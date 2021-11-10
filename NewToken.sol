pragma solidity ^0.8.4;

import "./ERC20Standard.sol";

contract NewToken is ERC20Standard {
	constructor() {
	    decimals = 12;
		totalSupply = 10000 * 10 ** decimals;
		name = "Retivov Aleksandr Dmitrievich";
		symbol = "RAD";
		version = "1.0";
		balances[msg.sender] = totalSupply;
	}
}
