//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// imports functionalities from other contracts

/// @dev Provide basic access control mechanisms like ownership 
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @dev Offers string manipulation utilities used for generating token URIs
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

/// @dev imports core ERC-404 contract from same directory
import {ERC404} from "../ERC404.sol";


// Contract Declaration and Inheritance 
// 'Ownable' contract by OpenZeppelin implements basic access control using inheritance


// Declares a new contract called ERC404Example and it inherits from `Ownable` and `ERC404`
contract ERC404Example is Ownable, ERC404 {

  // The constructor calls two parent constructors
  constructor(
    string memory name_, // Name of token 
    string memory symbol_, // Token symbol
    uint8 decimals_, // Decimal places for the ERC-20 token
    uint256 maxTotalSupplyERC721_, // Max total supply of ERC-721 tokens
    address initialOwner_, // Initial owner address 
    address initialMintRecipient_ // The address will receive the minted ERC-20 tokens
  ) ERC404(name_, symbol_, decimals_) Ownable(initialOwner_) {
    // ERC404(name_, symbol_, decimals_) calls the constructor of the ERC404 constructor
    // Ownable(initialOwner_) calls the constructor of the Ownable parent contract
    // The purpose of this code initialize token details 

    // Do not mint the ERC721s to the initial owner, as it's a waste of gas.
    // minting erc721 to contract owner is skipped 
    // Might exempt the recipient from transfer fees for ERC-721 tokens 
    _setERC721TransferExempt(initialMintRecipient_, true);
    
    // mints ERC-20 tokens and assigns them to a specific address 
    // initialMintRecipient_ will receive the minted ERC-20 tokens
    // mints total # of tokens and send them to specified wallet address
    _mintERC20(initialMintRecipient_, maxTotalSupplyERC721_ * units);
  }

  // URI points to metadata associated with the token
  // TokenURI defines how the contract retrieves URI for a specific token identified by its ID
  // pure keyword indicates the function can be called from inside and outside of the contract
  // override keyword indicates the `tokenURI function` overrides a similar function from parent contract
  function tokenURI(uint256 id_) public pure override returns (string memory) {
    
    // multiple strings are concatenated to generate URI
    // "https://example.com/token/": base URL pointing to the location the token metadata stored
    //  Strings.toString(id_): converts the token ID from a number to a string using the `toString` function from `Strings.sol`
    return string.concat("https://copper-important-coyote-286.mypinata.cloud/ipfs/QmQ7jWzYbqVDf8eHHZuEddsFQtMs4bV4PD5YeWWZX8mg2r/", Strings.toString(id_));
  }

  // `setERC721TransferExempt` sets an exemption on transfer fees for ERC-721 tokens for a specific account
  // External keyword: function can only be called outside of the contract
  function setERC721TransferExempt(
    // address for which transfer exemption is being set
    address account_,
    // bool value (true or false) indicating whether to exempt the account from transfer fees or not
    bool value_
  ) external onlyOwner {
    // _setERC721TransferExempt is `private` and not callable from outside the contract
    // Passes the values `account_`  & `value_` to this internal function
    _setERC721TransferExempt(account_, value_);
  }
}

