pragma solidity ^0.4.18;

import "./MasterStorage.sol";
import "./StorageLib.sol";

contract StorageConsumer {

  StorageLib.Storage _storage;

  function StorageConsumer(MasterStorage store) public {
    _storage.store = store;
  }
}
