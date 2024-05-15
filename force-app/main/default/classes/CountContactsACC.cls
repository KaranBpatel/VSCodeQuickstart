public with sharing class CountContactsACC {
    public static void CountContactsACC() {
        Account[] acc= [SELECT id,(SELECT id,Name FROM CONTACTS) FROM ACCOUNT WHERE CreatedDate=LASt_WEEk];
        for(Account accounter:acc)
        {
            accounter.Total_Cons_Query__c=accounter.Contacts.size();
        }
        update acc;
        System.debug('Updated');
    }
}