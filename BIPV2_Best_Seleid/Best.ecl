// Begin code to BEST data for each basis
import SALT30,ut;
EXPORT Best(DATASET(layout_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
//Create those fields with BestType: BestCompanyNameLegal
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameLegal_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameLegal_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLegal_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameLegal_tab_company_name,{Seleid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Name_Legal_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Name_Legal_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLegal_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameLegal_vote_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyNameLegal_method_company_name := cmn;
//Create those fields with BestType: BestCompanyNameVotedSeleLevel
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameVotedSeleLevel_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameVotedSeleLevel_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedSeleLevel_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameVotedSeleLevel_tab_company_name,{Seleid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Sele_Level_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Sele_Level_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedSeleLevel_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameVotedSeleLevel_vote_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyNameVotedSeleLevel_method_company_name := o;
//Create those fields with BestType: BestCompanyNameCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCommon_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCommon_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestCompanyNameCommon_tab_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyNameCommon_method_company_name := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestCompanyNameCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCurrent_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyNameCurrent_method_company_name := DEDUP( SORT( BestCompanyNameCurrent_tab_company_name(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Seleid,LOCAL);
//Create those fields with BestType: BestCompanyNameVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameVoted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameVoted_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVoted_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameVoted_tab_company_name,{Seleid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Name_Source_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Name_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVoted_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameVoted_vote_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyNameVoted_method_company_name := o;
//Create those fields with BestType: BestCompanyNameLength
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameLength_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameLength_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameLength_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestCompanyNameLength_method_company_name := DEDUP( SORT( BestCompanyNameLength_tab_company_name,Seleid,-LENGTH(TRIM((SALT30.StrType)company_name)),-Row_Cnt,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestCompanyNameStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameStrong_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameStrong_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameStrong_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameStrong_tab_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
  Totals := TABLE(GROUP(grp),{Seleid,Tot := SUM(GROUP,Row_Cnt)},Seleid);
export BestCompanyNameStrong_method_company_name := JOIN( cmn,Totals,left.Seleid = right.Seleid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestCompanyNameCurrent2
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameCurrent2_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameCurrent2_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameCurrent2_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestCompanyNameCurrent2_method_company_name := DEDUP( SORT( BestCompanyNameCurrent2_tab_company_name(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestCompanyNameVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyNameVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_name,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_name,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyNameVotedUnrestricted_tab_(company_name NOT IN SET(s.nulls_company_name,company_name),fn_valid_cname(TRIM((SALT30.StrType)company_name),source_for_votes)),{Seleid,source_for_votes,data_permits,company_name,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedUnrestricted_tab_company_name := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyNameVotedUnrestricted_tab_company_name,{Seleid,data_permits,company_name,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyNameVotedUnrestricted_vote_company_name := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyNameVotedUnrestricted_vote_company_name,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyNameVotedUnrestricted_method_company_name := o;
//Create those fields with BestType: BestCompanyAddressVotedSeleLevel
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVotedSeleLevel_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVotedSeleLevel_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSeleLevel_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVotedSeleLevel_tab_address,{Seleid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Sele_Level_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Sele_Level_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSeleLevel_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVotedSeleLevel_vote_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyAddressVotedSeleLevel_method_address := o;
//Create those fields with BestType: BestCompanyAddressVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVoted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVoted_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVoted_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVoted_tab_address,{Seleid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Address_Fields_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Address_Fields_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVoted_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVoted_vote_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyAddressVoted_method_address := o;
//Create those fields with BestType: BestCompanyAddressCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCurrent_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Early_Date,Late_Date,Row_Cnt});
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
  BestCompanyAddressCurrent_tab_address.Seleid;
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
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressCurrent_tab_address le,BestCompanyAddressCurrent_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressCurrent_tab_address,BestCompanyAddressCurrent_tab_address, LEFT.Seleid = RIGHT.Seleid  AND (( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestCompanyAddressCurrent_method_address := DEDUP( SORT( BestCompanyAddressCurrent_fuzz_address(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Seleid,LOCAL);
//Create those fields with BestType: BestCompanyAddressVotedSrc
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVotedSrc_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVotedSrc_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSrc_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVotedSrc_tab_address,{Seleid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Address_Source_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Address_Source_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedSrc_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVotedSrc_vote_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestCompanyAddressVotedSrc_method_address := o;
//Create those fields with BestType: BestCompanyAddressCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCommon_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCommon_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic
Fuzzy_layout := RECORD
  BestCompanyAddressCommon_tab_address.Seleid;
  BestCompanyAddressCommon_tab_address.prim_range;
  BestCompanyAddressCommon_tab_address.predir;
  BestCompanyAddressCommon_tab_address.prim_name;
  BestCompanyAddressCommon_tab_address.addr_suffix;
  BestCompanyAddressCommon_tab_address.postdir;
  BestCompanyAddressCommon_tab_address.unit_desig;
  BestCompanyAddressCommon_tab_address.sec_range;
  BestCompanyAddressCommon_tab_address.st;
  BestCompanyAddressCommon_tab_address.zip;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressCommon_tab_address le,BestCompanyAddressCommon_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressCommon_tab_address,BestCompanyAddressCommon_tab_address, LEFT.Seleid = RIGHT.Seleid  AND (( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCommon_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestCompanyAddressCommon_fuzz_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestCompanyAddressCommon_method_address := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestCompanyAddressStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressStrong_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressStrong_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressStrong_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic
Fuzzy_layout := RECORD
  BestCompanyAddressStrong_tab_address.Seleid;
  BestCompanyAddressStrong_tab_address.prim_range;
  BestCompanyAddressStrong_tab_address.predir;
  BestCompanyAddressStrong_tab_address.prim_name;
  BestCompanyAddressStrong_tab_address.addr_suffix;
  BestCompanyAddressStrong_tab_address.postdir;
  BestCompanyAddressStrong_tab_address.unit_desig;
  BestCompanyAddressStrong_tab_address.sec_range;
  BestCompanyAddressStrong_tab_address.st;
  BestCompanyAddressStrong_tab_address.zip;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressStrong_tab_address le,BestCompanyAddressStrong_tab_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressStrong_tab_address,BestCompanyAddressStrong_tab_address, LEFT.Seleid = RIGHT.Seleid  AND (( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressStrong_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressStrong_fuzz_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(GROUP(grp),{Seleid,Tot := SUM(GROUP,Orig_Row_Cnt)},Seleid);
export BestCompanyAddressStrong_method_address := JOIN( cmn,Totals,left.Seleid = right.Seleid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestCompanyAddressCurrent2
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressCurrent2_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressCurrent2_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressCurrent2_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestCompanyAddressCurrent2_method_address := DEDUP( SORT( BestCompanyAddressCurrent2_tab_address(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestCompanyAddressVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestCompanyAddressVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestCompanyAddressVotedUnrestricted_tab_(~(prim_range  IN SET(s.nulls_prim_range,prim_range) AND predir  IN SET(s.nulls_predir,predir) AND prim_name  IN SET(s.nulls_prim_name,prim_name) AND addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND postdir  IN SET(s.nulls_postdir,postdir) AND unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND sec_range  IN SET(s.nulls_sec_range,sec_range) AND st  IN SET(s.nulls_st,st) AND zip  IN SET(s.nulls_zip,zip)),fn_valid_caddress(TRIM((SALT30.StrType)prim_range) + '|' + TRIM((SALT30.StrType)predir) + '|' + TRIM((SALT30.StrType)prim_name) + '|' + TRIM((SALT30.StrType)addr_suffix) + '|' + TRIM((SALT30.StrType)postdir) + '|' + TRIM((SALT30.StrType)unit_desig) + '|' + TRIM((SALT30.StrType)sec_range) + '|' + TRIM((SALT30.StrType)st) + '|' + TRIM((SALT30.StrType)zip),source_for_votes)),{Seleid,source_for_votes,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_tab_address := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestCompanyAddressVotedUnrestricted_tab_address,{Seleid,data_permits,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,st,zip,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_vote_address := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for address using defined fuzzy logic
Fuzzy_layout := RECORD
  BestCompanyAddressVotedUnrestricted_vote_address.Seleid;
  BestCompanyAddressVotedUnrestricted_vote_address.prim_range;
  BestCompanyAddressVotedUnrestricted_vote_address.predir;
  BestCompanyAddressVotedUnrestricted_vote_address.prim_name;
  BestCompanyAddressVotedUnrestricted_vote_address.addr_suffix;
  BestCompanyAddressVotedUnrestricted_vote_address.postdir;
  BestCompanyAddressVotedUnrestricted_vote_address.unit_desig;
  BestCompanyAddressVotedUnrestricted_vote_address.sec_range;
  BestCompanyAddressVotedUnrestricted_vote_address.st;
  BestCompanyAddressVotedUnrestricted_vote_address.zip;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestCompanyAddressVotedUnrestricted_vote_address le,BestCompanyAddressVotedUnrestricted_vote_address ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestCompanyAddressVotedUnrestricted_vote_address,BestCompanyAddressVotedUnrestricted_vote_address, LEFT.Seleid = RIGHT.Seleid  AND (( (LEFT.prim_range = (TYPEOF(LEFT.prim_range))'' OR RIGHT.prim_range = (TYPEOF(RIGHT.prim_range))'' OR LEFT.prim_range = RIGHT.prim_range ) AND (LEFT.predir = (TYPEOF(LEFT.predir))'' OR RIGHT.predir = (TYPEOF(RIGHT.predir))'' OR LEFT.predir = RIGHT.predir ) AND (LEFT.prim_name = (TYPEOF(LEFT.prim_name))'' OR RIGHT.prim_name = (TYPEOF(RIGHT.prim_name))'' OR LEFT.prim_name = RIGHT.prim_name ) AND (LEFT.addr_suffix = (TYPEOF(LEFT.addr_suffix))'' OR RIGHT.addr_suffix = (TYPEOF(RIGHT.addr_suffix))'' OR LEFT.addr_suffix = RIGHT.addr_suffix ) AND (LEFT.postdir = (TYPEOF(LEFT.postdir))'' OR RIGHT.postdir = (TYPEOF(RIGHT.postdir))'' OR LEFT.postdir = RIGHT.postdir ) AND (LEFT.unit_desig = (TYPEOF(LEFT.unit_desig))'' OR RIGHT.unit_desig = (TYPEOF(RIGHT.unit_desig))'' OR LEFT.unit_desig = RIGHT.unit_desig ) AND (LEFT.sec_range = (TYPEOF(LEFT.sec_range))'' OR RIGHT.sec_range = (TYPEOF(RIGHT.sec_range))'' OR LEFT.sec_range = RIGHT.sec_range ) AND (LEFT.st = (TYPEOF(LEFT.st))'' OR RIGHT.st = (TYPEOF(RIGHT.st))'' OR LEFT.st = RIGHT.st ) AND (LEFT.zip = (TYPEOF(LEFT.zip))'' OR RIGHT.zip = (TYPEOF(RIGHT.zip))'' OR LEFT.zip = RIGHT.zip ) )),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestCompanyAddressVotedUnrestricted_fuzz_address := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestCompanyAddressVotedUnrestricted_fuzz_address,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT30.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestCompanyAddressVotedUnrestricted_method_address := o;
//Create those fields with BestType: BestPhoneVotedSeleLevelWithNpa
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneVotedSeleLevelWithNpa_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneVotedSeleLevelWithNpa_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedSeleLevelWithNpa_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestPhoneVotedSeleLevelWithNpa_tab_company_phone,{Seleid,data_permits,company_phone,UNSIGNED Row_Cnt := 100 * fn_Best_Sele_Level_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Sele_Level_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedSeleLevelWithNpa_vote_company_phone := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneVotedSeleLevelWithNpa_vote_company_phone,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestPhoneVotedSeleLevelWithNpa_method_company_phone := o;
//Create those fields with BestType: BestPhoneCurrentWithNpa
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCurrentWithNpa_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCurrentWithNpa_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Early_Date,Late_Date,Row_Cnt});
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
  BestPhoneCurrentWithNpa_tab_company_phone.Seleid;
  BestPhoneCurrentWithNpa_tab_company_phone.company_phone;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCurrentWithNpa_tab_company_phone le,BestPhoneCurrentWithNpa_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCurrentWithNpa_tab_company_phone,BestPhoneCurrentWithNpa_tab_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrentWithNpa_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestPhoneCurrentWithNpa_method_company_phone := DEDUP( SORT( BestPhoneCurrentWithNpa_fuzz_company_phone(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestPhoneCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCurrent_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Early_Date,Late_Date,Row_Cnt});
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
  BestPhoneCurrent_tab_company_phone.Seleid;
  BestPhoneCurrent_tab_company_phone.company_phone;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCurrent_tab_company_phone le,BestPhoneCurrent_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCurrent_tab_company_phone,BestPhoneCurrent_tab_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCurrent_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestPhoneCurrent_method_company_phone := DEDUP( SORT( BestPhoneCurrent_fuzz_company_phone(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestPhoneVoted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneVoted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneVoted_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestPhoneVoted_tab_company_phone,{Seleid,data_permits,company_phone,UNSIGNED Row_Cnt := 100 * fn_Best_Phone_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Phone_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_vote_company_phone := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic
Fuzzy_layout := RECORD
  BestPhoneVoted_vote_company_phone.Seleid;
  BestPhoneVoted_vote_company_phone.company_phone;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneVoted_vote_company_phone le,BestPhoneVoted_vote_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneVoted_vote_company_phone,BestPhoneVoted_vote_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVoted_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneVoted_fuzz_company_phone,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT30.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestPhoneVoted_method_company_phone := o;
//Create those fields with BestType: BestPhoneLongest
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneLongest_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneLongest_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneLongest_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic
Fuzzy_layout := RECORD
  BestPhoneLongest_tab_company_phone.Seleid;
  BestPhoneLongest_tab_company_phone.company_phone;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneLongest_tab_company_phone le,BestPhoneLongest_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneLongest_tab_company_phone,BestPhoneLongest_tab_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneLongest_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestPhoneLongest_method_company_phone := DEDUP( SORT( BestPhoneLongest_fuzz_company_phone,Seleid,-LENGTH(TRIM((SALT30.StrType)company_phone)),-Row_Cnt,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestPhoneStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneStrong_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneStrong_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone7(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic
Fuzzy_layout := RECORD
  BestPhoneStrong_tab_company_phone.Seleid;
  BestPhoneStrong_tab_company_phone.company_phone;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneStrong_tab_company_phone le,BestPhoneStrong_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneStrong_tab_company_phone,BestPhoneStrong_tab_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneStrong_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneStrong_fuzz_company_phone,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(GROUP(grp),{Seleid,Tot := SUM(GROUP,Orig_Row_Cnt)},Seleid);
export BestPhoneStrong_method_company_phone := JOIN( cmn,Totals,left.Seleid = right.Seleid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestPhoneVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneVotedUnrestricted_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestPhoneVotedUnrestricted_tab_company_phone,{Seleid,data_permits,company_phone,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_vote_company_phone := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic
Fuzzy_layout := RECORD
  BestPhoneVotedUnrestricted_vote_company_phone.Seleid;
  BestPhoneVotedUnrestricted_vote_company_phone.company_phone;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneVotedUnrestricted_vote_company_phone le,BestPhoneVotedUnrestricted_vote_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneVotedUnrestricted_vote_company_phone,BestPhoneVotedUnrestricted_vote_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneVotedUnrestricted_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestPhoneVotedUnrestricted_fuzz_company_phone,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT30.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestPhoneVotedUnrestricted_method_company_phone := o;
//Create those fields with BestType: BestPhoneCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestPhoneCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_phone,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_phone,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestPhoneCommon_tab_(company_phone NOT IN SET(s.nulls_company_phone,company_phone),fn_valid_cphone10(TRIM((SALT30.StrType)company_phone),source_for_votes)),{Seleid,source_for_votes,data_permits,company_phone,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCommon_tab_company_phone := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_phone using defined fuzzy logic
Fuzzy_layout := RECORD
  BestPhoneCommon_tab_company_phone.Seleid;
  BestPhoneCommon_tab_company_phone.company_phone;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestPhoneCommon_tab_company_phone le,BestPhoneCommon_tab_company_phone ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestPhoneCommon_tab_company_phone,BestPhoneCommon_tab_company_phone, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_phone = (TYPEOF(LEFT.company_phone))'' OR RIGHT.company_phone = (TYPEOF(RIGHT.company_phone))'' OR SALT30.WithinEditN(LEFT.company_phone,RIGHT.company_phone,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestPhoneCommon_fuzz_company_phone := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestPhoneCommon_fuzz_company_phone,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestPhoneCommon_method_company_phone := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestFeinStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinStrong_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinStrong_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic
Fuzzy_layout := RECORD
  BestFeinStrong_tab_company_fein.Seleid;
  BestFeinStrong_tab_company_fein.company_fein;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinStrong_tab_company_fein le,BestFeinStrong_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinStrong_tab_company_fein,BestFeinStrong_tab_company_fein, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT30.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1, 0)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinStrong_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinStrong_fuzz_company_fein,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the Orig_row_cnts.
  Totals := TABLE(GROUP(grp),{Seleid,Tot := SUM(GROUP,Orig_Row_Cnt)},Seleid);
export BestFeinStrong_method_company_fein := JOIN( cmn,Totals,left.Seleid = right.Seleid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestFeinCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinCommon_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic
Fuzzy_layout := RECORD
  BestFeinCommon_tab_company_fein.Seleid;
  BestFeinCommon_tab_company_fein.company_fein;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinCommon_tab_company_fein le,BestFeinCommon_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinCommon_tab_company_fein,BestFeinCommon_tab_company_fein, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT30.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1, 0)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCommon_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestFeinCommon_fuzz_company_fein,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestFeinCommon_method_company_fein := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestFeinCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinCurrent_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Early_Date,Late_Date,Row_Cnt});
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
  BestFeinCurrent_tab_company_fein.Seleid;
  BestFeinCurrent_tab_company_fein.company_fein;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinCurrent_tab_company_fein le,BestFeinCurrent_tab_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinCurrent_tab_company_fein,BestFeinCurrent_tab_company_fein, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT30.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1, 0)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinCurrent_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestFeinCurrent_method_company_fein := DEDUP( SORT( BestFeinCurrent_fuzz_company_fein(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestFeinVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinVotedUnrestricted_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinVotedUnrestricted_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinVotedUnrestricted_tab_company_fein,{Seleid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinVotedUnrestricted_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinVotedUnrestricted_vote_company_fein,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestFeinVotedUnrestricted_method_company_fein := o;
//Create those fields with BestType: BestFeinMin
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinMin_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinMin_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinMin_tab_company_fein,{Seleid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Fein_Votes_Min(source_for_votes,Row_Cnt)}); // Use fn_Best_Fein_Votes_Min to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic
Fuzzy_layout := RECORD
  BestFeinMin_vote_company_fein.Seleid;
  BestFeinMin_vote_company_fein.company_fein;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinMin_vote_company_fein le,BestFeinMin_vote_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinMin_vote_company_fein,BestFeinMin_vote_company_fein, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT30.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1, 0)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMin_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinMin_fuzz_company_fein,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT30.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestFeinMin_method_company_fein := o;
//Create those fields with BestType: BestFeinMax
// First step is to get all of the data slimmed and row-reduced
EXPORT BestFeinMax_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_fein,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_fein,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestFeinMax_tab_(company_fein NOT IN SET(s.nulls_company_fein,company_fein),fn_valid_cfein(TRIM((SALT30.StrType)company_fein),source_for_votes)),{Seleid,source_for_votes,data_permits,company_fein,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_tab_company_fein := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestFeinMax_tab_company_fein,{Seleid,data_permits,company_fein,UNSIGNED Row_Cnt := 100 * fn_Best_Fein_Votes_Max(source_for_votes,Row_Cnt)}); // Use fn_Best_Fein_Votes_Max to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_vote_company_fein := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Adjust scores for company_fein using defined fuzzy logic
Fuzzy_layout := RECORD
  BestFeinMax_vote_company_fein.Seleid;
  BestFeinMax_vote_company_fein.company_fein;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestFeinMax_vote_company_fein le,BestFeinMax_vote_company_fein ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestFeinMax_vote_company_fein,BestFeinMax_vote_company_fein, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.company_fein = (TYPEOF(LEFT.company_fein))'' OR RIGHT.company_fein = (TYPEOF(RIGHT.company_fein))'' OR SALT30.WithinEditN(LEFT.company_fein,RIGHT.company_fein,1, 0)  OR fn_Right4(RIGHT.company_fein) = fn_Right4(LEFT.company_fein)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestFeinMax_fuzz_company_fein := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestFeinMax_fuzz_company_fein,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  SALT30.MAC_Apply_Threshold_Fuzzy(srt,200,o);
EXPORT BestFeinMax_method_company_fein := o;
//Create those fields with BestType: BestUrlCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_url,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlCommon_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT30.StrType)company_url),source_for_votes)),{Seleid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCommon_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestUrlCommon_tab_company_url,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestUrlCommon_method_company_url := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestUrlCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_url,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_url,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlCurrent_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT30.StrType)company_url),source_for_votes)),{Seleid,source_for_votes,data_permits,company_url,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlCurrent_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestUrlCurrent_method_company_url := DEDUP( SORT( BestUrlCurrent_tab_company_url(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestUrlLength
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlLength_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_url,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlLength_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT30.StrType)company_url),source_for_votes)),{Seleid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlLength_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value
EXPORT BestUrlLength_method_company_url := DEDUP( SORT( BestUrlLength_tab_company_url,Seleid,-LENGTH(TRIM((SALT30.StrType)company_url)),-Row_Cnt,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestUrlStrong
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlStrong_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_url,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlStrong_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT30.StrType)company_url),source_for_votes)),{Seleid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlStrong_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestUrlStrong_tab_company_url,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
  Totals := TABLE(GROUP(grp),{Seleid,Tot := SUM(GROUP,Row_Cnt)},Seleid);
export BestUrlStrong_method_company_url := JOIN( cmn,Totals,left.Seleid = right.Seleid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Create those fields with BestType: BestUrlVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestUrlVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,company_url,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,company_url,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestUrlVotedUnrestricted_tab_(company_url NOT IN SET(s.nulls_company_url,company_url),fn_valid_curl(TRIM((SALT30.StrType)company_url),source_for_votes)),{Seleid,source_for_votes,data_permits,company_url,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlVotedUnrestricted_tab_company_url := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestUrlVotedUnrestricted_tab_company_url,{Seleid,data_permits,company_url,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestUrlVotedUnrestricted_vote_company_url := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestUrlVotedUnrestricted_vote_company_url,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestUrlVotedUnrestricted_method_company_url := o;
//Create those fields with BestType: BestDunsCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDunsCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,duns_number,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,duns_number,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestDunsCommon_tab_(duns_number NOT IN SET(s.nulls_duns_number,duns_number),fn_valid_duns(TRIM((SALT30.StrType)duns_number),source_for_votes)),{Seleid,source_for_votes,data_permits,duns_number,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsCommon_tab_duns_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,LOCAL);
// Adjust scores for duns_number using defined fuzzy logic
Fuzzy_layout := RECORD
  BestDunsCommon_tab_duns_number.Seleid;
  BestDunsCommon_tab_duns_number.duns_number;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestDunsCommon_tab_duns_number le,BestDunsCommon_tab_duns_number ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestDunsCommon_tab_duns_number,BestDunsCommon_tab_duns_number, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.duns_number = (TYPEOF(LEFT.duns_number))'' OR RIGHT.duns_number = (TYPEOF(RIGHT.duns_number))'' OR SALT30.WithinEditN(LEFT.duns_number,RIGHT.duns_number,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsCommon_fuzz_duns_number := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestDunsCommon_fuzz_duns_number,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt,-Orig_Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestDunsCommon_method_duns_number := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestDunsCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDunsCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,duns_number,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,duns_number,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestDunsCurrent_tab_(duns_number NOT IN SET(s.nulls_duns_number,duns_number),fn_valid_duns(TRIM((SALT30.StrType)duns_number),source_for_votes)),{Seleid,source_for_votes,data_permits,duns_number,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsCurrent_tab_duns_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
// Adjust scores for duns_number using defined fuzzy logic
Fuzzy_layout := RECORD
  BestDunsCurrent_tab_duns_number.Seleid;
  BestDunsCurrent_tab_duns_number.duns_number;
  UNSIGNED Early_Date;
  UNSIGNED Late_Date;
  UNSIGNED2 data_permits; // Data permits copied in by NOT fuzzy enforced
  UNSIGNED Row_Cnt;
  UNSIGNED Orig_Row_Cnt; // Stores the 'normal' row count
END;
Fuzzy_layout NoteSupport(BestDunsCurrent_tab_duns_number le,BestDunsCurrent_tab_duns_number ri) := TRANSFORM
  SELF.Row_Cnt := ri.Row_Cnt;
  SELF.Orig_Row_Cnt := le.Row_Cnt;
  SELF := le;
END;
Supports := JOIN(BestDunsCurrent_tab_duns_number,BestDunsCurrent_tab_duns_number, LEFT.Seleid = RIGHT.Seleid  AND ( LEFT.duns_number = (TYPEOF(LEFT.duns_number))'' OR RIGHT.duns_number = (TYPEOF(RIGHT.duns_number))'' OR SALT30.WithinEditN(LEFT.duns_number,RIGHT.duns_number,1, 0)  ),NoteSupport(LEFT,RIGHT),LOCAL);
  Supports TR(Supports le, Supports ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsCurrent_fuzz_duns_number := ROLLUP( SORT(Supports,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestDunsCurrent_method_duns_number := DEDUP( SORT( BestDunsCurrent_fuzz_duns_number(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Seleid,LOCAL);
//Create those fields with BestType: BestDunsCurrent2
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDunsCurrent2_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,duns_number,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,duns_number,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestDunsCurrent2_tab_(duns_number NOT IN SET(s.nulls_duns_number,duns_number),fn_valid_duns(TRIM((SALT30.StrType)duns_number),source_for_votes)),{Seleid,source_for_votes,data_permits,duns_number,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsCurrent2_tab_duns_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,source_for_votes,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value
EXPORT BestDunsCurrent2_method_duns_number := DEDUP( SORT( BestDunsCurrent2_tab_duns_number(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL),Seleid,LOCAL);
//Create those fields with BestType: BestDunsVotedUnrestricted
// First step is to get all of the data slimmed and row-reduced
EXPORT BestDunsVotedUnrestricted_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,source_for_votes,data_permits,duns_number,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,source_for_votes,data_permits,duns_number,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestDunsVotedUnrestricted_tab_(duns_number NOT IN SET(s.nulls_duns_number,duns_number),fn_valid_duns(TRIM((SALT30.StrType)duns_number),source_for_votes)),{Seleid,source_for_votes,data_permits,duns_number,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsVotedUnrestricted_tab_duns_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
// Voting is supported by altering the Row Count to be 100 * the (real) vote returned from the attribute
  Voted := TABLE( BestDunsVotedUnrestricted_tab_duns_number,{Seleid,data_permits,duns_number,UNSIGNED Row_Cnt := 100 * fn_Best_Source_Unrestricted_Votes(source_for_votes,Row_Cnt)}); // Use fn_Best_Source_Unrestricted_Votes to vote
  Voted TR(Voted le, Voted ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestDunsVotedUnrestricted_vote_duns_number := ROLLUP( SORT(Voted,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value
  grp := GROUP( BestDunsVotedUnrestricted_vote_duns_number,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  SALT30.MAC_Apply_Threshold(srt,200,o);
EXPORT BestDunsVotedUnrestricted_method_duns_number := o;
//Create those fields with BestType: BestSicCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestSicCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,data_permits,company_sic_code1,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,data_permits,company_sic_code1,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestSicCommon_tab_(company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1)),{Seleid,data_permits,company_sic_code1,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestSicCommon_tab_company_sic_code1 := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestSicCommon_tab_company_sic_code1,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestSicCommon_method_company_sic_code1 := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestSicCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestSicCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,data_permits,company_sic_code1,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,data_permits,company_sic_code1,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestSicCurrent_tab_(company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1)),{Seleid,data_permits,company_sic_code1,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestSicCurrent_tab_company_sic_code1 := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestSicCurrent_method_company_sic_code1 := DEDUP( SORT( BestSicCurrent_tab_company_sic_code1(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Seleid,LOCAL);
//Create those fields with BestType: BestNaicsCommon
// First step is to get all of the data slimmed and row-reduced
EXPORT BestNaicsCommon_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,data_permits,company_naics_code1,UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,data_permits,company_naics_code1,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestNaicsCommon_tab_(company_naics_code1 NOT IN SET(s.nulls_company_naics_code1,company_naics_code1)),{Seleid,data_permits,company_naics_code1,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNaicsCommon_tab_company_naics_code1 := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,LOCAL);
//Now actually find the best value enforcing minimum
  grp := GROUP( BestNaicsCommon_tab_company_naics_code1,Seleid,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
EXPORT BestNaicsCommon_method_company_naics_code1 := cmn(Row_Cnt >= 2);
//Create those fields with BestType: BestNaicsCurrent
// First step is to get all of the data slimmed and row-reduced
EXPORT BestNaicsCurrent_tab_ := DISTRIBUTE(TABLE(h(Seleid <> 0),{Seleid,data_permits,company_naics_code1,UNSIGNED Early_Date := MIN(GROUP,IF(dt_last_seen=0,99999999,dt_last_seen)),UNSIGNED Late_Date := MAX(GROUP,dt_last_seen),UNSIGNED Row_Cnt := COUNT(GROUP)},Seleid,data_permits,company_naics_code1,MERGE),HASH(Seleid)); // Slim and reduce row-count
  Slim := TABLE(BestNaicsCurrent_tab_(company_naics_code1 NOT IN SET(s.nulls_company_naics_code1,company_naics_code1)),{Seleid,data_permits,company_naics_code1,Early_Date,Late_Date,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Early_Date := MIN(le.Early_Date,ri.Early_Date);
    SELF.Late_Date := MAX(le.Late_Date,ri.Late_Date);
    SELF.data_permits := le.data_permits|ri.data_permits;
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT BestNaicsCurrent_tab_company_naics_code1 := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,data_permits,Early_Date,Late_Date,LOCAL);
//Now actually find the best value enforcing minimum
EXPORT BestNaicsCurrent_method_company_naics_code1 := DEDUP( SORT( BestNaicsCurrent_tab_company_naics_code1(Late_Date>0,Early_Date<99999999),Seleid,-Late_Date,-Early_Date,LOCAL)(Row_Cnt >= 2),Seleid,LOCAL);
// Start to gather together all records with basis:Seleid,source_for_votes,data_permits
// 0 - Gathering type:BestCompanyNameLegal Entries:1
  R0 := RECORD
    typeof(BestCompanyNameLegal_method_company_name.Seleid) Seleid; // Need to copy in basis
    TYPEOF(BestCompanyNameLegal_method_company_name.company_name) BestCompanyNameLegal_company_name;
    UNSIGNED company_name_BestCompanyNameLegal_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameLegal_data_permits;
  END;
  R0 T0(BestCompanyNameLegal_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameLegal_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameLegal_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameLegal_data_permits := ri.data_permits;
    SELF := ri;
  END;
  J0 := PROJECT(BestCompanyNameLegal_method_company_name,T0(left));
// 1 - Gathering type:BestCompanyNameVotedSeleLevel Entries:1
  R1 := RECORD
    J0; // The data so far
    TYPEOF(BestCompanyNameVotedSeleLevel_method_company_name.company_name) BestCompanyNameVotedSeleLevel_company_name;
    UNSIGNED company_name_BestCompanyNameVotedSeleLevel_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameVotedSeleLevel_data_permits;
  END;
  R1 T1(J0 le,BestCompanyNameVotedSeleLevel_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameVotedSeleLevel_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameVotedSeleLevel_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameVotedSeleLevel_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J1 := JOIN(J0,BestCompanyNameVotedSeleLevel_method_company_name,LEFT.Seleid = RIGHT.Seleid,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
// 2 - Gathering type:BestCompanyNameCommon Entries:1
  R2 := RECORD
    J1; // The data so far
    TYPEOF(BestCompanyNameCommon_method_company_name.company_name) BestCompanyNameCommon_company_name;
    UNSIGNED company_name_BestCompanyNameCommon_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameCommon_data_permits;
  END;
  R2 T2(J1 le,BestCompanyNameCommon_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCommon_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J2 := JOIN(J1,BestCompanyNameCommon_method_company_name,LEFT.Seleid = RIGHT.Seleid,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
// 3 - Gathering type:BestCompanyNameCurrent Entries:1
  R3 := RECORD
    J2; // The data so far
    TYPEOF(BestCompanyNameCurrent_method_company_name.company_name) BestCompanyNameCurrent_company_name;
    UNSIGNED company_name_BestCompanyNameCurrent_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameCurrent_data_permits;
  END;
  R3 T3(J2 le,BestCompanyNameCurrent_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCurrent_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J3 := JOIN(J2,BestCompanyNameCurrent_method_company_name,LEFT.Seleid = RIGHT.Seleid,T3(LEFT,RIGHT),FULL OUTER,LOCAL);
// 4 - Gathering type:BestCompanyNameVoted Entries:1
  R4 := RECORD
    J3; // The data so far
    TYPEOF(BestCompanyNameVoted_method_company_name.company_name) BestCompanyNameVoted_company_name;
    UNSIGNED company_name_BestCompanyNameVoted_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameVoted_data_permits;
  END;
  R4 T4(J3 le,BestCompanyNameVoted_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameVoted_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameVoted_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameVoted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J4 := JOIN(J3,BestCompanyNameVoted_method_company_name,LEFT.Seleid = RIGHT.Seleid,T4(LEFT,RIGHT),FULL OUTER,LOCAL);
// 5 - Gathering type:BestCompanyNameLength Entries:1
  R5 := RECORD
    J4; // The data so far
    TYPEOF(BestCompanyNameLength_method_company_name.company_name) BestCompanyNameLength_company_name;
    UNSIGNED company_name_BestCompanyNameLength_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameLength_data_permits;
  END;
  R5 T5(J4 le,BestCompanyNameLength_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameLength_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameLength_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameLength_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J5 := JOIN(J4,BestCompanyNameLength_method_company_name,LEFT.Seleid = RIGHT.Seleid,T5(LEFT,RIGHT),FULL OUTER,LOCAL);
// 6 - Gathering type:BestCompanyNameStrong Entries:1
  R6 := RECORD
    J5; // The data so far
    TYPEOF(BestCompanyNameStrong_method_company_name.company_name) BestCompanyNameStrong_company_name;
    UNSIGNED company_name_BestCompanyNameStrong_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameStrong_data_permits;
  END;
  R6 T6(J5 le,BestCompanyNameStrong_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameStrong_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J6 := JOIN(J5,BestCompanyNameStrong_method_company_name,LEFT.Seleid = RIGHT.Seleid,T6(LEFT,RIGHT),FULL OUTER,LOCAL);
// 7 - Gathering type:BestCompanyNameCurrent2 Entries:1
  R7 := RECORD
    J6; // The data so far
    TYPEOF(BestCompanyNameCurrent2_method_company_name.company_name) BestCompanyNameCurrent2_company_name;
    UNSIGNED company_name_BestCompanyNameCurrent2_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameCurrent2_data_permits;
  END;
  R7 T7(J6 le,BestCompanyNameCurrent2_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameCurrent2_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameCurrent2_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameCurrent2_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J7 := JOIN(J6,BestCompanyNameCurrent2_method_company_name,LEFT.Seleid = RIGHT.Seleid,T7(LEFT,RIGHT),FULL OUTER,LOCAL);
// 8 - Gathering type:BestCompanyNameVotedUnrestricted Entries:1
  R8 := RECORD
    J7; // The data so far
    TYPEOF(BestCompanyNameVotedUnrestricted_method_company_name.company_name) BestCompanyNameVotedUnrestricted_company_name;
    UNSIGNED company_name_BestCompanyNameVotedUnrestricted_Row_Cnt;
    UNSIGNED2 company_name_BestCompanyNameVotedUnrestricted_data_permits;
  END;
  R8 T8(J7 le,BestCompanyNameVotedUnrestricted_method_company_name ri) := TRANSFORM
    SELF.BestCompanyNameVotedUnrestricted_company_name := ri.company_name;
    SELF.company_name_BestCompanyNameVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_name_BestCompanyNameVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J8 := JOIN(J7,BestCompanyNameVotedUnrestricted_method_company_name,LEFT.Seleid = RIGHT.Seleid,T8(LEFT,RIGHT),FULL OUTER,LOCAL);
// 9 - Gathering type:BestCompanyAddressVotedSeleLevel Entries:1
  R9 := RECORD
    J8; // The data so far
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.prim_range) BestCompanyAddressVotedSeleLevel_address_prim_range;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.predir) BestCompanyAddressVotedSeleLevel_address_predir;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.prim_name) BestCompanyAddressVotedSeleLevel_address_prim_name;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.addr_suffix) BestCompanyAddressVotedSeleLevel_address_addr_suffix;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.postdir) BestCompanyAddressVotedSeleLevel_address_postdir;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.unit_desig) BestCompanyAddressVotedSeleLevel_address_unit_desig;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.sec_range) BestCompanyAddressVotedSeleLevel_address_sec_range;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.st) BestCompanyAddressVotedSeleLevel_address_st;
    TYPEOF(BestCompanyAddressVotedSeleLevel_method_address.zip) BestCompanyAddressVotedSeleLevel_address_zip;
    UNSIGNED address_BestCompanyAddressVotedSeleLevel_Row_Cnt;
    UNSIGNED2 address_BestCompanyAddressVotedSeleLevel_data_permits;
  END;
  R9 T9(J8 le,BestCompanyAddressVotedSeleLevel_method_address ri) := TRANSFORM
    SELF.BestCompanyAddressVotedSeleLevel_address_prim_range := ri.prim_range;
    SELF.BestCompanyAddressVotedSeleLevel_address_predir := ri.predir;
    SELF.BestCompanyAddressVotedSeleLevel_address_prim_name := ri.prim_name;
    SELF.BestCompanyAddressVotedSeleLevel_address_addr_suffix := ri.addr_suffix;
    SELF.BestCompanyAddressVotedSeleLevel_address_postdir := ri.postdir;
    SELF.BestCompanyAddressVotedSeleLevel_address_unit_desig := ri.unit_desig;
    SELF.BestCompanyAddressVotedSeleLevel_address_sec_range := ri.sec_range;
    SELF.BestCompanyAddressVotedSeleLevel_address_st := ri.st;
    SELF.BestCompanyAddressVotedSeleLevel_address_zip := ri.zip;
    SELF.address_BestCompanyAddressVotedSeleLevel_Row_Cnt := ri.Row_Cnt;
    SELF.address_BestCompanyAddressVotedSeleLevel_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J9 := JOIN(J8,BestCompanyAddressVotedSeleLevel_method_address,LEFT.Seleid = RIGHT.Seleid,T9(LEFT,RIGHT),FULL OUTER,LOCAL);
// 10 - Gathering type:BestCompanyAddressVoted Entries:1
  R10 := RECORD
    J9; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressVoted_data_permits;
  END;
  R10 T10(J9 le,BestCompanyAddressVoted_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J10 := JOIN(J9,BestCompanyAddressVoted_method_address,LEFT.Seleid = RIGHT.Seleid,T10(LEFT,RIGHT),FULL OUTER,LOCAL);
// 11 - Gathering type:BestCompanyAddressCurrent Entries:1
  R11 := RECORD
    J10; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressCurrent_data_permits;
  END;
  R11 T11(J10 le,BestCompanyAddressCurrent_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J11 := JOIN(J10,BestCompanyAddressCurrent_method_address,LEFT.Seleid = RIGHT.Seleid,T11(LEFT,RIGHT),FULL OUTER,LOCAL);
// 12 - Gathering type:BestCompanyAddressVotedSrc Entries:1
  R12 := RECORD
    J11; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressVotedSrc_data_permits;
  END;
  R12 T12(J11 le,BestCompanyAddressVotedSrc_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J12 := JOIN(J11,BestCompanyAddressVotedSrc_method_address,LEFT.Seleid = RIGHT.Seleid,T12(LEFT,RIGHT),FULL OUTER,LOCAL);
// 13 - Gathering type:BestCompanyAddressCommon Entries:1
  R13 := RECORD
    J12; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressCommon_data_permits;
  END;
  R13 T13(J12 le,BestCompanyAddressCommon_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J13 := JOIN(J12,BestCompanyAddressCommon_method_address,LEFT.Seleid = RIGHT.Seleid,T13(LEFT,RIGHT),FULL OUTER,LOCAL);
// 14 - Gathering type:BestCompanyAddressStrong Entries:1
  R14 := RECORD
    J13; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressStrong_data_permits;
  END;
  R14 T14(J13 le,BestCompanyAddressStrong_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J14 := JOIN(J13,BestCompanyAddressStrong_method_address,LEFT.Seleid = RIGHT.Seleid,T14(LEFT,RIGHT),FULL OUTER,LOCAL);
// 15 - Gathering type:BestCompanyAddressCurrent2 Entries:1
  R15 := RECORD
    J14; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressCurrent2_data_permits;
  END;
  R15 T15(J14 le,BestCompanyAddressCurrent2_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J15 := JOIN(J14,BestCompanyAddressCurrent2_method_address,LEFT.Seleid = RIGHT.Seleid,T15(LEFT,RIGHT),FULL OUTER,LOCAL);
// 16 - Gathering type:BestCompanyAddressVotedUnrestricted Entries:1
  R16 := RECORD
    J15; // The data so far
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
    UNSIGNED2 address_BestCompanyAddressVotedUnrestricted_data_permits;
  END;
  R16 T16(J15 le,BestCompanyAddressVotedUnrestricted_method_address ri) := TRANSFORM
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
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J16 := JOIN(J15,BestCompanyAddressVotedUnrestricted_method_address,LEFT.Seleid = RIGHT.Seleid,T16(LEFT,RIGHT),FULL OUTER,LOCAL);
// 17 - Gathering type:BestPhoneVotedSeleLevelWithNpa Entries:1
  R17 := RECORD
    J16; // The data so far
    TYPEOF(BestPhoneVotedSeleLevelWithNpa_method_company_phone.company_phone) BestPhoneVotedSeleLevelWithNpa_company_phone;
    UNSIGNED company_phone_BestPhoneVotedSeleLevelWithNpa_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits;
  END;
  R17 T17(J16 le,BestPhoneVotedSeleLevelWithNpa_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneVotedSeleLevelWithNpa_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneVotedSeleLevelWithNpa_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J17 := JOIN(J16,BestPhoneVotedSeleLevelWithNpa_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T17(LEFT,RIGHT),FULL OUTER,LOCAL);
// 18 - Gathering type:BestPhoneCurrentWithNpa Entries:1
  R18 := RECORD
    J17; // The data so far
    TYPEOF(BestPhoneCurrentWithNpa_method_company_phone.company_phone) BestPhoneCurrentWithNpa_company_phone;
    UNSIGNED company_phone_BestPhoneCurrentWithNpa_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneCurrentWithNpa_data_permits;
  END;
  R18 T18(J17 le,BestPhoneCurrentWithNpa_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCurrentWithNpa_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCurrentWithNpa_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCurrentWithNpa_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCurrentWithNpa_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J18 := JOIN(J17,BestPhoneCurrentWithNpa_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T18(LEFT,RIGHT),FULL OUTER,LOCAL);
// 19 - Gathering type:BestPhoneCurrent Entries:1
  R19 := RECORD
    J18; // The data so far
    TYPEOF(BestPhoneCurrent_method_company_phone.company_phone) BestPhoneCurrent_company_phone;
    UNSIGNED company_phone_BestPhoneCurrent_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCurrent_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneCurrent_data_permits;
  END;
  R19 T19(J18 le,BestPhoneCurrent_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCurrent_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J19 := JOIN(J18,BestPhoneCurrent_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T19(LEFT,RIGHT),FULL OUTER,LOCAL);
// 20 - Gathering type:BestPhoneVoted Entries:1
  R20 := RECORD
    J19; // The data so far
    TYPEOF(BestPhoneVoted_method_company_phone.company_phone) BestPhoneVoted_company_phone;
    UNSIGNED company_phone_BestPhoneVoted_Row_Cnt;
    UNSIGNED company_phone_BestPhoneVoted_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneVoted_data_permits;
  END;
  R20 T20(J19 le,BestPhoneVoted_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneVoted_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneVoted_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneVoted_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneVoted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J20 := JOIN(J19,BestPhoneVoted_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T20(LEFT,RIGHT),FULL OUTER,LOCAL);
// 21 - Gathering type:BestPhoneLongest Entries:1
  R21 := RECORD
    J20; // The data so far
    TYPEOF(BestPhoneLongest_method_company_phone.company_phone) BestPhoneLongest_company_phone;
    UNSIGNED company_phone_BestPhoneLongest_Row_Cnt;
    UNSIGNED company_phone_BestPhoneLongest_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneLongest_data_permits;
  END;
  R21 T21(J20 le,BestPhoneLongest_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneLongest_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneLongest_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneLongest_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneLongest_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J21 := JOIN(J20,BestPhoneLongest_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T21(LEFT,RIGHT),FULL OUTER,LOCAL);
// 22 - Gathering type:BestPhoneStrong Entries:1
  R22 := RECORD
    J21; // The data so far
    TYPEOF(BestPhoneStrong_method_company_phone.company_phone) BestPhoneStrong_company_phone;
    UNSIGNED company_phone_BestPhoneStrong_Row_Cnt;
    UNSIGNED company_phone_BestPhoneStrong_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneStrong_data_permits;
  END;
  R22 T22(J21 le,BestPhoneStrong_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneStrong_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J22 := JOIN(J21,BestPhoneStrong_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T22(LEFT,RIGHT),FULL OUTER,LOCAL);
// 23 - Gathering type:BestPhoneVotedUnrestricted Entries:1
  R23 := RECORD
    J22; // The data so far
    TYPEOF(BestPhoneVotedUnrestricted_method_company_phone.company_phone) BestPhoneVotedUnrestricted_company_phone;
    UNSIGNED company_phone_BestPhoneVotedUnrestricted_Row_Cnt;
    UNSIGNED company_phone_BestPhoneVotedUnrestricted_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneVotedUnrestricted_data_permits;
  END;
  R23 T23(J22 le,BestPhoneVotedUnrestricted_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneVotedUnrestricted_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneVotedUnrestricted_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J23 := JOIN(J22,BestPhoneVotedUnrestricted_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T23(LEFT,RIGHT),FULL OUTER,LOCAL);
// 24 - Gathering type:BestPhoneCommon Entries:1
  R24 := RECORD
    J23; // The data so far
    TYPEOF(BestPhoneCommon_method_company_phone.company_phone) BestPhoneCommon_company_phone;
    UNSIGNED company_phone_BestPhoneCommon_Row_Cnt;
    UNSIGNED company_phone_BestPhoneCommon_Orig_Row_Cnt;
    UNSIGNED2 company_phone_BestPhoneCommon_data_permits;
  END;
  R24 T24(J23 le,BestPhoneCommon_method_company_phone ri) := TRANSFORM
    SELF.BestPhoneCommon_company_phone := ri.company_phone;
    SELF.company_phone_BestPhoneCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_phone_BestPhoneCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_phone_BestPhoneCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J24 := JOIN(J23,BestPhoneCommon_method_company_phone,LEFT.Seleid = RIGHT.Seleid,T24(LEFT,RIGHT),FULL OUTER,LOCAL);
// 25 - Gathering type:BestFeinStrong Entries:1
  R25 := RECORD
    J24; // The data so far
    TYPEOF(BestFeinStrong_method_company_fein.company_fein) BestFeinStrong_company_fein;
    UNSIGNED company_fein_BestFeinStrong_Row_Cnt;
    UNSIGNED company_fein_BestFeinStrong_Orig_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinStrong_data_permits;
  END;
  R25 T25(J24 le,BestFeinStrong_method_company_fein ri) := TRANSFORM
    SELF.BestFeinStrong_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinStrong_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J25 := JOIN(J24,BestFeinStrong_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T25(LEFT,RIGHT),FULL OUTER,LOCAL);
// 26 - Gathering type:BestFeinCommon Entries:1
  R26 := RECORD
    J25; // The data so far
    TYPEOF(BestFeinCommon_method_company_fein.company_fein) BestFeinCommon_company_fein;
    UNSIGNED company_fein_BestFeinCommon_Row_Cnt;
    UNSIGNED company_fein_BestFeinCommon_Orig_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinCommon_data_permits;
  END;
  R26 T26(J25 le,BestFeinCommon_method_company_fein ri) := TRANSFORM
    SELF.BestFeinCommon_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J26 := JOIN(J25,BestFeinCommon_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T26(LEFT,RIGHT),FULL OUTER,LOCAL);
// 27 - Gathering type:BestFeinCurrent Entries:1
  R27 := RECORD
    J26; // The data so far
    TYPEOF(BestFeinCurrent_method_company_fein.company_fein) BestFeinCurrent_company_fein;
    UNSIGNED company_fein_BestFeinCurrent_Row_Cnt;
    UNSIGNED company_fein_BestFeinCurrent_Orig_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinCurrent_data_permits;
  END;
  R27 T27(J26 le,BestFeinCurrent_method_company_fein ri) := TRANSFORM
    SELF.BestFeinCurrent_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J27 := JOIN(J26,BestFeinCurrent_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T27(LEFT,RIGHT),FULL OUTER,LOCAL);
// 28 - Gathering type:BestFeinVotedUnrestricted Entries:1
  R28 := RECORD
    J27; // The data so far
    TYPEOF(BestFeinVotedUnrestricted_method_company_fein.company_fein) BestFeinVotedUnrestricted_company_fein;
    UNSIGNED company_fein_BestFeinVotedUnrestricted_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinVotedUnrestricted_data_permits;
  END;
  R28 T28(J27 le,BestFeinVotedUnrestricted_method_company_fein ri) := TRANSFORM
    SELF.BestFeinVotedUnrestricted_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J28 := JOIN(J27,BestFeinVotedUnrestricted_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T28(LEFT,RIGHT),FULL OUTER,LOCAL);
// 29 - Gathering type:BestFeinMin Entries:1
  R29 := RECORD
    J28; // The data so far
    TYPEOF(BestFeinMin_method_company_fein.company_fein) BestFeinMin_company_fein;
    UNSIGNED company_fein_BestFeinMin_Row_Cnt;
    UNSIGNED company_fein_BestFeinMin_Orig_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinMin_data_permits;
  END;
  R29 T29(J28 le,BestFeinMin_method_company_fein ri) := TRANSFORM
    SELF.BestFeinMin_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinMin_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinMin_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinMin_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J29 := JOIN(J28,BestFeinMin_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T29(LEFT,RIGHT),FULL OUTER,LOCAL);
// 30 - Gathering type:BestFeinMax Entries:1
  R30 := RECORD
    J29; // The data so far
    TYPEOF(BestFeinMax_method_company_fein.company_fein) BestFeinMax_company_fein;
    UNSIGNED company_fein_BestFeinMax_Row_Cnt;
    UNSIGNED company_fein_BestFeinMax_Orig_Row_Cnt;
    UNSIGNED2 company_fein_BestFeinMax_data_permits;
  END;
  R30 T30(J29 le,BestFeinMax_method_company_fein ri) := TRANSFORM
    SELF.BestFeinMax_company_fein := ri.company_fein;
    SELF.company_fein_BestFeinMax_Row_Cnt := ri.Row_Cnt;
    SELF.company_fein_BestFeinMax_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.company_fein_BestFeinMax_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J30 := JOIN(J29,BestFeinMax_method_company_fein,LEFT.Seleid = RIGHT.Seleid,T30(LEFT,RIGHT),FULL OUTER,LOCAL);
// 31 - Gathering type:BestUrlCommon Entries:1
  R31 := RECORD
    J30; // The data so far
    TYPEOF(BestUrlCommon_method_company_url.company_url) BestUrlCommon_company_url;
    UNSIGNED company_url_BestUrlCommon_Row_Cnt;
    UNSIGNED2 company_url_BestUrlCommon_data_permits;
  END;
  R31 T31(J30 le,BestUrlCommon_method_company_url ri) := TRANSFORM
    SELF.BestUrlCommon_company_url := ri.company_url;
    SELF.company_url_BestUrlCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J31 := JOIN(J30,BestUrlCommon_method_company_url,LEFT.Seleid = RIGHT.Seleid,T31(LEFT,RIGHT),FULL OUTER,LOCAL);
// 32 - Gathering type:BestUrlCurrent Entries:1
  R32 := RECORD
    J31; // The data so far
    TYPEOF(BestUrlCurrent_method_company_url.company_url) BestUrlCurrent_company_url;
    UNSIGNED company_url_BestUrlCurrent_Row_Cnt;
    UNSIGNED2 company_url_BestUrlCurrent_data_permits;
  END;
  R32 T32(J31 le,BestUrlCurrent_method_company_url ri) := TRANSFORM
    SELF.BestUrlCurrent_company_url := ri.company_url;
    SELF.company_url_BestUrlCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J32 := JOIN(J31,BestUrlCurrent_method_company_url,LEFT.Seleid = RIGHT.Seleid,T32(LEFT,RIGHT),FULL OUTER,LOCAL);
// 33 - Gathering type:BestUrlLength Entries:1
  R33 := RECORD
    J32; // The data so far
    TYPEOF(BestUrlLength_method_company_url.company_url) BestUrlLength_company_url;
    UNSIGNED company_url_BestUrlLength_Row_Cnt;
    UNSIGNED2 company_url_BestUrlLength_data_permits;
  END;
  R33 T33(J32 le,BestUrlLength_method_company_url ri) := TRANSFORM
    SELF.BestUrlLength_company_url := ri.company_url;
    SELF.company_url_BestUrlLength_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlLength_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J33 := JOIN(J32,BestUrlLength_method_company_url,LEFT.Seleid = RIGHT.Seleid,T33(LEFT,RIGHT),FULL OUTER,LOCAL);
// 34 - Gathering type:BestUrlStrong Entries:1
  R34 := RECORD
    J33; // The data so far
    TYPEOF(BestUrlStrong_method_company_url.company_url) BestUrlStrong_company_url;
    UNSIGNED company_url_BestUrlStrong_Row_Cnt;
    UNSIGNED2 company_url_BestUrlStrong_data_permits;
  END;
  R34 T34(J33 le,BestUrlStrong_method_company_url ri) := TRANSFORM
    SELF.BestUrlStrong_company_url := ri.company_url;
    SELF.company_url_BestUrlStrong_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlStrong_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J34 := JOIN(J33,BestUrlStrong_method_company_url,LEFT.Seleid = RIGHT.Seleid,T34(LEFT,RIGHT),FULL OUTER,LOCAL);
// 35 - Gathering type:BestUrlVotedUnrestricted Entries:1
  R35 := RECORD
    J34; // The data so far
    TYPEOF(BestUrlVotedUnrestricted_method_company_url.company_url) BestUrlVotedUnrestricted_company_url;
    UNSIGNED company_url_BestUrlVotedUnrestricted_Row_Cnt;
    UNSIGNED2 company_url_BestUrlVotedUnrestricted_data_permits;
  END;
  R35 T35(J34 le,BestUrlVotedUnrestricted_method_company_url ri) := TRANSFORM
    SELF.BestUrlVotedUnrestricted_company_url := ri.company_url;
    SELF.company_url_BestUrlVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.company_url_BestUrlVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J35 := JOIN(J34,BestUrlVotedUnrestricted_method_company_url,LEFT.Seleid = RIGHT.Seleid,T35(LEFT,RIGHT),FULL OUTER,LOCAL);
// 36 - Gathering type:BestDunsCommon Entries:1
  R36 := RECORD
    J35; // The data so far
    TYPEOF(BestDunsCommon_method_duns_number.duns_number) BestDunsCommon_duns_number;
    UNSIGNED duns_number_BestDunsCommon_Row_Cnt;
    UNSIGNED duns_number_BestDunsCommon_Orig_Row_Cnt;
    UNSIGNED2 duns_number_BestDunsCommon_data_permits;
  END;
  R36 T36(J35 le,BestDunsCommon_method_duns_number ri) := TRANSFORM
    SELF.BestDunsCommon_duns_number := ri.duns_number;
    SELF.duns_number_BestDunsCommon_Row_Cnt := ri.Row_Cnt;
    SELF.duns_number_BestDunsCommon_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.duns_number_BestDunsCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J36 := JOIN(J35,BestDunsCommon_method_duns_number,LEFT.Seleid = RIGHT.Seleid,T36(LEFT,RIGHT),FULL OUTER,LOCAL);
// 37 - Gathering type:BestDunsCurrent Entries:1
  R37 := RECORD
    J36; // The data so far
    TYPEOF(BestDunsCurrent_method_duns_number.duns_number) BestDunsCurrent_duns_number;
    UNSIGNED duns_number_BestDunsCurrent_Row_Cnt;
    UNSIGNED duns_number_BestDunsCurrent_Orig_Row_Cnt;
    UNSIGNED2 duns_number_BestDunsCurrent_data_permits;
  END;
  R37 T37(J36 le,BestDunsCurrent_method_duns_number ri) := TRANSFORM
    SELF.BestDunsCurrent_duns_number := ri.duns_number;
    SELF.duns_number_BestDunsCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.duns_number_BestDunsCurrent_Orig_Row_Cnt := ri.Orig_Row_Cnt;
    SELF.duns_number_BestDunsCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J37 := JOIN(J36,BestDunsCurrent_method_duns_number,LEFT.Seleid = RIGHT.Seleid,T37(LEFT,RIGHT),FULL OUTER,LOCAL);
// 38 - Gathering type:BestDunsCurrent2 Entries:1
  R38 := RECORD
    J37; // The data so far
    TYPEOF(BestDunsCurrent2_method_duns_number.duns_number) BestDunsCurrent2_duns_number;
    UNSIGNED duns_number_BestDunsCurrent2_Row_Cnt;
    UNSIGNED2 duns_number_BestDunsCurrent2_data_permits;
  END;
  R38 T38(J37 le,BestDunsCurrent2_method_duns_number ri) := TRANSFORM
    SELF.BestDunsCurrent2_duns_number := ri.duns_number;
    SELF.duns_number_BestDunsCurrent2_Row_Cnt := ri.Row_Cnt;
    SELF.duns_number_BestDunsCurrent2_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J38 := JOIN(J37,BestDunsCurrent2_method_duns_number,LEFT.Seleid = RIGHT.Seleid,T38(LEFT,RIGHT),FULL OUTER,LOCAL);
// 39 - Gathering type:BestDunsVotedUnrestricted Entries:1
  R39 := RECORD
    J38; // The data so far
    TYPEOF(BestDunsVotedUnrestricted_method_duns_number.duns_number) BestDunsVotedUnrestricted_duns_number;
    UNSIGNED duns_number_BestDunsVotedUnrestricted_Row_Cnt;
    UNSIGNED2 duns_number_BestDunsVotedUnrestricted_data_permits;
  END;
  R39 T39(J38 le,BestDunsVotedUnrestricted_method_duns_number ri) := TRANSFORM
    SELF.BestDunsVotedUnrestricted_duns_number := ri.duns_number;
    SELF.duns_number_BestDunsVotedUnrestricted_Row_Cnt := ri.Row_Cnt;
    SELF.duns_number_BestDunsVotedUnrestricted_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J39 := JOIN(J38,BestDunsVotedUnrestricted_method_duns_number,LEFT.Seleid = RIGHT.Seleid,T39(LEFT,RIGHT),FULL OUTER,LOCAL);
// 40 - Gathering type:BestSicCommon Entries:1
  R40 := RECORD
    J39; // The data so far
    TYPEOF(BestSicCommon_method_company_sic_code1.company_sic_code1) BestSicCommon_company_sic_code1;
    UNSIGNED company_sic_code1_BestSicCommon_Row_Cnt;
    UNSIGNED2 company_sic_code1_BestSicCommon_data_permits;
  END;
  R40 T40(J39 le,BestSicCommon_method_company_sic_code1 ri) := TRANSFORM
    SELF.BestSicCommon_company_sic_code1 := ri.company_sic_code1;
    SELF.company_sic_code1_BestSicCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_sic_code1_BestSicCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J40 := JOIN(J39,BestSicCommon_method_company_sic_code1,LEFT.Seleid = RIGHT.Seleid,T40(LEFT,RIGHT),FULL OUTER,LOCAL);
// 41 - Gathering type:BestSicCurrent Entries:1
  R41 := RECORD
    J40; // The data so far
    TYPEOF(BestSicCurrent_method_company_sic_code1.company_sic_code1) BestSicCurrent_company_sic_code1;
    UNSIGNED company_sic_code1_BestSicCurrent_Row_Cnt;
    UNSIGNED2 company_sic_code1_BestSicCurrent_data_permits;
  END;
  R41 T41(J40 le,BestSicCurrent_method_company_sic_code1 ri) := TRANSFORM
    SELF.BestSicCurrent_company_sic_code1 := ri.company_sic_code1;
    SELF.company_sic_code1_BestSicCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_sic_code1_BestSicCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J41 := JOIN(J40,BestSicCurrent_method_company_sic_code1,LEFT.Seleid = RIGHT.Seleid,T41(LEFT,RIGHT),FULL OUTER,LOCAL);
// 42 - Gathering type:BestNaicsCommon Entries:1
  R42 := RECORD
    J41; // The data so far
    TYPEOF(BestNaicsCommon_method_company_naics_code1.company_naics_code1) BestNaicsCommon_company_naics_code1;
    UNSIGNED company_naics_code1_BestNaicsCommon_Row_Cnt;
    UNSIGNED2 company_naics_code1_BestNaicsCommon_data_permits;
  END;
  R42 T42(J41 le,BestNaicsCommon_method_company_naics_code1 ri) := TRANSFORM
    SELF.BestNaicsCommon_company_naics_code1 := ri.company_naics_code1;
    SELF.company_naics_code1_BestNaicsCommon_Row_Cnt := ri.Row_Cnt;
    SELF.company_naics_code1_BestNaicsCommon_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J42 := JOIN(J41,BestNaicsCommon_method_company_naics_code1,LEFT.Seleid = RIGHT.Seleid,T42(LEFT,RIGHT),FULL OUTER,LOCAL);
// 43 - Gathering type:BestNaicsCurrent Entries:1
  R43 := RECORD
    J42; // The data so far
    TYPEOF(BestNaicsCurrent_method_company_naics_code1.company_naics_code1) BestNaicsCurrent_company_naics_code1;
    UNSIGNED company_naics_code1_BestNaicsCurrent_Row_Cnt;
    UNSIGNED2 company_naics_code1_BestNaicsCurrent_data_permits;
  END;
  R43 T43(J42 le,BestNaicsCurrent_method_company_naics_code1 ri) := TRANSFORM
    SELF.BestNaicsCurrent_company_naics_code1 := ri.company_naics_code1;
    SELF.company_naics_code1_BestNaicsCurrent_Row_Cnt := ri.Row_Cnt;
    SELF.company_naics_code1_BestNaicsCurrent_data_permits := ri.data_permits;
    BOOLEAN has_left := le.Seleid <> (TYPEOF(le.Seleid))''; // See if LHS is null
    SELF.Seleid := IF( has_left, le.Seleid, ri.Seleid );
    SELF := le;
  END;
  J43 := JOIN(J42,BestNaicsCurrent_method_company_naics_code1,LEFT.Seleid = RIGHT.Seleid,T43(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_Seleid_np := J43;
EXPORT BestBy_Seleid := BestBy_Seleid_np : PERSIST('~temp::Seleid::BIPV2_Best_Seleid::best::BestBy_Seleid',EXPIRE(Config.PersistExpire));
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 BestCompanyNameLegal_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameLegal_company_name=(typeof(BestBy_Seleid.BestCompanyNameLegal_company_name))'',0,100));
    UNSIGNED BestCompanyNameLegal_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&1<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&2<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&4<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&8<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&16<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&32<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&64<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&128<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&256<>0);
    UNSIGNED BestCompanyNameLegal_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLegal_data_permits&512<>0);
    REAL8 BestCompanyNameVotedSeleLevel_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameVotedSeleLevel_company_name=(typeof(BestBy_Seleid.BestCompanyNameVotedSeleLevel_company_name))'',0,100));
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&1<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&2<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&4<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&8<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&16<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&32<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&64<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&128<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&256<>0);
    UNSIGNED BestCompanyNameVotedSeleLevel_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedSeleLevel_data_permits&512<>0);
    REAL8 BestCompanyNameCommon_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameCommon_company_name=(typeof(BestBy_Seleid.BestCompanyNameCommon_company_name))'',0,100));
    UNSIGNED BestCompanyNameCommon_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&1<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&2<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&4<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&8<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&16<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&32<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&64<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&128<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&256<>0);
    UNSIGNED BestCompanyNameCommon_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCommon_data_permits&512<>0);
    REAL8 BestCompanyNameCurrent_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameCurrent_company_name=(typeof(BestBy_Seleid.BestCompanyNameCurrent_company_name))'',0,100));
    UNSIGNED BestCompanyNameCurrent_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&16<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&32<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&64<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&128<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&256<>0);
    UNSIGNED BestCompanyNameCurrent_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent_data_permits&512<>0);
    REAL8 BestCompanyNameVoted_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameVoted_company_name=(typeof(BestBy_Seleid.BestCompanyNameVoted_company_name))'',0,100));
    UNSIGNED BestCompanyNameVoted_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&1<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&2<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&4<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&8<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&16<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&32<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&64<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&128<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&256<>0);
    UNSIGNED BestCompanyNameVoted_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVoted_data_permits&512<>0);
    REAL8 BestCompanyNameLength_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameLength_company_name=(typeof(BestBy_Seleid.BestCompanyNameLength_company_name))'',0,100));
    UNSIGNED BestCompanyNameLength_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&1<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&2<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&4<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&8<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&16<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&32<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&64<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&128<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&256<>0);
    UNSIGNED BestCompanyNameLength_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameLength_data_permits&512<>0);
    REAL8 BestCompanyNameStrong_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameStrong_company_name=(typeof(BestBy_Seleid.BestCompanyNameStrong_company_name))'',0,100));
    UNSIGNED BestCompanyNameStrong_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&1<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&2<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&4<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&8<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&16<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&32<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&64<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&128<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&256<>0);
    UNSIGNED BestCompanyNameStrong_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameStrong_data_permits&512<>0);
    REAL8 BestCompanyNameCurrent2_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameCurrent2_company_name=(typeof(BestBy_Seleid.BestCompanyNameCurrent2_company_name))'',0,100));
    UNSIGNED BestCompanyNameCurrent2_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&1<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&2<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&4<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&8<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&16<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&32<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&64<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&128<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&256<>0);
    UNSIGNED BestCompanyNameCurrent2_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameCurrent2_data_permits&512<>0);
    REAL8 BestCompanyNameVotedUnrestricted_company_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyNameVotedUnrestricted_company_name=(typeof(BestBy_Seleid.BestCompanyNameVotedUnrestricted_company_name))'',0,100));
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestCompanyNameVotedUnrestricted_company_name_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_name_BestCompanyNameVotedUnrestricted_data_permits&512<>0);
    REAL8 BestCompanyAddressVotedSeleLevel_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_predir))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_st=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_st))'',0,100));
    REAL8 BestCompanyAddressVotedSeleLevel_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressVotedSeleLevel_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&16<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&32<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&64<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&128<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&256<>0);
    UNSIGNED BestCompanyAddressVotedSeleLevel_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSeleLevel_data_permits&512<>0);
    REAL8 BestCompanyAddressVoted_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVoted_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_predir))'',0,100));
    REAL8 BestCompanyAddressVoted_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVoted_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVoted_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVoted_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVoted_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVoted_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_st=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_st))'',0,100));
    REAL8 BestCompanyAddressVoted_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVoted_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressVoted_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVoted_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&16<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&32<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&64<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&128<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&256<>0);
    UNSIGNED BestCompanyAddressVoted_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVoted_data_permits&512<>0);
    REAL8 BestCompanyAddressCurrent_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_predir))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_st=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_st))'',0,100));
    REAL8 BestCompanyAddressCurrent_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressCurrent_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCurrent_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&16<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&32<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&64<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&128<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&256<>0);
    UNSIGNED BestCompanyAddressCurrent_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent_data_permits&512<>0);
    REAL8 BestCompanyAddressVotedSrc_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_predir))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_st=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_st))'',0,100));
    REAL8 BestCompanyAddressVotedSrc_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedSrc_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressVotedSrc_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVotedSrc_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&16<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&32<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&64<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&128<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&256<>0);
    UNSIGNED BestCompanyAddressVotedSrc_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedSrc_data_permits&512<>0);
    REAL8 BestCompanyAddressCommon_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCommon_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_predir))'',0,100));
    REAL8 BestCompanyAddressCommon_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCommon_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCommon_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCommon_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCommon_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCommon_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_st=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_st))'',0,100));
    REAL8 BestCompanyAddressCommon_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCommon_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressCommon_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCommon_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&16<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&32<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&64<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&128<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&256<>0);
    UNSIGNED BestCompanyAddressCommon_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCommon_data_permits&512<>0);
    REAL8 BestCompanyAddressStrong_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressStrong_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_predir))'',0,100));
    REAL8 BestCompanyAddressStrong_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressStrong_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressStrong_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_postdir))'',0,100));
    REAL8 BestCompanyAddressStrong_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressStrong_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressStrong_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_st=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_st))'',0,100));
    REAL8 BestCompanyAddressStrong_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressStrong_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressStrong_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressStrong_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&1<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&2<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&4<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&8<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&16<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&32<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&64<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&128<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&256<>0);
    UNSIGNED BestCompanyAddressStrong_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressStrong_data_permits&512<>0);
    REAL8 BestCompanyAddressCurrent2_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_predir))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_postdir))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_st=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_st))'',0,100));
    REAL8 BestCompanyAddressCurrent2_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressCurrent2_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressCurrent2_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressCurrent2_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&1<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&2<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&4<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&8<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&16<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&32<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&64<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&128<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&256<>0);
    UNSIGNED BestCompanyAddressCurrent2_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressCurrent2_data_permits&512<>0);
    REAL8 BestCompanyAddressVotedUnrestricted_address_prim_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_prim_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_prim_range))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_predir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_predir=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_predir))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_prim_name_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_prim_name=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_prim_name))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_addr_suffix_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_addr_suffix=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_addr_suffix))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_postdir_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_postdir=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_postdir))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_unit_desig_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_unit_desig=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_unit_desig))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_sec_range_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_sec_range=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_sec_range))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_st_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_st=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_st))'',0,100));
    REAL8 BestCompanyAddressVotedUnrestricted_address_zip_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_zip=(typeof(BestBy_Seleid.BestCompanyAddressVotedUnrestricted_address_zip))'',0,100));
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit1_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit2_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit3_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit4_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit5_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit6_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit7_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit8_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit9_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestCompanyAddressVotedUnrestricted_address_permit10_cnt := COUNT(GROUP,BestBy_Seleid.address_BestCompanyAddressVotedUnrestricted_data_permits&512<>0);
    REAL8 BestPhoneVotedSeleLevelWithNpa_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneVotedSeleLevelWithNpa_company_phone=(typeof(BestBy_Seleid.BestPhoneVotedSeleLevelWithNpa_company_phone))'',0,100));
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&1<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&2<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&4<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&8<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&16<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&32<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&64<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&128<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&256<>0);
    UNSIGNED BestPhoneVotedSeleLevelWithNpa_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits&512<>0);
    REAL8 BestPhoneCurrentWithNpa_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneCurrentWithNpa_company_phone=(typeof(BestBy_Seleid.BestPhoneCurrentWithNpa_company_phone))'',0,100));
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&1<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&2<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&4<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&8<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&16<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&32<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&64<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&128<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&256<>0);
    UNSIGNED BestPhoneCurrentWithNpa_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrentWithNpa_data_permits&512<>0);
    REAL8 BestPhoneCurrent_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneCurrent_company_phone=(typeof(BestBy_Seleid.BestPhoneCurrent_company_phone))'',0,100));
    UNSIGNED BestPhoneCurrent_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&1<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&2<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&4<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&8<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&16<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&32<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&64<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&128<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&256<>0);
    UNSIGNED BestPhoneCurrent_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCurrent_data_permits&512<>0);
    REAL8 BestPhoneVoted_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneVoted_company_phone=(typeof(BestBy_Seleid.BestPhoneVoted_company_phone))'',0,100));
    UNSIGNED BestPhoneVoted_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&1<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&2<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&4<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&8<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&16<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&32<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&64<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&128<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&256<>0);
    UNSIGNED BestPhoneVoted_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVoted_data_permits&512<>0);
    REAL8 BestPhoneLongest_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneLongest_company_phone=(typeof(BestBy_Seleid.BestPhoneLongest_company_phone))'',0,100));
    UNSIGNED BestPhoneLongest_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&1<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&2<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&4<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&8<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&16<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&32<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&64<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&128<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&256<>0);
    UNSIGNED BestPhoneLongest_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneLongest_data_permits&512<>0);
    REAL8 BestPhoneStrong_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneStrong_company_phone=(typeof(BestBy_Seleid.BestPhoneStrong_company_phone))'',0,100));
    UNSIGNED BestPhoneStrong_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&1<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&2<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&4<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&8<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&16<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&32<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&64<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&128<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&256<>0);
    UNSIGNED BestPhoneStrong_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneStrong_data_permits&512<>0);
    REAL8 BestPhoneVotedUnrestricted_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneVotedUnrestricted_company_phone=(typeof(BestBy_Seleid.BestPhoneVotedUnrestricted_company_phone))'',0,100));
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestPhoneVotedUnrestricted_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneVotedUnrestricted_data_permits&512<>0);
    REAL8 BestPhoneCommon_company_phone_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestPhoneCommon_company_phone=(typeof(BestBy_Seleid.BestPhoneCommon_company_phone))'',0,100));
    UNSIGNED BestPhoneCommon_company_phone_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&1<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&2<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&4<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&8<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&16<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&32<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&64<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&128<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&256<>0);
    UNSIGNED BestPhoneCommon_company_phone_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_phone_BestPhoneCommon_data_permits&512<>0);
    REAL8 BestFeinStrong_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinStrong_company_fein=(typeof(BestBy_Seleid.BestFeinStrong_company_fein))'',0,100));
    UNSIGNED BestFeinStrong_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&1<>0);
    UNSIGNED BestFeinStrong_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&2<>0);
    UNSIGNED BestFeinStrong_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&4<>0);
    UNSIGNED BestFeinStrong_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&8<>0);
    UNSIGNED BestFeinStrong_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&16<>0);
    UNSIGNED BestFeinStrong_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&32<>0);
    UNSIGNED BestFeinStrong_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&64<>0);
    UNSIGNED BestFeinStrong_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&128<>0);
    UNSIGNED BestFeinStrong_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&256<>0);
    UNSIGNED BestFeinStrong_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinStrong_data_permits&512<>0);
    REAL8 BestFeinCommon_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinCommon_company_fein=(typeof(BestBy_Seleid.BestFeinCommon_company_fein))'',0,100));
    UNSIGNED BestFeinCommon_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&1<>0);
    UNSIGNED BestFeinCommon_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&2<>0);
    UNSIGNED BestFeinCommon_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&4<>0);
    UNSIGNED BestFeinCommon_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&8<>0);
    UNSIGNED BestFeinCommon_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&16<>0);
    UNSIGNED BestFeinCommon_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&32<>0);
    UNSIGNED BestFeinCommon_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&64<>0);
    UNSIGNED BestFeinCommon_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&128<>0);
    UNSIGNED BestFeinCommon_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&256<>0);
    UNSIGNED BestFeinCommon_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCommon_data_permits&512<>0);
    REAL8 BestFeinCurrent_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinCurrent_company_fein=(typeof(BestBy_Seleid.BestFeinCurrent_company_fein))'',0,100));
    UNSIGNED BestFeinCurrent_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&1<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&2<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&4<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&8<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&16<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&32<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&64<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&128<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&256<>0);
    UNSIGNED BestFeinCurrent_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinCurrent_data_permits&512<>0);
    REAL8 BestFeinVotedUnrestricted_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinVotedUnrestricted_company_fein=(typeof(BestBy_Seleid.BestFeinVotedUnrestricted_company_fein))'',0,100));
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestFeinVotedUnrestricted_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinVotedUnrestricted_data_permits&512<>0);
    REAL8 BestFeinMin_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinMin_company_fein=(typeof(BestBy_Seleid.BestFeinMin_company_fein))'',0,100));
    UNSIGNED BestFeinMin_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&1<>0);
    UNSIGNED BestFeinMin_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&2<>0);
    UNSIGNED BestFeinMin_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&4<>0);
    UNSIGNED BestFeinMin_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&8<>0);
    UNSIGNED BestFeinMin_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&16<>0);
    UNSIGNED BestFeinMin_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&32<>0);
    UNSIGNED BestFeinMin_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&64<>0);
    UNSIGNED BestFeinMin_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&128<>0);
    UNSIGNED BestFeinMin_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&256<>0);
    UNSIGNED BestFeinMin_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMin_data_permits&512<>0);
    REAL8 BestFeinMax_company_fein_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestFeinMax_company_fein=(typeof(BestBy_Seleid.BestFeinMax_company_fein))'',0,100));
    UNSIGNED BestFeinMax_company_fein_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&1<>0);
    UNSIGNED BestFeinMax_company_fein_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&2<>0);
    UNSIGNED BestFeinMax_company_fein_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&4<>0);
    UNSIGNED BestFeinMax_company_fein_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&8<>0);
    UNSIGNED BestFeinMax_company_fein_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&16<>0);
    UNSIGNED BestFeinMax_company_fein_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&32<>0);
    UNSIGNED BestFeinMax_company_fein_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&64<>0);
    UNSIGNED BestFeinMax_company_fein_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&128<>0);
    UNSIGNED BestFeinMax_company_fein_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&256<>0);
    UNSIGNED BestFeinMax_company_fein_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_fein_BestFeinMax_data_permits&512<>0);
    REAL8 BestUrlCommon_company_url_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestUrlCommon_company_url=(typeof(BestBy_Seleid.BestUrlCommon_company_url))'',0,100));
    UNSIGNED BestUrlCommon_company_url_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&1<>0);
    UNSIGNED BestUrlCommon_company_url_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&2<>0);
    UNSIGNED BestUrlCommon_company_url_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&4<>0);
    UNSIGNED BestUrlCommon_company_url_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&8<>0);
    UNSIGNED BestUrlCommon_company_url_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&16<>0);
    UNSIGNED BestUrlCommon_company_url_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&32<>0);
    UNSIGNED BestUrlCommon_company_url_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&64<>0);
    UNSIGNED BestUrlCommon_company_url_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&128<>0);
    UNSIGNED BestUrlCommon_company_url_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&256<>0);
    UNSIGNED BestUrlCommon_company_url_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCommon_data_permits&512<>0);
    REAL8 BestUrlCurrent_company_url_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestUrlCurrent_company_url=(typeof(BestBy_Seleid.BestUrlCurrent_company_url))'',0,100));
    UNSIGNED BestUrlCurrent_company_url_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&1<>0);
    UNSIGNED BestUrlCurrent_company_url_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&2<>0);
    UNSIGNED BestUrlCurrent_company_url_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&4<>0);
    UNSIGNED BestUrlCurrent_company_url_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&8<>0);
    UNSIGNED BestUrlCurrent_company_url_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&16<>0);
    UNSIGNED BestUrlCurrent_company_url_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&32<>0);
    UNSIGNED BestUrlCurrent_company_url_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&64<>0);
    UNSIGNED BestUrlCurrent_company_url_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&128<>0);
    UNSIGNED BestUrlCurrent_company_url_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&256<>0);
    UNSIGNED BestUrlCurrent_company_url_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlCurrent_data_permits&512<>0);
    REAL8 BestUrlLength_company_url_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestUrlLength_company_url=(typeof(BestBy_Seleid.BestUrlLength_company_url))'',0,100));
    UNSIGNED BestUrlLength_company_url_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&1<>0);
    UNSIGNED BestUrlLength_company_url_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&2<>0);
    UNSIGNED BestUrlLength_company_url_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&4<>0);
    UNSIGNED BestUrlLength_company_url_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&8<>0);
    UNSIGNED BestUrlLength_company_url_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&16<>0);
    UNSIGNED BestUrlLength_company_url_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&32<>0);
    UNSIGNED BestUrlLength_company_url_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&64<>0);
    UNSIGNED BestUrlLength_company_url_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&128<>0);
    UNSIGNED BestUrlLength_company_url_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&256<>0);
    UNSIGNED BestUrlLength_company_url_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlLength_data_permits&512<>0);
    REAL8 BestUrlStrong_company_url_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestUrlStrong_company_url=(typeof(BestBy_Seleid.BestUrlStrong_company_url))'',0,100));
    UNSIGNED BestUrlStrong_company_url_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&1<>0);
    UNSIGNED BestUrlStrong_company_url_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&2<>0);
    UNSIGNED BestUrlStrong_company_url_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&4<>0);
    UNSIGNED BestUrlStrong_company_url_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&8<>0);
    UNSIGNED BestUrlStrong_company_url_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&16<>0);
    UNSIGNED BestUrlStrong_company_url_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&32<>0);
    UNSIGNED BestUrlStrong_company_url_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&64<>0);
    UNSIGNED BestUrlStrong_company_url_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&128<>0);
    UNSIGNED BestUrlStrong_company_url_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&256<>0);
    UNSIGNED BestUrlStrong_company_url_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlStrong_data_permits&512<>0);
    REAL8 BestUrlVotedUnrestricted_company_url_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestUrlVotedUnrestricted_company_url=(typeof(BestBy_Seleid.BestUrlVotedUnrestricted_company_url))'',0,100));
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestUrlVotedUnrestricted_company_url_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_url_BestUrlVotedUnrestricted_data_permits&512<>0);
    REAL8 BestDunsCommon_duns_number_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestDunsCommon_duns_number=(typeof(BestBy_Seleid.BestDunsCommon_duns_number))'',0,100));
    UNSIGNED BestDunsCommon_duns_number_permit1_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&1<>0);
    UNSIGNED BestDunsCommon_duns_number_permit2_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&2<>0);
    UNSIGNED BestDunsCommon_duns_number_permit3_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&4<>0);
    UNSIGNED BestDunsCommon_duns_number_permit4_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&8<>0);
    UNSIGNED BestDunsCommon_duns_number_permit5_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&16<>0);
    UNSIGNED BestDunsCommon_duns_number_permit6_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&32<>0);
    UNSIGNED BestDunsCommon_duns_number_permit7_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&64<>0);
    UNSIGNED BestDunsCommon_duns_number_permit8_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&128<>0);
    UNSIGNED BestDunsCommon_duns_number_permit9_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&256<>0);
    UNSIGNED BestDunsCommon_duns_number_permit10_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCommon_data_permits&512<>0);
    REAL8 BestDunsCurrent_duns_number_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestDunsCurrent_duns_number=(typeof(BestBy_Seleid.BestDunsCurrent_duns_number))'',0,100));
    UNSIGNED BestDunsCurrent_duns_number_permit1_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&1<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit2_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&2<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit3_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&4<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit4_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&8<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit5_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&16<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit6_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&32<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit7_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&64<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit8_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&128<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit9_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&256<>0);
    UNSIGNED BestDunsCurrent_duns_number_permit10_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent_data_permits&512<>0);
    REAL8 BestDunsCurrent2_duns_number_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestDunsCurrent2_duns_number=(typeof(BestBy_Seleid.BestDunsCurrent2_duns_number))'',0,100));
    UNSIGNED BestDunsCurrent2_duns_number_permit1_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&1<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit2_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&2<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit3_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&4<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit4_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&8<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit5_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&16<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit6_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&32<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit7_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&64<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit8_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&128<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit9_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&256<>0);
    UNSIGNED BestDunsCurrent2_duns_number_permit10_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsCurrent2_data_permits&512<>0);
    REAL8 BestDunsVotedUnrestricted_duns_number_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestDunsVotedUnrestricted_duns_number=(typeof(BestBy_Seleid.BestDunsVotedUnrestricted_duns_number))'',0,100));
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit1_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&1<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit2_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&2<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit3_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&4<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit4_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&8<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit5_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&16<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit6_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&32<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit7_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&64<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit8_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&128<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit9_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&256<>0);
    UNSIGNED BestDunsVotedUnrestricted_duns_number_permit10_cnt := COUNT(GROUP,BestBy_Seleid.duns_number_BestDunsVotedUnrestricted_data_permits&512<>0);
    REAL8 BestSicCommon_company_sic_code1_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestSicCommon_company_sic_code1=(typeof(BestBy_Seleid.BestSicCommon_company_sic_code1))'',0,100));
    UNSIGNED BestSicCommon_company_sic_code1_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&1<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&2<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&4<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&8<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&16<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&32<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&64<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&128<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&256<>0);
    UNSIGNED BestSicCommon_company_sic_code1_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCommon_data_permits&512<>0);
    REAL8 BestSicCurrent_company_sic_code1_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestSicCurrent_company_sic_code1=(typeof(BestBy_Seleid.BestSicCurrent_company_sic_code1))'',0,100));
    UNSIGNED BestSicCurrent_company_sic_code1_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&1<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&2<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&4<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&8<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&16<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&32<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&64<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&128<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&256<>0);
    UNSIGNED BestSicCurrent_company_sic_code1_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_sic_code1_BestSicCurrent_data_permits&512<>0);
    REAL8 BestNaicsCommon_company_naics_code1_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestNaicsCommon_company_naics_code1=(typeof(BestBy_Seleid.BestNaicsCommon_company_naics_code1))'',0,100));
    UNSIGNED BestNaicsCommon_company_naics_code1_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&1<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&2<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&4<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&8<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&16<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&32<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&64<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&128<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&256<>0);
    UNSIGNED BestNaicsCommon_company_naics_code1_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCommon_data_permits&512<>0);
    REAL8 BestNaicsCurrent_company_naics_code1_pcnt := AVE(GROUP,IF(BestBy_Seleid.BestNaicsCurrent_company_naics_code1=(typeof(BestBy_Seleid.BestNaicsCurrent_company_naics_code1))'',0,100));
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit1_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&1<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit2_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&2<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit3_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&4<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit4_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&8<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit5_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&16<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit6_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&32<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit7_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&64<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit8_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&128<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit9_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&256<>0);
    UNSIGNED BestNaicsCurrent_company_naics_code1_permit10_cnt := COUNT(GROUP,BestBy_Seleid.company_naics_code1_BestNaicsCurrent_data_permits&512<>0);
  END;
EXPORT BestBy_Seleid_population := TABLE(BestBy_Seleid,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_Seleid(DATASET({BestBy_Seleid}) d) := FUNCTION
  company_name_case_layout := RECORD
    TYPEOF(h.company_name) company_name;
    UNSIGNED2 company_name_data_permits;
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
    UNSIGNED2 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_phone_case_layout := RECORD
    TYPEOF(h.company_phone) company_phone;
    UNSIGNED2 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_fein_case_layout := RECORD
    TYPEOF(h.company_fein) company_fein;
    UNSIGNED2 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
  END;
  company_url_case_layout := RECORD
    TYPEOF(h.company_url) company_url;
    UNSIGNED2 company_url_data_permits;
    UNSIGNED1 company_url_method; // This value could come from multiple BESTTYPE; track which one
  END;
  duns_number_case_layout := RECORD
    TYPEOF(h.duns_number) duns_number;
    UNSIGNED2 duns_number_data_permits;
    UNSIGNED1 duns_number_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_sic_code1_case_layout := RECORD
    TYPEOF(h.company_sic_code1) company_sic_code1;
    UNSIGNED2 company_sic_code1_data_permits;
    UNSIGNED1 company_sic_code1_method; // This value could come from multiple BESTTYPE; track which one
  END;
  company_naics_code1_case_layout := RECORD
    TYPEOF(h.company_naics_code1) company_naics_code1;
    UNSIGNED2 company_naics_code1_data_permits;
    UNSIGNED1 company_naics_code1_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R := RECORD
    typeof(h.Seleid) Seleid := 0;
    DATASET(company_name_case_layout) company_name_cases;
    DATASET(address_case_layout) address_cases;
    DATASET(company_phone_case_layout) company_phone_cases;
    DATASET(company_fein_case_layout) company_fein_cases;
    DATASET(company_url_case_layout) company_url_cases;
    DATASET(duns_number_case_layout) duns_number_cases;
    DATASET(company_sic_code1_case_layout) company_sic_code1_cases;
    DATASET(company_naics_code1_case_layout) company_naics_code1_cases;
  END;
  R T(BestBy_Seleid le) := TRANSFORM
    SELF.company_name_cases := DATASET([
        {le.BestCompanyNameLegal_company_name,le.company_name_BestCompanyNameLegal_data_permits,1},
        {le.BestCompanyNameVotedSeleLevel_company_name,le.company_name_BestCompanyNameVotedSeleLevel_data_permits,2},
        {le.BestCompanyNameCommon_company_name,le.company_name_BestCompanyNameCommon_data_permits,3},
        {le.BestCompanyNameCurrent_company_name,le.company_name_BestCompanyNameCurrent_data_permits,4},
        {le.BestCompanyNameVoted_company_name,le.company_name_BestCompanyNameVoted_data_permits,5},
        {le.BestCompanyNameLength_company_name,le.company_name_BestCompanyNameLength_data_permits,6},
        {le.BestCompanyNameStrong_company_name,le.company_name_BestCompanyNameStrong_data_permits,7},
        {le.BestCompanyNameCurrent2_company_name,le.company_name_BestCompanyNameCurrent2_data_permits,8},
        {le.BestCompanyNameVotedUnrestricted_company_name,le.company_name_BestCompanyNameVotedUnrestricted_data_permits,9}
          ],company_name_case_layout)(company_name NOT IN SET(s.nulls_company_name,company_name));
    SELF.address_cases := DATASET([
        {le.BestCompanyAddressVotedSeleLevel_address_prim_range,le.BestCompanyAddressVotedSeleLevel_address_predir,le.BestCompanyAddressVotedSeleLevel_address_prim_name,le.BestCompanyAddressVotedSeleLevel_address_addr_suffix,le.BestCompanyAddressVotedSeleLevel_address_postdir,le.BestCompanyAddressVotedSeleLevel_address_unit_desig,le.BestCompanyAddressVotedSeleLevel_address_sec_range,le.BestCompanyAddressVotedSeleLevel_address_st,le.BestCompanyAddressVotedSeleLevel_address_zip,le.address_BestCompanyAddressVotedSeleLevel_data_permits,1},
        {le.BestCompanyAddressVoted_address_prim_range,le.BestCompanyAddressVoted_address_predir,le.BestCompanyAddressVoted_address_prim_name,le.BestCompanyAddressVoted_address_addr_suffix,le.BestCompanyAddressVoted_address_postdir,le.BestCompanyAddressVoted_address_unit_desig,le.BestCompanyAddressVoted_address_sec_range,le.BestCompanyAddressVoted_address_st,le.BestCompanyAddressVoted_address_zip,le.address_BestCompanyAddressVoted_data_permits,2},
        {le.BestCompanyAddressCurrent_address_prim_range,le.BestCompanyAddressCurrent_address_predir,le.BestCompanyAddressCurrent_address_prim_name,le.BestCompanyAddressCurrent_address_addr_suffix,le.BestCompanyAddressCurrent_address_postdir,le.BestCompanyAddressCurrent_address_unit_desig,le.BestCompanyAddressCurrent_address_sec_range,le.BestCompanyAddressCurrent_address_st,le.BestCompanyAddressCurrent_address_zip,le.address_BestCompanyAddressCurrent_data_permits,3},
        {le.BestCompanyAddressVotedSrc_address_prim_range,le.BestCompanyAddressVotedSrc_address_predir,le.BestCompanyAddressVotedSrc_address_prim_name,le.BestCompanyAddressVotedSrc_address_addr_suffix,le.BestCompanyAddressVotedSrc_address_postdir,le.BestCompanyAddressVotedSrc_address_unit_desig,le.BestCompanyAddressVotedSrc_address_sec_range,le.BestCompanyAddressVotedSrc_address_st,le.BestCompanyAddressVotedSrc_address_zip,le.address_BestCompanyAddressVotedSrc_data_permits,4},
        {le.BestCompanyAddressCommon_address_prim_range,le.BestCompanyAddressCommon_address_predir,le.BestCompanyAddressCommon_address_prim_name,le.BestCompanyAddressCommon_address_addr_suffix,le.BestCompanyAddressCommon_address_postdir,le.BestCompanyAddressCommon_address_unit_desig,le.BestCompanyAddressCommon_address_sec_range,le.BestCompanyAddressCommon_address_st,le.BestCompanyAddressCommon_address_zip,le.address_BestCompanyAddressCommon_data_permits,5},
        {le.BestCompanyAddressStrong_address_prim_range,le.BestCompanyAddressStrong_address_predir,le.BestCompanyAddressStrong_address_prim_name,le.BestCompanyAddressStrong_address_addr_suffix,le.BestCompanyAddressStrong_address_postdir,le.BestCompanyAddressStrong_address_unit_desig,le.BestCompanyAddressStrong_address_sec_range,le.BestCompanyAddressStrong_address_st,le.BestCompanyAddressStrong_address_zip,le.address_BestCompanyAddressStrong_data_permits,6},
        {le.BestCompanyAddressCurrent2_address_prim_range,le.BestCompanyAddressCurrent2_address_predir,le.BestCompanyAddressCurrent2_address_prim_name,le.BestCompanyAddressCurrent2_address_addr_suffix,le.BestCompanyAddressCurrent2_address_postdir,le.BestCompanyAddressCurrent2_address_unit_desig,le.BestCompanyAddressCurrent2_address_sec_range,le.BestCompanyAddressCurrent2_address_st,le.BestCompanyAddressCurrent2_address_zip,le.address_BestCompanyAddressCurrent2_data_permits,7},
        {le.BestCompanyAddressVotedUnrestricted_address_prim_range,le.BestCompanyAddressVotedUnrestricted_address_predir,le.BestCompanyAddressVotedUnrestricted_address_prim_name,le.BestCompanyAddressVotedUnrestricted_address_addr_suffix,le.BestCompanyAddressVotedUnrestricted_address_postdir,le.BestCompanyAddressVotedUnrestricted_address_unit_desig,le.BestCompanyAddressVotedUnrestricted_address_sec_range,le.BestCompanyAddressVotedUnrestricted_address_st,le.BestCompanyAddressVotedUnrestricted_address_zip,le.address_BestCompanyAddressVotedUnrestricted_data_permits,8}
          ],address_case_layout)(address_prim_range NOT IN SET(s.nulls_prim_range,prim_range) OR address_predir NOT IN SET(s.nulls_predir,predir) OR address_prim_name NOT IN SET(s.nulls_prim_name,prim_name) OR address_addr_suffix NOT IN SET(s.nulls_addr_suffix,addr_suffix) OR address_postdir NOT IN SET(s.nulls_postdir,postdir) OR address_unit_desig NOT IN SET(s.nulls_unit_desig,unit_desig) OR address_sec_range NOT IN SET(s.nulls_sec_range,sec_range) OR address_st NOT IN SET(s.nulls_st,st) OR address_zip NOT IN SET(s.nulls_zip,zip));
    SELF.company_phone_cases := DATASET([
        {le.BestPhoneVotedSeleLevelWithNpa_company_phone,le.company_phone_BestPhoneVotedSeleLevelWithNpa_data_permits,1},
        {le.BestPhoneCurrentWithNpa_company_phone,le.company_phone_BestPhoneCurrentWithNpa_data_permits,2},
        {le.BestPhoneCurrent_company_phone,le.company_phone_BestPhoneCurrent_data_permits,3},
        {le.BestPhoneVoted_company_phone,le.company_phone_BestPhoneVoted_data_permits,4},
        {le.BestPhoneLongest_company_phone,le.company_phone_BestPhoneLongest_data_permits,5},
        {le.BestPhoneStrong_company_phone,le.company_phone_BestPhoneStrong_data_permits,6},
        {le.BestPhoneVotedUnrestricted_company_phone,le.company_phone_BestPhoneVotedUnrestricted_data_permits,7},
        {le.BestPhoneCommon_company_phone,le.company_phone_BestPhoneCommon_data_permits,8}
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
    SELF.duns_number_cases := DATASET([
        {le.BestDunsCommon_duns_number,le.duns_number_BestDunsCommon_data_permits,1},
        {le.BestDunsCurrent_duns_number,le.duns_number_BestDunsCurrent_data_permits,2},
        {le.BestDunsCurrent2_duns_number,le.duns_number_BestDunsCurrent2_data_permits,3},
        {le.BestDunsVotedUnrestricted_duns_number,le.duns_number_BestDunsVotedUnrestricted_data_permits,4}
          ],duns_number_case_layout)(duns_number NOT IN SET(s.nulls_duns_number,duns_number));
    SELF.company_sic_code1_cases := DATASET([
        {le.BestSicCommon_company_sic_code1,le.company_sic_code1_BestSicCommon_data_permits,1},
        {le.BestSicCurrent_company_sic_code1,le.company_sic_code1_BestSicCurrent_data_permits,2}
          ],company_sic_code1_case_layout)(company_sic_code1 NOT IN SET(s.nulls_company_sic_code1,company_sic_code1));
    SELF.company_naics_code1_cases := DATASET([
        {le.BestNaicsCommon_company_naics_code1,le.company_naics_code1_BestNaicsCommon_data_permits,1},
        {le.BestNaicsCurrent_company_naics_code1,le.company_naics_code1_BestNaicsCurrent_data_permits,2}
          ],company_naics_code1_case_layout)(company_naics_code1 NOT IN SET(s.nulls_company_naics_code1,company_naics_code1));
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_Seleid_child := F_BestBy_Seleid(BestBy_Seleid);
EXPORT BestBy_Seleid_child_np := F_BestBy_Seleid(BestBy_Seleid_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
SHARED Flatten_BestBy_Seleid(DATASET({BestBy_Seleid_child}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.Seleid) Seleid := 0;
    TYPEOF(h.company_name) company_name;
    UNSIGNED2 company_name_data_permits;
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
    UNSIGNED2 address_data_permits;
    UNSIGNED1 address_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_phone) company_phone;
    UNSIGNED2 company_phone_data_permits;
    UNSIGNED1 company_phone_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_fein) company_fein;
    UNSIGNED2 company_fein_data_permits;
    UNSIGNED1 company_fein_method; // This value could come from multiple BESTTYPE; track which one
    UNSIGNED company_fein_own_cnt := 0; // Used for determining who OWNs this value
    BOOLEAN  company_fein_owns := false; // Does this cluster own this value?
    TYPEOF(h.company_url) company_url;
    UNSIGNED2 company_url_data_permits;
    UNSIGNED1 company_url_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.duns_number) duns_number;
    UNSIGNED2 duns_number_data_permits;
    UNSIGNED1 duns_number_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_sic_code1) company_sic_code1;
    UNSIGNED2 company_sic_code1_data_permits;
    UNSIGNED1 company_sic_code1_method; // This value could come from multiple BESTTYPE; track which one
    TYPEOF(h.company_naics_code1) company_naics_code1;
    UNSIGNED2 company_naics_code1_data_permits;
    UNSIGNED1 company_naics_code1_method; // This value could come from multiple BESTTYPE; track which one
  END;
  R T(BestBy_Seleid_child le) := TRANSFORM
    SELF := le.company_name_cases[1];
    SELF := le.address_cases[1];
    SELF := le.company_phone_cases[1];
    SELF := le.company_fein_cases[1];
    SELF := le.company_url_cases[1];
    SELF := le.duns_number_cases[1];
    SELF := le.company_sic_code1_cases[1];
    SELF := le.company_naics_code1_cases[1];
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  OwnCands_company_fein := SORT( DISTRIBUTE(P1(company_fein_own_cnt>0),HASH(company_fein)), company_fein, -company_fein_own_cnt, Seleid,LOCAL);
  PassThru_company_fein := P1(company_fein_own_cnt=0);
  TYPEOF(P1) AddOwn_company_fein(P1 le,P1 ri) := TRANSFORM
    SELF.company_fein_owns := le.company_fein <> ri.company_fein; // The first in line with this value
    SELF := ri;
  END;
  P1_After_company_fein := ITERATE(OwnCands_company_fein,AddOwn_company_fein(LEFT,RIGHT),LOCAL) + PassThru_company_fein;
  RETURN P1_After_company_fein;
END;
EXPORT BestBy_Seleid_best := Flatten_BestBy_Seleid(BestBy_Seleid_child);
EXPORT BestBy_Seleid_best_np := Flatten_BestBy_Seleid(BestBy_Seleid_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_Seleid_population,NAMED('BestBy_Seleid_Population')));
END;