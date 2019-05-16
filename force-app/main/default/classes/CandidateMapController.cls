public class CandidateMapController {

    public String address;

    public String candidateId;

    public CandidateMapController() {
        this.candidateId = ApexPages.currentPage().getParameters().get('candidate');
        this.candidateServices = new CandidateServices();
    }

    public String getAddress(){
        if (candidateId != null) {
            Candidate__c candidate = candidateServices.findCityById(candidateId);
            return candidate != null ? candidate.City__c : null;
        }
        return null;
    }

    private CandidateServices candidateServices;

}