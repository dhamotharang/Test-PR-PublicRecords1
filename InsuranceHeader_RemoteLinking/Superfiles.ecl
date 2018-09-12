// Manage superfiles related to incremental build
EXPORT Superfiles := MODULE
	
	EXPORT createSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
            //Current Files
												mod_Superfiles.mac_makeFiles(Filenames.spec_SSN_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_YEAR_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_MONTH_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_DAY_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DL_NBR_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_GENDER_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DERIVED_GENDER_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_NAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_RANGE_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SEC_RANGE_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CITY_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ST_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ZIP_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_POLICY_NUMBER_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CLAIM_NUMBER_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MAINNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDR1_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LOCALE_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDRESS_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FULLNAME_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DT_FIRST_SEEN_SF),            
            mod_Superfiles.mac_makeFiles(Filenames.spec_DT_LAST_SEEN_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SPECIFICITIES_SF),
                      
            //QA Files
												mod_Superfiles.mac_makeFiles(Filenames.spec_SSN_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_YEAR_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_MONTH_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_DAY_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DL_NBR_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_GENDER_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DERIVED_GENDER_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_NAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_RANGE_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SEC_RANGE_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CITY_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ST_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ZIP_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_POLICY_NUMBER_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CLAIM_NUMBER_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MAINNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDR1_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LOCALE_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDRESS_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FULLNAME_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DT_FIRST_SEEN_QA_SF),            
            mod_Superfiles.mac_makeFiles(Filenames.spec_DT_LAST_SEEN_QA_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SPECIFICITIES_QA_SF),
                       
            //Full Files
												mod_Superfiles.mac_makeFiles(Filenames.spec_SSN_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_YEAR_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_MONTH_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DOB_DAY_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DL_NBR_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_GENDER_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DERIVED_GENDER_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_NAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_PRIM_RANGE_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SEC_RANGE_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CITY_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ST_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ZIP_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_POLICY_NUMBER_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_CLAIM_NUMBER_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_MAINNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDR1_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_LOCALE_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_ADDRESS_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_FULLNAME_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_DT_FIRST_SEEN_Full_SF),            
            mod_Superfiles.mac_makeFiles(Filenames.spec_DT_LAST_SEEN_Full_SF),
												mod_Superfiles.mac_makeFiles(Filenames.spec_SPECIFICITIES_Full_SF),
											);	
		RETURN superFiles;
	END;
/*-------------------- updateSuperFiles ----------------------------------------------------*/
// keep 3 versions- remove older automatically
  EXPORT updateSF(newLogicalFile, nameMaker) := FUNCTIONMACRO
    RETURN mod_Superfiles.mac_updateSuperFiles(newLogicalFile, nameMaker,FALSE);
  ENDMACRO;

  EXPORT AddSuper(STRING superfile, STRING logical) := FUNCTION
    RETURN STD.File.AddSuperfile(superfile, logical); 
  END; 
	
// Demote all SF contents - Gone->Grandfather->Father->Current
  EXPORT DemoteSF(nameMaker, deleteNewest = FALSE) := FUNCTIONMACRO
    IMPORT STD;
    RETURN SEQUENTIAL(
      STD.File.ClearSuperFile(nameMaker.current    , deleteNewest),
      STD.File.SwapSuperFile (nameMaker.father     , nameMaker.current),
      STD.File.SwapSuperFile (nameMaker.grandfather, nameMaker.father),
    );
  ENDMACRO;
END;
