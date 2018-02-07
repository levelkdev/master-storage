/* global describe it artifacts beforeEach */

import { expect } from 'chai'
// import { web3 } from './helpers/w3'

// const accounts = web3.eth.accounts

const MasterStorage = artifacts.require('MasterStorage')
const ERC20Controller = artifacts.require('ERC20Controller')
const MyToken = artifacts.require('MyToken')

describe('MasterStorage Patterns', () => {
  describe('creating two tokens that use MasterStorage and ERC20Controller', async () => {
    let myToken1, myToken2

    beforeEach(async () => {
      const masterStorage = await MasterStorage.new()
      const erc20Controller = await ERC20Controller.new()
      myToken1 = await MyToken.new(erc20Controller.address, masterStorage.address, 10 * 10 ** 18)
      myToken2 = await MyToken.new(erc20Controller.address, masterStorage.address, 45 * 10 ** 18)
    })

    it('should keep separate state for each token', async () => {
      const token1TotalSupply = (await myToken1.totalSupply()).toNumber()
      const token2TotalSupply = (await myToken2.totalSupply()).toNumber()
      expect(token1TotalSupply).to.equal(10 * 10 ** 18)
      expect(token2TotalSupply).to.equal(45 * 10 ** 18)
    })
  })
})
