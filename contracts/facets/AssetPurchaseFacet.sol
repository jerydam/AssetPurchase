// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { AggregatorV3Interface } from "../interfaces/AggregatorV3Interface.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract AssetPurchaseFacet {
    
    using SafeMath for uint256;

    address public owner;
    uint256 public price;
    IERC20 public token;
    AggregatorV3Interface private priceFeed;

    event Purchase(address indexed buyer, uint256 amount);

    constructor(uint256 _price, address _token) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(0x986b5E1e1755e3C2440e960477f25201B0a8bbD4);
        token = IERC20(_token);
    }

    function getLatestPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    function _purchase(uint256 _amount) public {
        require(_amount >= price, "Insufficient payment");

        uint256 tokenAmount = _amount.div(price);
        uint256 excessPayment = _amount.mod(price);

        token.transferFrom(msg.sender, owner, tokenAmount);
        if (excessPayment > 0) {
            payable(msg.sender).transfer(excessPayment);
        }

        emit Purchase(msg.sender, tokenAmount);
    }

    function _setPrice(uint256 _price) public {
        require(msg.sender == owner, "Unauthorized");
        price = _price;
    }

    function withdrawTokens(IERC20 _token, uint256 _amount) public {
        require(msg.sender == owner, "Unauthorized");
        _token.transfer(owner, _amount);
    }

    function withdrawEther(uint256 _amount) public {
        require(msg.sender == owner, "Unauthorized");
        payable(owner).transfer(_amount);
    }
}
