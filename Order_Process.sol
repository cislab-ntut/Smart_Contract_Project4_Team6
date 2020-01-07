pragma solidity ^0.5.12;

contract Order_Process{
    address payable owner; 
    string deliver_address;
    address farmer;
    address deliveryman;
    uint price;
    uint id;
    
    constructor(address  _farmer, uint _price, uint _id, string memory _deliver_address) public {
        owner=msg.sender;
        deliver_address = _deliver_address;
        farmer = _farmer;
        price = _price;
        id = _id;
    }
    
    //完成訂單
     function Getdeliveryman() public returns(address){
        return deliveryman;
    }
     function Setdeliveryman(address _deliveryman) public{
       deliveryman  = _deliveryman;
    }

 //刪除訂單
    function kill() public { 
        require(msg.sender == owner, "Only owner can call this function.");
        selfdestruct(owner);
    }
    
    //GET
    function GetPrice() public returns(uint){
        return price;
    }
    function GetId() public returns(uint){
        return id;
    }
    function GetFarmer() public returns(address){
        return farmer;
    }
    function GetDeliver_address() public returns(string memory){
        return deliver_address;
    }
}
