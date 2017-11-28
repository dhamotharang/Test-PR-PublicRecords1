IMPORT SALT37,std;
EXPORT Key_LocationId_ := MODULE
 
//prim_range:predir:prim_name:?:addr_suffix:+:postdir:unit_desig:sec_range:v_city_name:st:zip5
EXPORT KeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Refs';
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Refs';
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
SHARED h := CandidatesForKey;//The input file - distributed by LocId
EXPORT Layout_Uber_Record := RECORD(SALT37.Layout_Uber_Record0)
END;
EXPORT Layout_Uber_Plus := RECORD(Layout_Uber_Record)
  SALT37.Str30Type word;
  UNSIGNED2 word_weight100 := 0;
END;
EXPORT Fn_Reduce_Uber_Local(DATASET(Layout_Uber_Plus) in_ds) := FUNCTION
// The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP(SORT(in_ds,uid,word,field,LOCAL),uid,word,field,LOCAL);
END;
Layout_Uber_Plus IntoInversion(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT37.StrType)le.prim_range,(SALT37.StrType)le.predir,(SALT37.StrType)le.prim_name,(SALT37.StrType)le.addr_suffix,(SALT37.StrType)le.postdir,(SALT37.StrType)le.unit_desig,(SALT37.StrType)le.sec_range,(SALT37.StrType)le.v_city_name,(SALT37.StrType)le.st,(SALT37.StrType)le.zip5,SKIP);
  SELF.field := c;
  SELF.uid := le.LocId;
  SELF := le;
END;
nfields_r := Fn_Reduce_UBER_Local(NORMALIZE(h,10,IntoInversion(LEFT,COUNTER))(word<>''));
invert_records := nfields_r;
SHARED DataForKey0 := Fn_Reduce_UBER_Local( invert_records );
 
EXPORT ValueKeyName := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+_CFG.KeyInfix+'::LocId::Words';
 
EXPORT ValueKeyName_sf := '~'+KeyPrefix+'::'+'key::LocationId_xLink'+'::'+KeySuperfile+'::LocId::Words';
 
EXPORT AssignCurrentValueKeyToSuperFile := FileServices.AddSuperFile(ValueKeyName_sf,ValueKeyName);
 
EXPORT ClearValueKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(ValueKeyName_sf,,TRUE),FileServices.ClearSuperFile(ValueKeyName_sf));
  r0 := RECORD
    DataForKey0.uid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  END;
  SHARED ClusterSizes := TABLE(DataForKey0,r0,uid,LOCAL);// Set up for Specificity_Local
  SHARED TotalClusters := COUNT(ClusterSizes);
  SALT37.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT37.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName_sf);
EXPORT BuildValueKey := INDEX(word_values,{word},{word_values},ValueKeyName);  /* HACK08 */

  Layout_Uber_Plus add_id(Layout_Uber_Plus le,word_values ri,BOOLEAN patch_default) := TRANSFORM
    SELF.word_id := ri.id;
    SELF := le;
  END;
  SALT37.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  DataForKey2:=DEDUP( SORT(DataForKey1,uid,word,field,LOCAL),uid,word,field,LOCAL );
  Layout_Uber_record slim(DataForKey2 le) := TRANSFORM
    SELF := le;
  END;
  SHARED DataForKey3 := DEDUP(SORT(PROJECT(DataForKey2,slim(LEFT)),WHOLE RECORD,SKEW(1)),WHOLE RECORD);
 
EXPORT Key := INDEX(DataForKey3,{DataForKey3},{},KeyName_sf);
EXPORT BuildKey := INDEX(DataForKey3,{DataForKey3},{},KeyName);  /* HACK09 */

EXPORT BuildAll := PARALLEL(BUILDINDEX(BuildValueKey, OVERWRITE),BUILDINDEX(BuildKey, OVERWRITE));
KeyRec := RECORDOF(Key);
 
EXPORT RawFetch(TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.predir) param_predir = (TYPEOF(h.predir))'',TYPEOF(h.predir_len) param_predir_len = (TYPEOF(h.predir_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.addr_suffix) param_addr_suffix = (TYPEOF(h.addr_suffix))'',TYPEOF(h.addr_suffix_len) param_addr_suffix_len = (TYPEOF(h.addr_suffix_len))'',TYPEOF(h.postdir) param_postdir = (TYPEOF(h.postdir))'',TYPEOF(h.postdir_len) param_postdir_len = (TYPEOF(h.postdir_len))'',TYPEOF(h.unit_desig) param_unit_desig = (TYPEOF(h.unit_desig))'',TYPEOF(h.unit_desig_len) param_unit_desig_len = (TYPEOF(h.unit_desig_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.v_city_name) param_v_city_name = (TYPEOF(h.v_city_name))'',TYPEOF(h.v_city_name_len) param_v_city_name_len = (TYPEOF(h.v_city_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'') := 
  FUNCTION
 //Create wordstream from parameters
    SALT37.MAC_Field_To_UberStream(param_prim_range,1,ValueKey,WS1);
    SALT37.MAC_Field_To_UberStream(param_predir,2,ValueKey,WS2);
    SALT37.MAC_Field_To_UberStream(param_prim_name,3,ValueKey,WS3);
    SALT37.MAC_Field_To_UberStream(param_addr_suffix,4,ValueKey,WS4);
    SALT37.MAC_Field_To_UberStream(param_postdir,5,ValueKey,WS5);
    SALT37.MAC_Field_To_UberStream(param_unit_desig,6,ValueKey,WS6);
    SALT37.MAC_Field_To_UberStream(param_sec_range,7,ValueKey,WS7);
    SALT37.MAC_Field_To_UberStream(param_v_city_name,8,ValueKey,WS8);
    SALT37.MAC_Field_To_UberStream(param_st,9,ValueKey,WS9);
    SALT37.MAC_Field_To_UberStream(param_zip5,10,ValueKey,WS10);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10;
    SALT37.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches,Layout_Uber_Record,,,,,,,);
    RETURN steppedmatches;
  END;
 
EXPORT ScoredLocIdFetch(TYPEOF(h.prim_range) param_prim_range = (TYPEOF(h.prim_range))'',TYPEOF(h.predir) param_predir = (TYPEOF(h.predir))'',TYPEOF(h.predir_len) param_predir_len = (TYPEOF(h.predir_len))'',TYPEOF(h.prim_name) param_prim_name = (TYPEOF(h.prim_name))'',TYPEOF(h.prim_name_len) param_prim_name_len = (TYPEOF(h.prim_name_len))'',TYPEOF(h.addr_suffix) param_addr_suffix = (TYPEOF(h.addr_suffix))'',TYPEOF(h.addr_suffix_len) param_addr_suffix_len = (TYPEOF(h.addr_suffix_len))'',TYPEOF(h.postdir) param_postdir = (TYPEOF(h.postdir))'',TYPEOF(h.postdir_len) param_postdir_len = (TYPEOF(h.postdir_len))'',TYPEOF(h.unit_desig) param_unit_desig = (TYPEOF(h.unit_desig))'',TYPEOF(h.unit_desig_len) param_unit_desig_len = (TYPEOF(h.unit_desig_len))'',TYPEOF(h.sec_range) param_sec_range = (TYPEOF(h.sec_range))'',TYPEOF(h.v_city_name) param_v_city_name = (TYPEOF(h.v_city_name))'',TYPEOF(h.v_city_name_len) param_v_city_name_len = (TYPEOF(h.v_city_name_len))'',TYPEOF(h.st) param_st = (TYPEOF(h.st))'',TYPEOF(h.zip5) param_zip5 = (TYPEOF(h.zip5))'') := FUNCTION
  RawData := RawFetch(param_prim_range,param_predir,param_predir_len,param_prim_name,param_prim_name_len,param_addr_suffix,param_addr_suffix_len,param_postdir,param_postdir_len,param_unit_desig,param_unit_desig_len,param_sec_range,param_v_city_name,param_v_city_name_len,param_st,param_zip5);
 
  Process_LocationID_Layouts.LayoutScoredFetch Score(RawData le) := TRANSFORM
    SELF.keys_used := 1 << 0; // Set bitmap for keys used
    SELF.keys_failed := 0; // Set bitmap for keys failed
    SELF.LocId := le.uid;
    SELF.Weight := le.Weight; // Already rolled up in collate_uber
    SELF := le;
  END;
  result0 := PROJECT(NOFOLD(RawData),Score(LEFT));
  result1 := ROLLUP(result0,LEFT.LocId = RIGHT.LocId,Process_LocationID_Layouts.combine_scores(LEFT,RIGHT));
  RETURN result1;
END;
END;
