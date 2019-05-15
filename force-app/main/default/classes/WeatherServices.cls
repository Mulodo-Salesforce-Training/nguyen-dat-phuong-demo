public class WeatherServices {
   
    public ResultWeather searchWeather(String address){
        HttpRequest req = new HttpRequest();
        String url = 'https://api.openweathermap.org/data/2.5/weather?appid=0975979bdf806a4ff40bb1b5a9bde994&q=' + EncodingUtil.urlEncode(address, 'UTF-8');
        req.setEndpoint(url);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res= http.send(req);
        string response = res.getBody();
        try {
            return (ResultWeather)JSON.deserialize(response, ResultWeather.class);
        } catch (JSONException e) {
            
        }
        return null;
    }
}