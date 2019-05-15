public class EmailManager {

     /**
     * Send mail confirm interview
     */
	public static Boolean sendConfirmInterview(Candidate__c candidate, Job_Application__c jobApplication) {
        EmailTemplate template = emailTemplateServices.findTemplate(TEMPLATE_NAME_MAIL_INTERVIEW);
        if(template == null){
            return false;
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(template.Id);
        mail.setWhatId(jobApplication.Id);
        mail.setTreatTargetObjectAsRecipient(false);
        mail.setTargetObjectId([SELECT Id FROM Contact WHERE Email <> null limit 1].Id);
        String[] toAddresses = new String[] { candidate.Email__c };
        mail.setToAddresses(toAddresses);
        System.debug(mail.getPlainTextBody());
        System.debug(mail.getHtmlBody());
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        return inspectResults(results);
    }

    private static EmailTemplateServices emailTemplateServices = new EmailTemplateServices();
    private static final String TEMPLATE_NAME_MAIL_INTERVIEW = 'Template_Confirm_Interview';
    //private static final String emailBody = '<html><body> <p>Dear {NAME}!</p><p>Thank you for joining our interview. We would like to invite you to join our company, please check our offer details in attachment file and send your confirmation about this.</p><p>Thank you for reading this mail.</p></body></html>';
    
    /**
     * Result send mail
     */
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }
        return sendResult;
    }
}