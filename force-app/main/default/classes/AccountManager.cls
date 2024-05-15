@RestResource(urlMapping='/Bhaskar')
 global with sharing class AccountManager {
      @HttpGet
    global static List<Account> getRecord() {
        
        RestRequest request= RestContext.request;
        return [SELECT ID, Name FROM Account ];
    }
     
     @HttpPost
     
     global static Account createAccount(String Name)
     {
         Account acc= new Account();
         acc.Name=Name;
         acc.Phone='123';
         insert acc;
         return acc;
     }
     
     @HttpDelete
     
     global static void deleteAccount()
     {
         RestRequest request= RestContext.request;
         
         String accId= request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
         
         Account acc= new Account();
         acc.Id= accId;
         delete acc;
     }  
     
     @HttpPut
     
     global static void upsertAccount()
     {
         
     }
     @HttpPatch
     
     global static void updateAccount()
     {
         RestRequest request= RestContext.request;
         String accId= request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
         
         Account acc= new Account();
         acc.Id= accId;
         
         Map<String,Object> toUpdate= (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
         
         for(String fieldName:toUpdate.keyset())
         {
             acc.put(fieldName,toUpdate.get(fieldName));
         }
         update acc;
     }
}