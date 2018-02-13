pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";

contract PublicStorage is KeyValueStorage {

  function senderIsValid() private view returns (bool) {
    return msg.sender != 0x0;
  }

  function keyAddress() private view returns (address) {
    return msg.sender;
  }

}
