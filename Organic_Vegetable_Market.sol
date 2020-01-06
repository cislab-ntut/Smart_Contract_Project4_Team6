pragma solidity ^0.5.12;

import "./Test_Process.sol";
import "./Order_Process.sol";

contract Organic_Vegetable_Market{
    
	//確認已收到貨，完成訂單
	function confirmOrder(uint _OrderID){
	    Order_Process _theop = findOrder(_OrderID);
	    pay_fee(theSystem,_theop.GetFarmer(),_theop.GetPrice()-0.5); //給農夫錢錢
	    pay_fee(theSystem,_theop.Getdeliveryman(),0.5); //給運送員錢錢
	    _theop.kill();
	}
	//尋找訂單
	function findOrder(uint _OrderID) returns (Order_Process){
	   for(unit i = 0; i < all_user.length; i++){
			//若為消費者
			if(people[allUser[i]].ptype == 4){
			    for(uint j = 0; j < people[allUser[j]].length ; j++){
			        //找出訂單
			        if(people[allUser[i]].ops[j].GetID() == _OrderID){
					    return people[allUser[i]].ops[j]; //回傳訂單
				    }
			    }
			}
		}
	}
	
}
