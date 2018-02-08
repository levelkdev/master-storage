pragma solidity ^0.4.18;

import "./BaseProxy.sol";

contract UpgradableProxy is BaseProxy {

  event Upgraded(address indexed implementation);

  address internal _implementation;

  function implementation() public view returns (address) {
    return _implementation;
  }

  function upgradeTo(address impl) public {
    require(_implementation != impl);
    _implementation = impl;
    Upgraded(impl);
  }
}
