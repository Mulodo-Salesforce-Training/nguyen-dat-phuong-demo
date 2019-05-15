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

     public Candidate__c findCityById(String id){
         try{
            List<Candidate__c> results = [SELECT City__c FROM Candidate__c WHERE Id =: id];
            if(results.size() > 0){
                return results.get(0);
            }
        }catch(QueryException e){
            System.debug(e);
        }
        return null;
    }

    public Attachment findAvatar(Id id){
        try {
            List<Attachment> results = [SELECT Id FROM Attachment WHERE ParentId =:id LIMIT 1];
             if(results.size() > 0){
                return results.get(0);
            }
        } catch (QueryException e) {
            System.debug(e);
        }
        return null;
    }
}