# Donation and Campaign Contract
This contract has two main contract, the *Donation Contract* and *Campaign Contract*. They work together to make donation and campaign creation seemless.

#### Donation Contract
The *Donation Contract* is the contract that stores the detail about a donation, which are:
- donationName: Donation name
- donationAmountNeeded: Amount Needed
- donationMinAmount: Min Amount that can be contributed to the donation
- owner: The creator of the donation, because we don't want anybody to be able withdraw from the donation except for the person that created it.

#### Campaign Contract
This can also be seen as the *Donation Contract* Manager, because it keeps track of all donations that have been created by the users. It is also the contract the users will intereact with to be able to create and manage their donations...

#### How It Works
As stated above, the *Campaign Contract* is what the users will interact with, it has functions that will enable users to do the following
- Create Campaign which in turn creates a donation
- Get Campaign balance
- Get Campaign Owner
- Donation to a Campaign
- Withdraw from a Campaign
- Get the list of all created campaigns