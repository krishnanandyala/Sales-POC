global class licenseWrapper {
    private Integer licenseCount;
    private String licenseType; 
    private Boolean isActive;  
    
    public Integer getLicenseCount(){
        return this.licenseCount;
    } 
    public String getLicenseType(){
        return this.licenseType;
    }
    public Boolean getIsActive(){
        return this.isActive;
    }
    
    
    public licenseWrapper(AggregateResult ar){
    	this.licenseCount = (Integer) ar.get('licenseCount');
    	this.licenseType = (String) ar.get('UserType');
    	this.isActive = (Boolean) ar.get('IsActive');
    }
    
    public static List<licenseWrapper> licenseList(List<AggregateResult> resultList){
    	List<licenseWrapper> licenseList = new List<licenseWrapper>();
    	licenseWrapper newLicense;
    	for(AggregateResult ar: resultList){
    		newLicense = new licenseWrapper(ar);
    		licenseList.add(newLicense);
    	}
    	return licenseList;
    }
}