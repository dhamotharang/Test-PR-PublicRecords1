// Begin code to BEST data for each basis
import SALT27,ut;
EXPORT Best(DATASET(layout_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
//Create those fields with BestType: BestCompanyNameCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCommon_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCommon_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameCommon_tab_company_name.Proxid;
  BestCompanyNameCommon_tab_company_name.company_name;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameCommon_tab_company_name le,BestCompanyNameCommon_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameCommon_tab_company_name,BestCompanyNameCommon_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR SALT27.WithinEditN(LEFT.company_name,RIGHT.company_name,2)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCommon_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestCompanyNameCommon_fuzz_company_name,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyNameCommon_method_company_name := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestCompanyNameCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCurrent_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameCurrent_tab_company_name.Proxid;
  BestCompanyNameCurrent_tab_company_name.company_name;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameCurrent_tab_company_name le,BestCompanyNameCurrent_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameCurrent_tab_company_name,BestCompanyNameCurrent_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR SALT27.WithinEditN(LEFT.company_name,RIGHT.company_name,2)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyNameCurrent_method_company_name := DEDUP( SORT( BestCompanyNameCurrent_fuzz_company_name(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyNameVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameVoted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameVoted_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVoted_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameVoted_tab_company_name,{Proxid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Name_Source_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Name_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVoted_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameVoted_vote_company_name,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyNameVoted_method_company_name := o;
//Create those fields with BestType: BestCompanyNameLength
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameLength_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameLength_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLength_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameLength_tab_company_name.Proxid;
  BestCompanyNameLength_tab_company_name.company_name;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameLength_tab_company_name le,BestCompanyNameLength_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameLength_tab_company_name,BestCompanyNameLength_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR SALT27.WithinEditN(LEFT.company_name,RIGHT.company_name,2)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLength_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestCompanyNameLength_method_company_name := DEDUP( SORT( BestCompanyNameLength_fuzz_company_name,Proxid,-LENGTH(TRIM((SALT27.StrType)company_name)),-Row_Cnt,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyNameStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameStrong_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameStrong_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_name using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyNameStrong_tab_company_name.Proxid;
  BestCompanyNameStrong_tab_company_name.company_name;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyNameStrong_tab_company_name le,BestCompanyNameStrong_tab_company_name ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyNameStrong_tab_company_name,BestCompanyNameStrong_tab_company_name, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_name = (TYPEOF(LEFT.company_name))'' OR RIGHT.company_name = (TYPEOF(RIGHT.company_name))'' OR SALT27.WithinEditN(LEFT.company_name,RIGHT.company_name,2)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameStrong_fuzz_company_name := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameStrong_fuzz_company_name,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestCompanyNameStrong_method_company_name := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestCompanyNameCurrent2
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCurrent2_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCurrent2_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent2_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestCompanyNameCurrent2_method_company_name := DEDUP( SORT( BestCompanyNameCurrent2_tab_company_name(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyNameVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_name,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameVotedUnrestricted_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT27.StrType)company_name),source_for_votes)),{Proxid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedUnrestricted_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameVotedUnrestricted_tab_company_name,{Proxid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedUnrestricted_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameVotedUnrestricted_vote_company_name,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyNameVotedUnrestricted_method_company_name := o;
//Create those fields with BestType: BestCompanyAddressVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVoted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVoted_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVoted_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVoted_tab_address,{Proxid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Address_Fields_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Address_Fields_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVoted_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVoted_vote_address,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyAddressVoted_method_address := o;
//Create those fields with BestType: BestCompanyAddressCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCurrent_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for address using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyAddressCurrent_tab_address.Proxid;
  BestCompanyAddressCurrent_tab_address.prim_range;
  BestCompanyAddressCurrent_tab_address.predir;
  BestCompanyAddressCurrent_tab_address.prim_name;
  BestCompanyAddressCurrent_tab_address.addr_suffix;
  BestCompanyAddressCurrent_tab_address.postdir;
  BestCompanyAddressCurrent_tab_address.unit_desig;
  BestCompanyAddressCurrent_tab_address.sec_range;
  BestCompanyAddressCurrent_tab_address.st;
  BestCompanyAddressCurrent_tab_address.zip;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressCurrent_tab_address le,BestCompanyAddressCurrent_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressCurrent_tab_address,BestCompanyAddressCurrent_tab_address, LEFT.Proxid = RIGHT.Proxid  AND ( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyAddressCurrent_method_address := DEDUP( SORT( BestCompanyAddressCurrent_fuzz_address(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyAddressVotedSrc
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVotedSrc_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVotedSrc_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSrc_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVotedSrc_tab_address,{Proxid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Address_Source_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Address_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSrc_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVotedSrc_vote_address,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyAddressVotedSrc_method_address := o;
//Create those fields with BestType: BestCompanyAddressCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCommon_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCommon_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyAddressCommon_tab_address.Proxid;
  BestCompanyAddressCommon_tab_address.prim_range;
  BestCompanyAddressCommon_tab_address.predir;
  BestCompanyAddressCommon_tab_address.prim_name;
  BestCompanyAddressCommon_tab_address.addr_suffix;
  BestCompanyAddressCommon_tab_address.postdir;
  BestCompanyAddressCommon_tab_address.unit_desig;
  BestCompanyAddressCommon_tab_address.sec_range;
  BestCompanyAddressCommon_tab_address.st;
  BestCompanyAddressCommon_tab_address.zip;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressCommon_tab_address le,BestCompanyAddressCommon_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressCommon_tab_address,BestCompanyAddressCommon_tab_address, LEFT.Proxid = RIGHT.Proxid  AND ( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCommon_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestCompanyAddressCommon_fuzz_address,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyAddressCommon_method_address := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestCompanyAddressStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressStrong_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressStrong_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyAddressStrong_tab_address.Proxid;
  BestCompanyAddressStrong_tab_address.prim_range;
  BestCompanyAddressStrong_tab_address.predir;
  BestCompanyAddressStrong_tab_address.prim_name;
  BestCompanyAddressStrong_tab_address.addr_suffix;
  BestCompanyAddressStrong_tab_address.postdir;
  BestCompanyAddressStrong_tab_address.unit_desig;
  BestCompanyAddressStrong_tab_address.sec_range;
  BestCompanyAddressStrong_tab_address.st;
  BestCompanyAddressStrong_tab_address.zip;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressStrong_tab_address le,BestCompanyAddressStrong_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressStrong_tab_address,BestCompanyAddressStrong_tab_address, LEFT.Proxid = RIGHT.Proxid  AND ( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressStrong_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressStrong_fuzz_address,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestCompanyAddressStrong_method_address := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestCompanyAddressCurrent2
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCurrent2_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCurrent2_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent2_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestCompanyAddressCurrent2_method_address := DEDUP( SORT( BestCompanyAddressCurrent2_tab_address(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestCompanyAddressVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVotedUnrestricted_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT27.StrType)prim_range) + '|' + TRIM((SALT27.StrType)predir) + '|' + TRIM((SALT27.StrType)prim_name) + '|' + TRIM((SALT27.StrType)addr_suffix) + '|' + TRIM((SALT27.StrType)postdir) + '|' + TRIM((SALT27.StrType)unit_desig) + '|' + TRIM((SALT27.StrType)sec_range) + '|' + TRIM((SALT27.StrType)st) + '|' + TRIM((SALT27.StrType)zip),source_for_votes)),{Proxid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVotedUnrestricted_tab_address,{Proxid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestCompanyAddressVotedUnrestricted_vote_address.Proxid;
  BestCompanyAddressVotedUnrestricted_vote_address.prim_range;
  BestCompanyAddressVotedUnrestricted_vote_address.predir;
  BestCompanyAddressVotedUnrestricted_vote_address.prim_name;
  BestCompanyAddressVotedUnrestricted_vote_address.addr_suffix;
  BestCompanyAddressVotedUnrestricted_vote_address.postdir;
  BestCompanyAddressVotedUnrestricted_vote_address.unit_desig;
  BestCompanyAddressVotedUnrestricted_vote_address.sec_range;
  BestCompanyAddressVotedUnrestricted_vote_address.st;
  BestCompanyAddressVotedUnrestricted_vote_address.zip;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressVotedUnrestricted_vote_address le,BestCompanyAddressVotedUnrestricted_vote_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressVotedUnrestricted_vote_address,BestCompanyAddressVotedUnrestricted_vote_address, LEFT.Proxid = RIGHT.Proxid  AND ( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVotedUnrestricted_fuzz_address,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT27.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestCompanyAddressVotedUnrestricted_method_address := o;
//Create those fields with BestType: BestPhoneCurrentWithNpa
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCurrentWithNpa_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCurrentWithNpa_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrentWithNpa_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneCurrentWithNpa_tab_company_phone.Proxid;
  BestPhoneCurrentWithNpa_tab_company_phone.company_phone;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCurrentWithNpa_tab_company_phone le,BestPhoneCurrentWithNpa_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCurrentWithNpa_tab_company_phone,BestPhoneCurrentWithNpa_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrentWithNpa_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestPhoneCurrentWithNpa_method_company_phone := DEDUP( SORT( BestPhoneCurrentWithNpa_fuzz_company_phone(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestPhoneCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCurrent_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrent_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneCurrent_tab_company_phone.Proxid;
  BestPhoneCurrent_tab_company_phone.company_phone;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCurrent_tab_company_phone le,BestPhoneCurrent_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCurrent_tab_company_phone,BestPhoneCurrent_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrent_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestPhoneCurrent_method_company_phone := DEDUP( SORT( BestPhoneCurrent_fuzz_company_phone(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestPhoneVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneVoted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneVoted_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestPhoneVoted_tab_company_phone,{Proxid,data_permits,company_phone,UNSIGNED Row_Cnt := 100 * fn_Best_Phone_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Phone_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_vote_company_phone := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneVoted_vote_company_phone.Proxid;
  BestPhoneVoted_vote_company_phone.company_phone;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneVoted_vote_company_phone le,BestPhoneVoted_vote_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneVoted_vote_company_phone,BestPhoneVoted_vote_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneVoted_fuzz_company_phone,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT27.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestPhoneVoted_method_company_phone := o;
//Create those fields with BestType: BestPhoneLongest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneLongest_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneLongest_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneLongest_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneLongest_tab_company_phone.Proxid;
  BestPhoneLongest_tab_company_phone.company_phone;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneLongest_tab_company_phone le,BestPhoneLongest_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneLongest_tab_company_phone,BestPhoneLongest_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneLongest_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestPhoneLongest_method_company_phone := DEDUP( SORT( BestPhoneLongest_fuzz_company_phone,Proxid,-LENGTH(TRIM((SALT27.StrType)company_phone)),-Row_Cnt,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestPhoneStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneStrong_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneStrong_tab_company_phone.Proxid;
  BestPhoneStrong_tab_company_phone.company_phone;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneStrong_tab_company_phone le,BestPhoneStrong_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneStrong_tab_company_phone,BestPhoneStrong_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneStrong_fuzz_company_phone,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestPhoneStrong_method_company_phone := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestPhoneVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneVotedUnrestricted_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestPhoneVotedUnrestricted_tab_company_phone,{Proxid,data_permits,company_phone,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_vote_company_phone := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneVotedUnrestricted_vote_company_phone.Proxid;
  BestPhoneVotedUnrestricted_vote_company_phone.company_phone;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneVotedUnrestricted_vote_company_phone le,BestPhoneVotedUnrestricted_vote_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneVotedUnrestricted_vote_company_phone,BestPhoneVotedUnrestricted_vote_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneVotedUnrestricted_fuzz_company_phone,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT27.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestPhoneVotedUnrestricted_method_company_phone := o;
//Create those fields with BestType: BestPhoneCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_phone,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCommon_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT27.StrType)company_phone),source_for_votes)),{Proxid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCommon_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestPhoneCommon_tab_company_phone.Proxid;
  BestPhoneCommon_tab_company_phone.company_phone;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCommon_tab_company_phone le,BestPhoneCommon_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCommon_tab_company_phone,BestPhoneCommon_tab_company_phone, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT27.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCommon_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestPhoneCommon_fuzz_company_phone,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestPhoneCommon_method_company_phone := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestFeinStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinStrong_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinStrong_tab_company_fein.Proxid;
  BestFeinStrong_tab_company_fein.company_fein;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinStrong_tab_company_fein le,BestFeinStrong_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinStrong_tab_company_fein,BestFeinStrong_tab_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT27.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinStrong_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestFeinStrong_method_company_fein := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestFeinCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinCommon_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinCommon_tab_company_fein.Proxid;
  BestFeinCommon_tab_company_fein.company_fein;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinCommon_tab_company_fein le,BestFeinCommon_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinCommon_tab_company_fein,BestFeinCommon_tab_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT27.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestFeinCommon_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestFeinCommon_method_company_fein := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestFeinCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinCurrent_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCurrent_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinCurrent_tab_company_fein.Proxid;
  BestFeinCurrent_tab_company_fein.company_fein;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinCurrent_tab_company_fein le,BestFeinCurrent_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinCurrent_tab_company_fein,BestFeinCurrent_tab_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT27.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCurrent_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestFeinCurrent_method_company_fein := DEDUP( SORT( BestFeinCurrent_fuzz_company_fein(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestFeinVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinVotedUnrestricted_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinVotedUnrestricted_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinVotedUnrestricted_tab_company_fein,{Proxid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinVotedUnrestricted_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinVotedUnrestricted_vote_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestFeinVotedUnrestricted_method_company_fein := o;
//Create those fields with BestType: BestFeinMin
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinMin_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinMin_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinMin_tab_company_fein,{Proxid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Fein_Votes_Min(source_for_votes,Row_Cnt)}); // Use fn_Best_Fein_Votes_Min to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinMin_vote_company_fein.Proxid;
  BestFeinMin_vote_company_fein.company_fein;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinMin_vote_company_fein le,BestFeinMin_vote_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinMin_vote_company_fein,BestFeinMin_vote_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT27.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinMin_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT27.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestFeinMin_method_company_fein := o;
//Create those fields with BestType: BestFeinMax
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinMax_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_fein,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinMax_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT27.StrType)company_fein),source_for_votes)),{Proxid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinMax_tab_company_fein,{Proxid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Fein_Votes_Max(source_for_votes,Row_Cnt)}); // Use fn_Best_Fein_Votes_Max to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestFeinMax_vote_company_fein.Proxid;
  BestFeinMax_vote_company_fein.company_fein;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinMax_vote_company_fein le,BestFeinMax_vote_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinMax_vote_company_fein,BestFeinMax_vote_company_fein, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT27.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinMax_fuzz_company_fein,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT27.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestFeinMax_method_company_fein := o;
//Create those fields with BestType: BestUrlCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlCommon_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlCommon_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT27.StrType)company_url),source_for_votes)),{Proxid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCommon_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_url using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestUrlCommon_tab_company_url.Proxid;
  BestUrlCommon_tab_company_url.company_url;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestUrlCommon_tab_company_url le,BestUrlCommon_tab_company_url ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestUrlCommon_tab_company_url,BestUrlCommon_tab_company_url, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_url = (TYPEOF(LEFT.company_url))'' OR RIGHT.company_url = (TYPEOF(RIGHT.company_url))'' OR SALT27.WithinEditN(LEFT.company_url,RIGHT.company_url,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCommon_fuzz_company_url := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestUrlCommon_fuzz_company_url,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestUrlCommon_method_company_url := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestUrlCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlCurrent_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_url,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlCurrent_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT27.StrType)company_url),source_for_votes)),{Proxid,source_for_votes,data_permits,company_url,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCurrent_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for company_url using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestUrlCurrent_tab_company_url.Proxid;
  BestUrlCurrent_tab_company_url.company_url;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestUrlCurrent_tab_company_url le,BestUrlCurrent_tab_company_url ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestUrlCurrent_tab_company_url,BestUrlCurrent_tab_company_url, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_url = (TYPEOF(LEFT.company_url))'' OR RIGHT.company_url = (TYPEOF(RIGHT.company_url))'' OR SALT27.WithinEditN(LEFT.company_url,RIGHT.company_url,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCurrent_fuzz_company_url := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestUrlCurrent_method_company_url := DEDUP( SORT( BestUrlCurrent_fuzz_company_url(Late_Date>0,Early_Date<99999999),Proxid,-Late_Date,-Early_Date,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestUrlLength
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlLength_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlLength_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT27.StrType)company_url),source_for_votes)),{Proxid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlLength_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_url using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestUrlLength_tab_company_url.Proxid;
  BestUrlLength_tab_company_url.company_url;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestUrlLength_tab_company_url le,BestUrlLength_tab_company_url ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestUrlLength_tab_company_url,BestUrlLength_tab_company_url, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_url = (TYPEOF(LEFT.company_url))'' OR RIGHT.company_url = (TYPEOF(RIGHT.company_url))'' OR SALT27.WithinEditN(LEFT.company_url,RIGHT.company_url,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlLength_fuzz_company_url := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestUrlLength_method_company_url := DEDUP( SORT( BestUrlLength_fuzz_company_url,Proxid,-LENGTH(TRIM((SALT27.StrType)company_url)),-Row_Cnt,LOCAL),Proxid,LOCAL);
//Create those fields with BestType: BestUrlStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlStrong_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlStrong_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT27.StrType)company_url),source_for_votes)),{Proxid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlStrong_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_url using defined fuzzy logic 
Fuzzy_layout := RECORD
  BestUrlStrong_tab_company_url.Proxid;
  BestUrlStrong_tab_company_url.company_url;
  UNSIGNED1 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestUrlStrong_tab_company_url le,BestUrlStrong_tab_company_url ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestUrlStrong_tab_company_url,BestUrlStrong_tab_company_url, LEFT.Proxid = RIGHT.Proxid  AND ( LEFT.company_url = (TYPEOF(LEFT.company_url))'' OR RIGHT.company_url = (TYPEOF(RIGHT.company_url))'' OR SALT27.WithinEditN(LEFT.company_url,RIGHT.company_url,1)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlStrong_fuzz_company_url := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestUrlStrong_fuzz_company_url,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(grp,{Proxid,Tot := SUM(GROUP,Orig_Row_Cnt)},Proxid);
export BestUrlStrong_method_company_url := JOIN( cmn,Totals,left.Proxid = right.Proxid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestUrlVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Proxid <> 0),{Proxid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Proxid,source_for_votes,data_permits,company_url,MERGE),HASH(Proxid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlVotedUnrestricted_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT27.StrType)company_url),source_for_votes)),{Proxid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlVotedUnrestricted_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestUrlVotedUnrestricted_tab_company_url,{Proxid,data_permits,company_url,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlVotedUnrestricted_vote_company_url := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestUrlVotedUnrestricted_vote_company_url,Proxid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT27.MAC_Apply_Threshold(srt,200,o);
EXPORT BestUrlVotedUnrestricted_method_company_url := o;
// Start to gather together all records with basis:Proxid,source_for_votes,data_permits
// 0 - Gathering type:BestCompanyNameCommon Entries:1
  R0 := RECORD
    typeof(BestCompanyNameCommon_method_company_name.Proxid) Proxid; // Need to copy in basis
    TYPEOF(BestCompanyNameCommon_method_company_name.company_name) BestCompanyNameCommon_company_name;
    UNSIGNED company_name_BestCompanyNameCommon_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameCommon_Orig_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameCommon_data_permits;
  END;
  R0 T0(BestCompanyNameCommon_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCommon_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameCommon_data_permits := ri.data_permits;
    SELF := ri;
  END;
  J0 := PROJECT(BestCompanyNameCommon_method_company_name,T0(left));
// 1 - Gathering type:BestCompanyNameCurrent Entries:1
  R1 := RECORD
    J0; // The data so far
    TYPEOF(BestCompanyNameCurrent_method_company_name.company_name) BestCompanyNameCurrent_company_name;
    UNSIGNED company_name_BestCompanyNameCurrent_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameCurrent_Orig_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameCurrent_data_permits;
  END;
  R1 T1(J0 le,BestCompanyNameCurrent_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCurrent_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J1 := JOIN(J0,BestCompanyNameCurrent_method_company_name,LEFT.Proxid = RIGHT.Proxid,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
// 2 - Gathering type:BestCompanyNameVoted Entries:1
  R2 := RECORD
    J1; // The data so far
    TYPEOF(BestCompanyNameVoted_method_company_name.company_name) BestCompanyNameVoted_company_name;
    UNSIGNED company_name_BestCompanyNameVoted_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameVoted_data_permits;
  END;
  R2 T2(J1 le,BestCompanyNameVoted_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameVoted_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameVoted_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameVoted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J2 := JOIN(J1,BestCompanyNameVoted_method_company_name,LEFT.Proxid = RIGHT.Proxid,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
// 3 - Gathering type:BestCompanyNameLength Entries:1
  R3 := RECORD
    J2; // The data so far
    TYPEOF(BestCompanyNameLength_method_company_name.company_name) BestCompanyNameLength_company_name;
    UNSIGNED company_name_BestCompanyNameLength_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameLength_Orig_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameLength_data_permits;
  END;
  R3 T3(J2 le,BestCompanyNameLength_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameLength_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameLength_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameLength_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameLength_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J3 := JOIN(J2,BestCompanyNameLength_method_company_name,LEFT.Proxid = RIGHT.Proxid,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
// 4 - Gathering type:BestCompanyNameStrong Entries:1
  R4 := RECORD
    J3; // The data so far
    TYPEOF(BestCompanyNameStrong_method_company_name.company_name) BestCompanyNameStrong_company_name;
    UNSIGNED company_name_BestCompanyNameStrong_Row_Cnt;
    UNSIGNED company_name_BestCompanyNameStrong_Orig_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameStrong_data_permits;
  END;
  R4 T4(J3 le,BestCompanyNameStrong_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameStrong_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_name_BestCompanyNameStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J4 := JOIN(J3,BestCompanyNameStrong_method_company_name,LEFT.Proxid = RIGHT.Proxid,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
// 5 - Gathering type:BestCompanyNameCurrent2 Entries:1
  R5 := RECORD
    J4; // The data so far
    TYPEOF(BestCompanyNameCurrent2_method_company_name.company_name) BestCompanyNameCurrent2_company_name;
    UNSIGNED company_name_BestCompanyNameCurrent2_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameCurrent2_data_permits;
  END;
  R5 T5(J4 le,BestCompanyNameCurrent2_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCurrent2_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCurrent2_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent2_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J5 := JOIN(J4,BestCompanyNameCurrent2_method_company_name,LEFT.Proxid = RIGHT.Proxid,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
// 6 - Gathering type:BestCompanyNameVotedUnrestricted Entries:1
  R6 := RECORD
    J5; // The data so far
    TYPEOF(BestCompanyNameVotedUnrestricted_method_company_name.company_name) BestCompanyNameVotedUnrestricted_company_name;
    UNSIGNED company_name_BestCompanyNameVotedUnrestricted_Row_Cnt;
    UNSIGNED1 company_name_BestCompanyNameVotedUnrestricted_data_permits;
  END;
  R6 T6(J5 le,BestCompanyNameVotedUnrestricted_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameVotedUnrestricted_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J6 := JOIN(J5,BestCompanyNameVotedUnrestricted_method_company_name,LEFT.Proxid = RIGHT.Proxid,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
// 7 - Gathering type:BestCompanyAddressVoted Entries:1
  R7 := RECORD
    J6; // The data so far
    TYPEOF(BestCompanyAddressVoted_method_address.prim_range) BestCompanyAddressVoted_address_prim_range;
    TYPEOF(BestCompanyAddressVoted_method_address.predir) BestCompanyAddressVoted_address_predir;
    TYPEOF(BestCompanyAddressVoted_method_address.prim_name) BestCompanyAddressVoted_address_prim_name;
    TYPEOF(BestCompanyAddressVoted_method_address.addr_suffix) BestCompanyAddressVoted_address_addr_suffix;
    TYPEOF(BestCompanyAddressVoted_method_address.postdir) BestCompanyAddressVoted_address_postdir;
    TYPEOF(BestCompanyAddressVoted_method_address.unit_desig) BestCompanyAddressVoted_address_unit_desig;
    TYPEOF(BestCompanyAddressVoted_method_address.sec_range) BestCompanyAddressVoted_address_sec_range;
    TYPEOF(BestCompanyAddressVoted_method_address.st) BestCompanyAddressVoted_address_st;
    TYPEOF(BestCompanyAddressVoted_method_address.zip) BestCompanyAddressVoted_address_zip;
    UNSIGNED address_BestCompanyAddressVoted_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressVoted_data_permits;
  END;
  R7 T7(J6 le,BestCompanyAddressVoted_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressVoted_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressVoted_address_predir := ri.predir;
    SELF.BestCompanyAddressVoted_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressVoted_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressVoted_address_postdir := ri.postdir;
    SELF.BestCompanyAddressVoted_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressVoted_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressVoted_address_st := ri.st;
    SELF.BestCompanyAddressVoted_address_zip := ri.zip;
    SELF.address_BestCompanyAddressVoted_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressVoted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J7 := JOIN(J6,BestCompanyAddressVoted_method_address,LEFT.Proxid = RIGHT.Proxid,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
// 8 - Gathering type:BestCompanyAddressCurrent Entries:1
  R8 := RECORD
    J7; // The data so far
    TYPEOF(BestCompanyAddressCurrent_method_address.prim_range) BestCompanyAddressCurrent_address_prim_range;
    TYPEOF(BestCompanyAddressCurrent_method_address.predir) BestCompanyAddressCurrent_address_predir;
    TYPEOF(BestCompanyAddressCurrent_method_address.prim_name) BestCompanyAddressCurrent_address_prim_name;
    TYPEOF(BestCompanyAddressCurrent_method_address.addr_suffix) BestCompanyAddressCurrent_address_addr_suffix;
    TYPEOF(BestCompanyAddressCurrent_method_address.postdir) BestCompanyAddressCurrent_address_postdir;
    TYPEOF(BestCompanyAddressCurrent_method_address.unit_desig) BestCompanyAddressCurrent_address_unit_desig;
    TYPEOF(BestCompanyAddressCurrent_method_address.sec_range) BestCompanyAddressCurrent_address_sec_range;
    TYPEOF(BestCompanyAddressCurrent_method_address.st) BestCompanyAddressCurrent_address_st;
    TYPEOF(BestCompanyAddressCurrent_method_address.zip) BestCompanyAddressCurrent_address_zip;
    UNSIGNED address_BestCompanyAddressCurrent_Row_Cnt;
    UNSIGNED address_BestCompanyAddressCurrent_Orig_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressCurrent_data_permits;
  END;
  R8 T8(J7 le,BestCompanyAddressCurrent_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressCurrent_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressCurrent_address_predir := ri.predir;
    SELF.BestCompanyAddressCurrent_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressCurrent_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressCurrent_address_postdir := ri.postdir;
    SELF.BestCompanyAddressCurrent_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressCurrent_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressCurrent_address_st := ri.st;
    SELF.BestCompanyAddressCurrent_address_zip := ri.zip;
    SELF.address_BestCompanyAddressCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.address_BestCompanyAddressCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J8 := JOIN(J7,BestCompanyAddressCurrent_method_address,LEFT.Proxid = RIGHT.Proxid,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
// 9 - Gathering type:BestCompanyAddressVotedSrc Entries:1
  R9 := RECORD
    J8; // The data so far
    TYPEOF(BestCompanyAddressVotedSrc_method_address.prim_range) BestCompanyAddressVotedSrc_address_prim_range;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.predir) BestCompanyAddressVotedSrc_address_predir;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.prim_name) BestCompanyAddressVotedSrc_address_prim_name;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.addr_suffix) BestCompanyAddressVotedSrc_address_addr_suffix;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.postdir) BestCompanyAddressVotedSrc_address_postdir;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.unit_desig) BestCompanyAddressVotedSrc_address_unit_desig;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.sec_range) BestCompanyAddressVotedSrc_address_sec_range;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.st) BestCompanyAddressVotedSrc_address_st;
    TYPEOF(BestCompanyAddressVotedSrc_method_address.zip) BestCompanyAddressVotedSrc_address_zip;
    UNSIGNED address_BestCompanyAddressVotedSrc_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressVotedSrc_data_permits;
  END;
  R9 T9(J8 le,BestCompanyAddressVotedSrc_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressVotedSrc_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressVotedSrc_address_predir := ri.predir;
    SELF.BestCompanyAddressVotedSrc_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressVotedSrc_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressVotedSrc_address_postdir := ri.postdir;
    SELF.BestCompanyAddressVotedSrc_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressVotedSrc_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressVotedSrc_address_st := ri.st;
    SELF.BestCompanyAddressVotedSrc_address_zip := ri.zip;
    SELF.address_BestCompanyAddressVotedSrc_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressVotedSrc_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J9 := JOIN(J8,BestCompanyAddressVotedSrc_method_address,LEFT.Proxid = RIGHT.Proxid,T9(LEFT,RIGHT),FULL OUTER,LOCAL);
// 10 - Gathering type:BestCompanyAddressCommon Entries:1
  R10 := RECORD
    J9; // The data so far
    TYPEOF(BestCompanyAddressCommon_method_address.prim_range) BestCompanyAddressCommon_address_prim_range;
    TYPEOF(BestCompanyAddressCommon_method_address.predir) BestCompanyAddressCommon_address_predir;
    TYPEOF(BestCompanyAddressCommon_method_address.prim_name) BestCompanyAddressCommon_address_prim_name;
    TYPEOF(BestCompanyAddressCommon_method_address.addr_suffix) BestCompanyAddressCommon_address_addr_suffix;
    TYPEOF(BestCompanyAddressCommon_method_address.postdir) BestCompanyAddressCommon_address_postdir;
    TYPEOF(BestCompanyAddressCommon_method_address.unit_desig) BestCompanyAddressCommon_address_unit_desig;
    TYPEOF(BestCompanyAddressCommon_method_address.sec_range) BestCompanyAddressCommon_address_sec_range;
    TYPEOF(BestCompanyAddressCommon_method_address.st) BestCompanyAddressCommon_address_st;
    TYPEOF(BestCompanyAddressCommon_method_address.zip) BestCompanyAddressCommon_address_zip;
    UNSIGNED address_BestCompanyAddressCommon_Row_Cnt;
    UNSIGNED address_BestCompanyAddressCommon_Orig_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressCommon_data_permits;
  END;
  R10 T10(J9 le,BestCompanyAddressCommon_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressCommon_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressCommon_address_predir := ri.predir;
    SELF.BestCompanyAddressCommon_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressCommon_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressCommon_address_postdir := ri.postdir;
    SELF.BestCompanyAddressCommon_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressCommon_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressCommon_address_st := ri.st;
    SELF.BestCompanyAddressCommon_address_zip := ri.zip;
    SELF.address_BestCompanyAddressCommon_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.address_BestCompanyAddressCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J10 := JOIN(J9,BestCompanyAddressCommon_method_address,LEFT.Proxid = RIGHT.Proxid,T10(LEFT,RIGHT),FULL OUTER,LOCAL);
// 11 - Gathering type:BestCompanyAddressStrong Entries:1
  R11 := RECORD
    J10; // The data so far
    TYPEOF(BestCompanyAddressStrong_method_address.prim_range) BestCompanyAddressStrong_address_prim_range;
    TYPEOF(BestCompanyAddressStrong_method_address.predir) BestCompanyAddressStrong_address_predir;
    TYPEOF(BestCompanyAddressStrong_method_address.prim_name) BestCompanyAddressStrong_address_prim_name;
    TYPEOF(BestCompanyAddressStrong_method_address.addr_suffix) BestCompanyAddressStrong_address_addr_suffix;
    TYPEOF(BestCompanyAddressStrong_method_address.postdir) BestCompanyAddressStrong_address_postdir;
    TYPEOF(BestCompanyAddressStrong_method_address.unit_desig) BestCompanyAddressStrong_address_unit_desig;
    TYPEOF(BestCompanyAddressStrong_method_address.sec_range) BestCompanyAddressStrong_address_sec_range;
    TYPEOF(BestCompanyAddressStrong_method_address.st) BestCompanyAddressStrong_address_st;
    TYPEOF(BestCompanyAddressStrong_method_address.zip) BestCompanyAddressStrong_address_zip;
    UNSIGNED address_BestCompanyAddressStrong_Row_Cnt;
    UNSIGNED address_BestCompanyAddressStrong_Orig_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressStrong_data_permits;
  END;
  R11 T11(J10 le,BestCompanyAddressStrong_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressStrong_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressStrong_address_predir := ri.predir;
    SELF.BestCompanyAddressStrong_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressStrong_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressStrong_address_postdir := ri.postdir;
    SELF.BestCompanyAddressStrong_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressStrong_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressStrong_address_st := ri.st;
    SELF.BestCompanyAddressStrong_address_zip := ri.zip;
    SELF.address_BestCompanyAddressStrong_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.address_BestCompanyAddressStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J11 := JOIN(J10,BestCompanyAddressStrong_method_address,LEFT.Proxid = RIGHT.Proxid,T11(LEFT,RIGHT),FULL OUTER,LOCAL);
// 12 - Gathering type:BestCompanyAddressCurrent2 Entries:1
  R12 := RECORD
    J11; // The data so far
    TYPEOF(BestCompanyAddressCurrent2_method_address.prim_range) BestCompanyAddressCurrent2_address_prim_range;
    TYPEOF(BestCompanyAddressCurrent2_method_address.predir) BestCompanyAddressCurrent2_address_predir;
    TYPEOF(BestCompanyAddressCurrent2_method_address.prim_name) BestCompanyAddressCurrent2_address_prim_name;
    TYPEOF(BestCompanyAddressCurrent2_method_address.addr_suffix) BestCompanyAddressCurrent2_address_addr_suffix;
    TYPEOF(BestCompanyAddressCurrent2_method_address.postdir) BestCompanyAddressCurrent2_address_postdir;
    TYPEOF(BestCompanyAddressCurrent2_method_address.unit_desig) BestCompanyAddressCurrent2_address_unit_desig;
    TYPEOF(BestCompanyAddressCurrent2_method_address.sec_range) BestCompanyAddressCurrent2_address_sec_range;
    TYPEOF(BestCompanyAddressCurrent2_method_address.st) BestCompanyAddressCurrent2_address_st;
    TYPEOF(BestCompanyAddressCurrent2_method_address.zip) BestCompanyAddressCurrent2_address_zip;
    UNSIGNED address_BestCompanyAddressCurrent2_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressCurrent2_data_permits;
  END;
  R12 T12(J11 le,BestCompanyAddressCurrent2_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressCurrent2_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressCurrent2_address_predir := ri.predir;
    SELF.BestCompanyAddressCurrent2_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressCurrent2_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressCurrent2_address_postdir := ri.postdir;
    SELF.BestCompanyAddressCurrent2_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressCurrent2_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressCurrent2_address_st := ri.st;
    SELF.BestCompanyAddressCurrent2_address_zip := ri.zip;
    SELF.address_BestCompanyAddressCurrent2_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressCurrent2_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J12 := JOIN(J11,BestCompanyAddressCurrent2_method_address,LEFT.Proxid = RIGHT.Proxid,T12(LEFT,RIGHT),FULL OUTER,LOCAL);
// 13 - Gathering type:BestCompanyAddressVotedUnrestricted Entries:1
  R13 := RECORD
    J12; // The data so far
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.prim_range) BestCompanyAddressVotedUnrestricted_address_prim_range;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.predir) BestCompanyAddressVotedUnrestricted_address_predir;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.prim_name) BestCompanyAddressVotedUnrestricted_address_prim_name;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.addr_suffix) BestCompanyAddressVotedUnrestricted_address_addr_suffix;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.postdir) BestCompanyAddressVotedUnrestricted_address_postdir;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.unit_desig) BestCompanyAddressVotedUnrestricted_address_unit_desig;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.sec_range) BestCompanyAddressVotedUnrestricted_address_sec_range;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.st) BestCompanyAddressVotedUnrestricted_address_st;
    TYPEOF(BestCompanyAddressVotedUnrestricted_method_address.zip) BestCompanyAddressVotedUnrestricted_address_zip;
    UNSIGNED address_BestCompanyAddressVotedUnrestricted_Row_Cnt;
    UNSIGNED address_BestCompanyAddressVotedUnrestricted_Orig_Row_Cnt;
    UNSIGNED1 address_BestCompanyAddressVotedUnrestricted_data_permits;
  END;
  R13 T13(J12 le,BestCompanyAddressVotedUnrestricted_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressVotedUnrestricted_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressVotedUnrestricted_address_predir := ri.predir;
    SELF.BestCompanyAddressVotedUnrestricted_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressVotedUnrestricted_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressVotedUnrestricted_address_postdir := ri.postdir;
    SELF.BestCompanyAddressVotedUnrestricted_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressVotedUnrestricted_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressVotedUnrestricted_address_st := ri.st;
    SELF.BestCompanyAddressVotedUnrestricted_address_zip := ri.zip;
    SELF.address_BestCompanyAddressVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressVotedUnrestricted_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.address_BestCompanyAddressVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J13 := JOIN(J12,BestCompanyAddressVotedUnrestricted_method_address,LEFT.Proxid = RIGHT.Proxid,T13(LEFT,RIGHT),FULL OUTER,LOCAL);
// 14 - Gathering type:BestPhoneCurrentWithNpa Entries:1
  R14 := RECORD
    J13; // The data so far
    TYPEOF(BestPhoneCurrentWithNpa_method_company_phone.company_phone) BestPhoneCurrentWithNpa_company_phone;
    UNSIGNED company_phone_BestPhoneCurrentWithNpa_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneCurrentWithNpa_data_permits;
  END;
  R14 T14(J13 le,BestPhoneCurrentWithNpa_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCurrentWithNpa_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCurrentWithNpa_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCurrentWithNpa_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J14 := JOIN(J13,BestPhoneCurrentWithNpa_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T14(LEFT,RIGHT),FULL OUTER,LOCAL);
// 15 - Gathering type:BestPhoneCurrent Entries:1
  R15 := RECORD
    J14; // The data so far
    TYPEOF(BestPhoneCurrent_method_company_phone.company_phone) BestPhoneCurrent_company_phone;
    UNSIGNED company_phone_BestPhoneCurrent_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCurrent_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneCurrent_data_permits;
  END;
  R15 T15(J14 le,BestPhoneCurrent_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCurrent_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J15 := JOIN(J14,BestPhoneCurrent_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T15(LEFT,RIGHT),FULL OUTER,LOCAL);
// 16 - Gathering type:BestPhoneVoted Entries:1
  R16 := RECORD
    J15; // The data so far
    TYPEOF(BestPhoneVoted_method_company_phone.company_phone) BestPhoneVoted_company_phone;
    UNSIGNED company_phone_BestPhoneVoted_Row_Cnt;
    UNSIGNED company_phone_BestPhoneVoted_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneVoted_data_permits;
  END;
  R16 T16(J15 le,BestPhoneVoted_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneVoted_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneVoted_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneVoted_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneVoted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J16 := JOIN(J15,BestPhoneVoted_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T16(LEFT,RIGHT),FULL OUTER,LOCAL);
// 17 - Gathering type:BestPhoneLongest Entries:1
  R17 := RECORD
    J16; // The data so far
    TYPEOF(BestPhoneLongest_method_company_phone.company_phone) BestPhoneLongest_company_phone;
    UNSIGNED company_phone_BestPhoneLongest_Row_Cnt;
    UNSIGNED company_phone_BestPhoneLongest_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneLongest_data_permits;
  END;
  R17 T17(J16 le,BestPhoneLongest_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneLongest_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneLongest_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneLongest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneLongest_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J17 := JOIN(J16,BestPhoneLongest_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T17(LEFT,RIGHT),FULL OUTER,LOCAL);
// 18 - Gathering type:BestPhoneStrong Entries:1
  R18 := RECORD
    J17; // The data so far
    TYPEOF(BestPhoneStrong_method_company_phone.company_phone) BestPhoneStrong_company_phone;
    UNSIGNED company_phone_BestPhoneStrong_Row_Cnt;
    UNSIGNED company_phone_BestPhoneStrong_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneStrong_data_permits;
  END;
  R18 T18(J17 le,BestPhoneStrong_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneStrong_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J18 := JOIN(J17,BestPhoneStrong_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T18(LEFT,RIGHT),FULL OUTER,LOCAL);
// 19 - Gathering type:BestPhoneVotedUnrestricted Entries:1
  R19 := RECORD
    J18; // The data so far
    TYPEOF(BestPhoneVotedUnrestricted_method_company_phone.company_phone) BestPhoneVotedUnrestricted_company_phone;
    UNSIGNED company_phone_BestPhoneVotedUnrestricted_Row_Cnt;
    UNSIGNED company_phone_BestPhoneVotedUnrestricted_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneVotedUnrestricted_data_permits;
  END;
  R19 T19(J18 le,BestPhoneVotedUnrestricted_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneVotedUnrestricted_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneVotedUnrestricted_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J19 := JOIN(J18,BestPhoneVotedUnrestricted_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T19(LEFT,RIGHT),FULL OUTER,LOCAL);
// 20 - Gathering type:BestPhoneCommon Entries:1
  R20 := RECORD
    J19; // The data so far
    TYPEOF(BestPhoneCommon_method_company_phone.company_phone) BestPhoneCommon_company_phone;
    UNSIGNED company_phone_BestPhoneCommon_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCommon_Orig_Row_Cnt;
    UNSIGNED1 company_phone_BestPhoneCommon_data_permits;
  END;
  R20 T20(J19 le,BestPhoneCommon_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCommon_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J20 := JOIN(J19,BestPhoneCommon_method_company_phone,LEFT.Proxid = RIGHT.Proxid,T20(LEFT,RIGHT),FULL OUTER,LOCAL);
// 21 - Gathering type:BestFeinStrong Entries:1
  R21 := RECORD
    J20; // The data so far
    TYPEOF(BestFeinStrong_method_company_fein.company_fein) BestFeinStrong_company_fein;
    UNSIGNED company_fein_BestFeinStrong_Row_Cnt;
    UNSIGNED company_fein_BestFeinStrong_Orig_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinStrong_data_permits;
  END;
  R21 T21(J20 le,BestFeinStrong_method_company_fein ri) := TRANSFORM
    SELF.BestFeinStrong_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J21 := JOIN(J20,BestFeinStrong_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T21(LEFT,RIGHT),FULL OUTER,LOCAL);
// 22 - Gathering type:BestFeinCommon Entries:1
  R22 := RECORD
    J21; // The data so far
    TYPEOF(BestFeinCommon_method_company_fein.company_fein) BestFeinCommon_company_fein;
    UNSIGNED company_fein_BestFeinCommon_Row_Cnt;
    UNSIGNED company_fein_BestFeinCommon_Orig_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinCommon_data_permits;
  END;
  R22 T22(J21 le,BestFeinCommon_method_company_fein ri) := TRANSFORM
    SELF.BestFeinCommon_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J22 := JOIN(J21,BestFeinCommon_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T22(LEFT,RIGHT),FULL OUTER,LOCAL);
// 23 - Gathering type:BestFeinCurrent Entries:1
  R23 := RECORD
    J22; // The data so far
    TYPEOF(BestFeinCurrent_method_company_fein.company_fein) BestFeinCurrent_company_fein;
    UNSIGNED company_fein_BestFeinCurrent_Row_Cnt;
    UNSIGNED company_fein_BestFeinCurrent_Orig_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinCurrent_data_permits;
  END;
  R23 T23(J22 le,BestFeinCurrent_method_company_fein ri) := TRANSFORM
    SELF.BestFeinCurrent_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J23 := JOIN(J22,BestFeinCurrent_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T23(LEFT,RIGHT),FULL OUTER,LOCAL);
// 24 - Gathering type:BestFeinVotedUnrestricted Entries:1
  R24 := RECORD
    J23; // The data so far
    TYPEOF(BestFeinVotedUnrestricted_method_company_fein.company_fein) BestFeinVotedUnrestricted_company_fein;
    UNSIGNED company_fein_BestFeinVotedUnrestricted_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinVotedUnrestricted_data_permits;
  END;
  R24 T24(J23 le,BestFeinVotedUnrestricted_method_company_fein ri) := TRANSFORM
    SELF.BestFeinVotedUnrestricted_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J24 := JOIN(J23,BestFeinVotedUnrestricted_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T24(LEFT,RIGHT),FULL OUTER,LOCAL);
// 25 - Gathering type:BestFeinMin Entries:1
  R25 := RECORD
    J24; // The data so far
    TYPEOF(BestFeinMin_method_company_fein.company_fein) BestFeinMin_company_fein;
    UNSIGNED company_fein_BestFeinMin_Row_Cnt;
    UNSIGNED company_fein_BestFeinMin_Orig_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinMin_data_permits;
  END;
  R25 T25(J24 le,BestFeinMin_method_company_fein ri) := TRANSFORM
    SELF.BestFeinMin_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinMin_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinMin_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinMin_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J25 := JOIN(J24,BestFeinMin_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T25(LEFT,RIGHT),FULL OUTER,LOCAL);
// 26 - Gathering type:BestFeinMax Entries:1
  R26 := RECORD
    J25; // The data so far
    TYPEOF(BestFeinMax_method_company_fein.company_fein) BestFeinMax_company_fein;
    UNSIGNED company_fein_BestFeinMax_Row_Cnt;
    UNSIGNED company_fein_BestFeinMax_Orig_Row_Cnt;
    UNSIGNED1 company_fein_BestFeinMax_data_permits;
  END;
  R26 T26(J25 le,BestFeinMax_method_company_fein ri) := TRANSFORM
    SELF.BestFeinMax_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinMax_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinMax_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinMax_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J26 := JOIN(J25,BestFeinMax_method_company_fein,LEFT.Proxid = RIGHT.Proxid,T26(LEFT,RIGHT),FULL OUTER,LOCAL);
// 27 - Gathering type:BestUrlCommon Entries:1
  R27 := RECORD
    J26; // The data so far
    TYPEOF(BestUrlCommon_method_company_url.company_url) BestUrlCommon_company_url;
    UNSIGNED company_url_BestUrlCommon_Row_Cnt;
    UNSIGNED company_url_BestUrlCommon_Orig_Row_Cnt;
    UNSIGNED1 company_url_BestUrlCommon_data_permits;
  END;
  R27 T27(J26 le,BestUrlCommon_method_company_url ri) := TRANSFORM
    SELF.BestUrlCommon_company_url := ri.company_url;
    SELF.company_url_BestUrlCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_url_BestUrlCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J27 := JOIN(J26,BestUrlCommon_method_company_url,LEFT.Proxid = RIGHT.Proxid,T27(LEFT,RIGHT),FULL OUTER,LOCAL);
// 28 - Gathering type:BestUrlCurrent Entries:1
  R28 := RECORD
    J27; // The data so far
    TYPEOF(BestUrlCurrent_method_company_url.company_url) BestUrlCurrent_company_url;
    UNSIGNED company_url_BestUrlCurrent_Row_Cnt;
    UNSIGNED company_url_BestUrlCurrent_Orig_Row_Cnt;
    UNSIGNED1 company_url_BestUrlCurrent_data_permits;
  END;
  R28 T28(J27 le,BestUrlCurrent_method_company_url ri) := TRANSFORM
    SELF.BestUrlCurrent_company_url := ri.company_url;
    SELF.company_url_BestUrlCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_url_BestUrlCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J28 := JOIN(J27,BestUrlCurrent_method_company_url,LEFT.Proxid = RIGHT.Proxid,T28(LEFT,RIGHT),FULL OUTER,LOCAL);
// 29 - Gathering type:BestUrlLength Entries:1
  R29 := RECORD
    J28; // The data so far
    TYPEOF(BestUrlLength_method_company_url.company_url) BestUrlLength_company_url;
    UNSIGNED company_url_BestUrlLength_Row_Cnt;
    UNSIGNED company_url_BestUrlLength_Orig_Row_Cnt;
    UNSIGNED1 company_url_BestUrlLength_data_permits;
  END;
  R29 T29(J28 le,BestUrlLength_method_company_url ri) := TRANSFORM
    SELF.BestUrlLength_company_url := ri.company_url;
    SELF.company_url_BestUrlLength_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlLength_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_url_BestUrlLength_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J29 := JOIN(J28,BestUrlLength_method_company_url,LEFT.Proxid = RIGHT.Proxid,T29(LEFT,RIGHT),FULL OUTER,LOCAL);
// 30 - Gathering type:BestUrlStrong Entries:1
  R30 := RECORD
    J29; // The data so far
    TYPEOF(BestUrlStrong_method_company_url.company_url) BestUrlStrong_company_url;
    UNSIGNED company_url_BestUrlStrong_Row_Cnt;
    UNSIGNED company_url_BestUrlStrong_Orig_Row_Cnt;
    UNSIGNED1 company_url_BestUrlStrong_data_permits;
  END;
  R30 T30(J29 le,BestUrlStrong_method_company_url ri) := TRANSFORM
    SELF.BestUrlStrong_company_url := ri.company_url;
    SELF.company_url_BestUrlStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_url_BestUrlStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J30 := JOIN(J29,BestUrlStrong_method_company_url,LEFT.Proxid = RIGHT.Proxid,T30(LEFT,RIGHT),FULL OUTER,LOCAL);
// 31 - Gathering type:BestUrlVotedUnrestricted Entries:1
  R31 := RECORD
    J30; // The data so far
    TYPEOF(BestUrlVotedUnrestricted_method_company_url.company_url) BestUrlVotedUnrestricted_company_url;
    UNSIGNED company_url_BestUrlVotedUnrestricted_Row_Cnt;
    UNSIGNED1 company_url_BestUrlVotedUnrestricted_data_permits;
  END;
  R31 T31(J30 le,BestUrlVotedUnrestricted_method_company_url ri) := TRANSFORM
    SELF.BestUrlVotedUnrestricted_company_url := ri.company_url;
    SELF.company_url_BestUrlVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Proxid <> (TYPEOF(le.Proxid))''; // See if LHS is null
    SELF.Proxid := IF( has_left, le.Proxid, ri.Proxid );
    SELF := le;
  END;
  J31 := JOIN(J30,BestUrlVotedUnrestricted_method_company_url,LEFT.Proxid = RIGHT.Proxid,T31(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_Proxid_np := J31;
EXPORT BestBy_Proxid := BestBy_Proxid_np  : PERSIST('~temp::Proxid::BIPV2_Best_test6::BestBy_Proxid::best');
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 BestCompanyNameCommon_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameCommon_company_name=(typeof(BestBy_Proxid.BestCompanyNameCommon_company_name))'',0,100));
    UNSIGNED BestCompanyNameCommon_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&1<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&2<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&4<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&8<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCommon_data_permits&16<>0);
    REAL8 BestCompanyNameCurrent_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameCurrent_company_name=(typeof(BestBy_Proxid.BestCompanyNameCurrent_company_name))'',0,100));
    UNSIGNED BestCompanyNameCurrent_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent_data_permits&16<>0);
    REAL8 BestCompanyNameVoted_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameVoted_company_name=(typeof(BestBy_Proxid.BestCompanyNameVoted_company_name))'',0,100));
    UNSIGNED BestCompanyNameVoted_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVoted_data_permits&1<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVoted_data_permits&2<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVoted_data_permits&4<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVoted_data_permits&8<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVoted_data_permits&16<>0);
    REAL8 BestCompanyNameLength_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameLength_company_name=(typeof(BestBy_Proxid.BestCompanyNameLength_company_name))'',0,100));
    UNSIGNED BestCompanyNameLength_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&1<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&2<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&4<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&8<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameLength_data_permits&16<>0);
    REAL8 BestCompanyNameStrong_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameStrong_company_name=(typeof(BestBy_Proxid.BestCompanyNameStrong_company_name))'',0,100));
    UNSIGNED BestCompanyNameStrong_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameStrong_data_permits&1<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameStrong_data_permits&2<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameStrong_data_permits&4<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameStrong_data_permits&8<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameStrong_data_permits&16<>0);
    REAL8 BestCompanyNameCurrent2_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameCurrent2_company_name=(typeof(BestBy_Proxid.BestCompanyNameCurrent2_company_name))'',0,100));
    UNSIGNED BestCompanyNameCurrent2_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent2_data_permits&1<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent2_data_permits&2<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent2_data_permits&4<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent2_data_permits&8<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameCurrent2_data_permits&16<>0);
    REAL8 BestCompanyNameVotedUnrestricted_company_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyNameVotedUnrestricted_company_name=(typeof(BestBy_Proxid.BestCompanyNameVotedUnrestricted_company_name))'',0,100));
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_name_BestCompanyNameVotedUnrestricted_data_permits&16<>0);
    REAL8 BestCompanyAddressVoted_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVoted_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_predir))'',0,100));
    REAL8 BestCompanyAddressVoted_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVoted_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVoted_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVoted_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVoted_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVoted_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_st=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_st))'',0,100));
    REAL8 BestCompanyAddressVoted_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVoted_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressVoted_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVoted_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVoted_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVoted_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVoted_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVoted_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVoted_data_permits&16<>0);
    REAL8 BestCompanyAddressCurrent_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_predir))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_st=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_st))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressCurrent_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCurrent_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent_data_permits&16<>0);
    REAL8 BestCompanyAddressVotedSrc_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_predir))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_st=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_st))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedSrc_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressVotedSrc_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVotedSrc_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedSrc_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedSrc_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedSrc_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedSrc_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedSrc_data_permits&16<>0);
    REAL8 BestCompanyAddressCommon_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCommon_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_predir))'',0,100));
    REAL8 BestCompanyAddressCommon_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCommon_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCommon_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCommon_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCommon_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCommon_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_st=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_st))'',0,100));
    REAL8 BestCompanyAddressCommon_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCommon_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressCommon_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCommon_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCommon_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCommon_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCommon_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCommon_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCommon_data_permits&16<>0);
    REAL8 BestCompanyAddressStrong_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressStrong_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_predir))'',0,100));
    REAL8 BestCompanyAddressStrong_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressStrong_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressStrong_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_postdir))'',0,100));
    REAL8 BestCompanyAddressStrong_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressStrong_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressStrong_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_st=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_st))'',0,100));
    REAL8 BestCompanyAddressStrong_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressStrong_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressStrong_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressStrong_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressStrong_data_permits&1<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressStrong_data_permits&2<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressStrong_data_permits&4<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressStrong_data_permits&8<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressStrong_data_permits&16<>0);
    REAL8 BestCompanyAddressCurrent2_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_predir))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_st=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_st))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressCurrent2_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressCurrent2_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCurrent2_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent2_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent2_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent2_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent2_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressCurrent2_data_permits&16<>0);
    REAL8 BestCompanyAddressVotedUnrestricted_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_prim_range=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_predir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_predir=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_predir))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_prim_name=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_addr_suffix=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_postdir=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_unit_desig=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_sec_range=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_st_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_st=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_st))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_zip_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_zip=(typeof(BestBy_Proxid.BestCompanyAddressVotedUnrestricted_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit1_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit2_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit3_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit4_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit5_cnt := COUNT(GROUP,BestBy_Proxid.address_BestCompanyAddressVotedUnrestricted_data_permits&16<>0);
    REAL8 BestPhoneCurrentWithNpa_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneCurrentWithNpa_company_phone=(typeof(BestBy_Proxid.BestPhoneCurrentWithNpa_company_phone))'',0,100));
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrentWithNpa_data_permits&1<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrentWithNpa_data_permits&2<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrentWithNpa_data_permits&4<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrentWithNpa_data_permits&8<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrentWithNpa_data_permits&16<>0);
    REAL8 BestPhoneCurrent_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneCurrent_company_phone=(typeof(BestBy_Proxid.BestPhoneCurrent_company_phone))'',0,100));
    UNSIGNED BestPhoneCurrent_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&1<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&2<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&4<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&8<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCurrent_data_permits&16<>0);
    REAL8 BestPhoneVoted_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneVoted_company_phone=(typeof(BestBy_Proxid.BestPhoneVoted_company_phone))'',0,100));
    UNSIGNED BestPhoneVoted_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVoted_data_permits&1<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVoted_data_permits&2<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVoted_data_permits&4<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVoted_data_permits&8<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVoted_data_permits&16<>0);
    REAL8 BestPhoneLongest_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneLongest_company_phone=(typeof(BestBy_Proxid.BestPhoneLongest_company_phone))'',0,100));
    UNSIGNED BestPhoneLongest_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneLongest_data_permits&1<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneLongest_data_permits&2<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneLongest_data_permits&4<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneLongest_data_permits&8<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneLongest_data_permits&16<>0);
    REAL8 BestPhoneStrong_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneStrong_company_phone=(typeof(BestBy_Proxid.BestPhoneStrong_company_phone))'',0,100));
    UNSIGNED BestPhoneStrong_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&1<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&2<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&4<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&8<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneStrong_data_permits&16<>0);
    REAL8 BestPhoneVotedUnrestricted_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneVotedUnrestricted_company_phone=(typeof(BestBy_Proxid.BestPhoneVotedUnrestricted_company_phone))'',0,100));
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneVotedUnrestricted_data_permits&16<>0);
    REAL8 BestPhoneCommon_company_phone_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestPhoneCommon_company_phone=(typeof(BestBy_Proxid.BestPhoneCommon_company_phone))'',0,100));
    UNSIGNED BestPhoneCommon_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCommon_data_permits&1<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCommon_data_permits&2<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCommon_data_permits&4<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCommon_data_permits&8<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_phone_BestPhoneCommon_data_permits&16<>0);
    REAL8 BestFeinStrong_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinStrong_company_fein=(typeof(BestBy_Proxid.BestFeinStrong_company_fein))'',0,100));
    UNSIGNED BestFeinStrong_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&1<>0);
    UNSIGNED BestFeinStrong_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&2<>0);
    UNSIGNED BestFeinStrong_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&4<>0);
    UNSIGNED BestFeinStrong_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&8<>0);
    UNSIGNED BestFeinStrong_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinStrong_data_permits&16<>0);
    REAL8 BestFeinCommon_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinCommon_company_fein=(typeof(BestBy_Proxid.BestFeinCommon_company_fein))'',0,100));
    UNSIGNED BestFeinCommon_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&1<>0);
    UNSIGNED BestFeinCommon_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&2<>0);
    UNSIGNED BestFeinCommon_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&4<>0);
    UNSIGNED BestFeinCommon_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&8<>0);
    UNSIGNED BestFeinCommon_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCommon_data_permits&16<>0);
    REAL8 BestFeinCurrent_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinCurrent_company_fein=(typeof(BestBy_Proxid.BestFeinCurrent_company_fein))'',0,100));
    UNSIGNED BestFeinCurrent_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCurrent_data_permits&1<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCurrent_data_permits&2<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCurrent_data_permits&4<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCurrent_data_permits&8<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinCurrent_data_permits&16<>0);
    REAL8 BestFeinVotedUnrestricted_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinVotedUnrestricted_company_fein=(typeof(BestBy_Proxid.BestFeinVotedUnrestricted_company_fein))'',0,100));
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinVotedUnrestricted_data_permits&16<>0);
    REAL8 BestFeinMin_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinMin_company_fein=(typeof(BestBy_Proxid.BestFeinMin_company_fein))'',0,100));
    UNSIGNED BestFeinMin_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMin_data_permits&1<>0);
    UNSIGNED BestFeinMin_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMin_data_permits&2<>0);
    UNSIGNED BestFeinMin_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMin_data_permits&4<>0);
    UNSIGNED BestFeinMin_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMin_data_permits&8<>0);
    UNSIGNED BestFeinMin_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMin_data_permits&16<>0);
    REAL8 BestFeinMax_company_fein_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestFeinMax_company_fein=(typeof(BestBy_Proxid.BestFeinMax_company_fein))'',0,100));
    UNSIGNED BestFeinMax_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMax_data_permits&1<>0);
    UNSIGNED BestFeinMax_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMax_data_permits&2<>0);
    UNSIGNED BestFeinMax_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMax_data_permits&4<>0);
    UNSIGNED BestFeinMax_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMax_data_permits&8<>0);
    UNSIGNED BestFeinMax_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_fein_BestFeinMax_data_permits&16<>0);
    REAL8 BestUrlCommon_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlCommon_company_url=(typeof(BestBy_Proxid.BestUrlCommon_company_url))'',0,100));
    UNSIGNED BestUrlCommon_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&1<>0);
    UNSIGNED BestUrlCommon_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&2<>0);
    UNSIGNED BestUrlCommon_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&4<>0);
    UNSIGNED BestUrlCommon_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&8<>0);
    UNSIGNED BestUrlCommon_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCommon_data_permits&16<>0);
    REAL8 BestUrlCurrent_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlCurrent_company_url=(typeof(BestBy_Proxid.BestUrlCurrent_company_url))'',0,100));
    UNSIGNED BestUrlCurrent_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCurrent_data_permits&1<>0);
    UNSIGNED BestUrlCurrent_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCurrent_data_permits&2<>0);
    UNSIGNED BestUrlCurrent_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCurrent_data_permits&4<>0);
    UNSIGNED BestUrlCurrent_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCurrent_data_permits&8<>0);
    UNSIGNED BestUrlCurrent_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlCurrent_data_permits&16<>0);
    REAL8 BestUrlLength_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlLength_company_url=(typeof(BestBy_Proxid.BestUrlLength_company_url))'',0,100));
    UNSIGNED BestUrlLength_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlLength_data_permits&1<>0);
    UNSIGNED BestUrlLength_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlLength_data_permits&2<>0);
    UNSIGNED BestUrlLength_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlLength_data_permits&4<>0);
    UNSIGNED BestUrlLength_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlLength_data_permits&8<>0);
    UNSIGNED BestUrlLength_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlLength_data_permits&16<>0);
    REAL8 BestUrlStrong_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlStrong_company_url=(typeof(BestBy_Proxid.BestUrlStrong_company_url))'',0,100));
    UNSIGNED BestUrlStrong_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlStrong_data_permits&1<>0);
    UNSIGNED BestUrlStrong_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlStrong_data_permits&2<>0);
    UNSIGNED BestUrlStrong_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlStrong_data_permits&4<>0);
    UNSIGNED BestUrlStrong_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlStrong_data_permits&8<>0);
    UNSIGNED BestUrlStrong_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlStrong_data_permits&16<>0);
    REAL8 BestUrlVotedUnrestricted_company_url_pcnt := AVE(GROUP,IF(BestBy_Proxid.BestUrlVotedUnrestricted_company_url=(typeof(BestBy_Proxid.BestUrlVotedUnrestricted_company_url))'',0,100));
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit1_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit2_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit3_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit4_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit5_cnt := COUNT(GROUP,BestBy_Proxid.company_url_BestUrlVotedUnrestricted_data_permits&16<>0);
  END;
EXPORT BestBy_Proxid_population := TABLE(BestBy_Proxid,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_Proxid(DATASET({BestBy_Proxid}) d) := FUNCTION
  company_name_case_layout := RECORD
    TYPEOF(h.company_name) company_name;
    UNSIGNED1 company_name_data_permits;
    UNSIGNED1 company_name_method; // This value could come from multiple BESTTYPE; track which one
  END;
  address_case_layout := RECORD
    TYPEOF(h.prim_range) address_prim_range;
    TYPEOF(h.predir) address_predir;
    TYPEOF(h.prim_name) address_prim_name;
    TYPEOF(h.addr_suffix) address_addr_suffix;
    TYPEOF(h.postdir) address_postdir;
    TYPEOF(h.unit_desig) address_unit_desig;
    TYPEOF(h.sec_range) address_sec_range;
    TYPEOF(h.st) address_st;
    TYPEOF(h.zip) address_zip;
    UNSIGNED1 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_phone_case_layout := RECORD
    TYPEOF(h.company_phone) company_phone;
    UNSIGNED1 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_fein_case_layout := RECORD
    TYPEOF(h.company_fein) company_fein;
    UNSIGNED1 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
  END;
  company_url_case_layout := RECORD
    TYPEOF(h.company_url) company_url;
    UNSIGNED1 company_url_data_permits;
    UNSIGNED1 company_url_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R := RECORD
    typeof(h.Proxid) Proxid := 0;
    DATASET(company_name_case_layout) company_name_cases;
    DATASET(address_case_layout) address_cases;
    DATASET(company_phone_case_layout) company_phone_cases;
    DATASET(company_fein_case_layout) company_fein_cases;
    DATASET(company_url_case_layout) company_url_cases;
  END;
  R T(BestBy_Proxid le) := TRANSFORM
    SELF.company_name_cases := DATASET([
        {le.BestCompanyNameCommon_company_name,le.company_name_BestCompanyNameCommon_data_permits,1},
        {le.BestCompanyNameCurrent_company_name,le.company_name_BestCompanyNameCurrent_data_permits,2},
        {le.BestCompanyNameVoted_company_name,le.company_name_BestCompanyNameVoted_data_permits,3},
        {le.BestCompanyNameLength_company_name,le.company_name_BestCompanyNameLength_data_permits,4},
        {le.BestCompanyNameStrong_company_name,le.company_name_BestCompanyNameStrong_data_permits,5},
        {le.BestCompanyNameCurrent2_company_name,le.company_name_BestCompanyNameCurrent2_data_permits,6},
        {le.BestCompanyNameVotedUnrestricted_company_name,le.company_name_BestCompanyNameVotedUnrestricted_data_permits,7}
          ],company_name_case_layout)(company_name NOT IN SET(s.nulls_company_name,company_name));
    SELF.address_cases := DATASET([
        {le.BestCompanyAddressVoted_address_prim_range,le.BestCompanyAddressVoted_address_predir,le.BestCompanyAddressVoted_address_prim_name,le.BestCompanyAddressVoted_address_addr_suffix,le.BestCompanyAddressVoted_address_postdir,le.BestCompanyAddressVoted_address_unit_desig,le.BestCompanyAddressVoted_address_sec_range,le.BestCompanyAddressVoted_address_st,le.BestCompanyAddressVoted_address_zip,le.address_BestCompanyAddressVoted_data_permits,1},
        {le.BestCompanyAddressCurrent_address_prim_range,le.BestCompanyAddressCurrent_address_predir,le.BestCompanyAddressCurrent_address_prim_name,le.BestCompanyAddressCurrent_address_addr_suffix,le.BestCompanyAddressCurrent_address_postdir,le.BestCompanyAddressCurrent_address_unit_desig,le.BestCompanyAddressCurrent_address_sec_range,le.BestCompanyAddressCurrent_address_st,le.BestCompanyAddressCurrent_address_zip,le.address_BestCompanyAddressCurrent_data_permits,2},
        {le.BestCompanyAddressVotedSrc_address_prim_range,le.BestCompanyAddressVotedSrc_address_predir,le.BestCompanyAddressVotedSrc_address_prim_name,le.BestCompanyAddressVotedSrc_address_addr_suffix,le.BestCompanyAddressVotedSrc_address_postdir,le.BestCompanyAddressVotedSrc_address_unit_desig,le.BestCompanyAddressVotedSrc_address_sec_range,le.BestCompanyAddressVotedSrc_address_st,le.BestCompanyAddressVotedSrc_address_zip,le.address_BestCompanyAddressVotedSrc_data_permits,3},
        {le.BestCompanyAddressCommon_address_prim_range,le.BestCompanyAddressCommon_address_predir,le.BestCompanyAddressCommon_address_prim_name,le.BestCompanyAddressCommon_address_addr_suffix,le.BestCompanyAddressCommon_address_postdir,le.BestCompanyAddressCommon_address_unit_desig,le.BestCompanyAddressCommon_address_sec_range,le.BestCompanyAddressCommon_address_st,le.BestCompanyAddressCommon_address_zip,le.address_BestCompanyAddressCommon_data_permits,4},
        {le.BestCompanyAddressStrong_address_prim_range,le.BestCompanyAddressStrong_address_predir,le.BestCompanyAddressStrong_address_prim_name,le.BestCompanyAddressStrong_address_addr_suffix,le.BestCompanyAddressStrong_address_postdir,le.BestCompanyAddressStrong_address_unit_desig,le.BestCompanyAddressStrong_address_sec_range,le.BestCompanyAddressStrong_address_st,le.BestCompanyAddressStrong_address_zip,le.address_BestCompanyAddressStrong_data_permits,5},
        {le.BestCompanyAddressCurrent2_address_prim_range,le.BestCompanyAddressCurrent2_address_predir,le.BestCompanyAddressCurrent2_address_prim_name,le.BestCompanyAddressCurrent2_address_addr_suffix,le.BestCompanyAddressCurrent2_address_postdir,le.BestCompanyAddressCurrent2_address_unit_desig,le.BestCompanyAddressCurrent2_address_sec_range,le.BestCompanyAddressCurrent2_address_st,le.BestCompanyAddressCurrent2_address_zip,le.address_BestCompanyAddressCurrent2_data_permits,6},
        {le.BestCompanyAddressVotedUnrestricted_address_prim_range,le.BestCompanyAddressVotedUnrestricted_address_predir,le.BestCompanyAddressVotedUnrestricted_address_prim_name,le.BestCompanyAddressVotedUnrestricted_address_addr_suffix,le.BestCompanyAddressVotedUnrestricted_address_postdir,le.BestCompanyAddressVotedUnrestricted_address_unit_desig,le.BestCompanyAddressVotedUnrestricted_address_sec_range,le.BestCompanyAddressVotedUnrestricted_address_st,le.BestCompanyAddressVotedUnrestricted_address_zip,le.address_BestCompanyAddressVotedUnrestricted_data_permits,7}
          ],address_case_layout)(address_prim_range NOT IN SET(s.nulls_prim_range,prim_range) OR address_predir NOT IN SET(s.nulls_predir,predir) OR address_prim_name NOT IN SET(s.nulls_prim_name,prim_name) OR address_addr_suffix NOT IN SET(s.nulls_addr_suffix,addr_suffix) OR address_postdir NOT IN SET(s.nulls_postdir,postdir) OR address_unit_desig NOT IN SET(s.nulls_unit_desig,unit_desig) OR address_sec_range NOT IN SET(s.nulls_sec_range,sec_range) OR address_st NOT IN SET(s.nulls_st,st) OR address_zip NOT IN SET(s.nulls_zip,zip));
    SELF.company_phone_cases := DATASET([
        {le.BestPhoneCurrentWithNpa_company_phone,le.company_phone_BestPhoneCurrentWithNpa_data_permits,1},
        {le.BestPhoneCurrent_company_phone,le.company_phone_BestPhoneCurrent_data_permits,2},
        {le.BestPhoneVoted_company_phone,le.company_phone_BestPhoneVoted_data_permits,3},
        {le.BestPhoneLongest_company_phone,le.company_phone_BestPhoneLongest_data_permits,4},
        {le.BestPhoneStrong_company_phone,le.company_phone_BestPhoneStrong_data_permits,5},
        {le.BestPhoneVotedUnrestricted_company_phone,le.company_phone_BestPhoneVotedUnrestricted_data_permits,6},
        {le.BestPhoneCommon_company_phone,le.company_phone_BestPhoneCommon_data_permits,7}
          ],company_phone_case_layout)(company_phone NOT IN SET(s.nulls_company_phone,company_phone));
    SELF.company_fein_cases := DATASET([
        {le.BestFeinStrong_company_fein,le.company_fein_BestFeinStrong_data_permits,1,le.company_fein_BestFeinStrong_row_cnt,false},
        {le.BestFeinCommon_company_fein,le.company_fein_BestFeinCommon_data_permits,2,le.company_fein_BestFeinCommon_row_cnt,false},
        {le.BestFeinCurrent_company_fein,le.company_fein_BestFeinCurrent_data_permits,3,le.company_fein_BestFeinCurrent_row_cnt,false},
        {le.BestFeinVotedUnrestricted_company_fein,le.company_fein_BestFeinVotedUnrestricted_data_permits,4,le.company_fein_BestFeinVotedUnrestricted_row_cnt,false},
        {le.BestFeinMin_company_fein,le.company_fein_BestFeinMin_data_permits,5,le.company_fein_BestFeinMin_row_cnt,false},
        {le.BestFeinMax_company_fein,le.company_fein_BestFeinMax_data_permits,6,le.company_fein_BestFeinMax_row_cnt,false}
          ],company_fein_case_layout)(company_fein NOT IN SET(s.nulls_company_fein,company_fein));
    SELF.company_url_cases := DATASET([
        {le.BestUrlCommon_company_url,le.company_url_BestUrlCommon_data_permits,1},
        {le.BestUrlCurrent_company_url,le.company_url_BestUrlCurrent_data_permits,2},
        {le.BestUrlLength_company_url,le.company_url_BestUrlLength_data_permits,3},
        {le.BestUrlStrong_company_url,le.company_url_BestUrlStrong_data_permits,4},
        {le.BestUrlVotedUnrestricted_company_url,le.company_url_BestUrlVotedUnrestricted_data_permits,5}
          ],company_url_case_layout)(company_url NOT IN SET(s.nulls_company_url,company_url));
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_Proxid_child := F_BestBy_Proxid(BestBy_Proxid);
EXPORT BestBy_Proxid_child_np := F_BestBy_Proxid(BestBy_Proxid_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
SHARED Flatten_BestBy_Proxid(DATASET({BestBy_Proxid_child}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.Proxid) Proxid := 0;
    TYPEOF(h.company_name) company_name;
    UNSIGNED1 company_name_data_permits;
    UNSIGNED1 company_name_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.prim_range) address_prim_range;
    TYPEOF(h.predir) address_predir;
    TYPEOF(h.prim_name) address_prim_name;
    TYPEOF(h.addr_suffix) address_addr_suffix;
    TYPEOF(h.postdir) address_postdir;
    TYPEOF(h.unit_desig) address_unit_desig;
    TYPEOF(h.sec_range) address_sec_range;
    TYPEOF(h.st) address_st;
    TYPEOF(h.zip) address_zip;
    UNSIGNED1 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_phone) company_phone;
    UNSIGNED1 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_fein) company_fein;
    UNSIGNED1 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
    TYPEOF(h.company_url) company_url;
    UNSIGNED1 company_url_data_permits;
    UNSIGNED1 company_url_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R T(BestBy_Proxid_child le) := TRANSFORM
    SELF := le.company_name_cases[1];
    SELF := le.address_cases[1];
    SELF := le.company_phone_cases[1];
    SELF := le.company_fein_cases[1];
    SELF := le.company_url_cases[1];
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  OwnCands_company_fein := SORT( DISTRIBUTE(P1(company_fein_own_cnt>0),HASH(company_fein)), company_fein, -company_fein_own_cnt, Proxid,LOCAL);
  PassThru_company_fein := P1(company_fein_own_cnt=0);
  TYPEOF(P1) AddOwn_company_fein(P1 le,P1 ri) := TRANSFORM
    SELF.company_fein_owns := le.company_fein <> ri.company_fein; // The first in line with this value
    SELF := ri;
  END;
  P1_After_company_fein := ITERATE(OwnCands_company_fein,AddOwn_company_fein(LEFT,RIGHT),LOCAL) + PassThru_company_fein;
  RETURN P1_After_company_fein;
END;
EXPORT BestBy_Proxid_best := Flatten_BestBy_Proxid(BestBy_Proxid_child);
EXPORT BestBy_Proxid_best_np := Flatten_BestBy_Proxid(BestBy_Proxid_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_Proxid_population,NAMED('BestBy_Proxid_Population')));
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT27.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT27.Flags.Missing,
      le.company_name = ri.company_name => SALT27.Flags.Equal,
      le.company_name = (TYPEOF(le.company_name))'' OR ri.company_name = (TYPEOF(ri.company_name))'' OR SALT27.WithinEditN(le.company_name,ri.company_name,2)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT27.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT27.Flags.Missing,
      ri.company_fein_owns => SALT27.Flags.Owns,
      le.company_fein = ri.company_fein => SALT27.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT27.WithinEditN(le.company_fein,ri.company_fein,1)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT27.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT27.Flags.Missing,
      le.company_phone = ri.company_phone => SALT27.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT27.WithinEditN(le.company_phone,ri.company_phone,1)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT27.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT27.Flags.Missing,
      le.company_url = ri.company_url => SALT27.Flags.Equal,
      le.company_url = (TYPEOF(le.company_url))'' OR ri.company_url = (TYPEOF(ri.company_url))'' OR SALT27.WithinEditN(le.company_url,ri.company_url,1)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.address_flag := MAP ( (ri.address_prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.address_predir  IN SET(s.nulls_predir,predir) AND ri.address_prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.address_addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.address_postdir  IN SET(s.nulls_postdir,postdir) AND ri.address_unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.address_sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.address_st  IN SET(s.nulls_st,st) AND ri.address_zip  IN SET(s.nulls_zip,zip)) => SALT27.Flags.Null,
      (le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip)) => SALT27.Flags.Missing,
      (le.prim_range = ri.address_prim_range) AND (le.predir = ri.address_predir) AND (le.prim_name = ri.address_prim_name) AND (le.addr_suffix = ri.address_addr_suffix) AND (le.postdir = ri.address_postdir) AND (le.unit_desig = ri.address_unit_desig) AND (le.sec_range = ri.address_sec_range) AND (le.st = ri.address_st) AND (le.zip = ri.address_zip) => SALT27.Flags.Equal,
      (le.prim_range = (TYPEOF(le.prim_range))'' OR ri.address_prim_range = (TYPEOF(ri.address_prim_range))'' OR le.prim_range = ri.address_prim_range ) AND (le.predir = (TYPEOF(le.predir))'' OR ri.address_predir = (TYPEOF(ri.address_predir))'' OR le.predir = ri.address_predir ) AND (le.prim_name = (TYPEOF(le.prim_name))'' OR ri.address_prim_name = (TYPEOF(ri.address_prim_name))'' OR le.prim_name = ri.address_prim_name ) AND (le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.address_addr_suffix = (TYPEOF(ri.address_addr_suffix))'' OR le.addr_suffix = ri.address_addr_suffix ) AND (le.postdir = (TYPEOF(le.postdir))'' OR ri.address_postdir = (TYPEOF(ri.address_postdir))'' OR le.postdir = ri.address_postdir ) AND (le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.address_unit_desig = (TYPEOF(ri.address_unit_desig))'' OR le.unit_desig = ri.address_unit_desig ) AND (le.sec_range = (TYPEOF(le.sec_range))'' OR ri.address_sec_range = (TYPEOF(ri.address_sec_range))'' OR le.sec_range = ri.address_sec_range ) AND (le.st = (TYPEOF(le.st))'' OR ri.address_st = (TYPEOF(ri.address_st))'' OR le.st = ri.address_st ) AND (le.zip = (TYPEOF(le.zip))'' OR ri.address_zip = (TYPEOF(ri.address_zip))'' OR le.zip = ri.address_zip ) => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
EXPORT In_Flagged := j;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Missing,100,0));
    REAL4 address_Null_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Null,100,0));
    REAL4 address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Equal,100,0));
    REAL4 address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Bad,100,0));
    REAL4 address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Missing,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.source_for_votes; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT27.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT27.Flags.Missing,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT27.Flags.Missing,100,0));
    REAL4 address_Null_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Null,100,0));
    REAL4 address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Equal,100,0));
    REAL4 address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Fuzzy,100,0));
    REAL4 address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Bad,100,0));
    REAL4 address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT27.Flags.Missing,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,source_for_votes,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT27.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT27.Flags.Missing,
      le.company_name = ri.company_name => SALT27.Flags.Equal,
      le.company_name = (TYPEOF(le.company_name))'' OR ri.company_name = (TYPEOF(ri.company_name))'' OR SALT27.WithinEditN(le.company_name,ri.company_name,2)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT27.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT27.Flags.Missing,
      ri.company_fein_owns => SALT27.Flags.Owns,
      le.company_fein = ri.company_fein => SALT27.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT27.WithinEditN(le.company_fein,ri.company_fein,1)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT27.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT27.Flags.Missing,
      le.company_phone = ri.company_phone => SALT27.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT27.WithinEditN(le.company_phone,ri.company_phone,1)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT27.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT27.Flags.Missing,
      le.company_url = ri.company_url => SALT27.Flags.Equal,
      le.company_url = (TYPEOF(le.company_url))'' OR ri.company_url = (TYPEOF(ri.company_url))'' OR SALT27.WithinEditN(le.company_url,ri.company_url,1)  => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF.address_flag := MAP ( (ri.address_prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.address_predir  IN SET(s.nulls_predir,predir) AND ri.address_prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.address_addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.address_postdir  IN SET(s.nulls_postdir,postdir) AND ri.address_unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.address_sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.address_st  IN SET(s.nulls_st,st) AND ri.address_zip  IN SET(s.nulls_zip,zip)) => SALT27.Flags.Null,
      (le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip)) => SALT27.Flags.Missing,
      (le.prim_range = ri.address_prim_range) AND (le.predir = ri.address_predir) AND (le.prim_name = ri.address_prim_name) AND (le.addr_suffix = ri.address_addr_suffix) AND (le.postdir = ri.address_postdir) AND (le.unit_desig = ri.address_unit_desig) AND (le.sec_range = ri.address_sec_range) AND (le.st = ri.address_st) AND (le.zip = ri.address_zip) => SALT27.Flags.Equal,
      (le.prim_range = (TYPEOF(le.prim_range))'' OR ri.address_prim_range = (TYPEOF(ri.address_prim_range))'' OR le.prim_range = ri.address_prim_range ) AND (le.predir = (TYPEOF(le.predir))'' OR ri.address_predir = (TYPEOF(ri.address_predir))'' OR le.predir = ri.address_predir ) AND (le.prim_name = (TYPEOF(le.prim_name))'' OR ri.address_prim_name = (TYPEOF(ri.address_prim_name))'' OR le.prim_name = ri.address_prim_name ) AND (le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.address_addr_suffix = (TYPEOF(ri.address_addr_suffix))'' OR le.addr_suffix = ri.address_addr_suffix ) AND (le.postdir = (TYPEOF(le.postdir))'' OR ri.address_postdir = (TYPEOF(ri.address_postdir))'' OR le.postdir = ri.address_postdir ) AND (le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.address_unit_desig = (TYPEOF(ri.address_unit_desig))'' OR le.unit_desig = ri.address_unit_desig ) AND (le.sec_range = (TYPEOF(le.sec_range))'' OR ri.address_sec_range = (TYPEOF(ri.address_sec_range))'' OR le.sec_range = ri.address_sec_range ) AND (le.st = (TYPEOF(le.st))'' OR ri.address_st = (TYPEOF(ri.address_st))'' OR le.st = ri.address_st ) AND (le.zip = (TYPEOF(le.zip))'' OR ri.address_zip = (TYPEOF(ri.address_zip))'' OR le.zip = ri.address_zip ) => SALT27.Flags.Fuzzy,
      SALT27.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
EXPORT Input_Flagged := j;
END;
