//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the Ownable contract from the OpenZeppelin library, which provides basic access control mechanisms 
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// Imports the Strings library from the OpenZeppelin library, which provides string operations
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// Imports the custom ERC404U16 that inherits from Ownable and ERC404U16
import {ERC404U16} from "../ERC404U16.sol";

// Define a contract named ERC404ExampleU16 that inherits from Ownable and ERC404U16 
contract ERC404ExampleU16 is Ownable, ERC404U16 {

  // Constructor to initalize the contract
  constructor(
    string memory name_, // Name of the token
    string memory symbol_, // Symbol of the token
    uint8 decimals_,  // Decimal places for the token
    uint256 maxTotalSupplyERC721_, // Maximum total supply for the ERC721 tokens
    address initialOwner_, // Address of the initial owner
    address initialMintRecipient_ // Address that will receive the initial minting of the tokens 
  ) ERC404U16(name_, symbol_, decimals_) Ownable(initialOwner_) {
    // Initialize the Ownable contract with the initial owner address
    // Do not mint the ERC721s to the initial owner, as it's a waste of gas.
    _setERC721TransferExempt(initialMintRecipient_, true);
    // Mint ERC20 equivalent tokens to the initial mint recipient, scaled by the units 
    _mintERC20(initialMintRecipient_, maxTotalSupplyERC721_ * units);
  }

  // Function to get the URI for a given token ID
  function tokenURI(uint256 id_) public pure override returns (string memory) {
  // Concatenate a base URI with the token ID to form the full token URI 
    return string.concat("ipfs://QmNNWwv7pcmsVuDUYRPJ7T9zLABM46KM9VR1rNNAqFKSQx/", Strings.toString(id_));
  }

  // Function to set whether an account is exempt from ERC721 transfer restrictions
  function setERC721TransferExempt(
    // Address to set the exemption fot 
    address account_,
    // Boolean value to set the exemption (true or false)
    bool value_
  ) external onlyOwner { // Only the contract owner can call this function 
    // Call the internal function to set the transfer exemptopn status for the given account
    _setERC721TransferExempt(account_, value_);
  }
}
