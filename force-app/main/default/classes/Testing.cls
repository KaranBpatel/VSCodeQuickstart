public class Testing {

    public static void test(){
    Map<id,Account> idToAcc= new Map<id,Account>([SELECT Active__c FROM Account WHERE Name='aaaaa']);
    
    System.debug(idToAcc);
    }
}