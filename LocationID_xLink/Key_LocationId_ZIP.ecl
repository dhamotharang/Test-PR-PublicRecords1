IMPORT SALT37,std;
EXPORT Key_LocationId_ZIP := MODULE
 
//zip5:prim_range:prim_name:?:sec_range:+:unit_desig:postdir:addr_suffix:predir
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Refs::ZIP';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Refs::ZIP';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by LocId
layout := RECORD // project out required fields
// Compulsory fields
  h.zip5;
  h.prim_range;
  h.prim_name;
// Optional fields
  h.LocId; // The ID field
  h.sec_range;
// Extra credit fields
  h.unit_desig;
  h.postdir;
  h.addr_suffix;
  h.predir;
  h.prim_name_len;
  h.unit_desig_len;
  h.postdir_len;
  h.addr_suffix_len;
  h.predir_len;
//Scores for various field components
  h.zip5_weight100 ; // Contains 100x the specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_name_weight100 ; // Contains 100x the specificity
  INTEGER2 prim_name_e1_Weight100 := SALT37.Min0(h.prim_name_weight100 + 100*log(h.prim_name_cnt/h.prim_name_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.unit_desig_weight100 ; // Contains 100x the specificity
  INTEGER2 unit_desig_e1_Weight100 := SALT37.Min0(h.unit_desig_weight100 + 100*log(h.unit_desig_cnt/h.unit_desig_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.postdir_weight100 ; // Contains 100x the specificity
  INTEGER2 postdir_e1_Weight100 := SALT37.Min0(h.postdir_weight100 + 100*log(h.postdir_cnt/h.postdir_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.addr_suffix_weight100 ; // Contains 100x the specificity
  INTEGER2 addr_suffix_e1_Weight100 := SALT37.Min0(h.addr_suffix_weight100 + 100*log(h.addr_suffix_cnt/h.addr_suffix_e1_cnt)/log(2)); // Precompute edit-distance specificity
  h.predir_weight100 ; // Contains 100x the specificity
  INTEGER2 predir_e1_Weight100 := SALT37.Min0(h.predir_weight100 + 100*log(h.predir_cnt/h.predir_e1_cnt)/log(2)); // Precompute edit-distance specificity
END;
 
s := Specificities(File_LocationId).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((zip5 NOT IN SET(s.nulls_zip5,zip5) AND zip5 <> (TYPEOF(zip5))''),(prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND prim_range <> (TYPEOF(prim_range))''),(prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
SHARED DataForKey := DataForKey0;
 
EXPORT Key := INDEX(DataForKey,{DataForKey},{},KeyName_sf); 
EXPORT BuildKey := INDEX(DataForKey,{DataForKey},{},KeyName);  /* HACK03 */

EXPORT BuildAll := BUILDINDEX(BuildKey, OVERWRITE);  /* HACK04 */
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LocId,zip5,prim_range,prim_name,sec_range,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_unit_desig := GROUP( DEDUP( SORT( Grpd, EXCEPT unit_desig), EXCEPT unit_desig));
  CntRed_unit_desig := (KeyCnt-COUNT(Rem_unit_desig))/KeyCnt;
  Rem_postdir := GROUP( DEDUP( SORT( Grpd, EXCEPT postdir), EXCEPT postdir));
  CntRed_postdir := (KeyCnt-COUNT(Rem_postdir))/KeyCnt;
  Rem_addr_suffix := GROUP( DEDUP( SORT( Grpd, EXCEPT addr_suffix), EXCEPT addr_suffix));
  CntRed_addr_suffix := (KeyCnt-COUNT(Rem_addr_suffix))/KeyCnt;
  Rem_predir := GROUP( DEDUP( SORT( Grpd, EXCEPT predir), EXCEPT predir));
  CntRed_predir := (KeyCnt-COUNT(Rem_predir))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ZIP','unit_desig',CntRed_unit_desig*100,CntRed_unit_desig*TSize},{'ZIP','postdir',CntRed_postdir*100,CntRed_postdir*TSize},{'ZIP','addr_suffix',CntRed_addr_suffix*100,CntRed_addr_suffix*TSize},{'ZIP','predir',CntRed_predir*100,CntRed_predir*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_LocationID_Layouts.InputLayout le) := le.zip5 <> (TYPEOF(le.zip5))'' AND Fields.InValid_zip5((SALT37.StrType)le.zip5)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND Fields.InValid_prim_range((SALT37.StrType)le.prim_range)=0 AND le.prim_name <> (TYPEOF(le.prim_name))'' AND Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( zip5 = param_zip5 AND param_zip5 <> (TYPEOF(zip5))''))
      AND KEYED(( prim_range = param_prim_range AND param_prim_range <> (TYPEOF(prim_range))''))
      AND KEYED(( prim_name = param_prim_name AND param_prim_name <> (TYPEOF(prim_name))''))
      AND ( sec_range = (TYPEOF(sec_range))'' OR param_sec_range = (TYPEOF(sec_range))'' OR SALT37.HyphenMatch(sec_range,param_sec_range,1)<=1 )),_CFG.ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LocId);
 
 
EXPORT ScoredLocIdFetch(TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.unit_desig) param_unit_desig = (TYPEOF(h.unit_desig))'',TYPEOF(h.unit_desig_len) param_unit_desig_len = (TYPEOF(h.unit_desig_len))'',TYPEOF(h.postdir) param_postdir = (TYPEOF(h.postdir))'',TYPEOF(h.postdir_len) param_postdir_len = (TYPEOF(h.postdir_len))'',TYPEOF(h.addr_suffix) param_addr_suffix = (TYPEOF(h.addr_suffix))'',TYPEOF(h.addr_suffix_len) param_addr_suffix_len = (TYPEOF(h.addr_suffix_len))'',TYPEOF(h.predir) param_predir = (TYPEOF(h.predir))'',TYPEOF(h.predir_len) param_predir_len = (TYPEOF(h.predir_len))'') := FUNCTION
  RawData := RawFetch(param_zip5,param_prim_range,param_prim_name,param_prim_name_len,param_sec_range);
 
  Process_LocationID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 2; // Set bitmap for keys used
    SELF.keys_failed := IF(le.LocId = 0, 1 << 2, 0); // Set bitmap for key failed
    SELF.zip5_match_code := match_methods(File_LocationId).match_zip5(le.zip5,param_zip5,TRUE);
    SELF.zip5Weight := (50+MAP (
           le.zip5 = param_zip5  => le.zip5_weight100,
          le.zip5 = (TYPEOF(le.zip5))'' OR param_zip5 = (TYPEOF(le.zip5))'' => 0,
          -1.000*le.zip5_weight100))/100; 
    SELF.prim_range_match_code := match_methods(File_LocationId).match_prim_range(le.prim_range,param_prim_range,TRUE);
    SELF.prim_rangeWeight := (50+MAP (
           le.prim_range = param_prim_range  => le.prim_range_weight100,
          le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(le.prim_range))'' => 0,
          -1.000*le.prim_range_weight100))/100; 
    SELF.prim_name_match_code := match_methods(File_LocationId).match_prim_name(le.prim_name,param_prim_name,le.prim_name_len,param_prim_name_len,TRUE);
    SELF.prim_nameWeight := (50+MAP (
           le.prim_name = param_prim_name  => le.prim_name_weight100,
          le.prim_name = (TYPEOF(le.prim_name))'' OR param_prim_name = (TYPEOF(le.prim_name))'' => 0,
          -1.000*le.prim_name_weight100))/100; 
    SELF.sec_range_match_code := MAP(
           le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_sec_range(le.sec_range,param_sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP (
           le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => 0,
           le.sec_range = param_sec_range  => le.sec_range_weight100,
           SALT37.HyphenMatch(le.sec_range,param_sec_range,1)<=1  =>le.sec_range_weight100*MIN(1,LENGTH(TRIM(param_sec_range))/LENGTH(TRIM(le.sec_range))),
           -1.000*le.sec_range_weight100))/100; 
    SELF.unit_desig_match_code := MAP(
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR param_unit_desig = (TYPEOF(param_unit_desig))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_unit_desig(le.unit_desig,param_unit_desig,le.unit_desig_len,param_unit_desig_len,FALSE));
    SELF.unit_desigWeight := (50+MAP (
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR param_unit_desig = (TYPEOF(param_unit_desig))'' => 0,
           le.unit_desig = param_unit_desig  => le.unit_desig_weight100,
           _CFG.WithinEditN(le.unit_desig,le.unit_desig_len,param_unit_desig,param_unit_desig_len,1, 0)  =>le.unit_desig_e1_weight100,
           -1.000*le.unit_desig_weight100))/100; 
    SELF.postdir_match_code := MAP(
           le.postdir = (TYPEOF(le.postdir))'' OR param_postdir = (TYPEOF(param_postdir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_postdir(le.postdir,param_postdir,le.postdir_len,param_postdir_len,FALSE));
    SELF.postdirWeight := (50+MAP (
           le.postdir = (TYPEOF(le.postdir))'' OR param_postdir = (TYPEOF(param_postdir))'' => 0,
           le.postdir = param_postdir  => le.postdir_weight100,
           _CFG.WithinEditN(le.postdir,le.postdir_len,param_postdir,param_postdir_len,1, 0)  =>le.postdir_e1_weight100,
           -1.000*le.postdir_weight100))/100; 
    SELF.addr_suffix_match_code := MAP(
           le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR param_addr_suffix = (TYPEOF(param_addr_suffix))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_addr_suffix(le.addr_suffix,param_addr_suffix,le.addr_suffix_len,param_addr_suffix_len,FALSE));
    SELF.addr_suffixWeight := (50+MAP (
           le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR param_addr_suffix = (TYPEOF(param_addr_suffix))'' => 0,
           le.addr_suffix = param_addr_suffix  => le.addr_suffix_weight100,
           _CFG.WithinEditN(le.addr_suffix,le.addr_suffix_len,param_addr_suffix,param_addr_suffix_len,1, 0)  =>le.addr_suffix_e1_weight100,
           -1.000*le.addr_suffix_weight100))/100; 
    SELF.predir_match_code := MAP(
           le.predir = (TYPEOF(le.predir))'' OR param_predir = (TYPEOF(param_predir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_predir(le.predir,param_predir,le.predir_len,param_predir_len,FALSE));
    SELF.predirWeight := (50+MAP (
           le.predir = (TYPEOF(le.predir))'' OR param_predir = (TYPEOF(param_predir))'' => 0,
           le.predir = param_predir  => le.predir_weight100,
           _CFG.WithinEditN(le.predir,le.predir_len,param_predir,param_predir_len,1, 0)  =>le.predir_e1_weight100,
           -1.000*le.predir_weight100))/100; 
    SELF.Weight := IF(le.LocId = 0, 100, MAX(0,SELF.zip5Weight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.addr_suffixWeight) + MAX(0,SELF.predirWeight));
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.LocId = RIGHT.LocId,Process_LocationID_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
 
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT37.UIDType Reference;//How to recognize this record in the subsequent
  TYPEOF(h.zip5) zip5 := (TYPEOF(h.zip5))'';
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  TYPEOF(h.prim_name_len) prim_name_len := (TYPEOF(h.prim_name_len))'';
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  TYPEOF(h.unit_desig) unit_desig := (TYPEOF(h.unit_desig))'';
  TYPEOF(h.unit_desig_len) unit_desig_len := (TYPEOF(h.unit_desig_len))'';
  TYPEOF(h.postdir) postdir := (TYPEOF(h.postdir))'';
  TYPEOF(h.postdir_len) postdir_len := (TYPEOF(h.postdir_len))'';
  TYPEOF(h.addr_suffix) addr_suffix := (TYPEOF(h.addr_suffix))'';
  TYPEOF(h.addr_suffix_len) addr_suffix_len := (TYPEOF(h.addr_suffix_len))'';
  TYPEOF(h.predir) predir := (TYPEOF(h.predir))'';
  TYPEOF(h.predir_len) predir_len := (TYPEOF(h.predir_len))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
 
  Process_LocationID_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := TRANSFORM
    SELF.Reference := ri.reference; // Copy reference field
    SELF.keys_used := 1 << 2; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for key failed
    SELF.zip5_match_code := match_methods(File_LocationId).match_zip5(le.zip5,ri.zip5,TRUE);
    SELF.zip5Weight := (50+MAP (
           le.zip5 = ri.zip5  => le.zip5_weight100,
          le.zip5 = (TYPEOF(le.zip5))'' OR ri.zip5 = (TYPEOF(le.zip5))'' => 0,
          -1.000*le.zip5_weight100))/100; 
    SELF.prim_range_match_code := match_methods(File_LocationId).match_prim_range(le.prim_range,ri.prim_range,TRUE);
    SELF.prim_rangeWeight := (50+MAP (
           le.prim_range = ri.prim_range  => le.prim_range_weight100,
          le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(le.prim_range))'' => 0,
          -1.000*le.prim_range_weight100))/100; 
    SELF.prim_name_match_code := match_methods(File_LocationId).match_prim_name(le.prim_name,ri.prim_name,le.prim_name_len,ri.prim_name_len,TRUE);
    SELF.prim_nameWeight := (50+MAP (
           le.prim_name = ri.prim_name  => le.prim_name_weight100,
          le.prim_name = (TYPEOF(le.prim_name))'' OR ri.prim_name = (TYPEOF(le.prim_name))'' => 0,
          -1.000*le.prim_name_weight100))/100; 
    SELF.sec_range_match_code := MAP(
           le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_sec_range(le.sec_range,ri.sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP (
           le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => 0,
           le.sec_range = ri.sec_range  => le.sec_range_weight100,
           SALT37.HyphenMatch(le.sec_range,ri.sec_range,1)<=1  =>le.sec_range_weight100*MIN(1,LENGTH(TRIM(ri.sec_range))/LENGTH(TRIM(le.sec_range))),
           -1.000*le.sec_range_weight100))/100; 
    SELF.unit_desig_match_code := MAP(
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.unit_desig = (TYPEOF(ri.unit_desig))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_unit_desig(le.unit_desig,ri.unit_desig,le.unit_desig_len,ri.unit_desig_len,FALSE));
    SELF.unit_desigWeight := (50+MAP (
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.unit_desig = (TYPEOF(ri.unit_desig))'' => 0,
           le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
           _CFG.WithinEditN(le.unit_desig,le.unit_desig_len,ri.unit_desig,ri.unit_desig_len,1, 0)  =>le.unit_desig_e1_weight100,
           -1.000*le.unit_desig_weight100))/100; 
    SELF.postdir_match_code := MAP(
           le.postdir = (TYPEOF(le.postdir))'' OR ri.postdir = (TYPEOF(ri.postdir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_postdir(le.postdir,ri.postdir,le.postdir_len,ri.postdir_len,FALSE));
    SELF.postdirWeight := (50+MAP (
           le.postdir = (TYPEOF(le.postdir))'' OR ri.postdir = (TYPEOF(ri.postdir))'' => 0,
           le.postdir = ri.postdir  => le.postdir_weight100,
           _CFG.WithinEditN(le.postdir,le.postdir_len,ri.postdir,ri.postdir_len,1, 0)  =>le.postdir_e1_weight100,
           -1.000*le.postdir_weight100))/100; 
    SELF.addr_suffix_match_code := MAP(
           le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.addr_suffix = (TYPEOF(ri.addr_suffix))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_addr_suffix(le.addr_suffix,ri.addr_suffix,le.addr_suffix_len,ri.addr_suffix_len,FALSE));
    SELF.addr_suffixWeight := (50+MAP (
           le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.addr_suffix = (TYPEOF(ri.addr_suffix))'' => 0,
           le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
           _CFG.WithinEditN(le.addr_suffix,le.addr_suffix_len,ri.addr_suffix,ri.addr_suffix_len,1, 0)  =>le.addr_suffix_e1_weight100,
           -1.000*le.addr_suffix_weight100))/100; 
    SELF.predir_match_code := MAP(
           le.predir = (TYPEOF(le.predir))'' OR ri.predir = (TYPEOF(ri.predir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_predir(le.predir,ri.predir,le.predir_len,ri.predir_len,FALSE));
    SELF.predirWeight := (50+MAP (
           le.predir = (TYPEOF(le.predir))'' OR ri.predir = (TYPEOF(ri.predir))'' => 0,
           le.predir = ri.predir  => le.predir_weight100,
           _CFG.WithinEditN(le.predir,le.predir_len,ri.predir,ri.predir_len,1, 0)  =>le.predir_e1_weight100,
           -1.000*le.predir_weight100))/100; 
    SELF.Weight := IF(le.LocId = 0, 100, MAX(0,SELF.zip5Weight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.addr_suffixWeight) + MAX(0,SELF.predirWeight));
    SELF := le;
  END;
  Recs0 := Recs(zip5 <> (TYPEOF(zip5))'',prim_range <> (TYPEOF(prim_range))'',prim_name <> (TYPEOF(prim_name))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,_CFG.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name = RIGHT.prim_name
     AND ( LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR SALT37.HyphenMatch(LEFT.sec_range,RIGHT.sec_range,1)<=1  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name = RIGHT.prim_name,_CFG.ZIP_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name = RIGHT.prim_name
     AND ( LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR SALT37.HyphenMatch(LEFT.sec_range,RIGHT.sec_range,1)<=1  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name = RIGHT.prim_name,_CFG.ZIP_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_LocationID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_zip5='',Input_prim_range='',Input_prim_name='',Input_sec_range='',Input_unit_desig='',Input_postdir='',Input_addr_suffix='',Input_predir='',output_file,AsIndex='true') := MACRO
IMPORT SALT37,LocationId_xLink;
#IF(#TEXT(Input_zip5)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_prim_name)<>'')
  #uniquename(trans)
  LocationId_xLink.Key_LocationId_ZIP.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.zip5 := (TYPEOF(SELF.zip5))le.Input_zip5;
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
    SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
    SELF.prim_name_len := LENGTH(TRIM((TYPEOF(SELF.prim_name))le.Input_prim_name));
    #IF ( #TEXT(Input_sec_range) <> '' )
      SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
    #END
    #IF ( #TEXT(Input_unit_desig) <> '' )
      SELF.unit_desig := (TYPEOF(SELF.unit_desig))le.Input_unit_desig;
      SELF.unit_desig_len := LENGTH(TRIM((TYPEOF(SELF.unit_desig))le.Input_unit_desig));
    #END
    #IF ( #TEXT(Input_postdir) <> '' )
      SELF.postdir := (TYPEOF(SELF.postdir))le.Input_postdir;
      SELF.postdir_len := LENGTH(TRIM((TYPEOF(SELF.postdir))le.Input_postdir));
    #END
    #IF ( #TEXT(Input_addr_suffix) <> '' )
      SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))le.Input_addr_suffix;
      SELF.addr_suffix_len := LENGTH(TRIM((TYPEOF(SELF.addr_suffix))le.Input_addr_suffix));
    #END
    #IF ( #TEXT(Input_predir) <> '' )
      SELF.predir := (TYPEOF(SELF.predir))le.Input_predir;
      SELF.predir_len := LENGTH(TRIM((TYPEOF(SELF.predir))le.Input_predir));
    #END
  END;
  #uniquename(p)
  %p% := PROJECT(Infile,%trans%(left));
  output_file := LocationId_xLink.Key_LocationId_ZIP.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := DATASET([],LocationId_xLink.Process_LocationID_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
END;
