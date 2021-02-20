/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-12-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   02-12-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger OpportunityTrigger on Opportunity (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityTrigger.afterInsert(Trigger.newMap); 
    }
    
}