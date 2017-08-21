import _control;

export Build_State(

	 pversion				// Process Date for State
	,pState					// Raw State -- not a string
	,pStateString		// State as a string
	,pDirectory			
	,pOutput
	,pServerIP			= '\'edata10\''
	,pFilename			= '\'gaming_licenses*d00\''
	,pGroupName			= Gaming_Licenses._dataset.groupname																		
	,pIsTesting			= 'false'
	,pOverwrite			= 'false'																															

) :=
macro

	export pOutput :=
	module

		lfileversion	:= regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');

		Gaming_Licenses.macSprayFiles(
			 pServerIP
			,pDirectory 
			,pFilename
			,pState
			,lfileversion
			,spray_files
			,pGroupName

		);
		
		// -- only spray if pass in a directory, and the file is not in the using superfile
		export spray_the_files := if(			pDirectory != ''
																	and not(Gaming_Licenses._Flags.ExistNJCurrentSprayed)
																,spray_files
															);
	
		export preprocess		:= Gaming_Licenses.Promote(,pStateString).Input.Sprayed2Using;

		export build_base		:= Gaming_Licenses.Update_State.pState(
																pversion
															);

		VersionControl.macBuildNewLogicalFile(
																 Gaming_Licenses.Filenames(pversion).base.pState.new	
																,build_base
																,Build_Base_File
		);
																																
		export postprocess :=
			sequential(
				 Gaming_Licenses.Promote(,pStateString).Input.Using2Used
				,Gaming_Licenses.Promote(pversion,pStateString).New2Built
				,Gaming_Licenses.Promote(pversion,pStateString).Built2QA2Father
				,Gaming_Licenses.Strata_Population_Stats(pversion).Business_headers.pState
				,Gaming_Licenses.Strata_Population_Stats(pversion).Business_Contacts.pState
				,Gaming_Licenses.QA_Records
			);

		export full_build :=
			sequential(
				 versioncontrol.mUtilities.createsupers(Gaming_Licenses.filenames().dAll_filenames)
				,nothor(apply(gaming_licenses.Filenames().input.dall_filenames	,apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))	))
				,spray_the_files
				,preprocess
				,Build_Base_File
				,postprocess
			) : success(Gaming_Licenses.send_email(pversion,pStateString).buildsuccess), failure(Gaming_Licenses.send_email(pversion,pStateString).buildfailure);

		export All :=
			if(VersionControl.IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping build')
			);

	end;
	
endmacro;