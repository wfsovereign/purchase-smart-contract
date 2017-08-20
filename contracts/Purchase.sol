pragma solidity ^0.4.11;


contract Purchase {
    address public seller;
    address public buyer;
    uint public value;
    State public state;

    enum  State {
        Created,
        Locked
    }

    struct CommonParams {
        address from;
        uint value;
    }
    
    function Purchase() payable {
        seller = msg.sender; 
        value = msg.value / 2;
        require((value * 2) == msg.value);
    }

    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    event PurchaseConfirmed();

    function confirmPurchase()
     condition((value * 2) == msg.value) payable 
    {
        PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;



    }

}
