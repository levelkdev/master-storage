pragma solidity ^0.4.18;

import "./MasterStorage.sol";
import "./StorageState.sol";

contract StorageConsumer is StorageState {
  function StorageConsumer(MasterStorage store) public {
    _storage.store = store;
  }
}
