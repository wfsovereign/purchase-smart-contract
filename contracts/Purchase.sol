pragma solidity ^0.4.11;


contract Purchase {
    address public seller;
    address public buyer;
    uint public value;
    State public state;

    enum  State {
        Created,
        Locked,
        Inactive
    }

    struct CommonParams {
        address from;
        uint value;
    }
    
    function Purchase() payable {
        seller = msg.sender; 
        value = msg.value / 2;
        require((value * 2) == msg.value);
        state = State.Created;
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

    modifier inState(State _state) {
        require(state == _state);
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();


    function abort()
     onlySeller
     inState(State.Created)
    {
        Aborted(); 
        state = State.Inactive;
        seller.transfer(this.balance);
    }

    function confirmPurchase()
     condition((value * 2) == msg.value)
     inState(State.Created)
     payable 
    {
        PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;
    }

    function confirmReceived()
     onlyBuyer 
     inState(State.Locked)
    {
        ItemReceived();
        state = State.Inactive;
        buyer.transfer(value);
        seller.transfer(this.balance);
    }
}
