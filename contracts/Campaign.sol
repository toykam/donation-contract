// SPDX-License-Identifier: UNLICENSED

pragma solidity >0.7.0 <0.9.0;

import "./Donation.sol";

contract Campaign {

    struct DonationModel {
        address id;
        address owner;

        string name;
        string description;

        uint balance;
    }

    DonationModel[] donations;
    mapping(address => DonationModel[]) userCampaigns;

    event NewCampaign(Donation donation);
    event NewDonation(Donation donation);

    function createDonation(string memory name,string memory description, uint amountNeeded, bool accept, uint minAMount) public returns(address) {
        Donation donation = new Donation(
            name, description,
            minAMount, accept, amountNeeded, msg.sender
        );
        DonationModel memory donationModel = DonationModel(
            address(donation),
            msg.sender,
            
            donation.getDonationName(),
            donation.getDonationDescription(), 
            
            donation.donationBalance()
        );
        donations.push(donationModel);
        userCampaigns[msg.sender].push(donationModel);
        /// emit event to notify the frontend about a new campaign
        emit NewCampaign(donation);
        return address(donation);
    }

    function getCampain(address campaignAddress) public view returns(DonationModel memory) {
        Donation donation = Donation(campaignAddress);
        return DonationModel(
            address(donation),
            donation.getOwner(),

            donation.getDonationName(),
            donation.getDonationDescription(), 
            
            donation.donationBalance()
        );
    }

    function getCampaigns(uint offset, uint limit) public view returns(DonationModel[] memory dns) {
        require(limit <= 20, "You cannot retrieve more than 20 data at once.");
        require(offset <= donations.length, "Seems you have retrieved all the data");
        
        // offset+limit == the length till the current
        uint length = limit;
        if ((offset + limit) > donations.length) {
            length = donations.length - offset;
        }
        // 2,6 == 5
        dns = new DonationModel[](length);
        for (uint i = 0; i < length; i++) {
            DonationModel memory don = donations[offset + i];
            Donation donation = Donation(don.id);
            don.balance = donation.donationBalance();
            dns[i] = don;
        }
        return dns;
    }

    function donateToCampaign(address campaignAddress) payable public {
        Donation donation = Donation(campaignAddress);
        donation.donate{value: msg.value}();
        emit NewDonation(donation);
    }

    function withdrawFromCampaign(address campaignAddress) public {
        Donation donation = Donation(campaignAddress);
        donation.withdraw(msg.sender);
    }

    function getUserCampaigns(address userAddress) public view returns(DonationModel[] memory) {
        return userCampaigns[userAddress];
    }
}