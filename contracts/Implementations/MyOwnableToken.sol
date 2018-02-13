pragma solidity ^0.4.18;

import "../Libraries/OwnableLib.sol";
import "../Core/Storage/KeyValueStorage.sol";
import "./MyToken.sol";

contract MyOwnableToken is MyToken {

  function MyOwnableToken(KeyValueStorage store, string _name, string _symbol, uint8 _decimals)
    public
    MyToken(store, _name, _symbol, _decimals)
  {
    OwnableLib.setOwner(_storage, msg.sender);
  }

}
