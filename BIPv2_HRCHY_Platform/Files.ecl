import tools,BIPV2_Files; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
		
	export base       := tools.macf_FilesBase	(filenames(pversion,pUseOtherEnvironment).base	    ,layouts.HrchyBase        );
	export baseold    := tools.macf_FilesBase	(filenames(pversion,pUseOtherEnvironment).base	    ,layouts.HrchyBase_static );
	
end;