IMPORT SALT311,std;
IMPORT Watchdog_Best; // Import modules for  attribute definitions
EXPORT match_methods(DATASET(layout_Hdr) ih) := MODULE

SHARED h := match_candidates(ih).candidates;
EXPORT match_pflag1(TYPEOF(h.pflag1) L, TYPEOF(h.pflag1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_pflag2(TYPEOF(h.pflag2) L, TYPEOF(h.pflag2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_pflag3(TYPEOF(h.pflag3) L, TYPEOF(h.pflag3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_src(TYPEOF(h.src) L, TYPEOF(h.src) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dt_first_seen(TYPEOF(h.dt_first_seen) L, TYPEOF(h.dt_first_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dt_last_seen(TYPEOF(h.dt_last_seen) L, TYPEOF(h.dt_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_last_reported(TYPEOF(h.dt_vendor_last_reported) L, TYPEOF(h.dt_vendor_last_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dt_vendor_first_reported(TYPEOF(h.dt_vendor_first_reported) L, TYPEOF(h.dt_vendor_first_reported) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dt_nonglb_last_seen(TYPEOF(h.dt_nonglb_last_seen) L, TYPEOF(h.dt_nonglb_last_seen) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_rec_type(TYPEOF(h.rec_type) L, TYPEOF(h.rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_phone(TYPEOF(h.phone) L, TYPEOF(h.phone) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_ssn(TYPEOF(h.ssn) L, TYPEOF(h.ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dob(TYPEOF(h.dob) L, TYPEOF(h.dob) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_title(TYPEOF(h.title) L, TYPEOF(h.title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.HyphenMatch(L,R,1)<=1 => SALT311.MatchCode.HyphenMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_predir(TYPEOF(h.predir) L, TYPEOF(h.predir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_suffix(TYPEOF(h.suffix) L, TYPEOF(h.suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_postdir(TYPEOF(h.postdir) L, TYPEOF(h.postdir) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_unit_desig(TYPEOF(h.unit_desig) L, TYPEOF(h.unit_desig) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_city_name(TYPEOF(h.city_name) L, TYPEOF(h.city_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_zip4(TYPEOF(h.zip4) L, TYPEOF(h.zip4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_tnt(TYPEOF(h.tnt) L, TYPEOF(h.tnt) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_valid_ssn(TYPEOF(h.valid_ssn) L, TYPEOF(h.valid_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_jflag1(TYPEOF(h.jflag1) L, TYPEOF(h.jflag1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_jflag2(TYPEOF(h.jflag2) L, TYPEOF(h.jflag2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_jflag3(TYPEOF(h.jflag3) L, TYPEOF(h.jflag3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_rawaid(TYPEOF(h.rawaid) L, TYPEOF(h.rawaid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_dodgy_tracking(TYPEOF(h.dodgy_tracking) L, TYPEOF(h.dodgy_tracking) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_address_ind(TYPEOF(h.address_ind) L, TYPEOF(h.address_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_name_ind(TYPEOF(h.name_ind) L, TYPEOF(h.name_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_persistent_record_id(TYPEOF(h.persistent_record_id) L, TYPEOF(h.persistent_record_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_ssnum(TYPEOF(h.ssnum) L,TYPEOF(h.ssnum) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_address(TYPEOF(h.address) L,TYPEOF(h.address) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
END;
