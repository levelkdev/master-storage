pragma solidity ^0.4.18;

contract PublicProxy {

  mapping(address => address) _senderToProxyMap;

  function setProxy(address proxy) public {
    _senderToProxyMap[msg.sender] = proxy;
  }
 
  function () payable public {
    address _impl = _senderToProxyMap[msg.sender];
    require(_impl != address(0));
    bytes memory data = msg.data;

    assembly {
      let result := delegatecall(gas, _impl, add(data, 0x20), mload(data), 0, 0)
      let size := returndatasize
      let ptr := mload(0x40)
      returndatacopy(ptr, 0, size)
      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }
}