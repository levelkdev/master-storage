pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageLib.sol";

library ERC20Lib {
  using SafeMath for uint256;

  function addSupply(StorageLib.Data storage data, uint256 amount) public {
    uint256 totalSupply = data.store.getUint("totalSupply");
    data.store.setUint("totalSupply", totalSupply.add(amount));
  }

  function totalSupply(StorageLib.Data storage data) public view returns (uint256) {
    return data.store.getUint("totalSupply");
  }

}
