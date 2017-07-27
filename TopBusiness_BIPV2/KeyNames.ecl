import tools;

export Keynames(
   string		pversion							= ''
  ,boolean	pUseOtherEnvironment	= false

) := 
MODULE

	shared lkeyTemplate := _Constants(pUseOtherEnvironment).keyTemplate;

	export Industry_linkids	 := tools.mod_FilenamesBuild(lkeyTemplate + 'Industry_linkids',pversion);
	export License_linkids	 := tools.mod_FilenamesBuild(lkeyTemplate + 'License_linkids' ,pversion);

	export dAll_filenames := 
      Industry_linkids.dAll_filenames 
    + License_linkids	.dAll_filenames 
    ;

end;