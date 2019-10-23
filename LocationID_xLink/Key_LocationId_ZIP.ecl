IMPORT SALT37,std;
EXPORT Key_LocationId_ZIP := MODULE
 
//zip5:prim_range:prim_name_derived:?:sec_range:predir:postdir:addr_suffix_derived:+:unit_desig:err_stat
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Refs::ZIP';
 
EXPORT KeyName_sf        := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Refs::ZIP';
EXPORT ForeignKeyName_sf(string daliAddress) := '~foreign::' + daliAddress +'::'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Refs::ZIP';

EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by LocId
layout := RECORD // project out required fields
// Compulsory fields
  h.zip5;
  h.prim_range;
  h.prim_name_derived;
// Optional fields
  h.sec_range;
  h.predir;
  h.postdir;
  h.addr_suffix_derived;
  h.LocId; // The ID field
// Extra credit fields
  h.unit_desig;
  h.err_stat;
//Scores for various field components
  h.zip5_weight100 ; // Contains 100x the specificity
  INTEGER2 zip5_ZipRadius_Weight100 := h.zip5_weight100; // Precompute ZipRadius specificity
  h.prim_range_weight100 ; // Contains 100x the specificity
  h.prim_name_derived_weight100 ; // Contains 100x the specificity
  h.sec_range_weight100 ; // Contains 100x the specificity
  h.predir_weight100 ; // Contains 100x the specificity
  h.postdir_weight100 ; // Contains 100x the specificity
  h.addr_suffix_derived_weight100 ; // Contains 100x the specificity
  h.unit_desig_weight100 ; // Contains 100x the specificity
  h.err_stat_weight100 ; // Contains 100x the specificity
END;
 
s := Specificities(File_LocationId).Specificities[1];
 
DataForKey0 := DEDUP(SORT(TABLE(h((zip5 NOT IN SET(s.nulls_zip5,zip5) AND zip5 <> (TYPEOF(zip5))''),(prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND prim_range <> (TYPEOF(prim_range))''),(prim_name_derived NOT IN SET(s.nulls_prim_name_derived,prim_name_derived) AND prim_name_derived <> (TYPEOF(prim_name_derived))'')),layout),WHOLE RECORD,LOCAL),WHOLE RECORD,LOCAL); // Project out the fields in match candidates required for this Name()
export DataForKey := DataForKey0;
 
EXPORT ForeignKey(string daliAddress)  := INDEX(DataForKey,{DataForKey},{},ForeignKeyName_sf(daliAddress)); /*Key_LocationId_ZIP01*/
EXPORT Key      := INDEX(DataForKey,{DataForKey},{},KeyName_sf); /*Key_LocationId_ZIP01*/
EXPORT BuildKey(dataset(recordof(DataForKey)) inData) := INDEX(inData,{inData},{},KeyName); /*Key_LocationId_ZIP01*/
 
EXPORT BuildAll := BUILDINDEX(BuildKey(DataForKey), OVERWRITE); /*Key_LocationId_ZIP02*/
// Compute shrinkage stats; the amount we could shrink the key for each extra credit removal
  KeyCnt := COUNT(Key);
  TSize := KeyCnt * SIZEOF(RECORDOF(Key)) / 1000000000; // Key size in gigs
  Grpd := GROUP(Key,LocId,zip5,prim_range,prim_name_derived,sec_range,predir,postdir,addr_suffix_derived,LOCAL); // Not perfect, does not need to be - for statistics
  Rem_unit_desig := GROUP( DEDUP( SORT( Grpd, EXCEPT unit_desig), EXCEPT unit_desig));
  CntRed_unit_desig := (KeyCnt-COUNT(Rem_unit_desig))/KeyCnt;
  Rem_err_stat := GROUP( DEDUP( SORT( Grpd, EXCEPT err_stat), EXCEPT err_stat));
  CntRed_err_stat := (KeyCnt-COUNT(Rem_err_stat))/KeyCnt;
EXPORT Shrinkage := DATASET([{'ZIP','unit_desig',CntRed_unit_desig*100,CntRed_unit_desig*TSize},{'ZIP','err_stat',CntRed_err_stat*100,CntRed_err_stat*TSize}],SALT37.ShrinkLayout);
EXPORT CanSearch(Process_LocationID_Layouts.InputLayout le) := le.zip5 <> (TYPEOF(le.zip5))'' AND Fields.InValid_zip5((SALT37.StrType)le.zip5)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND Fields.InValid_prim_range((SALT37.StrType)le.prim_range)=0 AND le.prim_name_derived <> (TYPEOF(le.prim_name_derived))'' AND Fields.InValid_prim_name_derived((SALT37.StrType)le.prim_name_derived)=0;
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name_derived) param_prim_name_derived = (TYPEOF(h.prim_name_derived))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.predir) param_predir = (TYPEOF(h.predir))'',TYPEOF(h.postdir) param_postdir = (TYPEOF(h.postdir))'',TYPEOF(h.addr_suffix_derived) param_addr_suffix_derived = (TYPEOF(h.addr_suffix_derived))'') := 
    STEPPED( LIMIT( Key(
          KEYED(( zip5 = param_zip5 AND param_zip5 <> (TYPEOF(zip5))''))
      AND KEYED(( prim_range = param_prim_range AND param_prim_range <> (TYPEOF(prim_range))''))
      AND KEYED(( prim_name_derived = param_prim_name_derived AND param_prim_name_derived <> (TYPEOF(prim_name_derived))''))
      AND KEYED(( sec_range = (TYPEOF(sec_range))'' OR param_sec_range = (TYPEOF(sec_range))'' OR sec_range = param_sec_range ))
      AND KEYED(( predir = (TYPEOF(predir))'' OR param_predir = (TYPEOF(predir))'' OR predir = param_predir ))
      AND KEYED(( postdir = (TYPEOF(postdir))'' OR param_postdir = (TYPEOF(postdir))'' OR postdir = param_postdir ))
      AND KEYED(( addr_suffix_derived = (TYPEOF(addr_suffix_derived))'' OR param_addr_suffix_derived = (TYPEOF(addr_suffix_derived))'' OR addr_suffix_derived = param_addr_suffix_derived ))),_CFG.ZIP_MAXBLOCKLIMIT,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED),LocId);
 
 
EXPORT ScoredLocIdFetch(TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'',TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.prim_name_derived) param_prim_name_derived = (TYPEOF(h.prim_name_derived))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.predir) param_predir = (TYPEOF(h.predir))'',TYPEOF(h.postdir) param_postdir = (TYPEOF(h.postdir))'',TYPEOF(h.addr_suffix_derived) param_addr_suffix_derived = (TYPEOF(h.addr_suffix_derived))'',TYPEOF(h.unit_desig) param_unit_desig = (TYPEOF(h.unit_desig))'',TYPEOF(h.err_stat) param_err_stat = (TYPEOF(h.err_stat))'') := FUNCTION
  RawData := RawFetch(param_zip5,param_prim_range,param_prim_name_derived,param_sec_range,param_predir,param_postdir,param_addr_suffix_derived);
 
  Process_LocationID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 2; // Set bitmap for keys used
    SELF.keys_failed := IF(le.LocId = 0, 1 << 2, 0); // Set bitmap for key failed
    SELF.zip5_match_code := match_methods(File_LocationId).match_zip5(le.zip5,param_zip5,TRUE);
    SELF.zip5Weight := (50+MAP (
           le.zip5 = param_zip5  => le.zip5_weight100,
          le.zip5 = (TYPEOF(le.zip5))'' OR param_zip5 = (TYPEOF(le.zip5))'' => 0,
          -0.994*le.zip5_weight100))/100; 
    SELF.prim_range_match_code := match_methods(File_LocationId).match_prim_range(le.prim_range,param_prim_range,TRUE);
    SELF.prim_rangeWeight := (50+MAP (
           le.prim_range = param_prim_range  => le.prim_range_weight100,
          le.prim_range = (TYPEOF(le.prim_range))'' OR param_prim_range = (TYPEOF(le.prim_range))'' => 0,
          -0.997*le.prim_range_weight100))/100; 
    SELF.prim_name_derived_match_code := match_methods(File_LocationId).match_prim_name_derived(le.prim_name_derived,param_prim_name_derived,TRUE);
    SELF.prim_name_derivedWeight := (50+MAP (
           le.prim_name_derived = param_prim_name_derived  => le.prim_name_derived_weight100,
          le.prim_name_derived = (TYPEOF(le.prim_name_derived))'' OR param_prim_name_derived = (TYPEOF(le.prim_name_derived))'' => 0,
          -0.993*le.prim_name_derived_weight100))/100; 
    SELF.sec_range_match_code := MAP(
           le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_sec_range(le.sec_range,param_sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP (
           le.sec_range = (TYPEOF(le.sec_range))'' OR param_sec_range = (TYPEOF(param_sec_range))'' => 0,
           le.sec_range = param_sec_range  => le.sec_range_weight100,
           -0.916*le.sec_range_weight100))/100; 
    SELF.predir_match_code := MAP(
           le.predir = (TYPEOF(le.predir))'' OR param_predir = (TYPEOF(param_predir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_predir(le.predir,param_predir,FALSE));
    SELF.predirWeight := (50+MAP (
           le.predir = (TYPEOF(le.predir))'' OR param_predir = (TYPEOF(param_predir))'' => 0,
           le.predir = param_predir  => le.predir_weight100,
           -0.998*le.predir_weight100))/100; 
    SELF.postdir_match_code := MAP(
           le.postdir = (TYPEOF(le.postdir))'' OR param_postdir = (TYPEOF(param_postdir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_postdir(le.postdir,param_postdir,FALSE));
    SELF.postdirWeight := (50+MAP (
           le.postdir = (TYPEOF(le.postdir))'' OR param_postdir = (TYPEOF(param_postdir))'' => 0,
           le.postdir = param_postdir  => le.postdir_weight100,
           -0.976*le.postdir_weight100))/100; 
    SELF.addr_suffix_derived_match_code := MAP(
           le.addr_suffix_derived = (TYPEOF(le.addr_suffix_derived))'' OR param_addr_suffix_derived = (TYPEOF(param_addr_suffix_derived))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_addr_suffix_derived(le.addr_suffix_derived,param_addr_suffix_derived,FALSE));
    SELF.addr_suffix_derivedWeight := (50+MAP (
           le.addr_suffix_derived = (TYPEOF(le.addr_suffix_derived))'' OR param_addr_suffix_derived = (TYPEOF(param_addr_suffix_derived))'' => 0,
           le.addr_suffix_derived = param_addr_suffix_derived  => le.addr_suffix_derived_weight100,
           -0.997*le.addr_suffix_derived_weight100))/100; 
    SELF.unit_desig_match_code := MAP(
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR param_unit_desig = (TYPEOF(param_unit_desig))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_unit_desig(le.unit_desig,param_unit_desig,FALSE));
    SELF.unit_desigWeight := (50+MAP (
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR param_unit_desig = (TYPEOF(param_unit_desig))'' => 0,
           le.unit_desig = param_unit_desig  => le.unit_desig_weight100,
           -0.988*le.unit_desig_weight100))/100; 
    SELF.err_stat_match_code := MAP(
           le.err_stat = (TYPEOF(le.err_stat))'' OR param_err_stat = (TYPEOF(param_err_stat))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_err_stat(le.err_stat,param_err_stat,FALSE));
    SELF.err_statWeight := (50+MAP (
           le.err_stat = (TYPEOF(le.err_stat))'' OR param_err_stat = (TYPEOF(param_err_stat))'' => 0,
           le.err_stat = param_err_stat  => le.err_stat_weight100,
           -1.000*le.err_stat_weight100))/100*10.00; 
    SELF.Weight := IF(le.LocId = 0, 100, MAX(0,SELF.zip5Weight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_name_derivedWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.predirWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.addr_suffix_derivedWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.err_statWeight));
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
  TYPEOF(h.prim_name_derived) prim_name_derived := (TYPEOF(h.prim_name_derived))'';
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  TYPEOF(h.predir) predir := (TYPEOF(h.predir))'';
  TYPEOF(h.postdir) postdir := (TYPEOF(h.postdir))'';
  TYPEOF(h.addr_suffix_derived) addr_suffix_derived := (TYPEOF(h.addr_suffix_derived))'';
  TYPEOF(h.unit_desig) unit_desig := (TYPEOF(h.unit_desig))'';
  TYPEOF(h.err_stat) err_stat := (TYPEOF(h.err_stat))'';
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
          -0.994*le.zip5_weight100))/100; 
    SELF.prim_range_match_code := match_methods(File_LocationId).match_prim_range(le.prim_range,ri.prim_range,TRUE);
    SELF.prim_rangeWeight := (50+MAP (
           le.prim_range = ri.prim_range  => le.prim_range_weight100,
          le.prim_range = (TYPEOF(le.prim_range))'' OR ri.prim_range = (TYPEOF(le.prim_range))'' => 0,
          -0.997*le.prim_range_weight100))/100; 
    SELF.prim_name_derived_match_code := match_methods(File_LocationId).match_prim_name_derived(le.prim_name_derived,ri.prim_name_derived,TRUE);
    SELF.prim_name_derivedWeight := (50+MAP (
           le.prim_name_derived = ri.prim_name_derived  => le.prim_name_derived_weight100,
          le.prim_name_derived = (TYPEOF(le.prim_name_derived))'' OR ri.prim_name_derived = (TYPEOF(le.prim_name_derived))'' => 0,
          -0.993*le.prim_name_derived_weight100))/100; 
    SELF.sec_range_match_code := MAP(
           le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_sec_range(le.sec_range,ri.sec_range,FALSE));
    SELF.sec_rangeWeight := (50+MAP (
           le.sec_range = (TYPEOF(le.sec_range))'' OR ri.sec_range = (TYPEOF(ri.sec_range))'' => 0,
           le.sec_range = ri.sec_range  => le.sec_range_weight100,
           -0.916*le.sec_range_weight100))/100; 
    SELF.predir_match_code := MAP(
           le.predir = (TYPEOF(le.predir))'' OR ri.predir = (TYPEOF(ri.predir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_predir(le.predir,ri.predir,FALSE));
    SELF.predirWeight := (50+MAP (
           le.predir = (TYPEOF(le.predir))'' OR ri.predir = (TYPEOF(ri.predir))'' => 0,
           le.predir = ri.predir  => le.predir_weight100,
           -0.998*le.predir_weight100))/100; 
    SELF.postdir_match_code := MAP(
           le.postdir = (TYPEOF(le.postdir))'' OR ri.postdir = (TYPEOF(ri.postdir))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_postdir(le.postdir,ri.postdir,FALSE));
    SELF.postdirWeight := (50+MAP (
           le.postdir = (TYPEOF(le.postdir))'' OR ri.postdir = (TYPEOF(ri.postdir))'' => 0,
           le.postdir = ri.postdir  => le.postdir_weight100,
           -0.976*le.postdir_weight100))/100; 
    SELF.addr_suffix_derived_match_code := MAP(
           le.addr_suffix_derived = (TYPEOF(le.addr_suffix_derived))'' OR ri.addr_suffix_derived = (TYPEOF(ri.addr_suffix_derived))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_addr_suffix_derived(le.addr_suffix_derived,ri.addr_suffix_derived,FALSE));
    SELF.addr_suffix_derivedWeight := (50+MAP (
           le.addr_suffix_derived = (TYPEOF(le.addr_suffix_derived))'' OR ri.addr_suffix_derived = (TYPEOF(ri.addr_suffix_derived))'' => 0,
           le.addr_suffix_derived = ri.addr_suffix_derived  => le.addr_suffix_derived_weight100,
           -0.997*le.addr_suffix_derived_weight100))/100; 
    SELF.unit_desig_match_code := MAP(
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.unit_desig = (TYPEOF(ri.unit_desig))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_unit_desig(le.unit_desig,ri.unit_desig,FALSE));
    SELF.unit_desigWeight := (50+MAP (
           le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.unit_desig = (TYPEOF(ri.unit_desig))'' => 0,
           le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
           -0.988*le.unit_desig_weight100))/100; 
    SELF.err_stat_match_code := MAP(
           le.err_stat = (TYPEOF(le.err_stat))'' OR ri.err_stat = (TYPEOF(ri.err_stat))'' => SALT37.MatchCode.OneSideNull,
           match_methods(File_LocationId).match_err_stat(le.err_stat,ri.err_stat,FALSE));
    SELF.err_statWeight := (50+MAP (
           le.err_stat = (TYPEOF(le.err_stat))'' OR ri.err_stat = (TYPEOF(ri.err_stat))'' => 0,
           le.err_stat = ri.err_stat  => le.err_stat_weight100,
           -1.000*le.err_stat_weight100))/100*10.00; 
    SELF.Weight := IF(le.LocId = 0, 100, MAX(0,SELF.zip5Weight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_name_derivedWeight) + MAX(0,SELF.sec_rangeWeight) + MAX(0,SELF.predirWeight) + MAX(0,SELF.postdirWeight) + MAX(0,SELF.addr_suffix_derivedWeight) + MAX(0,SELF.unit_desigWeight) + MAX(0,SELF.err_statWeight));
    SELF := le;
  END;
  Recs0 := Recs(zip5 <> (TYPEOF(zip5))'',prim_range <> (TYPEOF(prim_range))'',prim_name_derived <> (TYPEOF(prim_name_derived))'');
  SALT37.MAC_Dups_Note(Recs0,InputLayout_Batch,Recs1,outdups,Reference,_CFG.meow_dedup) // Whilst duplicates have been removed for the whole input; there may still be dups on a per linkpath basis
  J0 := JOIN(Recs1,Key,LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name_derived = RIGHT.prim_name_derived
     AND ( LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range  )
     AND ( LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir  )
     AND ( LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir  )
     AND ( LEFT.addr_suffix_derived = (TYPEOF(LEFT.addr_suffix_derived))'' OR RIGHT.addr_suffix_derived = (TYPEOF(RIGHT.addr_suffix_derived))'' OR LEFT.addr_suffix_derived = RIGHT.addr_suffix_derived  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name_derived = RIGHT.prim_name_derived,_CFG.ZIP_MAXBLOCKSIZE)); // Use indexed join (used for smaller batches
  J1 := JOIN(Recs1,PULL(Key),LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name_derived = RIGHT.prim_name_derived
     AND ( LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range  )
     AND ( LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir  )
     AND ( LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir  )
     AND ( LEFT.addr_suffix_derived = (TYPEOF(LEFT.addr_suffix_derived))'' OR RIGHT.addr_suffix_derived = (TYPEOF(RIGHT.addr_suffix_derived))'' OR LEFT.addr_suffix_derived = RIGHT.addr_suffix_derived  ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.zip5 = RIGHT.zip5
     AND LEFT.prim_range = RIGHT.prim_range
     AND LEFT.prim_name_derived = RIGHT.prim_name_derived,_CFG.ZIP_MAXBLOCKSIZE),HASH,UNORDERED); // PULL used to cause non-indexed join
  J2 := IF(AsIndex,J0,J1);
  J3 := Process_LocationID_Layouts.CombineLinkpathScores(J2); // Combine results and restrict number for one linkpath
  DD := DISTRIBUTE(outdups,HASH(__Shadow_Ref)); // Restore dups driven in local mode
  SALT37.MAC_Dups_Restore(J3,DD,J4,Reference,TRUE)
  RETURN J4;
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
EXPORT MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_zip5='',Input_prim_range='',Input_prim_name_derived='',Input_sec_range='',Input_predir='',Input_postdir='',Input_addr_suffix_derived='',Input_unit_desig='',Input_err_stat='',output_file,AsIndex='true') := MACRO
IMPORT SALT37,LocationId_xLink;
#IF(#TEXT(Input_zip5)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_prim_name_derived)<>'')
  #uniquename(trans)
  LocationId_xLink.Key_LocationId_ZIP.InputLayout_Batch %trans%(InFile le) := TRANSFORM
    SELF.Reference := le.Input_Ref;
    SELF.zip5 := (TYPEOF(SELF.zip5))le.Input_zip5;
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
    SELF.prim_name_derived := (TYPEOF(SELF.prim_name_derived))le.Input_prim_name_derived;
    #IF ( #TEXT(Input_sec_range) <> '' )
      SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
    #END
    #IF ( #TEXT(Input_predir) <> '' )
      SELF.predir := (TYPEOF(SELF.predir))le.Input_predir;
    #END
    #IF ( #TEXT(Input_postdir) <> '' )
      SELF.postdir := (TYPEOF(SELF.postdir))le.Input_postdir;
    #END
    #IF ( #TEXT(Input_addr_suffix_derived) <> '' )
      SELF.addr_suffix_derived := (TYPEOF(SELF.addr_suffix_derived))le.Input_addr_suffix_derived;
    #END
    #IF ( #TEXT(Input_unit_desig) <> '' )
      SELF.unit_desig := (TYPEOF(SELF.unit_desig))le.Input_unit_desig;
    #END
    #IF ( #TEXT(Input_err_stat) <> '' )
      SELF.err_stat := (TYPEOF(SELF.err_stat))le.Input_err_stat;
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
