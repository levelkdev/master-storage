pragma solidity ^0.4.18;

import "../Core/Storage/StorageLib.sol";

library MintableTokenLib {

  function getMintingFinished(StorageLib.Storage storage self) public view returns (bool) {
    return self.store.getBool("mintingFinished");
  }

  function setMintingFinished(StorageLib.Storage storage self, bool mintingFinished) public {
    return self.store.setBool("mintingFinished", mintingFinished);
  }

}