@isTest
private class AccountManagerTest {

    @isTest static void testAccountManager()
    {
        
        
        
        Account a= new Account(Name='TestAccount');
        insert a;
        
        Contact c= new Contact(LastName='Test',FirstName='Testal',AccountId=a.Id);
        insert c;
        
        RestRequest request= new RestRequest();
        request.requestURI= 'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+a.id+'/contacts';
        
        request.HttpMethod='GET';
        RestContext.request=request;
        
        Account thisAcc= AccountManager.getAccount();
        
        System.assert(thisAcc!=null);
        System.assertEquals('TestAccount',thisAcc.Name);
        
        
    }
    
   
}