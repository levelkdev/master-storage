pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Libraries/ERC20Lib.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";
import "../Core/Storage/StorageLib.sol";

contract ERC20Delegate is StorageConsumer {

  using ERC20Lib for StorageLib.Data;

  function ERC20Delegate(MasterStorage store) public StorageConsumer(store) { }

  function totalSupply() public view returns (uint256) {
    return _data.totalSupply();
  }

}
