// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "../lib/forge-std/src/Script.sol";
import "../contracts/interfaces/IDiamondCut.sol";
import "../contracts/facets/DiamondLoupeFacet.sol";
import "../contracts/facets/OwnershipFacet.sol";
import "../contracts/facets/AssetPurchaseFacet.sol";
import "../contracts/Diamond.sol";

contract Addfacet is Script, IDiamondCut {
  
  address deployer =  0x7A1c3b09298C227D910E90CD55985300bd1032F3;
   address DiamondAddr = 0xe8569787279241F6A5F3CBF21DCbc655e53A7f1b;
   address diamondcut = 0x76555110bc4938ff0A0bfB0AA113AF9447fc4B86;
   address AssetPurchase = 0x46d96167DA9E15aaD148c8c68Aa1042466BA6EEd;
    function run() public {
        FacetCut[] memory slice = new FacetCut[](1);

        slice[0] = ( FacetCut({
            facetAddress: AssetPurchase,
            action: FacetCutAction.Add,
            functionSelectors: generateSelectors("AssetPurchaseFacet")
        }));

        uint256 key = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(key);
        
        IDiamondCut (DiamondAddr).diamondCut(slice, address(0), "");
        IDiamondLoupe(DiamondAddr).facetAddresses();
        vm.stopBroadcast();


        }  
   function generateSelectors(string memory _facetName)
        internal
        returns (bytes4[] memory selectors)
    {
        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "scripts/genSelectors.js";
        cmd[2] = _facetName;
        bytes memory res = vm.ffi(cmd);
        selectors = abi.decode(res, (bytes4[]));
    }
    function diamondCut(
        FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata
    ) external override {}
}