pragma solidity ^0.4.18;

contract KeyValueStorage {

  /**** Ownership Mappings ***********/

  mapping(address => address) _ownerToKeyAddress;

  /**** Storage Mappings ***********/

  mapping(address => mapping(bytes32 => uint256)) _uintStorage;
  mapping(address => mapping(bytes32 => string)) _stringStorage;
  mapping(address => mapping(bytes32 => address)) _addressStorage;
  mapping(address => mapping(bytes32 => bytes)) _bytesStorage;
  mapping(address => mapping(bytes32 => bytes32)) _bytes32Storage;
  mapping(address => mapping(bytes32 => bool)) _boolStorage;
  mapping(address => mapping(bytes32 => int256)) _intStorage;

  modifier keyAddressIsLive {
    require(_ownerToKeyAddress[msg.sender] != 0x000000000000000000000000000000000000dEaD);
    _;
  }

  /**** Ownership Methods ***********/

  function transferOwnership(address newOwner) public {
    if (_ownerToKeyAddress[msg.sender] == 0x0) {
      _ownerToKeyAddress[newOwner] = msg.sender;
    } else {
      _ownerToKeyAddress[newOwner] = _ownerToKeyAddress[msg.sender];
    }
    _ownerToKeyAddress[msg.sender] = 0x000000000000000000000000000000000000dEaD;
  }

  /**** Get Methods ***********/

  function getAddress(bytes32 key) public view keyAddressIsLive returns (address) {
      return _addressStorage[keyAddress()][key];
  }

  function getUint(bytes32 key) public view keyAddressIsLive returns (uint) {
      return _uintStorage[keyAddress()][key];
  }

  function getString(bytes32 key) public view keyAddressIsLive returns (string) {
      return _stringStorage[keyAddress()][key];
  }

  function getBytes(bytes32 key) public view keyAddressIsLive returns (bytes) {
      return _bytesStorage[keyAddress()][key];
  }

  function getBytes32(bytes32 key) public view keyAddressIsLive returns (bytes32) {
      return _bytes32Storage[keyAddress()][key];
  }

  function getBool(bytes32 key) public view keyAddressIsLive returns (bool) {
      return _boolStorage[keyAddress()][key];
  }

  function getInt(bytes32 key) public view keyAddressIsLive returns (int) {
      return _intStorage[keyAddress()][key];
  }

  /**** Set Methods ***********/

  function setAddress(bytes32 key, address value) public keyAddressIsLive {
    _addressStorage[keyAddress()][key] = value;
  }

  function setUint(bytes32 key, uint value) public keyAddressIsLive {
      _uintStorage[keyAddress()][key] = value;
  }

  function setString(bytes32 key, string value) public keyAddressIsLive {
      _stringStorage[keyAddress()][key] = value;
  }

  function setBytes(bytes32 key, bytes value) public keyAddressIsLive {
      _bytesStorage[keyAddress()][key] = value;
  }

  function setBytes32(bytes32 key, bytes32 value) public keyAddressIsLive {
      _bytes32Storage[keyAddress()][key] = value;
  }

  function setBool(bytes32 key, bool value) public keyAddressIsLive {
      _boolStorage[keyAddress()][key] = value;
  }

  function setInt(bytes32 key, int value) public keyAddressIsLive {
      _intStorage[keyAddress()][key] = value;
  }

  /**** Delete Methods ***********/

  function deleteAddress(bytes32 key) public keyAddressIsLive {
      delete _addressStorage[keyAddress()][key];
  }

  function deleteUint(bytes32 key) public keyAddressIsLive {
      delete _uintStorage[keyAddress()][key];
  }

  function deleteString(bytes32 key) public keyAddressIsLive {
      delete _stringStorage[keyAddress()][key];
  }

  function deleteBytes(bytes32 key) public keyAddressIsLive {
      delete _bytesStorage[keyAddress()][key];
  }

  function deleteBytes32(bytes32 key) public keyAddressIsLive {
      delete _bytes32Storage[keyAddress()][key];
  }

  function deleteBool(bytes32 key) public keyAddressIsLive {
      delete _boolStorage[keyAddress()][key];
  }

  function deleteInt(bytes32 key) public keyAddressIsLive {
      delete _intStorage[keyAddress()][key];
  }

  /**** Private Methods ***********/

  function keyAddress() private view returns (address) {
    if (_ownerToKeyAddress[msg.sender] == 0x0) {
      return msg.sender;
    } else {
      return _ownerToKeyAddress[msg.sender];
    }
  }
}
