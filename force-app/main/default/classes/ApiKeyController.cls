public with sharing class ApiKeyController {
    @AuraEnabled
    public static Boolean authenticateApiKey(String apiKey) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            request.setEndpoint('https://0eb6-103-186-18-196.ngrok-free.app/api/integration/salesforce/auth');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + apiKey);

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Parse response and determine if the API key is valid
                Map<String, Object> res = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                return res.containsKey('valid') && (Boolean) res.get('valid');
            } else {
                return false;
            }
        } catch (Exception e) {
            System.debug('Error while verifying API key: ' + e.getMessage());
            return false;
        }
    }
}
