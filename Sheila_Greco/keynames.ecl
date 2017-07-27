import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	export lTmplt				:= _Constants(pUseOtherEnvironment).keyTemplate									;
  
	//new keys
  export LinkIds				  := tools.mod_FilenamesBuild(lTmplt		      + 'linkIds'			                      ,pversion );
  
	export dAll_filenames := 
		  LinkIds.dAll_filenames
		;

end;
