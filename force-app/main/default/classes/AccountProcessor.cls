public class AccountProcessor 
{
  @future
  public static void countContacts(List<id> accountList) 
  {
      List<Account> lstAccount = [select id,Number_of_Contacts__c , (select id from contacts ) from account where id in :accountList ];
      for( Account acc : lstAccount )
      {
          List<Contact> contactList = acc.contacts ;
          
          acc.Number_of_Contacts__c = contactList.size();
      }
      update lstAccount;
  }
}