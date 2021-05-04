IMPORT SALT44,std;
EXPORT Key_BizHead_L_ADDRESS3 := MODULE
//prim_name:prim_range:zip:?:cnp_name:st:+:city:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
EXPORT KeyName := BizLinkFull.Filename_keys.L_ADDRESS3; /*HACK07*/

SHARED h := CandidatesForKey;//The input file - distributed by proxid

SHARED s := Specificities(File_BizHead).Specificities[1];
SHARED s_index := Keys(File_BizHead).Specificities_Key[1]; // Index access for MEOW queries

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

// external files bitmap; Indicates whether proxid has records in the external file Ext_Layouts.ID_XXX; bit:= 1<<(ID_XXX-1)
  h.EFR_BMap;
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

DataForKey0 := DEDUP(SORT(TABLE(h((prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))''),(prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND prim_range <> (TYPEOF(prim_range))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),prim_name,prim_range,zip,st,proxid,seleid,orgid,ultid,cnp_name,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,powid,prim_name_len,prim_range_len,city_len,sec_range_len,EFR_BMap,prim_name_weight100,prim_name_e1_Weight100,prim_range_weight100,prim_range_e1_Weight100,zip_weight100,cnp_name_weight100,cnp_name_initial_char_weight100,st_weight100,city_weight100,city_p_Weight100,city_e2_Weight100,city_e2p_Weight100,company_sic_code1_weight100,cnp_number_weight100,cnp_btype_weight100,cnp_lowv_weight100,sec_range_weight100,sec_range_e1_Weight100,parent_proxid_weight100,sele_proxid_weight100,org_proxid_weight100,ultimate_proxid_weight100,sele_flag_weight100,org_flag_weight100,ult_flag_weight100,-fallback_value,LOCAL),WHOLE RECORD,EXCEPT fallback_value,LOCAL);
SHARED DataForKey := DataForKey0;
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName);

EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,prim_name,prim_range,zip,cnp_name,st,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_city := GROUP( DEDUP( SORT( Grpd, EXCEPT city), EXCEPT city));
  CntRed_city := (KeyCnt-COUNT(Rem_city))/KeyCnt;
  Rem_company_sic_code1 := GROUP( DEDUP( SORT( Grpd, EXCEPT company_sic_code1), EXCEPT company_sic_code1));
  CntRed_company_sic_code1 := (KeyCnt-COUNT(Rem_company_sic_code1))/KeyCnt;
  Rem_cnp_number := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_number), EXCEPT cnp_number));
  CntRed_cnp_number := (KeyCnt-COUNT(Rem_cnp_number))/KeyCnt;
  Rem_cnp_btype := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_btype), EXCEPT cnp_btype));
  CntRed_cnp_btype := (KeyCnt-COUNT(Rem_cnp_btype))/KeyCnt;
  Rem_cnp_lowv := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_lowv), EXCEPT cnp_lowv));
  CntRed_cnp_lowv := (KeyCnt-COUNT(Rem_cnp_lowv))/KeyCnt;
  Rem_sec_range := GROUP( DEDUP( SORT( Grpd, EXCEPT sec_range), EXCEPT sec_range));
  CntRed_sec_range := (KeyCnt-COUNT(Rem_sec_range))/KeyCnt;
  Rem_parent_proxid := GROUP( DEDUP( SORT( Grpd, EXCEPT parent_proxid), EXCEPT parent_proxid));
  CntRed_parent_proxid := (KeyCnt-COUNT(Rem_parent_proxid))/KeyCnt;
  Rem_sele_proxid := GROUP( DEDUP( SORT( Grpd, EXCEPT sele_proxid), EXCEPT sele_proxid));
  CntRed_sele_proxid := (KeyCnt-COUNT(Rem_sele_proxid))/KeyCnt;
  Rem_org_proxid := GROUP( DEDUP( SORT( Grpd, EXCEPT org_proxid), EXCEPT org_proxid));
  CntRed_org_proxid := (KeyCnt-COUNT(Rem_org_proxid))/KeyCnt;
  Rem_ultimate_proxid := GROUP( DEDUP( SORT( Grpd, EXCEPT ultimate_proxid), EXCEPT ultimate_proxid));
  CntRed_ultimate_proxid := (KeyCnt-COUNT(Rem_ultimate_proxid))/KeyCnt;
  Rem_sele_flag := GROUP( DEDUP( SORT( Grpd, EXCEPT sele_flag), EXCEPT sele_flag));
  CntRed_sele_flag := (KeyCnt-COUNT(Rem_sele_flag))/KeyCnt;
  Rem_org_flag := GROUP( DEDUP( SORT( Grpd, EXCEPT org_flag), EXCEPT org_flag));
  CntRed_org_flag := (KeyCnt-COUNT(Rem_org_flag))/KeyCnt;
  Rem_ult_flag := GROUP( DEDUP( SORT( Grpd, EXCEPT ult_flag), EXCEPT ult_flag));
  CntRed_ult_flag := (KeyCnt-COUNT(Rem_ult_flag))/KeyCnt;

EXPORT Shrinkage := DATASET([{'L_ADDRESS3','city',CntRed_city*100,CntRed_city*TSize},{'L_ADDRESS3','company_sic_code1',CntRed_company_sic_code1*100,CntRed_company_sic_code1*TSize},{'L_ADDRESS3','cnp_number',CntRed_cnp_number*100,CntRed_cnp_number*TSize},{'L_ADDRESS3','cnp_btype',CntRed_cnp_btype*100,CntRed_cnp_btype*TSize},{'L_ADDRESS3','cnp_lowv',CntRed_cnp_lowv*100,CntRed_cnp_lowv*TSize},{'L_ADDRESS3','sec_range',CntRed_sec_range*100,CntRed_sec_range*TSize},{'L_ADDRESS3','parent_proxid',CntRed_parent_proxid*100,CntRed_parent_proxid*TSize},{'L_ADDRESS3','sele_proxid',CntRed_sele_proxid*100,CntRed_sele_proxid*TSize},{'L_ADDRESS3','org_proxid',CntRed_org_proxid*100,CntRed_org_proxid*TSize},{'L_ADDRESS3','ultimate_proxid',CntRed_ultimate_proxid*100,CntRed_ultimate_proxid*TSize},{'L_ADDRESS3','sele_flag',CntRed_sele_flag*100,CntRed_sele_flag*TSize},{'L_ADDRESS3','org_flag',CntRed_org_flag*100,CntRed_org_flag*TSize},{'L_ADDRESS3','ult_flag',CntRed_ult_flag*100,CntRed_ult_flag*TSize}],SALT44.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.prim_name <> (TYPEOF(le.prim_name))'' AND Fields.InValid_prim_name((SALT44.StrType)le.prim_name)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND Fields.InValid_prim_range((SALT44.StrType)le.prim_range)=0 AND EXISTS(le.zip_cases);
KeyRec := RECORDOF(Key);
EXPORT RawFetch_server(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',UNSIGNED4 param_efr_bitmap = 0) := 
    STEPPED( LIMIT( Key(
          KEYED((prim_name = param_prim_name))

      AND KEYED((prim_range = param_prim_range))
      AND KEYED((zip IN SET(param_zip,zip)))

      AND KEYED((param_st = (TYPEOF(st))'' OR st = (TYPEOF(st))'') OR (st = param_st))

      AND ((param_cnp_name = (TYPEOF(cnp_name))'' OR cnp_name = (TYPEOF(cnp_name))'') OR (SALT44.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_RoxieAddrCnpNameBonus/*HACK08*/ > Config_BIP.cnp_name_Force * 100))

      AND KEYED(fallback_value >= param_fallback_value)

      AND ( param_efr_bitmap=0 OR (EFR_BMap & param_efr_bitmap)>0 )),Config_BIP.L_ADDRESS3_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);

EXPORT RawFetch(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',UNSIGNED4 param_efr_bitmap = 0) := FUNCTION
// Why not LOOP? - Because I am expecting FIRST one to win 99+ percent of the time - and don't want to impact it
  RawData0 := RawFetch_server(param_prim_name,param_prim_name_len,param_prim_range,param_prim_range_len,param_zip,param_cnp_name,param_st,0,param_efr_bitmap);
  RawData1 := RawFetch_server(param_prim_name,param_prim_name_len,param_prim_range,param_prim_range_len,param_zip,param_cnp_name,param_st,1,param_efr_bitmap);
  RawData2 := RawFetch_server(param_prim_name,param_prim_name_len,param_prim_range,param_prim_range_len,param_zip,param_cnp_name,param_st,2,param_efr_bitmap);
  Returnable(DATASET(RECORDOF(RawData0)) d) := COUNT(NOFOLD(d))<>1 OR EXISTS(NOFOLD(d((TYPEOF(prim_name))prim_name != (TYPEOF(prim_name))'')));
  res := MAP (
    param_fallback_value <= 0 AND Returnable(RawData0) => RawData0,
    param_fallback_value <= 1 AND Returnable(RawData1) => RawData1,
    RawData2);
  RETURN res;
END;

EXPORT ScoredproxidFetch(TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_range_len) param_prim_range_len = (TYPEOF(h.prim_range_len))'',DATASET(Process_Biz_Layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.city_len) param_city_len = (TYPEOF(h.city_len))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.sec_range_len) param_sec_range_len = (TYPEOF(h.sec_range_len))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'',UNSIGNED4 param_efr_bitmap = 0,BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_prim_name,param_prim_name_len,param_prim_range,param_prim_range_len,param_zip,param_cnp_name,param_st,param_fallback_value,param_efr_bitmap);
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 7, 0); // Set bitmap for key failed

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

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1, MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));

  result1 := PROJECT(result0, Process_Biz_Layouts.update_forcefailed(LEFT,param_disableForce));

  result2 := ROLLUP(result1,LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT,param_disableForce));

  RETURN result2;
END;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT44.UIDType Reference;//How to recognize this record in the subsequent

  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  TYPEOF(h.prim_name_len) prim_name_len := (TYPEOF(h.prim_name_len))'';


  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  TYPEOF(h.prim_range_len) prim_range_len := (TYPEOF(h.prim_range_len))'';


  DATASET(BizLinkFull.Process_Biz_Layouts.layout_zip_cases) zip_cases := DATASET([],BizLinkFull.Process_Biz_Layouts.layout_zip_cases);


  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';


  TYPEOF(h.st) st := (TYPEOF(h.st))'';


  TYPEOF(h.city) city := (TYPEOF(h.city))'';
  TYPEOF(h.city_len) city_len := (TYPEOF(h.city_len))'';


  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';


  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';


  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';


  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';


  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  TYPEOF(h.sec_range_len) sec_range_len := (TYPEOF(h.sec_range_len))'';


  TYPEOF(h.parent_proxid) parent_proxid := (TYPEOF(h.parent_proxid))'';


  TYPEOF(h.sele_proxid) sele_proxid := (TYPEOF(h.sele_proxid))'';


  TYPEOF(h.org_proxid) org_proxid := (TYPEOF(h.org_proxid))'';


  TYPEOF(h.ultimate_proxid) ultimate_proxid := (TYPEOF(h.ultimate_proxid))'';


  TYPEOF(h.sele_flag) sele_flag := (TYPEOF(h.sele_flag))'';


  TYPEOF(h.org_flag) org_flag := (TYPEOF(h.org_flag))'';


  TYPEOF(h.ult_flag) ult_flag := (TYPEOF(h.ult_flag))'';

END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 7; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed

    SELF.prim_name_match_code := match_methods(File_BizHead).match_prim_name(le.prim_name,ri.prim_name,le.prim_name_len,ri.prim_name_len,TRUE);

    SELF.prim_nameWeight := (50+MAP (
         SELF.prim_name_match_code = SALT44.MatchCode.ExactMatch =>le.prim_name_weight100,
         -1.000*le.prim_name_weight100))/100;


    SELF.prim_range_match_code := match_methods(File_BizHead).match_prim_range(le.prim_range,ri.prim_range,le.prim_range_len,ri.prim_range_len,TRUE);

    SELF.prim_rangeWeight := (50+MAP (
         SELF.prim_range_match_code = SALT44.MatchCode.ExactMatch =>le.prim_range_weight100,
         -1.000*le.prim_range_weight100))/100;


    SELF.zip_match_code := match_methods(File_BizHead).match_zip_el(le.zip,SET(ri.zip_cases,zip),TRUE);

    SELF.zipWeight := (50+MAP (
         SELF.zip_match_code = SALT44.MatchCode.ExactMatch =>le.zip_weight100 * ri.zip_cases(zip=le.zip)[1].weight/100.0,
         -0.995*le.zip_weight100))/100;
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_Layouts.layout_zip_cases);


    SELF.cnp_name_match_code := MAP(
         le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,FALSE));

    SELF.cnp_nameWeight := (50+MAP (
         SELF.cnp_name_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_name_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_name_weight100,
         SALT44.MatchBagOfWords(le.cnp_name,ri.cnp_name,3177747,1)

         ))/100;


    SELF.st_match_code := MAP(
         le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_st(le.st,ri.st,FALSE));

    SELF.stWeight := (50+MAP (
         SELF.st_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.st_match_code = SALT44.MatchCode.ExactMatch =>le.st_weight100,
         -1.000*le.st_weight100))/100;


    SELF.city_match_code := MAP(
         le.city = (TYPEOF(le.city))'' OR ri.city = (TYPEOF(ri.city))'' => SALT44.MatchCode.OneSideNull,
         le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' OR le.st <> ri.st => SALT44.MatchCode.ContextNoMatch, // Only valid if the context variable is equal

         match_methods(File_BizHead).match_city(le.city,ri.city,le.city_len,ri.city_len,FALSE));


    SELF.cityWeight := (50+MAP (
         SELF.city_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.city_match_code = SALT44.MatchCode.ContextNoMatch => 0,
         SELF.city_match_code = SALT44.MatchCode.ExactMatch =>le.city_weight100,
         SELF.city_match_code = SALT44.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(ri.city),le.city_e2p_weight100,le.city_e2_weight100),
         SELF.city_match_code = SALT44.MatchCode.PhoneticMatch =>le.city_p_weight100,

         -0.947*le.city_weight100))/100;


    SELF.company_sic_code1_match_code := MAP(
         le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,FALSE));

    SELF.company_sic_code1Weight := (50+MAP (
         SELF.company_sic_code1_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.company_sic_code1_match_code = SALT44.MatchCode.ExactMatch =>le.company_sic_code1_weight100,
         -0.727*le.company_sic_code1_weight100))/100;


    SELF.cnp_number_match_code := MAP(
         le.cnp_number = (TYPEOF(le.cnp_number))'' OR ri.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_number(le.cnp_number,ri.cnp_number,FALSE));

    SELF.cnp_numberWeight := (50+MAP (
         SELF.cnp_number_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_number_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_number_weight100,
         -0.996*le.cnp_number_weight100))/100;


    SELF.cnp_btype_match_code := MAP(
         le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,ri.cnp_btype,FALSE));

    SELF.cnp_btypeWeight := (50+MAP (
         SELF.cnp_btype_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_btype_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_btype_weight100,
         -0.958*le.cnp_btype_weight100))/100;


    SELF.cnp_lowv_match_code := MAP(
         le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv,FALSE));

    SELF.cnp_lowvWeight := (50+MAP (
         SELF.cnp_lowv_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.cnp_lowv_match_code = SALT44.MatchCode.ExactMatch =>le.cnp_lowv_weight100,
         -0.962*le.cnp_lowv_weight100))/100;


    SELF.sec_range_match_code := MAP(
         le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sec_range(le.sec_range,ri.sec_range,le.sec_range_len,ri.sec_range_len,FALSE));

    SELF.sec_rangeWeight := (50+MAP (
         SELF.sec_range_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sec_range_match_code = SALT44.MatchCode.ExactMatch =>le.sec_range_weight100,
         SELF.sec_range_match_code = SALT44.MatchCode.EditDistanceMatch =>le.sec_range_e1_weight100,

         -0.888*le.sec_range_weight100))/100;


    SELF.parent_proxid_match_code := MAP(
         le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR ri.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,ri.parent_proxid,FALSE));

    SELF.parent_proxidWeight := (50+MAP (
         SELF.parent_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.parent_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.parent_proxid_weight100,
         -1.000*le.parent_proxid_weight100))/100*0.00;


    SELF.sele_proxid_match_code := MAP(
         le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR ri.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,ri.sele_proxid,FALSE));

    SELF.sele_proxidWeight := (50+MAP (
         SELF.sele_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.sele_proxid_weight100,
         -1.000*le.sele_proxid_weight100))/100*0.00;


    SELF.org_proxid_match_code := MAP(
         le.org_proxid = (TYPEOF(le.org_proxid))'' OR ri.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_proxid(le.org_proxid,ri.org_proxid,FALSE));

    SELF.org_proxidWeight := (50+MAP (
         SELF.org_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.org_proxid_weight100,
         -1.000*le.org_proxid_weight100))/100*0.00;


    SELF.ultimate_proxid_match_code := MAP(
         le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR ri.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,ri.ultimate_proxid,FALSE));

    SELF.ultimate_proxidWeight := (50+MAP (
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ultimate_proxid_match_code = SALT44.MatchCode.ExactMatch =>le.ultimate_proxid_weight100,
         -1.000*le.ultimate_proxid_weight100))/100*0.00;


    SELF.sele_flag_match_code := MAP(
         le.sele_flag = (TYPEOF(le.sele_flag))'' OR ri.sele_flag = (TYPEOF(ri.sele_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_sele_flag(le.sele_flag,ri.sele_flag,FALSE));

    SELF.sele_flagWeight := (50+MAP (
         SELF.sele_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.sele_flag_match_code = SALT44.MatchCode.ExactMatch =>le.sele_flag_weight100,
         -1.000*le.sele_flag_weight100))/100*0.00;


    SELF.org_flag_match_code := MAP(
         le.org_flag = (TYPEOF(le.org_flag))'' OR ri.org_flag = (TYPEOF(ri.org_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_org_flag(le.org_flag,ri.org_flag,FALSE));

    SELF.org_flagWeight := (50+MAP (
         SELF.org_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.org_flag_match_code = SALT44.MatchCode.ExactMatch =>le.org_flag_weight100,
         -1.000*le.org_flag_weight100))/100*0.00;


    SELF.ult_flag_match_code := MAP(
         le.ult_flag = (TYPEOF(le.ult_flag))'' OR ri.ult_flag = (TYPEOF(ri.ult_flag))'' => SALT44.MatchCode.OneSideNull,
         match_methods(File_BizHead).match_ult_flag(le.ult_flag,ri.ult_flag,FALSE));

    SELF.ult_flagWeight := (50+MAP (
         SELF.ult_flag_match_code = SALT44.MatchCode.OneSideNull => 0,
         SELF.ult_flag_match_code = SALT44.MatchCode.ExactMatch =>le.ult_flag_weight100,
         -1.000*le.ult_flag_weight100))/100*0.00;

    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1, MAX(0, SELF.prim_nameWeight) + MAX(0, SELF.prim_rangeWeight) + MAX(0, SELF.zipWeight) + MAX(0, SELF.cnp_nameWeight) + MAX(0, SELF.stWeight) + MAX(0, SELF.cityWeight) + MAX(0, SELF.company_sic_code1Weight) + MAX(0, SELF.cnp_numberWeight) + MAX(0, SELF.cnp_btypeWeight) + MAX(0, SELF.cnp_lowvWeight) + MAX(0, SELF.sec_rangeWeight) + MAX(0, SELF.parent_proxidWeight) + MAX(0, SELF.sele_proxidWeight) + MAX(0, SELF.org_proxidWeight) + MAX(0, SELF.ultimate_proxidWeight) + MAX(0, SELF.sele_flagWeight) + MAX(0, SELF.org_flagWeight) + MAX(0, SELF.ult_flagWeight));

    SELF := le;
  END;
  Recs0 := Recs(prim_name <> (TYPEOF(prim_name))'',prim_range <> (TYPEOF(prim_range))'',EXISTS(zip_cases));
  InputLayout_Batch NormMultiple0(InputLayout_Batch L,INTEGER C) := TRANSFORM
    SELF.zip_cases := L.zip_cases[C];
      SELF := L;
    END;
  Recs1 := NORMALIZE(Recs0,COUNT(LEFT.zip_cases),NormMultiple0(LEFT,COUNTER));

  SALT44.MAC_Dups_Note(Recs1,InputLayout_Batch,Recs2,outdups,Reference,Config_BIP.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs2,Key,((RIGHT.prim_name = LEFT.prim_name))
  AND ((RIGHT.prim_range = LEFT.prim_range))
  AND ((RIGHT.zip = LEFT.zip_cases[1].zip))
  AND ((LEFT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'') OR (SALT44.MatchBagOfWords(RIGHT.cnp_name,LEFT.cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_ThorAddrCnpNameBonus/*HACK08_b*/ > BizLinkFull.Config_BIP.cnp_name_Force * 100))
  AND ((LEFT.st = (TYPEOF(RIGHT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'') OR (RIGHT.st = LEFT.st)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.prim_name = LEFT.prim_name))
      AND ((RIGHT.prim_range = LEFT.prim_range))
      AND ((RIGHT.zip = LEFT.zip_cases[1].zip)),Config_BIP.L_ADDRESS3_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs2,PULL(Key),((RIGHT.prim_name = LEFT.prim_name))
  AND ((RIGHT.prim_range = LEFT.prim_range))
  AND ((RIGHT.zip = LEFT.zip_cases[1].zip))
  AND ((LEFT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'') OR (SALT44.MatchBagOfWords(RIGHT.cnp_name,LEFT.cnp_name,3177747,1)+BizLinkFull.Config_BIP.HACK08_ThorAddrCnpNameBonus/*HACK08_c*/ > BizLinkFull.Config_BIP.cnp_name_Force * 100))
  AND ((LEFT.st = (TYPEOF(RIGHT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'') OR (RIGHT.st = LEFT.st)),Score_Batch(RIGHT,LEFT),
    ATMOST(((RIGHT.prim_name = LEFT.prim_name))
      AND ((RIGHT.prim_range = LEFT.prim_range))
      AND ((RIGHT.zip = LEFT.zip_cases[1].zip)),Config_BIP.L_ADDRESS3_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join

  J2 := IF(AsIndex,J0,J1);
  J3 := PROJECT(J2, Process_Biz_Layouts.update_forcefailed(LEFT,In_disableForce));
  J4 := Process_Biz_Layouts.CombineLinkpathScores(J3,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT44.MAC_Dups_Restore(J4,DD,J5,Reference,TRUE)
  RETURN J5;
END;

// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_prim_name='',Input_prim_range='',Input_zip='',Input_cnp_name='',Input_st='',Input_city='',Input_company_sic_code1='',Input_cnp_number='',Input_cnp_btype='',Input_cnp_lowv='',Input_sec_range='',Input_parent_proxid='',Input_sele_proxid='',Input_org_proxid='',Input_ultimate_proxid='',Input_sele_flag='',Input_org_flag='',Input_ult_flag='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT44,BizLinkFull;
  #IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(trans)
    BizLinkFull.Key_BizHead_L_ADDRESS3.InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;

    SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    SELF.prim_name_len := LENGTH(TRIM((TYPEOF(SELF.prim_name))le.Input_prim_name));


    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
    SELF.prim_range_len := LENGTH(TRIM((TYPEOF(SELF.prim_range))le.Input_prim_range));


    SELF.zip_cases := le.Input_zip;

    #IF ( #TEXT(Input_cnp_name) <> '' )
      SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
    #END

    #IF ( #TEXT(Input_st) <> '' )
      SELF.st := (TYPEOF(SELF.st))le.Input_st;
    #END

    #IF ( #TEXT(Input_city) <> '' )
      SELF.city := (TYPEOF(SELF.city))le.Input_city;
      SELF.city_len := LENGTH(TRIM((TYPEOF(SELF.city))le.Input_city));
    #END

    #IF ( #TEXT(Input_company_sic_code1) <> '' )
      SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))le.Input_company_sic_code1;
    #END

    #IF ( #TEXT(Input_cnp_number) <> '' )
      SELF.cnp_number := (TYPEOF(SELF.cnp_number))le.Input_cnp_number;
    #END

    #IF ( #TEXT(Input_cnp_btype) <> '' )
      SELF.cnp_btype := (TYPEOF(SELF.cnp_btype))le.Input_cnp_btype;
    #END

    #IF ( #TEXT(Input_cnp_lowv) <> '' )
      SELF.cnp_lowv := (TYPEOF(SELF.cnp_lowv))le.Input_cnp_lowv;
    #END

    #IF ( #TEXT(Input_sec_range) <> '' )
      SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
      SELF.sec_range_len := LENGTH(TRIM((TYPEOF(SELF.sec_range))le.Input_sec_range));
    #END

    #IF ( #TEXT(Input_parent_proxid) <> '' )
      SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))le.Input_parent_proxid;
    #END

    #IF ( #TEXT(Input_sele_proxid) <> '' )
      SELF.sele_proxid := (TYPEOF(SELF.sele_proxid))le.Input_sele_proxid;
    #END

    #IF ( #TEXT(Input_org_proxid) <> '' )
      SELF.org_proxid := (TYPEOF(SELF.org_proxid))le.Input_org_proxid;
    #END

    #IF ( #TEXT(Input_ultimate_proxid) <> '' )
      SELF.ultimate_proxid := (TYPEOF(SELF.ultimate_proxid))le.Input_ultimate_proxid;
    #END

    #IF ( #TEXT(Input_sele_flag) <> '' )
      SELF.sele_flag := (TYPEOF(SELF.sele_flag))le.Input_sele_flag;
    #END

    #IF ( #TEXT(Input_org_flag) <> '' )
      SELF.org_flag := (TYPEOF(SELF.org_flag))le.Input_org_flag;
    #END

    #IF ( #TEXT(Input_ult_flag) <> '' )
      SELF.ult_flag := (TYPEOF(SELF.ult_flag))le.Input_ult_flag;
    #END

    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := BizLinkFull.Key_BizHead_L_ADDRESS3.ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;

END;
