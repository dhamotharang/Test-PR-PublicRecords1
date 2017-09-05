// RR-11535 - Adding Utility Data to Comprehensive Report. 
EXPORT layout_utility := MODULE

  EXPORT address_layout := RECORD 

    string1         addr_type;
    string10        prim_range;
    string2         predir;
    string28        prim_name;
    string4         addr_suffix;
    string2         postdir;
    string10        unit_desig;
    string8         sec_range;
    string25        city;
    string2         state;
    string10        zip;
    string10        zip4;
    string18        county_name;

  END;

  EXPORT record_layout_slim := RECORD

    string1         util_type;
    string20        util_category;
    string20        util_type_description;
    string8         connect_date;
    string8         date_first_seen;
    string8         record_date;
    string20        title;
    string20        fname;
    string20        mname;
    string25        lname;
    string5         name_suffix;
    string9         ssn;
    string8         dob;
    string2         drivers_license_state_code;
    string22        drivers_license;
    string10        work_phone;
    string10        phone;
    string1         addr_dual;

    DATASET(address_layout) address_recs {MAXCOUNT(2)};

  END;

  EXPORT record_layout := RECORD

    string15        id;
    string10        exchange_serial_number;
    boolean         is_service_addr_set;
    boolean         is_billing_addr_set;

    record_layout_slim;

    string1         service_addr_type;
    string10        service_prim_range;
    string2         service_predir;
    string28        service_prim_name;
    string4         service_addr_suffix;
    string2         service_postdir;
    string10        service_unit_desig;
    string8         service_sec_range;
    string25        service_city;
    string2         service_state;
    string10        service_zip;
    string10        service_zip4;
    string18        service_county_name;    

    string1         billing_addr_type;
    string10        billing_prim_range;
    string2         billing_predir;
    string28        billing_prim_name;
    string4         billing_addr_suffix;
    string2         billing_postdir;
    string10        billing_unit_desig;
    string8         billing_sec_range;
    string25        billing_city;
    string2         billing_state;
    string10        billing_zip;
    string10        billing_zip4;
    string18        billing_county_name;    

    string50        debug;

  END;

END;