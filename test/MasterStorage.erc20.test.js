/* global describe it artifacts beforeEach */

import { expect } from 'chai'
// import { web3 } from './helpers/w3'

// const accounts = web3.eth.accounts

const MasterStorage = artifacts.require('MasterStorage')
const ERC20Delegate = artifacts.require('ERC20Delegate')
const ERC20Lib = artifacts.require('ERC20Lib')
const MyToken = artifacts.require('MyToken')

describe('MasterStorage Patterns', () => {
  describe('creating two tokens that use MasterStorage and ERC20Controller', async () => {
    let myToken1, myToken2, masterStorage, erc20Lib, erc20, erc20Token1, erc20Token2

    beforeEach(async () => {
      erc20Lib = await ERC20Lib.new()
      console.log('erc20Lib address: ', erc20Lib.address)
      MyToken.link('ERC20Lib', erc20Lib.address)
      ERC20Delegate.link('ERC20Lib', erc20Lib.address)

      masterStorage = await MasterStorage.new()
      console.log('masterStorage address: ', masterStorage.address)
      erc20 = await ERC20Delegate.new()
      console.log('erc20Del address: ', erc20.address)

      myToken1 = await MyToken.new(erc20.address, masterStorage.address, 10 * 10 ** 18)
      console.log('myToken1 address: ', myToken1.address)
      myToken2 = await MyToken.new(erc20.address, masterStorage.address, 45 * 10 ** 18)
      console.log('myToken2 address: ', myToken2.address)

      erc20Token1 = ERC20Delegate.at(myToken1.address)
      erc20Token2 = ERC20Delegate.at(myToken2.address)
    })

    it.only('should keep separate state for each token', async () => {
      const token1TotalSupply = (await erc20Token1.totalSupply()).toNumber()
      const token2TotalSupply = (await erc20Token2.totalSupply()).toNumber()
      expect(token1TotalSupply).to.equal(10 * 10 ** 18)
      expect(token2TotalSupply).to.equal(45 * 10 ** 18)
    })
  })
})
