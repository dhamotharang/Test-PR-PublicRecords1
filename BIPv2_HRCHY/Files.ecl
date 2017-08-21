import tools,BIPV2_Files,BIPV2; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
		
	export base       := tools.macf_FilesBase	(filenames(pversion,pUseOtherEnvironment).base	    ,BIPV2.CommonBase.Layout);
	export baseold    := tools.macf_FilesBase	(filenames(pversion,pUseOtherEnvironment).base	    ,layouts.HrchyBase_static );
	
end;