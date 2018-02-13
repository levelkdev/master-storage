pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";
import "./StorageState.sol";

contract StorageConsumer is StorageState {
  function StorageConsumer(KeyValueStorage store) public {
    _storage.store = store;
  }
}
