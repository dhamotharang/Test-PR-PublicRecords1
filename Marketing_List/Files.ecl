import tools; 
export Files(
	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
  #IF(Marketing_List._Config().Add_Extra_Source_Fields = false)
	export business_information := tools.macf_FilesBase	(fnames.business_information ,layouts.business_information );
	export business_contact     := tools.macf_FilesBase	(fnames.business_contact     ,layouts.business_contact     );
  #ELSE
	export business_information := tools.macf_FilesBase	(fnames.business_information ,layouts.business_information_prep2 );
	export business_contact     := tools.macf_FilesBase	(fnames.business_contact     ,layouts.business_contact_prep      );
  #END
  
end;
