public class getRelatedRecords 
{
	public static void getContactRecords()
	{
        Account[] accts= [SELECT Name,(SELECT FirstName,LastName FROM Contacts ) FROM Account WHERE Name='Renil'];
        Contact[] cons= accts[0].Contacts;
        System.debug('Name of asscociated contacts FirstName'+cons[0].FirstName+'LastName'+cons[0].LastName);  
    }

}