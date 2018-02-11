pragma solidity ^0.4.18;

import "../Libraries/ERC20Lib.sol";
import "../Delegates/ERC20Delegate.sol";
import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";
import "../Core/Storage/StorageLib.sol";

contract MyToken is StorageConsumer, OwnableProxy {

  using ERC20Lib for StorageLib.Storage;

  function MyToken(ERC20Delegate erc20Delegate, MasterStorage store, uint256 initialSupply)
    StorageConsumer(store)
    public
  {
    upgradeTo(erc20Delegate);
    _storage.addSupply(initialSupply);
  }

}
