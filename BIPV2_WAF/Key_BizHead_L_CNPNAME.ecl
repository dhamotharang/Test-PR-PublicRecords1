EXPORT Key_BizHead_L_CNPNAME := MODULE
 
IMPORT SALT29,ut,std, data_services;
//cnp_name:?:zip:prim_name:p_city_name:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range
 
EXPORT KeyName := data_services.data_location.prefix('bipv2') +'key::BIPV2_WAF::proxid::Refs::L_CNPNAME';
SHARED h := CandidatesForKey;//The input file - distributed by proxid
layout := RECORD // project out required fields
// Compulsory fields
  UNSIGNED4 GSS_hash := 0; // A 'nominal' to allow this record to be treated as a pseudo-inversion
// Optional fields
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1
  h.proxid; // The ID field
  h.zip;
  h.prim_name;
  h.p_city_name;
  h.st;
// Extra credit fields
  h.company_sic_code1;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.prim_range;
  h.sec_range;
  UNSIGNED2 GSS_word_weight := 0; // Weight for just the word in the hash
  //Required in project to allow later processing
  h.cnp_name;
  UNSIGNED8 gss_bloom := SALT29.Fn_Wordbag_To_Bloom(h.cnp_name); // To allow pruning of positives from rawfetch//Scores for various field components
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;
  h.p_city_name_weight100 ; // Contains 100x the specificity
  INTEGER2 p_city_name_e1_Weight100 := SALT29.Min0(h.p_city_name_weight100 + 100*log(h.p_city_name_cnt/h.p_city_name_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;
END;
 
s := Specificities(File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
// Now need to 'blow out' the fixed word-bag fields to create the pseudo-inversion
SALT29.mac_expand_wordbag_key(DataForKey0,GSS_hash,cnp_name,DataForKey1,GSS_word_weight)
DataForKey2 := DEDUP(SORT(DataForKey1,WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Can remove wordbag fields now
 
EXPORT Key := INDEX(DataForKey2,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,cnp_name,zip,prim_name,p_city_name,st,LOCAL); // Not perfect, does not need to be - for statistics
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
EXPORT Shrinkage := DATASET([{'L_CNPNAME','company_sic_code1',CntRed_company_sic_code1*100,CntRed_company_sic_code1*TSize},{'L_CNPNAME','cnp_number',CntRed_cnp_number*100,CntRed_cnp_number*TSize},{'L_CNPNAME','cnp_btype',CntRed_cnp_btype*100,CntRed_cnp_btype*TSize},{'L_CNPNAME','cnp_lowv',CntRed_cnp_lowv*100,CntRed_cnp_lowv*TSize},{'L_CNPNAME','prim_range',CntRed_prim_range*100,CntRed_prim_range*TSize},{'L_CNPNAME','sec_range',CntRed_sec_range*100,CntRed_sec_range*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.cnp_name <> (typeof(le.cnp_name))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.cnp_name) param_cnp_name,SET OF TYPEOF(h.zip) param_zip,TYPEOF(h.prim_name) param_prim_name,TYPEOF(h.p_city_name) param_p_city_name,TYPEOF(h.st) param_st) := 
  FUNCTION
 //Generate service attributes for GSS join
    wds := SALT29.fn_string_to_wordstream(param_cnp_name);
    indexOutputRecord := RECORDOF(Key);
    slimrec := { Key.gss_word_weight, Key.proxid, Key.seleid, Key.orgid, Key.ultid };
    BloomF := SALT29.Fn_Wordbag_To_Bloom(param_cnp_name); // Use for extra index filtering
    doIndexRead(UNSIGNED4 search,UNSIGNED2 spc) := STEPPED(KEY( GSS_hash = search AND (GSS_bloom & BloomF) = BloomF
      AND ( zip IN param_zip OR param_zip = [] OR zip = (TYPEOF(zip))'' )
      AND ( prim_name = (TYPEOF(prim_name))'' OR param_prim_name = (TYPEOF(prim_name))'' OR SALT29.WithinEditN(prim_name,param_prim_name,1, 0)  )
      AND ( p_city_name = (TYPEOF(p_city_name))'' OR param_p_city_name = (TYPEOF(p_city_name))'' OR SALT29.WithinEditN(p_city_name,param_p_city_name,1, 0)  )
      AND ( st = (TYPEOF(st))'' OR param_st = (TYPEOF(st))'' OR st = param_st  )),ultid,orgid,seleid,proxid,PRIORITY(40-spc)); // Filter for each row of index fetch
    SALT29.MAC_collate_wordbag_matches4(wds,slimrec,doIndexRead,ultid,orgid,seleid,proxid,steppedmatches) // Perform N-way join
    res := JOIN( steppedmatches, Key, RIGHT.GSS_Hash = wds[1].hsh AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid,TRANSFORM(indexOutputRecord,SELF.gss_word_weight := LEFT.gss_word_weight,SELF := RIGHT));
    RETURN IF(SUM(wds,spec) > 19,res,IF(SUM(wds,spec) = 0,DATASET([],indexOutputRecord) ,DATASET(ROW([],indexOutputRecord)))); // Ensure at least spc of specificity in gss portion
  END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.cnp_name) param_cnp_name,SET OF TYPEOF(h.zip) param_zip,TYPEOF(h.prim_name) param_prim_name,TYPEOF(h.p_city_name) param_p_city_name,TYPEOF(h.st) param_st,TYPEOF(h.company_sic_code1) param_company_sic_code1,TYPEOF(h.cnp_number) param_cnp_number,TYPEOF(h.cnp_btype) param_cnp_btype,TYPEOF(h.cnp_lowv) param_cnp_lowv,TYPEOF(h.prim_range) param_prim_range,TYPEOF(h.sec_range) param_sec_range) := FUNCTION
  RawData := RawFetch(param_cnp_name,param_zip,param_prim_name,param_p_city_name,param_st);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 1; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 1, 0); // Set bitmap for key failed
    SELF.cnp_name_match_code := match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,TRUE);
    SELF.cnp_nameWeight :=   le.gss_word_weight; //Fixed Wordbag weights accumulated in gss_weight field
  SELF.cnp_name_GSS_Weight := le.gss_word_weight;// MORE - need to scale in independence
  SELF.cnp_name_gss_cases := DATASET([{le.gss_hash}],SALT29.layout_GSS_cases);
    SELF.zip_match_code := MAP(
		le.zip = (TYPEOF(le.zip))'' OR param_zip = []  => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_zip(le.zip,param_zip,FALSE));
    SELF.zipWeight := (50+MAP ( le.zip IN param_zip  => le.zip_weight100,
          le.zip = (TYPEOF(le.zip))'' OR param_zip = [] => 0,
           -1.000*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip}],Process_Biz_layouts.layout_zip_cases);
    SELF.prim_name_match_code := MAP(
		le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = param_prim_name  => le.prim_name_weight100,
           le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => 0,
           SALT29.WithinEditN(le.prim_name,param_prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.p_city_name_match_code := MAP(
		le.p_city_name = (TYPEOF(le.p_city_name))'' OR param_p_city_name = (TYPEOF(param_p_city_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_p_city_name(le.p_city_name,param_p_city_name,FALSE));
    SELF.p_city_nameWeight := (50+MAP ( le.p_city_name = param_p_city_name  => le.p_city_name_weight100,
           le.p_city_name = (TYPEOF(le.p_city_name))'' OR param_p_city_name = (TYPEOF(param_p_city_name))'' => 0,
           SALT29.WithinEditN(le.p_city_name,param_p_city_name,1, 0) => le.p_city_name_e1_weight100,
           -1.000*le.p_city_name_weight100))/100; 
    SELF.st_match_code := MAP(
		le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_st(le.st,param_st,FALSE));
    SELF.stWeight := (50+MAP ( le.st = param_st  => le.st_weight100,
           le.st = (TYPEOF(le.st))'' OR param_st = (TYPEOF(param_st))'' => 0,
           -1.000*le.st_weight100))/100; 
    SELF.company_sic_code1_match_code := MAP(
		le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,FALSE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = param_company_sic_code1  => le.company_sic_code1_weight100,
           le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(param_company_sic_code1))'' => 0,
           -1.000*le.company_sic_code1_weight100))/100; 
    SELF.cnp_number_match_code := MAP(
		le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_number(le.cnp_number,param_cnp_number,FALSE));
    SELF.cnp_numberWeight := (50+MAP ( le.cnp_number = param_cnp_number  => le.cnp_number_weight100,
           le.cnp_number = (TYPEOF(le.cnp_number))'' OR param_cnp_number = (TYPEOF(param_cnp_number))'' => 0,
           -1.000*le.cnp_number_weight100))/100; 
    SELF.cnp_btype_match_code := MAP(
		le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,param_cnp_btype,FALSE));
    SELF.cnp_btypeWeight := (50+MAP ( le.cnp_btype = param_cnp_btype  => le.cnp_btype_weight100,
           le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR param_cnp_btype = (TYPEOF(param_cnp_btype))'' => 0,
           -1.000*le.cnp_btype_weight100))/100; 
    SELF.cnp_lowv_match_code := MAP(
		le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,param_cnp_lowv,FALSE));
    SELF.cnp_lowvWeight := (50+MAP ( le.cnp_lowv = param_cnp_lowv  => le.cnp_lowv_weight100,
           le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR param_cnp_lowv = (TYPEOF(param_cnp_lowv))'' => 0,
           -1.000*le.cnp_lowv_weight100))/100; 
    SELF.prim_range_match_code := MAP(
		le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_range(le.prim_range,param_prim_range,FALSE));
    SELF.prim_rangeWeight := (50+MAP ( le.prim_range = param_prim_range  => le.prim_range_weight100,
           le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(param_prim_range))'' => 0,
           SALT29.WithinEditN(le.prim_range,param_prim_range,1, 0) => le.prim_range_e1_weight100,
           -1.000*le.prim_range_weight100))/100; 
    SELF.sec_range_match_code := MAP(
		le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_sec_range(le.sec_range,param_sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP ( le.sec_range = param_sec_range  => le.sec_range_weight100,
           le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => 0,
           SALT29.WithinEditN(le.sec_range,param_sec_range,1, 0) => le.sec_range_e1_weight100,
           -1.000*le.sec_range_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  SET OF SALT29.StrType zip_cases := [];
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  TYPEOF(h.p_city_name) p_city_name := (TYPEOF(h.p_city_name))'';
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';
  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';
  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 1; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.cnp_name_match_code := match_methods(File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,TRUE);
    SELF.cnp_nameWeight := IF(SALT29.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0)<=Config.cnp_name_force,SKIP,SALT29.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0)/100); 
    SELF.zip_match_code := MAP(
		le.zip = (TYPEOF(le.zip))'' OR ri.zip_cases = []  => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_zip(le.zip,ri.zip_cases,FALSE));
    SELF.zipWeight := (50+MAP ( le.zip IN ri.zip_cases  => le.zip_weight100,
          le.zip = (TYPEOF(le.zip))'' OR ri.zip_cases = [] => 0,
           -1.000*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip}],Process_Biz_layouts.layout_zip_cases);
    SELF.prim_name_match_code := MAP(
		le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_name(le.prim_name,ri.prim_name,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = ri.prim_name  => le.prim_name_weight100,
           le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => 0,
           SALT29.WithinEditN(le.prim_name,ri.prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.p_city_name_match_code := MAP(
		le.p_city_name = (TYPEOF(le.p_city_name))'' OR ri.p_city_name = (TYPEOF(ri.p_city_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_p_city_name(le.p_city_name,ri.p_city_name,FALSE));
    SELF.p_city_nameWeight := (50+MAP ( le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
           le.p_city_name = (TYPEOF(le.p_city_name))'' OR ri.p_city_name = (TYPEOF(ri.p_city_name))'' => 0,
           SALT29.WithinEditN(le.p_city_name,ri.p_city_name,1, 0) => le.p_city_name_e1_weight100,
           -1.000*le.p_city_name_weight100))/100; 
    SELF.st_match_code := MAP(
		le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_st(le.st,ri.st,FALSE));
    SELF.stWeight := (50+MAP ( le.st = ri.st  => le.st_weight100,
           le.st = (TYPEOF(le.st))'' OR ri.st = (TYPEOF(ri.st))'' => 0,
           -1.000*le.st_weight100))/100; 
    SELF.company_sic_code1_match_code := MAP(
		le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,FALSE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
           le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => 0,
           -1.000*le.company_sic_code1_weight100))/100; 
    SELF.cnp_number_match_code := MAP(
		le.cnp_number = (TYPEOF(le.cnp_number))'' OR ri.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_number(le.cnp_number,ri.cnp_number,FALSE));
    SELF.cnp_numberWeight := (50+MAP ( le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
           le.cnp_number = (TYPEOF(le.cnp_number))'' OR ri.cnp_number = (TYPEOF(ri.cnp_number))'' => 0,
           -1.000*le.cnp_number_weight100))/100; 
    SELF.cnp_btype_match_code := MAP(
		le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_btype(le.cnp_btype,ri.cnp_btype,FALSE));
    SELF.cnp_btypeWeight := (50+MAP ( le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
           le.cnp_btype = (TYPEOF(le.cnp_btype))'' OR ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => 0,
           -1.000*le.cnp_btype_weight100))/100; 
    SELF.cnp_lowv_match_code := MAP(
		le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv,FALSE));
    SELF.cnp_lowvWeight := (50+MAP ( le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
           le.cnp_lowv = (TYPEOF(le.cnp_lowv))'' OR ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => 0,
           -1.000*le.cnp_lowv_weight100))/100; 
    SELF.prim_range_match_code := MAP(
		le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(ri.prim_range))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_prim_range(le.prim_range,ri.prim_range,FALSE));
    SELF.prim_rangeWeight := (50+MAP ( le.prim_range = ri.prim_range  => le.prim_range_weight100,
           le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(ri.prim_range))'' => 0,
           SALT29.WithinEditN(le.prim_range,ri.prim_range,1, 0) => le.prim_range_e1_weight100,
           -1.000*le.prim_range_weight100))/100; 
    SELF.sec_range_match_code := MAP(
		le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_sec_range(le.sec_range,ri.sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP ( le.sec_range = ri.sec_range  => le.sec_range_weight100,
           le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => 0,
           SALT29.WithinEditN(le.sec_range,ri.sec_range,1, 0) => le.sec_range_e1_weight100,
           -1.000*le.sec_range_weight100))/100; 
    SELF.Weight :=MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight);
    SELF := le;
  END;
  Recs0 := Recs(cnp_name <> (typeof(cnp_name))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,HASH32(SALT29.fn_bow_bestword(LEFT.cnp_name))=RIGHT.gss_hash AND SALT29.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,31744,0) > Config.cnp_name_Force * 100
     AND ( LEFT.zip_cases[1] = (TYPEOF(LEFT.zip_cases[1]))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip_cases[1] = RIGHT.zip  )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT29.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  )
     AND ( LEFT.p_city_name = (TYPEOF(LEFT.p_city_name))'' OR RIGHT.p_city_name = (TYPEOF(RIGHT.p_city_name))'' OR SALT29.WithinEditN(LEFT.p_city_name,RIGHT.p_city_name,1, 0)  )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(HASH32(SALT29.fn_bow_bestword(LEFT.cnp_name))=RIGHT.gss_hash,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),HASH32(SALT29.fn_bow_bestword(LEFT.cnp_name))=RIGHT.gss_hash AND SALT29.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,31744,0) > Config.cnp_name_Force * 100
     AND ( LEFT.zip_cases[1] = (TYPEOF(LEFT.zip_cases[1]))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip_cases[1] = RIGHT.zip  )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT29.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  )
     AND ( LEFT.p_city_name = (TYPEOF(LEFT.p_city_name))'' OR RIGHT.p_city_name = (TYPEOF(RIGHT.p_city_name))'' OR SALT29.WithinEditN(LEFT.p_city_name,RIGHT.p_city_name,1, 0)  )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(HASH32(SALT29.fn_bow_bestword(LEFT.cnp_name))=RIGHT.gss_hash,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_Biz_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_cnp_name='',Input_zip='',Input_prim_name='',Input_p_city_name='',Input_st='',Input_company_sic_code1='',Input_cnp_number='',Input_cnp_btype='',Input_cnp_lowv='',Input_prim_range='',Input_sec_range='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,BIPV2_WAF;
#IF(#TEXT(Input_cnp_name)<>'')
  #uniquename(trans)
  BIPV2_WAF.Key_BizHead_L_CNPNAME.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
    #IF ( #TEXT(Input_zip) <> '' )
      SELF.zip_cases := le.Input_zip;
    #END
    #IF ( #TEXT(Input_prim_name) <> '' )
      SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    #END
    #IF ( #TEXT(Input_p_city_name) <> '' )
      SELF.p_city_name := (TYPEOF(SELF.p_city_name))le.Input_p_city_name;
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
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := BIPV2_WAF.Key_BizHead_L_CNPNAME.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
