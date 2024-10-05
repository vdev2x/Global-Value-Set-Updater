public class Util_GlobalValueSetUpdater {
    public static void updateGlobalValueSet(String developerName, Map<String, String> apiNameLabelMap) {
        updateGlobalValueSet(developerName, apiNameLabelMap, 'v61.0');
    }
    
    public static void updateGlobalValueSet(String developerName, Map<String, String> apiNameLabelMap, String apiVersion) {
        if(apiNameLabelMap.keySet().size() > 0) {
            Util_GlobalValueSetUpdater_Wrapper gvs = getGlobalValueSet(developerName, apiVersion);
            setGlobalValueSet(gvs, apiNameLabelMap);
        }
    }
    
    private static Util_GlobalValueSetUpdater_Wrapper getGlobalValueSet(String developerName, String apiVersion) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + '/services/data/' + apiVersion + '/tooling/query?q=SELECT+Id,MasterLabel,Description,FullName,Metadata+FROM+GlobalValueSet+WHERE+DeveloperName=\'' + developerName + '\'');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() != 200) {
            throw new NoAccessException();
        }
        
        Util_GlobalValueSetUpdater_Wrapper gvs = Util_GlobalValueSetUpdater_Wrapper.parse(response.getBody());
        
        if(gvs.records == NULL) {
            throw new NoDataFoundException();
        }
        
        return gvs;
    }
    
    private static void setGlobalValueSet(Util_GlobalValueSetUpdater_Wrapper gvs, Map<String, String> apiNameLabelMap) {
        Util_GlobalValueSetUpdater_Wrapper.patch_body reqBody = new Util_GlobalValueSetUpdater_Wrapper.patch_body();
        reqBody.FullName = gvs.records[0].FullName + '__gvs';
        reqBody.Metadata = new Util_GlobalValueSetUpdater_Wrapper.cls_Metadata();
        reqBody.Metadata.masterLabel = gvs.records[0].Metadata.masterLabel;
        reqBody.Metadata.customValue = new List<Util_GlobalValueSetUpdater_Wrapper.cls_customValue>();
        for(String key: apiNameLabelMap.keySet()) {
            Util_GlobalValueSetUpdater_Wrapper.cls_customValue newVal = new Util_GlobalValueSetUpdater_Wrapper.cls_customValue();
            newVal.label = apiNameLabelMap.get(key);
            newVal.valueName = key;
            reqBody.Metadata.customValue.add(newVal);
        }
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + gvs.records[0].attributes.url);
        request.setMethod('PATCH');
        request.setBody(JSON.serialize(reqBody));
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() != 204) {
            System.debug(response.getBody());
            throw new HandledException('Something went wrong. Check debug logs');
        }
    }
}