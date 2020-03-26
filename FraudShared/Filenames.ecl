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
	
		shared Template(string tag) := Platform.InputTemplate(pUseOtherEnvironment) + tag;
		export MBS                           := tools.mod_FilenamesInput(Template('mbs'                              ),pversion);
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
		export MbsFdnMasterIDIndTypeInclusion:= tools.mod_FilenamesInput(Template('MbsFdnMasterIDIndTypeInclusion'   ),pversion);
		export MbsVelocityRules							 :=	tools.mod_FilenamesInput(Template('MbsVelocityRules'   							 ),pversion);


		export dAll_filenames :=
			MBS.dAll_filenames +
			MbsNewGcIdExclusion.dAll_filenames +
			MbsIndTypeExclusion.dAll_filenames +
			MbsProductInclude.dAll_filenames +
			MBSSourceGcExclusion.dAll_filenames +
			MBSFdnIndType.dAll_filenames +
			MBSFdnCCID.dAll_filenames +
			MBSFdnHHID.dAll_filenames +
			MBSTableCol.dAll_filenames +
			MBSColValDesc.dAll_filenames +
			MBSmarketAppend.dAll_filenames +
			MbsFdnMasterIDIndTypeInclusion.dAll_filenames +
			MbsVelocityRules.dAll_filenames;
			
			
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	
		shared Template(string tag) := Platform.FileTemplate(pUseOtherEnvironment) + tag;
		export Main                  := tools.mod_FilenamesBuild(Template('Main'                ),pversion);

		export dAll_filenames :=
			Main.dAll_filenames;
	
	end;
	
	export dAll_filenames :=
		Base.dAll_filenames;
 
end;