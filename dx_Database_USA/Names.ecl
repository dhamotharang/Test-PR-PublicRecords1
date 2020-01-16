import $, tools;

export Names(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lkeyTemplate	  := $.Constants(pUseOtherEnvironment).keyTemplate;
 
	// export LinkIds	      := tools.mod_FilenamesBuild(lkeyTemplate  + 'linkIds'  ,pversion);
	export did			      := tools.mod_FilenamesBuild(lkeyTemplate  + 'did'  ,pversion);

	
	export dAll_filenames := 
														// LinkIds.dAll_filenames +
														did.dAll_filenames;

end;
