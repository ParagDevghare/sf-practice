//@isTest
public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numContact, string LatNameContact) {
        List<Contact> accts = new List<Contact>();
        
        for(Integer i=0;i<numContact;i++) {
            
            Contact c = new Contact(
            FirstName = 'TestContact'+i,
            LastName = LatNameContact
            );
            
            accts.add(c);
        }
        //insert accts;
        
        return accts;
    }
}