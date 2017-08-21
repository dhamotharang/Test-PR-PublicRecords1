import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate		:= _Constants(pUseOtherEnvironment).keyTemplate			;

	export Bdid						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'				,pversion);
	//export Did						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'did'					,pversion);
	export LinkIds					:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'linkIds'			,pversion);
	export Source_Rec_Id		:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'source_rec_id',pversion);			
	
	export dAll_filenames := 
		  Bdid.dAll_filenames
		//+ Did.dAll_filenames
		+ LinkIds.dAll_filenames
		+ Source_Rec_Id.dAll_filenames		
		;

end;