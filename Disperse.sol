pragma solidity ^0.8.0;

interface Token {
    function transfer(address _recipient, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract DisperseContract {
    address tokenAddr;
    
    constructor() {
    }
    
    function setToken(address token) external returns (bool success) {
        tokenAddr = token;
        return true;
    }
    
    function disperse(address[] calldata recipients, uint256[] calldata values) external returns (bool success) {
        Token token = Token(tokenAddr);
        for(uint256 i = 0; i < recipients.length; i++) {
            require(token.transferFrom(msg.sender, recipients[i], values[i]));
        }
        return true;
    }
    
    function disperseOpt(address[] calldata recipients, uint256[] calldata values) external returns (bool success) {
        Token token = Token(tokenAddr);
        uint256 total = 0;
        for(uint256 i = 0; i < recipients.length; i++) {
            total += values[i];
        }
        require(token.transferFrom(msg.sender, address(this), total));
        for(uint256 i = 0; i < recipients.length; i++) {
            require(token.transfer(recipients[i], values[i]));
        }
        return true;
    }
    
    function disperseEth(address payable[] calldata recipients, uint256[] calldata values) external payable returns (bool success) {
        for(uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i].send(values[i]));
        }
        return true;
    }
    
    function disperseEthSingle(address payable recipient) external payable returns (bool success) {
        require(recipient.send(msg.value));
        return true;
    }
}