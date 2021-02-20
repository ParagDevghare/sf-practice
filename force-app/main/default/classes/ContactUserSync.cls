/**
 * @description       : 
 * @author            : Parag
 * @group             : 
 * @last modified on  : 02-13-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   02-13-2021   Parag   Initial Version
**/
public class ContactUserSync {
      /*
      * Create after update function for contact obj
      * retrive user ID for that contact's email using foreach loop
      * select User obj and update the details for that user as per Contact
      */

   public void updateUserDetails(Map<Id, Contact> newContactMap, Map<Id, Contact> oldContactMap){

      /**
       * Get Emails from Contact When there is a Change in First Name and last Name of Contact Update
       * Assign a Collective map of <Email,Contact> 
       * Get Users based on the Emails that we had from contact<Email,Contact> keyset()
       * Iterate the Forloop to update users based on contact --> Update userinformation from the Retrived users by passing email as a key to contact map
       */
      Map<String,Contact> email_Contact = new Map<String,Contact>();
       for(Contact conn: newContactMap.values())
       {
            Contact oldContact = oldContactMap.get(conn.Id);

            Boolean isFirstName = conn.FirstName != oldContact.FirstName ? true : false;
            Boolean isLastName = conn.LastName != oldContact.LastName ? true : false;
            Boolean isChanged = conn.Email != null ? isFirstName || isLastName : false;

            if(isChanged ){
               email_Contact.put(conn.Email,conn);
            }
       }

       if(email_Contact != null && email_Contact.keyset().size() > 0 ){
         Map <Id, User> userMap= new Map <Id, User>([select id, Firstname, LastName,Email from user where Email in:email_Contact.keyset()]);
         for(User record : userMap.values()){
           // Contact relatedDetail = email_Contact.get(record.Email) != null ? email_Contact.get(record.Email) : null;
            Contact relateDetail = email_Contact.keyset().contains(record.Email) ? email_Contact.get(record.Email) : null ;
            record.FirstName = relateDetail.FirstName;
            record.LastName = relateDetail.LastName;
         }

         Update userMap.values();

       }
      
    }
}