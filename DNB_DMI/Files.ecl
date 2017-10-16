import tools,dnb,scrubs_dnb_dmi;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pDatasetName					= 'DNB_DMI'

) :=
module

	shared lfns := Filenames(pversion,pUseOtherEnvironment,pDatasetName);

	export Input := 
	module

		tools.mac_FilesInput(lfns.Input.raw	   ,layouts.Input.raw						      ,Raw						,'CSV','"','\n','',0,pMaxLength := 100000, pOpt := true);
		tools.mac_FilesInput(lfns.Input.raw	   ,layouts.Input.sprayed				      ,Sprayed				);
		tools.mac_FilesInput(lfns.Input.raw	   ,Scrubs_DNB_DMI.Raw_Layout_DNB_DMI ,Flattened			);  //Added for Scrubs
		tools.mac_FilesInput(lfns.Input.oldcompanies,layouts.Input.oldcompanies		,oldcompanies		);	//old DNB V1 input files
		tools.mac_FilesInput(lfns.Input.oldcontacts	,layouts.Input.oldcontacts		,oldcontacts		);	//old DNB V1 input files

	end;

	export Base :=
	module

		tools.mac_FilesBase	(lfns.Base.Companies	,layouts.Base.CompaniesForBIP2,Companies	);
		tools.mac_FilesBase	(lfns.Base.Contacts		,layouts.Base.Contacts				,Contacts		);
		tools.mac_FilesBase	(lfns.Base.Companies	,layouts.Base.companies_prev	,companies_prev	);

	end;

	export SPC :=
	module

		tools.mac_FilesBase	(lfns.Base.Companies	,layouts.Base.CompaniesSPC		,CompaniesSPC	);
		tools.mac_FilesBase	(lfns.Base.Contacts		,layouts.Base.ContactsSPC			,ContactsSPC	);

	end;

	export V1 :=
	module

		tools.mac_FilesBase	(lfns.V1.Companies	,DNB.Layout_DNB_Base					,Companies	);
		tools.mac_FilesBase	(lfns.V1.Contacts		,DNB.Layout_DNB_Contacts_Base	,Contacts		);

	end;

end;