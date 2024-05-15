public with sharing class deleteTask {
    @AuraEnabled
    
    public static void deleteTask(Id i) {

        Task t= new Task();
        t.Id=i;
        delete t;
    }
}