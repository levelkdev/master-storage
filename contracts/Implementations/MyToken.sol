pragma solidity ^0.4.18;

import "../Libraries/BasicTokenLib.sol";
import "../Delegates/BasicTokenDelegate.sol";
import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";
import "../Core/Storage/StorageLib.sol";

contract MyToken is StorageConsumer, OwnableProxy {

  function MyToken(BasicTokenDelegate basicTokenDelegate, MasterStorage store, uint256 initialSupply)
    StorageConsumer(store)
    public
  {
    upgradeTo(basicTokenDelegate);
    BasicTokenLib.addSupply(_storage, initialSupply);
  }

}
