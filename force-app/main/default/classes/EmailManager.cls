public class EmailManager {

     /**
     * Send mail confirm interview
     */
	public static Boolean sendConfirmInterview(String toAddress, String firstName) {
        String body = emailBody;
        body = body.replace('{NAME}', firstName);
        return sendMail(toAddress, 'Candidate Confirmation', body, true);
    }

    private static final String emailBody = '<html><body> <p>Dear {NAME}!</p><p>Thank you for joining our interview. We would like to invite you to join our company, please check our offer details in attachment file and send your confirmation about this.</p><p>Thank you for reading this mail.</p></body></html>';
    
    /**
     * Common send mail
     */
    private static Boolean sendMail(String to, String subject, String body, boolean isHtml){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {to};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        if(isHtml){
            mail.setHtmlBody(body);
        }else {
            mail.setPlainTextBody(body);
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        return inspectResults(results);
    }
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