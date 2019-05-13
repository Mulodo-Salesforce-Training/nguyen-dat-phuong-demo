trigger JobApplicationTrigger on Job_Application__c (before insert, after insert) {
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            //Send mail confirm to candidate
             for (Job_Application__c jobApplication: Trigger.newMap.values()) {
                try{
                    CandidateServices candidateServices = new CandidateServices();
                    String id = jobApplication.Candidate__c;
                    Candidate__c candidate = candidateServices.findSendMailConfirm(id);
                    if(candidate != null){
                        EmailManager.sendConfirmInterview(candidate.Email__c, (candidate.First_Name__c +' '+ candidate.Last_Name__c));
                    }
                }catch(System.EmailException e){
                    System.debug(e);
                }
      		}  
        }
    }
}