public class EmailTemplateServices {

    public EmailTemplate findTemplate(String name){
         try{
            List<EmailTemplate> results = [SELECT Id FROM EmailTemplate WHERE DeveloperName =:name AND IsActive = true];
            if(results.size() > 0){
                return results.get(0);
            }
        }catch(QueryException e){
            System.debug(e);
        }
        return null;
    }

}