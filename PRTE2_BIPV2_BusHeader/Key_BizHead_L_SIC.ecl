﻿IMPORT BizLinkFull,SALT33,ut,std;
EXPORT Key_BizHead_L_SIC := MODULE
 
//company_sic_code1:zip:?:cnp_name:prim_name
 
EXPORT KeyName := PRTE2_BIPV2_BusHeader.Filename_keys.L_SIC; /*HACK07*/
SHARED h := CandidatesForKey;//The input file - distributed by proxid
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
  h.cnp_name;
  h.prim_name;
  h.powid; // Uncle #1
//Scores for various field components
  h.company_sic_code1_weight100 ; // Contains 100x the specificity
  h.zip_weight100 ; // Contains 100x the specificity
  h.cnp_name_weight100 ; // Contains 100x the specificity
  h.cnp_name_initial_char_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  h.prim_name_e1_Weight100;
END;
 
s := PRTE2_BIPV2_BusHeader.Specificities(PRTE2_BIPV2_BusHeader.File_BizHead).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1) AND company_sic_code1 <> (TYPEOF(company_sic_code1))''),(zip NOT IN SET(s.nulls_zip,zip) AND zip <> (TYPEOF(zip))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
 
EXPORT Key := INDEX(DataForKey0,,KeyName);
 
EXPORT BuildAll := BUILDINDEX(Key, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,proxid,company_sic_code1,zip,cnp_name,prim_name,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT33.ShrinkLayout);
EXPORT CanSearch(Process_Biz_Layouts.InputLayout le) := le.company_sic_code1 <> (typeof(le.company_sic_code1))'' AND EXISTS(le.zip_cases);
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch_server(TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( company_sic_code1 = param_company_sic_code1 AND param_company_sic_code1 <> (TYPEOF(company_sic_code1))''))
      AND KEYED(( zip IN SET(param_zip,zip) AND EXISTS(param_zip)))
      AND ( SALT33.MatchBagOfWords(cnp_name,param_cnp_name,3177747,1) > BizLinkFull.Config_BIP.cnp_name_Force * 100 OR cnp_name = (TYPEOF(cnp_name))'' OR param_cnp_name = (TYPEOF(cnp_name))'' )
      AND ( prim_name = (TYPEOF(prim_name))'' OR param_prim_name = (TYPEOF(prim_name))'' OR SALT33.WithinEditN(prim_name,param_prim_name,1, 0) )
      AND KEYED(fallback_value >= param_fallback_value)),10000,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),ultid,orgid,seleid,proxid);
 
EXPORT RawFetch(TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
// Why not LOOP? - Because I am expecting FIRST one to win 990f the time - and don't want to impact it
  RawData0 := RawFetch_server(param_company_sic_code1,param_zip,param_cnp_name,param_prim_name,0);
  RawData1 := RawFetch_server(param_company_sic_code1,param_zip,param_cnp_name,param_prim_name,1);
  RawData2 := RawFetch_server(param_company_sic_code1,param_zip,param_cnp_name,param_prim_name,2);
  Returnable(DATASET(RECORDOF(RawData0)) d) := COUNT(NOFOLD(d))<>1 OR EXISTS(NOFOLD(d((SALT33.StrType)company_sic_code1 != '')));
  res := MAP (
      param_fallback_value <= 0 AND Returnable(RawData0) => RawData0,
      param_fallback_value <= 1 AND Returnable(RawData1) => RawData1,
      RawData2);
  RETURN res;
END;
 
EXPORT ScoredproxidFetch(TYPEOF(h.company_sic_code1) param_company_sic_code1 = (TYPEOF(h.company_sic_code1))'',DATASET(process_Biz_layouts.layout_zip_cases) param_zip,TYPEOF(h.cnp_name) param_cnp_name = (TYPEOF(h.cnp_name))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.fallback_value) param_fallback_value = (TYPEOF(h.fallback_value))'') := FUNCTION
  RawData := RawFetch(param_company_sic_code1,param_zip,param_cnp_name,param_prim_name,param_fallback_value);
 
  Process_Biz_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 1 << 14, 0); // Set bitmap for key failed
    SELF.company_sic_code1_match_code := MAP(le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,param_company_sic_code1,TRUE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = param_company_sic_code1  => le.company_sic_code1_weight100,
          le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR param_company_sic_code1 = (TYPEOF(le.company_sic_code1))'' => 0,
          -0.727*le.company_sic_code1_weight100))/100; 
    SELF.zip_match_code := MAP(le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_zip(le.zip,param_zip,TRUE));
    SELF.zipWeight := (50+MAP ( EXISTS(param_zip(le.zip=zip)) => /*HACK16  le.zip_weight100 */ 1100 * param_zip(zip=le.zip)[1].weight/100.0,
          le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(param_zip) => 0,
          -0.995*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_layouts.layout_zip_cases);
    SELF.cnp_name_match_code := MAP(le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_cnp_name(le.cnp_name,param_cnp_name,0,0,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = (TYPEOF(le.cnp_name))'' OR param_cnp_name = (TYPEOF(param_cnp_name))'' => 0,
           le.cnp_name = param_cnp_name  => le.cnp_name_weight100,
           SALT33.MatchBagOfWords(le.cnp_name,param_cnp_name,3177747,1)))/100; 
    SELF.prim_name_match_code := MAP(le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_prim_name(le.prim_name,param_prim_name,0,0,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(param_prim_name))'' => 0,
           le.prim_name = param_prim_name  => le.prim_name_weight100,
           SALT33.WithinEditN(le.prim_name,param_prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.prim_nameWeight));
    SELF := le;
  END;
  RETURN ROLLUP(PROJECT(NOFOLD(RawData),Score(LEFT)),LEFT.proxid = RIGHT.proxid,Process_Biz_Layouts.combine_scores(LEFT,RIGHT));
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT33.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  DATASET(BizLinkFull.process_Biz_layouts.layout_zip_cases) zip_cases := DATASET([],BizLinkFull.process_Biz_layouts.layout_zip_cases);
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_Biz_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 14; // Set bitmap for key used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.company_sic_code1_match_code := MAP(le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,TRUE));
    SELF.company_sic_code1Weight := (50+MAP ( le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
          le.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' OR ri.company_sic_code1 = (TYPEOF(le.company_sic_code1))'' => 0,
          -0.727*le.company_sic_code1_weight100))/100; 
    SELF.zip_match_code := MAP(le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(ri.zip_cases) => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_zip(le.zip,ri.zip_cases,TRUE));
    SELF.zipWeight := (50+MAP ( EXISTS(ri.zip_cases(le.zip=zip)) => le.zip_weight100 * ri.zip_cases(zip=le.zip)[1].weight/100.0,
          le.zip = (TYPEOF(le.zip))'' OR ~EXISTS(ri.zip_cases) => 0,
          -0.995*le.zip_weight100))/100; 
    SELF.zip_cases := DATASET([{le.zip,SELF.zipweight}],Process_Biz_layouts.layout_zip_cases);
    SELF.cnp_name_match_code := MAP(le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,0,0,FALSE));
    SELF.cnp_nameWeight := (50+MAP ( le.cnp_name = (TYPEOF(le.cnp_name))'' OR ri.cnp_name = (TYPEOF(ri.cnp_name))'' => 0,
           le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
           SALT33.MatchBagOfWords(le.cnp_name,ri.cnp_name,3177747,1)))/100; 
    SELF.prim_name_match_code := MAP(le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT33.MatchCode.OneSideNull,BizLinkFull.match_methods(File_BizHead).match_prim_name(le.prim_name,ri.prim_name,0,0,FALSE));
    SELF.prim_nameWeight := (50+MAP ( le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(ri.prim_name))'' => 0,
           le.prim_name = ri.prim_name  => le.prim_name_weight100,
           SALT33.WithinEditN(le.prim_name,ri.prim_name,1, 0) => le.prim_name_e1_weight100,
           -1.000*le.prim_name_weight100))/100; 
    SELF.Weight := IF(le.proxid = 0 AND le.seleid = 0 AND le.orgid = 0 AND le.ultid = 0, 100, MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.prim_nameWeight));
    SELF := le;
  END;
  Recs0 := Recs(company_sic_code1 <> (typeof(company_sic_code1))'',EXISTS(zip_cases));
  SALT33.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,BizLinkFull.Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.company_sic_code1 = RIGHT.company_sic_code1
     AND LEFT.zip_cases[1].zip = RIGHT.zip
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT33.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,3177747,1) > BizLinkFull.Config_BIP.cnp_name_Force * 100 )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT33.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
     AND LEFT.zip_cases[1].zip = RIGHT.zip,/*HACK01*/2000)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.company_sic_code1 = RIGHT.company_sic_code1
     AND LEFT.zip_cases[1].zip = RIGHT.zip
     AND ( LEFT.cnp_name = (TYPEOF(LEFT.cnp_name))'' OR RIGHT.cnp_name = (TYPEOF(RIGHT.cnp_name))'' OR SALT33.MatchBagOfWords(LEFT.cnp_name,RIGHT.cnp_name,3177747,1) > BizLinkFull.Config_BIP.cnp_name_Force * 100 )
     AND ( LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR SALT33.WithinEditN(LEFT.prim_name,RIGHT.prim_name,1, 0)  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1
     AND LEFT.zip_cases[1].zip = RIGHT.zip,/*HACK01*/2000),HASH,HINT(unsorted_output)); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_Biz_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT33.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_company_sic_code1='',Input_zip='',Input_cnp_name='',Input_prim_name='',output_file,AsIndex='true') := MACRO
IMPORT SALT33,BizLinkFull;
#IF(#TEXT(Input_company_sic_code1)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(trans)
  PRTE2_BIPV2_BusHeader.Key_BizHead_L_SIC.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))le.Input_company_sic_code1;
    SELF.zip_cases := le.Input_zip;
    #IF ( #TEXT(Input_cnp_name) <> '' )
      SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
    #END
    #IF ( #TEXT(Input_prim_name) <> '' )
      SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := PRTE2_BIPV2_BusHeader.Key_BizHead_L_SIC.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],PRTE2_BIPV2_BusHeader.Process_Biz_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
