pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";

library StorageLib {
  struct Storage {
    KeyValueStorage store;
  }
}
