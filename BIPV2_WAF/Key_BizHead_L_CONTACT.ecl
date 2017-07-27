EXPORT Key_BizHead_L_CONTACT := MODULE
 
IMPORT SALT29,ut,std;
//fname:lname:?:mname:cnp_name:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:prim_range:sec_range
 
EXPORT KeyName := '~'+'key::BIPV2_WAF::proxid::Refs::L_CONTACT';
SHARED h := CandidatesForKey;//The input file - distributed by proxid
layout := RECORD // project out required fields
// Compulsory fields
  h.fname;
  h.lname;
// Optional fields
  h.st;
  h.ultid; // Parent #3
  h.orgid; // Parent #2
  h.seleid; // Parent #1
  h.proxid; // The ID field
  h.mname;
  h.cnp_name;
// Extra credit fields
  h.company_sic_code1;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.zip;
  h.prim_name;
  h.p_city_name;
  h.prim_range;
  h.sec_range;
//Scores for various field components
  h.fname_weight100 ; // Contains 100x the specificity
  h.fname_e1_Weight100;
  h.fname_PreferredName_Weight100;
  h.lname_weight100 ; // Contains 100x the specificity
  h.lname_e2_Weight100;
  h.mname_weight100 ; // Contains 100x the specificity
  h.mname_e2_Weight100;
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.st_weight100 ; // Contains 100x the specificity
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.cnp_number_weight100 ; // Contains 100x the specificity
  h.cnp_btype_weight100 ; // Contains 100x the specificity
  h.cnp_lowv_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;
  h.p_city_name_weight100 ; // Contains 100x the specificity
  INTEGER2 p_city_name_e1_Weight100 := SALT29.Min0(h.p_city_name_weight100 + 100*log(h.p_city_name_cnt/h.p_city_name_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_range_e1_Weight100;
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.sec_range_e1_Weight100;
  INTEGER2 mname_initial_weight100 := 0; // Weight if only first character matches
END;
 
s := Specificities(File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h(fname NOT IN SET(s.nulls_fname,fname),lname NOT IN SET(s.nulls_lname,lname)),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
layout note_init2(layout le,Specificities(File_BizHead).mname_values_persisted ri) := TRANSFORM
  SELF.mname_initial_weight100 := ri.field_specificity * 100;
  SELF := le;
END;
DataForKey1 := JOIN(DataForKey0,Specificities(File_BizHead).mname_values_persisted(LENGTH(TRIM(mname))=1),LEFT.mname[1]=RIGHT.mname[1],note_init2(LEFT,RIGHT),LOOKUP,LEFT OUTER); // Append specificities for initials of mname
 
EXPORT Key := INDEX(DataForKey1,,KeyName);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,fname,lname,mname,cnp_name,st,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_company_sic_code1 := GROUP( DEDUP( SORT( Grpd, EXCEPT company_sic_code1), EXCEPT company_sic_code1));
  CntRed_company_sic_code1 := (KeyCnt-COUNT(Rem_company_sic_code1))/KeyCnt;
  Rem_cnp_number := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_number), EXCEPT cnp_number));
  CntRed_cnp_number := (KeyCnt-COUNT(Rem_cnp_number))/KeyCnt;
  Rem_cnp_btype := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_btype), EXCEPT cnp_btype));
  CntRed_cnp_btype := (KeyCnt-COUNT(Rem_cnp_btype))/KeyCnt;
  Rem_cnp_lowv := GROUP( DEDUP( SORT( Grpd, EXCEPT cnp_lowv), EXCEPT cnp_lowv));
  CntRed_cnp_lowv := (KeyCnt-COUNT(Rem_cnp_lowv))/KeyCnt;
  Rem_zip := GROUP( DEDUP( SORT( Grpd, EXCEPT zip), EXCEPT zip));
  CntRed_zip := (KeyCnt-COUNT(Rem_zip))/KeyCnt;
  Rem_prim_name := GROUP( DEDUP( SORT( Grpd, EXCEPT prim_name), EXCEPT prim_name));
  CntRed_prim_name := (KeyCnt-COUNT(Rem_prim_name))/KeyCnt;
  Rem_p_city_name := GROUP( DEDUP( SORT( Grpd, EXCEPT p_city_name), EXCEPT p_city_name));
  CntRed_p_city_name := (KeyCnt-COUNT(Rem_p_city_name))/KeyCnt;
  Rem_prim_range := GROUP( DEDUP( SORT( Grpd, EXCEPT prim_range), EXCEPT prim_range));
  CntRed_prim_range := (KeyCnt-COUNT(Rem_prim_range))/KeyCnt;
  Rem_sec_range := GROUP( DEDUP( SORT( Grpd, EXCEPT sec_range), EXCEPT sec_range));
  CntRed_sec_range := (KeyCnt-COUNT(Rem_sec_range))/KeyCnt;
EXPORT Shrinkage := DATASET([{'L_CONTACT','company_sic_code1',CntRed_company_sic_code1*100,CntRed_company_sic_code1*TSize},{'L_CONTACT','cnp_number',CntRed_cnp_number*100,CntRed_cnp_number*TSize},{'L_CONTACT','cnp_btype',CntRed_cnp_btype*100,CntRed_cnp_btype*TSize},{'L_CONTACT','cnp_lowv',CntRed_cnp_lowv*100,CntRed_cnp_lowv*TSize},{'L_CONTACT','zip',CntRed_zip*100,CntRed_zip*TSize},{'L_CONTACT','prim_name',CntRed_prim_name*100,CntRed_prim_name*TSize},{'L_CONTACT','p_city_name',CntRed_p_city_name*100,CntRed_p_city_name*TSize},{'L_CONTACT','prim_range',CntRed_prim_range*100,CntRed_prim_range*TSize},{'L_CONTACT','sec_range',CntRed_sec_range*100,CntRed_sec_range*TSize}],SALT29.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.fname <> (typeof(le.fname))'' AND le.lname <> (typeof(le.lname))'';
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.fname) param_fname,TYPEOF(h.lname) param_lname,TYPEOF(h.mname) param_mname,TYPEOF(h.cnp_name) param_cnp_name,TYPEOF(h.st) param_st) := 
    STEPPED( LIMIT( Key(
          ( fname = param_fname AND param_fname <> (TYPEOF(fname))'' )
      AND ( lname = param_lname AND param_lname <> (TYPEOF(lname))'' )
      AND ( mname[1..LENGTH(TRIM(param_mname))] = param_mname OR param_mname[1..LENGTH(TRIM(mname))] = mname OR SALT29.WithinEditN(mname,param_mname,2, 0)  )
      AND ( SALT29.MatchBagOfWords(cnp_name,param_cnp_name,31744,0) > Config.cnp_name_Force * 100 OR cnp_name = (TYPEOF(cnp_name))'' OR param_cnp_name = (TYPEOF(cnp_name))''  )
      AND ( st = (TYPEOF(st))'' OR param_st = (TYPEOF(st))'' OR st = param_st  )),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
 
 
EXPORT ScoredproxidFetch(TYPEOF(h.fname) param_fname,TYPEOF(h.lname) param_lname,TYPEOF(h.mname) param_mname,TYPEOF(h.cnp_name) param_cnp_name,TYPEOF(h.st) param_st,TYPEOF(h.company_sic_code1) param_company_sic_code1,TYPEOF(h.cnp_number) param_cnp_number,TYPEOF(h.cnp_btype) param_cnp_btype,TYPEOF(h.cnp_lowv) param_cnp_lowv,SET OF TYPEOF(h.zip) param_zip,TYPEOF(h.prim_name) param_prim_name,TYPEOF(h.p_city_name) param_p_city_name,TYPEOF(h.prim_range) param_prim_range,TYPEOF(h.sec_range) param_sec_range) := FUNCTION
  RawData := RawFetch(param_fname,param_lname,param_mname,param_cnp_name,param_st);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 7; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 7, 0); // Set bitmap for key failed
    SELF.fname_match_code := MAP(
		le.fname = (TYPEOF(le.fname))'' OR le.fname = (TYPEOF(le.fname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_fname(le.fname,param_fname,TRUE));
    SELF.fnameWeight := (50+MAP ( le.fname = param_fname  => le.fname_weight100,
          le.fname = (TYPEOF(le.fname))'' OR param_fname = (TYPEOF(le.fname))'' => 0,
           -1.000*le.fname_weight100))/100; 
    SELF.lname_match_code := MAP(
		le.lname = (TYPEOF(le.lname))'' OR le.lname = (TYPEOF(le.lname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_lname(le.lname,param_lname,TRUE));
    SELF.lnameWeight := (50+MAP ( le.lname = param_lname  => le.lname_weight100,
          le.lname = (TYPEOF(le.lname))'' OR param_lname = (TYPEOF(le.lname))'' => 0,
           -1.000*le.lname_weight100))/100; 
    SELF.mname_match_code := MAP(
		le.mname = (TYPEOF(le.mname))'' OR param_mname = (TYPEOF(param_mname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_mname(le.mname,param_mname,FALSE));
    SELF.mnameWeight := (50+MAP ( le.mname = param_mname  => le.mname_weight100,
           le.mname = (TYPEOF(le.mname))'' OR param_mname = (TYPEOF(param_mname))'' => 0,
           le.mname = param_mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100,
           SALT29.WithinEditN(le.mname,param_mname,2, 0) => le.mname_e2_weight100,
           le.mname[1..LENGTH(TRIM(param_mname))] = param_mname => SALT29.Fn_Interpolate_Initial(le.mname,param_mname,le.mname_weight100,le.mname_initial_weight100), // later in sequence as less accurate
           -1.000*le.mname_weight100))/100; 
    SELF.cnp_name_match_code := MAP(
		le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = param_cnp_name  => le.cnp_name_weight100,
           le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => 0,
           SALT29.MatchBagOfWords(le.cnp_name,param_cnp_name,31744,0)))/100; 
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
    SELF.Weight :=MAX(0,SELF.fnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight);
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT29.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.fname) fname := (TYPEOF(h.fname))'';
  TYPEOF(h.lname) lname := (TYPEOF(h.lname))'';
  TYPEOF(h.mname) mname := (TYPEOF(h.mname))'';
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';
  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';
  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';
  SET OF SALT29.StrType zip_cases := [];
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  TYPEOF(h.p_city_name) p_city_name := (TYPEOF(h.p_city_name))'';
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 7; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.fname_match_code := MAP(
		le.fname = (TYPEOF(le.fname))'' OR le.fname = (TYPEOF(le.fname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_fname(le.fname,ri.fname,TRUE));
    SELF.fnameWeight := (50+MAP ( le.fname = ri.fname  => le.fname_weight100,
          le.fname = (TYPEOF(le.fname))'' OR ri.fname = (TYPEOF(le.fname))'' => 0,
           -1.000*le.fname_weight100))/100; 
    SELF.lname_match_code := MAP(
		le.lname = (TYPEOF(le.lname))'' OR le.lname = (TYPEOF(le.lname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_lname(le.lname,ri.lname,TRUE));
    SELF.lnameWeight := (50+MAP ( le.lname = ri.lname  => le.lname_weight100,
          le.lname = (TYPEOF(le.lname))'' OR ri.lname = (TYPEOF(le.lname))'' => 0,
           -1.000*le.lname_weight100))/100; 
    SELF.mname_match_code := MAP(
		le.mname = (TYPEOF(le.mname))'' OR ri.mname = (TYPEOF(ri.mname))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_mname(le.mname,ri.mname,FALSE));
    SELF.mnameWeight := (50+MAP ( le.mname = ri.mname  => le.mname_weight100,
           le.mname = (TYPEOF(le.mname))'' OR ri.mname = (TYPEOF(ri.mname))'' => 0,
           le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100,
           SALT29.WithinEditN(le.mname,ri.mname,2, 0) => le.mname_e2_weight100,
           le.mname[1..LENGTH(TRIM(ri.mname))] = ri.mname => SALT29.Fn_Interpolate_Initial(le.mname,ri.mname,le.mname_weight100,le.mname_initial_weight100), // later in sequence as less accurate
           -1.000*le.mname_weight100))/100; 
    SELF.cnp_name_match_code := MAP(
		le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT29.MatchCode.OneSideNull,match_methods(File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
           le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => 0,
           SALT29.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0)))/100; 
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
    SELF.Weight :=MAX(0,SELF.fnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.sec_rangeWeight);
    SELF := le;
  END;
  Recs0 := Recs(fname <> (typeof(fname))'',lname <> (typeof(lname))'');
  SALT29.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.fname = RIGHT.fname
     AND LEFT.lname = RIGHT.lname
     AND ( LEFT.mname[1..LENGTH(TRIM(RIGHT.mname))] = RIGHT.mname OR RIGHT.mname[1..LENGTH(TRIM(LEFT.mname))] = LEFT.mname OR SALT29.WithinEditN(LEFT.mname,RIGHT.mname,2, 0)  )
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT29.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,31744,0) > Config.cnp_name_Force * 100 )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.fname = RIGHT.fname
     AND LEFT.lname = RIGHT.lname,10000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.fname = RIGHT.fname
     AND LEFT.lname = RIGHT.lname
     AND ( LEFT.mname[1..LENGTH(TRIM(RIGHT.mname))] = RIGHT.mname OR RIGHT.mname[1..LENGTH(TRIM(LEFT.mname))] = LEFT.mname OR SALT29.WithinEditN(LEFT.mname,RIGHT.mname,2, 0)  )
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT29.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,31744,0) > Config.cnp_name_Force * 100 )
     AND ( LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.fname = RIGHT.fname
     AND LEFT.lname = RIGHT.lname,10000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_Biz_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT29.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_fname='',Input_lname='',Input_mname='',Input_cnp_name='',Input_st='',Input_company_sic_code1='',Input_cnp_number='',Input_cnp_btype='',Input_cnp_lowv='',Input_zip='',Input_prim_name='',Input_p_city_name='',Input_prim_range='',Input_sec_range='',output_file,AsIndex='true') := MACRO
IMPORT SALT29,BIPV2_WAF;
#IF(#TEXT(Input_fname)<>'' AND #TEXT(Input_lname)<>'')
  #uniquename(trans)
  BIPV2_WAF.Key_BizHead_L_CONTACT.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.fname := (TYPEOF(SELF.fname))le.Input_fname;
    SELF.lname := (TYPEOF(SELF.lname))le.Input_lname;
    #IF ( #TEXT(Input_mname) <> '' )
      SELF.mname := (TYPEOF(SELF.mname))le.Input_mname;
    #END
    #IF ( #TEXT(Input_cnp_name) <> '' )
      SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
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
    #IF ( #TEXT(Input_zip) <> '' )
      SELF.zip_cases := le.Input_zip;
    #END
    #IF ( #TEXT(Input_prim_name) <> '' )
      SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    #END
    #IF ( #TEXT(Input_p_city_name) <> '' )
      SELF.p_city_name := (TYPEOF(SELF.p_city_name))le.Input_p_city_name;
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
  output_file := BIPV2_WAF.Key_BizHead_L_CONTACT.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
