EXPORT proc_specPromote(STRING version, BOOLEAN isQA = TRUE, BOOLEAN demote = FALSE) := FUNCTION
  IMPORT STD;
  versionPublish     := version + Filenames.Suffix_Publish;
    
  outputPublishVersion(STRING inFileName, STRING outFileName = '') := FUNCTION
    publishFileName  := IF(TRIM(outFileName) > '', outFileName, inFileName + Filenames.Suffix_Publish);
    RETURN IF(STD.File.FileExists(inFileName) AND NOT STD.File.FileExists(publishFileName), STD.File.Copy(inFileName, thorlib.group(), publishFileName,,,,,TRUE, TRUE));
  END;
  
  outputPublishFiles := PARALLEL(
    outputPublishVersion(Filenames.spec_SSN_LF(version)),
    outputPublishVersion(Filenames.spec_DOB_YEAR_LF(version)),
    outputPublishVersion(Filenames.spec_DOB_MONTH_LF(version)),
    outputPublishVersion(Filenames.spec_DOB_DAY_LF(version)),
    outputPublishVersion(Filenames.spec_DL_NBR_LF(version)),
    outputPublishVersion(Filenames.spec_SNAME_LF(version)),
    outputPublishVersion(Filenames.spec_FNAME_LF(version)), 
    outputPublishVersion(Filenames.spec_MNAME_LF(version)),
    outputPublishVersion(Filenames.spec_LNAME_LF(version)),
    outputPublishVersion(Filenames.spec_GENDER_LF(version)),
    outputPublishVersion(Filenames.spec_DERIVED_GENDER_LF(version)),
    outputPublishVersion(Filenames.spec_PRIM_NAME_LF(version)),
    outputPublishVersion(Filenames.spec_PRIM_RANGE_LF(version)),
    outputPublishVersion(Filenames.spec_SEC_RANGE_LF(version)),
    outputPublishVersion(Filenames.spec_CITY_LF(version)),
    outputPublishVersion(Filenames.spec_ST_LF(version)),
    outputPublishVersion(Filenames.spec_ZIP_LF(version)),
    outputPublishVersion(Filenames.spec_POLICY_NUMBER_LF(version)),
    outputPublishVersion(Filenames.spec_CLAIM_NUMBER_LF(version)),
    outputPublishVersion(Filenames.spec_MAINNAME_LF(version)),
    outputPublishVersion(Filenames.spec_ADDR1_LF(version)),
    outputPublishVersion(Filenames.spec_LOCALE_LF(version)),
    outputPublishVersion(Filenames.spec_ADDRESS_LF(version)),
    outputPublishVersion(Filenames.spec_FULLNAME_LF(version)),
    outputPublishVersion(Filenames.spec_DT_FIRST_SEEN_LF(version)),
    outputPublishVersion(Filenames.spec_DT_LAST_SEEN_LF(version)),
    outputPublishVersion(Filenames.spec_SPECIFICITIES_LF(version))
  );
 
  promoteToQA    := PARALLEL(
    IF(STD.File.FileExists(Filenames.spec_SSN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SSN_LF(versionPublish), Filenames.spec_SSN_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_YEAR_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_YEAR_LF(versionPublish), Filenames.spec_DOB_YEAR_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_MONTH_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_MONTH_LF(versionPublish), Filenames.spec_DOB_MONTH_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_DAY_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_DAY_LF(versionPublish), Filenames.spec_DOB_DAY_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DL_NBR_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DL_NBR_LF(versionPublish), Filenames.spec_DL_NBR_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_SNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SNAME_LF(versionPublish), Filenames.spec_SNAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_FNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_FNAME_LF(versionPublish), Filenames.spec_FNAME_QA_SF)), 
    IF(STD.File.FileExists(Filenames.spec_MNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_MNAME_LF(versionPublish), Filenames.spec_MNAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_LNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_LNAME_LF(versionPublish), Filenames.spec_LNAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_GENDER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_GENDER_LF(versionPublish), Filenames.spec_GENDER_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DERIVED_GENDER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DERIVED_GENDER_LF(versionPublish), Filenames.spec_DERIVED_GENDER_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_PRIM_NAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_PRIM_NAME_LF(versionPublish), Filenames.spec_PRIM_NAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_PRIM_RANGE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_PRIM_RANGE_LF(versionPublish), Filenames.spec_PRIM_RANGE_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_SEC_RANGE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SEC_RANGE_LF(versionPublish), Filenames.spec_SEC_RANGE_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_CITY_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_CITY_LF(versionPublish), Filenames.spec_CITY_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_ST_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ST_LF(versionPublish), Filenames.spec_ST_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_ZIP_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ZIP_LF(versionPublish), Filenames.spec_ZIP_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_POLICY_NUMBER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_POLICY_NUMBER_LF(versionPublish), Filenames.spec_POLICY_NUMBER_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_CLAIM_NUMBER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_CLAIM_NUMBER_LF(versionPublish), Filenames.spec_CLAIM_NUMBER_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_MAINNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_MAINNAME_LF(versionPublish), Filenames.spec_MAINNAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_ADDR1_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ADDR1_LF(versionPublish), Filenames.spec_ADDR1_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_LOCALE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_LOCALE_LF(versionPublish), Filenames.spec_LOCALE_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_ADDRESS_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ADDRESS_LF(versionPublish), Filenames.spec_ADDRESS_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_FULLNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_FULLNAME_LF(versionPublish), Filenames.spec_FULLNAME_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DT_FIRST_SEEN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DT_FIRST_SEEN_LF(versionPublish), Filenames.spec_DT_FIRST_SEEN_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_DT_LAST_SEEN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DT_LAST_SEEN_LF(versionPublish), Filenames.spec_DT_LAST_SEEN_QA_SF)),
    IF(STD.File.FileExists(Filenames.spec_SPECIFICITIES_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SPECIFICITIES_LF(versionPublish), Filenames.spec_SPECIFICITIES_QA_SF))
  );
 
   promoteToCurrent    := PARALLEL(
    IF(STD.File.FileExists(Filenames.spec_SSN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SSN_LF(versionPublish), Filenames.spec_SSN_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_YEAR_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_YEAR_LF(versionPublish), Filenames.spec_DOB_YEAR_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_MONTH_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_MONTH_LF(versionPublish), Filenames.spec_DOB_MONTH_SF)),
    IF(STD.File.FileExists(Filenames.spec_DOB_DAY_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DOB_DAY_LF(versionPublish), Filenames.spec_DOB_DAY_SF)),
    IF(STD.File.FileExists(Filenames.spec_DL_NBR_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DL_NBR_LF(versionPublish), Filenames.spec_DL_NBR_SF)),
    IF(STD.File.FileExists(Filenames.spec_SNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SNAME_LF(versionPublish), Filenames.spec_SNAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_FNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_FNAME_LF(versionPublish), Filenames.spec_FNAME_SF)), 
    IF(STD.File.FileExists(Filenames.spec_MNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_MNAME_LF(versionPublish), Filenames.spec_MNAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_LNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_LNAME_LF(versionPublish), Filenames.spec_LNAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_GENDER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_GENDER_LF(versionPublish), Filenames.spec_GENDER_SF)),
    IF(STD.File.FileExists(Filenames.spec_DERIVED_GENDER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DERIVED_GENDER_LF(versionPublish), Filenames.spec_DERIVED_GENDER_SF)),
    IF(STD.File.FileExists(Filenames.spec_PRIM_NAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_PRIM_NAME_LF(versionPublish), Filenames.spec_PRIM_NAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_PRIM_RANGE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_PRIM_RANGE_LF(versionPublish), Filenames.spec_PRIM_RANGE_SF)),
    IF(STD.File.FileExists(Filenames.spec_SEC_RANGE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SEC_RANGE_LF(versionPublish), Filenames.spec_SEC_RANGE_SF)),
    IF(STD.File.FileExists(Filenames.spec_CITY_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_CITY_LF(versionPublish), Filenames.spec_CITY_SF)),
    IF(STD.File.FileExists(Filenames.spec_ST_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ST_LF(versionPublish), Filenames.spec_ST_SF)),
    IF(STD.File.FileExists(Filenames.spec_ZIP_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ZIP_LF(versionPublish), Filenames.spec_ZIP_SF)),
    IF(STD.File.FileExists(Filenames.spec_POLICY_NUMBER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_POLICY_NUMBER_LF(versionPublish), Filenames.spec_POLICY_NUMBER_SF)),
    IF(STD.File.FileExists(Filenames.spec_CLAIM_NUMBER_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_CLAIM_NUMBER_LF(versionPublish), Filenames.spec_CLAIM_NUMBER_SF)),
    IF(STD.File.FileExists(Filenames.spec_MAINNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_MAINNAME_LF(versionPublish), Filenames.spec_MAINNAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_ADDR1_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ADDR1_LF(versionPublish), Filenames.spec_ADDR1_SF)),
    IF(STD.File.FileExists(Filenames.spec_LOCALE_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_LOCALE_LF(versionPublish), Filenames.spec_LOCALE_SF)),
    IF(STD.File.FileExists(Filenames.spec_ADDRESS_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_ADDRESS_LF(versionPublish), Filenames.spec_ADDRESS_SF)),
    IF(STD.File.FileExists(Filenames.spec_FULLNAME_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_FULLNAME_LF(versionPublish), Filenames.spec_FULLNAME_SF)),
    IF(STD.File.FileExists(Filenames.spec_DT_FIRST_SEEN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DT_FIRST_SEEN_LF(versionPublish), Filenames.spec_DT_FIRST_SEEN_SF)),
    IF(STD.File.FileExists(Filenames.spec_DT_LAST_SEEN_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_DT_LAST_SEEN_LF(versionPublish), Filenames.spec_DT_LAST_SEEN_SF)),
    IF(STD.File.FileExists(Filenames.spec_SPECIFICITIES_LF(versionPublish)), Superfiles.UpdateSF(Filenames.spec_SPECIFICITIES_LF(versionPublish), Filenames.spec_SPECIFICITIES_SF))
  );
  
  demoteQA := PARALLEL(
    Superfiles.DemoteSF(Filenames.spec_SSN_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_YEAR_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_MONTH_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_DAY_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DL_NBR_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_SNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_FNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_MNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_LNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_GENDER_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DERIVED_GENDER_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_PRIM_NAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_PRIM_RANGE_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_SEC_RANGE_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_CITY_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_ST_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_ZIP_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_POLICY_NUMBER_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_CLAIM_NUMBER_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_MAINNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_ADDR1_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_LOCALE_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_ADDRESS_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_FULLNAME_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DT_FIRST_SEEN_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_DT_LAST_SEEN_QA_SF),
    Superfiles.DemoteSF(Filenames.spec_SPECIFICITIES_QA_SF)
  );
  
  demoteCurrent := PARALLEL(
    Superfiles.DemoteSF(Filenames.spec_SSN_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_YEAR_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_MONTH_SF),
    Superfiles.DemoteSF(Filenames.spec_DOB_DAY_SF),
    Superfiles.DemoteSF(Filenames.spec_DL_NBR_SF),
    Superfiles.DemoteSF(Filenames.spec_SNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_FNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_MNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_LNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_GENDER_SF),
    Superfiles.DemoteSF(Filenames.spec_DERIVED_GENDER_SF),
    Superfiles.DemoteSF(Filenames.spec_PRIM_NAME_SF),
    Superfiles.DemoteSF(Filenames.spec_PRIM_RANGE_SF),
    Superfiles.DemoteSF(Filenames.spec_SEC_RANGE_SF),
    Superfiles.DemoteSF(Filenames.spec_CITY_SF),
    Superfiles.DemoteSF(Filenames.spec_ST_SF),
    Superfiles.DemoteSF(Filenames.spec_ZIP_SF),
    Superfiles.DemoteSF(Filenames.spec_POLICY_NUMBER_SF),
    Superfiles.DemoteSF(Filenames.spec_CLAIM_NUMBER_SF),
    Superfiles.DemoteSF(Filenames.spec_MAINNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_ADDR1_SF),
    Superfiles.DemoteSF(Filenames.spec_LOCALE_SF),
    Superfiles.DemoteSF(Filenames.spec_ADDRESS_SF),
    Superfiles.DemoteSF(Filenames.spec_FULLNAME_SF),
    Superfiles.DemoteSF(Filenames.spec_DT_FIRST_SEEN_SF),
    Superfiles.DemoteSF(Filenames.spec_DT_LAST_SEEN_SF),
    Superfiles.DemoteSF(Filenames.spec_SPECIFICITIES_SF)
  );
  
  RETURN 
    IF(isQA,
      IF(NOT demote, 
        SEQUENTIAL(outputPublishFiles,STD.File.StartSuperfileTransaction(),promoteToQA,STD.File.FinishSuperfileTransaction()),
        SEQUENTIAL(STD.File.StartSuperfileTransaction(),demoteQA,STD.File.FinishSuperfileTransaction())),
      IF(NOT demote,
        SEQUENTIAL(STD.File.StartSuperfileTransaction(),promoteToCurrent,STD.File.FinishSuperfileTransaction()),
        SEQUENTIAL(STD.File.StartSuperfileTransaction(),demoteCurrent,STD.File.FinishSuperfileTransaction())));
        
END;