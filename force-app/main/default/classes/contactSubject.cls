public with sharing class contactSubject {
    @AuraEnabled
   
    public static List<message__c> contactSub() {

        List<message__c> newList=[SELECT id,message__c,messageDate__c,check__c,contactId__c,Name,phone__c FROM message__c  ORDER BY  messageDate__c DESC ];
        
        return newList;
    }

    @AuraEnabled
    public static String updateRead(Id b,Boolean c){
       
        message__c con= new message__c();
        con.Id=b;
        con.check__c=c;
        update con;
        return 'updated';
    }

    @AuraEnabled
    public static void updateAll(Boolean b){

        List<message__c> uplist= new List<message__c>();

        if(b==false){

       for(message__c cv:[SELECT Id,check__c FROM message__c WHERE check__c= : b])
       {
            cv.check__c=true;
            uplist.add(cv);
       }
    }
    else if(b==true)
    {
        for(message__c cv:[SELECT Id,check__c FROM message__c WHERE check__c= : b])
        {
             cv.check__c=false;
             uplist.add(cv);
        }

    }

       if(!upList.isEmpty())
       {
        update uplist;
       }

       //List<Contact> cList= [SELECT name,message__c,messagedDate__c,check__c,Phone FROM Contact WHERE messagedDate__c!=null];
        
        //return cList;
    }

    @AuraEnabled
    public static firstui__c getAllRead()
    {
        firstui__c msall= [SELECT 	markread__c,id FROM firstui__c]; 

        return msall;

    }

    @AuraEnabled
    public static firstui__c updateAllRead(Boolean b){

        firstui__c msall= [SELECT 	markread__c,id FROM firstui__c];
       
        if(b==false){
            msall.markread__c=true;
        }
        else if(b==true){
            msall.markread__c=false;
        }
        update msall;
        return msall;
    }


        @AuraEnabled
        public static boolean showcheck(){
          
            firstui__c boolshow=[SELECT bool2__c FROM firstui__c];
            Boolean bool = boolshow.bool2__c;
            return bool;
        }

        @AuraEnabled
        public static Boolean updateshow(){
          
            firstui__c boolshow=[SELECT bool2__c FROM firstui__c];
            boolshow.bool2__c =false;
            update boolshow;
            return boolshow.bool2__c;
        }

        @AuraEnabled
        public static Boolean updateshowTrue(Id b){
          
            firstui__c boolshow=[SELECT bool2__c,cid__c FROM firstui__c];
            boolshow.bool2__c = true;
            boolshow.cid__c=b;
            update boolshow;
            return boolshow.bool2__c;
        }

        @AuraEnabled
        public static message__c getshowTrue(){
          
            firstui__c boolshow=[SELECT bool2__c,cid__c FROM firstui__c];

            message__c showTrue=[SELECT Id,Name,message__c,messageDate__c FROM message__c WHERE Id=:boolshow.cid__c];
            
            return showTrue;
        }

        @AuraEnabled
        public static firstui__c getAllUnread()
        {
            firstui__c msall= [SELECT unreadall__c,id FROM firstui__c]; 
    
            return msall;
    
        }

        @AuraEnabled
    public static firstui__c updateAllUnread(Boolean b){

       firstui__c fu= [SELECT unreadall__c,id FROM firstui__c];

       if(b==false)
       {
            fu.unreadall__c=true;
       }
       else if(b==true)
       {
        fu.unreadall__c=false;
       }

       update fu;
       return fu;
    }

    @AuraEnabled
    public static Integer countCon(){
      
        Integer cn = [SELECT COUNT() FROM message__c WHERE check__c=false];
        System.debug(cn);
        return cn;
    }
}