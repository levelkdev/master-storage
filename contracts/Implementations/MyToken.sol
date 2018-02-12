pragma solidity ^0.4.18;

import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";

contract MyToken is StorageConsumer, OwnableProxy {

  function MyToken(MasterStorage store)
    public
    StorageConsumer(store)
  { }

}
