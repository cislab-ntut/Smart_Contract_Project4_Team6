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
	people[sender].balance -= amount;
        people[receiver].balance += amount;
    }
	//消費者下單，指定農夫是誰，消費金額，宅配地址
	function place_order(address famer, uint amount, string memory deliver_address) public{
	    OrderID++;
		pay_fee(msg.sender,theSystem, amount);
		Order_Process theop = new Order_Process(famer, amount, OrderID, deliver_address);
		people[msg.sender].ops.push(theop);
	}
	//確認已收到貨，完成訂單
	function confirmOrder(uint _OrderID)public{
	    Order_Process _theop = findOrder(_OrderID);
	    pay_fee(theSystem,_theop.GetFarmer(),_theop.GetPrice()-1); //給農夫錢錢
	    pay_fee(theSystem,_theop.Getdeliveryman(),1); //給運送員錢錢
	    _theop.kill();
	}
	//尋找訂單
	function findOrder(uint _OrderID) public returns (Order_Process){
	   for(uint i = 0; i < all_user.length; i++){
			//若為消費者
			if(people[all_user[i]].job_type == 4){
			    for(uint j = 0; j < people[all_user[i]].ops.length ; j++){
			        //找出訂單
			        if(people[all_user[i]].ops[j].GetId() == _OrderID){
					    return people[all_user[i]].ops[j]; //回傳訂單
				    }
			    }
			}
		}
	}
	//回傳合格商品資訊
	function display_product(address indexF) public returns (bool) {
	    bool ans =  tp.GetPassedVegetables(indexF);
        return ans;
    }
    //農夫申請檢測
    function famerStartCheck(uint test_val, string memory product)public{
        tp.RequestCheck(people[msg.sender].job_type, test_val, product);
    }
    //檢測商進行檢測，農夫支付費用
    function checkWork(address theF)public{
        tp.GoCheck(people[msg.sender].job_type, theF);
        pay_fee(theF, msg.sender, 1);
    }
}
