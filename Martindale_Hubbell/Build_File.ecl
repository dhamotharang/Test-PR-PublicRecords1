export Build_File(
										 pversion			= ''// Process Date for State
										,pFile						// Raw File -- not a string
										,pFileString	= ''// File as a string
										,pOutput

) :=
macro

	export pOutput :=
	module
	
		export build_base		:= martindale_hubbell.Update_File.pFile(
																 pversion
															);

		VersionControl.macBuildNewLogicalFile(
																 martindale_hubbell.Filenames(pversion).base.pFile.new	
																,build_base
																,Build_Base_File
		);
																																
		export postprocess :=
			sequential(
				martindale_hubbell.Promote(pversion,pFileString).New2Built
			);

		export All :=
		if(VersionControl.IsValidVersion(pversion)
				,sequential(
					 Build_Base_File
					,postprocess
				)
				,output('No Version passed into the build process, exiting')
		);

	end;
	
endmacro;