pragma solidity ^0.4.11;


contract Purchase {
    address public seller;
    uint public value;
    uint public state;

    struct CommonParams {
        address from;
        uint value;
    }
    
    function Purchase() payable {
        seller = msg.sender; 
        value = msg.value / 2;
        state = 0;

    }

    function confirmPurchase() {
        
    }

}
