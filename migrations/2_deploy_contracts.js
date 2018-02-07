/* global artifacts */

const MasterStorage = artifacts.require('MasterStorage')

module.exports = function (deployer) {
  deployer.deploy(
    MasterStorage
  )
}
