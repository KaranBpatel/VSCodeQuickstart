public with sharing class UpdatePhone {
    public static void UpdatePhone() {
        Account[] acclastWeek= [SELECT id,Name,Phone FROM  Account WHERE CreatedDate=LAST_Week];
		System.debug(acclastWeek);
        for(Account acc:acclastWeek)
        {

            acc.phone='1234567890';
        }
        update acclastWeek;

    }
}