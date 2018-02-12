pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/Storage/StorageLib.sol";

library StandardTokenLib {
  using SafeMath for uint256;

  function getAllowed(
    StorageLib.Storage storage self,
    address owner,
    address spender
  )
    public view returns (uint256)
  {
    return self.store.getUint(keccak256("allowed", owner, spender));
  }

  function addAllowed(
    StorageLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).add(amount));
  }

  function subAllowed(
    StorageLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).sub(amount));
  }

  function setAllowed(
    StorageLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public 
  {
    self.store.setUint(keccak256("allowed", owner, spender), amount);
  }

}
