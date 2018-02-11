pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/Storage/MasterStorage.sol";
import "../Core/Storage/StorageLib.sol";

library ERC20Lib {
  using SafeMath for uint256;

  function getBalance(StorageLib.Data storage data, address balanceHolder) public view returns (uint256) {
    return data.store.getUint(keccak256("balances", balanceHolder));
  }

  function totalSupply(StorageLib.Data storage data) public view returns (uint256) {
    return data.store.getUint("totalSupply");
  }

  function addSupply(StorageLib.Data storage data, uint256 amount) public {
    data.store.setUint("totalSupply", totalSupply(data).add(amount));
  }

  function addBalance(StorageLib.Data storage data, address balanceHolder, uint256 amount) public {
    setBalance(data, balanceHolder, getBalance(data, balanceHolder).add(amount));
  }

  function subBalance(StorageLib.Data storage data, address balanceHolder, uint256 amount) public {
    setBalance(data, balanceHolder, getBalance(data, balanceHolder).sub(amount));
  }

  function setBalance(StorageLib.Data storage data, address balanceHolder, uint256 amount) private {
    data.store.setUint(keccak256("balances", balanceHolder), amount);
  }

}
