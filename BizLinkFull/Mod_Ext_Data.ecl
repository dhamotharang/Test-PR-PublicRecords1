IMPORT SALT44,BizLinkFull;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
EXPORT Mod_Ext_Data(BOOLEAN MultiRec = FALSE,SET OF SALT44.UIDType ButNot=[], DATASET(RECORDOF(File_Ext_Data)) inefile = File_Ext_Data) := MODULE
  R := RECORD
    inefile;
    SALT44.UIDType UniqueId;
    UNSIGNED2 proxid_Score := 0;
    UNSIGNED2 proxid_Weight := 0;
  END;
SHARED  input := PROJECT(inefile,TRANSFORM(R,SELF := LEFT,SELF.UniqueId:=COUNTER)); // UniqueID is required
SHARED s_index := CHOOSEN(Keys(File_BizHead).Specificities_Key,1)[1]; // Index access for MEOW queries
SHARED s := Specificities(File_BizHead).Specificities[1];
SHARED BitShift := (SIZEOF({SALT44.UIDType dummy})-1)*8;
SHARED BitMask := (1<<BitShift)-1;
Mapping0 := 'zip_cases:zip'; // Tweaks for non-standard field names
UniChange0 := input;
Mapped0 := SALT44.FromFlat(UniChange0,Process_Biz_Layouts.InputLayout,Mapping0); // Copy out the linkable indicative


// Create the mappings and links for data in the main external file
  CanSearch(Process_Biz_Layouts.InputLayout le) := IF (Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),1 << 1,0) + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2,0) + IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 3,0) + IF (Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),1 << 4,0) + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 5,0) + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 6,0) + IF (Key_BizHead_L_ADDRESS3.CanSearch(le),1 << 7,0) + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 8,0) + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 9,0) + IF (Key_BizHead_L_URL.CanSearch(le),1 << 10,0) + IF (Key_BizHead_L_CONTACT_ZIP.CanSearch(le),1 << 11,0) + IF (Key_BizHead_L_CONTACT_ST.CanSearch(le),1 << 12,0) + IF (Key_BizHead_L_CONTACT.CanSearch(le),1 << 13,0) + IF (Key_BizHead_L_CONTACT_SSN.CanSearch(le),1 << 14,0) + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 15,0) + IF (Key_BizHead_L_SIC.CanSearch(le),1 << 16,0) + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 17,0) + IF (Key_BizHead_L_CONTACT_DID.CanSearch(le),1 << 18,0) > 0;
  Process_Biz_Layouts.InputLayout tr(Process_Biz_Layouts.InputLayout le) := TRANSFORM,SKIP(~CanSearch(le))
    SELF := le;
  END;
EXPORT Mapped_ToClean := PROJECT(Mapped0,tr(LEFT));
EXPORT Mapped := Process_Biz_Layouts.CleanInput(Mapped_ToClean) : PERSIST(Config_BIP.DefaultTempPrefix + 'proxid::BizLinkFull::Mapped::UID::Ext_Data',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
  BizLinkFull.MAC_PopulationStatistics(Mapped,UniqueId,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,has_lgid,empid,source,source_record_id,source_docid,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,active_duns_number,prim_range,prim_name,sec_range,city,city_clean,st,zip_cases,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,,,,fallback_value,CONTACTNAME,STREETADDRESS,ml);
EXPORT MappedStats := ml;
  BizLinkFull.Config_BIP.MAC_MEOW_Biz_Batch_Wrapper(Mapped,UniqueId,/* MY_proxid */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,has_lgid,empid,source,source_record_id,source_docid,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,active_duns_number,prim_range,prim_name,sec_range,city,city_clean,st,zip_cases,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,,,,fallback_value,CONTACTNAME,STREETADDRESS,ofi,false,,,,true,true); /*HACK23*/
SHARED LinkResults := ofi : PERSIST(Config_BIP.DefaultTempPrefix + 'proxid::BizLinkFull::LinkResults::UID::Ext_Data',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));
j0 := JOIN(input,LinkResults(Resolved_ultid,(COUNT(Results)=1 AND Results[1].Score>75) OR (COUNT(Results)>1 AND Results[1].Score-Results[2].Score>0 AND Results[1].Score>75),Reference>>BitShift=0),LEFT.UniqueID=(RIGHT.Reference&BitMask),TRANSFORM({input},SELF.proxid := RIGHT.Results[1].proxid,SELF.seleid := RIGHT.Results[1].seleid,SELF.orgid := RIGHT.Results[1].orgid,SELF.ultid := RIGHT.Results[1].ultid,SELF.proxid_Score := RIGHT.Results[1].score,SELF.proxid_Weight := RIGHT.Results[1].weight,SELF := LEFT),LEFT OUTER);


EXPORT WithUID := j0 : PERSIST(Config_BIP.DefaultTempPrefix + 'proxid::BizLinkFull::WithUID::UID::Ext_Data',EXPIRE(BizLinkFull.Config_BIP.PersistExpire));

j0 := JOIN(Mapped,LinkResults(Resolved_ultid,(COUNT(Results)=1 AND Results[1].Score>75) OR (COUNT(Results)>1 AND Results[1].Score-Results[2].Score>0 AND Results[1].Score>75)),LEFT.UniqueID=(RIGHT.Reference),TRANSFORM({Mapped},SELF.Entered_rcid := LEFT.UniqueID&BitMask,SELF.Entered_proxid := RIGHT.Results[1].proxid,SELF.Entered_seleid := RIGHT.Results[1].seleid,SELF.Entered_orgid := RIGHT.Results[1].orgid,SELF.Entered_ultid := RIGHT.Results[1].ultid,SELF := LEFT),LEFT OUTER);

EXPORT MappedUID := j0;

EXPORT UidStats := Process_Biz_Layouts.ScoreSummary(LinkResults);


SHARED AllUidMapped := PROJECT(MappedUID,Process_Biz_Layouts.InputLayout);
// Now we need to construct a payload key for the primary file
// We need this payload key to be indexed by proxid
  RLayout := RECORD
    SALT44.UIDType Fetch_proxid;
    SALT44.UIDType Fetch_seleid;
    SALT44.UIDType Fetch_orgid;
    SALT44.UIDType Fetch_ultid;
    SALT44.UIDType Fetch_rcid;
    WithUID;
  END;
  SHARED T := PROJECT(WithUID,TRANSFORM(RLayout,SELF.Fetch_proxid := LEFT.proxid,SELF.Fetch_seleid := LEFT.seleid,SELF.Fetch_orgid := LEFT.orgid,SELF.Fetch_ultid := LEFT.ultid,SELF.Fetch_rcid := LEFT.UniqueId, SELF := LEFT)); // Copy the fetches out
EXPORT PayloadByproxidName := BizLinkFull.Filename_keys.Ext_PayloadByproxid; /*HACK07*/

EXPORT PayloadByproxid := INDEX(T,{Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,Fetch_rcid},{T},PayloadByproxidName);
// Need to construct keys to allow direct searching of the data
SHARED h := Process_Biz_Layouts.InputToMC(AllUidMapped);
// Working with LINKPATH L_CNPNAME_ZIP;
EXPORT KeyL_CNPNAME_ZIPName := BizLinkFull.Filename_keys.Ext_L_CNPNAME_ZIP; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields
UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion

  h.zip;


// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.prim_name;


  h.st;

// Extra credit fields

  h.city;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing

        h.cnp_name;

            UNSIGNED8 gss_bloom := SALT44.Fn_Wordbag_To_Bloom(h.cnp_name); // To allow pruning of positives from rawfetch



  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.st_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))'')),layout),GSS_hash,zip,proxid,seleid,orgid,ultid,rcid,prim_name,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,cnp_name,gss_bloom,prim_name_len,city_len,prim_range_len,sec_range_len,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,st_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT44.mac_expand_wordbag_key(DataForKey0,GSS_hash,cnp_name,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
SHARED DataForKeyL_CNPNAME_ZIP := DataForKey2;
EXPORT KeyL_CNPNAME_ZIP := INDEX(DataForKeyL_CNPNAME_ZIP,{DataForKeyL_CNPNAME_ZIP},{},KeyL_CNPNAME_ZIPName);

KeyRec := RECORDOF(KeyL_CNPNAME_ZIP);
EXPORT RawFetchL_CNPNAME_ZIP(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT44.fn_string_to_wordstream(param_cnp_name);
    indexOutputRecord := RECORDOF(KeyL_CNPNAME_ZIP);
    slimrec := { KeyL_CNPNAME_ZIP.gss_word_weight, KeyL_CNPNAME_ZIP.proxid, KeyL_CNPNAME_ZIP.seleid, KeyL_CNPNAME_ZIP.orgid, KeyL_CNPNAME_ZIP.ultid };
    BloomF := SALT44.Fn_Wordbag_To_Bloom(param_cnp_name); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(LIMIT(KEYL_CNPNAME_ZIP( KEYED(GSS_hash = search) AND (GSS_bloom & BloomF) = BloomF
AND KEYED((zip IN SET(param_zip,zip)))
AND ((param_prim_name = (TYPEOF(prim_name))'' OR prim_name = (TYPEOF(prim_name))'') OR (prim_name = param_prim_name) OR ((Config_BIP.WithinEditN(prim_name,prim_name_len,param_prim_name,param_prim_name_len,1, 0))))

AND ((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))),Config_BIP.L_CNPNAME_ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28a*/,ultid,orgid,seleid,proxid,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT44.MAC_collate_wordbag_matches4(wds,slimrec,doIndexRead,ultid,orgid,seleid,proxid,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, KeyL_CNPNAME_ZIP, KEYED(RIGHT.GSS_Hash = wds[1].hsh)
AND KEYED((RIGHT.zip IN SET(param_zip,zip))) AND KEYED(RIGHT.fallback_value >= param_fallback_value) AND KEYED(LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid),TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(COUNT(param_zip)>600,DATASET([],indexOutputRecord),IF(SUM(wds,spec) > (5+ LOG(COUNT(param_zip))/LOG(2)+(LOG(COUNT(param_zip))/LOG(2))),res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))))/*HACK14*/; // Ensure at least spc of specificity in gss portion
   END;

EXPORT ScoredproxidFetchL_CNPNAME_ZIP(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CNPNAME_ZIP(param_cnp_name,param_zip,param_prim_name,param_prim_name_len,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 1+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 1+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.cnp_name_match_code := match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,TRUE);

    SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/
      SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/
      SELF.cnp_name_gss_cases := DATASET([{le.gss_hash}],SALT44.layout_GSS_cases);


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CNPNAME_ST;
EXPORT KeyL_CNPNAME_STName := BizLinkFull.Filename_keys.Ext_L_CNPNAME_ST; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields
UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion

  h.st;


// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.prim_name;


  h.zip;

// Extra credit fields

  h.city;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing

        h.cnp_name;

            UNSIGNED8 gss_bloom := SALT44.Fn_Wordbag_To_Bloom(h.cnp_name); // To allow pruning of positives from rawfetch



  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.st_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.zip_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),layout),GSS_hash,st,proxid,seleid,orgid,ultid,rcid,prim_name,zip,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,cnp_name,gss_bloom,prim_name_len,city_len,prim_range_len,sec_range_len,st_weight100,prim_name_weight100,prim_name_e1_Weight100,zip_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT44.mac_expand_wordbag_key(DataForKey0,GSS_hash,cnp_name,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
SHARED DataForKeyL_CNPNAME_ST := DataForKey2;
EXPORT KeyL_CNPNAME_ST := INDEX(DataForKeyL_CNPNAME_ST,{DataForKeyL_CNPNAME_ST},{},KeyL_CNPNAME_STName);

KeyRec := RECORDOF(KeyL_CNPNAME_ST);
EXPORT RawFetchL_CNPNAME_ST(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT44.fn_string_to_wordstream(param_cnp_name);
    indexOutputRecord := RECORDOF(KeyL_CNPNAME_ST);
    slimrec := { KeyL_CNPNAME_ST.gss_word_weight, KeyL_CNPNAME_ST.proxid, KeyL_CNPNAME_ST.seleid, KeyL_CNPNAME_ST.orgid, KeyL_CNPNAME_ST.ultid };
    BloomF := SALT44.Fn_Wordbag_To_Bloom(param_cnp_name); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(LIMIT(KEYL_CNPNAME_ST( KEYED(GSS_hash = search) AND (GSS_bloom & BloomF) = BloomF
AND KEYED((st = param_st))
AND ((param_prim_name = (TYPEOF(prim_name))'' OR prim_name = (TYPEOF(prim_name))'') OR (prim_name = param_prim_name) OR ((Config_BIP.WithinEditN(prim_name,prim_name_len,param_prim_name,param_prim_name_len,1, 0))))

AND ((~EXISTS(param_zip) OR zip = (TYPEOF(zip))'') OR (zip IN SET(param_zip,zip)))),Config_BIP.L_CNPNAME_ST_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28b*/,ultid,orgid,seleid,proxid,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT44.MAC_collate_wordbag_matches4(wds,slimrec,doIndexRead,ultid,orgid,seleid,proxid,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, KeyL_CNPNAME_ST, KEYED(RIGHT.GSS_Hash = wds[1].hsh)
AND KEYED((RIGHT.st = param_st)) AND KEYED(RIGHT.fallback_value >= param_fallback_value) AND KEYED(LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid),TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(SUM(wds,spec) > 14,res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))); // Ensure at least spc of specificity in gss portion
   END;

EXPORT ScoredproxidFetchL_CNPNAME_ST(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CNPNAME_ST(param_cnp_name,param_st,param_prim_name,param_prim_name_len,param_zip,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 2+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 2+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.cnp_name_match_code := match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,TRUE);

    SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/
      SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/
      SELF.cnp_name_gss_cases := DATASET([{le.gss_hash}],SALT44.layout_GSS_cases);


    SELF.st_match_code := match_methods(File_BizHead).match_st(le.st,param_st,TRUE);

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CNPNAME;
EXPORT KeyL_CNPNAMEName := BizLinkFull.Filename_keys.Ext_L_CNPNAME; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields
UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion

// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.prim_name;


  h.city;

// Extra credit fields

  h.st;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.zip;

  h.powid; // Uncle #1
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing

        h.cnp_name;

            UNSIGNED8 gss_bloom := SALT44.Fn_Wordbag_To_Bloom(h.cnp_name); // To allow pruning of positives from rawfetch



  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),layout),GSS_hash,proxid,seleid,orgid,ultid,rcid,prim_name,city,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,zip,powid,cnp_name,gss_bloom,prim_name_len,city_len,prim_range_len,sec_range_len,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,zip_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT44.mac_expand_wordbag_key(DataForKey0,GSS_hash,cnp_name,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
SHARED DataForKeyL_CNPNAME := DataForKey2;
EXPORT KeyL_CNPNAME := INDEX(DataForKeyL_CNPNAME,{DataForKeyL_CNPNAME},{},KeyL_CNPNAMEName);

KeyRec := RECORDOF(KeyL_CNPNAME);
EXPORT RawFetchL_CNPNAME(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT44.fn_string_to_wordstream(param_cnp_name);
    indexOutputRecord := RECORDOF(KeyL_CNPNAME);
    slimrec := { KeyL_CNPNAME.gss_word_weight, KeyL_CNPNAME.proxid, KeyL_CNPNAME.seleid, KeyL_CNPNAME.orgid, KeyL_CNPNAME.ultid };
    BloomF := SALT44.Fn_Wordbag_To_Bloom(param_cnp_name); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(LIMIT(KEYL_CNPNAME( KEYED(GSS_hash = search) AND (GSS_bloom & BloomF) = BloomF
AND ((param_prim_name = (TYPEOF(prim_name))'' OR prim_name = (TYPEOF(prim_name))'') OR (prim_name = param_prim_name) OR ((Config_BIP.WithinEditN(prim_name,prim_name_len,param_prim_name,param_prim_name_len,1, 0))))

AND ((param_city = (TYPEOF(city))'' OR city = (TYPEOF(city))'') OR (city = param_city) OR ((metaphonelib.DMetaPhone1(city)=metaphonelib.DMetaPhone1(param_city)) OR (Config_BIP.WithinEditN(city,city_len,param_city,param_city_len,2, 0))))),Config_BIP.L_CNPNAME_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28c*/,ultid,orgid,seleid,proxid,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT44.MAC_collate_wordbag_matches4(wds,slimrec,doIndexRead,ultid,orgid,seleid,proxid,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, KeyL_CNPNAME, KEYED(RIGHT.GSS_Hash = wds[1].hsh) AND KEYED(RIGHT.fallback_value >= param_fallback_value) AND KEYED(LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid),TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(SUM(wds,spec) > 19,res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))); // Ensure at least spc of specificity in gss portion
   END;

EXPORT ScoredproxidFetchL_CNPNAME(TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CNPNAME(param_cnp_name,param_prim_name,param_prim_name_len,param_city,param_city_len,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 3+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 3+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.cnp_name_match_code := match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,TRUE);

    SELF.cnp_nameWeight := SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)/100; /*HACK22_a*/
      SELF.cnp_name_GSS_Weight := SELF.cnp_nameWeight; /*HACK22_b*/
      SELF.cnp_name_gss_cases := DATASET([{le.gss_hash}],SALT44.layout_GSS_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight) + MAX(0, SELF.zipWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CNPNAME_FUZZY;
EXPORT KeyL_CNPNAME_FUZZYName := BizLinkFull.Filename_keys.Ext_L_CNPNAME_FUZZY; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.company_name_prefix;


// Optional fields

  h.st;

  h.zip;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.cnp_name;

// Extra credit fields

  h.city;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.company_name_prefix_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((company_name_prefix NOT IN SET(s.nulls_company_name_prefix,company_name_prefix) AND company_name_prefix <> (TYPEOF(company_name_prefix))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),layout),company_name_prefix,st,zip,proxid,seleid,orgid,ultid,rcid,cnp_name,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,city_len,prim_range_len,sec_range_len,company_name_prefix_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,st_weight100,zip_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CNPNAME_FUZZY := DataForKey0;
EXPORT KeyL_CNPNAME_FUZZY := INDEX(DataForKeyL_CNPNAME_FUZZY,{DataForKeyL_CNPNAME_FUZZY},{},KeyL_CNPNAME_FUZZYName);

KeyRec := RECORDOF(KeyL_CNPNAME_FUZZY);
EXPORT RawFetchL_CNPNAME_FUZZY(TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CNPNAME_FUZZY(
          KEYED((company_name_prefix = param_company_name_prefix))

      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))
      AND KEYED((~EXISTS(param_zip) OR zip = (TYPEOF(zip))'') OR (zip IN SET(param_zip,zip)))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CNPNAME_FUZZY_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CNPNAME_FUZZY(TYPEOF(h.company_name_prefix) param_company_name_prefix = (TYPEOF(h.company_name_prefix))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CNPNAME_FUZZY(param_company_name_prefix,param_cnp_name,param_st,param_zip,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 4+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := 0; // Skip setting keys_failed for this linkpath

    SELF.company_name_prefix_match_code := match_methods(File_BizHead).match_company_name_prefix(le.company_name_prefix,param_company_name_prefix,TRUE);

    SELF.company_name_prefixWeight := (50+MAP (
         SELF.company_name_prefix_match_code = SALT44.MatchCode.ExactMatch =>le.company_name_prefix_weight100,
         -0.915*le.company_name_prefix_weight100))/100*0.10;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.company_name_prefixWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_ADDRESS1;
EXPORT KeyL_ADDRESS1Name := BizLinkFull.Filename_keys.Ext_L_ADDRESS1; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.prim_name;


  h.city;


  h.st;


// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.prim_range;


  h.cnp_name;

// Extra credit fields

  h.zip;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))''),(city NOT IN SET(s.nulls_city,city) AND city <> (TYPEOF(city))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),prim_name,city,st,proxid,seleid,orgid,ultid,rcid,prim_range,cnp_name,zip,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,city_len,prim_range_len,sec_range_len,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,prim_range_weight100,prim_range_e1_Weight100,cnp_name_weight100,cnp_name_initial_char_weight100,zip_weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_ADDRESS1 := DataForKey0;
EXPORT KeyL_ADDRESS1 := INDEX(DataForKeyL_ADDRESS1,{DataForKeyL_ADDRESS1},{},KeyL_ADDRESS1Name);

KeyRec := RECORDOF(KeyL_ADDRESS1);
EXPORT RawFetchL_ADDRESS1(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_ADDRESS1(
          KEYED((prim_name = param_prim_name))

      AND KEYED((city = param_city))
      AND KEYED((st = param_st))

      AND ((param_prim_range = (TYPEOF(prim_range))'' OR prim_range = (TYPEOF(prim_range))'') OR (prim_range = param_prim_range) OR ((Config_BIP.WithinEditN(prim_range,prim_range_len,param_prim_range,param_prim_range_len,1, 0))))
      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_RoxieAddrCnpNameBonus/*HACK08_a*/ > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_ADDRESS1_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_ADDRESS1(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_ADDRESS1(param_prim_name,param_prim_name_len,param_city,param_city_len,param_st,param_prim_range,param_prim_range_len,param_cnp_name,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 5+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 5+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.prim_name_match_code := match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,TRUE);

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,TRUE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         -0.947*le.city_weight100))/100;


    SELF.st_match_code := match_methods(File_BizHead).match_st(le.st,param_st,TRUE);

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_ADDRESS2;
EXPORT KeyL_ADDRESS2Name := BizLinkFull.Filename_keys.Ext_L_ADDRESS2; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.prim_name;


  h.zip;


// Optional fields

  h.st;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.prim_range;


  h.cnp_name;

// Extra credit fields

  h.city;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.prim_range_len;

  h.city_len;

  h.sec_range_len;

//Scores for various field components
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))'')),layout),prim_name,zip,st,proxid,seleid,orgid,ultid,rcid,prim_range,cnp_name,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,prim_range_len,city_len,sec_range_len,prim_name_weight100,prim_name_e1_Weight100,zip_weight100,prim_range_weight100,prim_range_e1_Weight100,cnp_name_weight100,cnp_name_initial_char_weight100,st_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_ADDRESS2 := DataForKey0;
EXPORT KeyL_ADDRESS2 := INDEX(DataForKeyL_ADDRESS2,{DataForKeyL_ADDRESS2},{},KeyL_ADDRESS2Name);

KeyRec := RECORDOF(KeyL_ADDRESS2);
EXPORT RawFetchL_ADDRESS2(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_ADDRESS2(
          KEYED((prim_name = param_prim_name))

      AND KEYED((zip IN SET(param_zip,zip)))

      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_prim_range = (TYPEOF(prim_range))'' OR prim_range = (TYPEOF(prim_range))'') OR (prim_range = param_prim_range) OR ((Config_BIP.WithinEditN(prim_range,prim_range_len,param_prim_range,param_prim_range_len,1, 0))))
      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_RoxieAddrCnpNameBonus/*HACK08_b*/ > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_ADDRESS2_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_ADDRESS2(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_ADDRESS2(param_prim_name,param_prim_name_len,param_zip,param_prim_range,param_prim_range_len,param_cnp_name,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 6+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 6+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.prim_name_match_code := match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,TRUE);

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         -1.000*le.prim_name_weight100))/100;


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_ADDRESS3;
EXPORT KeyL_ADDRESS3Name := BizLinkFull.Filename_keys.Ext_L_ADDRESS3; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.prim_name;


  h.prim_range;


  h.zip;


// Optional fields

  h.st;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.cnp_name;

// Extra credit fields

  h.city;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.prim_range_len;

  h.city_len;

  h.sec_range_len;

//Scores for various field components
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.zip_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))''),(prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND prim_range <> (TYPEOF(prim_range))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),prim_name,prim_range,zip,st,proxid,seleid,orgid,ultid,rcid,cnp_name,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,prim_range_len,city_len,sec_range_len,prim_name_weight100,prim_name_e1_Weight100,prim_range_weight100,prim_range_e1_Weight100,zip_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,st_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_ADDRESS3 := DataForKey0;
EXPORT KeyL_ADDRESS3 := INDEX(DataForKeyL_ADDRESS3,{DataForKeyL_ADDRESS3},{},KeyL_ADDRESS3Name);

KeyRec := RECORDOF(KeyL_ADDRESS3);
EXPORT RawFetchL_ADDRESS3(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_ADDRESS3(
          KEYED((prim_name = param_prim_name))

      AND KEYED((prim_range = param_prim_range))
      AND KEYED((zip IN SET(param_zip,zip)))

      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_RoxieAddrCnpNameBonus/*HACK08_c*/ > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_ADDRESS3_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_ADDRESS3(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_ADDRESS3(param_prim_name,param_prim_name_len,param_prim_range,param_prim_range_len,param_zip,param_cnp_name,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 7+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 7+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.prim_name_match_code := match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,TRUE);

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         -1.000*le.prim_name_weight100))/100;


    SELF.prim_range_match_code := match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,TRUE);

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         -1.000*le.prim_range_weight100))/100;


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_PHONE;
EXPORT KeyL_PHONEName := BizLinkFull.Filename_keys.Ext_L_PHONE; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.company_phone_7;


// Optional fields

  h.company_phone_3;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.cnp_name;

// Extra credit fields

  h.company_phone_3_ex;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.zip;

  h.prim_name;

  h.city;

  h.st;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.company_phone_7_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.company_phone_3_weight100 ; // Contains 100x the specificity
  h.company_phone_3_ex_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((company_phone_7 NOT IN SET(s.nulls_company_phone_7,company_phone_7) AND company_phone_7 <> (TYPEOF(company_phone_7))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),company_phone_7,company_phone_3,proxid,seleid,orgid,ultid,rcid,cnp_name,company_phone_3_ex,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,city_len,prim_range_len,sec_range_len,company_phone_7_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,company_phone_3_weight100,company_phone_3_ex_weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_PHONE := DataForKey0;
EXPORT KeyL_PHONE := INDEX(DataForKeyL_PHONE,{DataForKeyL_PHONE},{},KeyL_PHONEName);

KeyRec := RECORDOF(KeyL_PHONE);
EXPORT RawFetchL_PHONE(TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_PHONE(
          KEYED((company_phone_7 = param_company_phone_7))

      AND KEYED((param_company_phone_3 = (TYPEOF(company_phone_3))'' OR company_phone_3 = (TYPEOF(company_phone_3))'') OR (company_phone_3 = param_company_phone_3))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_PHONE_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_PHONE(TYPEOF(h.company_phone_7) param_company_phone_7 = (TYPEOF(h.company_phone_7))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.company_phone_3) param_company_phone_3 = (TYPEOF(h.company_phone_3))'',TYPEOF(h.company_phone_3_ex) param_company_phone_3_ex = (TYPEOF(h.company_phone_3_ex))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_PHONE(param_company_phone_7,param_cnp_name,param_company_phone_3,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 8+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 8+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.company_phone_7_match_code := match_methods(File_BizHead).match_company_phone_7(le.company_phone_7,param_company_phone_7,TRUE);

    SELF.company_phone_7Weight := (50+MAP (
         SELF.company_phone_7_match_code = SALT44.MatchCode.ExactMatch =>le.company_phone_7_weight100,
         -0.798*le.company_phone_7_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.company_phone_3_match_code := MAP(
         le.company_phone_3 = (TYPEOF(le.company_phone_3))'' OR param_company_phone_3 = (TYPEOF(param_company_phone_3))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_phone_3(le.company_phone_3,param_company_phone_3,FALSE));

    SELF.company_phone_3Weight := (50+MAP (
         SELF.company_phone_3_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_phone_3_match_code = SALT44.MatchCode.ExactMatch =>le.company_phone_3_weight100,
         -0.952*le.company_phone_3_weight100))/100;


    SELF.company_phone_3_ex_match_code := MAP(
         le.company_phone_3_ex = (TYPEOF(le.company_phone_3_ex))'' OR param_company_phone_3_ex = (TYPEOF(param_company_phone_3_ex))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_phone_3_ex(le.company_phone_3_ex,param_company_phone_3_ex,FALSE));

    SELF.company_phone_3_exWeight := (50+MAP (
         SELF.company_phone_3_ex_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_phone_3_ex_match_code = SALT44.MatchCode.ExactMatch =>le.company_phone_3_ex_weight100,
         -0.952*le.company_phone_3_ex_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.company_phone_7Weight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.company_phone_3Weight) + MAX(0, SELF.company_phone_3_exWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_FEIN;
EXPORT KeyL_FEINName := BizLinkFull.Filename_keys.Ext_L_FEIN; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.company_fein;


  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen
// Extra credit fields

  h.company_sic_code1;

  h.cnp_name;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.zip;

  h.prim_name;

  h.city;

  h.st;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.company_fein_len;

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.company_fein_weight100 ; // Contains 100x the specificity
  INTEGER2 company_fein_e1_Weight100 := SALT44.Min0(h.company_fein_weight100 + 100*log(h.company_fein_cnt/h.company_fein_e1_cnt)/log(2)); // Precompute edit-distance specificity

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((company_fein NOT IN SET(s.nulls_company_fein,company_fein) AND company_fein <> (TYPEOF(company_fein))'')),layout),company_fein,proxid,seleid,orgid,ultid,rcid,company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,company_fein_len,prim_name_len,city_len,prim_range_len,sec_range_len,company_fein_weight100,company_fein_e1_Weight100,company_sic_code1_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_FEIN := DataForKey0;
EXPORT KeyL_FEIN := INDEX(DataForKeyL_FEIN,{DataForKeyL_FEIN},{},KeyL_FEINName);

KeyRec := RECORDOF(KeyL_FEIN);
EXPORT RawFetchL_FEIN(TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_FEIN(
          KEYED((company_fein = param_company_fein))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_FEIN_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_FEIN(TYPEOF(h.company_fein) param_company_fein = (TYPEOF(h.company_fein))'',TYPEOF(h.company_fein_len) param_company_fein_len = (TYPEOF(h.company_fein_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_FEIN(param_company_fein,param_company_fein_len,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 9+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 9+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.company_fein_match_code := match_methods(File_BizHead).match_company_fein(le.company_fein,param_company_fein,le.company_fein_len,param_company_fein_len,TRUE);

    SELF.company_feinWeight := (50+MAP (
         SELF.company_fein_match_code = SALT44.MatchCode.ExactMatch =>le.company_fein_weight100,
         -0.941*le.company_fein_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.company_feinWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_URL;
EXPORT KeyL_URLName := BizLinkFull.Filename_keys.Ext_L_URL; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields
UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion

// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.st;

// Extra credit fields

  h.company_sic_code1;

  h.cnp_name;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.zip;

  h.prim_name;

  h.city;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing

        h.company_url;

            UNSIGNED8 gss_bloom := SALT44.Fn_Wordbag_To_Bloom(h.company_url); // To allow pruning of positives from rawfetch



  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.st_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((company_url NOT IN SET(s.nulls_company_url,company_url) AND company_url <> (TYPEOF(company_url))'')),layout),GSS_hash,proxid,seleid,orgid,ultid,rcid,st,company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,company_url,gss_bloom,prim_name_len,city_len,prim_range_len,sec_range_len,st_weight100,company_sic_code1_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT44.mac_expand_wordbag_key(DataForKey0,GSS_hash,company_url,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
SHARED DataForKeyL_URL := DataForKey2;
EXPORT KeyL_URL := INDEX(DataForKeyL_URL,{DataForKeyL_URL},{},KeyL_URLName);

KeyRec := RECORDOF(KeyL_URL);
EXPORT RawFetchL_URL(TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT44.fn_string_to_wordstream(param_company_url);
    indexOutputRecord := RECORDOF(KeyL_URL);
    slimrec := { KeyL_URL.gss_word_weight, KeyL_URL.proxid, KeyL_URL.seleid, KeyL_URL.orgid, KeyL_URL.ultid };
    BloomF := SALT44.Fn_Wordbag_To_Bloom(param_company_url); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(LIMIT(KEYL_URL( KEYED(GSS_hash = search) AND (GSS_bloom & BloomF) = BloomF
AND ((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))),Config_BIP.L_URL_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)/*HACK28d*/,ultid,orgid,seleid,proxid,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT44.MAC_collate_wordbag_matches4(wds,slimrec,doIndexRead,ultid,orgid,seleid,proxid,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, KeyL_URL, KEYED(RIGHT.GSS_Hash = wds[1].hsh) AND KEYED(RIGHT.fallback_value >= param_fallback_value) AND KEYED(LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid),TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(SUM(wds,spec) > 19,res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))); // Ensure at least spc of specificity in gss portion
   END;

EXPORT ScoredproxidFetchL_URL(TYPEOF(h.company_url) param_company_url = (TYPEOF(h.company_url))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_URL(param_company_url,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 10+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 10+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.company_url_match_code := match_methods(File_BizHead).match_company_url(le.company_url,param_company_url,TRUE);

    SELF.company_urlWeight := le.gss_word_weight; //Fixed Wordbag weights accumulated in gss_weight field
      SELF.company_url_GSS_Weight := le.gss_word_weight;// MORE - need to scale in independence
      SELF.company_url_gss_cases := DATASET([{le.gss_hash}],SALT44.layout_GSS_cases);


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.company_urlWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CONTACT_ZIP;
EXPORT KeyL_CONTACT_ZIPName := BizLinkFull.Filename_keys.Ext_L_CONTACT_ZIP; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.fname_preferred;


  h.lname;


  h.zip;


// Optional fields

  h.st;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.mname;


  h.cnp_name;

// Extra credit fields

  h.fname;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_name;

  h.city;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.lname_len;

  h.mname_len;

  h.fname_len;

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.fname_preferred_weight100 ; // Contains 100x the specificity
  h.lname_weight100 ; // Contains 100x the specificity
  h.lname_initial_char_weight100 ; // Contains 100x the specificity
  h.lname_e2_Weight100;

  h.zip_weight100 ; // Contains 100x the specificity
  h.mname_weight100 ; // Contains 100x the specificity
  h.mname_initial_char_weight100 ; // Contains 100x the specificity
  h.mname_e2_Weight100;

  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.fname_weight100 ; // Contains 100x the specificity
  h.fname_initial_char_weight100 ; // Contains 100x the specificity
  h.fname_e1_Weight100;

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((fname_preferred NOT IN SET(s.nulls_fname_preferred,fname_preferred) AND fname_preferred <> (TYPEOF(fname_preferred))''),(lname NOT IN SET(s.nulls_lname,lname) AND lname <> (TYPEOF(lname))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),fname_preferred,lname,zip,st,proxid,seleid,orgid,ultid,rcid,mname,cnp_name,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,lname_len,mname_len,fname_len,prim_name_len,city_len,prim_range_len,sec_range_len,fname_preferred_weight100,lname_weight100,lname_initial_char_weight100,lname_e2_Weight100,zip_weight100,mname_weight100,mname_initial_char_weight100,mname_e2_Weight100,cnp_name_weight100,cnp_name_initial_char_weight100,st_weight100,fname_weight100,fname_initial_char_weight100,fname_e1_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CONTACT_ZIP := DataForKey0;
EXPORT KeyL_CONTACT_ZIP := INDEX(DataForKeyL_CONTACT_ZIP,{DataForKeyL_CONTACT_ZIP},{},KeyL_CONTACT_ZIPName);

KeyRec := RECORDOF(KeyL_CONTACT_ZIP);
EXPORT RawFetchL_CONTACT_ZIP(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CONTACT_ZIP(
          KEYED((fname_preferred = param_fname_preferred))

      AND KEYED((lname = param_lname))
      AND KEYED((zip IN SET(param_zip,zip)))

      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_mname = (TYPEOF(mname))'' OR mname = (TYPEOF(mname))'') OR (mname = param_mname) OR ((mname[1..LENGTH(TRIM(param_mname))] = param_mname OR param_mname[1..LENGTH(TRIM(mname))] = mname) OR (Config_BIP.WithinEditN(mname,mname_len,param_mname,param_mname_len,2, 0))))
      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CONTACT_ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CONTACT_ZIP(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CONTACT_ZIP(param_fname_preferred,param_lname,param_lname_len,param_zip,param_mname,param_mname_len,param_cnp_name,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 11+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 11+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.fname_preferred_match_code := match_methods(File_BizHead).match_fname_preferred(le.fname_preferred,param_fname_preferred,TRUE);

    SELF.fname_preferredWeight := (50+MAP (
         SELF.fname_preferred_match_code = SALT44.MatchCode.ExactMatch =>le.fname_preferred_weight100,
         -0.562*le.fname_preferred_weight100))/100;


    SELF.lname_match_code := match_methods(File_BizHead).match_lname(le.lname,param_lname,le.lname_len,param_lname_len,TRUE);

    SELF.lnameWeight := (50+MAP (
         SELF.lname_match_code = SALT44.MatchCode.ExactMatch =>le.lname_weight100,
         -0.651*le.lname_weight100))/100;


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.mname_match_code := MAP(
         le.mname = (TYPEOF(le.mname))'' OR param_mname = (TYPEOF(param_mname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_mname(le.mname,param_mname,le.mname_len,param_mname_len,FALSE));

    SELF.mnameWeight := (50+MAP (
         SELF.mname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.mname_match_code = SALT44.MatchCode.ExactMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialLMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.mname,param_mname,le.mname_weight100,le.mname_initial_char_weight100),
         SELF.mname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.mname_e2_weight100,

         -0.723*le.mname_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.fname_match_code := MAP(
         le.fname = (TYPEOF(le.fname))'' OR param_fname = (TYPEOF(param_fname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_fname(le.fname,param_fname,le.fname_len,param_fname_len,FALSE));

    SELF.fnameWeight := (50+MAP (
         SELF.fname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.fname_match_code = SALT44.MatchCode.ExactMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialLMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.fname,param_fname,le.fname_weight100,le.fname_initial_char_weight100),
         SELF.fname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.fname_e1_weight100,

         -0.578*le.fname_weight100))/100*0.20;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.fname_preferredWeight) + MAX(0, SELF.lnameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.mnameWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.fnameWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CONTACT_ST;
EXPORT KeyL_CONTACT_STName := BizLinkFull.Filename_keys.Ext_L_CONTACT_ST; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.fname_preferred;


  h.lname;


  h.st;


// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.mname;


  h.cnp_name;

// Extra credit fields

  h.fname;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_name;

  h.city;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.lname_len;

  h.mname_len;

  h.fname_len;

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.fname_preferred_weight100 ; // Contains 100x the specificity
  h.lname_weight100 ; // Contains 100x the specificity
  h.lname_initial_char_weight100 ; // Contains 100x the specificity
  h.lname_e2_Weight100;

  h.st_weight100 ; // Contains 100x the specificity
  h.mname_weight100 ; // Contains 100x the specificity
  h.mname_initial_char_weight100 ; // Contains 100x the specificity
  h.mname_e2_Weight100;

  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.fname_weight100 ; // Contains 100x the specificity
  h.fname_initial_char_weight100 ; // Contains 100x the specificity
  h.fname_e1_Weight100;

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((fname_preferred NOT IN SET(s.nulls_fname_preferred,fname_preferred) AND fname_preferred <> (TYPEOF(fname_preferred))''),(lname NOT IN SET(s.nulls_lname,lname) AND lname <> (TYPEOF(lname))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),fname_preferred,lname,st,proxid,seleid,orgid,ultid,rcid,mname,cnp_name,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,lname_len,mname_len,fname_len,prim_name_len,city_len,prim_range_len,sec_range_len,fname_preferred_weight100,lname_weight100,lname_initial_char_weight100,lname_e2_Weight100,st_weight100,mname_weight100,mname_initial_char_weight100,mname_e2_Weight100,cnp_name_weight100,cnp_name_initial_char_weight100,fname_weight100,fname_initial_char_weight100,fname_e1_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CONTACT_ST := DataForKey0;
EXPORT KeyL_CONTACT_ST := INDEX(DataForKeyL_CONTACT_ST,{DataForKeyL_CONTACT_ST},{},KeyL_CONTACT_STName);

KeyRec := RECORDOF(KeyL_CONTACT_ST);
EXPORT RawFetchL_CONTACT_ST(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CONTACT_ST(
          KEYED((fname_preferred = param_fname_preferred))

      AND KEYED((lname = param_lname))
      AND KEYED((st = param_st))

      AND ((param_mname = (TYPEOF(mname))'' OR mname = (TYPEOF(mname))'') OR (mname = param_mname) OR ((mname[1..LENGTH(TRIM(param_mname))] = param_mname OR param_mname[1..LENGTH(TRIM(mname))] = mname) OR (Config_BIP.WithinEditN(mname,mname_len,param_mname,param_mname_len,2, 0))))
      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CONTACT_ST_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CONTACT_ST(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CONTACT_ST(param_fname_preferred,param_lname,param_lname_len,param_st,param_mname,param_mname_len,param_cnp_name,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 12+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 12+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.fname_preferred_match_code := match_methods(File_BizHead).match_fname_preferred(le.fname_preferred,param_fname_preferred,TRUE);

    SELF.fname_preferredWeight := (50+MAP (
         SELF.fname_preferred_match_code = SALT44.MatchCode.ExactMatch =>le.fname_preferred_weight100,
         -0.562*le.fname_preferred_weight100))/100;


    SELF.lname_match_code := match_methods(File_BizHead).match_lname(le.lname,param_lname,le.lname_len,param_lname_len,TRUE);

    SELF.lnameWeight := (50+MAP (
         SELF.lname_match_code = SALT44.MatchCode.ExactMatch =>le.lname_weight100,
         -0.651*le.lname_weight100))/100;


    SELF.st_match_code := match_methods(File_BizHead).match_st(le.st,param_st,TRUE);

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.mname_match_code := MAP(
         le.mname = (TYPEOF(le.mname))'' OR param_mname = (TYPEOF(param_mname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_mname(le.mname,param_mname,le.mname_len,param_mname_len,FALSE));

    SELF.mnameWeight := (50+MAP (
         SELF.mname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.mname_match_code = SALT44.MatchCode.ExactMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialLMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.mname,param_mname,le.mname_weight100,le.mname_initial_char_weight100),
         SELF.mname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.mname_e2_weight100,

         -0.723*le.mname_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.fname_match_code := MAP(
         le.fname = (TYPEOF(le.fname))'' OR param_fname = (TYPEOF(param_fname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_fname(le.fname,param_fname,le.fname_len,param_fname_len,FALSE));

    SELF.fnameWeight := (50+MAP (
         SELF.fname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.fname_match_code = SALT44.MatchCode.ExactMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialLMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.fname,param_fname,le.fname_weight100,le.fname_initial_char_weight100),
         SELF.fname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.fname_e1_weight100,

         -0.578*le.fname_weight100))/100*0.20;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.fname_preferredWeight) + MAX(0, SELF.lnameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.mnameWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.fnameWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CONTACT;
EXPORT KeyL_CONTACTName := BizLinkFull.Filename_keys.Ext_L_CONTACT; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.fname_preferred;


  h.lname;


// Optional fields

  h.zip;

  h.st;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.mname;


  h.cnp_name;

// Extra credit fields

  h.fname;

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_name;

  h.city;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.lname_len;

  h.mname_len;

  h.fname_len;

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.fname_preferred_weight100 ; // Contains 100x the specificity
  h.lname_weight100 ; // Contains 100x the specificity
  h.lname_initial_char_weight100 ; // Contains 100x the specificity
  h.lname_e2_Weight100;

  h.mname_weight100 ; // Contains 100x the specificity
  h.mname_initial_char_weight100 ; // Contains 100x the specificity
  h.mname_e2_Weight100;

  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.fname_weight100 ; // Contains 100x the specificity
  h.fname_initial_char_weight100 ; // Contains 100x the specificity
  h.fname_e1_Weight100;

  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((fname_preferred NOT IN SET(s.nulls_fname_preferred,fname_preferred) AND fname_preferred <> (TYPEOF(fname_preferred))''),(lname NOT IN SET(s.nulls_lname,lname) AND lname <> (TYPEOF(lname))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),fname_preferred,lname,zip,st,proxid,seleid,orgid,ultid,rcid,mname,cnp_name,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,lname_len,mname_len,fname_len,prim_name_len,city_len,prim_range_len,sec_range_len,fname_preferred_weight100,lname_weight100,lname_initial_char_weight100,lname_e2_Weight100,mname_weight100,mname_initial_char_weight100,mname_e2_Weight100,cnp_name_weight100,cnp_name_initial_char_weight100,zip_weight100,st_weight100,fname_weight100,fname_initial_char_weight100,fname_e1_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CONTACT := DataForKey0;
EXPORT KeyL_CONTACT := INDEX(DataForKeyL_CONTACT,{DataForKeyL_CONTACT},{},KeyL_CONTACTName);

KeyRec := RECORDOF(KeyL_CONTACT);
EXPORT RawFetchL_CONTACT(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CONTACT(
          KEYED((fname_preferred = param_fname_preferred))

      AND KEYED((lname = param_lname))

      AND KEYED((~EXISTS(param_zip) OR zip = (TYPEOF(zip))'') OR (zip IN SET(param_zip,zip)))
      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_mname = (TYPEOF(mname))'' OR mname = (TYPEOF(mname))'') OR (mname = param_mname) OR ((mname[1..LENGTH(TRIM(param_mname))] = param_mname OR param_mname[1..LENGTH(TRIM(mname))] = mname) OR (Config_BIP.WithinEditN(mname,mname_len,param_mname,param_mname_len,2, 0))))
      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CONTACT_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CONTACT(TYPEOF(h.fname_preferred) param_fname_preferred = (TYPEOF(h.fname_preferred))'',TYPEOF(h.lname) param_lname = (TYPEOF(h.lname))'',TYPEOF(h.lname_len) param_lname_len = (TYPEOF(h.lname_len))'',TYPEOF(h.mname) param_mname = (TYPEOF(h.mname))'',TYPEOF(h.mname_len) param_mname_len = (TYPEOF(h.mname_len))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fname) param_fname = (TYPEOF(h.fname))'',TYPEOF(h.fname_len) param_fname_len = (TYPEOF(h.fname_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CONTACT(param_fname_preferred,param_lname,param_lname_len,param_mname,param_mname_len,param_cnp_name,param_zip,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 13+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 13+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.fname_preferred_match_code := match_methods(File_BizHead).match_fname_preferred(le.fname_preferred,param_fname_preferred,TRUE);

    SELF.fname_preferredWeight := (50+MAP (
         SELF.fname_preferred_match_code = SALT44.MatchCode.ExactMatch =>le.fname_preferred_weight100,
         -0.562*le.fname_preferred_weight100))/100;


    SELF.lname_match_code := match_methods(File_BizHead).match_lname(le.lname,param_lname,le.lname_len,param_lname_len,TRUE);

    SELF.lnameWeight := (50+MAP (
         SELF.lname_match_code = SALT44.MatchCode.ExactMatch =>le.lname_weight100,
         -0.651*le.lname_weight100))/100;


    SELF.mname_match_code := MAP(
         le.mname = (TYPEOF(le.mname))'' OR param_mname = (TYPEOF(param_mname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_mname(le.mname,param_mname,le.mname_len,param_mname_len,FALSE));

    SELF.mnameWeight := (50+MAP (
         SELF.mname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.mname_match_code = SALT44.MatchCode.ExactMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialLMatch =>le.mname_weight100,
         SELF.mname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.mname,param_mname,le.mname_weight100,le.mname_initial_char_weight100),
         SELF.mname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.mname_e2_weight100,

         -0.723*le.mname_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.fname_match_code := MAP(
         le.fname = (TYPEOF(le.fname))'' OR param_fname = (TYPEOF(param_fname))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_fname(le.fname,param_fname,le.fname_len,param_fname_len,FALSE));

    SELF.fnameWeight := (50+MAP (
         SELF.fname_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.fname_match_code = SALT44.MatchCode.ExactMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialLMatch =>le.fname_weight100,
         SELF.fname_match_code = SALT44.MatchCode.InitialRMatch=> SALT44.Fn_Interpolate_Initial(le.fname,param_fname,le.fname_weight100,le.fname_initial_char_weight100),
         SELF.fname_match_code = SALT44.MatchCode.EditDistanceMatch =>le.fname_e1_weight100,

         -0.578*le.fname_weight100))/100*0.20;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.fname_preferredWeight) + MAX(0, SELF.lnameWeight) + MAX(0, SELF.mnameWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.fnameWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CONTACT_SSN;
EXPORT KeyL_CONTACT_SSNName := BizLinkFull.Filename_keys.Ext_L_CONTACT_SSN; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.contact_ssn;


  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen
// Extra credit fields

  h.contact_email;

  h.company_sic_code1;

  h.cnp_name;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.zip;

  h.prim_name;

  h.city;

  h.st;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.contact_ssn_weight100 ; // Contains 100x the specificity
  h.contact_email_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((contact_ssn NOT IN SET(s.nulls_contact_ssn,contact_ssn) AND contact_ssn <> (TYPEOF(contact_ssn))'')),layout),contact_ssn,proxid,seleid,orgid,ultid,rcid,contact_email,company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,city_len,prim_range_len,sec_range_len,contact_ssn_weight100,contact_email_weight100,company_sic_code1_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CONTACT_SSN := DataForKey0;
EXPORT KeyL_CONTACT_SSN := INDEX(DataForKeyL_CONTACT_SSN,{DataForKeyL_CONTACT_SSN},{},KeyL_CONTACT_SSNName);

KeyRec := RECORDOF(KeyL_CONTACT_SSN);
EXPORT RawFetchL_CONTACT_SSN(TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CONTACT_SSN(
          KEYED((contact_ssn = param_contact_ssn))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CONTACT_SSN_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CONTACT_SSN(TYPEOF(h.contact_ssn) param_contact_ssn = (TYPEOF(h.contact_ssn))'',TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CONTACT_SSN(param_contact_ssn,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 14+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 14+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.contact_ssn_match_code := match_methods(File_BizHead).match_contact_ssn(le.contact_ssn,param_contact_ssn,TRUE);

    SELF.contact_ssnWeight := (50+MAP (
         SELF.contact_ssn_match_code = SALT44.MatchCode.ExactMatch =>le.contact_ssn_weight100,
         -0.866*le.contact_ssn_weight100))/100;


    SELF.contact_email_match_code := MAP(
         le.contact_email = (TYPEOF(le.contact_email))'' OR param_contact_email = (TYPEOF(param_contact_email))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_contact_email(le.contact_email,param_contact_email,FALSE));

    SELF.contact_emailWeight := (50+MAP (
         SELF.contact_email_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.contact_email_match_code = SALT44.MatchCode.ExactMatch =>le.contact_email_weight100,
         -0.913*le.contact_email_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.contact_ssnWeight) + MAX(0, SELF.contact_emailWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_EMAIL;
EXPORT KeyL_EMAILName := BizLinkFull.Filename_keys.Ext_L_EMAIL; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.contact_email;


  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen
// Extra credit fields

  h.company_sic_code1;

  h.cnp_name;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.zip;

  h.prim_name;

  h.city;

  h.st;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.contact_email_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((contact_email NOT IN SET(s.nulls_contact_email,contact_email) AND contact_email <> (TYPEOF(contact_email))'')),layout),contact_email,proxid,seleid,orgid,ultid,rcid,company_sic_code1,cnp_name,cnp_number,cnp_btype,cnp_lowv,zip,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,city_len,prim_range_len,sec_range_len,contact_email_weight100,company_sic_code1_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,zip_weight100,prim_name_weight100,prim_name_e1_Weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_EMAIL := DataForKey0;
EXPORT KeyL_EMAIL := INDEX(DataForKeyL_EMAIL,{DataForKeyL_EMAIL},{},KeyL_EMAILName);

KeyRec := RECORDOF(KeyL_EMAIL);
EXPORT RawFetchL_EMAIL(TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_EMAIL(
          KEYED((contact_email = param_contact_email))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_EMAIL_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_EMAIL(TYPEOF(h.contact_email) param_contact_email = (TYPEOF(h.contact_email))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_EMAIL(param_contact_email,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 15+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 15+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.contact_email_match_code := match_methods(File_BizHead).match_contact_email(le.contact_email,param_contact_email,TRUE);

    SELF.contact_emailWeight := (50+MAP (
         SELF.contact_email_match_code = SALT44.MatchCode.ExactMatch =>le.contact_email_weight100,
         -0.913*le.contact_email_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.contact_emailWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_SIC;
EXPORT KeyL_SICName := BizLinkFull.Filename_keys.Ext_L_SIC; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.company_sic_code1;


  h.zip;


// Optional fields
  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.cnp_name;


  h.prim_name;

  h.powid; // Uncle #1

  h.prim_name_len;

//Scores for various field components
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;


END;

DataForKey0 := DEDUP(SORT(TABLE(h((company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1) AND company_sic_code1 <> (TYPEOF(company_sic_code1))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),layout),company_sic_code1,zip,proxid,seleid,orgid,ultid,rcid,cnp_name,prim_name,powid,prim_name_len,company_sic_code1_weight100,zip_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,prim_name_weight100,prim_name_e1_Weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_SIC := DataForKey0;
EXPORT KeyL_SIC := INDEX(DataForKeyL_SIC,{DataForKeyL_SIC},{},KeyL_SICName);

KeyRec := RECORDOF(KeyL_SIC);
EXPORT RawFetchL_SIC(TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_SIC(
          KEYED((company_sic_code1 = param_company_sic_code1))

      AND KEYED((zip IN SET(param_zip,zip)))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))
      AND ((param_prim_name = (TYPEOF(prim_name))'' OR prim_name = (TYPEOF(prim_name))'') OR (prim_name = param_prim_name) OR ((Config_BIP.WithinEditN(prim_name,prim_name_len,param_prim_name,param_prim_name_len,1, 0))))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_SIC_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_SIC(TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_SIC(param_company_sic_code1,param_zip,param_cnp_name,param_prim_name,param_prim_name_len,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 16+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 16+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.company_sic_code1_match_code := match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,TRUE);

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.prim_nameWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_SOURCE;
EXPORT KeyL_SOURCEName := BizLinkFull.Filename_keys.Ext_L_SOURCE; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.source_record_id;


  h.source;


// Optional fields

  h.zip;

  h.st;

  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen

  h.cnp_name;


  h.prim_name;


  h.city;

// Extra credit fields

  h.company_sic_code1;

  h.cnp_number;

  h.cnp_btype;

  h.cnp_lowv;

  h.prim_range;

  h.sec_range;

  h.parent_proxid;

  h.sele_proxid;

  h.org_proxid;

  h.ultimate_proxid;

  h.sele_flag;

  h.org_flag;

  h.ult_flag;

  h.powid; // Uncle #1

  h.prim_name_len;

  h.city_len;

  h.prim_range_len;

  h.sec_range_len;

//Scores for various field components
  h.source_record_id_weight100 ; // Contains 100x the specificity
  h.source_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;

  h.zip_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT44.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity

  h.st_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;

  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;

  h.parent_proxid_weight100 ; // Contains 100x the specificity
  h.sele_proxid_weight100 ; // Contains 100x the specificity
  h.org_proxid_weight100 ; // Contains 100x the specificity
  h.ultimate_proxid_weight100 ; // Contains 100x the specificity
  h.sele_flag_weight100 ; // Contains 100x the specificity
  h.org_flag_weight100 ; // Contains 100x the specificity
  h.ult_flag_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((source_record_id NOT IN SET(s.nulls_source_record_id,source_record_id) AND source_record_id <> (TYPEOF(source_record_id))''),(source NOT IN SET(s.nulls_source,source) AND source <> (TYPEOF(source))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),source_record_id,source,zip,st,proxid,seleid,orgid,ultid,rcid,cnp_name,prim_name,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,city_len,prim_range_len,sec_range_len,source_record_id_weight100,source_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,prim_name_weight100,prim_name_e1_Weight100,zip_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,st_weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,prim_range_weight100,prim_range_e1_Weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_SOURCE := DataForKey0;
EXPORT KeyL_SOURCE := INDEX(DataForKeyL_SOURCE,{DataForKeyL_SOURCE},{},KeyL_SOURCEName);

KeyRec := RECORDOF(KeyL_SOURCE);
EXPORT RawFetchL_SOURCE(TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_SOURCE(
          KEYED((source_record_id = param_source_record_id))

      AND KEYED((source = param_source))

      AND KEYED((~EXISTS(param_zip) OR zip = (TYPEOF(zip))'') OR (zip IN SET(param_zip,zip)))
      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100))
      AND ((param_prim_name = (TYPEOF(prim_name))'' OR prim_name = (TYPEOF(prim_name))'') OR (prim_name = param_prim_name) OR ((Config_BIP.WithinEditN(prim_name,prim_name_len,param_prim_name,param_prim_name_len,1, 0))))
      AND ((param_city = (TYPEOF(city))'' OR city = (TYPEOF(city))'') OR (city = param_city) OR ((metaphonelib.DMetaPhone1(city)=metaphonelib.DMetaPhone1(param_city)) OR (Config_BIP.WithinEditN(city,city_len,param_city,param_city_len,2, 0))))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_SOURCE_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_SOURCE(TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_SOURCE(param_source_record_id,param_source,param_cnp_name,param_prim_name,param_prim_name_len,param_zip,param_city,param_city_len,param_st,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 17+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 17+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.source_record_id_match_code := match_methods(File_BizHead).match_source_record_id(le.source_record_id,param_source_record_id,TRUE);

    SELF.source_record_idWeight := (50+MAP (
         SELF.source_record_id_match_code = SALT44.MatchCode.ExactMatch =>le.source_record_id_weight100,
         -0.244*le.source_record_id_weight100))/100;


    SELF.source_match_code := match_methods(File_BizHead).match_source(le.source,param_source,TRUE);

    SELF.sourceWeight := (50+MAP (
         SELF.source_match_code = SALT44.MatchCode.ExactMatch =>le.source_weight100,
         -0.486*le.source_weight100))/100;


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)

         ))/100;


    SELF.prim_name_match_code := MAP(
         le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,FALSE));

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         SELF.prim_name_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_name_e1_weight100,

         -1.000*le.prim_name_weight100))/100;


    SELF.zip_match_code := MAP(
         le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT44.MatchCode.OneSideNull,

         match_methods(File_BizHead).match_zip_el(le.zip,SET(param_zip,zip),FALSE));

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch => /*HACK16*/ if(count(param_zip) > 1, (1100 * param_zip(zip=le.zip)[1].weight/100.0), (le.zip_weight100 * param_zip(zip=le.zip)[1].weight/100.0)),
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' OR le.st <> param_st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,param_city,le.city_len,param_city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,param_st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.prim_range_match_code := MAP(
         le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,le.prim_range_len,param_prim_range_len,FALSE));

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         SELF.prim_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.prim_range_e1_weight100,

         -1.000*le.prim_range_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,le.sec_range_len,param_sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.source_record_idWeight) + MAX(0, SELF.sourceWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
// Working with LINKPATH L_CONTACT_DID;
EXPORT KeyL_CONTACT_DIDName := BizLinkFull.Filename_keys.Ext_L_CONTACT_DID; /*HACK07*/

layout := RECORD // project out required fields
// Compulsory fields

  h.contact_did;


  h.fallback_value; // Populate the fallback field
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1

  h.proxid; // The ID field
  h.rcid; // For the case where an external linkage did not happen
  h.powid; // Uncle #1

//Scores for various field components
  h.contact_did_weight100 ; // Contains 100x the specificity

END;

DataForKey0 := DEDUP(SORT(TABLE(h((contact_did NOT IN SET(s.nulls_contact_did,contact_did) AND contact_did <> (TYPEOF(contact_did))'')),layout),contact_did,proxid,seleid,orgid,ultid,rcid,powid,contact_did_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKeyL_CONTACT_DID := DataForKey0;
EXPORT KeyL_CONTACT_DID := INDEX(DataForKeyL_CONTACT_DID,{DataForKeyL_CONTACT_DID},{},KeyL_CONTACT_DIDName);

KeyRec := RECORDOF(KeyL_CONTACT_DID);
EXPORT RawFetchL_CONTACT_DID(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( KeyL_CONTACT_DID(
          KEYED((contact_did = param_contact_did))

      AND KEYED(fallback_value >= param_fallback_value)
),Config_BIP.L_CONTACT_DID_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT ScoredproxidFetchL_CONTACT_DID(TYPEOF(h.contact_did) param_contact_did = (TYPEOF(h.contact_did))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetchL_CONTACT_DID(param_contact_did,param_fallback_value);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 18+Config_BIP.KeysBitmapOffset; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 18+Config_BIP.KeysBitmapOffset, 0); // Set bitmap for key failed

    SELF.contact_did_match_code := match_methods(File_BizHead).match_contact_did(le.contact_did,param_contact_did,TRUE);

    SELF.contact_didWeight := (50+MAP (
         SELF.contact_did_match_code = SALT44.MatchCode.ExactMatch =>le.contact_did_weight100,
         -0.663*le.contact_did_weight100))/100;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0 AND le.rcid = 0, 1, MAX(0, SELF.contact_didWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid  AND ( LEFT.proxid<>0 OR LEFT.rcid = RIGHT.rcid ),Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;

EXPORT BuildAll := PARALLEL(BUILDINDEX(PayloadByproxid, OVERWRITE),BUILDINDEX(KeyL_CNPNAME_ZIP, OVERWRITE),BUILDINDEX(KeyL_CNPNAME_ST, OVERWRITE),BUILDINDEX(KeyL_CNPNAME, OVERWRITE),BUILDINDEX(KeyL_CNPNAME_FUZZY, OVERWRITE),BUILDINDEX(KeyL_ADDRESS1, OVERWRITE),BUILDINDEX(KeyL_ADDRESS2, OVERWRITE),BUILDINDEX(KeyL_ADDRESS3, OVERWRITE),BUILDINDEX(KeyL_PHONE, OVERWRITE),BUILDINDEX(KeyL_FEIN, OVERWRITE),BUILDINDEX(KeyL_URL, OVERWRITE),BUILDINDEX(KeyL_CONTACT_ZIP, OVERWRITE),BUILDINDEX(KeyL_CONTACT_ST, OVERWRITE),BUILDINDEX(KeyL_CONTACT, OVERWRITE),BUILDINDEX(KeyL_CONTACT_SSN, OVERWRITE),BUILDINDEX(KeyL_EMAIL, OVERWRITE),BUILDINDEX(KeyL_SIC, OVERWRITE),BUILDINDEX(KeyL_SOURCE, OVERWRITE),BUILDINDEX(KeyL_CONTACT_DID, OVERWRITE));
//Having built all the data - we need to be able to fetch it all too!
EXPORT FetchLayout := RECORD
  UNSIGNED4 UniqueID; // Will store UniqueID of QUERY
  UNSIGNED2 Weight;
  Config_BIP.KeysBitmapType KeysUsed;
  Config_BIP.CombinedCodeType KeysUsedTxt;
  Config_BIP.KeysBitmapType KeysFailed;
  Config_BIP.CombinedCodeType KeysFailedTxt;
  WithUID;
END;
EXPORT Fetch_(DATASET(BizLinkFull.Process_Biz_Layouts.id_stream_layout) ins,INTEGER MaxRecs=0) := FUNCTION
  RData := JOIN(ins,PayloadByproxid,(LEFT.ultid = RIGHT.Fetch_ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.Fetch_orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.Fetch_seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.Fetch_proxid) AND (LEFT.rcid = 0 AND LEFT.proxid<>0 OR LEFT.rcid = RIGHT.Fetch_rcid),
                  TRANSFORM(FetchLayout,SELF.UniqueID := LEFT.UniqueId, SELF.Weight := LEFT.Weight, SELF.KeysUsed := LEFT.KeysUsed, SELF.KeysUsedTxt := Process_Biz_Layouts.KeysBitmapDecode(LEFT.KeysUsed)+Process_Biz_Layouts.KeysBitmapDecode(LEFT.KeysUsed>>Config_BIP.KeysBitmapOffset,'Ext_Data'), SELF.KeysFailed := LEFT.KeysFailed, SELF.KeysFailedTxt := Process_Biz_Layouts.KeysBitmapDecode(LEFT.KeysFailed)+Process_Biz_Layouts.KeysBitmapDecode(LEFT.KeysFailed>>Config_BIP.KeysBitmapOffset,'Ext_Data'), SELF := RIGHT)
                  ,LEFT OUTER,LIMIT(Config_BIP.JoinLimit));
  RLimit := IF ( MaxRecs>0, DEDUP( SORT( RData, UniqueID, -UniqueID ), UniqueID, KEEP(MaxRecs) ), RData );
  RETURN RLimit;
END;
// Nested module very similar to MEOW_Biz - but takes DIVE options into account
EXPORT MEOW_(DATASET(Process_Biz_Layouts.InputLayout) inpu) := MODULE
// Pass-thru any records which already had the proxid on them
  Process_Biz_Layouts.id_stream_layout ptt(inpu le) := TRANSFORM
  SELF.UniqueId := le.UniqueId;
  SELF.IsTruncated := FALSE;
  SELF.seleid := le.Entered_seleid;
  SELF.orgid := le.Entered_orgid;
  SELF.ultid := le.Entered_ultid;
  SELF.powid := le.Entered_powid;
  SELF.proxid := le.Entered_proxid;
  SELF.rcid := le.Entered_rcid;
  SELF.seleid_Weight := Config_BIP.MatchThreshold;
  SELF.seleid_Score := 100;
  SELF.orgid_Weight := Config_BIP.MatchThreshold;
  SELF.orgid_Score := 100;
  SELF.ultid_Weight := Config_BIP.MatchThreshold;
  SELF.ultid_Score := 100;
  SELF.Weight := Config_BIP.MatchThreshold; // Assume at least 'threshold' met
  SELF.Score := 100;
  SELF.powid_Weight := Config_BIP.MatchThreshold;
  SELF.powid_Score := 100;
END;
SHARED pass_thru0 := PROJECT(inpu(~(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0 AND Entered_powid=0)),ptt(LEFT));
SHARED pass_thru := Process_Biz_Layouts.id_stream_complete(pass_thru0);
SHARED Pass := pass_thru;
  in := inpu;
Process_Biz_Layouts.OutputLayout GetResults(Process_Biz_Layouts.InputLayout le) := TRANSFORM
// Need to annotate wordbags with specificities
cnp_name_spec := SALT44.fn_wordbag_appendspecs_fake(le.cnp_name);


company_url_spec := SALT44.fn_wordbag_appendspecs_fake(le.company_url);

// Need to calculate lengths for EDIT fields
UNSIGNED1 company_fein_len := LENGTH(TRIM(le.company_fein));
UNSIGNED1 prim_range_len := LENGTH(TRIM(le.prim_range));
UNSIGNED1 prim_name_len := LENGTH(TRIM(le.prim_name));
UNSIGNED1 sec_range_len := LENGTH(TRIM(le.sec_range));
UNSIGNED1 city_len := LENGTH(TRIM(le.city));
UNSIGNED1 fname_len := LENGTH(TRIM(le.fname));
UNSIGNED1 mname_len := LENGTH(TRIM(le.mname));
UNSIGNED1 lname_len := LENGTH(TRIM(le.lname));
In_disableForce := le.disableForce;
In_bGetAllScores := le.bGetAllScores;
SELF.keys_tried := IF (Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),1 << 1,0) + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2,0) + IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 3,0) + IF (Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),1 << 4,0) + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 5,0) + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 6,0) + IF (Key_BizHead_L_ADDRESS3.CanSearch(le),1 << 7,0) + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 8,0) + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 9,0) + IF (Key_BizHead_L_URL.CanSearch(le),1 << 10,0) + IF (Key_BizHead_L_CONTACT_ZIP.CanSearch(le),1 << 11,0) + IF (Key_BizHead_L_CONTACT_ST.CanSearch(le),1 << 12,0) + IF (Key_BizHead_L_CONTACT.CanSearch(le),1 << 13,0) + IF (Key_BizHead_L_CONTACT_SSN.CanSearch(le),1 << 14,0) + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 15,0) + IF (Key_BizHead_L_SIC.CanSearch(le),1 << 16,0) + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 17,0) + IF (Key_BizHead_L_CONTACT_DID.CanSearch(le),1 << 18,0) + IF (Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),1 << 1+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 3+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),1 << 4+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 5+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 6+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_ADDRESS3.CanSearch(le),1 << 7+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 8+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 9+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_URL.CanSearch(le),1 << 10+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CONTACT_ZIP.CanSearch(le),1 << 11+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CONTACT_ST.CanSearch(le),1 << 12+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CONTACT.CanSearch(le),1 << 13+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CONTACT_SSN.CanSearch(le),1 << 14+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 15+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_SIC.CanSearch(le),1 << 16+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 17+Config_BIP.KeysBitmapOffset,0) + IF (Key_BizHead_L_CONTACT_DID.CanSearch(le),1 << 18+Config_BIP.KeysBitmapOffset,0);
fetchResults0 := ROLLUP(
  MERGE(

SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),ScoredproxidFetchL_CNPNAME_ZIP(param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le),ScoredproxidFetchL_CNPNAME_ST(param_cnp_name := cnp_name_spec,param_st := le.st,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le) AND ~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME.CanSearch(le),ScoredproxidFetchL_CNPNAME(param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_zip := le.zip_cases,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),ScoredproxidFetchL_CNPNAME_FUZZY(param_company_name_prefix := le.company_name_prefix,param_cnp_name := cnp_name_spec,param_st := le.st,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS1.CanSearch(le),ScoredproxidFetchL_ADDRESS1(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS2.CanSearch(le),ScoredproxidFetchL_ADDRESS2(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS3.CanSearch(le),ScoredproxidFetchL_ADDRESS3(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_PHONE.CanSearch(le),ScoredproxidFetchL_PHONE(param_company_phone_7 := le.company_phone_7,param_cnp_name := cnp_name_spec,param_company_phone_3 := le.company_phone_3,param_company_phone_3_ex := le.company_phone_3_ex,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_FEIN.CanSearch(le),ScoredproxidFetchL_FEIN(param_company_fein := le.company_fein,param_company_fein_len := company_fein_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_URL.CanSearch(le),ScoredproxidFetchL_URL(param_company_url := company_url_spec,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le),ScoredproxidFetchL_CONTACT_ZIP(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_zip := le.zip_cases,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF((~BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CONTACT_ST.CanSearch(le),ScoredproxidFetchL_CONTACT_ST(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_st := le.st,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF((~BizLinkFull.Key_BizHead_L_CONTACT_ST.CanSearch(le) AND ~BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CONTACT.CanSearch(le),ScoredproxidFetchL_CONTACT(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_st := le.st,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_SSN.CanSearch(le),ScoredproxidFetchL_CONTACT_SSN(param_contact_ssn := le.contact_ssn,param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_EMAIL.CanSearch(le),ScoredproxidFetchL_EMAIL(param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_SIC.CanSearch(le),ScoredproxidFetchL_SIC(param_company_sic_code1 := le.company_sic_code1,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_SOURCE.CanSearch(le),ScoredproxidFetchL_SOURCE(param_source_record_id := le.source_record_id,param_source := le.source,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid)
,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_DID.CanSearch(le),ScoredproxidFetchL_CONTACT_DID(param_contact_did := le.contact_did,param_fallback_value := le.fallback_value,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid,rcid),SORTED(ultid,orgid,seleid,proxid,rcid)) /* Merged */
  , (RIGHT.proxid > 0 OR RIGHT.rcid = LEFT.rcid)  AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT, RIGHT, In_disableForce))((proxid NOT IN ButNot) AND (SALT44.DebugMode OR ~ForceFailed OR ButNot <> [])); // Warning - is a fetch to keys etc
fetchResults := TOPN(fetchResults0(proxid > 0 OR rcid > 0),le.MaxIDs + 1,-Weight) & fetchResults0(proxid = 0,rcid = 0);
  SELF.Results := PROJECT(CHOOSEN(Process_Biz_Layouts.AdjustKeysUsedAndFailed(fetchResults), le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  SELF.Results_seleid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-seleid),LEFT.seleid=RIGHT.seleid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
  SELF.Results_orgid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_seleid,-orgid),LEFT.orgid=RIGHT.orgid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(seleid=SELF.Results[1].seleid),-seleid));
  SELF.Results_ultid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_orgid,-ultid),LEFT.ultid=RIGHT.ultid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(orgid=SELF.Results[1].orgid),-orgid));
  SELF.Results_powid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-powid),LEFT.powid=RIGHT.powid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));

  Process_Biz_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
RR0 := PROJECT(in(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0 AND Entered_powid=0),GetResults(left),PREFETCH(Config_BIP.MeowPrefetch,PARALLEL));
Process_Biz_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
  In_disableForce := le.disableForce;
  SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
  mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, proxid )
  , (RIGHT.proxid > 0 OR RIGHT.rcid = LEFT.rcid)  AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT, RIGHT, In_disableForce))((proxid NOT IN ButNot) AND (SALT44.DebugMode OR ~ForceFailed OR ButNot <> [])),le.MaxIds + 1,-Weight);
  SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
  SELF.IsTruncated := ((le.IsTruncated OR ri.IsTruncated) AND COUNT(mergedResults) = le.MaxIds) OR COUNT(mergedResults) > le.MaxIds;
  SELF := le;
END;
RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
RR20 := IF ( MultiRec, RR1, RR0 );
Process_Biz_Layouts.OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
  SELF.Results := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results));
  SELF.Results_seleid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_seleid));
  SELF.Results_orgid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_orgid));
  SELF.Results_ultid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_ultid));
  SELF := le;
END;
RR2 := PROJECT(RR20,AdjustScores(LEFT));
Process_Biz_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
  SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
  SELF.Results_seleid := le.Results_seleid(weight >= MAX(le.Results_seleid,weight)-le.LeadThreshold);
  SELF.Results_orgid := le.Results_orgid(weight >= MAX(le.Results_orgid,weight)-le.LeadThreshold);
  SELF.Results_ultid := le.Results_ultid(weight >= MAX(le.Results_ultid,weight)-le.LeadThreshold);
  SELF.IsTruncated := le.IsTruncated AND COUNT(SELF.Results) = le.MaxIds;
  SELF := le;
END;
RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
EXPORT Local_Raw := RR3;
  Process_Biz_Layouts.id_stream_layout n(Local_Raw le,UNSIGNED c) := TRANSFORM
    SELF.rcid := IF(le.Results[c].proxid=0,le.Results[c].rcid,0);
    SELF.UniqueId := le.UniqueId;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
    SELF.seleid_Weight := le.Results_seleid(seleid = le.Results[c].seleid)[1].weight;
    SELF.seleid_Score := le.Results_seleid(seleid = le.Results[c].seleid)[1].score;
    SELF.orgid_Weight := le.Results_orgid(orgid = le.Results[c].orgid)[1].weight;
    SELF.orgid_Score := le.Results_orgid(orgid = le.Results[c].orgid)[1].score;
    SELF.ultid_Weight := le.Results_ultid(ultid = le.Results[c].ultid)[1].weight;
    SELF.ultid_Score := le.Results_ultid(ultid = le.Results[c].ultid)[1].score;
    SELF.powid_Weight := le.Results_powid(powid = le.Results[c].powid)[1].weight;
    SELF.powid_Score := le.Results_powid(powid = le.Results[c].powid)[1].score;
  END;
SHARED LocalUids := NORMALIZE(Local_Raw,COUNT(LEFT.Results),n(LEFT,COUNTER));

EXPORT Uid_Results := Pass + LocalUids;
EXPORT Raw_Data := Fetch_(Uid_Results);
  // This macro can be used to score any data with mapped field names matching the header standard to the input criteria
  // if FORMAT:EFILESEARCH is used in spc, only a subset of field names used in LINKPTHs is scored
  // FORMAT:EFILESEARCH[:FIELD]* can be used in spc, to define a set of field names to score
  EXPORT ScoreExt_DataData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_parent_proxid;
      INTEGER2 Match_sele_proxid;
      INTEGER2 Match_org_proxid;
      INTEGER2 Match_ultimate_proxid;
      INTEGER2 Match_has_lgid;
      INTEGER2 Match_empid;
      INTEGER2 Match_source;
      INTEGER2 Match_source_record_id;
      INTEGER2 Match_source_docid;
      INTEGER2 Match_company_name;
      INTEGER2 Match_company_name_prefix;
      INTEGER2 Match_cnp_name;
      INTEGER2 Match_cnp_number;
      INTEGER2 Match_cnp_btype;
      INTEGER2 Match_cnp_lowv;
      INTEGER2 Match_company_phone;
      INTEGER2 Match_company_phone_3;
      INTEGER2 Match_company_phone_3_ex;
      INTEGER2 Match_company_phone_7;
      INTEGER2 Match_company_fein;
      INTEGER2 Match_company_sic_code1;
      INTEGER2 Match_active_duns_number;
      INTEGER2 Match_prim_range;
      INTEGER2 Match_prim_name;
      INTEGER2 Match_sec_range;
      INTEGER2 Match_city;
      INTEGER2 Match_city_clean;
      INTEGER2 Match_st;
      INTEGER2 Match_zip;
      INTEGER2 Match_company_url;
      INTEGER2 Match_isContact;
      INTEGER2 Match_contact_did;
      INTEGER2 Match_title;
      INTEGER2 Match_fname;
      INTEGER2 Match_fname_preferred;
      INTEGER2 Match_mname;
      INTEGER2 Match_lname;
      INTEGER2 Match_name_suffix;
      INTEGER2 Match_contact_ssn;
      INTEGER2 Match_contact_email;



      INTEGER2 Match_fallback_value;
      INTEGER2 Match_CONTACTNAME;
      INTEGER2 Match_STREETADDRESS;
    END;
    IMPORT SALT44,BizLinkFull;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM

    SELF.Match_parent_proxid := MAP ( ri.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_parent_proxid(le.parent_proxid,ri.parent_proxid,FALSE)));

    SELF.Match_sele_proxid := MAP ( ri.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_sele_proxid(le.sele_proxid,ri.sele_proxid,FALSE)));

    SELF.Match_org_proxid := MAP ( ri.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_org_proxid(le.org_proxid,ri.org_proxid,FALSE)));

    SELF.Match_ultimate_proxid := MAP ( ri.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_ultimate_proxid(le.ultimate_proxid,ri.ultimate_proxid,FALSE)));

    SELF.Match_has_lgid := MAP ( ri.has_lgid = (TYPEOF(ri.has_lgid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.has_lgid = (TYPEOF(ri.has_lgid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.has_lgid = le.has_lgid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_empid := MAP ( ri.empid = (TYPEOF(ri.empid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.empid = (TYPEOF(ri.empid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.empid = le.empid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_source := MAP ( ri.source = (TYPEOF(ri.source))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source = (TYPEOF(ri.source))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_source(le.source,ri.source,FALSE)));

    SELF.Match_source_record_id := MAP ( ri.source_record_id = (TYPEOF(ri.source_record_id))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source_record_id = (TYPEOF(ri.source_record_id))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_source_record_id(le.source_record_id,ri.source_record_id,FALSE)));

    SELF.Match_source_docid := MAP ( ri.source_docid = (TYPEOF(ri.source_docid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source_docid = (TYPEOF(ri.source_docid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.source_docid = le.source_docid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_company_name := MAP ( ri.company_name = (TYPEOF(ri.company_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_name = (TYPEOF(ri.company_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_name(le.company_name,ri.company_name,FALSE)));

    SELF.Match_company_name_prefix := MAP ( ri.company_name_prefix = (TYPEOF(ri.company_name_prefix))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_name_prefix = (TYPEOF(ri.company_name_prefix))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_name_prefix(le.company_name_prefix,ri.company_name_prefix,FALSE)));

    le_cnp_name := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)le.cnp_name);//For later scoring
    ri_cnp_name := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.cnp_name);//For later scoring
    SELF.Match_cnp_name := MAP ( ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,FALSE)));

    SELF.Match_cnp_number := MAP ( ri.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_number(le.cnp_number,ri.cnp_number,FALSE)));

    SELF.Match_cnp_btype := MAP ( ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_btype(le.cnp_btype,ri.cnp_btype,FALSE)));

    SELF.Match_cnp_lowv := MAP ( ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv,FALSE)));

    SELF.Match_company_phone := MAP ( ri.company_phone = (TYPEOF(ri.company_phone))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone = (TYPEOF(ri.company_phone))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.company_phone = le.company_phone => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_company_phone_3 := MAP ( ri.company_phone_3 = (TYPEOF(ri.company_phone_3))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_3 = (TYPEOF(ri.company_phone_3))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_3(le.company_phone_3,ri.company_phone_3,FALSE)));

    SELF.Match_company_phone_3_ex := MAP ( ri.company_phone_3_ex = (TYPEOF(ri.company_phone_3_ex))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_3_ex = (TYPEOF(ri.company_phone_3_ex))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_3_ex(le.company_phone_3_ex,ri.company_phone_3_ex,FALSE)));

    SELF.Match_company_phone_7 := MAP ( ri.company_phone_7 = (TYPEOF(ri.company_phone_7))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_7 = (TYPEOF(ri.company_phone_7))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_7(le.company_phone_7,ri.company_phone_7,FALSE)));

    SELF.Match_company_fein := MAP ( ri.company_fein = (TYPEOF(ri.company_fein))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_fein = (TYPEOF(ri.company_fein))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_fein(le.company_fein,ri.company_fein,0,0,FALSE)));

    SELF.Match_company_sic_code1 := MAP ( ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,FALSE)));

    SELF.Match_active_duns_number := MAP ( ri.active_duns_number = (TYPEOF(ri.active_duns_number))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.active_duns_number = (TYPEOF(ri.active_duns_number))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.active_duns_number = le.active_duns_number => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_prim_range := MAP ( ri.prim_range = (TYPEOF(ri.prim_range))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.prim_range = (TYPEOF(ri.prim_range))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_prim_range(le.prim_range,ri.prim_range,0,0,FALSE)));

    SELF.Match_prim_name := MAP ( ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.prim_name = (TYPEOF(ri.prim_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_prim_name(le.prim_name,ri.prim_name,0,0,FALSE)));

    SELF.Match_sec_range := MAP ( ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.sec_range = (TYPEOF(ri.sec_range))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_sec_range(le.sec_range,ri.sec_range,0,0,FALSE)));

    SELF.Match_city := MAP ( ri.city = (TYPEOF(ri.city))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.city = (TYPEOF(ri.city))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_city(le.city,ri.city,0,0,FALSE)));

    SELF.Match_city_clean := MAP ( ri.city_clean = (TYPEOF(ri.city_clean))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.city_clean = (TYPEOF(ri.city_clean))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_city_clean(le.city_clean,ri.city_clean,FALSE)));

    SELF.Match_st := MAP ( ri.st = (TYPEOF(ri.st))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.st = (TYPEOF(ri.st))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_st(le.st,ri.st,FALSE)));

    SELF.Match_zip := MAP ( ~EXISTS(ri.zip_cases) => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.zip = (TYPEOF(le.zip))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_zip_el(le.zip,SET(ri.zip_cases,zip),FALSE)));

    le_company_url := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)le.company_url);//For later scoring
    ri_company_url := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.company_url);//For later scoring
    SELF.Match_company_url := MAP ( ri.company_url = (TYPEOF(ri.company_url))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_url = (TYPEOF(ri.company_url))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_url(le.company_url,ri.company_url,FALSE)));

    SELF.Match_isContact := MAP ( ri.isContact = (TYPEOF(ri.isContact))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.isContact = (TYPEOF(ri.isContact))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_isContact(le.isContact,ri.isContact,FALSE)));

    SELF.Match_contact_did := MAP ( ri.contact_did = (TYPEOF(ri.contact_did))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_did = (TYPEOF(ri.contact_did))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_did(le.contact_did,ri.contact_did,FALSE)));

    SELF.Match_title := MAP ( ri.title = (TYPEOF(ri.title))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.title = (TYPEOF(ri.title))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_title(le.title,ri.title,FALSE)));

    SELF.Match_fname := MAP ( ri.fname = (TYPEOF(ri.fname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fname = (TYPEOF(ri.fname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fname(le.fname,ri.fname,0,0,FALSE)));

    SELF.Match_fname_preferred := MAP ( ri.fname_preferred = (TYPEOF(ri.fname_preferred))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fname_preferred = (TYPEOF(ri.fname_preferred))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fname_preferred(le.fname_preferred,ri.fname_preferred,FALSE)));

    SELF.Match_mname := MAP ( ri.mname = (TYPEOF(ri.mname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.mname = (TYPEOF(ri.mname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_mname(le.mname,ri.mname,0,0,FALSE)));

    SELF.Match_lname := MAP ( ri.lname = (TYPEOF(ri.lname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.lname = (TYPEOF(ri.lname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_lname(le.lname,ri.lname,0,0,FALSE)));

    SELF.Match_name_suffix := MAP ( ri.name_suffix = (TYPEOF(ri.name_suffix))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.name_suffix = (TYPEOF(ri.name_suffix))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_name_suffix(le.name_suffix,ri.name_suffix,FALSE)));

    SELF.Match_contact_ssn := MAP ( ri.contact_ssn = (TYPEOF(ri.contact_ssn))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_ssn = (TYPEOF(ri.contact_ssn))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_ssn(le.contact_ssn,ri.contact_ssn,FALSE)));

    SELF.Match_contact_email := MAP ( ri.contact_email = (TYPEOF(ri.contact_email))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_email = (TYPEOF(ri.contact_email))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_email(le.contact_email,ri.contact_email,FALSE)));




    SELF.Match_fallback_value := MAP ( ri.fallback_value = (TYPEOF(ri.fallback_value))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fallback_value = (TYPEOF(ri.fallback_value))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fallback_value(le.fallback_value,ri.fallback_value,FALSE)));
    ri_CONTACTNAME := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.CONTACTNAME);//For later scoring
    le_CONTACTNAME := SALT44.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT44.StrType)le.fname) + ' ' + TRIM((SALT44.StrType)le.mname) + ' ' + TRIM((SALT44.StrType)le.lname));//For later scoring
    SELF.Match_CONTACTNAME := MAP ( ri.CONTACTNAME = (typeof(ri.CONTACTNAME))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le_CONTACTNAME = (typeof(ri.CONTACTNAME))'' => SALT44.HeaderSearchMatchCode.BlankField, ri_CONTACTNAME = le_CONTACTNAME => SALT44.HeaderSearchMatchCode.Match, SALT44.HeaderSearchMatchCode.NoMatch);
    ri_STREETADDRESS := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.STREETADDRESS);//For later scoring
    le_STREETADDRESS := SALT44.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT44.StrType)le.prim_range) + ' ' + TRIM((SALT44.StrType)le.prim_name) + ' ' + TRIM((SALT44.StrType)le.sec_range));//For later scoring
    SELF.Match_STREETADDRESS := MAP ( ri.STREETADDRESS = (typeof(ri.STREETADDRESS))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le_STREETADDRESS = (typeof(ri.STREETADDRESS))'' => SALT44.HeaderSearchMatchCode.BlankField, ri_STREETADDRESS = le_STREETADDRESS => SALT44.HeaderSearchMatchCode.Match, SALT44.HeaderSearchMatchCode.NoMatch);



      SELF.Record_Score := SELF.Match_parent_proxid + SELF.Match_sele_proxid + SELF.Match_org_proxid + SELF.Match_ultimate_proxid + SELF.Match_has_lgid + SELF.Match_empid + SELF.Match_source + SELF.Match_source_record_id + SELF.Match_source_docid + SELF.Match_company_name + SELF.Match_company_name_prefix + SELF.Match_cnp_name + SELF.Match_cnp_number + SELF.Match_cnp_btype + SELF.Match_cnp_lowv + SELF.Match_company_phone + SELF.Match_company_phone_3 + SELF.Match_company_phone_3_ex + SELF.Match_company_phone_7 + SELF.Match_company_fein + SELF.Match_company_sic_code1 + SELF.Match_active_duns_number + SELF.Match_prim_range + SELF.Match_prim_name + SELF.Match_sec_range + SELF.Match_city + SELF.Match_city_clean + SELF.Match_st + SELF.Match_zip + SELF.Match_company_url + SELF.Match_isContact + SELF.Match_contact_did + SELF.Match_title + SELF.Match_fname + SELF.Match_fname_preferred + SELF.Match_mname + SELF.Match_lname + SELF.Match_name_suffix + SELF.Match_contact_ssn + SELF.Match_contact_email + SELF.Match_fallback_value + SELF.Match_CONTACTNAME + SELF.Match_STREETADDRESS;
      SELF.Is_FullMatch := SELF.Match_parent_proxid>=0 AND SELF.Match_sele_proxid>=0 AND SELF.Match_org_proxid>=0 AND SELF.Match_ultimate_proxid>=0 AND SELF.Match_has_lgid>=0 AND SELF.Match_empid>=0 AND SELF.Match_source>=0 AND SELF.Match_source_record_id>=0 AND SELF.Match_source_docid>=0 AND SELF.Match_company_name>=0 AND SELF.Match_company_name_prefix>=0 AND SELF.Match_cnp_name>=0 AND SELF.Match_cnp_number>=0 AND SELF.Match_cnp_btype>=0 AND SELF.Match_cnp_lowv>=0 AND SELF.Match_company_phone>=0 AND SELF.Match_company_phone_3>=0 AND SELF.Match_company_phone_3_ex>=0 AND SELF.Match_company_phone_7>=0 AND SELF.Match_company_fein>=0 AND SELF.Match_company_sic_code1>=0 AND SELF.Match_active_duns_number>=0 AND SELF.Match_prim_range>=0 AND SELF.Match_prim_name>=0 AND SELF.Match_sec_range>=0 AND SELF.Match_city>=0 AND SELF.Match_city_clean>=0 AND SELF.Match_st>=0 AND SELF.Match_zip>=0 AND SELF.Match_company_url>=0 AND SELF.Match_isContact>=0 AND SELF.Match_contact_did>=0 AND SELF.Match_title>=0 AND SELF.Match_fname>=0 AND SELF.Match_fname_preferred>=0 AND SELF.Match_mname>=0 AND SELF.Match_lname>=0 AND SELF.Match_name_suffix>=0 AND SELF.Match_contact_ssn>=0 AND SELF.Match_contact_email>=0 AND SELF.Match_fallback_value>=0 AND SELF.Match_CONTACTNAME>=0 AND SELF.Match_STREETADDRESS>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
          SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.proxid=ri.proxid AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;


  i := ScoreExt_DataData(Raw_Data,Inpu);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,proxid,-(Record_Score+Weight-W1)),WHOLE RECORD)(rcid>0 OR KeysFailed<>0); /*HACK20 KeysFailed added*/
END;

//Provide a record of those proxid in the payload keys
  cnts := TABLE(PayloadByproxid,{Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,Cnt := COUNT(GROUP)},Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,MERGE); // ,MERGE should not be needed
EXPORT EFR := PROJECT(cnts,TRANSFORM(Ext_Layouts.EFRR_Layout,SELF.Child_Id := Ext_Layouts.ID_Ext_Data,SELF.ChildId_BMap := 1<<(Ext_Layouts.ID_Ext_Data-1),SELF.proxid := LEFT.Fetch_proxid,SELF.seleid := LEFT.Fetch_seleid,SELF.orgid := LEFT.Fetch_orgid,SELF.ultid := LEFT.Fetch_ultid,SELF := LEFT));
END;

