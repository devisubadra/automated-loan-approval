public class ErrorLogger {
    public static void logError(String message, String type) {
        Error_Log__c errorLog = new Error_Log__c();
        errorLog.Error_Message__c = message;
        errorLog.Error_Type__c = type;
        errorLog.Timestamp__c = System.now();
        insert errorLog;
    }
}
