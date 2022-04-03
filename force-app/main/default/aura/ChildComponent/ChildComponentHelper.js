({
    fireComponentEvent: function (component, event, helper) {
        //debugger;
        let fName = component.find("firstName").get("v.value");
        let lName = component.find("lastName").get("v.value");
        let payloadData = {
            componentName: "ChildComponent",
            action: "Update Names",
            firstName: fName,
            lastName: lName
        };
        let payloadDataString = JSON.stringify(payloadData);

        //Fire the Component Event
        let cmpRegisterName = component.getEvent("childToParent");
        cmpRegisterName.setParams({
            jsonPayload: payloadDataString
        });
        cmpRegisterName.fire();
        //debugger;
    }
})