IMPORT tools;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE

	SHARED lversiondate	:= pversion;
	SHARED lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'lookup';
	SHARED lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'lookup';
	SHARED lInputRootDnbDmi	:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'lookup::dnbdmi';
	SHARED lfileRootDnbDmi := _Constants(pUseOtherEnvironment).FileTemplate	+ 'lookup::dnbdmi'	;

export Input :=
	module
	EXPORT NAICS	      := tools.mod_FilenamesInput(lInputRoot,lversiondate);
	EXPORT DnbDmi  := tools.mod_FilenamesInput(lInputRootDnbDmi,lversiondate);	
  export dAll_filenames := NAICS.dAll_filenames + DnbDmi.dAll_filenames;
end;

export NAICSLookup	:= tools.mod_FilenamesBuild(lfileRoot,lversiondate);
	
  export dAll_filenames := NAICSLookup.dAll_filenames;
			
END;
		     
