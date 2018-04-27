Crowdsale token deployed on Rinkeby

Send Rinkeby Ether to 0xaf46b8fca060d4ebc648de42906258d302f0746b (may change in future)

1. After making changes to either AssetCoinSale.sol or AssetCoinToken.sol, deploy bytecode to Rinkeby client running on our Digital Ocean VM
2. If new deployment of AssetCoinToken.sol, the contract address needs to be updated for AssetCoinCrowdsale.sol in it's init parameters
3. Check price and personalMax values and set them appropriately
4. Get Rinkey address KYC approved before sending Ether
5. Checking funding status before sending Ether

Checking Funding Status

(ContractObject).funding()

Checking KYC Status

(ContractObject).permissions()

Getting KYC approved (only from Owner Account - eth.accounts[0])

(ContractObject).approve((AddressToBeApproved))
