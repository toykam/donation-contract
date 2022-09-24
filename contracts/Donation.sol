// SPDX-License-Identifier: UNLICENSED

pragma solidity >0.7.0 <0.9.0;

contract Donation {

    string public _donationName;
    string public _donationDescription;
    uint public donationMinAmount;
    uint public donationAmountNeeded;
    bool public acceptPaymentAfterAmountMet;

    address _owner;


    constructor(
        string memory name,
        string memory description, 
        uint minAmount, bool accept, 
        uint amountNeeded, address owner
    ) {
        _donationName = name;
        donationMinAmount = minAmount;
        acceptPaymentAfterAmountMet = accept;
        donationAmountNeeded = amountNeeded;
        _donationDescription = description;
        _owner = owner;
    }


    function donate() payable external {
        require(msg.value >= donationMinAmount, "You cannot donate below ${_minAmount}");
        if (!acceptPaymentAfterAmountMet) {
            uint balance = address(this).balance;
            require(balance + msg.value <= donationAmountNeeded, "Your donation will cross the amount needed");
        }
    }

    function donationBalance() view external returns (uint) {
        return address(this).balance;
    }

    function withdraw(address owner) public {
        require(_owner == owner, "Only owner of this donation can withdraw from it");
        payable(_owner).call{value: (address(this).balance)}("");
    }

    function getDonationName() public view returns (string memory){
        return _donationName;
    }

    function getDonationDescription() public view returns (string memory){
        return _donationDescription;
    }

    function getOwner() public view returns(address) {
        return _owner;
    }
}