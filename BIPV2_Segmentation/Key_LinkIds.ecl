import tools,BIPV2,BIPV2_PostProcess;

export Key_LinkIds(
   string   pversion              = '' 
  ,boolean	pUseOtherEnvironment	= tools._Constants.IsDataland
) := 
module
  
  shared superfile_name   := keynames(, pUseOtherEnvironment).seg_linkids.qa;
	
	shared headerRecs     := BIPV2.CommonBase.DS_Clean;
	shared header_clean   := distribute(headerRecs, hash32(seleid));
	
	shared seg          := project(BIPV2_PostProcess.segmentation_category.perSeleid(header_clean, BIPV2.KeySuffix), Layouts.SegKeyLayout);
	
	export Key          := KeyRead(pversion, pUseOtherEnvironment).IndexDef(superfile_name, seg);
end;