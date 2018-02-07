pragma solidity ^0.4.18;

import "./BaseProxy.sol";

contract PublicProxy is BaseProxy {

  mapping(address => address) _senderToProxyMap;

  function setProxy(address proxy) public {
    _senderToProxyMap[msg.sender] = proxy;
  }

  function implementation() public view returns (address) {
    return _senderToProxyMap[msg.sender];
  }

}