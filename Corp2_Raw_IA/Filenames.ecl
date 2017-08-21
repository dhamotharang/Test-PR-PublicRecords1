IMPORT tools, Corp2_Raw_IA;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_IA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT crpAdd := tools.mod_FilenamesInput(Template('crpAdd::IA'), pversion);
		EXPORT crpAgt := tools.mod_FilenamesInput(Template('crpAgt::IA'), pversion);		
		EXPORT crpDes := tools.mod_FilenamesInput(Template('crpDes::IA'), pversion);		
		EXPORT crpFil := tools.mod_FilenamesInput(Template('crpFil::IA'), pversion);		
		EXPORT crpHis := tools.mod_FilenamesInput(Template('crpHis::IA'), pversion);	
		EXPORT crpNam := tools.mod_FilenamesInput(Template('crpNam::IA'), pversion);	
    EXPORT crpOff := tools.mod_FilenamesInput(Template('crpOff::IA'), pversion);	
		EXPORT crpPrt := tools.mod_FilenamesInput(Template('crpPrt::IA'), pversion);	
		EXPORT crpRem := tools.mod_FilenamesInput(Template('crpRem::IA'), pversion);	
		EXPORT crpStk := tools.mod_FilenamesInput(Template('crpStk::IA'), pversion);	
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_IA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT crpAdd := tools.mod_FilenamesBuild(Template('crpAdd::IA'), pversion);
		EXPORT crpAgt := tools.mod_FilenamesBuild(Template('crpAgt::IA'), pversion);		
		EXPORT crpDes := tools.mod_FilenamesBuild(Template('crpDes::IA'), pversion);		
		EXPORT crpFil := tools.mod_FilenamesBuild(Template('crpFil::IA'), pversion);
		EXPORT crpHis := tools.mod_FilenamesBuild(Template('crpHis::IA'), pversion);
		EXPORT crpNam := tools.mod_FilenamesBuild(Template('crpNam::IA'), pversion);
		EXPORT crpOff := tools.mod_FilenamesBuild(Template('crpOff::IA'), pversion);
		EXPORT crpPrt := tools.mod_FilenamesBuild(Template('crpPrt::IA'), pversion);
		EXPORT crpRem := tools.mod_FilenamesBuild(Template('crpRem::IA'), pversion);
		EXPORT crpStk := tools.mod_FilenamesBuild(Template('crpStk::IA'), pversion);

		EXPORT dAll_crpAdd := crpAdd.dAll_filenames;
		EXPORT dAll_crpAgt := crpAgt.dAll_filenames;
		EXPORT dAll_crpDes := crpDes.dAll_filenames;
		EXPORT dAll_crpFil := crpFil.dAll_filenames;	
		EXPORT dAll_crpHis := crpHis.dAll_filenames;
		EXPORT dAll_crpNam := crpNam.dAll_filenames;
		EXPORT dAll_crpOff := crpOff.dAll_filenames;
		EXPORT dAll_crpPrt := crpPrt.dAll_filenames;
		EXPORT dAll_crpRem := crpRem.dAll_filenames;
		EXPORT dAll_crpStk := crpStk.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_crpAdd +
													 Base.dAll_crpAgt +
													 Base.dAll_crpDes	+
													 Base.dAll_crpFil +
													 Base.dAll_crpHis +
													 Base.dAll_crpNam +
													 Base.dAll_crpOff +
													 Base.dAll_crpPrt +
													 Base.dAll_crpRem +
													 Base.dAll_crpStk	;
	
END;