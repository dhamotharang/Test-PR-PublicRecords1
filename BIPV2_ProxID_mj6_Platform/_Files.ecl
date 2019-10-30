import tools,BIPV2_Files,Business_DOT,bipv2; 
export _Files(
	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	export dotfile      := BIPV2_Files.files_dotid().DS_BASE;
  shared fnames       := _filenames(pversion,pUseOtherEnvironment);
  
	export base         := tools.macf_FilesBase	(fnames.base	    ,layout_DOT_Base                  );
	export Out          := tools.macf_FilesBase	(fnames.out 	    ,_layouts.DOT_Base_orig           );
	export baseold      := tools.macf_FilesBase	(fnames.base	    ,BIPV2.CommonBase.layout_static   );
	export wkhistory    := tools.macf_FilesBase	(fnames.wkhistory	,_layouts.wkhistory               );
	export wkhistoryold := tools.macf_FilesBase	(fnames.wkhistory	,_layouts.wkhistoryold            );
	export precision    := tools.macf_FilesBase	(fnames.precision	,_layouts.precision               );
	
end;
