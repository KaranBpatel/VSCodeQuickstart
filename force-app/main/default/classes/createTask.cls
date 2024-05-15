public with sharing class createTask {
    @AuraEnabled
 
    public static void createTask(String a,Id b,String c,String d,String e , String f) {

        System.debug(''+f);
        System.debug(''+e);
       Task t = new Task();
        t.OwnerId = b;
        t.Subject = a;
        t.Status = c;
        t.Priority =d;
        t.WhoId=e;
        t.WhatId=f;
       // t.WhatId = '0055h00000AlqutAAB';*/
        insert t;
        

    }
}