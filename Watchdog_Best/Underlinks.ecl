// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT Watchdog_Best; // Import modules for  attribute definitions
IMPORT SALT311,std;
EXPORT Underlinks(DATASET(layout_Hdr) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];

  dt := Debug(ih, s, MatchThreshold).sample_match_join;
  RawResults := matches(ih, MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT311.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.src_Score = 0,'','|'+IF(le.src_Score < 0,'-','')+'src')+IF(le.address_Score = 0,'','|'+IF(le.address_Score < 0,'-','')+'address')+IF(le.rawaid_Score = 0,'','|'+IF(le.rawaid_Score < 0,'-','')+'rawaid')+IF(le.prim_name_Score = 0,'','|'+IF(le.prim_name_Score < 0,'-','')+'prim_name')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.zip4_Score = 0,'','|'+IF(le.zip4_Score < 0,'-','')+'zip4')+IF(le.prim_range_Score = 0,'','|'+IF(le.prim_range_Score < 0,'-','')+'prim_range')+IF(le.city_name_Score = 0,'','|'+IF(le.city_name_Score < 0,'-','')+'city_name')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.tnt_Score = 0,'','|'+IF(le.tnt_Score < 0,'-','')+'tnt')+IF(le.name_suffix_Score = 0,'','|'+IF(le.name_suffix_Score < 0,'-','')+'name_suffix')+IF(le.dt_nonglb_last_seen_Score = 0,'','|'+IF(le.dt_nonglb_last_seen_Score < 0,'-','')+'dt_nonglb_last_seen')+IF(le.dt_first_seen_Score = 0,'','|'+IF(le.dt_first_seen_Score < 0,'-','')+'dt_first_seen')+IF(le.postdir_Score = 0,'','|'+IF(le.postdir_Score < 0,'-','')+'postdir')+IF(le.dt_last_seen_Score = 0,'','|'+IF(le.dt_last_seen_Score < 0,'-','')+'dt_last_seen')+IF(le.ssnum_Score = 0,'','|'+IF(le.ssnum_Score < 0,'-','')+'ssnum')+IF(le.dodgy_tracking_Score = 0,'','|'+IF(le.dodgy_tracking_Score < 0,'-','')+'dodgy_tracking')+IF(le.dt_vendor_first_reported_Score = 0,'','|'+IF(le.dt_vendor_first_reported_Score < 0,'-','')+'dt_vendor_first_reported')+IF(le.dt_vendor_last_reported_Score = 0,'','|'+IF(le.dt_vendor_last_reported_Score < 0,'-','')+'dt_vendor_last_reported')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.pflag1_Score = 0,'','|'+IF(le.pflag1_Score < 0,'-','')+'pflag1')+IF(le.pflag2_Score = 0,'','|'+IF(le.pflag2_Score < 0,'-','')+'pflag2')+IF(le.predir_Score = 0,'','|'+IF(le.predir_Score < 0,'-','')+'predir')+IF(le.jflag2_Score = 0,'','|'+IF(le.jflag2_Score < 0,'-','')+'jflag2')+IF(le.suffix_Score = 0,'','|'+IF(le.suffix_Score < 0,'-','')+'suffix')+IF(le.unit_desig_Score = 0,'','|'+IF(le.unit_desig_Score < 0,'-','')+'unit_desig')+IF(le.jflag3_Score = 0,'','|'+IF(le.jflag3_Score < 0,'-','')+'jflag3')+IF(le.jflag1_Score = 0,'','|'+IF(le.jflag1_Score < 0,'-','')+'jflag1')+IF(le.valid_ssn_Score = 0,'','|'+IF(le.valid_ssn_Score < 0,'-','')+'valid_ssn')+IF(le.phone_Score = 0,'','|'+IF(le.phone_Score < 0,'-','')+'phone')+IF(le.ssn_Score = 0,'','|'+IF(le.ssn_Score < 0,'-','')+'ssn')+IF(le.dob_Score = 0,'','|'+IF(le.dob_Score < 0,'-','')+'dob')+IF(le.rec_type_Score = 0,'','|'+IF(le.rec_type_Score < 0,'-','')+'rec_type')+IF(le.pflag3_Score = 0,'','|'+IF(le.pflag3_Score < 0,'-','')+'pflag3')+IF(le.title_Score = 0,'','|'+IF(le.title_Score < 0,'-','')+'title')+IF(le.fname_Score = 0,'','|'+IF(le.fname_Score < 0,'-','')+'fname')+IF(le.mname_Score = 0,'','|'+IF(le.mname_Score < 0,'-','')+'mname')+IF(le.lname_Score = 0,'','|'+IF(le.lname_Score < 0,'-','')+'lname')+IF(le.address_ind_Score = 0,'','|'+IF(le.address_ind_Score < 0,'-','')+'address_ind')+IF(le.name_ind_Score = 0,'','|'+IF(le.name_ind_Score < 0,'-','')+'name_ind')+IF(le.persistent_record_id_Score = 0,'','|'+IF(le.persistent_record_id_Score < 0,'-','')+'persistent_record_id');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
