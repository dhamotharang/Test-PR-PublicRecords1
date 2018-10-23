EXPORT proc_SpecKeyBuild(STRING version) := FUNCTION
  #CONSTANT('Superfile_Name','full');
  BuildKeys := InsuranceHeader_RemoteLinking.specificities(InsuranceHeader_RemoteLinking.File_HEADER).BuildAll(version);
  BuildSpec := InsuranceHeader_RemoteLinking.specificities(InsuranceHeader_RemoteLinking.File_HEADER).BuildSpec(version);
  
  UpdateSuperfiles_keys := PARALLEL(
    Superfiles.UpdateSF(Filenames.spec_SSN_LF(version), Filenames.spec_SSN_Full_SF),//SPEC
    Superfiles.UpdateSF(Filenames.spec_DOB_YEAR_LF(version), Filenames.spec_DOB_YEAR_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DOB_MONTH_LF(version), Filenames.spec_DOB_MONTH_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DOB_DAY_LF(version), Filenames.spec_DOB_DAY_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DL_NBR_LF(version), Filenames.spec_DL_NBR_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_SNAME_LF(version), Filenames.spec_SNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_FNAME_LF(version), Filenames.spec_FNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_MNAME_LF(version), Filenames.spec_MNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_LNAME_LF(version), Filenames.spec_LNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_GENDER_LF(version), Filenames.spec_GENDER_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DERIVED_GENDER_LF(version), Filenames.spec_DERIVED_GENDER_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_PRIM_NAME_LF(version), Filenames.spec_PRIM_NAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_PRIM_RANGE_LF(version), Filenames.spec_PRIM_RANGE_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_SEC_RANGE_LF(version), Filenames.spec_SEC_RANGE_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_CITY_LF(version), Filenames.spec_CITY_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_ST_LF(version), Filenames.spec_ST_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_ZIP_LF(version), Filenames.spec_ZIP_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_POLICY_NUMBER_LF(version), Filenames.spec_POLICY_NUMBER_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_CLAIM_NUMBER_LF(version), Filenames.spec_CLAIM_NUMBER_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_MAINNAME_LF(version), Filenames.spec_MAINNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_ADDR1_LF(version), Filenames.spec_ADDR1_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_LOCALE_LF(version), Filenames.spec_LOCALE_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_ADDRESS_LF(version), Filenames.spec_ADDRESS_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_FULLNAME_LF(version), Filenames.spec_FULLNAME_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DT_FIRST_SEEN_LF(version), Filenames.spec_DT_FIRST_SEEN_Full_SF),
    Superfiles.UpdateSF(Filenames.spec_DT_LAST_SEEN_LF(version), Filenames.spec_DT_LAST_SEEN_Full_SF)
  );
  
  UpdateSuperfiles_spec := PARALLEL(
      Superfiles.UpdateSF(Filenames.spec_SPECIFICITIES_LF(version), Filenames.spec_SPECIFICITIES_Full_SF)
  );
  
  RETURN SEQUENTIAL(
    InsuranceHeader_RemoteLinking.Superfiles.createSuperfiles(),
    BuildKeys,
    STD.File.StartSuperfileTransaction(),    
    UpdateSuperfiles_keys,
    STD.File.FinishSuperfileTransaction(),
    BuildSpec,
    STD.File.StartSuperfileTransaction(),    
    UpdateSuperfiles_spec,
    STD.File.FinishSuperfileTransaction()
  );
END;
  
  
  
  
  
  
  
  
