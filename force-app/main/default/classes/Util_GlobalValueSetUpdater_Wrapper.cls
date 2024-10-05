public class Util_GlobalValueSetUpdater_Wrapper {
	public cls_records[] records;
	public class cls_records {
		public String Id;
		public String FullName;
		public Util_GlobalValueSetUpdater_Wrapper.cls_Metadata Metadata;
        public Util_GlobalValueSetUpdater_Wrapper.cls_attributes attributes;
	}
    
	public class cls_attributes {
		public String url;
	}
    
	public class cls_Metadata {
		public Util_GlobalValueSetUpdater_Wrapper.cls_customValue[] customValue;
		public String masterLabel;
	}
    
	public class cls_customValue {
		public String label;
		public String valueName;
	}
    
    public class patch_body {
        public String FullName;
        public Util_GlobalValueSetUpdater_Wrapper.cls_Metadata Metadata;
    }
    
	public static Util_GlobalValueSetUpdater_Wrapper parse(String json){
		return (Util_GlobalValueSetUpdater_Wrapper) System.JSON.deserialize(json, Util_GlobalValueSetUpdater_Wrapper.class);
	}
}