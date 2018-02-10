pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Libraries/ERC20Lib.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";

contract ERC20Delegate is StorageConsumer {

  function totalSupply() public view returns (uint256) {
    return ERC20Lib.totalSupply(_store);
  }

}
