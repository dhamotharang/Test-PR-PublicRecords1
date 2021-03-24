import BatchShare,didville,progressive_phone,doxie;

export Layout_BestAddr := MODULE

  export Batch_in := RECORD
    DidVille.Layout_BestInfo_BatchIn and not [version_number];
    unsigned6 did := 0;
    qSTRING150 addr1;
    qSTRING50 addr1_2;
    qSTRING25 city_name1;
    qSTRING2 st1;
    qSTRING5 zip1;
    qSTRING150 addr2;
    qSTRING50 addr2_2;
    qSTRING25 city_name2;
    qSTRING2 st2;
    qSTRING5 zip2;
    qSTRING150 addr3;
    qSTRING50 addr3_2;
    qSTRING25 city_name3;
    qSTRING2 st3;
    qSTRING5 zip3;
    qSTRING150 addr4;
    qSTRING50 addr4_2;
    qSTRING25 city_name4;
    qSTRING2 st4;
    qSTRING5 zip4;
    qSTRING150 addr5;
    qSTRING50 addr5_2;
    qSTRING25 city_name5;
    qSTRING2 st5;
    qSTRING5 zip5;
    qSTRING150 addr6;
    qSTRING50 addr6_2;
    qSTRING25 city_name6;
    qSTRING2 st6;
    qSTRING5 zip6;
    qSTRING150 addr7;
    qSTRING50 addr7_2;
    qSTRING25 city_name7;
    qSTRING2 st7;
    qSTRING5 zip7;
    qSTRING150 addr8;
    qSTRING50 addr8_2;
    qSTRING25 city_name8;
    qSTRING2 st8;
    qSTRING5 zip8;
    qSTRING150 addr9;
    qSTRING50 addr9_2;
    qSTRING25 city_name9;
    qSTRING2 st9;
    qSTRING5 zip9;
    qSTRING150 addr10;
    qSTRING50 addr10_2;
    qSTRING25 city_name10;
    qSTRING2 st10;
    qSTRING5 zip10;
    qSTRING24 dl:= '';
    qSTRING2 dlstate := '';
    BatchShare.Layouts.ShareAddressNCOA - NCOA_county_name;
  END;

  export Batch_in_both := RECORD(batch_in)
    string4 z4;
    string10 phoneno_1;
    string10 phoneno_2;
    string10 phoneno_3;
    string10 phoneno_4;
    string10 phoneno_5;
    string10 phoneno_6;
    string10 phoneno_7;
    string10 phoneno_8;
    string10 phoneno_9;
    string10 phoneno_10;
  END;

  
  export Batch := RECORD
    string20 acctno;
    unsigned6 did;
    string10 phone10;
    string20 name_first;
    string20 name_middle;
    string20 name_last;
    string5 name_suffix;
    string9 ssn;
    string8 dob;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING2 st;
    STRING5 z5;
    STRING4 zip4;
    string5 fips_county;
    string18 County_name;
    string6 addr_dt_last_seen;
  END;
  
  export rec_src := record
    string2 src;
  end;

  EXPORT service_Out:= RECORD
    Batch;
    string6 addr_dt_first_seen;
    string120 name_dual;
    string3 name_score;
    string3 ssn_score;
    string1 dup_flag;
    boolean is_input;
    dataset(rec_src) srcs {MAXCOUNT(AddrBest.Constants.max_count_src)} := dataset([],rec_src) ;
  END;
  
  EXPORT service_additional_codes := RECORD
    boolean unserviceable;
    boolean ff_mover;
    boolean match_name;
    boolean match_street_address;
    boolean match_city;
    boolean match_state;
    boolean match_zip;
    boolean match_ssn;
    boolean match_dob;
    boolean match_did;
    boolean matches;
    STRING8 matchcodes;
  END;
  
  EXPORT service_Out_matchcodes:= RECORD
    service_Out;
    string3 dob_score;
    service_additional_codes;
    INTEGER error_code := 0;
  END;

  EXPORT batch_Out:= RECORD
    Batch;
    string6 addr_dt_first_seen;
    string120 name_dual;
    string3 name_score;
    string3 ssn_score;
    string3 dob_score;
    string10 phone_address;
    string1 unq_id_subject;
    string10 latitude;
    string11 longitude;
    string1 unserv_addr;
    string1 ff_mover;
    string1 conf_flag;
    string1 conf_addr_match_code;
    string1 multiple_count_flag;
    string1 dup_flag;
    boolean is_input;
    string100 srcs;
  END;
    
  EXPORT best_Out_common := record
    service_additional_codes - [ff_mover, unserviceable];
    string1 unq_id_subject;
    string1 multiple_count_flag;
    string3 dob_score;
    string1 ff_mover;
    string1 conf_flag;
    string1 conf_addr_match_code;
    string1 unserv_addr;
    service_Out;
  end;
    
  EXPORT batch_Out_matchcodes:= RECORD
    Batch_out;
    string8 matchcodes;
    INTEGER error_code := 0;
  END;
  
  EXPORT batch_out_final := RECORD
    batch_Out_matchcodes;
    unsigned4 address_history_seq := 0;
    string1 PrevCurrMilitary_address;
    string1 ssn_loose_match;
    STRING1 BA_flag := ''; //potential values of B=Best Address hit or ''
    STRING1 NCOA_flag := ''; //potential values of N=NCOA hit or ''
    BatchShare.Layouts.ShareAddressNCOA - NCOA_county_name;
    STRING1 college_addr := ''; //(Y/N)
    STRING1 business_addr := ''; //(Y/N)
    STRING1 rent_flag := ''; //(Y/N)
    STRING1 property_owner := ''; //(Y/N)
    STRING1 long_term_hit := ''; //(Y/N)
    STRING1 short_term_hit := ''; //(Y/N)
    STRING1 owner_occupied_hit := ''; //(Y/N)
    UNSIGNED8 location_id := 0;
  END;
  
  EXPORT batch_Out_both := RECORD
    string1 ind;
    Batch_Out-[srcs,dob_score,phone_address,unq_id_subject,latitude,longitude,unserv_addr,ff_mover,conf_flag,conf_addr_match_code,multiple_count_flag] or progressive_phone.layout_progressive_batch_out;
    unsigned2 cnt;
    string8 dod;
    string1 deceased := 'U'; // unknown
    string2 orig_state;
    string24 dl_number;
    unsigned4 lic_issue_date := 0;
    unsigned4 expiration_date := 0;
  END;
  export batch_out_both_wp_did := record(batch_Out_both)
    unsigned6 p_did;
  end;
  export batch_presentation := record(doxie.Layout_presentation)
    service_additional_codes;
    dataset(rec_src) srcs {MAXCOUNT(AddrBest.Constants.max_count_src)} := dataset([],rec_src) ;
  end;
  export batch_presentation_phones := record(doxie.layout_presentation_phones)
    service_additional_codes;
    dataset(rec_src) srcs {maxcount(AddrBest.Constants.max_count_src)} := dataset([],rec_src) ;
  end;
END;
