pragma solidity ^0.4.18;

import "../Core/Storage/StorageLib.sol";

library OwnableLib {

  function getOwner(StorageLib.Storage storage self) public view returns (address) {
    return self.store.getAddress("owner");
  }

  function setOwner(StorageLib.Storage storage self, address owner) public {
    self.store.setAddress("owner", owner);
  }

}