public class getAccounts {
        @AuraEnabled
        public static List<Account> getAccountRecs()
        {
            return [SELECT name,Phone FROM Account WHERE name='aaaaa'];
        }
}