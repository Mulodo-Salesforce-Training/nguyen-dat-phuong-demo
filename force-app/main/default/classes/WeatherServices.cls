public class WeatherServices {
    /**
     * Get lat, lng from address
     */
    public Map<String, Object> searchPlace(String address){
        HttpRequest req = new HttpRequest();
        String url = 'https://nominatim.openstreetmap.org/search?format=json&q='+address;
        req.setEndpoint(url);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res= http.send(req);
        string response = res.getBody();
        List<Map<String, Object>> parserResults = (List<Map<String, Object>>) JSON.deserializeUntyped(response);
        if(parserResults.size() > 0){
            return parserResults.get(0);
        }
        return null;
    }
    /**
     * Get weather from lat, lng
     */
    public Map<String, Object> searchWeather(double lat, double lng){
        HttpRequest req = new HttpRequest();
        String url = 'https://api.openweathermap.org/data/2.5/weather?appid=53bef0d54f0a5b823e659fdc7c21fa32&lat='+lat+'&lon='+lng;
        req.setEndpoint(url);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res= http.send(req);
        string response = res.getBody();
        return (Map<String, Object>) JSON.deserializeUntyped(response);
    }
}