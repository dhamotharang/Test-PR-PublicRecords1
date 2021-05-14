// DF-28230 - fcra_opt_out delta build
IMPORT dx_common;

EXPORT layouts := MODULE

  EXPORT i_address := RECORD
    STRING5     z5;
    STRING10    prim_range;
    STRING28    prim_name;
    STRING8     sec_range;
    STRING9     ssn;
    UNSIGNED6   did := 0;
    STRING1     source_flag;
    STRING7     julian_date := '';
    STRING15    inname_first;
    STRING20    inname_last;
    STRING40    address;
    STRING20    city;
    STRING2     state;
    STRING5     zip5;
    UNSIGNED    did_score := 0;
    STRING9     ssn_append := '';
    STRING1     permanent_flag := 'Y';
    STRING1     Opt_Back_in := 'N';
    STRING8     date_YYYYMMDD := '';
    dx_common.layout_metadata;      //DF-28230
  END;

  EXPORT i_did := RECORD
    UNSIGNED6   l_did;
    STRING9     ssn;
    STRING1     source_flag;
    STRING7     julian_date := '';
    STRING15    inname_first;
    STRING20    inname_last;
    STRING40    address;
    STRING20    city;
    STRING2     state;
    STRING5     zip5;
    UNSIGNED    did_score := 0;
    STRING9     ssn_append := '';
    STRING1     permanent_flag := 'Y';
    STRING1     Opt_Back_in := 'N';
    STRING8     date_YYYYMMDD := '';
    dx_common.layout_metadata;      //DF-28230
  END;

  EXPORT i_ssn := RECORD
    UNSIGNED6   l_ssn;
    UNSIGNED6   did := 0;
    STRING1     source_flag;
    STRING7     julian_date := '';
    STRING15    inname_first;
    STRING20    inname_last;
    STRING40    address;
    STRING20    city;
    STRING2     state;
    STRING5     zip5;
    UNSIGNED    did_score := 0;
    STRING9     ssn_append := '';
    STRING1     permanent_flag := 'Y';
    STRING1     Opt_Back_in := 'N';
    STRING8     date_YYYYMMDD := '';
    dx_common.layout_metadata;      //DF-28230
  END;


END;
