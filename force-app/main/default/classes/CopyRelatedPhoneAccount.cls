public class CopyRelatedPhoneAccount {
    public static void CopyPhone()
    {
        Contact[] cons= [SELECT id,AccountId,Phone,Account.Phone FROM Contact WHERE AccountId!=null];
        if(!cons.isEmpty())
        {
            for(Contact conv:cons)
            {
                
                if(conv.phone==null || conv.phone=='')
                {
                    conv.phone=conv.Account.phone;
                }
                
            }
            
        }
        if(!cons.isEmpty())
        {
            update cons;
            System.debug('Updated Phone Number');
        }
    }

}