import tools; 
export Files(
	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export business_information := tools.macf_FilesBase	(fnames.business_information ,layouts.business_information );
	export business_contact     := tools.macf_FilesBase	(fnames.business_contact     ,layouts.business_contact     );
  
end;
