public with sharing class FlexipageDemo {
    @AuraEnabled
    public static contact insertContact(string parentAccountId,string firstName1,string lastName1)
    {
        try {
            contact con=new contact();
            con.firstName=firstName1;
            con.lastName=lastName1;
            con.accountid=parentAccountId;
            insert con;
            return con;
        } 
        catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
        }
    }
}