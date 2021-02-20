public class AccountHandler {
	//public static Account insertNewAccount(string AccountName)
	public static void insertNewAccount(string AccountName)
    {
        try{
            Account store = new Account();
            store.Name = AccountName;
            insert store;
                        
            //return store;
        }
        catch(DmlException ex)
        { 
            System.debug('A DML exception has occurred: ' + ex.getMessage());
            //return null;
        }
    }
}