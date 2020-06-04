import tools;
export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

  export base := tools.macf_FilesBase	(filenames(pversion,pUseOtherEnvironment).base	,layouts.base);

END;
