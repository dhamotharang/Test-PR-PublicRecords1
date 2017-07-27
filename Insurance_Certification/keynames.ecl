import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'insurance_certification'
) := module

	export lLogicalTmplt := _Constants(pUseOtherEnvironment,pDatasetname).keyTemplate;
		
  export LinkIds := tools.mod_FilenamesBuild(lLogicalTmplt + 'linkIds'	,pversion );
	  
	export dNotAutokey_filenames := LinkIds.dAll_filenames;

	export dAll_filenames := LinkIds.dAll_filenames;

end;
