/* global describe it artifacts beforeEach */

import _ from 'lodash'
import { expect } from 'chai'
import { web3 } from './helpers/w3'
import expectRevert from './helpers/expectRevert'

const accounts = web3.eth.accounts

const WhitelistedStorage = artifacts.require('WhitelistedStorage')
const BasicTokenLib = artifacts.require('BasicTokenLib')
const StandardTokenLib = artifacts.require('StandardTokenLib')
const MintableTokenLib = artifacts.require('MintableTokenLib')
const OwnableLib = artifacts.require('OwnableLib')
const BasicTokenDelegate = artifacts.require('BasicTokenDelegate')
const StandardTokenDelegate = artifacts.require('StandardTokenDelegate')
const MintableTokenDelegate = artifacts.require('MintableTokenDelegate')
const MyToken = artifacts.require('MyToken')
const MyOwnableToken = artifacts.require('MyOwnableToken')

describe('Whitelisted storage contract', () => {
  describe('when contracts attempt to set storage', async () => {
    it('should only allow whitelisted contracts to set storage', async () => {
      const basicTokenLib = await BasicTokenLib.new()
      const standardTokenLib = await StandardTokenLib.new()
      const mintableTokenLib = await MintableTokenLib.new()
      const ownableLib = await OwnableLib.new()
      MyOwnableToken.link('OwnableLib', ownableLib.address)
      MintableTokenDelegate.link('BasicTokenLib', basicTokenLib.address)
      MintableTokenDelegate.link('StandardTokenLib', standardTokenLib.address)
      MintableTokenDelegate.link('MintableTokenLib', mintableTokenLib.address)
      MintableTokenDelegate.link('OwnableLib', ownableLib.address)

      const whitelistedStorage = await WhitelistedStorage.new()
      const mintableTokenDelegate = await MintableTokenDelegate.new()

      let myToken1 = await MyOwnableToken.new(
        whitelistedStorage.address, mintableTokenDelegate.address, 'MyToken1', 'MTKONE', 18
      )
      let myToken2 = await MyOwnableToken.new(
        whitelistedStorage.address, mintableTokenDelegate.address, 'MyToken2', 'MTKTWO', 18
      )

      myToken1 = tokenObject(myToken1)
      myToken2 = tokenObject(myToken2)

      await whitelistedStorage.addSender(myToken1.address)

      await myToken1.setOwner()

      expectRevert(myToken2.setOwner())
    })
  })
})

function tokenObject (token) {
  return _.extend(
    token,
    MintableTokenDelegate.at(token.address)
  )
}
