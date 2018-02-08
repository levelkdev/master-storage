pragma solidity ^0.4.18;

import "../Libraries/ERC20Lib.sol";
import "../Delegates/ERC20Delegate.sol";
import "../Core/Proxy/OwnableProxy.sol";
import "../Core/Storage/MasterStorage.sol";

contract MyToken is OwnableProxy {
  using ERC20Lib for ERC20Lib.StoreContainer;
  ERC20Lib.StoreContainer _erc20;

  function MyToken(ERC20Delegate erc20Delegate, MasterStorage store, uint256 initialSupply) public {
    upgradeTo(erc20Delegate);
    _erc20.store = store;
    _erc20.addSupply(initialSupply);
  }

}
