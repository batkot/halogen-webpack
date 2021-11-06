const config = require('./build.config');
const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const Webpack = require('webpack');

module.exports = {
    mode: 'development',
    entry: config.entryPoint,
//    output: {
 //       path: path.join(__dirname, config.buildPath),
  //      filename: config.appName
   // },

    module: {
        rules: [
            //Sass
            {
                test: /\.s[ac]ss$/i,
                exclude: config.excludes,
                use: [
                    { loader: MiniCssExtractPlugin.loader },
                    'css-loader',
                    'sass-loader'
                ]
            },
            //PureScript
            {
                test: /\.purs$/,
                exclude: config.excludes,
                use: [
                    {
                        loader: 'purs-loader',
                        options: {
                            spago: true,
                            src: config.pursSources,
                            bundle: true
                        }
                    }
                ]
            }
        ]
    },

    resolve: {
        modules: [ 'node_modules', 'output' ],
        extensions: ['.purs', '.js' ]
    },

    plugins: [
        new MiniCssExtractPlugin({
            filename: '[name].css',
            chunkFilename: '[id].css'
        }),
        new HtmlWebpackPlugin({
            template: config.indexPath,
            inject: 'body',
            filename: 'index.html'
        }),
        new Webpack.DefinePlugin({
            __APP_CONTAINER_SELECTOR__: "'#app'"
        })
    ],

    devServer: {
        static: {
            directory: path.join(__dirname, "src/static")
        },
        compress: true,
        port: 3001
    }
}
