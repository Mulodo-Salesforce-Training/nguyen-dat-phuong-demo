trigger PositionTrigger on Position__c (before insert, before update) {
    PositionServices positionServices = new PositionServices();
    PositionTriggerHandler positionTriggerHandler = new PositionTriggerHandler(positionServices);
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            positionTriggerHandler.beforeInsert(Trigger.new);
        }
    }
    else if(Trigger.isUpdate) {
        if (Trigger.isBefore) {
            positionTriggerHandler.beforeUpdate(Trigger.new, Trigger.old);
        }
    }
}