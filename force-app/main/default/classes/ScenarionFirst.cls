public with sharing class ScenarionFirst {
    public static void getAccountThisYear() {

            Account[] acc= [SELECT Id,Name FROM ACCOUNT WHERE CreatedDate=THIS_Year];
            System.Debug(acc);
            List<Opportunity> opptoAccList= new List<Opportunity>();

            if(acc.size()>0)
            {
                for(Account a:acc)
                {
                    Opportunity opptoAcc = new Opportunity();
                    opptoAcc.Name=a.Name;
                    opptoAcc.CloseDate=System.Today();
                    opptoAcc.StageName='Prospecting';
                    opptoAcc.AccountId=a.id;
                    opptoAccList.add(opptoAcc);
                }

            }
            if(opptoAccList.size()>0)
            {
                insert opptoAccList;
            }
    }
}