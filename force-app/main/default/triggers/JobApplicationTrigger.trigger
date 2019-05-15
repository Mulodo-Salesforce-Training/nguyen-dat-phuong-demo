trigger JobApplicationTrigger on Job_Application__c (before insert, after insert) {
    CandidateServices candidateServices = new CandidateServices();
    JobApplicationTriggerHandler jobApplicationTriggerHandler = new JobApplicationTriggerHandler(candidateServices);
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            jobApplicationTriggerHandler.afterInsert(Trigger.newMap);
        }
    }
}