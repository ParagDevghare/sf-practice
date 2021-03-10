({
    doInitHandler : function(component, event, helper) {
        const startIndex = component.get("v.startIndex");
        const componentName = "c:"+component.get("v.componentList")[0];
        alert("componentName : "+componentName);
        let params = this.setParams(component, event, helper);
        $A.createComponent(componentName ,params , function(newComponent , status , errorMessage){
            if(status === "SUCCESS"){
                let body = component.get("v.body");
                body.push(newComponent);
                component.set("v.body",body);
            }
            else {
                alert ("Craete CMP ERROR : "+JSON.stringify(errorMessage));
            }
        });
    },
    setParams : function(component, event, helper){
        return {
            "sObjectName" : component.getReference("v.sObjectName"),
            "sObjectId" : component.getReference("v.sObjectId"),
            "componentList" : component.getReference("v.componentList"),
            "currentPageIndex" : component.getReference("v.currentPageIndex"),
            "startIndex" : component.getReference("v.startIndex"),
            "actionName" : component.getReference("v.actionName"),
        };
    }
})