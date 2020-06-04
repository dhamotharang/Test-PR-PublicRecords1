import tools;
EXPORT Filenames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		      := _Config(pUseOtherEnvironment).prefix	;
	export business_information := tools.mod_FilenamesBuild(lfileprefix + 'Marketing_List::base::@version@::business_information' ,pversion);
	export business_contact     := tools.mod_FilenamesBuild(lfileprefix + 'Marketing_List::base::@version@::business_contact'     ,pversion);
     
	export dall_filenames := 
      business_information  .dall_filenames
    + business_contact      .dall_filenames
    ;
    
end;