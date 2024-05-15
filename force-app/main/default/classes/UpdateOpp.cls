public with sharing class UpdateOpp {
    public static void UpdateOpp() {

        Opportunity[] opp = [SELECT id,Name,StageName FROM Opportunity WHERE CreatedDate=LAST_Week];
        System.debug(opp);
        for(Opportunity ot:opp)
        {
            if(ot.StageName=='Closed Won')
            {
                ot.Description='Opportunity is Closed won.';
                update opp;
            }
            else if(ot.StageName=='Closed Lost')
            {
                ot.Description='Opportunity is Closed Lost';
                update opp;
            }
        }

    }
}