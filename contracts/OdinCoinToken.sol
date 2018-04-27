pragma solidity ^0.4.18;

import './browser/StandardToken.sol';

contract OdinCoin is StandardToken {

    string public constant name = "ODIN TOKEN";
    string public constant symbol = "ODIN";
    uint8 public constant decimals = 0;
    uint256 public constant totalSupply = 200000000;

    function OdinCoin(address reserve) public {
        balances[reserve] = totalSupply;
    }
}
