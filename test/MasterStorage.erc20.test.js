/* global describe it artifacts beforeEach */

import _ from 'lodash'
import { expect } from 'chai'
import { web3 } from './helpers/w3'

const accounts = web3.eth.accounts

const MasterStorage = artifacts.require('MasterStorage')
const BasicTokenDelegate = artifacts.require('BasicTokenDelegate')
const BasicTokenLib = artifacts.require('BasicTokenLib')
const StandardTokenDelegate = artifacts.require('StandardTokenDelegate')
const StandardTokenLib = artifacts.require('StandardTokenLib')
const MyToken = artifacts.require('MyToken')

describe('MasterStorage Patterns', () => {
  describe('creating two tokens that use MasterStorage and ERC20Controller', async () => {
    it('should keep separate state for each token', async () => {
      const basicTokenLib = await BasicTokenLib.new()
      MyToken.link('BasicTokenLib', basicTokenLib.address)
      BasicTokenDelegate.link('BasicTokenLib', basicTokenLib.address)

      const masterStorage = await MasterStorage.new()
      const basicToken = await BasicTokenDelegate.new()

      const myToken1Address = (await MyToken.new(basicToken.address, masterStorage.address, 10 * 10 ** 18)).address
      const myToken2Address = (await MyToken.new(basicToken.address, masterStorage.address, 45 * 10 ** 18)).address

      const myToken1 = BasicTokenDelegate.at(myToken1Address)
      const myToken2 = BasicTokenDelegate.at(myToken2Address)

      const token1TotalSupply = (await myToken1.totalSupply()).toNumber()
      const token2TotalSupply = (await myToken2.totalSupply()).toNumber()
      expect(token1TotalSupply).to.equal(10 * 10 ** 18)
      expect(token2TotalSupply).to.equal(45 * 10 ** 18)
    })
  })

  describe('upgrading a token from basic to standard', async () => {
    it('should allow the `approve` transaction and `allowance` call', async () => {
      const basicTokenLib = await BasicTokenLib.new()
      const standardTokenLib = await StandardTokenLib.new()

      MyToken.link('BasicTokenLib', basicTokenLib.address)
      BasicTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      StandardTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      StandardTokenDelegate.link('StandardTokenLib', standardTokenLib.address)

      const masterStorage = await MasterStorage.new()
      const basicTokenDelegate = await BasicTokenDelegate.new()
      const standardTokenDelegate = await StandardTokenDelegate.new()

      const myToken = await MyToken.new(basicTokenDelegate.address, masterStorage.address, 10 * 10 ** 18)
      const myTokenBasic = _.extend(myToken, BasicTokenDelegate.at(myToken.address))

      expect((await myTokenBasic.totalSupply()).toNumber()).to.equal(10 * 10 ** 18)

      await myTokenBasic.upgradeTo(standardTokenDelegate.address)
      const myTokenStandard = _.extend(myToken, StandardTokenDelegate.at(myToken.address))
      await myTokenStandard.approve(accounts[2], 0.08 * 10 ** 18, { from: accounts[1] })

      expect((await myTokenStandard.allowance(accounts[1], accounts[2])).toNumber()).to.equal(0.08 * 10 ** 18)
    })
  })
})
