({
  getFullName: function (component, event, helper) {
    /*
             How to read attribute values from Javascript Controller's
             let variableName = component.get("v.AttributeNmae");
            */
    const firstName = component.get("v.FirstName");
    const lastName = component.get("v.LastName");
    const fullName = firstName + " " + lastName;
    /*
            How to set a Data to attribute
            component.set("v.attributeName",value);
           */
    component.set("v.FullName", fullName);
    helper.fireAppEvent(component, event, helper);
  },
  getUpdatableFullName: function (component, event, helper) {
    const firstName = component.getReference("v.FirstName");
    component.set("v.FullName", firstName);
    helper.fireAppEvent(component, event, helper);
  }
});