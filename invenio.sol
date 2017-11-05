pragma solidity ^0.4.8;
contract invenio{
    
    struct Review{
        string link;
        uint64 rating;
        uint64 byIndex;
    }
    struct Paper{
        string title;
        uint64 byIndex;
        string link;
        Review[] reviews;
        string tag;
    }
    struct User{
        Paper[] papers;
        string[] reviewed ;
        string firstName;
        string lastName;
        address userId;
        uint64 cred;
    }

    
    User[] private allUsers;
    uint64 private currentUser;
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
                currentUser = i;
            }
        }
    }
    function getUserIndex(address getAddrIndex) private returns(uint64){
        for(uint64 i = 0; i <= allUsers.length; i++){
            if(allUsers[i].userId == getAddrIndex){
                return i;
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
            newUser.cred = 5;
            allUsers.push(newUser);
        }
        else{
            require(false);
            return;
        }
    }
    function uploadPaper(string newTitle, string newLink, string newTag, address toAddr) public{
        require(checkOwner(allUsers[currentUser].userId));
        Paper newPaper;
        newPaper.title = newTitle;
        newPaper.link = newLink;
        newPaper.tag = newTag;
        allUsers[getUserIndex(toAddr)].papers.push(newPaper);
        calcCred(getUserIndex(toAddr));
    }
    function addReview(uint64 parentUser, uint64 postIndex, string reviewLink, uint64 newRating) public{
        Review newReview;
        newReview.link = reviewLink;
        newReview.rating = newRating;
        newReview.byIndex = getUserIndex(msg.sender);
        allUsers[parentUser].papers[postIndex].reviews.push(newReview);
        calcCred(parentUser);
    }
    function calcCred(uint64 userIndex) private{
        uint64 count;
        uint64 newCred;
        for(uint64 i = 0; i <= allUsers[userIndex].papers.length; i++){
            for(uint64 n = 0; n <= allUsers[userIndex].papers[i].reviews.length; n++){

                newCred += allUsers[userIndex].papers[i].reviews[n].rating * allUsers[allUsers[userIndex].papers[i].reviews[n].byIndex].cred;
                count++;
            }
        }
        allUsers[currentUser].cred = newCred/count;
    }
}
