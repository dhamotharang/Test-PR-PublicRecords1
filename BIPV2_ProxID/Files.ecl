import tools,BIPV2_Files,Business_DOT,bipv2; 
export Files(
	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	export dotfile  := BIPV2_Files.files_dotid().DS_BASE;
  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export base       := tools.macf_FilesBase	(fnames.base	    ,layout_DOT_Base  );
	export out        := tools.macf_FilesBase	(fnames.out 	    ,layouts.orig_DOT_Base  );
	export baseold    := tools.macf_FilesBase	(fnames.base	    ,BIPV2.CommonBase.layout_static  );
	export wkhistory  := tools.macf_FilesBase	(fnames.wkhistory	,layouts.wkhistory);
	export wkhistoryold  := tools.macf_FilesBase	(fnames.wkhistory	,layouts.wkhistoryold);
	export precision  := tools.macf_FilesBase	(fnames.precision	,layouts.precision);
	
end;
