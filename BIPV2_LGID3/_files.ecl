import tools,BIPV2_Files,Business_DOT,bipv2,BIPV2_Files; 
export _Files(
	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module
  shared fnames         := _filenames(pversion,pUseOtherEnvironment);
  
	export base           := tools.macf_FilesBase	(fnames.base	    ,BIPV2_Files.files_lgid3.Layout_LGID3  );
  export lgid3_building := BIPV2_Files.files_lgid3.DS_BUILDING;
	
end;
