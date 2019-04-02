import tools,BIPV2_Files,Business_DOT; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export Gold_Seleid_Orgid_Persistence   := tools.macf_FilesBase	(fnames.Gold_Seleid_Orgid_Persistence  ,layouts.Gold_Seleid_Orgid_Persistence);
	
end;