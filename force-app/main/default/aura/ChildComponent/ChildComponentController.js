({
    UpdateNameFields : function(component, event, helper) {
        component.set("v.isUpdate",true);
    },
    saveNameFields : function(component, event, helper) {
        helper.fireComponentEvent(component, event, helper);
    },
    cancelNameFields : function(component, event, helper) {
        component.set("v.isUpdate",false);
    },
})