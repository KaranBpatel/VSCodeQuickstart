@RestResource(urlMapping='/Account')
global with sharing class restWebServices {

   @HttpGet
    global static List<Account> getRecord() {
        
        RestRequest req = RestContext.request;

        RestResponse res = RestContext.response;
        return [SELECT ID, Name FROM Account ];
    }
}