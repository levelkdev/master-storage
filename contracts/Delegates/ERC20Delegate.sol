pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Libraries/ERC20Lib.sol";
import "../Core/Storage/MasterStorage.sol";

contract ERC20Delegate {
  address public _;
  address public __;

  using ERC20Lib for ERC20Lib.StoreContainer;
  ERC20Lib.StoreContainer _erc20;

  function addSupply(uint256 amount) public {
    _erc20.addSupply(amount);
  }

  function totalSupply() public view returns (uint256) {
    return _erc20.totalSupply();
  }

  function getMS() public view returns (address) {
    return _erc20.getMS();
  }
}
