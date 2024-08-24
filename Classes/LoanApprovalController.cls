public class LoanApprovalController {
    public String applicantId { get; set; }
    public Decimal loanAmount { get; set; }
    public String approvalStatus { get; set; }
    public String errorMessage { get; set; }
    
    public void processLoanApproval() {
        try {
            Map<String, String> config = APIConfigService.getAPIConfig();
            String endpoint = config.get('endpoint');
            String apiKey = config.get('apiKey');
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer ' + apiKey);
            req.setBody('{"applicantId": "' + applicantId + '", "loanAmount": ' + loanAmount + '}');
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            if (res.getStatusCode() == 200) {
                Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                Decimal creditScore = (Decimal) responseBody.get('creditScore');
                
                if (creditScore > 700) {
                    approvalStatus = 'Approved';
                } else {
                    approvalStatus = 'Denied';
                }
            } else {
                approvalStatus = 'Error';
                errorMessage = 'HTTP Error: ' + res.getStatusCode() + ' - ' + res.getStatus();
                ErrorLogger.logError(errorMessage, 'API Error');
            }
        } catch (Exception e) {
            approvalStatus = 'Exception';
            errorMessage = 'Exception: ' + e.getMessage();
            ErrorLogger.logError(errorMessage, 'System Error');
        }
    }
}
