public class CandidateServices {

    public Candidate__c findSendMailConfirm(String id){
         try{
            List<Candidate__c> results = [SELECT Email__c, First_Name__c, Last_Name__c FROM Candidate__c WHERE Id =: id];
            if(results.size() > 0){
                return results.get(0);
            }
        }catch(QueryException e){
            System.debug(e);
        }
        return null;
    }
}