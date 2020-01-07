pragma solidity ^0.5.12;

import "./Order_Process.sol";

contract Test_Process{
    uint standard = 500;
	address[] famerIndex;
    struct certificate{
        bool Checked;
        bool organicMark;
        address theChcker;
        string vName;
        uint theTV;
        uint markTime;
    }
    struct Person {
        uint job_type;
        Test_Process tp;
		Order_Process[] ops;
    }
    
    mapping (address => certificate) public allcertificates;
    
    function RequestCheck(uint theP, uint test_val, string memory product) public{
        //檢查是否為農夫申請檢測
        require(theP == 3, "Sorry, you are not a famer");
        allcertificates[msg.sender].Checked = false;
        allcertificates[msg.sender].theTV = test_val;
        allcertificates[msg.sender].vName = product;
    }
    
    function GoCheck(uint theP, address theF) public{
        //檢查是否為檢測商
        require(theP == 1, "Sorry, you are not a checker");
        allcertificates[theF].Checked = true;
        //檢測值符合標準
        if( allcertificates[theF].theTV <= standard ){
            allcertificates[theF].organicMark = true;
        }
        else{
            allcertificates[theF].organicMark = false;
        }
        allcertificates[theF].theChcker = msg.sender;
        allcertificates[theF].markTime = now;
        
    }
    
    function GetPassedVegetables(address theF) public returns(bool){
        if(allcertificates[theF].Checked){
            if(allcertificates[theF].organicMark){
                return true;
            }
            else{
                return false;
            }
        }
    }
    
}