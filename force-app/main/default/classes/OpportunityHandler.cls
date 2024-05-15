public class OpportunityHandler {
    
    public static void afterInsert(List<Opportunity> newList)
    {
        Set<id> accId= new Set<id>();
        List<Account> accUpdateList= new List<Account>();
        for(Opportunity opp:newList)//iterate all inserted records
        {
            if(opp.AccountId!=null)//check for related opportunity unito Account through Relatioship Lookip= AccountId
            {
                accId.add(opp.AccountId);//Add to set of Ids  (unique)
            }
        } 
       accUpdateList= calculateAnnualRevenue(accId);//perform calculate Annual revenue through method pass ids of Account which has related Opp
        // method Retutrn ACcount list assign to Account list
        
        if(!accUpdateList.isEmpty())
        {
            update accUpdateList;
        }
    }
    
    public static void afterUpdate(List<Opportunity> newList)
    {
        Account[] accListUpdate = new Account[]{};
        Set<id> Accids= new Set<id>();
            
        for(Opportunity ov:newList)
        {
            if(ov.AccountId!=null)
            {
                Accids.add(ov.AccountId);
            }
        }
        
        accListUpdate= calculateAnnualRevenue(Accids);
        
        if(!accListUpdate.isEmpty())
        {
            update accListUpdate;
        }
        
    }
     public static void afterDelete(List<Opportunity> newList)
    {
        Account[] accListUpdate = new Account[]{};
        Set<id> Accids= new Set<id>();
            
        for(Opportunity ov:newList)
        {
            if(ov.AccountId!=null)
            {
                Accids.add(ov.AccountId);
            }
        }
        
        accListUpdate= calculateAnnualRevenue(Accids);
        
        if(!accListUpdate.isEmpty())
        {
            update accListUpdate;
        }
        
    }
    
    public static List<Account> calculateAnnualRevenue(Set<id> accId)
    {
        List<Account> accListReturn= new List<Account>();
        Map<Id,Decimal> accIdToAnnualRevenue= new Map<Id,Decimal>();
        
        for(Opportunity ov:[SELECT id,Amount,AccountId FROM Opportunity WHERE AccountId!=null])//get Opportunity whose related with account with 
            //COndition AccountId!=null
        {
            Decimal total=0;//var for count amount
            if(accIdToAnnualRevenue.containskey(ov.AccountId))//in map if id is there so it has to addition with Amount ex=id=124 contains true
            {
                //total=3000
                total= accIdToAnnualRevenue.get(ov.AccountId);
                 
            }
            if(ov.Amount!=null)//If in map first time id came so it has to get Amount in total
                {
                   	total = total+ov.Amount;
                }
            accIdToAnnualRevenue.put(ov.AccountId,total);//put amount with it Account's Id<124,5000>
        }
        
        for(Id idv:accIdToAnnualRevenue.keyset())
        {
            Account acc= new Account();
            acc.Id=idv;
            acc.AnnualRevenue=accIdToAnnualRevenue.get(idv);
            accListReturn.add(acc);
        }
        
        return accListReturn;
    }

}