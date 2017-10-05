global class installedApplication {
    private String label; 
    private String description;
    private String logoUrl; 
    private String namespace; 
    private Boolean selected;
    private Id packageId; 
    private integer allowedLicenses;
    private integer usedLicenses; 
    private DateTime expirationDate; 
    private String status; 
    
    global String getLabel(){
        return this.label;
    }
    global String getDescription(){
        return this.description;
    }
    global String getLogoUrl(){
        return this.logoUrl;
    }
    global String getNamespace(){
        return this.namespace;
    }
    global Boolean getSelected(){
        return this.selected;
    }
    global Id getPackageId(){
        return this.packageId;
    }
    global integer getAllowedLicenses(){
        return this.allowedLicenses;
    }
    global integer getUsedLicenses(){
        return this.usedLicenses;
    }
    global datetime getExpirationDate(){
        return this.expirationDate;
    }
    global String getStatus(){
        return this.status;
    }
    
    
    global installedApplication(Schema.DescribeTabSetResult tabs, PackageLicense licenseInfo){        
        this.label=tabs.getLabel();
        this.description = tabs.getDescription();
        this.logoUrl = tabs.getLogoUrl();
        this.namespace = tabs.getNamespace();
        //this.tabs = tabs.getTabs();
        this.selected = tabs.isSelected();
        this.packageId = licenseInfo.id;
        this.allowedLicenses = licenseInfo.AllowedLicenses;
        this.usedLicenses = licenseInfo.UsedLicenses;
        this.expirationDate = licenseInfo.ExpirationDate;
        this.status = licenseInfo.Status;
    }
    
}