const path = require('path');

module.exports = {
  entry: {
    index: './src/index.jsx',
    ReactDisplay: './web/themes/custom/custom_bootstrap_barrio/js/ReactDisplay.entry.jsx',
  },
  mode: 'production',
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        loader: 'babel-loader',
        exclude: /(node_modules|bower_components)/,
      },
    ],
  },
  resolve: { extensions: ['*', '.js', '.jsx'] },
  output: {
    path: path.resolve(__dirname, './web/themes/custom/custom_bootstrap_barrio/js/'),
    filename: '[name].entry.js',
    sourceMapFilename: '[name].js.map'
  },
};