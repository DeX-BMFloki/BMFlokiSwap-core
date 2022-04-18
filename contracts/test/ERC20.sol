pragma solidity =0.5.16;

import '../BMFlokiERC20.sol';

contract ERC20 is BMFlokiERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
