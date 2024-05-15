public  class getAccountRecs {
    @AuraEnabled
  
    public static List<Account> getAccountRecs() {

            return [SELECT Name,Id,Phone FROM Account WHERE Name='aaaaa'];

    }
}