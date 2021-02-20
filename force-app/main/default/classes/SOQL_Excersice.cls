public class SOQL_Excersice {
	public static void runSOQLFirst()
    {
            Account[] accts = [SELECT Name,Phone FROM Account 
                       WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
                       ORDER BY Name
                       LIMIT 10];
        System.debug(accts.size() + ' account(s) returned.');
        // Write all account array info
        System.debug(accts);
        
        
        Account[] acctsWithContacts = [SELECT Name, (SELECT FirstName,LastName FROM Contacts)
                               FROM Account 
                               WHERE Name = 'SFDC Computing'];
            // Get child records
            Contact[] cts = acctsWithContacts[0].Contacts;
            System.debug('Name of first associated contact: ' 
             + cts[0].FirstName + ', ' + cts[0].LastName);
        
        	insert new Account[]{new Account(Name = 'for loop 1'), 
                     new Account(Name = 'for loop 2'), 
                     new Account(Name = 'for loop 3')};
            // The sObject list format executes the for loop once per returned batch
            // of records
            Integer i=0;
            Integer j=0;
            for (Account[] tmp : [SELECT Id FROM Account WHERE Name LIKE 'for loop _']) {
                j = tmp.size();
                i++;
                
                System.debug('Value of i here: ' +i+'Value of j here: '+j);//added For testing
            }
            System.assertEquals(3, j); // The list should have contained the three accounts
                           // named 'yyy'
            System.assertEquals(1, i); // Since a single batch can hold up to 200 records and,
                                   // only three records should have been returned, the 
                                   // loop should have executed only once
    }
}