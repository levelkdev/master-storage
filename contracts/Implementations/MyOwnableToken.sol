pragma solidity ^0.4.18;

import "../Libraries/OwnableLib.sol";
import "../Core/Storage/MasterStorage.sol";
import "./MyToken.sol";

contract MyOwnableToken is MyToken {

  function MyOwnableToken(MasterStorage store)
    public
    MyToken(store)
  {
    OwnableLib.setOwner(_storage, msg.sender);
  }

}
