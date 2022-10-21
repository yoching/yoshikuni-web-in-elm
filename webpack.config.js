const path = require('path');

module.exports = {
    entry: {
        index: './src/index.ts'
    },
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    devtool: 'eval-source-map',
    resolve: {
        extensions: ['.ts', '.tsx', '...']
    },
    devServer: {
        historyApiFallback: true
    },
    module: {
        rules: [
            {
                test: /\.ts$/,
                exclude: /node_modules/,
                use: 'ts-loader',
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader',
                options: {
                    name: '[name].[ext]',
                }
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node-modules/],
                use: [
                    {
                        loader: 'elm-asset-webpack-loader'
                    },
                    {
                        loader: 'elm-webpack-loader'
                    }
                ]
            },
            {
                test: /\.css$/,
                exclude: /node_modules/,
                use: [
                    "style-loader",
                    {
                        loader: "css-loader",
                        options: {
                            importLoaders: 1,
                        },
                    },
                    "postcss-loader",
                ],
            },
            {
                test: /\.(png|svg|jpg|jpeg|gif)$/i,
                type: 'asset/resource',
            }
        ]
    }
};