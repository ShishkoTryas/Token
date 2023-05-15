//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string private _name;
    string private _symbol;

    uint256 private _totalSupply;

    address public owner;

    mapping(address => uint256) balances;

    event Transfer(address indexed to, uint256 value);

    constructor(string memory name_, string memory symbol_, uint256 totalSupply_) {
        owner = msg.sender;
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        balances[owner] = _totalSupply;
    }

    function name() public view returns(string memory) {
        return _name;
    }

    function symbol() public view returns(string memory) {
        return _symbol;
    }

    function totalSupply() public view returns(uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns(uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 amount) external returns(bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(balances[msg.sender] >= amount, "Not enough tokens");

        console.log("Transferring from %s to %s %s tokens", msg.sender, to, amount);

        unchecked {
            balances[msg.sender] -= amount;
            balances[to] += amount;
        }

        emit Transfer(to, amount);

        return true;
    }

}