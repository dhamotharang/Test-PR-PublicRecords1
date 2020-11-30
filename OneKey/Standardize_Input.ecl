IMPORT ut, lib_Stringlib, MDR, OneKey;

EXPORT Standardize_Input := MODULE

  //////////////////////////////////////////////////////////////////////////////////////
  // -- fPreProcessA
  // -- add proprietary dates
  //////////////////////////////////////////////////////////////////////////////////////
  EXPORT fPreProcess(DATASET(OneKey.Layouts.InputA.Sprayed) pRawFileInput
                    ,STRING pversion) := FUNCTION
	
    OneKey.Layouts.base tPreProcessIndividuals(OneKey.Layouts.InputA.Sprayed l) := TRANSFORM

      //////////////////////////////////////////////////////////////////////////////////////
      // -- Prepare Addresses and Phone Numbers for Cleaning using macro
      //////////////////////////////////////////////////////////////////////////////////////
      addr1 := Stringlib.Stringcleanspaces(ut.CleanSpacesAndUpper(l.ADDR_LN_1_TXT) + ' ' + 
                                           ut.CleanSpacesAndUpper(l.ADDR_LN_2_TXT));        
      addr2 := Stringlib.Stringcleanspaces(ut.CleanSpacesAndUpper(l.CITY_NM) +
                                           IF(TRIM(l.CITY_NM) <> '',', ','') +
                                           ut.CleanSpacesAndUpper(l.ST_CD) + ' ' +
                                           ut.CleanSpacesAndUpper(l.ZIP5_CD));                

      Cln_Phone := ut.CleanPhone(l.TELEPHN_NBR);

      //////////////////////////////////////////////////////////////////////////////////////
      // -- Map Fields
      //////////////////////////////////////////////////////////////////////////////////////																																												 
      SELF.prep_addr_line1										:= addr1;
      SELF.prep_addr_line_last								:= addr2;

      SELF.source                               := MDR.sourceTools.src_SKA;
      SELF.dt_vendor_first_reported						:= (UNSIGNED4)pversion;
      SELF.dt_vendor_last_reported						:= (UNSIGNED4)pversion;
      SELF.record_type                          := 'C';
						
      SELF.HCP_HCE_ID                           := TRIM(l.HCP_HCE_ID, LEFT, RIGHT);
      SELF.OK_INDV_ID                           := ut.CleanSpacesAndUpper(l.OK_INDV_ID);
      SELF.SKA_UID                              := TRIM(l.SKA_UID, LEFT, RIGHT);
      SELF.FRST_NM                              := ut.CleanSpacesAndUpper(l.FRST_NM);
      SELF.MID_NM                               := ut.CleanSpacesAndUpper(l.MID_NM);
      SELF.LAST_NM                              := ut.CleanSpacesAndUpper(l.LAST_NM);
      SELF.SFX_CD                               := ut.CleanSpacesAndUpper(l.SFX_CD);
      SELF.GENDER_CD                            := ut.CleanSpacesAndUpper(l.GENDER_CD);
      SELF.PRIM_PRFSN_CD                        := TRIM(l.PRIM_PRFSN_CD, LEFT, RIGHT);
      SELF.PRIM_PRFSN_DESC                      := ut.CleanSpacesAndUpper(l.PRIM_PRFSN_DESC);
      SELF.PRIM_SPCL_CD                         := ut.CleanSpacesAndUpper(l.PRIM_SPCL_CD);
      SELF.PRIM_SPCL_DESC                       := ut.CleanSpacesAndUpper(l.PRIM_SPCL_DESC);
      SELF.SEC_SPCL_CD                          := ut.CleanSpacesAndUpper(l.SEC_SPCL_CD);
      SELF.SEC_SPCL_DESC                        := ut.CleanSpacesAndUpper(l.SEC_SPCL_DESC);
      SELF.TERT_SPCL_CD                         := ut.CleanSpacesAndUpper(l.TERT_SPCL_CD);
      SELF.TERT_SPCL_DESC                       := ut.CleanSpacesAndUpper(l.TERT_SPCL_DESC);
      SELF.SUB_SPCL_CD                          := ut.CleanSpacesAndUpper(l.SUB_SPCL_CD);
      SELF.SUB_SPCL_DESC                        := ut.CleanSpacesAndUpper(l.SUB_SPCL_DESC);
      SELF.TITL_TYP_ID                          := TRIM(l.TITL_TYP_ID, LEFT, RIGHT);
      SELF.TITL_TYP_DESC                        := ut.CleanSpacesAndUpper(l.TITL_TYP_DESC);
      SELF.HCO_HCE_ID                           := TRIM(l.HCP_HCE_ID, LEFT, RIGHT);
      SELF.OK_WKP_ID                            := ut.CleanSpacesAndUpper(l.OK_WKP_ID);
      SELF.SKA_ID                               := TRIM(l.SKA_ID, LEFT, RIGHT);
      SELF.BUS_NM                               := ut.CleanSpacesAndUpper(l.BUS_NM);
      SELF.DBA_NM                               := ut.CleanSpacesAndUpper(l.DBA_NM);
      SELF.ADDR_ID                              := TRIM(l.ADDR_ID, LEFT, RIGHT);
      SELF.STR_FRONT_ID                         := TRIM(l.STR_FRONT_ID, LEFT, RIGHT);
      SELF.ADDR_LN_1_TXT                        := ut.CleanSpacesAndUpper(l.ADDR_LN_1_TXT);
      SELF.ADDR_LN_2_TXT                        := ut.CleanSpacesAndUpper(l.ADDR_LN_1_TXT);
      SELF.CITY_NM                              := ut.CleanSpacesAndUpper(l.CITY_NM);
      SELF.ST_CD                                := ut.CleanSpacesAndUpper(l.ST_CD);
      SELF.ZIP5_CD                              := TRIM(l.ZIP5_CD, LEFT, RIGHT);
      SELF.ZIP4_CD                              := TRIM(l.ZIP4_CD, LEFT, RIGHT);
      SELF.FIPS_CNTY_CD                         := TRIM(l.FIPS_CNTY_CD, LEFT, RIGHT);
      SELF.FIPS_CNTY_DESC                       := ut.CleanSpacesAndUpper(l.FIPS_CNTY_DESC);
      SELF.TELEPHN_NBR                          := TRIM(l.TELEPHN_NBR, LEFT, RIGHT);
      SELF.CLEAN_PHONE                          := Cln_Phone;
      SELF.COT_ID                               := TRIM(l.COT_ID, LEFT, RIGHT);
      SELF.COT_CLAS_ID                          := TRIM(l.COT_CLAS_ID, LEFT, RIGHT);
      SELF.COT_CLAS_DESC                        := ut.CleanSpacesAndUpper(l.COT_CLAS_DESC);
      SELF.COT_FCLT_TYP_ID                      := TRIM(l.COT_FCLT_TYP_ID, LEFT, RIGHT);
      SELF.COT_FCLT_TYP_DESC                    := ut.CleanSpacesAndUpper(l.COT_FCLT_TYP_DESC);
      SELF.COT_SPCL_ID                          := TRIM(l.COT_SPCL_ID, LEFT, RIGHT);
      SELF.COT_SPCL_DESC                        := ut.CleanSpacesAndUpper(l.COT_SPCL_DESC);
      SELF.EMAIL_IND_FLAG                       := ut.CleanSpacesAndUpper(l.EMAIL_IND_FLAG);
      SELF.HCP_AFFIL_XID                        := TRIM(l.HCP_AFFIL_XID, LEFT, RIGHT);
      SELF.DELTA_CD                             := ut.CleanSpacesAndUpper(l.DELTA_CD);

      SELF.SOURCE_REC_ID                        := HASH64(
                                                     HASHMD5(
                                                       SELF.HCP_HCE_ID    + ',' + SELF.OK_INDV_ID      + ',' + SELF.FRST_NM        + ',' +
                                                       SELF.MID_NM        + ',' + SELF.LAST_NM         + ',' + SELF.SFX_CD         + ',' +
                                                       SELF.GENDER_CD     + ',' + SELF.PRIM_PRFSN_CD   + ',' + SELF.PRIM_SPCL_CD   + ',' +
                                                       SELF.SEC_SPCL_CD   + ',' + SELF.TERT_SPCL_CD    + ',' + SELF.SUB_SPCL_CD    + ',' +
                                                       SELF.TITL_TYP_ID   + ',' + SELF.HCO_HCE_ID      + ',' + SELF.OK_WKP_ID      + ',' +
                                                       SELF.BUS_NM        + ',' + SELF.DBA_NM          + ',' + SELF.ADDR_ID        + ',' +
                                                       SELF.STR_FRONT_ID  + ',' + SELF.ADDR_LN_1_TXT   + ',' + SELF.ADDR_LN_2_TXT  + ',' +
                                                       SELF.CITY_NM       + ',' + SELF.ST_CD           + ',' + SELF.ZIP5_CD        + ',' +
                                                       SELF.FIPS_CNTY_CD  + ',' + SELF.TELEPHN_NBR     + ',' + SELF.COT_ID         + ',' +
                                                       SELF.COT_CLAS_ID   + ',' + SELF.COT_FCLT_TYP_ID + ',' + SELF.COT_SPCL_ID
                                                     )
                                                   );

  
      SELF                                      := l;
      SELF                                      := [];
			
    END;
		
    dPreProcess := PROJECT(pRawFileInput, tPreProcessIndividuals(LEFT));
	
    RETURN dPreProcess;

	END;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll(DATASET(OneKey.Layouts.InputA.Sprayed) pRawFileInputA
             ,STRING pversion
             ,STRING pPersistnameA = OneKey.Filenames().PersistStandardizeInputA) := FUNCTION
	
    dPreprocessA := fPreProcess(pRawFileInputA, pversion) : PERSIST(pPersistnameA);

    RETURN dPreprocessA;
	
  END;

END;