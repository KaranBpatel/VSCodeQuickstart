public class MetadataComponentDependency {
    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public String queryLocator;
    public String entityTypeName;
    public List<Record> records;
     
    
    public class Record {
        public Attributes attributes;
        public String MetadataComponentType;
        public String MetadataComponentName;
        public String RefMetadataComponentName;
        public String RefMetadataComponentId;
        public String Id;
    public String DeveloperName;
    public String NamespacePrefix;
    }
    
    public class Attributes {
        public String type;
        public String url;
    }
}