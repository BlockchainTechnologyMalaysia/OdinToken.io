pragma solidity ^0.4.18;


import './ERC20.sol';
import './SafeMath.sol';

contract StandardToken is ERC20 {
  using SafeMath for uint256; //invoking safemath library


//@dev Fix for the ERC20 short address attack.
  modifier onlyPayloadSize(uint size) {
     require(msg.data.length >= size + 4);
     _;
  }

  mapping(address => uint) balances;
  mapping (address => mapping (address => uint)) allowed;

  function transfer(address _to, uint _value) onlyPayloadSize(2 * 32) public returns (bool success){
    require(_to != address(0));
    require(_value <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender].safeSub(_value);
    balances[_to] = balances[_to].safeAdd(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint _value) onlyPayloadSize(3 * 32) public returns (bool success) {
    require(_from != address(0));
    require(_to != address(0));
    var _allowance = allowed[_from][msg.sender];

    // Check is not needed because safeSub(_allowance, _value) will already throw if this condition is not met
    // if (_value > _allowance) throw;

    balances[_to] = balances[_to].safeAdd(_value);
    balances[_from] = balances[_from].safeSub(_value);
    allowed[_from][msg.sender] = _allowance.safeSub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  function balanceOf(address _owner) public constant returns (uint balance) {
    return balances[_owner];
  }

  function approve(address _spender, uint _value) public returns (bool success) {
    require(_spender != address(0));
    require((_value == 0) || (allowed[msg.sender][_spender] == 0));
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) public constant returns (uint remaining) {
    require(_owner != address(0));
    require(_spender != address(0));
    return allowed[_owner][_spender];
  }
  
  //To increment allowed value is better to use this function to avoid 2 calls (and wait until the first transaction is mined)
  //_addedValue The amount of tokens to increase the allowance by.
  function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
    require(_spender != address(0));
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].safeAdd(_addedValue);
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }	
   
  //To decrement allowed value is better to use this function to avoid 2 calls (and wait until the first transaction is mined)
  //_subtractedValue The amount of tokens to decrease the allowance by
  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
    require(_spender != address(0));
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.safeSub(_subtractedValue);
    }
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }
}
