/**
 * @description       : 
 * @author            : Parag
 * @group             : 
 * @last modified on  : 02-23-2021
 * @last modified by  : Parag
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   02-23-2021   Parag   Initial Version
**/
public inherited sharing class AccountInvocable {
   
    @InvocableMethod (label ='Update Primary Contact Detail' description='Update Primary Contact Detail' category='Account')
    public static List<Contact> updatePrimaryContacts(List<Id> accountIds){
    List<Account> accountList= [SELECT ID, Primary_Contact__c from Account where Id IN:accountIds];

    }
}
