Public with sharing class UpdateRecords{
    public static void updateContact(){
       
       // List<Contact> contoUpdate = [SELECT Title,Name FROM Contact];
        //Contact contoUpsert = new Contact();    
        List<Contact> contoDelete = [SELECT Title,Name FROM Contact WHERE Title='Lumex'];

       /* for(Contact cn : contoUpdate)
        {
            if(cn.Title=='Sales')
            {
                cn.Title='Tanvi';
                updsert contoUpdate;
               // contoUpdate.add(cn);
            }
            
        } */
       // ContoUpsert.Name='TAnvi Patel';
        //contoUpsert.Title='MAhindra';
        delete contoDelete;

        
        System.debug('Updated');
    }
}