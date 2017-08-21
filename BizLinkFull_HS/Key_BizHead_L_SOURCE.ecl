IMPORT SALT33,ut,std;
EXPORT Key_BizHead_L_SOURCE := MODULE
 
//source_record_id:source:?:cnp_name:prim_name:zip:city:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range:parent_proxid:sele_proxid:org_proxid:ultimate_proxid:sele_flag:org_flag:ult_flag
 
EXPORT KeyName := BizLinkFull_HS.Filename_keys.L_SOURCE; /*HACK07*/
SHARED h := CandidatesForKey;//The input file - distributed by proxid
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
//Scores for various field components
  h.source_record_id_weight100 ; // Contains 100x the specificity
  h.source_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;
  h.zip_weight100 ; // Contains 100x the specificity
  h.city_weight100 ; // Contains 100x the specificity
  INTEGER2 city_p_Weight100 := SALT33.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_p_cnt)/log(2)); // Precompute phonetic specificity
  INTEGER2 city_e2_Weight100 := SALT33.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2_cnt)/log(2)); // Precompute edit-distance specificity
  INTEGER2 city_e2p_Weight100 := SALT33.Min0(h.city_weight100 + 100*log(h.city_cnt/h.city_e2p_cnt)/log(2)); // Precompute phonetic & edit_distance specificity
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
 
s := Specificities(File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((source_record_id NOT IN SET(s.nulls_source_record_id,source_record_id) AND source_record_id <> (TYPEOF(source_record_id))''),(source NOT IN SET(s.nulls_source,source) AND source <> (TYPEOF(source))''),(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,source_record_id,source,cnp_name,prim_name,zip,city,st,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_company_sic_code1 := GROUP( DEDUP( SORT( Grpd, EXCEPT company_sic_code1), EXCEPT company_sic_code1));
  CntRed_company_sic_code1 := (KeyCnt-COUNT(Rem_company_sic_code1))/KeyCnt;
  Rem_cnp_number := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_number), EXCEPT cnp_number));
  CntRed_cnp_number := (KeyCnt-COUNT(Rem_cnp_number))/KeyCnt;
  Rem_cnp_btype := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_btype), EXCEPT cnp_btype));
  CntRed_cnp_btype := (KeyCnt-COUNT(Rem_cnp_btype))/KeyCnt;
  Rem_cnp_lowv := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_lowv), EXCEPT cnp_lowv));
  CntRed_cnp_lowv := (KeyCnt-COUNT(Rem_cnp_lowv))/KeyCnt;
  Rem_prim_range := GROUP( DEDUP( SORT( Grpd, EXCEPT prim_range), EXCEPT prim_range));
  CntRed_prim_range := (KeyCnt-COUNT(Rem_prim_range))/KeyCnt;
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
EXPORT Shrinkage := DATASET([{'L_SOURCE','company_sic_code1',CntRed_company_sic_code1*100,CntRed_company_sic_code1*TSize},{'L_SOURCE','cnp_number',CntRed_cnp_number*100,CntRed_cnp_number*TSize},{'L_SOURCE','cnp_btype',CntRed_cnp_btype*100,CntRed_cnp_btype*TSize},{'L_SOURCE','cnp_lowv',CntRed_cnp_lowv*100,CntRed_cnp_lowv*TSize},{'L_SOURCE','prim_range',CntRed_prim_range*100,CntRed_prim_range*TSize},{'L_SOURCE','sec_range',CntRed_sec_range*100,CntRed_sec_range*TSize},{'L_SOURCE','parent_proxid',CntRed_parent_proxid*100,CntRed_parent_proxid*TSize},{'L_SOURCE','sele_proxid',CntRed_sele_proxid*100,CntRed_sele_proxid*TSize},{'L_SOURCE','org_proxid',CntRed_org_proxid*100,CntRed_org_proxid*TSize},{'L_SOURCE','ultimate_proxid',CntRed_ultimate_proxid*100,CntRed_ultimate_proxid*TSize},{'L_SOURCE','sele_flag',CntRed_sele_flag*100,CntRed_sele_flag*TSize},{'L_SOURCE','org_flag',CntRed_org_flag*100,CntRed_org_flag*TSize},{'L_SOURCE','ult_flag',CntRed_ult_flag*100,CntRed_ult_flag*TSize}],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.source_record_id <> (typeof(le.source_record_id))'' AND le.source <> (typeof(le.source))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch_server(TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( source_record_id = param_source_record_id AND param_source_record_id <> (TYPEOF(source_record_id))''))
      AND KEYED(( source = param_source AND param_source <> (TYPEOF(source))''))
      AND ( SALT33.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100 OR cnp_name = (TYPEOF(cnp_name))'' OR param_cnp_name = (TYPEOF(cnp_name))'' )
      AND ( prim_name = (TYPEOF(prim_name))'' OR param_prim_name = (TYPEOF(prim_name))'' OR SALT33.WithinEditN(prim_name,param_prim_name,1, 0) )
      AND KEYED(( zip IN SET(param_zip,zip) OR ~EXISTS(param_zip) OR zip = (TYPEOF(zip))''))
      AND ( city = (TYPEOF(city))'' OR param_city = (TYPEOF(city))'' OR metaphonelib.DMetaPhone1(city)=metaphonelib.DMetaPhone1(param_city) OR SALT33.WithinEditN(city,param_city,2, 0) )
      AND KEYED(( st = (TYPEOF(st))'' OR param_st = (TYPEOF(st))'' OR st = param_st ))
      AND KEYED(fallback_value >= param_fallback_value)),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
 
EXPORT RawFetch(TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
// Why not LOOP? - Because I am expecting FIRST one to win 990f the time - and don't want to impact it
  RawData0 := RawFetch_server(param_source_record_id,param_source,param_cnp_name,param_prim_name,param_zip,param_city,param_st,0);
  RawData1 := RawFetch_server(param_source_record_id,param_source,param_cnp_name,param_prim_name,param_zip,param_city,param_st,1);
  RawData2 := RawFetch_server(param_source_record_id,param_source,param_cnp_name,param_prim_name,param_zip,param_city,param_st,2);
  Returnable(DATASET(RECORDOF(RawData0)) d) := COUNT(NOFOLD(d))<>1 OR EXISTS(NOFOLD(d((SALT33.StrType)source_record_id != '')));
  res := MAP (
      param_fallback_value <= 0 AND Returnable(RawData0) => RawData0,
      param_fallback_value <= 1 AND Returnable(RawData1) => RawData1,
      RawData2);
  RETURN res;
END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.source_record_id) param_source_record_id = (TYPEOF(h.source_record_id))'',TYPEOF(h.source) param_source = (TYPEOF(h.source))'',TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.city) param_city = (TYPEOF(h.city))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',TYPEOF(h.cnp_number) param_cnp_number = (TYPEOF(h.cnp_number))'',TYPEOF(h.cnp_btype) param_cnp_btype = (TYPEOF(h.cnp_btype))'',TYPEOF(h.cnp_lowv) param_cnp_lowv = (TYPEOF(h.cnp_lowv))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.parent_proxid) param_parent_proxid = (TYPEOF(h.parent_proxid))'',TYPEOF(h.sele_proxid) param_sele_proxid = (TYPEOF(h.sele_proxid))'',TYPEOF(h.org_proxid) param_org_proxid = (TYPEOF(h.org_proxid))'',TYPEOF(h.ultimate_proxid) param_ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',TYPEOF(h.sele_flag) param_sele_flag = (TYPEOF(h.sele_flag))'',TYPEOF(h.org_flag) param_org_flag = (TYPEOF(h.org_flag))'',TYPEOF(h.ult_flag) param_ult_flag = (TYPEOF(h.ult_flag))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
  RawData := RawFetch(param_source_record_id,param_source,param_cnp_name,param_prim_name,param_zip,param_city,param_st,param_fallback_value);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 15; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 15, 0); // Set bitmap for key failed
    SELF.source_record_id_match_code := MAP(le.source_record_id = (TYPEOF(le.source_record_id))'' OR le.source_record_id = (TYPEOF(le.source_record_id))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_source_record_id(le.source_record_id,param_source_record_id,TRUE));
    SELF.source_record_idWeight := (50+MAP ( le.source_record_id = param_source_record_id  => le.source_record_id_weight100,
          le.source_record_id = (TYPEOF(le.source_record_id))'' OR param_source_record_id = (TYPEOF(le.source_record_id))'' => 0,
          -0.244*le.source_record_id_weight100))/100; 
    SELF.source_match_code := MAP(le.source = (TYPEOF(le.source))'' OR le.source = (TYPEOF(le.source))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_source(le.source,param_source,TRUE));
    SELF.sourceWeight := (50+MAP ( le.source = param_source  => le.source_weight100,
          le.source = (TYPEOF(le.source))'' OR param_source = (TYPEOF(le.source))'' => 0,
          -0.486*le.source_weight100))/100; 
    SELF.cnp_name_match_code := MAP(le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,0,0,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => 0,
           le.cnp_name = param_cnp_name  => le.cnp_name_weight100,
           SALT33.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)))/100; 
    SELF.prim_name_match_code := MAP(le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,0,0,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => 0,
           le.prim_name = param_prim_name  => le.prim_name_weight100,
           SALT33.WithinEditN(le.prim_name,param_prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.zip_match_code := MAP(le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_zip(le.zip,param_zip,FALSE));
    SELF.zipWeight := (50+MAP ( EXISTS(param_zip(le.zip=zip)) => /*HACK16  le.zip_weight100 */ 1100 * param_zip(zip=le.zip)[1].weight/100.0,
          le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => 0,
          -0.995*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_layouts.layout_zip_cases);
    SELF.city_match_code := MAP(le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_city(le.city,param_city,0,0,FALSE));
    SELF.cityWeight := (50+MAP ( le.city = (TYPEOF(le.city))'' OR param_city = (TYPEOF(param_city))'' => 0,
           le.city = param_city  => le.city_weight100,
           SALT33.WithinEditN(le.city,param_city,2, 0) => IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city),le.city_e2p_weight100,le.city_e2_weight100),
           metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(param_city)=>le.city_p_weight100,
           -0.947*le.city_weight100))/100; 
    SELF.st_match_code := MAP(le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_st(le.st,param_st,FALSE));
    SELF.stWeight := (50+MAP ( le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => 0,
           le.st = param_st  => le.st_weight100,
           -1.000*le.st_weight100))/100; 
    SELF.company_sic_code1_match_code := MAP(le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => 0,
           le.company_sic_code1 = param_company_sic_code1  => le.company_sic_code1_weight100,
           -0.727*le.company_sic_code1_weight100))/100; 
    SELF.cnp_number_match_code := MAP(le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));
    SELF.cnp_numberWeight := (50+MAP ( le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => 0,
           le.cnp_number = param_cnp_number  => le.cnp_number_weight100,
           -0.996*le.cnp_number_weight100))/100; 
    SELF.cnp_btype_match_code := MAP(le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));
    SELF.cnp_btypeWeight := (50+MAP ( le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => 0,
           le.cnp_btype = param_cnp_btype  => le.cnp_btype_weight100,
           -0.958*le.cnp_btype_weight100))/100; 
    SELF.cnp_lowv_match_code := MAP(le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));
    SELF.cnp_lowvWeight := (50+MAP ( le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => 0,
           le.cnp_lowv = param_cnp_lowv  => le.cnp_lowv_weight100,
           -0.962*le.cnp_lowv_weight100))/100; 
    SELF.prim_range_match_code := MAP(le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,0,0,FALSE));
    SELF.prim_rangeWeight := (50+MAP ( le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => 0,
           le.prim_range = param_prim_range  => le.prim_range_weight100,
           SALT33.WithinEditN(le.prim_range,param_prim_range,1, 0) => le.prim_range_e1_weight100,
           -1.000*le.prim_range_weight100))/100; 
    SELF.sec_range_match_code := MAP(le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,0,0,FALSE));
    SELF.sec_rangeWeight := (50+MAP ( le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => 0,
           le.sec_range = param_sec_range  => le.sec_range_weight100,
           SALT33.WithinEditN(le.sec_range,param_sec_range,1, 0) => le.sec_range_e1_weight100,
           -0.888*le.sec_range_weight100))/100; 
    SELF.parent_proxid_match_code := MAP(le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,param_parent_proxid,FALSE));
    SELF.parent_proxidWeight := (50+MAP ( le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR param_parent_proxid = (TYPEOF(param_parent_proxid))'' => 0,
           le.parent_proxid = param_parent_proxid  => le.parent_proxid_weight100,
           -1.000*le.parent_proxid_weight100))/100*0.00; 
    SELF.sele_proxid_match_code := MAP(le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,param_sele_proxid,FALSE));
    SELF.sele_proxidWeight := (50+MAP ( le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR param_sele_proxid = (TYPEOF(param_sele_proxid))'' => 0,
           le.sele_proxid = param_sele_proxid  => le.sele_proxid_weight100,
           -1.000*le.sele_proxid_weight100))/100*0.00; 
    SELF.org_proxid_match_code := MAP(le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_org_proxid(le.org_proxid,param_org_proxid,FALSE));
    SELF.org_proxidWeight := (50+MAP ( le.org_proxid = (TYPEOF(le.org_proxid))'' OR param_org_proxid = (TYPEOF(param_org_proxid))'' => 0,
           le.org_proxid = param_org_proxid  => le.org_proxid_weight100,
           -1.000*le.org_proxid_weight100))/100*0.00; 
    SELF.ultimate_proxid_match_code := MAP(le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,param_ultimate_proxid,FALSE));
    SELF.ultimate_proxidWeight := (50+MAP ( le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR param_ultimate_proxid = (TYPEOF(param_ultimate_proxid))'' => 0,
           le.ultimate_proxid = param_ultimate_proxid  => le.ultimate_proxid_weight100,
           -1.000*le.ultimate_proxid_weight100))/100*0.00; 
    SELF.sele_flag_match_code := MAP(le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sele_flag(le.sele_flag,param_sele_flag,FALSE));
    SELF.sele_flagWeight := (50+MAP ( le.sele_flag = (TYPEOF(le.sele_flag))'' OR param_sele_flag = (TYPEOF(param_sele_flag))'' => 0,
           le.sele_flag = param_sele_flag  => le.sele_flag_weight100,
           -1.000*le.sele_flag_weight100))/100*0.00; 
    SELF.org_flag_match_code := MAP(le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_org_flag(le.org_flag,param_org_flag,FALSE));
    SELF.org_flagWeight := (50+MAP ( le.org_flag = (TYPEOF(le.org_flag))'' OR param_org_flag = (TYPEOF(param_org_flag))'' => 0,
           le.org_flag = param_org_flag  => le.org_flag_weight100,
           -1.000*le.org_flag_weight100))/100*0.00; 
    SELF.ult_flag_match_code := MAP(le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_ult_flag(le.ult_flag,param_ult_flag,FALSE));
    SELF.ult_flagWeight := (50+MAP ( le.ult_flag = (TYPEOF(le.ult_flag))'' OR param_ult_flag = (TYPEOF(param_ult_flag))'' => 0,
           le.ult_flag = param_ult_flag  => le.ult_flag_weight100,
           -1.000*le.ult_flag_weight100))/100*0.00; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.cityWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.sele_proxidWeight) + MAX(0,SELF.org_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.sele_flagWeight) + MAX(0,SELF.org_flagWeight) + MAX(0,SELF.ult_flagWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(PROJECT(NOFOLD(RawData),Score(LEFT)),Process_Biz_Layouts.update_forcefailed(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.source_record_id) source_record_id := (TYPEOF(h.source_record_id))'';
  TYPEOF(h.source) source := (TYPEOF(h.source))'';
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  DATASET(BizLinkFull_HS.process_Biz_layouts.layout_zip_cases) zip_cases := DATASET([],BizLinkFull_HS.process_Biz_layouts.layout_zip_cases);
  TYPEOF(h.city) city := (TYPEOF(h.city))'';
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';
  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';
  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  TYPEOF(h.parent_proxid) parent_proxid := (TYPEOF(h.parent_proxid))'';
  TYPEOF(h.sele_proxid) sele_proxid := (TYPEOF(h.sele_proxid))'';
  TYPEOF(h.org_proxid) org_proxid := (TYPEOF(h.org_proxid))'';
  TYPEOF(h.ultimate_proxid) ultimate_proxid := (TYPEOF(h.ultimate_proxid))'';
  TYPEOF(h.sele_flag) sele_flag := (TYPEOF(h.sele_flag))'';
  TYPEOF(h.org_flag) org_flag := (TYPEOF(h.org_flag))'';
  TYPEOF(h.ult_flag) ult_flag := (TYPEOF(h.ult_flag))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 15; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.source_record_id_match_code := MAP(le.source_record_id = (TYPEOF(le.source_record_id))'' OR le.source_record_id = (TYPEOF(le.source_record_id))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_source_record_id(le.source_record_id,ri.source_record_id,TRUE));
    SELF.source_record_idWeight := (50+MAP ( le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
          le.source_record_id = (TYPEOF(le.source_record_id))'' OR ri.source_record_id = (TYPEOF(le.source_record_id))'' => 0,
          -0.244*le.source_record_id_weight100))/100; 
    SELF.source_match_code := MAP(le.source = (TYPEOF(le.source))'' OR le.source = (TYPEOF(le.source))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_source(le.source,ri.source,TRUE));
    SELF.sourceWeight := (50+MAP ( le.source = ri.source  => le.source_weight100,
          le.source = (TYPEOF(le.source))'' OR ri.source = (TYPEOF(le.source))'' => 0,
          -0.486*le.source_weight100))/100; 
    SELF.cnp_name_match_code := MAP(le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,0,0,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => 0,
           le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
           SALT33.MatchBagOfWords(le.cnp_name,ri.cnp_name,3177747,1)))/100; 
    SELF.prim_name_match_code := MAP(le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_name(le.prim_name,ri.prim_name,0,0,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => 0,
           le.prim_name = ri.prim_name  => le.prim_name_weight100,
           SALT33.WithinEditN(le.prim_name,ri.prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.zip_match_code := MAP(le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(ri.zip_cases) => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_zip(le.zip,ri.zip_cases,FALSE));
    SELF.zipWeight := (50+MAP ( EXISTS(ri.zip_cases(le.zip=zip)) => le.zip_weight100 * ri.zip_cases(zip=le.zip)[1].weight/100.0,
          le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(ri.zip_cases) => 0,
          -0.995*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_layouts.layout_zip_cases);
    SELF.city_match_code := MAP(le.city = (TYPEOF(le.city))'' OR ri.city = (TYPEOF(ri.city))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_city(le.city,ri.city,0,0,FALSE));
    SELF.cityWeight := (50+MAP ( le.city = (TYPEOF(le.city))'' OR ri.city = (TYPEOF(ri.city))'' => 0,
           le.city = ri.city  => le.city_weight100,
           SALT33.WithinEditN(le.city,ri.city,2, 0) => IF( metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(ri.city),le.city_e2p_weight100,le.city_e2_weight100),
           metaphonelib.DMetaPhone1(le.city)=metaphonelib.DMetaPhone1(ri.city)=>le.city_p_weight100,
           -0.947*le.city_weight100))/100; 
    SELF.st_match_code := MAP(le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_st(le.st,ri.st,FALSE));
    SELF.stWeight := (50+MAP ( le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' => 0,
           le.st = ri.st  => le.st_weight100,
           -1.000*le.st_weight100))/100; 
    SELF.company_sic_code1_match_code := MAP(le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,FALSE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => 0,
           le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
           -0.727*le.company_sic_code1_weight100))/100; 
    SELF.cnp_number_match_code := MAP(le.cnp_number = (TYPEOF(le.cnp_number))'' OR ri.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_number(le.cnp_number,ri.cnp_number,FALSE));
    SELF.cnp_numberWeight := (50+MAP ( le.cnp_number = (TYPEOF(le.cnp_number))'' OR ri.cnp_number = (TYPEOF(ri.cnp_number))'' => 0,
           le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
           -0.996*le.cnp_number_weight100))/100; 
    SELF.cnp_btype_match_code := MAP(le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,ri.cnp_btype,FALSE));
    SELF.cnp_btypeWeight := (50+MAP ( le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => 0,
           le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
           -0.958*le.cnp_btype_weight100))/100; 
    SELF.cnp_lowv_match_code := MAP(le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv,FALSE));
    SELF.cnp_lowvWeight := (50+MAP ( le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => 0,
           le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
           -0.962*le.cnp_lowv_weight100))/100; 
    SELF.prim_range_match_code := MAP(le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(ri.prim_range))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_range(le.prim_range,ri.prim_range,0,0,FALSE));
    SELF.prim_rangeWeight := (50+MAP ( le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(ri.prim_range))'' => 0,
           le.prim_range = ri.prim_range  => le.prim_range_weight100,
           SALT33.WithinEditN(le.prim_range,ri.prim_range,1, 0) => le.prim_range_e1_weight100,
           -1.000*le.prim_range_weight100))/100; 
    SELF.sec_range_match_code := MAP(le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sec_range(le.sec_range,ri.sec_range,0,0,FALSE));
    SELF.sec_rangeWeight := (50+MAP ( le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => 0,
           le.sec_range = ri.sec_range  => le.sec_range_weight100,
           SALT33.WithinEditN(le.sec_range,ri.sec_range,1, 0) => le.sec_range_e1_weight100,
           -0.888*le.sec_range_weight100))/100; 
    SELF.parent_proxid_match_code := MAP(le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR ri.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_parent_proxid(le.parent_proxid,ri.parent_proxid,FALSE));
    SELF.parent_proxidWeight := (50+MAP ( le.parent_proxid = (TYPEOF(le.parent_proxid))'' OR ri.parent_proxid = (TYPEOF(ri.parent_proxid))'' => 0,
           le.parent_proxid = ri.parent_proxid  => le.parent_proxid_weight100,
           -1.000*le.parent_proxid_weight100))/100*0.00; 
    SELF.sele_proxid_match_code := MAP(le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR ri.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sele_proxid(le.sele_proxid,ri.sele_proxid,FALSE));
    SELF.sele_proxidWeight := (50+MAP ( le.sele_proxid = (TYPEOF(le.sele_proxid))'' OR ri.sele_proxid = (TYPEOF(ri.sele_proxid))'' => 0,
           le.sele_proxid = ri.sele_proxid  => le.sele_proxid_weight100,
           -1.000*le.sele_proxid_weight100))/100*0.00; 
    SELF.org_proxid_match_code := MAP(le.org_proxid = (TYPEOF(le.org_proxid))'' OR ri.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_org_proxid(le.org_proxid,ri.org_proxid,FALSE));
    SELF.org_proxidWeight := (50+MAP ( le.org_proxid = (TYPEOF(le.org_proxid))'' OR ri.org_proxid = (TYPEOF(ri.org_proxid))'' => 0,
           le.org_proxid = ri.org_proxid  => le.org_proxid_weight100,
           -1.000*le.org_proxid_weight100))/100*0.00; 
    SELF.ultimate_proxid_match_code := MAP(le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR ri.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_ultimate_proxid(le.ultimate_proxid,ri.ultimate_proxid,FALSE));
    SELF.ultimate_proxidWeight := (50+MAP ( le.ultimate_proxid = (TYPEOF(le.ultimate_proxid))'' OR ri.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => 0,
           le.ultimate_proxid = ri.ultimate_proxid  => le.ultimate_proxid_weight100,
           -1.000*le.ultimate_proxid_weight100))/100*0.00; 
    SELF.sele_flag_match_code := MAP(le.sele_flag = (TYPEOF(le.sele_flag))'' OR ri.sele_flag = (TYPEOF(ri.sele_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_sele_flag(le.sele_flag,ri.sele_flag,FALSE));
    SELF.sele_flagWeight := (50+MAP ( le.sele_flag = (TYPEOF(le.sele_flag))'' OR ri.sele_flag = (TYPEOF(ri.sele_flag))'' => 0,
           le.sele_flag = ri.sele_flag  => le.sele_flag_weight100,
           -1.000*le.sele_flag_weight100))/100*0.00; 
    SELF.org_flag_match_code := MAP(le.org_flag = (TYPEOF(le.org_flag))'' OR ri.org_flag = (TYPEOF(ri.org_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_org_flag(le.org_flag,ri.org_flag,FALSE));
    SELF.org_flagWeight := (50+MAP ( le.org_flag = (TYPEOF(le.org_flag))'' OR ri.org_flag = (TYPEOF(ri.org_flag))'' => 0,
           le.org_flag = ri.org_flag  => le.org_flag_weight100,
           -1.000*le.org_flag_weight100))/100*0.00; 
    SELF.ult_flag_match_code := MAP(le.ult_flag = (TYPEOF(le.ult_flag))'' OR ri.ult_flag = (TYPEOF(ri.ult_flag))'' => SALT33.MatchCode.OneSideNull,match_methods(File_BizHead).match_ult_flag(le.ult_flag,ri.ult_flag,FALSE));
    SELF.ult_flagWeight := (50+MAP ( le.ult_flag = (TYPEOF(le.ult_flag))'' OR ri.ult_flag = (TYPEOF(ri.ult_flag))'' => 0,
           le.ult_flag = ri.ult_flag  => le.ult_flag_weight100,
           -1.000*le.ult_flag_weight100))/100*0.00; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.cityWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.sele_proxidWeight) + MAX(0,SELF.org_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.sele_flagWeight) + MAX(0,SELF.org_flagWeight) + MAX(0,SELF.ult_flagWeight));
    SELF := le;
  END;
  Recs0 := Recs(source_record_id <> (typeof(source_record_id))'',source <> (typeof(source))'');
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,BizLinkFull_HS.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.source_record_id = RIGHT.source_record_id
     AND LEFT.source = RIGHT.source
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT33.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100 )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT33.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  )
     AND ( LEFT.zip_cases[1].zip = (TYPEOF(LEFT.zip_cases[1].zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip_cases[1].zip = RIGHT.zip  )
     AND ( LEFT.city = (TYPEOF(LEFT.city))'' OR RIGHT.city = (TYPEOF(RIGHT.city))'' OR metaphonelib.DMetaPhone1(LEFT.city)=metaphonelib.DMetaPhone1(RIGHT.city) OR SALT33.WithinEditN(LEFT.city,RIGHT.city,2, 0)  )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.source_record_id = RIGHT.source_record_id
     AND LEFT.source = RIGHT.source,/*HACK01*/2000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.source_record_id = RIGHT.source_record_id
     AND LEFT.source = RIGHT.source
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT33.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,3177747,1) > Config_BIP.cnp_name_Force * 100 )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT33.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  )
     AND ( LEFT.zip_cases[1].zip = (TYPEOF(LEFT.zip_cases[1].zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip_cases[1].zip = RIGHT.zip  )
     AND ( LEFT.city = (TYPEOF(LEFT.city))'' OR RIGHT.city = (TYPEOF(RIGHT.city))'' OR metaphonelib.DMetaPhone1(LEFT.city)=metaphonelib.DMetaPhone1(RIGHT.city) OR SALT33.WithinEditN(LEFT.city,RIGHT.city,2, 0)  )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.source_record_id = RIGHT.source_record_id
     AND LEFT.source = RIGHT.source,/*HACK01*/2000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := PROJECT(IF(AsIndex,J0,J1),Process_Biz_Layouts.update_forcefailed(LEFT));
  J3 := Process_Biz_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_source_record_id='',Input_source='',Input_cnp_name='',Input_prim_name='',Input_zip='',Input_city='',Input_st='',Input_company_sic_code1='',Input_cnp_number='',Input_cnp_btype='',Input_cnp_lowv='',Input_prim_range='',Input_sec_range='',Input_parent_proxid='',Input_sele_proxid='',Input_org_proxid='',Input_ultimate_proxid='',Input_sele_flag='',Input_org_flag='',Input_ult_flag='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,BizLinkFull_HS;
#IF(#TEXT(Input_source_record_id)<>'' AND #TEXT(Input_source)<>'')
  #uniquename(trans)
  BizLinkFull_HS.Key_BizHead_L_SOURCE.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.source_record_id := (TYPEOF(SELF.source_record_id))le.Input_source_record_id;
    SELF.source := (TYPEOF(SELF.source))le.Input_source;
    #IF ( #TEXT(Input_cnp_name) <> '' )
      SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
    #END
    #IF ( #TEXT(Input_prim_name) <> '' )
      SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    #END
    #IF ( #TEXT(Input_zip) <> '' )
      SELF.zip_cases := le.Input_zip;
    #END
    #IF ( #TEXT(Input_city) <> '' )
      SELF.city := (TYPEOF(SELF.city))le.Input_city;
    #END
    #IF ( #TEXT(Input_st) <> '' )
      SELF.st := (TYPEOF(SELF.st))le.Input_st;
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
    #IF ( #TEXT(Input_prim_range) <> '' )
      SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
    #END
    #IF ( #TEXT(Input_sec_range) <> '' )
      SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
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
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := BizLinkFull_HS.Key_BizHead_L_SOURCE.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],BizLinkFull_HS.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
