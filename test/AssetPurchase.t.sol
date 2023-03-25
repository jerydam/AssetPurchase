// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
// import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
// import "../lib/forge-std/src/Test.sol";


// import "../contracts/facets/AssetPurchaseFacet.sol";


// contract AssetPurchaseTest is Test {
//         AssetF  asset;
//         NFT nft;

//         address tester1 = mkaddr("tester1");
//         address assetowner = mkaddr("assetowner");
//    function setUp() public {
//         vm.startPrank(tester1);
//         AssetPurchase = new AssetPurchase();
        
//         nft = new NFT();
//         vm.stopPrank();

//    }

//    function testPurchase() public{
//     vm.deal(tester1, 1000 ether);
//     vm.startPrank(tester1);
    
//     asset.getprice("usdt");
//     vm.stopPrank();
//    }


// function testStageAsset() public {
//     vm.startPrank(tester1);
//     vm.deal(tester1, 1000 ether);

//     // Set tester account as an approved operator for the NFT contract
//     IERC721(address(nft)).setApprovalForAll(address(asset), true);

//     // Approve Assetbuyer contract to transfer NFT
//     IERC721(address(nft)).approve(address(asset), 1);

//     // Stage asset
//     asset.stageAsset("test", 1 ether, assetowner, address(nft), true, 0, 1);

//     vm.stopPrank();
// }

// function testgetAssetdetails() public {
//     testStageAsset();
//     vm.prank(tester1);
//     asset.getAssetDetails(1);
// }

//     function mkaddr(string memory name) public returns (address) {
//         address addr = address(
//             uint160(uint256(keccak256(abi.encodePacked(name))))
//         );
//         vm.label(addr, name);
//         return addr;
//     }
// }