public class EmailManager {

     /**
     * Send mail confirm interview
     */
	public static Boolean sendConfirmInterview(String email, String jobApplicationId) {
        if(String.isBlank(email) || String.isBlank(jobApplicationId)){
            System.debug('email or jobId empty');
            return false;
        }
        EmailTemplate template = emailTemplateServices.findTemplate(TEMPLATE_NAME_MAIL_INTERVIEW);
        if(template == null){
            System.debug('template empty');
            return false;
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(template.Id);
        mail.setWhatId(jobApplicationId);
        mail.setTreatTargetObjectAsRecipient(false);
        List<Contact> contacts = [select id, Email from Contact where email <> null limit 1];
        if(contacts.size() == 0){
            Contact contact = new Contact();
            contact.FirstName='Demo';
            contact.LastName='Email';
            contact.Email='dat.phuong@mulodo.com';
            insert contact;
            contacts.add(contact);
        }
        mail.setTargetObjectId(contacts.get(0).Id);
        mail.setSaveAsActivity(false);
        String[] toAddresses = new String[] { email };
        mail.setToAddresses(toAddresses);
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