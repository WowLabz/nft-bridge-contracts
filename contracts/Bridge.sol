pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";


contract Bridge {

    address owner;
    address bridgeNftContractAddress;

    constructor(address _bridggeNftContractAddress){
        owner = msg.sender;
        bridgeNftContractAddress = _bridggeNftContractAddress;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this functionality");
        _;
    }

    modifier validAddress(address _test) {
        require(_test != address(0), "Invalid address passed");
        _;
    }

    modifier bridgeNftSet {
        require(bridgeNftContractAddress != address(0), "Bridge NFT Contract Not set");
        _;
    }

    function setBridgeNftContractAddress(address _bridgeNftContractAddress) external onlyOwner validAddress(_bridgeNftContractAddress) {
        bridgeNftContractAddress = _bridgeNftContractAddress;
    }

    function transferSelf(address _nftContractAddress, uint256 _nftId) public bridgeNftSet onlyOwner validAddress(_nftContractAddress) {
        address _owner = IERC721(_nftContractAddress).ownerOf(_nftId);
        // transfer(_nftContractAddress, _nftId, _owner, address(this));
        transfer(_nftContractAddress, _nftId, _owner, bridgeNftContractAddress);
        require(checkOurOwnership(_nftContractAddress, _nftId), "Transfer failed!");
    }

    function checkOurOwnership(address _nftContractAddress, uint256 _nftId) public view  validAddress(_nftContractAddress) returns(bool) {
        bool result = IERC721(_nftContractAddress).ownerOf(_nftId) == bridgeNftContractAddress;
        return result;
    }

    function getName(address _nftContractAddress) public view validAddress(_nftContractAddress) returns(string memory) {
        return IERC721Metadata(_nftContractAddress).name();
    }

    function getOwner(address _nftContractAddress, uint256 _nftId) external view validAddress(_nftContractAddress) returns(address) {
        return IERC721(_nftContractAddress).ownerOf(_nftId);
    }

    function getUri(address _nftContractAddress, uint256 _nftId) external view validAddress(_nftContractAddress) returns(string memory){
        return IERC721Metadata(_nftContractAddress).tokenURI(_nftId);
    }

    function transferBack(address _nftContractAddress, uint256 _nftId, address _owner) external onlyOwner {
        require(_nftContractAddress != address(0), "Invalid Contract Address");
        require(_owner != address(0), "Invalid owner address");
        transfer(_nftContractAddress, _nftId, address(this), _owner);
    }

    function transfer(address _contractAddress, uint256 _nftId, address _from, address _to) private {
        IERC721(_contractAddress).safeTransferFrom(_from, _to, _nftId);
    } 
}
