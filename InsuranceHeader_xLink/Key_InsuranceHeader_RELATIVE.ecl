IMPORT SALT311,std;
EXPORT Key_InsuranceHeader_RELATIVE(BOOLEAN incremental=FALSE, UNSIGNED2  aBlockLimit= Config.RELATIVE_MAXBLOCKLIMIT) := MODULE/*HACK25*/
 
//fname2:lname2:?:FNAME:LNAME
EXPORT KeyName := KeyNames().RELATIVE_logical; /*HACK40*/
 
EXPORT KeyName_sf := KeyNames().RELATIVE_super; /*HACK10*/
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
STRING csv_fields := 'FNAME,LNAME,DID';
SHARED h := CandidatesForKey(csv_fields, incremental);//The input file - distributed by DID
 
SHARED s := Specificities(File_InsuranceHeader).Specificities[1];
SHARED s_index := Keys(File_InsuranceHeader).Specificities_Key[1]; // Index access for MEOW queries
SHARED infileRES := Specificities(File_InsuranceHeader).RES_values_persisted;
layout := RECORD // project out required fields
// Compulsory fields
  Config.AttrValueType fname2 := '';
  Config.AttrValueType lname2 := '';
// Optional fields
  h.DID; // The ID field
  h.FNAME_PreferredName;
  h.FNAME;
  h.LNAME;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  h.FNAME_len;
  h.LNAME_len;
//Scores for various field components
  INTEGER2 fname2_weight100 := 0;
  INTEGER2 lname2_weight100 := 0;
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.FNAME_initial_char_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e1_Weight100;
  h.FNAME_e1p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.FNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_MAINNAME_fuzzy_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e1_Weight100;
  h.LNAME_e1p_Weight100;
  h.LNAME_MAINNAME_cnt ; // Number of name instances matching this one in CONCEPT as BOW
END;
 
DataForKey0 := DEDUP(SORT(TABLE(h(),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
TYPEOF(DataForKey0) AddAFile0(DataForKey0 le,infileRES ri) := TRANSFORM
  SELF.fname2 := ri.fname2;
  SELF.fname2_weight100 := ri.fname2_weight100;
  SELF.lname2 := ri.lname2;
  SELF.lname2_weight100 := ri.lname2_weight100;
  SELF := le; // Copy record
END;
 
DataForKey1 := DEDUP(SORT(JOIN(DataForKey0,PULL(infileRES),left.DID=right.DID,AddAFile0(LEFT,RIGHT),LEFT OUTER,HASH),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL)(fname2_weight100 > 0 AND lname2_weight100 > 0);
SHARED DataForKey := DataForKey1;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{BOOLEAN IsIncremental := incremental},KeyName_sf);
 
EXPORT BuildAll := BUILDINDEX(Key, KeyName, OVERWRITE);
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,DID,fname2,lname2,FNAME,LNAME,LOCAL); // Not perfect, does not need to be - for statistics
EXPORT Shrinkage := DATASET([],SALT311.ShrinkLayout);
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := SALT311.MAC_FieldListCSVFromDataset(DataForKey,[],',');
  fieldListPayload := 'IsIncremental';
  RETURN Process_xIDL_Layouts().MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.RELATIVE_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/
EXPORT CanSearch(Process_xIDL_Layouts().InputLayout le) := le.fname2 <> (TYPEOF(le.fname2))'' AND Fields.InValid_fname2((SALT311.StrType)le.fname2)=0 AND le.lname2 <> (TYPEOF(le.lname2))'' AND Fields.InValid_lname2((SALT311.StrType)le.lname2)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(SALT311.StrType param_fname2,SALT311.StrType param_lname2,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'') := 
    STEPPED( LIMIT( Key(
          ( fname2 = param_fname2 AND param_fname2 <> (TYPEOF(fname2))'' )
      AND ( lname2 = param_lname2 AND param_lname2 <> (TYPEOF(lname2))'' )
      AND ((param_FNAME = (TYPEOF(FNAME))'' OR FNAME = (TYPEOF(FNAME))'') OR (FNAME = param_FNAME) OR ((FNAME[1..LENGTH(TRIM(param_FNAME))] = param_FNAME OR param_FNAME[1..LENGTH(TRIM(FNAME))] = FNAME)  OR  (FNAME_PreferredName = fn_PreferredName(param_FNAME))  OR  (metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME))  OR (Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/) OR (Config.WildMatch(FNAME,param_FNAME,FALSE)) ))
      AND ((param_LNAME = (TYPEOF(LNAME))'' OR LNAME = (TYPEOF(LNAME))'') OR (LNAME = param_LNAME) OR ( (metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME))  OR (Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/)  OR (SALT311.HyphenMatch(LNAME,param_LNAME,1)<=2)OR (Config.WildMatch(LNAME,param_LNAME,FALSE)) ))),MAX_BLOCKLIMIT/*HACK24b*/,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),DID);
 
 
EXPORT ScoredDIDFetch(SALT311.StrType param_fname2,SALT311.StrType param_lname2,TYPEOF(h.FNAME) param_FNAME = (TYPEOF(h.FNAME))'',TYPEOF(h.FNAME_len) param_FNAME_len = (TYPEOF(h.FNAME_len))'',TYPEOF(h.LNAME) param_LNAME = (TYPEOF(h.LNAME))'',TYPEOF(h.LNAME_len) param_LNAME_len = (TYPEOF(h.LNAME_len))'',BOOLEAN param_disableForce = FALSE) := FUNCTION
  RawData := RawFetch(param_fname2,param_lname2,param_FNAME,param_FNAME_len,param_LNAME,param_LNAME_len);
useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
 
  Process_xIDL_Layouts().LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 12; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := IF(le.DID = 0, 1 << 12, 0); // Set bitmap for key failed
    SELF.fname2_match_code := match_methods(File_InsuranceHeader).match_fname2(le.fname2,param_fname2,TRUE);
    SELF.fname2Weight := (50+MAP (
           SELF.fname2_match_code = SALT311.MatchCode.ExactMatch =>le.fname2_weight100,
           -1.000*le.fname2_weight100))/100; 
    SELF.lname2_match_code := match_methods(File_InsuranceHeader).match_lname2(le.lname2,param_lname2,TRUE);
    SELF.lname2Weight := (50+MAP (
           SELF.lname2_match_code = SALT311.MatchCode.ExactMatch =>le.lname2_weight100,
           -1.000*le.lname2_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR param_FNAME = (TYPEOF(param_FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,param_FNAME,le.FNAME_len,param_FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.WildMatch =>le.FNAME_weight100 / Config.WildPenalty,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR param_LNAME = (TYPEOF(param_LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,param_LNAME,le.LNAME_len,param_LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(param_LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.WildMatch =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.fname2Weight) + MAX(0, SELF.lname2Weight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  poisoned_results := TABLE(result0(keys_poisoned > 0), {DID, keys_poisoned}, DID, keys_poisoned);
  result_rollup0 := DEDUP(SORT(result0,DID,fname2,lname2,FNAME,LNAME,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST),DID,fname2,lname2,FNAME,LNAME,DT_EFFECTIVE_FIRST);
  result_rollup1 := JOIN(result_rollup0, poisoned_results, LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), SELF.keys_poisoned := RIGHT.keys_poisoned, SELF := LEFT), LEFT OUTER);
  result1 := result_rollup1((DT_EFFECTIVE_FIRST = 0 OR useDate >= DT_EFFECTIVE_FIRST) AND (useDate <= DT_EFFECTIVE_LAST OR DT_EFFECTIVE_LAST = 0));
  result2 := PROJECT(result1, Process_xIDL_Layouts().update_forcefailed(LEFT,param_disableForce));
  result3 := ROLLUP(result2,LEFT.DID = RIGHT.DID,Process_xIDL_Layouts().combine_scores(LEFT,RIGHT,param_disableForce));
  RETURN result3;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT311.UIDType Reference;//How to recognize this record in the subsequent
  SALT311.StrType fname2 := '';
  SALT311.StrType lname2 := '';
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  TYPEOF(h.FNAME_len) FNAME_len := (TYPEOF(h.FNAME_len))'';
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  TYPEOF(h.LNAME_len) LNAME_len := (TYPEOF(h.LNAME_len))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex, BOOLEAN In_disableForce = FALSE) := FUNCTION
 
  Process_xIDL_Layouts().LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 12; // Set bitmap for keys used
    SELF.keys_poisoned := IF(le.DT_EFFECTIVE_LAST <> 0 AND le.IsIncremental, SELF.keys_used, 0);
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.fname2_match_code := match_methods(File_InsuranceHeader).match_fname2(le.fname2,ri.fname2,TRUE);
    SELF.fname2Weight := (50+MAP (
           SELF.fname2_match_code = SALT311.MatchCode.ExactMatch =>le.fname2_weight100,
           -1.000*le.fname2_weight100))/100; 
    SELF.lname2_match_code := match_methods(File_InsuranceHeader).match_lname2(le.lname2,ri.lname2,TRUE);
    SELF.lname2Weight := (50+MAP (
           SELF.lname2_match_code = SALT311.MatchCode.ExactMatch =>le.lname2_weight100,
           -1.000*le.lname2_weight100))/100; 
    SELF.FNAME_match_code := MAP(
           le.FNAME = (TYPEOF(le.FNAME))'' OR ri.FNAME = (TYPEOF(ri.FNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_FNAME(le.FNAME,ri.FNAME,le.FNAME_len,ri.FNAME_len,FALSE));
    SELF.FNAMEWeight := (50+MAP (
           SELF.FNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.FNAME_match_code = SALT311.MatchCode.ExactMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialLMatch =>le.FNAME_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.InitialRMatch=> SALT311.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_char_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e1p_weight100,le.FNAME_e1_weight100),
           SELF.FNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.FNAME_p_weight100,
           SELF.FNAME_match_code = SALT311.MatchCode.WildMatch =>le.FNAME_weight100 / Config.WildPenalty,
           SELF.FNAME_match_code = SALT311.MatchCode.CustomFuzzyMatch =>le.FNAME_PreferredName_weight100,
           -0.737*le.FNAME_weight100))/100*0.80; 
    SELF.LNAME_match_code := MAP(
           le.LNAME = (TYPEOF(le.LNAME))'' OR ri.LNAME = (TYPEOF(ri.LNAME))'' => SALT311.MatchCode.OneSideNull,
           match_methods(File_InsuranceHeader).match_LNAME(le.LNAME,ri.LNAME,le.LNAME_len,ri.LNAME_len,FALSE));
    SELF.LNAMEWeight := (50+MAP (
           SELF.LNAME_match_code = SALT311.MatchCode.OneSideNull => 0,
           SELF.LNAME_match_code = SALT311.MatchCode.ExactMatch =>le.LNAME_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.HyphenMatch =>le.LNAME_weight100*MIN(1,LENGTH(TRIM(ri.LNAME))/LENGTH(TRIM(le.LNAME))),
           SELF.LNAME_match_code = SALT311.MatchCode.EditDistanceMatch =>IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e1p_weight100,le.LNAME_e1_weight100),
           SELF.LNAME_match_code = SALT311.MatchCode.PhoneticMatch =>le.LNAME_p_weight100,
           SELF.LNAME_match_code = SALT311.MatchCode.WildMatch =>le.LNAME_weight100 / Config.WildPenalty,
           -0.617*le.LNAME_weight100))/100*0.80; 
    SELF.Weight := IF(le.DID = 0, 100, MAX(0, SELF.fname2Weight) + MAX(0, SELF.lname2Weight) + MAX(0, SELF.FNAMEWeight) + MAX(0, SELF.LNAMEWeight));
    SELF := le;
  END;
  Recs0 := Recs(fname2 <> (TYPEOF(fname2))'',lname2 <> (TYPEOF(lname2))'');
  SALT311.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,Config.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.fname2 = RIGHT.fname2
     AND LEFT.lname2 = RIGHT.lname2
     AND ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/) OR (Config.WildMatch(RIGHT.FNAME,LEFT.FNAME,FALSE)) ))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.fname2 = RIGHT.fname2
     AND LEFT.lname2 = RIGHT.lname2,Config.RELATIVE_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.fname2 = RIGHT.fname2
     AND LEFT.lname2 = RIGHT.lname2
     AND ((LEFT.FNAME = (TYPEOF(RIGHT.FNAME))'' OR RIGHT.FNAME = (TYPEOF(RIGHT.FNAME))'') OR (RIGHT.FNAME = LEFT.FNAME) OR ((RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME)  OR  (RIGHT.FNAME_PreferredName = fn_PreferredName(LEFT.FNAME))  OR  (metaphonelib.DMetaPhone1(RIGHT.FNAME)=metaphonelib.DMetaPhone1(LEFT.FNAME))  OR (Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/) OR (Config.WildMatch(RIGHT.FNAME,LEFT.FNAME,FALSE)) ))
     AND ((LEFT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'') OR (RIGHT.LNAME = LEFT.LNAME) OR ( (metaphonelib.DMetaPhone1(RIGHT.LNAME)=metaphonelib.DMetaPhone1(LEFT.LNAME))  OR (Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/)  OR (SALT311.HyphenMatch(RIGHT.LNAME,LEFT.LNAME,1)<=2)OR (Config.WildMatch(RIGHT.LNAME,LEFT.LNAME,FALSE)) )),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.fname2 = RIGHT.fname2
     AND LEFT.lname2 = RIGHT.lname2,Config.RELATIVE_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  useDate := (UNSIGNED4)SALT311.fn_now('YYYYMMDD');
  J2_dist := DISTRIBUTE(J2, HASH(Reference));
  poisoned_results := TABLE(SORT(J2_dist, Reference, DID, LOCAL), {Reference, DID, keys_poisoned}, Reference, DID, keys_poisoned, LOCAL);
  result_rollup0 := DEDUP(SORT(J2_dist,Reference,DID,fname2,lname2,FNAME,LNAME,DT_EFFECTIVE_FIRST,-DT_EFFECTIVE_LAST, LOCAL),Reference,DID,fname2,lname2,FNAME,LNAME,DT_EFFECTIVE_FIRST, LOCAL);
  result_rollup1 := JOIN(result_rollup0, poisoned_results, LEFT.Reference = RIGHT.Reference AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(LEFT), SELF.keys_poisoned := RIGHT.keys_poisoned, SELF := LEFT), LEFT OUTER, LOCAL);
  result_rollup := result_rollup1((DT_EFFECTIVE_FIRST = 0 OR useDate >= DT_EFFECTIVE_FIRST) AND (useDate <= DT_EFFECTIVE_LAST OR DT_EFFECTIVE_LAST = 0));
  J3 := IF(EXISTS(poisoned_results), result_rollup, J2);
  J4 := PROJECT(J3, Process_xIDL_Layouts().update_forcefailed(LEFT,In_disableForce));
  J5 := Process_xIDL_Layouts().CombineLinkpathScores(J4,In_disableForce); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT311.MAC_Dups_Restore(J5,DD,J6,Reference,TRUE)
  RETURN J6;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_fname2='',Input_lname2='',Input_FNAME='',Input_LNAME='',output_file,AsIndex='true', In_disableForce = 'false') := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
  #IF(#TEXT(Input_fname2)<>'' AND #TEXT(Input_lname2)<>'')
    #UNIQUENAME(trans)
    InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().InputLayout_Batch %trans%(InFile le) := TRANSFORM
      SELF.Reference := le.Input_Ref;
      SELF.fname2 := (TYPEOF(SELF.fname2))le.Input_fname2;
      SELF.lname2 := (TYPEOF(SELF.lname2))le.Input_lname2;
      #IF ( #TEXT(Input_FNAME) <> '' )
        SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
        SELF.FNAME_len := LENGTH(TRIM((TYPEOF(SELF.FNAME))le.Input_FNAME));
      #END
      #IF ( #TEXT(Input_LNAME) <> '' )
        SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
        SELF.LNAME_len := LENGTH(TRIM((TYPEOF(SELF.LNAME))le.Input_LNAME));
      #END
    END;
    #UNIQUENAME(p)
    %p% := PROJECT(Infile,%trans%(left));
    output_file := InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().ScoredFetch_Batch(%p%,AsIndex, In_disableForce);
  #ELSE
    output_file := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch); // Compulsory fields missing
  #END
ENDMACRO;
END;
