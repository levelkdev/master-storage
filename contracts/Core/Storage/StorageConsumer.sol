pragma solidity ^0.4.18;

import "./MasterStorage.sol";
import "./StorageLib.sol";

contract StorageConsumer {

  StorageLib.Data _data;

  function StorageConsumer(MasterStorage store) public {
    _data.store = store;
  }
}
