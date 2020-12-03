pragma solidity ^0.4.21;

contract Election{
    //store candidate info.
    struct Candidate {
        // Candidate name in string
        string name;
        
        //how many votes each candidate received
        uint voteCount;
    }
    
    //store voter info.
    struct Voter {
        // only authorized voters can vote
        bool authorized;
        
        // to prevent voting more than one time
        bool voted;
        
        
        //to keep track of each vote received
        uint vote;
    }
    
    //////START STATE VARIABLES//////
    
    //deployer is the owner of the contract
    address public owner;
    
    // identify election name or purpose
    string public electionName;
    
    //mapping the address to voters
    mapping(address =>  Voter) public voters;
    
    //keep track of candidates in an array.
    Candidate[] public candidates;
    
    //keep track of how many votes are received
    uint public totalVotes;
    
   //////END STATE VARIABLES//////
   
   
    event voteEvent (uint _voteIndex);
    
    //set delpoyer which is the contract owner
    //to be the only one allowed to modify
    //functions in this contract when ownerOnly
    //is added to any function
    
    //_; is a pre-condition check in this contract
    //making sure that require condition is satisfied first
    //before executing the rest of the function.
    
    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }
    
    // constructor executed once when the contract is deployed.
    constructor (string memory _name) public {
        
        //create global variable to owner
        // owner here is the delpoyer
        owner = msg.sender;
        
        //pass the parameter given in constructor
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";
import "./ICryptoRight.sol";

contract CryptoRight is ICryptoRight {

    using Counters for Counters.Counter;

    Counters.Counter copyright_ids;

    struct Work {
        address owner;
        string uri;
    }

    mapping(uint => Work) public copyrights;

    event Copyright(uint copyright_id, address owner, string reference_uri);

    event OpenSource(uint copyright_id, string reference_uri);

    event Transfer(uint copyright_id, address new_owner);

    modifier onlyCopyrightOwner(uint copyright_id) {
        require(copyrights[copyright_id].owner == msg.sender, "You do not have permission to alter this copyright!");
        _;
    }

    function copyrightWork(string memory reference_uri) public {
        copyright_ids.increment();
        uint id = copyright_ids.current();

        copyrights[id] = Work(msg.sender, reference_uri);

        emit Copyright(id, msg.sender, reference_uri);
    }

    function openSourceWork(string memory reference_uri) public {
        copyright_ids.increment();
        uint id = copyright_ids.current();

        copyrights[id].uri = reference_uri;
        // no need to set address(0) in the copyrights mapping as this is already the default for empty address types

        emit OpenSource(id, reference_uri);
    }

    function transferCopyrightOwnership(uint copyright_id, address new_owner) public onlyCopyrightOwner(copyright_id) {
        // Re-maps a given copyright_id to a new copyright owner.
        copyrights[copyright_id].owner = new_owner;

        emit Transfer(copyright_id, new_owner);
    }

    function renounceCopyrightOwnership(uint copyright_id) public onlyCopyrightOwner(copyright_id) {
        // Re-maps a given copyright_id to the 0x0000000000000000000000000000000000000000
        transferCopyrightOwnership(copyright_id, address(0));

        emit OpenSource(copyright_id, copyrights[copyright_id].uri);
    }

}

