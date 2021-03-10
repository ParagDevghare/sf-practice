({
    fireAppEvent : function(component , event , helper) {
        let appEvent = $A.get("e.c:LtngTipsAndTricksAppEvent");
        appEvent.setParams({
            firstName : component.get("v.FirstName"),
            lastName : component.get("v.LastName")
        });
        appEvent.fire();
    }
})