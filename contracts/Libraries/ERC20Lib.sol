pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/Storage/MasterStorage.sol";

library ERC20Lib {
  using SafeMath for uint256;

  struct StoreContainer { address store; }

  function addSupply(StoreContainer storage storeContainer, uint256 amount) public {
    MasterStorage ms = MasterStorage(storeContainer.store);
    uint256 totalSupply = ms.getUint("totalSupply");
    ms.setUint("totalSupply", totalSupply.add(amount));
  }

  function getMS(StoreContainer storage storeContainer) public view returns (address) {
    return storeContainer.store;
  }

  function totalSupply(StoreContainer storage storeContainer) public view returns (uint256) {
    MasterStorage ms = MasterStorage(storeContainer.store);
    return ms.getUint("totalSupply");
  }

}
