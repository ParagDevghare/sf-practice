public with sharing class AccountUpdate {
    
    public static void beforeInsert(List<Account> accountList)
    {
        for(Account record : accountList)
        {
            if(record.Phone == null)
            {
                record.Phone.addError('Please add Phone Number to save Account.');
                record.ph.addError('Please add Phone Number to save Account.');
            }

        }
    }

}
