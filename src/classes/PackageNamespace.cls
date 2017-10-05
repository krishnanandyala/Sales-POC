public class PackageNamespace { 
    public static List<installedApplication> getAppInfo(){
        
        List<installedApplication> appList = new List<installedApplication>();
        String namespace;
        List<PackageLicense> plList = getNamespace();
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        
        for (Schema.DescribeTabSetResult tabSetResult : tabSetDesc){
            namespace = tabSetResult.getNamespace();
            if (namespace == 'standard'){
                continue;
            }
            else{
                for(PackageLicense pl : plList){
                    if (pl.NamespacePrefix == namespace){
                       installedApplication app = new installedApplication(tabSetResult, pl);
                        appList.add(app);
                    }
                }
            }
        }
    	return appList;
    }
    
    public static List<PackageLicense> getNamespace(){
        //PackageLicense p1 = new PackageLicense();
        List<PackageLicense> plList = [SELECT Id, NamespacePrefix, AllowedLicenses, UsedLicenses, 
                             ExpirationDate,Status FROM PackageLicense];
        //For (PackageLicense pl : plList){
         //   system.debug(pl); //added to get code formatted
       // }
        return plList;
    }
    
   /* public static void printAppInfo(){
        // Get tab set describes for each app
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        
        // Iterate through each tab set describe for each app and display the info
        for(DescribeTabSetResult tsr : tabSetDesc) {
            String appLabel = tsr.getLabel();
            System.debug('Label: ' + appLabel);
            System.debug('Logo URL: ' + tsr.getLogoUrl());
            System.debug('isSelected: ' + tsr.isSelected());
            String ns = tsr.getNamespace();
            if (ns == '') {
                System.debug('The ' + appLabel + ' app has no namespace defined.');
            }
            else {
                System.debug('Namespace: ' + ns);
            }
            
            // Display tab info for the Sales app
            if (appLabel == 'Sales') {
                List<Schema.DescribeTabResult> tabDesc = tsr.getTabs();
                System.debug('-- Tab information for the Sales app --');
                for(Schema.DescribeTabResult tr : tabDesc) {
                    System.debug('getLabel: ' + tr.getLabel());
                    System.debug('getColors: ' + tr.getColors());
                    System.debug('getIconUrl: ' + tr.getIconUrl());
                    System.debug('getIcons: ' + tr.getIcons());
                    System.debug('getMiniIconUrl: ' + tr.getMiniIconUrl());
                    System.debug('getSobjectName: ' + tr.getSobjectName());
                    System.debug('getUrl: ' + tr.getUrl());
                    System.debug('isCustom: ' + tr.isCustom());
                }
            }
        }
        
        
    }*/
    
}