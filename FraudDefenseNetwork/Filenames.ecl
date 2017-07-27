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
		export MBS                           := tools.mod_FilenamesInput(Template('mbs'                              ),pversion);
		export MbsGcIdExclusion              := tools.mod_FilenamesInput(Template('MbsGcIdExclusion'                 ),pversion);
		export MbsNewGcIdExclusion           := tools.mod_FilenamesInput(Template('MbsNewGcIdExclusion'              ),pversion); //In this new file gcid is replaced by exclusion_id and exclusion_type
		export MbsIndTypeExclusion           := tools.mod_FilenamesInput(Template('MbsIndTypeExclusion'              ),pversion);
    export MbsProductInclude             := tools.mod_FilenamesInput(Template('MbsProductInclude'                ),pversion);
    export MBSSourceGcExclusion          := tools.mod_FilenamesInput(Template('MBSSourceGcExclusion'             ),pversion);
    export MBSFdnIndType                 := tools.mod_FilenamesInput(Template('MBSFdnIndType'                    ),pversion);
    export MBSFdnCCID                    := tools.mod_FilenamesInput(Template('MBSFdnCCID'                       ),pversion);
    export MBSFdnHHID                    := tools.mod_FilenamesInput(Template('MBSFdnHHID'                       ),pversion);
    export MBSTableCol                   := tools.mod_FilenamesInput(Template('MBSTableCol'                      ),pversion);
    export MBSColValDesc                 := tools.mod_FilenamesInput(Template('MBSColValDesc'                    ),pversion);
    export MBSmarketAppend               := tools.mod_FilenamesInput(Template('MBSmarketAppend'                  ),pversion);


		export dAll_filenames :=
			SuspectIP.dAll_filenames +
			GLB5.dAll_filenames +
	    TIGER.dAll_filenames +
			CFNA.dAll_filenames +
			AInspection.dAll_filenames +
			TextMinedCrim.dAll_filenames +
			OIG.dAll_filenames +
			MBS.dAll_filenames +
			MbsGcIdExclusion.dAll_filenames +
			MbsNewGcIdExclusion.dAll_filenames +
			MbsIndTypeExclusion.dAll_filenames +
			MbsProductInclude.dAll_filenames +
			MBSSourceGcExclusion.dAll_filenames +
			MBSFdnIndType.dAll_filenames +
			MBSFdnCCID.dAll_filenames +
			MBSFdnHHID.dAll_filenames +
			MBSTableCol.dAll_filenames +
			MBSColValDesc.dAll_filenames +
			MBSmarketAppend.dAll_filenames ;
			
			
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		export SuspectIP             := tools.mod_FilenamesBuild(Template('SuspectIP'           ),pversion);
		export Glb5                  := tools.mod_FilenamesBuild(Template('GLB5'                ),pversion);
		export Main                  := tools.mod_FilenamesBuild(Template('Main'                ),pversion);
		export Tiger                 := tools.mod_FilenamesBuild(Template('Tiger'               ),pversion);
		export CFNA                  := tools.mod_FilenamesBuild(Template('CFNA'                ),pversion);
		export AInspection           := tools.mod_FilenamesBuild(Template('AInspection'         ),pversion);
	  export TextMinedCrim         := tools.mod_FilenamesBuild(Template('TextMinedCrim'       ),pversion);
		export OIG                   := tools.mod_FilenamesBuild(Template('OIG'                 ),pversion);

		export dAll_filenames :=
			Main.dAll_filenames + 
			SuspectIP.dAll_filenames  +
			Glb5.dAll_filenames  +
			Tiger.dAll_filenames  +
			CFNA.dAll_filenames   +
			AInspection.dAll_filenames +
			TextMinedCrim.dAll_filenames   +
			OIG.dAll_filenames ;
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;