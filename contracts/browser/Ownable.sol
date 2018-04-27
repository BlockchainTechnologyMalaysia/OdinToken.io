pragma solidity ^0.4.18;

contract Ownable {
  address public owner;

  event transferOwner(address indexed existingOwner, address indexed newOwner);

  function Ownable() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) onlyOwner public {
    if (newOwner != address(0)) {
      owner = newOwner;
      transferOwner(msg.sender, owner);
    }
  }
}
