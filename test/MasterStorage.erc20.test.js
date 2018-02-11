/* global describe it artifacts beforeEach */

import { expect } from 'chai'
// import { web3 } from './helpers/w3'

// const accounts = web3.eth.accounts

const MasterStorage = artifacts.require('MasterStorage')
const BasicTokenDelegate = artifacts.require('BasicTokenDelegate')
const BasicTokenLib = artifacts.require('BasicTokenLib')
const MyToken = artifacts.require('MyToken')

describe('MasterStorage Patterns', () => {
  describe('creating two tokens that use MasterStorage and ERC20Controller', async () => {
    let myToken1, myToken2, masterStorage, basicTokenLib, basicToken

    beforeEach(async () => {
      basicTokenLib = await BasicTokenLib.new()
      // console.log('basicTokenLib address: ', basicTokenLib.address)
      MyToken.link('BasicTokenLib', basicTokenLib.address)
      BasicTokenDelegate.link('BasicTokenLib', basicTokenLib.address)

      masterStorage = await MasterStorage.new()
      // console.log('masterStorage address: ', masterStorage.address)
      basicToken = await BasicTokenDelegate.new()
      // console.log('basicTokenDel address: ', basicToken.address)

      const myToken1Address = (await MyToken.new(basicToken.address, masterStorage.address, 10 * 10 ** 18)).address
      // console.log('myToken1 address: ', myToken1Address)
      const myToken2Address = (await MyToken.new(basicToken.address, masterStorage.address, 45 * 10 ** 18)).address
      // console.log('myToken2 address: ', myToken2Address)

      myToken1 = BasicTokenDelegate.at(myToken1Address)
      myToken2 = BasicTokenDelegate.at(myToken2Address)
    })

    it('should keep separate state for each token', async () => {
      const token1TotalSupply = (await myToken1.totalSupply()).toNumber()
      const token2TotalSupply = (await myToken2.totalSupply()).toNumber()
      expect(token1TotalSupply).to.equal(10 * 10 ** 18)
      expect(token2TotalSupply).to.equal(45 * 10 ** 18)
    })
  })

})
