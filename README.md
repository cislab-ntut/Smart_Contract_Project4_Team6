# Project6-4_Smart_contract

## 構思與設計理念
農夫透過智能合約讓有機蔬果得到認證，並且上架商品，消費者確保購買的是有機蔬果，營造誠信的交易環境。

## 系統架構示意圖
![image](https://i.imgur.com/HWYs7hk.jpg)

### 系統主要分成三部分：
* 商品檢測與上架(上圖橘色部分，Test_Process.sol)
    
    ![](https://i.imgur.com/QUyZwRB.png)


* 消費者下單與配送(上圖深紅色部分，Order_Process.sol)
  ![](https://i.imgur.com/uFTkBvF.jpg)

* 檢測商與宅配員入場(上圖天藍色部分，Organic_Vegetable_Market.sol)
    ![](https://i.imgur.com/QlG3RyH.png)

### 使用者分成五種身分：
1. 系統管理者 (job_type = 0)
```  
收取入場費及扮演中立角色，維持系統運作。
當訂單成立時，先由系統保管消費金額，待消費者確認收到貨後，再將金額分還給農夫及宅配員。
```  
2. 檢測商 (job_type = 1)
```  
需通過系統管理者認證並付入場費，方可開始使用系統。
負責檢驗農夫的土地是否符合有機生產環境的規範。
檢測合格 --> 給農夫合格證明
```  
3. 宅配員 (job_type = 2)
```  
需通過系統管理者認證並付入場費，方可開始使用系統。
負責從農地取貨及送貨給消費者，並從中獲取利潤。
```  
4. 農夫 (job_type = 3)
```  
得到檢測合格證明後，方可刊登、銷售農產品。
```  
5. 消費者 (job_type = 4)
```  
消費農產品。
```  
## Function詳細說明

###  Organic_Vegetable_Market.sol
function register(uint8 ptype)
不是系統的人需要註冊。
- ptype是使用者類別(0:系統管理者 1:檢測商 2:物流業者 3:農夫 4:消費者)

function pay_fee(address sender, address receiver, uint amount)
支付費用
- sender 付錢的人
- receiver 收錢的人
- amount 金額

function place_order(address famer, uint amount, string memory deliver_address)
消費者下單
- farmer 農夫
- amount 消費金額
- deliver_address 宅配地址

function confirmOrder(uint OrderID)
確認是否有收到貨，完成訂單
- OrderID 訂單編號

function findOrder(uint OrderID)
尋找訂單
- OerderID 訂單標號

function display_product(address indexF)
回傳農夫商品是否有檢測成功(True或False)，裡面呼叫Test_Process.sol的GetPassedVegetables
- indexF表示農夫

function famerStartCheck(uint test_val, string memory product)
農夫申請檢測，裡面呼叫Test_Process.sol的RequestCheck
- test_val表示農地的分數
- product表示農夫的作物

function checkWork(address theF)
檢測商進行檢測，農夫支付費用，裡面呼叫Test_Process.sol的GoCheck
- theF表示農夫 

### Order_Process.sol

function Getdeliveryman()
回傳送貨員address

function Setdeliveryman(address _deliveryman)
設定送貨員address
- _deliveryman表示送貨員的address

function kill()
刪除此訂單

function GetPrice()
回傳訂單價格

function GetId()
回傳訂單編號

function GetFarmer()
回傳農夫address

function GetDeliver_address()
回傳送貨地址

### Test_Process.sol
function RequestCheck(uint theP, uint test_val, string memory product)
農夫會call這個function申請檢測，先透過theP檢查是否為農夫，然後把農地跟產品存起來，表示這個農夫待檢測。
- theP表示身分
- test_val表示農地的分數
- product表示農夫的作物

function GoCheck(uint theP, address theF)
檢測商call這個function，先透過theP檢查是否為檢測商，並檢查進來的農夫是否符合標準，若農夫的農地分數高於標準，就讓農夫過關。
- theP表示身分
- theF表示農夫

function GetPassedVegetables(address theF)
看這個農夫的農地有沒有檢驗合格
- theF表示農夫


### Function使用情境
1. 除了系統以外的人註冊
    * 所有使用者進入系統註冊呼叫，若為農夫與宅配員需付入場費：register(身分型態)

2. 消費者購物流程
    * 消費者收到貨物，系統發送薪資給農夫與宅配員：confirmOrder(訂單編號)
    * 消費者下訂單，註記商品與宅配資訊：place_order(商品與宅配資訊) 
    * 消費者查詢合格商品：display_product(欲查詢的農夫)

3. 農夫檢測流程
    * 農夫申請檢驗：famerStartCheck(檢測值與商品名稱)
    * 檢測商進行檢測，農夫支付檢測費：checkWork(欲檢測的農夫資訊)
