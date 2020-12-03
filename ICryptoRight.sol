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
        // to set the election name
        electionName = _name;
    }
    
    // create a function to add candidate in the form of string
    //ownerOnly: only owner can add candidates
    //to prevent anyone interferring with candidate list.
    // it was set earlier in modifier line 57.
    
    //push : is to push new candidate in the array of candidates
    //crteating a new Candidate struct, passing all parameters given
    //in the struct which is giving _name, & _uint voteCount 
    //starting with zero votes.
    function addCandidate(string _name) ownerOnly public {
        candidates.push(Candidate(_name,0));
    }
    
    //create a function to keep track of the number of candidates
    //view : is to read only & not changing our varaiables.
    function getNumCandidate() public view returns (uint) {
        return candidates.length;
    }
    
    //create a function to authorize _person to vote
    //authorization is given only by owner
pragma experimental ABIEncoderV2;
pragma solidity ^0.5.0;

interface ICryptoRight {

    struct IWork {
        address owner;
        string uri;
    }

    event Copyright(uint copyright_id, address owner, string reference_uri);

    event OpenSource(uint copyright_id, string reference_uri);

    event Transfer(uint copyright_id, address new_owner);

    function copyrights(uint copyright_id) external returns(IWork memory);

    function copyrightWork(string calldata reference_uri) external;

    function openSourceWork(string calldata reference_uri) external;

    function renounceCopyrightOwnership(uint copyright_id) external;

    function transferCopyrightOwnership(uint copyright_id, address new_owner) external;
}
