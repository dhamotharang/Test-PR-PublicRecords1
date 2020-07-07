import BIPV2;
import tools;
import BIPV2_PostProcess;
export Key_LinkIds(string   pversion  = '' ,boolean	pUseOtherEnvironment	= tools._Constants.IsDataland) := module
  shared superfile_name   := keynames(, pUseOtherEnvironment).seg_linkids.qa;
	
	shared SegKeyLayout     := record
	     Layouts.SegmentationLayout.seleid;
	     Layouts.SegmentationLayout.category;
	     Layouts.SegmentationLayout.subcategory;
	end;
	
	shared headerRecs     := BIPV2.CommonBase.DS_Clean;
	shared header_clean   := distribute(headerRecs, hash32(seleid));
	
	shared seg          := project(BIPV2_PostProcess.segmentation_category.perSeleid(header_clean, BIPV2.KeySuffix), SegKeyLayout);
	shared indexDef     := index(seg, { seleid }, { seg }, superfile_name); 
	
	
	export Key          := indexDef;
end;
