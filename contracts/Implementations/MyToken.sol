pragma solidity ^0.4.18;

import "../Libraries/ERC20Lib.sol";
import "../Delegates/ERC20Delegate.sol";
import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageConsumer.sol";

contract MyToken is StorageConsumer, OwnableProxy {

  function MyToken(ERC20Delegate erc20Delegate, MasterStorage store, uint256 initialSupply) public {
    _store = store;
    upgradeTo(erc20Delegate);
    ERC20Lib.addSupply(store, initialSupply);
  }

}
