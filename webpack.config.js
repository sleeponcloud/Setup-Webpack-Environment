const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'development',
    entry: {
        bundleIndex: './src/index.js',
        bundleNext: './src/next.js'
    },
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: '[name].js',
        clean: true,
        assetModuleFilename: 'images/[name][ext]',
    },

    module: {
        rules: [
            {
                test: /\.scss$/,
                use:[
                    'style-loader',
                    'css-loader',
                    'sass-loader'
                ]
            },
            {
                test: /\.(png|svg|jpg|jpeg|gif)$/i,
                type: 'asset/resource',
            },
        ]
    },
    plugins: [
        new HtmlWebpackPlugin({
            title: 'Webpack Demo',
            filename: 'template.html',
            template: '../src/template.html',
            chunks: ['bundleIndex'],
        }),
        new HtmlWebpackPlugin({
            title: 'Webpack Demo',
            filename: 'next.html',
            template: '../src/next.html',
            chunks: ['bundleNext'],
        })
    ],
    devServer: {
        // static: {
        //     directory: path.resolve(__dirname, 'dist'),
        // },
        compress: true,
        port: 3000,
        hot: true,
        historyApiFallback: true,
    },
    // devtool: 'source-map',
 };
 