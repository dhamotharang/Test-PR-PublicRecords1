// RR-11535 - Adding Utility Data to Comprehensive Report.
IMPORT iesp;

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

    DATASET(address_layout) address_recs {MAXCOUNT(iesp.Constants.BR.MaxUtilAddresses)};

  END;

  EXPORT record_layout := RECORD

    string15        id;
    string10        exchange_serial_number;
    boolean         is_service_addr_set;
    boolean         is_billing_addr_set;

    record_layout_slim;

    string50        debug;

  END;

END;