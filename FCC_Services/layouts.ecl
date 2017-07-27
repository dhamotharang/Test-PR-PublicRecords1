IMPORT FCC, standard, ut;

EXPORT layouts := MODULE

  EXPORT id := RECORD
    FCC.Layout_FCC_base.fcc_seq;
    string30 acctno := ''; //for batch purposes
  END;

  EXPORT search_ids := RECORD (id)
    boolean isDeepDive := false;
  END;

  shared AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
  end;

  shared translations:= RECORD
    string50 license_type_desc;
    string7 pending_granted_desc;
    string74 service_code_desc;
    // transmitter class
    string100 class_desc;
    string40 last_change_desc;
  END;

  // same as main layout FCC.Layout_FCC_base, but using named portions: address(es), names
  shared Base := RECORD
    FCC.Layout_FCC_base AND NOT [
      // eclude cleaned name (named layout will be used instead) from FCC.Layout_FCC_Licenses_in
      attention_title,attention_fname,attention_mname,attention_lname,attention_name_suffix,attention_name_score,

      // exclude address fields (named layout will be used instead) from FCC.Layout_FCC_Licenses_in
      prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,
      p_city_name,v_city_name,st,zip5,zip4,cart,cr_sort_sz,lot,
      lot_order,dpbc,chk_digit,addr_rec_type,fips_state,fips_county,geo_lat,geo_long,
      cbsa,geo_blk,geo_match,err_stat,

      // exclude firm address fields (named layout will be used instead) from FCC.Layout_FCC_base
      firm];

    translations;
    // cleaned fields
    standard.Name name_attention;
    AddressTranslated address;
    AddressTranslated addr_firm;
  end; 

  // shared between search/embedded output (further slimmed down)
  EXPORT ReportSearchShared := RECORD
    unsigned1 penalt;
    Base AND NOT [
      addr_firm,
      // exclude other fields to slim layout down for purpose of search/embedded services
      latitude,longitude,transmitters_street,transmitters_city,transmitters_county,transmitters_state,
      transmitters_antenna_height,transmitters_height_above_avg_terra,transmitters_height_above_ground_le,
      power_of_this_frequency,frequency_Mhz,class_of_station,number_of_units_authorized_on_freq,
      effective_radiated_power,emissions_codes,frequency_coordination_number,control_point_for_the_system,
      unique_key];
  END; 

  // output for SEARCH service 
  EXPORT SearchOutput := RECORD (ReportSearchShared)
  END;

  // SUBREPORT (as part of CRS, for instanse) //so far is same as SearchOutput, but shall be different
  EXPORT EmbeddedOutput := RECORD (ReportSearchShared)
  END; 

  // Complete stand-alone SOURCE/REPORT service
  EXPORT SourceOutput := RECORD 
    // transmitter's latitude, longitude should be translated
    Base AND NOT [latitude,longitude];
    STRING20 latitude; 
    STRING20 longitude; 
  END; 

  // most complete and close to original: SOURCE service (generally, )
  EXPORT DataOutput := RECORD (FCC.Layout_FCC_base)
  END; 

END;
