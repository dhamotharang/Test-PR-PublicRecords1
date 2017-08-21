ds_main := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::main',
				                      AMS.Layouts.Base.Main, THOR),
									    HASH(ams_id));
							
ds_license := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::statelicense',
				                         AMS.Layouts.Base.StateLicense, THOR),
									       HASH(ams_id));

ds_spec := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::specialty',
				                      AMS.Layouts.Base.Specialty, THOR),
								      HASH(ams_id));

ds_idnum := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::idnumber',
				                       AMS.Layouts.Base.IDNumber, THOR),
									     HASH(ams_id));

ds_degree := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::degree',
				                        AMS.Layouts.Base.Degree, THOR),
									      HASH(ams_id));

ds_cred := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::credential',
				                      AMS.Layouts.Base.Credential, THOR),
									    HASH(ams_id));

ds_affil := DISTRIBUTE(DATASET('~thor_data400::base::ams::20120109::affiliation',
				                       AMS.Layouts.Base.Affiliation, THOR),
									     HASH(ams_parent_id));

main_plus_lic_rec := RECORD
  AMS.Layouts.Base.Main;
	unsigned4 lic_dt_first_seen;
	unsigned4 lic_dt_last_seen;
	unsigned4 lic_dt_vendor_first_reported;
	unsigned4 lic_dt_vendor_last_reported;
	string1 lic_record_type;
	string8 LIC_AMS_ID; 
	string20 LIC_INDY_ID;
	string LIC_SRC_CD; 
	string20 ST_LIC_NUM;
	string ST_LIC_BRD_CD;
	string2 ST_LIC_STATE;
	string ST_LIC_DEGREE;
	string ST_LIC_TYPE;
	string ST_LIC_STATUS;
	string ST_LIC_EXP_DATE;
	string ST_LIC_ISSUE_DATE;
	string ST_LIC_BRD_DATE;
	string ELIGIBILITY_CD;
	string LIC_SRC_CD_DESC;
	string ST_LIC_STATE_DESC;
	string ST_LIC_DEGREE_DESC;
	string ST_LIC_TYPE_DESC;
	string ST_LIC_STATUS_DESC;
	string ELIGIBILITY_CD_DESC;
END;

main_plus_lic_rec add_license_data(AMS.Layouts.Base.Main L, AMS.Layouts.Base.StateLicense R) := TRANSFORM
  SELF.lic_dt_first_seen := R.dt_first_seen;
	SELF.lic_dt_last_seen := R.dt_last_seen;
	SELF.lic_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.lic_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.lic_record_type := R.record_type;
	SELF.LIC_AMS_ID := R.AMS_ID;
	SELF.LIC_INDY_ID := R.rawfields.INDY_ID;
	SELF.LIC_SRC_CD := R.rawfields.SRC_CD;
	SELF.ST_LIC_NUM := R.rawfields.ST_LIC_NUM;
	SELF.ST_LIC_BRD_CD := R.rawfields.ST_LIC_BRD_CD;
	SELF.ST_LIC_STATE := R.rawfields.ST_LIC_STATE;
	SELF.ST_LIC_DEGREE := R.rawfields.ST_LIC_DEGREE;
	SELF.ST_LIC_TYPE := R.rawfields.ST_LIC_TYPE;
	SELF.ST_LIC_STATUS := R.rawfields.ST_LIC_STATUS;
	SELF.ST_LIC_EXP_DATE := R.rawfields.ST_LIC_EXP_DATE;
	SELF.ST_LIC_ISSUE_DATE := R.rawfields.ST_LIC_ISSUE_DATE;
	SELF.ST_LIC_BRD_DATE := R.rawfields.ST_LIC_BRD_DATE;
	SELF.ELIGIBILITY_CD := R.rawfields.ELIGIBILITY_CD;
	SELF.LIC_SRC_CD_DESC := R.SRC_CD_DESC;

  SELF := L;
	SELF := R;
END;

ds_main_lic := JOIN(ds_main, ds_license,
                    LEFT.ams_id = RIGHT.ams_id,
					          add_license_data(LEFT, RIGHT),
					          LEFT OUTER,
										LOCAL);
										
plus_specialty_rec := RECORD
  main_plus_lic_rec;
	unsigned4 spec_dt_first_seen;
	unsigned4 spec_dt_last_seen;
	unsigned4 spec_dt_vendor_first_reported;
	unsigned4 spec_dt_vendor_last_reported;
	string1 spec_record_type;
	string8 SPEC_AMS_ID;
	string SPECIALTY_TYPE;
	string SPECIALTY;
	string SPEC_SRC_CD;
	string SPECIALTY_DESC;
	string SPEC_SRC_CD_DESC;
END;

plus_specialty_rec add_specialty_data(main_plus_lic_rec L, AMS.Layouts.Base.Specialty R) := TRANSFORM
  SELF.spec_dt_first_seen := R.dt_first_seen;
	SELF.spec_dt_last_seen := R.dt_last_seen;
	SELF.spec_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.spec_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.spec_record_type := R.record_type;
	SELF.SPEC_AMS_ID := R.AMS_ID;
	SELF.SPECIALTY_TYPE := R.rawfields.SPECIALTY_TYPE;
	SELF.SPECIALTY := R.rawfields.SPECIALTY;
	SELF.SPEC_SRC_CD := R.rawfields.SRC_CD;
	SELF.SPECIALTY_DESC := R.SPECIALTY_DESC;
	SELF.SPEC_SRC_CD_DESC := R.SRC_CD_DESC;

  SELF := L;
END;

ds_plus_spec := JOIN(ds_main_lic, ds_spec,
                     LEFT.ams_id = RIGHT.ams_id,
					           add_specialty_data(LEFT, RIGHT),
					           LEFT OUTER,
										 LOCAL);

plus_idnumber_rec := RECORD
  plus_specialty_rec;
	unsigned4 idnum_dt_first_seen;
	unsigned4 idnum_dt_last_seen;
	unsigned4 idnum_dt_vendor_first_reported;
	unsigned4 idnum_dt_vendor_last_reported;
	string1 idnum_record_type;
	string8 IDNUM_AMS_ID;
	string20 IDNUM_INDY_ID;
	string IDNUM_SRC_CD;
	string IDNUM_INDY_ID_END_DATE;
	string IDNUM_END_DATE_REASON;
	string IDNUM_SRC_CD_DESC;
END;

plus_idnumber_rec add_idnumber_data(plus_specialty_rec L, AMS.Layouts.Base.IDNumber R) := TRANSFORM
  SELF.idnum_dt_first_seen := R.dt_first_seen;
	SELF.idnum_dt_last_seen := R.dt_last_seen;
	SELF.idnum_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.idnum_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.idnum_record_type := R.record_type;
	SELF.IDNUM_AMS_ID := R.AMS_ID;
	SELF.IDNUM_INDY_ID := R.rawfields.INDY_ID;
	SELF.IDNUM_INDY_ID_END_DATE := R.rawfields.INDY_ID_END_DATE;
	SELF.IDNUM_END_DATE_REASON := R.rawfields.END_DATE_REASON;
	SELF.IDNUM_SRC_CD := R.rawfields.SRC_CD;
	SELF.IDNUM_SRC_CD_DESC := R.SRC_CD_DESC;

  SELF := L;
END;

ds_plus_idnum := JOIN(ds_plus_spec, ds_idnum,
                      LEFT.ams_id = RIGHT.ams_id,
					            add_idnumber_data(LEFT, RIGHT),
					            LEFT OUTER,
										  LOCAL);

plus_degree_rec := RECORD
  plus_idnumber_rec;
	unsigned4 degree_dt_first_seen;
	unsigned4 degree_dt_last_seen;
	unsigned4 degree_dt_vendor_first_reported;
	unsigned4 degree_dt_vendor_last_reported;
	string1 degree_record_type;
	string8 DEGREE_AMS_ID;
	string DEGREE;
	string BEST_DEGREE;
	string DEGREE_DESC;
END;

plus_degree_rec add_degree_data(plus_idnumber_rec L, AMS.Layouts.Base.Degree R) := TRANSFORM
  SELF.degree_dt_first_seen := R.dt_first_seen;
	SELF.degree_dt_last_seen := R.dt_last_seen;
	SELF.degree_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.degree_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.degree_record_type := R.record_type;
	SELF.DEGREE_AMS_ID := R.AMS_ID;
	SELF.DEGREE := R.rawfields.DEGREE;
	SELF.BEST_DEGREE := R.rawfields.BEST_DEGREE;
	SELF.DEGREE_DESC := R.DEGREE_DESC;

  SELF := L;
END;

ds_plus_degree := JOIN(ds_plus_idnum, ds_degree,
                       LEFT.ams_id = RIGHT.ams_id,
					             add_degree_data(LEFT, RIGHT),
					             LEFT OUTER,
										   LOCAL);

plus_cred_rec := RECORD
  plus_degree_rec;
	unsigned4 cred_dt_first_seen;
	unsigned4 cred_dt_last_seen;
	unsigned4 cred_dt_vendor_first_reported;
	unsigned4 cred_dt_vendor_last_reported;
	string1 cred_record_type;
	string8 CRED_AMS_ID;
	string CREDENTIAL;
	string CREDENTIAL_DESC;
END;

plus_cred_rec add_cred_data(plus_degree_rec L, AMS.Layouts.Base.Credential R) := TRANSFORM
  SELF.cred_dt_first_seen := R.dt_first_seen;
	SELF.cred_dt_last_seen := R.dt_last_seen;
	SELF.cred_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.cred_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.cred_record_type := R.record_type;
	SELF.CRED_AMS_ID := R.AMS_ID;
	SELF.CREDENTIAL := R.rawfields.CREDENTIAL;
	SELF.CREDENTIAL_DESC := R.CREDENTIAL_DESC;

  SELF := L;
END;

ds_plus_cred := JOIN(ds_plus_degree, ds_cred,
                     LEFT.ams_id = RIGHT.ams_id,
					           add_cred_data(LEFT, RIGHT),
					           LEFT OUTER,
										 LOCAL);

plus_affil_rec := RECORD
  plus_cred_rec;
	unsigned4 affil_dt_first_seen;
	unsigned4 affil_dt_last_seen;
	unsigned4 affil_dt_vendor_first_reported;
	unsigned4 affil_dt_vendor_last_reported;
	string1 affil_record_type;
	string8 AFFIL_PARENT_AMS_ID;
	string8 AFFIL_CHILD_AMS_ID;
	string AFFIL_SRC_CD;
	string AFFIL_STATUS;
	string AFFIL_TYPE;
	string AFFIL_UPDATE_DATE;
	string AFFIL_START_DATE;
	string AFFIL_END_DATE;
	string AFFIL_SRC_CD_DESC;
END;

plus_affil_rec add_affil_data(plus_cred_rec L, AMS.Layouts.Base.Affiliation R) := TRANSFORM
  SELF.affil_dt_first_seen := R.dt_first_seen;
	SELF.affil_dt_last_seen := R.dt_last_seen;
	SELF.affil_dt_vendor_first_reported := R.dt_vendor_first_reported;
	SELF.affil_dt_vendor_last_reported := R.dt_vendor_last_reported;
	SELF.affil_record_type := R.record_type;
	SELF.AFFIL_PARENT_AMS_ID := R.AMS_PARENT_ID;
	SELF.AFFIL_CHILD_AMS_ID := R.AMS_CHILD_ID;
	SELF.AFFIL_SRC_CD := R.rawfields.SRC_CD;
	SELF.AFFIL_STATUS := R.rawfields.AFFIL_STATUS;
	SELF.AFFIL_TYPE := R.rawfields.AFFIL_TYPE;
	SELF.AFFIL_UPDATE_DATE := R.rawfields.AFFIL_UPDATE_DATE;
	SELF.AFFIL_START_DATE := R.rawfields.AFFIL_START_DATE;
	SELF.AFFIL_END_DATE := R.rawfields.AFFIL_END_DATE;
	SELF.AFFIL_SRC_CD_DESC := R.SRC_CD_DESC;

  SELF := L;
END;

ds := JOIN(ds_plus_cred, ds_affil,
           LEFT.ams_id = RIGHT.ams_parent_id,
					 add_affil_data(LEFT, RIGHT),
					 LEFT OUTER,
					 LOCAL);

OUTPUT(ds);

Field_PopulationStats := RECORD
  CountGroup 												:= COUNT(GROUP);
	xAMS_ID 													:= AVE(GROUP, IF(ds.AMS_ID <> '', 100, 0));
	xAMSID_TYPE 											:= AVE(GROUP, IF(ds.AMSID_TYPE <> '', 100, 0));
	xAMSID_SUBTYPE 										:= AVE(GROUP, IF(ds.AMSID_SUBTYPE <> '', 100, 0));
	xRecord_type 											:= AVE(GROUP, IF(ds.record_type <> '', 100, 0));
	xDt_first_seen 										:= AVE(GROUP, IF(ds.dt_first_seen <> 0, 100, 0));
	xDt_last_seen											:= AVE(GROUP, IF(ds.dt_last_seen <> 0, 100, 0));
	xDt_vendor_first_reported					:= AVE(GROUP, IF(ds.dt_vendor_first_reported <> 0, 100, 0));
	xDt_vendor_last_reported					:= AVE(GROUP, IF(ds.dt_vendor_last_reported <> 0, 100, 0));
	xDid															:= AVE(GROUP, IF(ds.did <> 0, 100, 0));
	xDid_score												:= AVE(GROUP, IF(ds.did_score <> 0, 100, 0));
	xBdid															:= AVE(GROUP, IF(ds.bdid <> 0, 100, 0));
	xBdid_score												:= AVE(GROUP, IF(ds.bdid_score <> 0, 100, 0));
	xAMS_GOLD_FLAG										:= AVE(GROUP, IF(ds.rawdemographicsfields.AMS_GOLD_FLAG <> '', 100, 0));
	xINDY_ID													:= AVE(GROUP, IF(ds.rawdemographicsfields.INDY_ID <> '', 100, 0));
	xSRC_CD														:= AVE(GROUP, IF(ds.rawdemographicsfields.SRC_CD <> '', 100, 0));
	xACCT_NAME												:= AVE(GROUP, IF(ds.rawdemographicsfields.ACCT_NAME <> '', 100, 0));
	xALT_NAME													:= AVE(GROUP, IF(ds.rawdemographicsfields.ALT_NAME <> '', 100, 0));
	xFULL_NAME												:= AVE(GROUP, IF(ds.rawdemographicsfields.FULL_NAME <> '', 100, 0));
	xLAST_NAME												:= AVE(GROUP, IF(ds.rawdemographicsfields.LAST_NAME <> '', 100, 0));
	xFIRST_NAME												:= AVE(GROUP, IF(ds.rawdemographicsfields.FIRST_NAME <> '', 100, 0));
	xMIDDLE_NAME											:= AVE(GROUP, IF(ds.rawdemographicsfields.MIDDLE_NAME <> '', 100, 0));
	xSUFFIX_NAME											:= AVE(GROUP, IF(ds.rawdemographicsfields.SUFFIX_NAME <> '', 100, 0));
	xFORMER_LAST_NAME									:= AVE(GROUP, IF(ds.rawdemographicsfields.FORMER_LAST_NAME <> '', 100, 0));
	xFORMER_FIRST_NAME								:= AVE(GROUP, IF(ds.rawdemographicsfields.FORMER_FIRST_NAME <> '', 100, 0));
	xFORMER_MIDDLE_NAME								:= AVE(GROUP, IF(ds.rawdemographicsfields.FORMER_MIDDLE_NAME <> '', 100, 0));
	xFORMER_SUFFIX_NAME								:= AVE(GROUP, IF(ds.rawdemographicsfields.FORMER_SUFFIX_NAME <> '', 100, 0));
	xNICK_NAME												:= AVE(GROUP, IF(ds.rawdemographicsfields.NICK_NAME <> '', 100, 0));
	xSECTOR_CD												:= AVE(GROUP, IF(ds.rawdemographicsfields.SECTOR_CD <> '', 100, 0));
	xFISCAL_CD												:= AVE(GROUP, IF(ds.rawdemographicsfields.FISCAL_CD <> '', 100, 0));
	xACADEMIC_FLAG										:= AVE(GROUP, IF(ds.rawdemographicsfields.ACADEMIC_FLAG <> '', 100, 0));
	xGEN_CD														:= AVE(GROUP, IF(ds.rawdemographicsfields.GEN_CD <> '', 100, 0));
	xDOB_DATE													:= AVE(GROUP, IF(ds.rawdemographicsfields.DOB_DATE <> '', 100, 0));
	xYOB_DATE													:= AVE(GROUP, IF(ds.rawdemographicsfields.YOB_DATE <> '', 100, 0));
	xBIRTH_CITY												:= AVE(GROUP, IF(ds.rawdemographicsfields.BIRTH_CITY <> '', 100, 0));
	xBIRTH_STATE											:= AVE(GROUP, IF(ds.rawdemographicsfields.BIRTH_STATE <> '', 100, 0));
	xBIRTH_CNTRY											:= AVE(GROUP, IF(ds.rawdemographicsfields.BIRTH_CNTRY <> '', 100, 0));
	xOPT_OUT_FLAG											:= AVE(GROUP, IF(ds.rawdemographicsfields.OPT_OUT_FLAG <> '', 100, 0));
	xOPT_OUT_START_DATE								:= AVE(GROUP, IF(ds.rawdemographicsfields.OPT_OUT_START_DATE <> '', 100, 0));
	xKAISER_PROV_FLAG									:= AVE(GROUP, IF(ds.rawdemographicsfields.KAISER_PROV_FLAG <> '', 100, 0));
	xSTATUS														:= AVE(GROUP, IF(ds.rawdemographicsfields.STATUS <> '', 100, 0));
	xSTATUS_CD												:= AVE(GROUP, IF(ds.rawdemographicsfields.STATUS_CD <> '', 100, 0));
	xSTATUS_UPDATE_DATE								:= AVE(GROUP, IF(ds.rawdemographicsfields.STATUS_UPDATE_DATE <> '', 100, 0));
	xPRESUMED_DEAD_FLAG								:= AVE(GROUP, IF(ds.rawdemographicsfields.PRESUMED_DEAD_FLAG <> '', 100, 0));
	xCONTACT_FLAG											:= AVE(GROUP, IF(ds.rawdemographicsfields.CONTACT_FLAG <> '', 100, 0));
	xTOP_CD														:= AVE(GROUP, IF(ds.rawdemographicsfields.TOP_CD <> '', 100, 0));
	xPE_CD														:= AVE(GROUP, IF(ds.rawdemographicsfields.PE_CD <> '', 100, 0));
	xMPA_CD														:= AVE(GROUP, IF(ds.rawdemographicsfields.MPA_CD <> '', 100, 0));
	xTAX_ID														:= AVE(GROUP, IF(ds.rawdemographicsfields.TAX_ID <> '', 100, 0));
	xSSN_LAST4												:= AVE(GROUP, IF(ds.rawdemographicsfields.SSN_LAST4 <> '', 100, 0));
	xSOLO															:= AVE(GROUP, IF(ds.rawdemographicsfields.SOLO <> '', 100, 0));
	xGROUP_AFFILIATED									:= AVE(GROUP, IF(ds.rawdemographicsfields.GROUP_AFFILIATED <> '', 100, 0));
	xHOSPITAL_AFFILIATED							:= AVE(GROUP, IF(ds.rawdemographicsfields.HOSPITAL_AFFILIATED <> '', 100, 0));
	xADMINISTRATOR										:= AVE(GROUP, IF(ds.rawdemographicsfields.ADMINISTRATOR <> '', 100, 0));
	xRESEARCH													:= AVE(GROUP, IF(ds.rawdemographicsfields.RESEARCH <> '', 100, 0));
	xCLINICAL_TRIALS									:= AVE(GROUP, IF(ds.rawdemographicsfields.CLINICAL_TRIALS <> '', 100, 0));
	xPHONE_FLAG												:= AVE(GROUP, IF(ds.rawdemographicsfields.PHONE_FLAG <> '', 100, 0));
	xEMAIL_FLAG												:= AVE(GROUP, IF(ds.rawdemographicsfields.EMAIL_FLAG <> '', 100, 0));
	xFAX_FLAG													:= AVE(GROUP, IF(ds.rawdemographicsfields.FAX_FLAG <> '', 100, 0));
	xURL_FLAG													:= AVE(GROUP, IF(ds.rawdemographicsfields.URL_FLAG <> '', 100, 0));
	xGOLD_RECORD_FLAG									:= AVE(GROUP, IF(ds.rawaddressfields.GOLD_RECORD_FLAG <> '', 100, 0));
	xBOB_RANK													:= AVE(GROUP, IF(ds.rawaddressfields.BOB_RANK <> '', 100, 0));
	xBOB_VALUE												:= AVE(GROUP, IF(ds.rawaddressfields.BOB_VALUE <> '', 100, 0));
	xNEW_AMS_ID												:= AVE(GROUP, IF(ds.rawaddressfields.NEW_AMS_ID <> '', 100, 0));
	xNEW_AMS_ADDR_ID									:= AVE(GROUP, IF(ds.rawaddressfields.NEW_AMS_ADDR_ID <> '', 100, 0));
	xAMS_ADDR_ID											:= AVE(GROUP, IF(ds.rawaddressfields.AMS_ADDR_ID <> '', 100, 0));
	xINACTIVE_REASON_CD								:= AVE(GROUP, IF(ds.rawaddressfields.INACTIVE_REASON_CD <> '', 100, 0));
	xINDY_ID_rawaddressfield					:= AVE(GROUP, IF(ds.rawaddressfields.INDY_ID <> '', 100, 0));
	xSRC_CD_rawaddressfield						:= AVE(GROUP, IF(ds.rawaddressfields.SRC_CD <> '', 100, 0));
	xAMS_STREET												:= AVE(GROUP, IF(ds.rawaddressfields.AMS_STREET <> '', 100, 0));
	xAMS_UNIT													:= AVE(GROUP, IF(ds.rawaddressfields.AMS_UNIT <> '', 100, 0));
	xAMS_CITY													:= AVE(GROUP, IF(ds.rawaddressfields.AMS_CITY <> '', 100, 0));
	xAMS_STATE												:= AVE(GROUP, IF(ds.rawaddressfields.AMS_STATE <> '', 100, 0));
	xAMS_ZIP5													:= AVE(GROUP, IF(ds.rawaddressfields.AMS_ZIP5 <> '', 100, 0));
	xAMS_ZIP4													:= AVE(GROUP, IF(ds.rawaddressfields.AMS_ZIP4 <> '', 100, 0));
	xLEFTOVERS												:= AVE(GROUP, IF(ds.rawaddressfields.LEFTOVERS <> '', 100, 0));
	xCNTRY_CD													:= AVE(GROUP, IF(ds.rawaddressfields.CNTRY_CD <> '', 100, 0));
	xCBSA_CD													:= AVE(GROUP, IF(ds.rawaddressfields.CBSA_CD <> '', 100, 0));
	xFIPS_CNTY_CD											:= AVE(GROUP, IF(ds.rawaddressfields.FIPS_CNTY_CD <> '', 100, 0));
	xFIPS_STATE_CD										:= AVE(GROUP, IF(ds.rawaddressfields.FIPS_STATE_CD <> '', 100, 0));
	xADDR_TYPE												:= AVE(GROUP, IF(ds.rawaddressfields.ADDR_TYPE <> '', 100, 0));
	xAMS_GLID													:= AVE(GROUP, IF(ds.rawaddressfields.AMS_GLID <> '', 100, 0));
	xMULTIUNIT_CD											:= AVE(GROUP, IF(ds.rawaddressfields.MULTIUNIT_CD <> '', 100, 0));
	xAMS_ADDR_PASS_FLAG								:= AVE(GROUP, IF(ds.rawaddressfields.AMS_ADDR_PASS_FLAG <> '', 100, 0));
	xADDR_STATUS											:= AVE(GROUP, IF(ds.rawaddressfields.ADDR_STATUS <> '', 100, 0));
	xADD_START_DATE										:= AVE(GROUP, IF(ds.rawaddressfields.ADD_START_DATE <> '', 100, 0));
	xADD_END_DATE											:= AVE(GROUP, IF(ds.rawaddressfields.ADD_END_DATE <> '', 100, 0));
	xORG_UNIT													:= AVE(GROUP, IF(ds.rawaddressfields.ORG_UNIT <> '', 100, 0));
	xAMS_ACCOUNT_ID										:= AVE(GROUP, IF(ds.rawaddressfields.AMS_ACCOUNT_ID <> '', 100, 0));
	xUNIT_NAME												:= AVE(GROUP, IF(ds.rawaddressfields.UNIT_NAME <> '', 100, 0));
	xUNIT_VALUE												:= AVE(GROUP, IF(ds.rawaddressfields.UNIT_VALUE <> '', 100, 0));
	xFLOOR_VALUE											:= AVE(GROUP, IF(ds.rawaddressfields.FLOOR_VALUE <> '', 100, 0));
	xBUILDING_NAME_VALUE							:= AVE(GROUP, IF(ds.rawaddressfields.BUILDING_NAME_VALUE <> '', 100, 0));
	xDEPT_NAME_VALUE									:= AVE(GROUP, IF(ds.rawaddressfields.DEPT_NAME_VALUE <> '', 100, 0));
	xCASS_FLAG												:= AVE(GROUP, IF(ds.rawaddressfields.CASS_FLAG <> '', 100, 0));
	xCONG_CD													:= AVE(GROUP, IF(ds.rawaddressfields.CONG_CD <> '', 100, 0));
	xCMRA_FLAG												:= AVE(GROUP, IF(ds.rawaddressfields.CMRA_FLAG <> '', 100, 0));
	xDPC_CD														:= AVE(GROUP, IF(ds.rawaddressfields.DPC_CD <> '', 100, 0));
	xSTREET_TYPE_CD										:= AVE(GROUP, IF(ds.rawaddressfields.STREET_TYPE_CD <> '', 100, 0));
	xINVALIDUNIT_FLAG									:= AVE(GROUP, IF(ds.rawaddressfields.INVALIDUNIT_FLAG <> '', 100, 0));
	xBUILDFIRM_NAME										:= AVE(GROUP, IF(ds.rawaddressfields.BUILDFIRM_NAME <> '', 100, 0));
	xDPV_CD														:= AVE(GROUP, IF(ds.rawaddressfields.DPV_CD <> '', 100, 0));
	xRDI_CD														:= AVE(GROUP, IF(ds.rawaddressfields.RDI_CD <> '', 100, 0));
	xLAT_ADDR													:= AVE(GROUP, IF(ds.rawaddressfields.LAT_ADDR <> '', 100, 0));
	xLNG_ADDR													:= AVE(GROUP, IF(ds.rawaddressfields.LNG_ADDR <> '', 100, 0));
	xLATLONG_TYPE											:= AVE(GROUP, IF(ds.rawaddressfields.LATLONG_TYPE <> '', 100, 0));
	xPHONE														:= AVE(GROUP, IF(ds.rawaddressfields.PHONE <> '', 100, 0));
	xPHONE_EXT												:= AVE(GROUP, IF(ds.rawaddressfields.PHONE_EXT <> '', 100, 0));
	xPHONE_FLAG_rawaddressfield				:= AVE(GROUP, IF(ds.rawaddressfields.PHONE_FLAG <> '', 100, 0));
	xEMAIL														:= AVE(GROUP, IF(ds.rawaddressfields.EMAIL <> '', 100, 0));
	xEMAIL_FLAG_rawaddressfield				:= AVE(GROUP, IF(ds.rawaddressfields.EMAIL_FLAG <> '', 100, 0));
	xFAX															:= AVE(GROUP, IF(ds.rawaddressfields.FAX <> '', 100, 0));
	xFAX_FLAG_rawaddressfield					:= AVE(GROUP, IF(ds.rawaddressfields.FAX_FLAG <> '', 100, 0));
	xURL															:= AVE(GROUP, IF(ds.rawaddressfields.URL <> '', 100, 0));
	xURL_FLAG_rawaddressfield					:= AVE(GROUP, IF(ds.rawaddressfields.URL_FLAG <> '', 100, 0));
	xDEA_NUM													:= AVE(GROUP, IF(ds.rawaddressfields.DEA_NUM <> '', 100, 0));
	xEXP_DATE													:= AVE(GROUP, IF(ds.rawaddressfields.EXP_DATE <> '', 100, 0));
	xDRUG_SCHEDULES										:= AVE(GROUP, IF(ds.rawaddressfields.DRUG_SCHEDULES <> '', 100, 0));
	xADDR_ID													:= AVE(GROUP, IF(ds.rawaddressfields.ADDR_ID <> '', 100, 0));
	xLOC_ID														:= AVE(GROUP, IF(ds.rawaddressfields.LOC_ID <> '', 100, 0));
	xRAW_AID													:= AVE(GROUP, IF(ds.rawaddressfields.RAW_AID <> 0, 100, 0));
	xACE_AID													:= AVE(GROUP, IF(ds.rawaddressfields.ACE_AID <> 0, 100, 0));
	xAMSID_TYPE_DESC									:= AVE(GROUP, IF(ds.AMSID_TYPE_DESC <> '', 100, 0));
	xAMSID_SUBTYPE_DESC								:= AVE(GROUP, IF(ds.AMSID_SUBTYPE_DESC <> '', 100, 0));
	xSRC_CD_DESC											:= AVE(GROUP, IF(ds.SRC_CD_DESC <> '', 100, 0));
	xSECTOR_CD_DESC										:= AVE(GROUP, IF(ds.SECTOR_CD_DESC <> '', 100, 0));
	xACADEMIC_FLAG_DESC								:= AVE(GROUP, IF(ds.ACADEMIC_FLAG_DESC <> '', 100, 0));
	xSTATUS_CD_DESC										:= AVE(GROUP, IF(ds.STATUS_CD_DESC <> '', 100, 0));
	xGEN_CD_DESC											:= AVE(GROUP, IF(ds.GEN_CD_DESC <> '', 100, 0));
	xBIRTH_CNTRY_DESC									:= AVE(GROUP, IF(ds.BIRTH_CNTRY_DESC <> '', 100, 0));
	xOPT_OUT_FLAG_DESC								:= AVE(GROUP, IF(ds.OPT_OUT_FLAG_DESC <> '', 100, 0));
	xKAISER_PROV_FLAG_DESC						:= AVE(GROUP, IF(ds.KAISER_PROV_FLAG_DESC <> '', 100, 0));
	xSTATUS_DESC											:= AVE(GROUP, IF(ds.STATUS_DESC <> '', 100, 0));
	xPRESUMED_DEAD_FLAG_DESC					:= AVE(GROUP, IF(ds.PRESUMED_DEAD_FLAG_DESC <> '', 100, 0));
	xCONTACT_FLAG_DESC								:= AVE(GROUP, IF(ds.CONTACT_FLAG_DESC <> '', 100, 0));
	xTOP_CD_DESC											:= AVE(GROUP, IF(ds.TOP_CD_DESC <> '', 100, 0));
	xPE_CD_DESC												:= AVE(GROUP, IF(ds.PE_CD_DESC <> '', 100, 0));
	xMPA_CD_DESC											:= AVE(GROUP, IF(ds.MPA_CD_DESC <> '', 100, 0));
	xSOLO_DESC												:= AVE(GROUP, IF(ds.SOLO_DESC <> '', 100, 0));
	xGROUP_AFFILIATED_DESC						:= AVE(GROUP, IF(ds.GROUP_AFFILIATED_DESC <> '', 100, 0));
	xHOSPITAL_AFFILIATED_DESC					:= AVE(GROUP, IF(ds.HOSPITAL_AFFILIATED_DESC <> '', 100, 0));
	xADMINISTRATOR_DESC								:= AVE(GROUP, IF(ds.ADMINISTRATOR_DESC <> '', 100, 0));
	xRESEARCH_DESC										:= AVE(GROUP, IF(ds.RESEARCH_DESC <> '', 100, 0));
	xCLINICAL_TRIALS_DESC							:= AVE(GROUP, IF(ds.CLINICAL_TRIALS_DESC <> '', 100, 0));
	xPHONE_FLAG_DESC									:= AVE(GROUP, IF(ds.PHONE_FLAG_DESC <> '', 100, 0));
	xEMAIL_FLAG_DESC									:= AVE(GROUP, IF(ds.EMAIL_FLAG_DESC <> '', 100, 0));
	xFAX_FLAG_DESC										:= AVE(GROUP, IF(ds.FAX_FLAG_DESC <> '', 100, 0));
	xURL_FLAG_DESC										:= AVE(GROUP, IF(ds.URL_FLAG_DESC <> '', 100, 0));
	xTITLE														:= AVE(GROUP, IF(ds.clean_name.TITLE <> '', 100, 0));
	xFNAME														:= AVE(GROUP, IF(ds.clean_name.FNAME <> '', 100, 0));
	xMNAME														:= AVE(GROUP, IF(ds.clean_name.MNAME <> '', 100, 0));
	xLNAME														:= AVE(GROUP, IF(ds.clean_name.LNAME <> '', 100, 0));
	xNAME_SUFFIX											:= AVE(GROUP, IF(ds.clean_name.NAME_SUFFIX <> '', 100, 0));
	xNAME_SCORE												:= AVE(GROUP, IF(ds.clean_name.NAME_SCORE <> '', 100, 0));
	xPRIM_RANGE												:= AVE(GROUP, IF(ds.clean_company_address.PRIM_RANGE <> '', 100, 0));
	xPREDIR														:= AVE(GROUP, IF(ds.clean_company_address.PREDIR <> '', 100, 0));
	xPRIM_NAME												:= AVE(GROUP, IF(ds.clean_company_address.PRIM_NAME <> '', 100, 0));
	xADDR_SUFFIX											:= AVE(GROUP, IF(ds.clean_company_address.ADDR_SUFFIX <> '', 100, 0));
	xPOSTDIR													:= AVE(GROUP, IF(ds.clean_company_address.POSTDIR <> '', 100, 0));
	xUNIT_DESIG												:= AVE(GROUP, IF(ds.clean_company_address.UNIT_DESIG <> '', 100, 0));
	xSEC_RANGE												:= AVE(GROUP, IF(ds.clean_company_address.SEC_RANGE <> '', 100, 0));
	xP_CITY_NAME											:= AVE(GROUP, IF(ds.clean_company_address.P_CITY_NAME <> '', 100, 0));
	xV_CITY_NAME											:= AVE(GROUP, IF(ds.clean_company_address.V_CITY_NAME <> '', 100, 0));
	xST																:= AVE(GROUP, IF(ds.clean_company_address.ST <> '', 100, 0));
	xZIP															:= AVE(GROUP, IF(ds.clean_company_address.ZIP <> '', 100, 0));
	xZIP4															:= AVE(GROUP, IF(ds.clean_company_address.ZIP4 <> '', 100, 0));
	xCART															:= AVE(GROUP, IF(ds.clean_company_address.CART <> '', 100, 0));
	xCR_SORT_SZ												:= AVE(GROUP, IF(ds.clean_company_address.CR_SORT_SZ <> '', 100, 0));
	xLOT															:= AVE(GROUP, IF(ds.clean_company_address.LOT <> '', 100, 0));
	xLOT_ORDER												:= AVE(GROUP, IF(ds.clean_company_address.LOT_ORDER <> '', 100, 0));
	xDBPC															:= AVE(GROUP, IF(ds.clean_company_address.DBPC <> '', 100, 0));
	xCHK_DIGIT												:= AVE(GROUP, IF(ds.clean_company_address.CHK_DIGIT <> '', 100, 0));
	xREC_TYPE													:= AVE(GROUP, IF(ds.clean_company_address.REC_TYPE <> '', 100, 0));
	xFIPS_STATE												:= AVE(GROUP, IF(ds.clean_company_address.FIPS_STATE <> '', 100, 0));
	xFIPS_COUNTY											:= AVE(GROUP, IF(ds.clean_company_address.FIPS_COUNTY <> '', 100, 0));
	xGEO_LAT													:= AVE(GROUP, IF(ds.clean_company_address.GEO_LAT <> '', 100, 0));
	xGEO_LONG													:= AVE(GROUP, IF(ds.clean_company_address.GEO_LONG <> '', 100, 0));
	xMSA															:= AVE(GROUP, IF(ds.clean_company_address.MSA <> '', 100, 0));
	xGEO_BLK													:= AVE(GROUP, IF(ds.clean_company_address.GEO_BLK <> '', 100, 0));
	xGEO_MATCH												:= AVE(GROUP, IF(ds.clean_company_address.GEO_MATCH <> '', 100, 0));
	xERR_STAT													:= AVE(GROUP, IF(ds.clean_company_address.ERR_STAT <> '', 100, 0));
	xPHONE_cleanphones								:= AVE(GROUP, IF(ds.clean_phones.PHONE <> '', 100, 0));	
	xFAX_cleanphones									:= AVE(GROUP, IF(ds.clean_phones.FAX <> '', 100, 0));	
	
	xLIC_AMS_ID 											:= AVE(GROUP, IF(ds.LIC_AMS_ID <> '', 100, 0));
	xLIC_Record_type 									:= AVE(GROUP, IF(ds.lic_record_type <> '', 100, 0));
	xLIC_Dt_first_seen 								:= AVE(GROUP, IF(ds.lic_dt_first_seen <> 0, 100, 0));
	xLIC_Dt_last_seen									:= AVE(GROUP, IF(ds.lic_dt_last_seen <> 0, 100, 0));
	xLIC_Dt_vendor_first_reported			:= AVE(GROUP, IF(ds.lic_dt_vendor_first_reported <> 0, 100, 0));
	xLIC_Dt_vendor_last_reported			:= AVE(GROUP, IF(ds.lic_dt_vendor_last_reported <> 0, 100, 0));
	xLIC_INDY_ID											:= AVE(GROUP, IF(ds.LIC_INDY_ID <> '', 100, 0));
	xLIC_SRC_CD												:= AVE(GROUP, IF(ds.LIC_SRC_CD <> '', 100, 0));
	xST_LIC_NUM												:= AVE(GROUP, IF(ds.ST_LIC_NUM <> '', 100, 0));
	xST_LIC_BRD_CD										:= AVE(GROUP, IF(ds.ST_LIC_BRD_CD <> '', 100, 0));
	xST_LIC_STATE											:= AVE(GROUP, IF(ds.ST_LIC_STATE <> '', 100, 0));
	xST_LIC_DEGREE										:= AVE(GROUP, IF(ds.ST_LIC_DEGREE <> '', 100, 0));
	xST_LIC_TYPE											:= AVE(GROUP, IF(ds.ST_LIC_TYPE <> '', 100, 0));
	xST_LIC_STATUS										:= AVE(GROUP, IF(ds.ST_LIC_STATUS <> '', 100, 0));
	xST_LIC_EXP_DATE									:= AVE(GROUP, IF(ds.ST_LIC_EXP_DATE <> '', 100, 0));
	xST_LIC_ISSUE_DATE								:= AVE(GROUP, IF(ds.ST_LIC_ISSUE_DATE <> '', 100, 0));
	xST_LIC_BRD_DATE									:= AVE(GROUP, IF(ds.ST_LIC_BRD_DATE <> '', 100, 0));
	xELIGIBILITY_CD										:= AVE(GROUP, IF(ds.ELIGIBILITY_CD <> '', 100, 0));
	xLIC_SRC_CD_DESC									:= AVE(GROUP, IF(ds.LIC_SRC_CD_DESC <> '', 100, 0));
	xST_LIC_STATE_DESC								:= AVE(GROUP, IF(ds.ST_LIC_STATE_DESC <> '', 100, 0));
	xST_LIC_DEGREE_DESC								:= AVE(GROUP, IF(ds.ST_LIC_DEGREE_DESC <> '', 100, 0));
	xST_LIC_TYPE_DESC									:= AVE(GROUP, IF(ds.ST_LIC_TYPE_DESC <> '', 100, 0));
	xST_LIC_STATUS_DESC								:= AVE(GROUP, IF(ds.ST_LIC_STATUS_DESC <> '', 100, 0));
	xELIGIBILITY_CD_DESC							:= AVE(GROUP, IF(ds.ELIGIBILITY_CD_DESC <> '', 100, 0));
	
	xSPEC_AMS_ID 											:= AVE(GROUP, IF(ds.SPEC_AMS_ID <> '', 100, 0));
	xSPEC_Record_type 								:= AVE(GROUP, IF(ds.spec_record_type <> '', 100, 0));
	xSPEC_Dt_first_seen 							:= AVE(GROUP, IF(ds.spec_dt_first_seen <> 0, 100, 0));
	xSPEC_Dt_last_seen								:= AVE(GROUP, IF(ds.spec_dt_last_seen <> 0, 100, 0));
	xSPEC_Dt_vendor_first_reported		:= AVE(GROUP, IF(ds.spec_dt_vendor_first_reported <> 0, 100, 0));
	xSPEC_Dt_vendor_last_reported			:= AVE(GROUP, IF(ds.spec_dt_vendor_last_reported <> 0, 100, 0));
	xSPECIALTY_TYPE										:= AVE(GROUP, IF(ds.SPECIALTY_TYPE <> '', 100, 0));
	xSPECIALTY												:= AVE(GROUP, IF(ds.SPECIALTY	<> '', 100, 0));
	xSPEC_SRC_CD											:= AVE(GROUP, IF(ds.SPEC_SRC_CD <> '', 100, 0));
	xSPECIALTY_DESC										:= AVE(GROUP, IF(ds.SPECIALTY_DESC <> '', 100, 0));
	xSPEC_SRC_CD_DESC									:= AVE(GROUP, IF(ds.SPEC_SRC_CD_DESC <> '', 100, 0));

	xIDNUM_AMS_ID 										:= AVE(GROUP, IF(ds.IDNUM_AMS_ID <> '', 100, 0));
	xIDNUM_Record_type 								:= AVE(GROUP, IF(ds.idnum_record_type <> '', 100, 0));
	xIDNUM_Dt_first_seen 							:= AVE(GROUP, IF(ds.idnum_dt_first_seen <> 0, 100, 0));
	xIDNUM_Dt_last_seen								:= AVE(GROUP, IF(ds.idnum_dt_last_seen <> 0, 100, 0));
	xIDNUM_Dt_vendor_first_reported		:= AVE(GROUP, IF(ds.idnum_dt_vendor_first_reported <> 0, 100, 0));
	xIDNUM_Dt_vendor_last_reported		:= AVE(GROUP, IF(ds.idnum_dt_vendor_last_reported <> 0, 100, 0));
	xIDNUM_INDY_ID										:= AVE(GROUP, IF(ds.IDNUM_INDY_ID	<> '', 100, 0));
	xIDNUM_SRC_CD											:= AVE(GROUP, IF(ds.IDNUM_SRC_CD <> '', 100, 0));
	xIDNUM_INDY_ID_END_DATE						:= AVE(GROUP, IF(ds.IDNUM_INDY_ID_END_DATE <> '', 100, 0));
	xIDNUM_END_DATE_REASON						:= AVE(GROUP, IF(ds.IDNUM_END_DATE_REASON <> '', 100, 0));
	xIDNUM_SRC_CD_DESC								:= AVE(GROUP, IF(ds.IDNUM_SRC_CD_DESC <> '', 100, 0));

	xDEGREE_AMS_ID 										:= AVE(GROUP, IF(ds.DEGREE_AMS_ID <> '', 100, 0));
	xDEGREE_Record_type 							:= AVE(GROUP, IF(ds.degree_record_type <> '', 100, 0));
	xDEGREE_Dt_first_seen 						:= AVE(GROUP, IF(ds.degree_dt_first_seen <> 0, 100, 0));
	xDEGREE_Dt_last_seen							:= AVE(GROUP, IF(ds.degree_dt_last_seen <> 0, 100, 0));
	xDEGREE_Dt_vendor_first_reported 	:= AVE(GROUP, IF(ds.degree_dt_vendor_first_reported <> 0, 100, 0));
	xDEGREE_Dt_vendor_last_reported		:= AVE(GROUP, IF(ds.degree_dt_vendor_last_reported <> 0, 100, 0));
	xDEGREE										       	:= AVE(GROUP, IF(ds.DEGREE <> '', 100, 0));
	xBEST_DEGREE							       	:= AVE(GROUP, IF(ds.BEST_DEGREE	<> '', 100, 0));
	xDEGREE_DESC										 	:= AVE(GROUP, IF(ds.DEGREE_DESC <> '', 100, 0));

	xCRED_AMS_ID 											:= AVE(GROUP, IF(ds.CRED_AMS_ID <> '', 100, 0));
	xCRED_Record_type 								:= AVE(GROUP, IF(ds.cred_record_type <> '', 100, 0));
	xCRED_Dt_first_seen 							:= AVE(GROUP, IF(ds.cred_dt_first_seen <> 0, 100, 0));
	xCRED_Dt_last_seen								:= AVE(GROUP, IF(ds.cred_dt_last_seen <> 0, 100, 0));
	xCRED_Dt_vendor_first_reported		:= AVE(GROUP, IF(ds.cred_dt_vendor_first_reported <> 0, 100, 0));
	xCRED_Dt_vendor_last_reported			:= AVE(GROUP, IF(ds.cred_dt_vendor_last_reported <> 0, 100, 0));
	xCREDENTIAL												:= AVE(GROUP, IF(ds.CREDENTIAL <> '', 100, 0));
	xCREDENTIAL_DESC									:= AVE(GROUP, IF(ds.CREDENTIAL_DESC <> '', 100, 0));

	xAFFIL_PARENT_AMS_ID 							:= AVE(GROUP, IF(ds.AFFIL_PARENT_AMS_ID <> '', 100, 0));
	xAFFIL_CHILD_AMS_ID 							:= AVE(GROUP, IF(ds.AFFIL_CHILD_AMS_ID <> '', 100, 0));
	xAFFIL_Record_type 								:= AVE(GROUP, IF(ds.affil_record_type <> '', 100, 0));
	xAFFIL_Dt_first_seen 							:= AVE(GROUP, IF(ds.affil_dt_first_seen <> 0, 100, 0));
	xAFFIL_Dt_last_seen								:= AVE(GROUP, IF(ds.affil_dt_last_seen	<> 0, 100, 0));
	xAFFIL_Dt_vendor_first_reported		:= AVE(GROUP, IF(ds.affil_dt_vendor_first_reported	<> 0, 100, 0));
	xAFFIL_Dt_vendor_last_reported		:= AVE(GROUP, IF(ds.affil_dt_vendor_last_reported <> 0, 100, 0));
	xAFFIL_SRC_CD											:= AVE(GROUP, IF(ds.AFFIL_SRC_CD	<> '', 100, 0));
	xAFFIL_STATUS											:= AVE(GROUP, IF(ds.AFFIL_STATUS	<> '', 100, 0));
	xAFFIL_TYPE												:= AVE(GROUP, IF(ds.AFFIL_TYPE	<> '', 100, 0));
	xAFFIL_UPDATE_DATE								:= AVE(GROUP, IF(ds.AFFIL_UPDATE_DATE <> '', 100, 0));
	xAFFIL_START_DATE									:= AVE(GROUP, IF(ds.AFFIL_START_DATE	<> '', 100, 0));
	xAFFIL_END_DATE										:= AVE(GROUP, IF(ds.AFFIL_END_DATE	<> '', 100, 0));
	xAFFIL_SRC_CD_DESC								:= AVE(GROUP, IF(ds.AFFIL_SRC_CD_DESC <> '', 100, 0));
END;

fieldPOP := TABLE(ds, Field_PopulationStats, ALL);

OUTPUT(fieldPOP);