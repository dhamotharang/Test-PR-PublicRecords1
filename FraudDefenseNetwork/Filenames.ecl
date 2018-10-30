import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		export SuspectIP                     := tools.mod_FilenamesInput(Template('SuspectIP'                        ),pversion);
		export Glb5                          := tools.mod_FilenamesInput(Template('GLB5'                             ),pversion);
		export TIGER                         := tools.mod_FilenamesInput(Template('TIGER'                            ),pversion);
    export CFNA                          := tools.mod_FilenamesInput(Template('CFNA'                             ),pversion);
		export AInspection                   := tools.mod_FilenamesInput(Template('AInspection'                      ),pversion);
		export TextMinedCrim                 := tools.mod_FilenamesInput(Template('TextMinedCrim'                    ),pversion);
		export OIG                           := tools.mod_FilenamesInput(Template('OIG'                              ),pversion);
		export Erie                          := tools.mod_FilenamesInput(Template('Erie'                             ),pversion);
		export ErieWatchList                 := tools.mod_FilenamesInput(Template('ErieWatchList'                    ),pversion);


		export dAll_filenames :=
			SuspectIP.dAll_filenames +
			GLB5.dAll_filenames +
	    TIGER.dAll_filenames +
			CFNA.dAll_filenames +
			AInspection.dAll_filenames +
			TextMinedCrim.dAll_filenames +
			OIG.dAll_filenames + 
			Erie.dAll_filenames +
			ErieWatchList.dAll_filenames;
			
			
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		export SuspectIP             := tools.mod_FilenamesBuild(Template('SuspectIP'           ),pversion);
		export Glb5                  := tools.mod_FilenamesBuild(Template('GLB5'                ),pversion);
		export Tiger                 := tools.mod_FilenamesBuild(Template('Tiger'               ),pversion);
		export CFNA                  := tools.mod_FilenamesBuild(Template('CFNA'                ),pversion);
		export AInspection           := tools.mod_FilenamesBuild(Template('AInspection'         ),pversion);
	  export TextMinedCrim         := tools.mod_FilenamesBuild(Template('TextMinedCrim'       ),pversion);
		export OIG                   := tools.mod_FilenamesBuild(Template('OIG'                 ),pversion);
		export Erie                  := tools.mod_FilenamesBuild(Template('Erie'                ),pversion);
		export ErieWatchList         := tools.mod_FilenamesBuild(Template('ErieWatchList'       ),pversion);

		export dAll_filenames :=
			SuspectIP.dAll_filenames  +
			Glb5.dAll_filenames  +
			Tiger.dAll_filenames  +
			CFNA.dAll_filenames   +
			AInspection.dAll_filenames +
			TextMinedCrim.dAll_filenames   +
			OIG.dAll_filenames +
			Erie.dAll_filenames +
			ErieWatchList.dAll_filenames ;
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;