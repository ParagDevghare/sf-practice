({
    handleAppEvent : function(component, event, helper) {
        let appDataFirstName =  event.getParam("firstName");
        let appDataLastName =  event.getParam("lastName");
        console.log("First Name : "+appDataFirstName);
        console.log("Last Name : "+appDataLastName);
        component.set("v.firstNameP",appDataFirstName);
        component.set("v.lastNameP",appDataLastName);
    },
    handleCmpEvent : function(component, event, helper){
        let payloadString = event.getParam("jsonPayload");
        let payloadObject = JSON.parse(payloadString);
        if(payloadObject.componentName === "ChildComponent" && payloadObject.action === "Update Names"){
            let fName = payloadObject.firstName;
            let lName = payloadObject.lastName;
            component.set("v.firstNameP",fName);
            component.set("v.lastNameP",lName);
            let childComponent = component.find("childcmpauraId");
            childComponent.saveSucess();
            alert("data Updated with :"+fName+' '+lName);
        }
    }
})