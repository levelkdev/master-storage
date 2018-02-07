pragma solidity ^0.4.18;

import "../Controllers/ERC20Controller.sol";
import "../Storage/MasterStorage.sol";

contract MyToken {

  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);

  ERC20Controller _store;

  function MyToken(ERC20Controller erc20Controller, MasterStorage store, uint256 initialSupply) public {
    _store = ERC20Controller(store);
    _store.setProxy(erc20Controller);
    _store.addSupply(initialSupply);
  }

  function totalSupply() public view returns (uint256) {
    return _store.totalSupply();
  }

}