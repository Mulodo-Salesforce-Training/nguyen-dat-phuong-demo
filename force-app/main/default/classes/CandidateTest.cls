@isTest public class CandidateTest {
    @IsTest
    static void testServiceFindEmail(){
        
        Test.startTest();
        Candidate__c candidate = new Candidate__c();
        candidate.Email__c = 'nguyendatphuong0710@gmail.com';
        candidate.First_Name__c = 'Nguyen';
        candidate.Last_Name__c = 'Phuong';
        candidate.Phone__c = '0336733682';
        candidate.City__c = 'Thanh Pho Ho Chi Minh';
        insert candidate;
        CandidateServices candidateSer2vices = new CandidateServices();
        Candidate__c candidateResultEmail = candidateServices.findSendMailConfirm(candidate.Id);
        System.assertEquals('nguyendatphuong0710@gmail.com', candidateResultEmail.Email__c);
        Candidate__c candidateResultCity = candidateServices.findCityById(candidate.Id);
        System.assertEquals('Thanh Pho Ho Chi Minh', candidateResultCity.City__c);

        Candidate__c candidateResultCity1 = candidateServices.findCityById('a070K00000oAvVt');
        System.assertEquals(null, candidateResultCity1);

        Attachment attachment = candidateServices.findAvatar(candidate.Id);
        System.assertEquals(null, attachment);
        Test.stopTest();
    }
}