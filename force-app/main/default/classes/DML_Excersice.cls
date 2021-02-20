public class DML_Excersice {
	
    public static void sObjectInsertForExcersice()
    {
        // Add account and related contact
        Account acct = new Account(
        Name='SFDC Computing',
        Phone='(415)555-1212',
        NumberOfEmployees=50,
        BillingCity='San Francisco');
        insert acct;
        // Once the account is inserted, the sObject will be 
        // populated with an ID.
        // Get this ID.
        ID acctID = acct.ID;
        // Add a contact to this account.
        Contact con = new Contact(
        FirstName='Carol',
        LastName='Ruiz',
        Phone='(415)555-1212',
        Department='Wingo',
        AccountId=acctID);
		insert con;
        // Add account with no contact
        Account acct2 = new Account(
        Name='The SFDC Query Man',
        Phone='(310)555-1213',
        NumberOfEmployees=50,
        BillingCity='Los Angeles',
        Description='Expert in wing technologies.');
		insert acct2;
    }
    
    public static void sObjectsInsert(){
        try{
            case store = new case();
            store.Product__c = 'GC1040';
            store.type = 'Other';
            store.origin = 'Email';
            store.status = 'New';
            insert store;
            system.debug('result inserted case'+store.Origin);
        }
        catch(exception ex){ system.debug('result'+ex); }
    }
    
    public static void sObjectsUpdate(){
        try{
            Contact contact = new Contact();
            //store.Name = 'The Tea Factory';
            contact.FirstName = 'ABC';
            contact.LastName = 'XYZ';
            contact.Salutation='Mr.';
            insert contact;
            system.debug('result inserted'+contact);
            
            if(contact.FirstName=='ABC' && contact.LastName=='XYZ')
                contact.Salutation='ms.';
            
            update contact;
        }
        catch(exception ex){ system.debug('result'+ex); }
    }
    
     public static void sObjectsUpsert(){
        try{
            Contact contact = new Contact();
            contact.FirstName = 'ABC';
            contact.LastName = 'XYZ';
            contact.Salutation='Mr.';
            insert contact;
            system.debug('result inserted'+contact);
            
            contact.Salutation='Ms.';
            
            Contact contact1 = new Contact();
            contact1.FirstName = 'ABC-01';
            contact1.LastName = 'XYZ-01';
            contact1.Salutation='Mr.';
            
            List<Contact> contacts = new List<Contact> { contact, contact1 };
                upsert contacts;
            
            system.debug('result upserted'+contact1);
            
        }
        catch(exception ex){ system.debug('result'+ex); }
     }
         
     public static void sObjectsUpsertByIdLookup(){
         try{
                Contact jane = new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='abc.xyz@example.com',
                         Description='Contact of the day');
             	insert jane;
                // 1. Upsert using an idLookup field
                // Create a second sObject variable.
                // This variable doesn’t have any ID set.
                Contact jane2 = new Contact(FirstName='ABC',
                                            LastName='XYZ',
                                            Email='abc.xyz@example.com',
                                            Description='Prefers to be contacted by email.');
                // Upsert the contact by using the idLookup field for matching.
                upsert jane2 Contact.fields.Email;
                // Verify that the contact has been updated
                System.assertEquals('Prefers to be contacted by email.',
                   [SELECT Description FROM Contact WHERE Id=:jane.Id].FirstName);
         }
         catch(exception ex){ system.debug('result'+ex); }
    }
    
    public static void sObjectsDMLException(){
        try{
            Contact jane = new Contact();
            insert jane;
        }
        catch(DmlException ex){ System.debug('A DML exception has occurred: ' + ex.getMessage()); }
    }
}