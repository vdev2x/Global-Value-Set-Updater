@isTest
public class Util_GlobalValueSetUpdater_Test implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();

        if (req.getMethod() == 'GET') {
            res.setStatusCode(200);
            res.setBody('{"records":[{"attributes":{"url":"/services/data/v61.0/tooling/sobjects/GlobalValueSet/01xxxxxx"},"FullName":"Test_GlobalValueSet","Metadata":{"masterLabel":"Test Label","customValue":[]}}]}');
        } else if (req.getMethod() == 'PATCH') {
            res.setStatusCode(204);
        } else {
            res.setStatusCode(400);
            res.setBody('{"error":"Bad Request"}');
        }
        
        return res;
    }
    
    @isTest
    public static void testUpdateGlobalValueSet() {
        String developerName = 'Test_GlobalValueSet';
        Map<String, String> apiNameLabelMap = new Map<String, String>{
            'Test_Value1' => 'Test Label 1',
            'Test_Value2' => 'Test Label 2'
        };
        
        Test.setMock(HttpCalloutMock.class, new Util_GlobalValueSetUpdater_Test());

        Test.startTest();

        Util_GlobalValueSetUpdater.updateGlobalValueSet(developerName, apiNameLabelMap);

        Test.stopTest();
    }

    @isTest
    public static void testUpdateGlobalValueSetWithVersion() {
        String developerName = 'Test_GlobalValueSet';
        Map<String, String> apiNameLabelMap = new Map<String, String>{
            'Test_Value1' => 'Test Label 1',
            'Test_Value2' => 'Test Label 2'
        };
        String apiVersion = 'v57.0';

        Test.setMock(HttpCalloutMock.class, new Util_GlobalValueSetUpdater_Test());

        Test.startTest();

        Util_GlobalValueSetUpdater.updateGlobalValueSet(developerName, apiNameLabelMap, apiVersion);

        Test.stopTest();
    }
}