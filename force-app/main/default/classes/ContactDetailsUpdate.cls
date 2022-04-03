public class ContactDetailsUpdate {
    
	@InvocableMethod(label='Update Contact details')
    public static List<Contact> updateContactDetails(List<Contact> contactList){
        
        contactList[0].put('Description', 'This description is updatd from Apex method called from Flow');
        return contactList;
        
    }
}