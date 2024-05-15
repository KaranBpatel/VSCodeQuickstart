public class contactCounter {

    
     public static void countContact(List<Contact> newList)
    {
        Contact[] conList= new Contact[]{};
        Set<id> conids= new Set<id>();
        for(Contact con:newList)
        {
           conids.add(con.AccountId); 
           conList.add(con);
        }
        
        Map<id,Account> conRelAcc=new Map<id,Account>([SELECT id,Total_Customer_Acc__c FROM Account WHERE Id IN: conids]);//id for Secoond MAp accIdtoCOunt check contact related
        Map<id,Decimal> accIdtoCount= new Map<id,Decimal>();//<account's ID,Total contacts>
        for(Contact con:conList )
        {
            
            if(conRelAcc.containskey(con.AccountId))
            {
                if(accIdtoCount.containskey(con.AccountId)){
                    
                    Decimal count=1;
                    Count = Count+accIdtoCount.get(con.AccountId);
                  
                    accIdtoCount.put(con.AccountId,accIdtoCount.get(con.AccountId)+1);
                    System.debug('Contains '+count);
                                 System.debug(accIdtoCount.get(con.AccountId)+1);

                    
                }
                 else
           			 {
                         if(conRelAcc.get(con.AccountId).Total_Customer_Acc__c!=null){
                         
                         System.debug('First +');
                         System.debug(conRelAcc.get(con.AccountId).Total_Customer_Acc__c);
							accIdtoCount.put(con.AccountId,conRelAcc.get(con.AccountId).Total_Customer_Acc__c+1);

                         }
                         else
                         {
                             accIdtoCount.put(con.AccountId,1);
                         }
                         } 
            }
                       
        }
        Account[] accUpdated= new Account[]{};
        for(Id idv:accIdtoCount.keyset())
        {
            Account acc= new Account();
            acc.id=idv;
            acc.Total_Customer_Acc__c= accIdtoCount.get(idv);
            accUpdated.add(acc);
        }
        if(!accUpdated.isEmpty())
        {
            update accUpdated;
        }
    }
    
    public static void afterDelete(List<Contact> newList)
    {
           Contact[] conList= new Contact[]{};
        Set<id> conids= new Set<id>();
        for(Contact con:newList)
        {
           conids.add(con.AccountId); 
           conList.add(con);
        }
        
        Map<id,Account> conRelAcc=new Map<id,Account>([SELECT id,Total_Customer_Acc__c FROM Account WHERE Id IN: conids]);//id for Secoond MAp accIdtoCOunt check contact related
        Map<id,Decimal> accIdtoCount= new Map<id,Decimal>();//<account's ID,Total contacts>
        for(Contact con:conList )
        {
            
            if(conRelAcc.containskey(con.AccountId))
            {
                if(accIdtoCount.containskey(con.AccountId)){
                    
                    Decimal count=1;
                    Count = Count+accIdtoCount.get(con.AccountId);
                  
                    accIdtoCount.put(con.AccountId,accIdtoCount.get(con.AccountId)-1);
                    System.debug('Contains '+count);
                                 System.debug(accIdtoCount.get(con.AccountId)-1);

                    
                }
                 else
           			 {
                         //if(conRelAcc.get(con.AccountId).Total_Customer_Acc__c!=null){
                         
                         System.debug('First +');
                         System.debug(conRelAcc.get(con.AccountId).Total_Customer_Acc__c);
							accIdtoCount.put(con.AccountId,conRelAcc.get(con.AccountId).Total_Customer_Acc__c-1);

                        // }
                         //else
                      ///   {
                       //      accIdtoCount.put(con.AccountId,);
                       //  }
                         } 
            }
                       
        }
        Account[] accUpdated= new Account[]{};
        for(Id idv:accIdtoCount.keyset())
        {
            Account acc= new Account();
            acc.id=idv;
            acc.Total_Customer_Acc__c= accIdtoCount.get(idv);
            accUpdated.add(acc);
        }
        if(!accUpdated.isEmpty())
        {
            update accUpdated;
        }
    }
}