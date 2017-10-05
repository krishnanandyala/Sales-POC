global class htmlRegEx {
    private Decimal usedDataSpaceNum;
    private String usedDataSpaceUnit;
    private Integer usedDataPercent;    
    private Decimal usedFileSpaceNum;
    private String usedFileSpaceUnit;
    private Integer usedFilePercent;
    private Integer devSndbxAvailable;
    private Integer devSndbxInUse;
    private Integer proSndbxAvailable;
    private Integer proSndbxInUse;    
    private Integer partialSndbxAvailable;
    private Integer partialSndbxInUse;   
    private Integer fullSndbxAvailable;
    private Integer fullSndbxInUse;    
    private String debugStatement;

    
    global htmlRegEx(){
        this.debugStatement = 'Start';
        String[] resultSplit;
        String rawLicenseInfo;
        id orgId = getOrgId();
        this.debugStatement = this.debugStatement + '|' + 'getting Raw Data';
        String rawData = Test.isRunningTest() ? getTestData(1) : getRawData(String.valueof(orgId));
        this.debugStatement = this.debugStatement + '|' + 'got rawData';
        Organization org = [SELECT IsSandbox FROM Organization LIMIT 1][0];
        this.debugStatement = this.debugStatement + '|' + 'queried Org';
        if (rawData != null){
            this.debugStatement = this.debugStatement + '|' + 'rawData not null';
            String usedDataResult = scrapePage('Used Data Space', rawData);
            if (usedDataResult != null){
                this.debugStatement = this.debugStatement + '|' + 'usedData not null';
                resultSplit = usedDataResult.split('&nbsp;'); //Error handling if this string isn't there
                this.usedDataSpaceNum = decimal.valueof(resultSplit[0]); //Put all of these next three lines in a try/catch in case it isn't an integer value
                this.usedDataSpaceUnit = resultSplit[1];
                this.usedDataPercent = integer.valueof(resultSplit[2].substring(1,resultSplit[2].length()-2));
            }
            
            String usedFileResult = scrapePage('Used File Space', rawData);
            if (usedFileResult != null){
                resultSplit = usedFileResult.split('&nbsp;');//Error handling if this string isn't there
                this.usedFileSpaceNum = decimal.valueof(resultSplit[0]);//Put all of these next three lines in a try/catch in case it isn't an integer value
                this.usedFileSpaceUnit = resultSplit[1];
                this.usedFilePercent = integer.valueof(resultSplit[2].substring(1,resultSplit[2].length()-2));
            }
        }
        else{
            this.debugStatement = this.debugStatement + '|' + 'rawData was null';
        }

        
        
        if (!org.IsSandbox || Test.isRunningTest()){ //This code shouldn't be put in a sandbox
            rawData = Test.isRunningTest() ? getTestData(2) : getRawData('07E?retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DDeploy&setupid=DataManagementCreateTestInstance');
            if(rawData != null){
            rawLicenseInfo = scrapeLicenseInfo('"licenseA"', rawData);
            if (rawLicenseInfo != null){
               	resultSplit = rawLicenseInfo.split(';'); //Error Handle this in case this substring isn't present
            	this.devSndbxAvailable = Integer.valueOf(resultSplit[0].trim()); //Error Handle these lines in all 4 blocks in case not integer or somehting goes wrong
            	this.devSndbxInUse = Integer.valueOf(resultSplit[1].trim());
            }//Do we need to initialize these variables otherwise?
            
            rawLicenseInfo = scrapeLicenseInfo('"licenseS"', rawData);
            if (rawLicenseInfo != null){
                resultSplit = rawLicenseInfo.split(';');
                this.proSndbxAvailable = Integer.valueOf(resultSplit[0].trim());
                this.proSndbxInUse = Integer.valueOf(resultSplit[1].trim());
            }
            
            rawLicenseInfo = scrapeLicenseInfo('"licenseC"', rawData);
            if (rawLicenseInfo != null){
                resultSplit = rawLicenseInfo.split(';');
                this.partialSndbxAvailable = Integer.valueOf(resultSplit[0].trim());
                this.partialSndbxInUse = Integer.valueOf(resultSplit[1].trim());
            }
            
            rawLicenseInfo = scrapeLicenseInfo('"licenseF"', rawData);
            if (rawLicenseInfo != null){
                resultSplit = rawLicenseInfo.split(';');
                this.fullSndbxAvailable = Integer.valueOf(resultSplit[0].trim());
                this.fullSndbxInUse = Integer.valueOf(resultSplit[1].trim());
            }
        }
        }
        else{
            //Do something to handle error
        }
        

    }
    
    private Id getOrgId(){
        Organization orgDetails =[select Id from Organization 
                                  limit 1];
        Id orgId = orgDetails.Id;
        return orgId;
    }
    
    private String getRawData(String url){
        this.debugStatement = this.debugStatement + '|' + 'in getRawData';
        PageReference pr;
        try{
            pr = new PageReference('/'+url);
            this.debugStatement = this.debugStatement + '|' + 'got pageRef';
        }
        catch(Exception e){
            this.debugStatement = this.debugStatement + '|' + 'pageRef exception';
            System.debug(e.getStackTraceString());
            return null;
        }
        String rawData = pr.getContent().toString();
        return rawData;
    }
    
    private String scrapePage(String searchCriteria, String rawData){
        Integer pos = rawData.indexOf(searchCriteria);
        String result;
        if (-1!=pos)
        {
            pos=rawData.indexOf('<td', pos);
            if (-1!=pos)
            {
                pos=rawData.indexOf('>', pos+3);
                if (-1!=pos)
                { 
                    Integer endPos=rawData.indexOf('%)', pos);
                    result=rawData.substring(pos+1, endPos+2);
                }
            }
        }
        return result;

    }
    
    private String getTestData(Integer selector){
        if (selector == 1){
        	return '<tr><td class="labelCol">Newsletter</td><td class="dataCol col02"><img src="/img/checkbox_unchecked.gif" alt="Not Checked" class="checkImg" id="ReceivesInfoEmails_chkbox" title="Not Checked" height="16" width="21"></td><td class="labelCol">Used Data Space</td><td class="dataCol">30&nbsp;KB&nbsp;(0%)&nbsp;<a href="/setup/org/orgstorageusage.jsp?id=00DQ000000GKdcZ&amp;setupid=CompanyResourceDisk">[View]</a></td></tr> <tr><td class="labelCol">Admin Newsletter</td><td class="dataCol col02"><img src="/img/checkbox_unchecked.gif" alt="Not Checked" class="checkImg" id="ReceivesAdminInfoEmails_chkbox" title="Not Checked" height="16" width="21"></td><td class="labelCol">Used File Space</td><td class="dataCol">688&nbsp;KB&nbsp;(0%)&nbsp;<a href="/setup/org/orgstorageusage.jsp?id=00DQ000000GKdcZ&amp;setupid=CompanyResourceDisk">[View]</a></td></tr>'; 
        } 
        else if (selector == 2){
            return '<td id="licenseA"><span class="license_available" id="licenseAvailableId">92 Available</span><span class="license_used" id="licenseUsedId">(8 in use)</span></td><td class="" id="licenseS"><span class="license_available" id="licenseAvailableId">1 Available</span><span class="license_used" id="licenseUsedId">(4 in use)</span></td><td class="" id="licenseC"><span class="license_available" id="licenseAvailableId">1 Available</span><span class="license_used" id="licenseUsedId">(0 in use)</span></td><td id="licenseF"><span class="license_unavailable" id="licenseAvailableId">0 Available</span><span class="license_used" id="licenseUsedId">(1 in use)</span></td>';
        }
        else{
            return null;
        }
    }
    
    private String scrapeLicenseInfo(String searchCriteria, String rawData){
        Integer startPos;
        Integer endPos;
        String licenseAvailable;
        String licenseInUse;
        
        startPos =  rawData.indexOf(searchCriteria);
        if (startPos == -1){
            return null;
        }
        startPos = rawData.indexOf('>', startPos+searchCriteria.length()+1);
        if (startPos == -1){
            return null;
        }
        endPos = rawData.indexOf('A', startPos);
        if (endPos == -1){
            return null;
        }
        licenseAvailable = rawData.substring(startPos+1, endPos).trim();
        
        startPos = rawData.indexOf('(',endPos);
        if (startPos == -1){
            return null;
        }
        endPos = rawData.indexOf('in use', startPos);
        if (endPos == -1){
            return null;
        }
        licenseInUse = rawData.substring(startPos+1, endPos).trim();
        return licenseAvailable + ';' + licenseInUse;
        
    }
    
    global Decimal getUsedFileSpaceNum(){
        return this.usedFileSpaceNum;
    }
    global String getusedFileSpaceUnit(){
        return this.usedFileSpaceUnit;
    }
    global Integer getUsedFilePercent(){
        return this.usedFilePercent;
    }
    global Decimal getUsedDataSpaceNum(){
        return this.usedDataSpaceNum;
    }
    global String getusedDataSpaceUnit(){
        return this.usedDataSpaceUnit;
    }
    global Integer getUsedDataPercent(){
        return this.usedDataPercent;
    }
    global Integer getDevSndbxAvailable(){
        return this.devSndbxAvailable;
    }
    global Integer getDevSndbxInUse(){
        return this.devSndbxInUse;
    }
    global Integer getProSndbxAvailable(){
        return this.proSndbxAvailable;
    }
    global Integer getProSndbxInUse(){
        return this.proSndbxInUse;
    }
    global Integer getPartialSndbxAvailable(){
        return this.partialSndbxAvailable;
    }
    global Integer getPartialSndbxInUse(){
        return this.partialSndbxInUse;
    }
    global Integer getFullSndbxAvailable(){
        return this.fullSndbxAvailable;
    }
    global Integer getFullSndbxInUse(){
        return this.fullSndbxInUse;
    }
}