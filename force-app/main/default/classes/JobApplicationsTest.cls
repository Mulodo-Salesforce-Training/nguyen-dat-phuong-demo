@isTest public class JobApplicationsTest {

    @isTest static void testSendMailConfirmInterviewSuccess(){
        Test.startTest();
        Boolean result = EmailManager.sendConfirmInterview('nguyendatphuong0710@gmail.com', 'a090K000019fgf0');
        Test.stopTest();
        System.assertEquals(true, result, 'Send mail success');
    }

     @isTest static void testSendMailConfirmInterviewFailed(){
        Test.startTest();
        Boolean result = EmailManager.sendConfirmInterview(null, null);
        Test.stopTest();
        System.assertEquals(false, result, 'Send mail failed!');
    }
}