export Build_File(
										 pversion			= ''// Process Date for State
										,pFile						// Raw File -- not a string
										,pFileString	= ''// File as a string

) :=
functionmacro

	pOutput :=
	module
	
		export build_base		:= Sheila_Greco.Update_File.pFile(
																 pversion
															);

		export Build_Base_File	  := tools.macf_WriteFile(Sheila_Greco.Filenames(pversion).base.pFile.new		,build_base		);
																															
		export postprocess :=
			sequential(
				Sheila_Greco.Promote(pversion,pFileString).Buildfiles.New2Built
			);

		export All :=
		if(tools.fun_IsValidVersion(pversion)
				,sequential(
					 Build_Base_File
					,postprocess
				)
				,output('No Version passed into Sheila_Greco.Build_File,  exiting')
		);

	end;
  
  return pOutput;
	
endmacro;