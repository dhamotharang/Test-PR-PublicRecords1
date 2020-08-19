IMPORT _Control, BIPV2_Best_SBFE, BIPV2_Best,	BIPV2, Business_Credit, MDR, doxie, STD;
EXPORT Key_LinkIds( STRING pVersion = (STRING8)Std.Date.Today(),
                    Constants().buildType pBuildType = Constants().buildType.Daily) := MODULE

  // If this is a Daily Build we want to create an empty key.
  SHARED dSBFEBestBase := IF(pBuildType = Constants().buildType.Daily,
                              DATASET([],BIPV2_Best.Layouts.base),
                              BIPV2_Best.fn_Prep_Base_for_Key(pVersion,BIPV2_Best_SBFE.Files(pVersion).base.built)
                            );
  shared old_company_address_case_layout := RECORD
  string10 company_prim_range;
  string2 company_predir;
  string28 company_prim_name;
  string4 company_addr_suffix;
  string2 company_postdir;
  string10 company_unit_desig;
  string8 company_sec_range;
  string25 company_p_city_name;
  string25 address_v_city_name;
  string2 company_st;
  string5 company_zip5;
  string4 company_zip4;
  string2 state_fips;
  string3 county_fips;
  string18 county_name;
  unsigned2 company_address_data_permits;
  unsigned1 company_address_method; // This value could come from multiple BESTTYPE; track which one
  unsigned1 score := 0 ;
  END;
  shared old_key := RECORD
    BIPV2.IDlayouts.l_xlink_ids;
    boolean isActive ; //seleid level
    boolean isDefunct; //seleid level
    unsigned6 company_bdid;
    DATASET(BIPV2_Best.layouts.company_name_case_layout and not score) company_name;
    DATASET(old_company_address_case_layout  and not [score, state_fips, county_fips]) company_address;
    DATASET(BIPV2_Best.layouts.company_phone_case_layout  and not score) company_phone;
    DATASET(BIPV2_Best.layouts.company_fein_case_layout and not [score, company_fein_cnt,company_fein_owns]) company_fein;
    DATASET(BIPV2_Best.layouts.company_url_case_layout  and not score) company_url;
    DATASET(BIPV2_Best.layouts.company_incorporation_date_layout  and not score) company_incorporation_date;
    DATASET(BIPV2_Best.layouts.duns_number_case_layout and not score) duns_number;
    DATASET(BIPV2_Best.layouts.sic_code_case_layout and not score) sic_code;
    DATASET(BIPV2_Best.layouts.naics_code_case_layout and not score) naics_code;
    DATASET(BIPV2_Best.layouts.dba_name_case_layout and not score) dba_name;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;
  SHARED dSBFEBestKey := PROJECT(dSBFEBestBase, TRANSFORM(old_key, SELF:=LEFT, SELF:=[]));

  SHARED  addGlobalSID :=  MDR.macGetGlobalSid(dSBFEBestKey,'SBFECV','','global_sid');

  // DEFINE THE INDEX
  SHARED	superfile_name	:=	BIPV2_Best_SBFE.Keynames().LinkIds.QA;
    // If this is a daily build then only create a key with today's records
  SHARED	Base						:=	addGlobalSID;

  BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
  EXPORT Key := k;

  // DEFINE THE INDEX ACCESS
  // NOTE! SBFE (Business_Credit) data is restricted! Do not fetch records unless you have
  // obtained approval from product management.
  // Jira# DF-26179,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
  EXPORT kFetch2(DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs,
                STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                      //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                    //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
                STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
                INTEGER JoinLimit = 10000,
                UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
                ):=FUNCTION

  use_sbfe := DataPermissionMask[12] NOT IN ['0', ''];

  BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, JoinLimit, JoinType);  //DF-26180 - Remove code calling mac_check_access b/c this key does not have lexid

  RETURN out(use_sbfe);

  END;

  // Depricated version of the above kFetch2
  EXPORT kFetch(DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
                STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                      //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                    //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
                STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
                INTEGER JoinLimit = 10000
                ):=FUNCTION

    inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
    f2 := kFetch2(inputs_for2, Level, ScoreThreshold, DataPermissionMask, JoinLimit);
    RETURN PROJECT(f2, RECORDOF(Key));

  END;
END;