public class JobApplicationTriggerHandler {

    public JobApplicationTriggerHandler(CandidateServices candidateServices){
        this.candidateServices = candidateServices;
    }

    public void afterInsert(Map<Id, Job_Application__c> newMap){
         //Send mail confirm to candidate
         for (Job_Application__c jobApplication: newMap.values()) {
                try{
                    Candidate__c candidate = candidateServices.findSendMailConfirm(jobApplication.Candidate__c);
                    if(candidate != null){
                        EmailManager.sendConfirmInterview(candidate, jobApplication);
                    }
                }catch(System.EmailException e){
                    System.debug(e);
                }
      		}  
    }
    

    private CandidateServices candidateServices;
}