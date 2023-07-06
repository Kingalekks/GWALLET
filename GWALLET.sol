// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract GWALLET {
    address public minter;
    mapping (address => uint) public balance;
    event send(address from, address to, uint amount);
    address private owner;
    address public payer;
    address public origin;
    uint256 public value;
    string public tokenName;
    string public tokenSymbol;
    int8 public tokenDecimal;
    int256 public totalSupply;
    
    constructor() {
        tokenName = "Grey Wallet";
        tokenSymbol = "GWALLET";
        tokenDecimal = 18;
        totalSupply = 100000000;
        minter == msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller must be owner");
        _;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balance[receiver] += amount;
    }

    function sent(address receiver, uint amount) public {
        require(amount <= balance[msg.sender], "Insufficient Balance");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit send(msg.sender, receiver, amount);
    }

    function balances(address _account) external view returns (uint) {
        return balance[_account];
    }

    function pay() public payable {
        payer = msg.sender;
        origin = tx.origin;
        value = msg.value;
    }

    function getBlockInfo() external view returns (uint, uint, uint) {
        return (
        block.number,
        block.timestamp,
        block.chainid
        );
        
    }
}