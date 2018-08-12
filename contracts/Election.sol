pragma solidity ^0.4.2;
contract Election{
    //model of a candidate 
    struct Candidate{
        uint id;
        string name;
        uint votecount;
    }
    //store accounts that have voted
    mapping(address => bool) public voters;
    //store and fetch candidates
    //interaction with the datalink layer of the blockchain
    mapping(uint => Candidate) public candidates;
    //store candidate count
    uint public candidatesCount;
    //voted event
    event votedEvent (
        uint indexed _candidateId
    );
    

    constructor()public {
        addCandidate("candidate 1");
        addCandidate("candidate 2");
       
    }
    function addCandidate(string _naam) private{
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _naam , 0);
    }
    function vote(uint _candidateId) public {
        //requires a valid candidate
        //requires the voter has not voted already
        require(!voters[msg.sender]);
        require(_candidateId>0 && _candidateId<= candidatesCount);
        
        //record the voter has voted
        voters [msg.sender] = true ;

        //update candidate votecount 
        candidates[_candidateId].votecount ++;
        emit votedEvent(_candidateId);
    }
}