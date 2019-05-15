public class CandidateWeatherController {

    public String candidateId;

    public String getCandidateId() {
        return this.candidateId;
    }

    public CandidateWeatherController() {
        this.candidateId = ApexPages.currentPage().getParameters().get('candidate');
        this.candidateServices = new CandidateServices();
        this.weatherServices = new WeatherServices();
    }

    public ResultWeather getWeather() {
        if (candidateId != null) {
            Candidate__c candidate = candidateServices.findCityById(candidateId);
            if (candidate != null && candidate.City__c != null) {
                ResultWeather weather = weatherServices.searchWeather(candidate.City__c);
                return weather;
            }
        }
        return null;
    }
    private CandidateServices candidateServices;
    private WeatherServices weatherServices;
}