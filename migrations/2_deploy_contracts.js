/* global artifacts */

const KeyValueStorage = artifacts.require('KeyValueStorage')

module.exports = function (deployer) {
  deployer.deploy(
    KeyValueStorage
  )
}
