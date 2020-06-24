import tools;

export Key_LinkIds(
   string   pversion              = '' 
  ,boolean	pUseOtherEnvironment	= tools._Constants.IsDataland
) := 
module
  
  shared superfile_name   := keynames(, pUseOtherEnvironment).seg_linkids.qa;
	
	shared SegKeyLayout     := record
	     Layouts.SegmentationLayout.seleid;
	     Layouts.SegmentationLayout.category;
	     Layouts.SegmentationLayout.subcategory;
	end;
	
	shared seg          := dataset([], SegKeyLayout); // built in BIPV2_Build.Build_Misc_Keys

	shared indexDef     := index(seg, { seleid }, { seg }, superfile_name); 
	
	export Key          := indexDef;
  
  export keyversions := tools.macf_FilesIndex('Key',keynames(pversion, pUseOtherEnvironment).seg_linkids); //allow easy access to other versions(logical or super) of key

end;