public class updateOpportunity {
    
    public static List<Opportunity> updateOpportunity(List<Account> newList)
    {
        Account[] accList = new List<Account>();
        
        Set<id> accIds= new Set<id>();
        
        for(Account av:newList)
        {
            accIds.add(av.id);
        }
        
        Opportunity[] relOpps= [SELECT Name,createdDate,StageName,AccountId,CreatedById FROM Opportunity WHERE AccountId IN :accIds];
        
        Opportunity[] updateList= new List<Opportunity>();
        
        for(Opportunity ov:relOpps)
        {
            if(ov.StageName!='Closed Won')
            {
                Integer noOfDays = ((ov.createdDate).date()).daysBetween(System.today());
				System.debug(noOfDays);
               
                if(noOfDays>30)
                {
                    System.debug('Update');
                    Opportunity ovup= new Opportunity();
                    ovup.id=ov.id;
                    ovup.StageName='Closed Lost';
                    updateList.add(ovup);
                }      
            }
        }
        
        if(!updateList.isEmpty())
        {
            update updateList;
        }
        
      
        return updateList;
    }

    
}