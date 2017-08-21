IMPORT tools, Corp2_Raw_AL;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AL._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT crAnlPf := tools.mod_FilenamesInput(Template('crAnlPf::AL'), pversion);
		EXPORT crBusPf := tools.mod_FilenamesInput(Template('crBusPf::AL'), pversion);		
		EXPORT crHstPf := tools.mod_FilenamesInput(Template('crHstPf::AL'), pversion);		
		EXPORT crIncPf := tools.mod_FilenamesInput(Template('crIncPf::AL'), pversion);		
		EXPORT crMstPf := tools.mod_FilenamesInput(Template('crMstPf::AL'), pversion);	
		EXPORT crNamPf := tools.mod_FilenamesInput(Template('crNamPf::AL'), pversion);	
    EXPORT crOffPf := tools.mod_FilenamesInput(Template('crOffPf::AL'), pversion);	
		EXPORT crSerPf := tools.mod_FilenamesInput(Template('crSerPf::AL'), pversion);	
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AL._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT crAnlPf := tools.mod_FilenamesBuild(Template('crAnlPf::AL'), pversion);
		EXPORT crBusPf := tools.mod_FilenamesBuild(Template('crBusPf::AL'), pversion);		
		EXPORT crHstPf := tools.mod_FilenamesBuild(Template('crHstPf::AL'), pversion);		
		EXPORT crIncPf := tools.mod_FilenamesBuild(Template('crIncPf::AL'), pversion);
		EXPORT crMstPf := tools.mod_FilenamesBuild(Template('crMstPf::AL'), pversion);
		EXPORT crNamPf := tools.mod_FilenamesBuild(Template('crNamPf::AL'), pversion);
		EXPORT crOffPf := tools.mod_FilenamesBuild(Template('crOffPf::AL'), pversion);
		EXPORT crSerPf := tools.mod_FilenamesBuild(Template('crSerPf::AL'), pversion);
		
		EXPORT dAll_crAnlPf := crAnlPf.dAll_filenames;
		EXPORT dAll_crBusPf := crBusPf.dAll_filenames;
		EXPORT dAll_crHstPf := crHstPf.dAll_filenames;
		EXPORT dAll_crIncPf := crIncPf.dAll_filenames;	
		EXPORT dAll_crMstPf := crMstPf.dAll_filenames;
		EXPORT dAll_crNamPf := crNamPf.dAll_filenames;
		EXPORT dAll_crOffPf := crOffPf.dAll_filenames;
		EXPORT dAll_crSerPf := crSerPf.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_crAnlPf +
													 Base.dAll_crBusPf +
													 Base.dAll_crHstPf	+
													 Base.dAll_crIncPf +
													 Base.dAll_crMstPf +
													 Base.dAll_crNamPf +
													 Base.dAll_crOffPf +
													 Base.dAll_crSerPf ;
	
END;