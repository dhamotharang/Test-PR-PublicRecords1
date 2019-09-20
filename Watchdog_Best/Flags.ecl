// Begin code to append flags to the file
IMPORT SALT311;
EXPORT Flags(DATASET(layout_Hdr) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := Watchdog_best.BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
SHARED b := MAC_CreateBest(ih, , );
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,b.BestBy_did_Best ri) := TRANSFORM
    SELF.ssnum_flag := MAP ( ((ri.ssnum_valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR ri.ssnum_valid_ssn = (TYPEOF(ri.ssnum_valid_ssn))'')) => SALT311.Flags.Null,
      ((le.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR le.valid_ssn = (TYPEOF(le.valid_ssn))'')) => SALT311.Flags.Missing,
      (le.valid_ssn = ri.ssnum_valid_ssn) => SALT311.Flags.Equal,
      (le.valid_ssn = (TYPEOF(le.valid_ssn))'' OR ri.ssnum_valid_ssn = (TYPEOF(ri.ssnum_valid_ssn))'' OR le.valid_ssn = ri.ssnum_valid_ssn ) => SALT311.Flags.Fuzzy,
      SALT311.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,b.BestBy_did_Best,LEFT.did=RIGHT.did,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED In_Flagged0 := SORT(DISTRIBUTE(j,HASH(did)),did,LOCAL);
EXPORT In_Flagged := In_Flagged0;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 ssnum_Null_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Null,100,0));
    REAL4 ssnum_Equal_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Equal,100,0));
    REAL4 ssnum_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Fuzzy,100,0));
    REAL4 ssnum_Bad_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Bad,100,0));
    REAL4 ssnum_Missing_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Missing,100,0));
    REAL4 ssnum_Relative_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative,100,0));
    REAL4 ssnum_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative_Possible,100,0));
    REAL4 ssnum_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative_Fuzzy,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.src; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 ssnum_Null_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Null,100,0));
    REAL4 ssnum_Equal_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Equal,100,0));
    REAL4 ssnum_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Fuzzy,100,0));
    REAL4 ssnum_Bad_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Bad,100,0));
    REAL4 ssnum_Missing_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Missing,100,0));
    REAL4 ssnum_Relative_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative,100,0));
    REAL4 ssnum_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative_Possible,100,0));
    REAL4 ssnum_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.ssnum_Flag = SALT311.Flags.Relative_Fuzzy,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,src,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,b.BestBy_did_Best ri) := TRANSFORM
    SELF.ssnum_flag := MAP ( ((ri.ssnum_valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR ri.ssnum_valid_ssn = (TYPEOF(ri.ssnum_valid_ssn))'')) => SALT311.Flags.Null,
      ((le.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR le.valid_ssn = (TYPEOF(le.valid_ssn))'')) => SALT311.Flags.Missing,
      (le.valid_ssn = ri.ssnum_valid_ssn) => SALT311.Flags.Equal,
      (le.valid_ssn = (TYPEOF(le.valid_ssn))'' OR ri.ssnum_valid_ssn = (TYPEOF(ri.ssnum_valid_ssn))'' OR le.valid_ssn = ri.ssnum_valid_ssn ) => SALT311.Flags.Fuzzy,
      SALT311.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,b.BestBy_did_Best,LEFT.did=RIGHT.did,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED Input_Flagged0 := SORT(DISTRIBUTE(j,HASH(did)),did,LOCAL);
EXPORT Input_Flagged := Input_Flagged0;
END;
