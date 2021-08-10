pragma solidity ^0.4.17;

contract CampaingFactory {
    address[] public deployedCampaigns;

    function createCampaign(uint minimumContribution) public{
        address newCampaign = new Campaing(minimumContribution, msg.sender);
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaigns() public view returns(address[]){
        return deployedCampaigns;
    }

}


contract Campaing {
    struct Request{
        string description;
        uint value;
        address recepient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public contributors;
    uint public contributorsCount;

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    constructor(uint minimum, address creator) public{
        manager = creator;
        minimumContribution = minimum;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution);

        contributors[msg.sender] = true;
        contributorsCount++;
    }

    function createRequest(string description, uint value, address recepient) public restricted{
        Request memory newRequest = Request({
           description: description,
           value: value,
           recepient: recepient,
           complete: false,
           approvalCount: 0
        });

        requests.push(newRequest);

    }

    function approveRequests(uint requestIndex) public {
        Request storage request = requests[requestIndex];

        require(contributors[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequests(uint requestIndex) public restricted {
        Request storage request = requests[requestIndex];

        require(request.approvalCount > (contributorsCount/2));
        require(!request.complete);

        request.recepient.transfer(request.value);
        request.complete = true;

    }


}
