pragma solidity ^0.5.12;

import "./Test_Process.sol";
import "./Order_Process.sol";

contract Organic_Vegetable_Market{
    address theSystem;
    uint OrderID;
    Test_Process tp;
	//紀錄所有user的address
    address[] all_user; 
    struct Person {
        uint job_type;
		Order_Process[] ops;
		uint balance;
    }
    //people陣列中記錄系統中所有用戶身分
    mapping(address => Person) people;

    constructor(uint8 ptype) public {
        people[msg.sender].job_type = ptype;
        theSystem = msg.sender;
        OrderID = 0;
    }
    
	//除了系統以外的人註冊job_type
	function register(uint8 ptype) public{
	    people[msg.sender].job_type = ptype;
	    //檢驗商跟物流業者付入場費；testers and logistics pay fee
        if(ptype == 1 || ptype == 2){
            pay_fee(msg.sender,theSystem, 1);
			all_user.push(msg.sender);
        }
		//農夫入場建立檢驗流程
        else if(ptype == 3){
            people[msg.sender].balance = msg.sender.balance;
			all_user.push(msg.sender);
        }
		else if(ptype == 4){
            people[msg.sender].balance = msg.sender.balance;
			all_user.push(msg.sender);
		}
	}
	//支付費用
    function pay_fee(address sender, address receiver, uint amount) public {
        require(amount <= people[sender].balance, "Not enough funds.");
