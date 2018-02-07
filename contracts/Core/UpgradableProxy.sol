pragma solidity ^0.4.18;

import "./BaseProxy.sol";

contract UpgradableProxy is BaseProxy {

  event Upgraded(address indexed implementation);

  address internal _implementation;

  function implementation() public view returns (address) {
    return _implementation;
  }

  function upgradeTo(address implementation) public {
    require(_implementation != implementation);
    _implementation = implementation;
    Upgraded(implementation);
  }
}
