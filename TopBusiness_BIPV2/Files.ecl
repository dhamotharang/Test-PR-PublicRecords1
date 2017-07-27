import tools;

export Files(
   string  pversion             = ''
  ,boolean pUseOtherEnvironment = false
) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
  export Industry_linkids	:= tools.macf_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Industry_linkids  ,layouts.rec_industry_combined_layout		);
  export License_linkids	:= tools.macf_FilesBase	(Filenames(pversion,pUseOtherEnvironment).License_linkids   ,layouts.rec_license_combined_layout		);
	
end;