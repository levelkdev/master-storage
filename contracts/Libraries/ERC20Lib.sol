pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/Storage/MasterStorage.sol";

library ERC20Lib {
  using SafeMath for uint256;

  struct StoreContainer { address store; }

  function addSupply(MasterStorage store, uint256 amount) public {
    uint256 totalSupply = store.getUint("totalSupply");
    store.setUint("totalSupply", totalSupply.add(amount));
  }

  function totalSupply(MasterStorage store) public view returns (uint256) {
    return store.getUint("totalSupply");
  }

}
