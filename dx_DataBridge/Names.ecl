import $, tools;
  
export Names(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lkeyTemplate	  := $.Constants(pUseOtherEnvironment).keyTemplate;
 
	export LinkIds	      := tools.mod_FilenamesBuild(lkeyTemplate  + 'linkIds'  ,pversion);
	
	export dAll_filenames := LinkIds.dAll_filenames;

end;