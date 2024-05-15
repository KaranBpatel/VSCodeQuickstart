public class TopXobjectHandler {
    
    public static void afterInsert(List<Top_X_Designation__c> newList)
    {
        Opportunity[] oppList= new Opportunity[]{};
        for(Top_X_Designation__c tv:newList)
        {
            if(tv.Type__c == 'Contract Flow Down' && tv.Document_Attached__c==True && tv.Opportunity__c!=null)
            {
                Opportunity opp=new Opportunity();
                opp.id=tv.Opportunity__c;
                opp.Handoff_Attached__c='Yes';
                oppList.add(opp);
            }
            else if(tv.Type__c=='Handoff' && tv.Document_Attached__c== True && tv.Opportunity__c!=null)
            {
                Opportunity opp=new Opportunity();
                opp.id=tv.Opportunity__c;
                opp.Handoff_Attached__c='Yes';
                oppList.add(opp);
            }

        }
        if(!oppList.isEmpty())
        {
            update oppList;
        }
    }

    public static void afterUpdate(List<Top_X_Designation__c>  newList)
    {
        
        Opportunity[] oppL= new Opportunity[]{};
        for(Top_X_Designation__c tv:newList)
        {
            
                
            if(tv.Type__c=='Contract Flow Down' && tv.Document_Attached__c== True && tv.Opportunity__c!=null)
            {
                Opportunity opp=new Opportunity();
                opp.id=tv.Opportunity__c;
                opp.Handoff_Attached__c='Yes';
                oppL.add(opp);
            }
            else if(tv.Type__c=='Handoff' && tv.Document_Attached__c== True && tv.Opportunity__c!=null)
            {
                Opportunity opp=new Opportunity();
                opp.id=tv.Opportunity__c;
                opp.Handoff_Attached__c='Yes';
                oppL.add(opp);
            }
        }
        
        if(!oppL.isEmpty())
        {
            update oppL;
        }
    } 
    
    public static void afterDelete(List<Top_X_Designation__c> oldList)
    {
        Set<id> idsOpp= new Set<id>();
        List<Top_X_Designation__c> listTop= new List<Top_X_Designation__c>();
         List<Top_X_Designation__c> updateList= new List<Top_X_Designation__c>();
        
        for(Top_X_Designation__c tv:oldList)
        {
            if(tv.Opportunity__c!=null)
            {
                idsOpp.add(tv.Opportunity__c);
                listTop.add(tv);
            }
        }
        
        
        Map<id,Opportunity> oppRelated= new Map<id,Opportunity>([SELECT id FROM Opportunity WHERE id IN :idsOpp]);
        Map<id,Boolean> oppIdtoCheck= new Map<id,Boolean>();
        
        for(Top_X_Designation__c tv:listTop)
        {
            if(oppRelated.containskey(tv.Opportunity__c))
            {
                if(oppIdtoCheck.containskey(tv.Opportunity__c))
                {
                    
                }
            }
        }

        if(!updateList.isEmpty())
        {
            update updateList;
        }
        
    }
}