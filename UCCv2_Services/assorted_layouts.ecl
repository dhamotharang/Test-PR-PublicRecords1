EXPORT assorted_layouts := MODULE

   EXPORT fn_convert_to_yyyymmdd(STRING10 date_value) := FUNCTION
    searchpattern := '^(.*)/(.*)/(.*)$';
    yyyy := REGEXFIND(searchpattern, date_value, 3) ;
    mm := REGEXFIND(searchpattern, date_value, 1) ;
    dd := REGEXFIND(searchpattern, date_value, 2) ;
    RETURN yyyy + // i.e. '1968' in '10/12/1968'
           IF(LENGTH(mm)=1,'0'+mm,mm)+ // i.e. '10' in '10/12/1968'
           IF(LENGTH(dd)=1,'0'+dd,dd); // i.e. '12' in '10/12/1968'
  END;

    
    EXPORT tmsid_acctno := RECORD
     STRING20 acctno ;
     UCCv2_Services.layout_rmsid;
    END;
     
   
    EXPORT inp_rec := RECORD
      STRING20 acctno;
      STRING comp_name_indic_value;
      STRING comp_name_sec_value;
      STRING2 st ;
      UNSIGNED6 Secured_zip5 := 0 ;
      SET of UNSIGNED6 Debtor_zip5 := [] ;
      STRING SIC_code := '';
      STRING Filing_number ;
      STRING Fg_StartDate ;
      STRING Fg_EndDate ;
    END;
  
    SHARED party_raw := uccv2_services.layout_ucc_party_raw;
    EXPORT matched_party_name_rec := RECORD
      party_raw.title;
      party_raw.lname;
      party_raw.fname;
      party_raw.mname;
      party_raw.name_suffix;
    END;
    EXPORT matched_party_address_rec := RECORD
      party_raw.Orig_address1;
      party_raw.Orig_address2;
      party_raw.address1;
      party_raw.address2;
      party_raw.prim_range;
      party_raw.predir;
      party_raw.prim_name;
      party_raw.addr_suffix;
      party_raw.postdir;
      party_raw.unit_desig;
      party_raw.sec_range;
      party_raw.v_city_name;
      party_raw.st;
      party_raw.zip5;
      party_raw.zip4;
    END;
    
    EXPORT matched_party_rec := RECORD
      STRING1 party_type;
      party_raw.orig_name;
      matched_party_name_rec parsed_party;
      matched_party_address_rec address;
    END;

END;
