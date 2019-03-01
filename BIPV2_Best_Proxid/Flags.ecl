// Begin code to append flags to the file
IMPORT SALT30,ut;
EXPORT Flags(DATASET(layout_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
SHARED b := Best(ih);
// Append flags to the regular file
  TYPEOF(ih) NoteFlags(ih le,b.BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT30.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT30.Flags.Missing,
      le.company_name = ri.company_name => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT30.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT30.Flags.Missing,
      ri.company_fein_owns => SALT30.Flags.Owns,
      le.company_fein = ri.company_fein => SALT30.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT30.WithinEditN(le.company_fein,ri.company_fein,1, 0)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT30.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT30.Flags.Missing,
      le.company_phone = ri.company_phone => SALT30.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT30.WithinEditN(le.company_phone,ri.company_phone,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT30.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT30.Flags.Missing,
      le.company_url = ri.company_url => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.duns_number_flag := MAP ( ri.duns_number  IN SET(s.nulls_duns_number,duns_number) => SALT30.Flags.Null,
      le.duns_number  IN SET(s.nulls_duns_number,duns_number) => SALT30.Flags.Missing,
      le.duns_number = ri.duns_number => SALT30.Flags.Equal,
      le.duns_number = (TYPEOF(le.duns_number))'' OR ri.duns_number = (TYPEOF(ri.duns_number))'' OR SALT30.WithinEditN(le.duns_number,ri.duns_number,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_sic_code1_flag := MAP ( ri.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) => SALT30.Flags.Null,
      le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) => SALT30.Flags.Missing,
      le.company_sic_code1 = ri.company_sic_code1 => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.company_naics_code1_flag := MAP ( ri.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1) => SALT30.Flags.Null,
      le.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1) => SALT30.Flags.Missing,
      le.company_naics_code1 = ri.company_naics_code1 => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.address_flag := MAP ( (ri.address_prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.address_predir  IN SET(s.nulls_predir,predir) AND ri.address_prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.address_addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.address_postdir  IN SET(s.nulls_postdir,postdir) AND ri.address_unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.address_sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.address_st  IN SET(s.nulls_st,st) AND ri.address_zip  IN SET(s.nulls_zip,zip)) => SALT30.Flags.Null,
      (le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip)) => SALT30.Flags.Missing,
      (le.prim_range = ri.address_prim_range) AND (le.predir = ri.address_predir) AND (le.prim_name = ri.address_prim_name) AND (le.addr_suffix = ri.address_addr_suffix) AND (le.postdir = ri.address_postdir) AND (le.unit_desig = ri.address_unit_desig) AND (le.sec_range = ri.address_sec_range) AND (le.st = ri.address_st) AND (le.zip = ri.address_zip) => SALT30.Flags.Equal,
      (le.prim_range = (TYPEOF(le.prim_range))'' OR ri.address_prim_range = (TYPEOF(ri.address_prim_range))'' OR le.prim_range = ri.address_prim_range ) AND (le.predir = (TYPEOF(le.predir))'' OR ri.address_predir = (TYPEOF(ri.address_predir))'' OR le.predir = ri.address_predir ) AND (le.prim_name = (TYPEOF(le.prim_name))'' OR ri.address_prim_name = (TYPEOF(ri.address_prim_name))'' OR le.prim_name = ri.address_prim_name ) AND (le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.address_addr_suffix = (TYPEOF(ri.address_addr_suffix))'' OR le.addr_suffix = ri.address_addr_suffix ) AND (le.postdir = (TYPEOF(le.postdir))'' OR ri.address_postdir = (TYPEOF(ri.address_postdir))'' OR le.postdir = ri.address_postdir ) AND (le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.address_unit_desig = (TYPEOF(ri.address_unit_desig))'' OR le.unit_desig = ri.address_unit_desig ) AND (le.sec_range = (TYPEOF(le.sec_range))'' OR ri.address_sec_range = (TYPEOF(ri.address_sec_range))'' OR le.sec_range = ri.address_sec_range ) AND (le.st = (TYPEOF(le.st))'' OR ri.address_st = (TYPEOF(ri.address_st))'' OR le.st = ri.address_st ) AND (le.zip = (TYPEOF(le.zip))'' OR ri.address_zip = (TYPEOF(ri.address_zip))'' OR le.zip = ri.address_zip ) => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(ih,b.BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED In_Flagged0 := SORT(DISTRIBUTE(j,HASH(Proxid)),Proxid,LOCAL);
EXPORT In_Flagged := In_Flagged0;
  FlagTots := RECORD
    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_name_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_name_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_name_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_fein_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_fein_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_fein_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_phone_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_phone_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_phone_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_url_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_url_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_url_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 duns_number_Null_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Null,100,0));
    REAL4 duns_number_Equal_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Equal,100,0));
    REAL4 duns_number_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 duns_number_Bad_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Bad,100,0));
    REAL4 duns_number_Missing_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Missing,100,0));
    REAL4 duns_number_Relative_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative,100,0));
    REAL4 duns_number_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 duns_number_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_sic_code1_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_sic_code1_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_sic_code1_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_sic_code1_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_sic_code1_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_sic_code1_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_sic_code1_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_sic_code1_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_naics_code1_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_naics_code1_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_naics_code1_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_naics_code1_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_naics_code1_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_naics_code1_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_naics_code1_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_naics_code1_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 address_Null_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Null,100,0));
    REAL4 address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Equal,100,0));
    REAL4 address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Bad,100,0));
    REAL4 address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Missing,100,0));
    REAL4 address_Relative_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative,100,0));
    REAL4 address_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 address_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
  END;
EXPORT In_Flagged_Summary := TABLE(In_Flagged,FlagTots); // Global summary
  FlagTots := RECORD
    In_Flagged.source_for_votes; // Group by sourcefield    UNSIGNED Cnt := COUNT(GROUP);
    REAL4 company_name_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_name_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_name_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_name_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_name_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_name_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_name_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_name_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_name_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_fein_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_fein_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_fein_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_fein_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_fein_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_fein_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_fein_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_fein_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_fein_Owns_pcnt := AVE(GROUP,IF(In_Flagged.company_fein_Flag = SALT30.Flags.Owns,100,0));
    REAL4 company_phone_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_phone_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_phone_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_phone_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_phone_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_phone_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_phone_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_phone_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_phone_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_url_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_url_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_url_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_url_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_url_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_url_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_url_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_url_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_url_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 duns_number_Null_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Null,100,0));
    REAL4 duns_number_Equal_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Equal,100,0));
    REAL4 duns_number_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 duns_number_Bad_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Bad,100,0));
    REAL4 duns_number_Missing_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Missing,100,0));
    REAL4 duns_number_Relative_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative,100,0));
    REAL4 duns_number_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 duns_number_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.duns_number_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_sic_code1_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_sic_code1_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_sic_code1_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_sic_code1_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_sic_code1_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_sic_code1_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_sic_code1_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_sic_code1_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_sic_code1_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 company_naics_code1_Null_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Null,100,0));
    REAL4 company_naics_code1_Equal_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Equal,100,0));
    REAL4 company_naics_code1_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 company_naics_code1_Bad_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Bad,100,0));
    REAL4 company_naics_code1_Missing_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Missing,100,0));
    REAL4 company_naics_code1_Relative_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative,100,0));
    REAL4 company_naics_code1_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 company_naics_code1_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.company_naics_code1_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
    REAL4 address_Null_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Null,100,0));
    REAL4 address_Equal_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Equal,100,0));
    REAL4 address_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Fuzzy,100,0));
    REAL4 address_Bad_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Bad,100,0));
    REAL4 address_Missing_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Missing,100,0));
    REAL4 address_Relative_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative,100,0));
    REAL4 address_Relative_Possible_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative_Possible,100,0));
    REAL4 address_Relative_Fuzzy_pcnt := AVE(GROUP,IF(In_Flagged.address_Flag = SALT30.Flags.Relative_Fuzzy,100,0));
  END;
EXPORT In_Flagged_Summary_BySrc := TABLE(In_Flagged,FlagTots,source_for_votes,FEW);
// Append flags to the input file
  TYPEOF(h) NoteFlags(h le,b.BestBy_Proxid_Best ri) := TRANSFORM
    SELF.company_name_flag := MAP ( ri.company_name  IN SET(s.nulls_company_name,company_name) => SALT30.Flags.Null,
      le.company_name  IN SET(s.nulls_company_name,company_name) => SALT30.Flags.Missing,
      le.company_name = ri.company_name => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.company_fein_flag := MAP ( ri.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT30.Flags.Null,
      le.company_fein  IN SET(s.nulls_company_fein,company_fein) => SALT30.Flags.Missing,
      ri.company_fein_owns => SALT30.Flags.Owns,
      le.company_fein = ri.company_fein => SALT30.Flags.Equal,
      le.company_fein = (TYPEOF(le.company_fein))'' OR ri.company_fein = (TYPEOF(ri.company_fein))'' OR SALT30.WithinEditN(le.company_fein,ri.company_fein,1, 0)  OR fn_Right4(ri.company_fein) = fn_Right4(le.company_fein)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_phone_flag := MAP ( ri.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT30.Flags.Null,
      le.company_phone  IN SET(s.nulls_company_phone,company_phone) => SALT30.Flags.Missing,
      le.company_phone = ri.company_phone => SALT30.Flags.Equal,
      le.company_phone = (TYPEOF(le.company_phone))'' OR ri.company_phone = (TYPEOF(ri.company_phone))'' OR SALT30.WithinEditN(le.company_phone,ri.company_phone,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_url_flag := MAP ( ri.company_url  IN SET(s.nulls_company_url,company_url) => SALT30.Flags.Null,
      le.company_url  IN SET(s.nulls_company_url,company_url) => SALT30.Flags.Missing,
      le.company_url = ri.company_url => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.duns_number_flag := MAP ( ri.duns_number  IN SET(s.nulls_duns_number,duns_number) => SALT30.Flags.Null,
      le.duns_number  IN SET(s.nulls_duns_number,duns_number) => SALT30.Flags.Missing,
      le.duns_number = ri.duns_number => SALT30.Flags.Equal,
      le.duns_number = (TYPEOF(le.duns_number))'' OR ri.duns_number = (TYPEOF(ri.duns_number))'' OR SALT30.WithinEditN(le.duns_number,ri.duns_number,1, 0)  => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF.company_sic_code1_flag := MAP ( ri.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) => SALT30.Flags.Null,
      le.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) => SALT30.Flags.Missing,
      le.company_sic_code1 = ri.company_sic_code1 => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.company_naics_code1_flag := MAP ( ri.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1) => SALT30.Flags.Null,
      le.company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1) => SALT30.Flags.Missing,
      le.company_naics_code1 = ri.company_naics_code1 => SALT30.Flags.Equal,
      SALT30.Flags.Bad);
    SELF.address_flag := MAP ( (ri.address_prim_range  IN SET(s.nulls_prim_range,prim_range) AND ri.address_predir  IN SET(s.nulls_predir,predir) AND ri.address_prim_name  IN SET(s.nulls_prim_name,prim_name) AND ri.address_addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND ri.address_postdir  IN SET(s.nulls_postdir,postdir) AND ri.address_unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND ri.address_sec_range  IN SET(s.nulls_sec_range,sec_range) AND ri.address_st  IN SET(s.nulls_st,st) AND ri.address_zip  IN SET(s.nulls_zip,zip)) => SALT30.Flags.Null,
      (le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip)) => SALT30.Flags.Missing,
      (le.prim_range = ri.address_prim_range) AND (le.predir = ri.address_predir) AND (le.prim_name = ri.address_prim_name) AND (le.addr_suffix = ri.address_addr_suffix) AND (le.postdir = ri.address_postdir) AND (le.unit_desig = ri.address_unit_desig) AND (le.sec_range = ri.address_sec_range) AND (le.st = ri.address_st) AND (le.zip = ri.address_zip) => SALT30.Flags.Equal,
      (le.prim_range = (TYPEOF(le.prim_range))'' OR ri.address_prim_range = (TYPEOF(ri.address_prim_range))'' OR le.prim_range = ri.address_prim_range ) AND (le.predir = (TYPEOF(le.predir))'' OR ri.address_predir = (TYPEOF(ri.address_predir))'' OR le.predir = ri.address_predir ) AND (le.prim_name = (TYPEOF(le.prim_name))'' OR ri.address_prim_name = (TYPEOF(ri.address_prim_name))'' OR le.prim_name = ri.address_prim_name ) AND (le.addr_suffix = (TYPEOF(le.addr_suffix))'' OR ri.address_addr_suffix = (TYPEOF(ri.address_addr_suffix))'' OR le.addr_suffix = ri.address_addr_suffix ) AND (le.postdir = (TYPEOF(le.postdir))'' OR ri.address_postdir = (TYPEOF(ri.address_postdir))'' OR le.postdir = ri.address_postdir ) AND (le.unit_desig = (TYPEOF(le.unit_desig))'' OR ri.address_unit_desig = (TYPEOF(ri.address_unit_desig))'' OR le.unit_desig = ri.address_unit_desig ) AND (le.sec_range = (TYPEOF(le.sec_range))'' OR ri.address_sec_range = (TYPEOF(ri.address_sec_range))'' OR le.sec_range = ri.address_sec_range ) AND (le.st = (TYPEOF(le.st))'' OR ri.address_st = (TYPEOF(ri.address_st))'' OR le.st = ri.address_st ) AND (le.zip = (TYPEOF(le.zip))'' OR ri.address_zip = (TYPEOF(ri.address_zip))'' OR le.zip = ri.address_zip ) => SALT30.Flags.Fuzzy,
      SALT30.Flags.Bad);
    SELF := le;
  END;
  j := JOIN(h,b.BestBy_Proxid_Best,LEFT.Proxid=RIGHT.Proxid,NoteFlags(LEFT,RIGHT),LEFT OUTER,HASH);
SHARED Input_Flagged0 := SORT(DISTRIBUTE(j,HASH(Proxid)),Proxid,LOCAL);
EXPORT Input_Flagged := Input_Flagged0;
END;