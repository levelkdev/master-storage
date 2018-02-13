/* global describe it artifacts beforeEach */

import _ from 'lodash'
import abi from 'ethereumjs-abi'
import { expect } from 'chai'
import { web3 } from './helpers/w3'

const accounts = web3.eth.accounts

const KeyValueStorage = artifacts.require('KeyValueStorage')
const BasicTokenLib = artifacts.require('BasicTokenLib')
const StandardTokenLib = artifacts.require('StandardTokenLib')
const MintableTokenLib = artifacts.require('MintableTokenLib')
const OwnableLib = artifacts.require('OwnableLib')
const BasicTokenDelegate = artifacts.require('BasicTokenDelegate')
const StandardTokenDelegate = artifacts.require('StandardTokenDelegate')
const MintableTokenDelegate = artifacts.require('MintableTokenDelegate')
const MyToken = artifacts.require('MyToken')
const MyOwnableToken = artifacts.require('MyOwnableToken')

describe('KeyValueStorage Patterns', () => {
  describe('creating three tokens that use KeyValueStorage and MintableTokenDelegate', async () => {
    it('should keep separate state for each token', async () => {
      const basicTokenLib = await BasicTokenLib.new()
      const standardTokenLib = await StandardTokenLib.new()
      const mintableTokenLib = await MintableTokenLib.new()
      const ownableLib = await OwnableLib.new()
      MyOwnableToken.link('OwnableLib', ownableLib.address)
      MintableTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      MintableTokenDelegate.link('StandardTokenLib', standardTokenLib.address)
      MintableTokenDelegate.link('MintableTokenLib', mintableTokenLib.address)
      MintableTokenDelegate.link('OwnableLib', ownableLib.address)

      const keyValueStorage = await KeyValueStorage.new()
      const mintableTokenDelegate = await MintableTokenDelegate.new()

      let myToken1 = await MyOwnableToken.new(keyValueStorage.address, 'MyToken1', 'MTKONE', 18)
      let myToken2 = await MyOwnableToken.new(keyValueStorage.address, 'MyToken2', 'MTKTWO', 18)
      let myToken3 = await MyOwnableToken.new(keyValueStorage.address, 'MyToken3', 'MTKTHREE', 18)

      await myToken1.upgradeTo(mintableTokenDelegate.address)
      await myToken2.upgradeTo(mintableTokenDelegate.address)
      await myToken3.upgradeTo(mintableTokenDelegate.address)

      myToken1 = tokenObject(myToken1)
      myToken2 = tokenObject(myToken2)
      myToken3 = tokenObject(myToken3)

      await myToken1.mint(accounts[1], 0.01 * 10 ** 18)
      await myToken2.mint(accounts[1], 0.02 * 10 ** 18)
      await myToken3.mint(accounts[1], 0.03 * 10 ** 18)

      expect((await myToken1.balanceOf(accounts[1])).toNumber()).to.equal(0.01 * 10 ** 18)
      expect((await myToken2.balanceOf(accounts[1])).toNumber()).to.equal(0.02 * 10 ** 18)
      expect((await myToken3.balanceOf(accounts[1])).toNumber()).to.equal(0.03 * 10 ** 18)
    })
  })

  describe('upgrading a token from basic to standard', async () => {
    it('should allow the `approve` transaction and `allowance` call', async () => {
      const basicTokenLib = await BasicTokenLib.new()
      const standardTokenLib = await StandardTokenLib.new()

      BasicTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      StandardTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      StandardTokenDelegate.link('StandardTokenLib', standardTokenLib.address)

      const keyValueStorage = await KeyValueStorage.new()
      const basicTokenDelegate = await BasicTokenDelegate.new()
      const standardTokenDelegate = await StandardTokenDelegate.new()

      const myToken = await MyToken.new(keyValueStorage.address, 'MyToken', 'MTK', 18)
      await myToken.upgradeTo(basicTokenDelegate.address)
      const myTokenBasic = _.extend(myToken, BasicTokenDelegate.at(myToken.address))

      expect(await myTokenBasic.name()).to.equal('MyToken')
      expect(await myTokenBasic.symbol()).to.equal('MTK')
      expect((await myTokenBasic.decimals()).toNumber()).to.equal(18)

      await myToken.upgradeTo(standardTokenDelegate.address)
      const myTokenStandard = _.extend(myToken, StandardTokenDelegate.at(myToken.address))
      await myTokenStandard.approve(accounts[2], 0.08 * 10 ** 18, { from: accounts[1] })

      expect((await myTokenStandard.allowance(accounts[1], accounts[2])).toNumber()).to.equal(0.08 * 10 ** 18)
    })
  })
})

function tokenObject (token) {
  return _.extend(
    token,
    BasicTokenDelegate.at(token.address),
    StandardTokenDelegate.at(token.address),
    MintableTokenDelegate.at(token.address)
  )
}