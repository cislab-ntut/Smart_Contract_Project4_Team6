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
