public class MapExample {
    public static void MapLearn()
    {
        Account[] accList= [SELECT id,phone FROM Account WHERE createdDate=LAST_WEEK AND Phone!=null];
        Map<id,Account> accIdtoMap= new map<id,Account>(accList);
        
        Contact[] conlist= [SELECT id,phone,AccountId FROM Contact WHERE AccountId IN :accIdtoMap.keyset()];
        Contact[] toUpdated= new Contact[]{};
        if(!conlist.isEmpty()){
        for(Contact conv:conlist)
        {
            if((accIdtoMap).containsKey(conv.AccountId))
            {
                Contact cont= new Contact();
                cont.phone=accIdtoMap.get(conv.AccountId).phone;//Get phone number from Account Map
                cont.id=conv.id;
                toUpdated.add(cont);
            }
        }
        }
        if(!toUpdated.isEmpty())
        {
            update toUpdated;
        }
    }
}