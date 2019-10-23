import _control;

export Build_State(

	 pversion				// Process Date for State
	,pState					// Raw State -- not a string
	,pStateString		// State as a string
	,pDirectory			
	,pOutput
	//,pServerIP			= '\'bctlpedata11\''
	//,pServerIP			= '\'bctlpedata11.risk.regn.net\''
	,pServerIP			= _Control.IPAddress.bctlpedata11
	,pFilename			= '\'liquor_licenses*d00\''
	,pGroupName			= Liquor_Licenses._dataset.groupname																		
	,pIsTesting			= 'false'
	,pOverwrite			= 'false'																															

) :=
macro

	export pOutput :=
	module

		lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

		Liquor_Licenses.macSprayFiles(
			 pServerIP
			,pDirectory 
			,pFilename
			,pState
			,lfileversion
			,spray_files
			,pGroupName

		);
		
		export spray_the_files := if(pDirectory != '', 	spray_files);
	
		export preprocess		:= Liquor_Licenses.Promote(,pStateString).Input.Sprayed2Using;

		export build_base		:= Liquor_Licenses.Update_State.pState(
																pversion
															);

		VersionControl.macBuildNewLogicalFile(
																 Liquor_Licenses.Filenames(pversion).base.pState.new	
																,build_base
																,Build_Base_File
		);
																																
		export postprocess :=
			sequential(
				 Liquor_Licenses.Promote(,pStateString).Input.Using2Used
				,Liquor_Licenses.Promote(pversion,pStateString).New2Built
				,Liquor_Licenses.Promote(pversion,pStateString).Built2QA
				,Liquor_Licenses.Strata_Population_Stats(pversion).Business_headers.pState
				,Liquor_Licenses.Strata_Population_Stats(pversion).Business_Contacts.pState
			);

		export full_build :=
			sequential(
				 versioncontrol.mUtilities.createsupers(Liquor_Licenses.Filenames().base.pState.dAll_filenames)
				,spray_the_files
				,preprocess
				,Build_Base_File
				,postprocess
			) : success(Liquor_Licenses.send_email(pversion,pStateString).buildsuccess), failure(Liquor_Licenses.send_email(pversion,pStateString).buildfailure);

		export All :=
			if(VersionControl.IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping build')
			);

	end;
	
endmacro;