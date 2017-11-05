pragma solidity ^0.4.0;
contract invenio{
    
    struct User{
        string[] papers;
        string[] reviewed ;
        string firstName;
        string lastName;
        address userId;
    }
    
    User[] private allUsers;
    
    User private currentUser;
    function checkOwner(address checkAddr) returns(bool){
        if(checkAddr == msg.sender){
            return true;
        }
        else{
            return false;
        }
    }
    
    function getUser(address getAddr) private returns(bool){
        for(uint64 i = 0; i <= allUsers.length; i++){
            if(allUsers[i].userId == getAddr){
                currentUser = allUsers[i];
            }
        }
    }
    
    function checkColl(address checkAddr) private returns(bool){
        for(uint64 i = 0; i <= allUsers.length; i++){
            if(allUsers[i].userId == checkAddr){
                return true;
            }
            return false;
        }
    }

    function newUser(string newFirstName, string newLastName){
        if(!checkColl(msg.sender)){
            User newUser;
            newUser.firstName = newFirstName;
            newUser.lastName = newLastName;
            newUser.userId = msg.sender;
            allUsers.push(newUser);
        }
        else{
            require(false);
            return;
        }
    }
    function uploadPaper(address toAddress) public{
        require(checkOwner(toAddress));
        
    }
    event print(address out);
    function checkAccounts() public{
        for(uint64 i = 0; i <= allUsers.length; i++){
            print(allUsers[i].userId);
        }
    }
}
