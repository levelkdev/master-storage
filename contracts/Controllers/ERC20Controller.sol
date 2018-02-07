pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../Core/MasterStorage.sol";

contract ERC20Controller is MasterStorage {
  using SafeMath for uint256;

  function addSupply(uint256 amount) public {
    uint256 totalSupply = getUint("totalSupply");
    setUint("totalSupply", totalSupply.add(amount));
  }

  function totalSupply() public view returns (uint256) {
    return getUint("totalSupply");
  }

}
