public with sharing class getTask {
    @AuraEnabled(cacheable=true)
    
    public static List<Task> getTask() {

        return [SELECT Subject,Priority,id FROM TASK];
    }

    public static void updateTask(sObject tas)
    {
        update tas;
    }
}