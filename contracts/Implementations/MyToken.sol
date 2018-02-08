pragma solidity ^0.4.18;

import "../Libraries/ERC20Lib.sol";
import "../Core/MasterStorage.sol";

contract MyToken {
  using ERC20Lib for ERC20Lib.StoreContainer;
  ERC20Lib.StoreContainer erc20;

  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);

  function MyToken(MasterStorage store, uint256 initialSupply) public {
    erc20.store = store;
    erc20.addSupply(initialSupply);
  }

  function totalSupply() public view returns (uint256) {
    return erc20.totalSupply();
  }

}