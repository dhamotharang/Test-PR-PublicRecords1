IMPORT ut, lib_Stringlib, STD, OneKey;

EXPORT Standardize_FileB := MODULE

  //////////////////////////////////////////////////////////////////////////////////////
  // -- fPreProcess
  // -- add proprietary dates
  //////////////////////////////////////////////////////////////////////////////////////
  EXPORT fPreProcess(DATASET(OneKey.Layouts.InputB.Sprayed) pRawFileInput
                     ,STRING pversion) := FUNCTION

    OneKey.Layouts.base tPreProcessIndividuals(OneKey.Layouts.InputB.Sprayed l) := TRANSFORM

      //////////////////////////////////////////////////////////////////////////////////////
      // -- Prepare Addresses and Dates for Cleaning using macro
      //////////////////////////////////////////////////////////////////////////////////////       
      addr := Stringlib.Stringcleanspaces(ut.CleanSpacesAndUpper(l.CITY_NM) +
                                          IF(TRIM(l.CITY_NM) <> '',', ','') +
                                          ut.CleanSpacesAndUpper(l.ST_CD) + ' ' +
                                          ut.CleanSpacesAndUpper(l.ZIP5_CD));                
		
      CleanDate := STD.Str.FilterOut(l.DEACTV_DT, '-');
                                
      //////////////////////////////////////////////////////////////////////////////////////
      // -- Map Fields
      //////////////////////////////////////////////////////////////////////////////////////																																												 
      SELF.prep_addr_line1										  := '';
      SELF.prep_addr_line_last								  := addr;
			
      SELF.dt_vendor_first_reported						  := (UNSIGNED4)pversion;
      SELF.dt_vendor_last_reported						  := (UNSIGNED4)pversion;
      SELF.record_type                          := 'C';

      SELF.HCP_HCE_ID                           := TRIM(l.HCP_HCE_ID, LEFT, RIGHT);
      SELF.OK_INDV_ID                           := ut.CleanSpacesAndUpper(l.OK_INDV_ID);
      SELF.SKA_UID                              := TRIM(l.SKA_UID, LEFT, RIGHT);
      SELF.IMS_ID                               := TRIM(l.IMS_ID, LEFT, RIGHT);
      SELF.FRST_NM                              := ut.CleanSpacesAndUpper(l.FRST_NM);
      SELF.MID_NM                               := ut.CleanSpacesAndUpper(l.MID_NM);
      SELF.LAST_NM                              := ut.CleanSpacesAndUpper(l.LAST_NM);
      SELF.SFX_CD                               := ut.CleanSpacesAndUpper(l.SFX_CD);
      SELF.GENDER_CD                            := ut.CleanSpacesAndUpper(l.GENDER_CD);
      SELF.PRIM_PRFSN_CD                        := TRIM(l.PRIM_PRFSN_CD, LEFT, RIGHT);
      SELF.PRIM_PRFSN_DESC                      := ut.CleanSpacesAndUpper(l.PRIM_PRFSN_DESC);
      SELF.PRIM_SPCL_CD                         := ut.CleanSpacesAndUpper(l.PRIM_SPCL_CD);
      SELF.PRIM_SPCL_DESC                       := ut.CleanSpacesAndUpper(l.PRIM_SPCL_DESC);
      SELF.HCE_PRFSNL_STAT_CD                   := ut.CleanSpacesAndUpper(l.HCE_PRFSNL_STAT_CD);
      SELF.HCE_PRFSNL_STAT_DESC                 := ut.CleanSpacesAndUpper(l.HCE_PRFSNL_STAT_DESC);
      SELF.EXCLD_RSN_DESC                       := ut.CleanSpacesAndUpper(l.EXCLD_RSN_DESC);
      SELF.NPI                                  := ut.CleanSpacesAndUpper(l.NPI);
      SELF.DEACTV_DT                            := TRIM(l.DEACTV_DT, LEFT, RIGHT);
      SELF.CLEANED_DEACTV_DT                    := CleanDate;
      SELF.XREF_HCE_ID                          := ut.CleanSpacesAndUpper(l.XREF_HCE_ID);     
      SELF.CITY_NM                              := ut.CleanSpacesAndUpper(l.CITY_NM);
      SELF.ST_CD                                := ut.CleanSpacesAndUpper(l.ST_CD);
      SELF.ZIP5_CD                              := TRIM(l.ZIP5_CD, LEFT, RIGHT);

      SELF                                      := l;
      SELF                                      := [];
			
    END;
		
    dPreProcess := PROJECT(pRawFileInput, tPreProcessIndividuals(LEFT));
	
    RETURN dPreProcess;

	END;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll(DATASET(OneKey.Layouts.InputB.Sprayed) pRawFileInputB
             ,STRING pversion
             ,STRING pPersistnameB = OneKey.Filenames().PersistStandardizeInputB) := FUNCTION
	
    dPreprocessB := fPreProcess(pRawFileInputB, pversion) : PERSIST(pPersistnameB);

    RETURN dPreprocessB;
	
  END;

END;