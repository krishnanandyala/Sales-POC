global class batchgetSforg implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {  
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        String Query = 'SELECT Address,City,ComplianceBccEmail,Country,CreatedById,CreatedDate,DefaultAccountAccess,DefaultCalendarAccess,DefaultCampaignAccess,DefaultCaseAccess,DefaultContactAccess,DefaultLeadAccess,DefaultLocaleSidKey,DefaultOpportunityAccess,DefaultPricebookAccess,Division,Fax,FiscalYearStartMonth,GeocodeAccuracy,Id,InstanceName,IsReadOnly,IsSandbox,LanguageLocaleKey,LastModifiedById,LastModifiedDate,Latitude,Longitude,MonthlyPageViewsEntitlement,MonthlyPageViewsUsed,Name,NamespacePrefix,OrganizationType,Phone,PostalCode,PrimaryContact,ReceivesAdminInfoEmails,ReceivesInfoEmails,SignupCountryIsoCode,State,Street,SystemModstamp,TrialExpirationDate,UiSkin,UsesStartDateAsFiscalYearName,WebToCaseDefaultOrigin FROM Organization';
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext BC,List<Organization> scope){
        

        
        //OrgPulse__OrgPulseCredentials__mdt creds = [SELECT MasterLabel, QualifiedApiName, OrgPulse__clientId__c, OrgPulse__Client_Secret__c, OrgPulse__password__c, OrgPulse__token__c, OrgPulse__username__c From OrgPulse__OrgPulseCredentials__mdt WHERE QualifiedApiName = 'OrgPulse__Hub_Org_Credentials'][0];

        String clientId = '3MVG9zeKbAVObYjOvPni08Fvj2a.fKxwzkwIan1.SPQ.koZkNY7CrsdODiMzKo4rIr0LyGPXtG8HeaUGyqJLA';
        String clientSecret = '3020268111442079217';
        String username = 'lucas.hearn@optum.garage'; 
        string password = 'Optum123!N7xmCMQiqJDIbvsJ9t2CYjdIJ';
        
        
        /*OrgPulse__HubOrgCredential__mdt creds = [SELECT QualifiedApiName, OrgPulse__clientId__c, OrgPulse__clientSecret__c, OrgPulse__password__c, OrgPulse__token__c, OrgPulse__username__c FROM OrgPulse__HubOrgCredential__mdt WHERE QualifiedApiName = :'OrgPulse__Optum_Hub_Credentials'];
        String clientId = creds.OrgPulse__clientId__c;
        String clientSecret = creds.OrgPulse__clientSecret__c;
        String username = creds.OrgPulse__username__c; 
        string password = creds.OrgPulse__password__c + creds.OrgPulse__token__c;
        Boolean contactExists = False;*/

		
        Integer activeuser =[SELECT count() FROM User where isactive=true];// number of active users
        Integer loginusr =[SELECT count() FROM AuthSession where iscurrent=true]; // login users  

        
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        
        
        HttpResponse res;
        if (!Test.isRUnningTest()){
            res = h.send(req);
        }
        OAuth2 objAuthenticationInfo = Test.isRunningTest() ? new OAuth2('Test_Access', 'www.test.com') :(OAuth2)JSON.deserialize(res.getbody(), OAuth2.class); 
        
        
        for(Organization org : scope) {          
            if(objAuthenticationInfo.access_token!=null || test.isRunningTest()){
                Http h1 = new Http();
                HttpRequest req1 = new HttpRequest();
                req1.setHeader('Authorization','Bearer '+ objAuthenticationInfo.access_token);
                req1.setHeader('Content-Type','application/json');
                req1.setHeader('accept','application/json');            
                
                
                
                String jsonstr= ' {"loginusr": "'+loginusr+'" ,"activeuser" : "'+activeuser+'"}' ;                
                List<installedApplication> appList = PackageNamespace.getAppInfo();
                CountLines lines = new Countlines();
                htmlRegEx scrapedInfo = new htmlRegEx();
                System.debug(scrapedInfo);
                List<AggregateResult> userList = [SELECT COUNT(id) licenseCount, profile.usertype, isactive 
                       							  FROM user 
                       							  GROUP BY profile.usertype, isactive 
                       							  ORDER BY profile.usertype, isactive];
                List<licenseWrapper> licenseList = licenseWrapper.licenseList(userList);       							  
                Organization thisOrg = [SELECT Id, Phone, InstanceName, Name, OrganizationType, PrimaryContact FROM Organization Limit 1][0];
                orgClass newOrgObj = new orgClass(thisOrg);
                String licenseListJsonStr = JSON.serialize(licenseList);
                String scrapedInfoJsonStr = JSON.serialize(scrapedInfo);
                System.debug(scrapedInfoJsonStr);
                String linesJsonStr = JSON.serialize(lines);
                String appListJsonStr = JSON.serialize(appList); 
                String orgJsonStr = JSON.serialize(newOrgObj);  
                jsonstr = jsonstr.substring(0,jsonstr.length()-1);
                jsonstr = jsonstr + 
                		', "appList": ' + appListJsonStr + 
                		', "lines": ' +linesJsonStr + 
                		', "scrapedInfo": ' + scrapedInfoJsonStr + 
                		', "orgInfo": '  + orgJsonStr + 
                		', "licenseList": '  + licenseListJsonStr + '}';
     
				//jsonstr = '{"loginusr": "3" ,"activeuser" : "14", "appList": [], "lines": {"triggerLines":454,"classLines":1348}, "scrapedInfo": {"usedFileSpaceUnit":"MB","usedFileSpaceNum":23,"usedFilePercent":5,"usedDataSpaceUnit":"MB","usedDataSpaceNum":12,"usedDataPercent":11,"proSndbxInUse":0,"proSndbxAvailable":3,"partialSndbxInUse":1,"partialSndbxAvailable":1,"fullSndbxInUse":1,"fullSndbxAvailable":1,"devSndbxInUse":12,"devSndbxAvailable":81}, "orgInfo": {"primaryLastName":"Hearn","primaryFirstName":"Lucas","phone":null,"orgName":"OrgPulse Dev Org","orgId":"00D41000002GQeR","organizationType":"Development Org","instanceName":"NA08"}, "licenseList": [{"licenseType":"Standard","licenseCount":1,"isActive":false},{"licenseType":"Standard","licenseCount":1,"isActive":true},{"licenseType":"Guest","licenseCount":0,"isActive":true},{"licenseType":"Guest","licenseCount":2,"isActive":false},{"licenseType":"CspLitePortal","licenseCount":1,"isActive":true},{"licenseType":"CspLitePortal","licenseCount":4,"isActive":false},{"licenseType":"CsnOnly","licenseCount":2,"isActive":true},{"licenseType":"CsnOnly","licenseCount":2,"isActive":false}]}';
                req1.setBody(jsonstr);//Send JSON body
                req1.setMethod('POST');          
                req1.setEndpoint(objAuthenticationInfo.instance_url+'/services/apexrest/OrgpulseHub');//URL will be your Salesforce REST API end point where you will do POST,PUT,DELETE orGET
                if (!test.isRunningTest()){
                    HttpResponse res1 = h1.send(req1);
                    system.debug('RESPONSE_BODY'+res1 .getbody());
                }
            }
            
            

			            
        }
        
        
        
    }
    global void finish(Database.BatchableContext BC){ 
    }
    
    public class OAuth2{
        public String id{get; set;}
        public String issued_at{get; set;}
        public String instance_url{get; set;}
        public String signature{get; set;}
        public String access_token{get; set;} 
        
        public OAuth2(String accessToken, String instanceUrl){
            this.access_token = accessToken;
            this.instance_url = instanceURL;
        }
    }
    
    
    
    
    
}