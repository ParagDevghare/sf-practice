public class ContactSearch {
	public static Contact[] searchForContacts(string LastName, string MailingPostalCode)
    {
        Contact[] cts = [SELECT Account.Name FROM Contact 
                 WHERE FirstName = 'Carol' AND LastName='Ruiz'];
        
        return cts;
    }
}