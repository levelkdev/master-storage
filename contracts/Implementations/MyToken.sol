pragma solidity ^0.4.18;

import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";
import "./DetailedToken.sol";

contract MyToken is StorageConsumer, OwnableProxy, DetailedToken {

  function MyToken(MasterStorage store, string _name, string _symbol, uint8 _decimals)
    public
    StorageConsumer(store)
    DetailedToken(_name, _symbol, _decimals)
  { }

}
