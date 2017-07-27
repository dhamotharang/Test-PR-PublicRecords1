EXPORT L_Address := MODULE

  EXPORT base := RECORD // almost same as Address.Layout_Address_Clean_Return and others
    string10 prim_range;
    string2  predir;
    string28 prim_name;
    string4  addr_suffix;
    string2  postdir;
    string10 unit_desig;
    string8  sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2  st;
    string5  zip5;
    string4  zip4;
    string2  fips_state;
    string3  fips_county;
    //populated for assigned records, and the valid record types are:
    //F - Firm; G - General Delivery; H - High Rise; P - PO box; R - Rural Route or HWY - Contract; S - Street;
    string2  addr_rec_type; //does it belong here?
  END;


  EXPORT expanded := RECORD
    base;
    string10 geo_lat;
    string11 geo_long;
    string4  cbsa;  // this one a lot of synonyms (msa, etc.)
    string7  geo_blk;
    string1  geo_match;
    string4  err_stat;
  END;

  EXPORT detailed := RECORD  // ... Address.Layout_Address_Clean_Components
    expanded AND NOT [err_stat];
    string4  cart;
    string1  cr_sort_sz;
    string4  lot;
    string1  lot_order;
    string2  dpbc;
    string1  chk_digit;
    string4  err_stat;
  END;

  EXPORT translated := RECORD
    string30 state;
    string35 county;
  END;


  EXPORT baseCanada := RECORD
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string2 st;
    string6 zip;
    string2 rec_type;
    string1 language;
    string6 errstat;
  END;

END;
