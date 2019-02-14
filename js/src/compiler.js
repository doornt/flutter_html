var path = require('path');
var lex = require('pug-lexer');
var stripComments = require('pug-strip-comments');
var parse = require('pug-parser');
var load = require('pug-load');
var link = require('pug-linker');


function applyPlugins(value, options, plugins, name) {
    return plugins.reduce(function (value, plugin) {
        return (
            plugin[name] ?
            plugin[name](value, options) :
            value
        );
    }, value);
}

function findReplacementFunc(plugins, name) {
    var eligiblePlugins = plugins.filter(function (plugin) {
      return plugin[name];
    });
  
    if (eligiblePlugins.length > 1) {
      throw new Error('Two or more plugins all implement ' + name + ' method.');
    } else if (eligiblePlugins.length) {
      return eligiblePlugins[0][name].bind(eligiblePlugins[0]);
    }
    return null;
  }

exports.compile = function (str, options = {}) {
    var debug_sources = {};
    debug_sources[options.filename] = str;
    var dependencies = [];
    var plugins = options.plugins || [];
    var ast = load.string(str, {
        filename: options.filename,
        basedir: options.basedir,
        lex: function (str, options) {
            var lexOptions = {};
            Object.keys(options).forEach(function (key) {
                lexOptions[key] = options[key];
            });
            lexOptions.plugins = plugins.filter(function (plugin) {
                return !!plugin.lex;
            }).map(function (plugin) {
                return plugin.lex;
            });
            return applyPlugins(lex(str, lexOptions), options, plugins, 'postLex');
        },
        parse: function (tokens, options) {
            tokens = tokens.map(function (token) {
                if (token.type === 'path' && path.extname(token.val) === '') {
                    return {
                        type: 'path',
                        line: token.line,
                        col: token.col,
                        val: token.val + '.pug'
                    };
                }
                return token;
            });
            tokens = stripComments(tokens, options);
            tokens = applyPlugins(tokens, options, plugins, 'preParse');
            var parseOptions = {};
            Object.keys(options).forEach(function (key) {
                parseOptions[key] = options[key];
            });
            parseOptions.plugins = plugins.filter(function (plugin) {
                return !!plugin.parse;
            }).map(function (plugin) {
                return plugin.parse;
            });

            return applyPlugins(
                applyPlugins(parse(tokens, parseOptions), options, plugins, 'postParse'),
                options, plugins, 'preLoad'
            );
        },
        resolve: function (filename, source, loadOptions) {
            var replacementFunc = findReplacementFunc(plugins, 'resolve');
            if (replacementFunc) {
                return replacementFunc(filename, source, options);
            }

            return load.resolve(filename, source, loadOptions);
        },
        read: function (filename, loadOptions) {
            dependencies.push(filename);

            var contents;

            var replacementFunc = findReplacementFunc(plugins, 'read');
            if (replacementFunc) {
                contents = replacementFunc(filename, options);
            } else {
                contents = load.read(filename, loadOptions);
            }

            var str = applyPlugins(contents, {
                filename: filename
            }, plugins, 'preLex');
            debug_sources[filename] = str;
            return str;
        }
    });
    ast = applyPlugins(ast, options, plugins, 'postLoad');

    ast = applyPlugins(ast, options, plugins, 'preLink');
    ast = link(ast);
    ast = applyPlugins(ast, options, plugins, 'postLink');

    // return require('./dom-node.js').createNodes(ast)

    return ast

}