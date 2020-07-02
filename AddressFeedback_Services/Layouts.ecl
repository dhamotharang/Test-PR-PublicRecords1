import AddressFeedback;

export Layouts := module

  export feedback_input:=record
    unsigned6 did;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string4 zip4;
  end;
    
  export feedback_common := record
    AddressFeedback.Key_AddressFeedback.did;
    AddressFeedback.Key_AddressFeedback.fname;
    AddressFeedback.Key_AddressFeedback.mname;
    AddressFeedback.Key_AddressFeedback.lname;
    AddressFeedback.Key_AddressFeedback.prim_range;
    AddressFeedback.Key_AddressFeedback.predir;
    AddressFeedback.Key_AddressFeedback.prim_name;
    AddressFeedback.Key_AddressFeedback.postdir;
    AddressFeedback.Key_AddressFeedback.addr_suffix;
    AddressFeedback.Key_AddressFeedback.unit_desig;
    AddressFeedback.Key_AddressFeedback.sec_range;
    AddressFeedback.Key_AddressFeedback.city;
    AddressFeedback.Key_AddressFeedback.st;
    AddressFeedback.Key_AddressFeedback.zip;
    AddressFeedback.Key_AddressFeedback.zip4;
    AddressFeedback.Key_AddressFeedback.phone_number;
    AddressFeedback.Key_AddressFeedback.alt_phone;
    AddressFeedback.Key_AddressFeedback.other_info;
    AddressFeedback.Key_AddressFeedback.address_contact_type;
    AddressFeedback.Key_AddressFeedback.feedback_source;
    AddressFeedback.Key_AddressFeedback.date_time_added;
    AddressFeedback.Key_AddressFeedback.loginid;
    AddressFeedback.Key_AddressFeedback.login_history_id;
    AddressFeedback.Key_AddressFeedback.companyid;
  end;
  
  export feedback_report := record
    unsigned2 feedback_count;
    string40 last_feedback_result;
    unsigned4 last_feedback_result_provided;
  end;
  
end;
