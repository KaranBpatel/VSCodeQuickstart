public with sharing class updateTask {
    @AuraEnabled
    
    public static String updateTask(Object tas) {

            System.debug('helo'+tas);
            List<Task> listTask= (List<Task>) JSON.deserialize( JSON.serialize(tas), List<Task>.class);

            System.debug(listTask);

            if(!listTask.isEmpty())
            {
                update listTask;
                return 'Success';
            }

            else{
               return 'Failure'; 
            }
        }
    }