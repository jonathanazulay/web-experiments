const { RawSource } = require('webpack-sources')
class WebExperimentsPlugin {
  apply(compiler) {
    compiler.hooks.emit.tap('Plugin', (c) => {
      console.log(c.modules)
      c.emitAsset('config.json', new RawSource(JSON.stringify(c.assets)), {})
    })
  }
}

module.exports.WebExperimentsPlugin = WebExperimentsPlugin
