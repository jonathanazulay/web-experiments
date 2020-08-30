const { WebExperimentsPlugin } = require("./plugin.js")

module.exports = {
  devServer: {
    contentBase: './dist'
  },
  plugins: [
    new WebExperimentsPlugin()
  ]
}
