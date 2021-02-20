/**
 * @description       : 
 * @author            : i.lakshmideepak@gmail.com
 * @group             : 
 * @last modified on  : 02-13-2021
 * @last modified by  : i.lakshmideepak@gmail.com
 * Modifications Log 
 * Ver   Date         Author                      Modification
 * 1.0   02-12-2021   i.lakshmideepak@gmail.com   Initial Version
**/


public inherited sharing class OpportunityTrigger {
    
 public static void beforeInsert(List<Opportunity> newOpportunities){
        for (Opportunity record: newOpportunities){
            record.addError('FORMULA VALUE '+record.Discount_Ammount__c);
        }
 }
    public static void afterInsert(Map<Id, Opportunity> newOpportunities){
        List<Opportunity> records = new List<Opportunity>();
            for(Opportunity record : newOpportunities.values()){
                Opportunity opp = new Opportunity();
                opp.Id = record.Id;
                opp.Salesforce_ID_External__c  = record.Id ;
                opp.Description = record.Name;
                records.add(opp);
            }
            upsert records Salesforce_ID_External__c;
    }
}