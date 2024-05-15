public class ParentToChild {
    //Static Integer a;
    public static void updatePho()
    {
        Account[] accots= [SELECT id,phone,(SELECT id,Phone FROM Contacts) FROM Account WHERE CreatedDate=LAST_WEEK];
        Contact[] conList= new List<Contact>();
        if(!accots.isEmpty())
        {
            
            for(Account acc:accots)
            {
                if(acc.phone!=null)
                {
                for(Contact con:acc.Contacts)
                {
                    Contact newCon= new Contact();
                    //newcon.LastName='Jay';
                    newcon.id=con.id;
                    newcon.phone=acc.phone;
                    conList.add(newcon);
                }
            }
            }
        }
        if(!conList.isEmpty()){
           update conList;
        }
    }

}