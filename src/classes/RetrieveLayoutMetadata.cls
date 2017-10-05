public class RetrieveLayoutMetadata{
    public List<MetadataService.Layout> layoutList {get; set;}
    public List<String> layoutNamesToDisplay;
    public Integer pageSize = 10;
    public Integer targetSize = 10;
    public Integer count = 0;
    public Boolean hasNext {get; set;}
    public Boolean hasPrevious {get; set;}
    
    public RetrieveLayoutMetadata()
    {
        getRetrieveLayoutMetadata();
        hasPrevious = false;
    }
    
    public MetadataService.MetadataPort metadataService
    {
        get
        {
            if(metadataService == null)
            {
                metadataService = MetaDataComponentPageController.createService();
            }
            return metadataService;
        }
        set;
    }
    
    public List<String> layoutNamesList
    {
        get
        {
            if(layoutNamesList == null)
            {
                layoutNamesList = new List<String>();
                MetadataService.ListMetadataQuery listMetaQuery = new MetadataService.ListMetadataQuery();
                listMetaQuery.type_x = 'Layout';
                
                MetadataService.FileProperties[] fieldProp = (MetadataService.FileProperties[]) metadataService.listMetadata(new List<MetadataService.ListMetadataQuery>{listMetaQuery}, 40);
                
                if(fieldProp != null && !fieldProp.isEmpty())
                {
                    for(MetadataService.FileProperties flp : fieldProp)
                    {   
                        if(flp.fullName != null && !flp.fullName.startsWith('LiveChat'))
                        {
                            layoutNamesList.add(flp.fullName);
                        }
                    }
                }
                if(!layoutNamesList.isEmpty())
                {
                    layoutNamesList.sort();
                }
            }
            return layoutNamesList;
        }
        set;
    }
    
    public void getRetrieveLayoutMetadata()
    {   
        layoutList = new List<MetadataService.Layout>();
        List<MetadataService.Layout> metadataResponseOfLayouts;
        layoutNamesToDisplay = new List<String>();
        for(Integer i = count ; i < targetSize ; i++)
        {   
            if(i < layoutNamesList.size())
            {
                String layOutName = layoutNamesList[i];
                Pattern p = Pattern.compile('(.*(?=(__.*__)))');
                Matcher m = p.matcher(layOutName);
                if(m.find())
                {
                    String placeHolder = layOutName.split('-')[0] +'{0}{1}{2}'+layOutName.split('-')[1];
                    String mngPkglayOutName = String.format(placeHolder,new List<String> {'-',m.group(1),'__'});
                    layoutNamesToDisplay.add(mngPkglayOutName);
                }
                else
                {
                    layoutNamesToDisplay.add(layOutName);
                }
            }
        }
        
        if(layoutNamesToDisplay!= null && !layoutNamesToDisplay.isEmpty())
        {
            metadataResponseOfLayouts = (MetadataService.Layout[]) metadataService.readMetadata('Layout', layoutNamesToDisplay).getRecords();
        }
        
        if(metadataResponseOfLayouts != null)
        {
            for(MetadataService.Layout layoutItem : metadataResponseOfLayouts)
            {   
                if(layoutItem.fullName != null)
                {
                    layoutList.add(layoutItem);       
                }
            }
        }
        setNextAndPrevious();
    }
    
    public void getNextCount()
    {
        count = targetSize;
        targetSize = targetSize+ pageSize; 
        getRetrieveLayoutMetadata();
    }
    
    public void getPreviousCount()
    {
        targetSize = targetSize - pageSize;
        count = targetSize - pageSize;
        getRetrieveLayoutMetadata();
    }
    
    public void setNextAndPrevious()
    {
        if(targetSize >= layoutNamesList.size())
        {   
            hasNext = false;
            hasPrevious = true;
        }
        else if(count == 0)
        {
            hasPrevious = false;
            hasNext = true;
        }
        else if(targetSize < layoutNamesList.size())
        {
            hasNext = true;
            hasPrevious = true;
        }
    }
    public pageReference exportLayouts(){
        PageReference pageRef = new PageReference('/apex/LayoutsExport');
        pageRef.setRedirect(false);
        return pageRef;        
    }
}