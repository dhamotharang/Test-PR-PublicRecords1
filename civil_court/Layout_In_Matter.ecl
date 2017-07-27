export Layout_In_Matter
 := 
  record
    string8     process_date;
    string2     vendor;
    string2     state_origin;
    string20    source_file;
    string60    case_key;
    string60    parent_case_key;
    string10    court_code;
    string60    court;
    string35    case_number;
    string10    case_type_code;
    string60    case_type;
    string175   case_title;
    string10    case_cause_code;
    string60    case_cause;
    string10    manner_of_filing_code;
    string50    manner_of_filing;
    string8     filing_date;
    string10    manner_of_judgmt_code;
    string50    manner_of_judgmt;
    string8     judgmt_date;
    string5     ruled_for_against_code;
    string20    ruled_for_against;
    string10    judgmt_type_code;
    string65    judgmt_type;
    string8     judgmt_disposition_date;
    string10    judgmt_disposition_code;
    string65    judgmt_disposition;
    string10    disposition_code;
    string65    disposition_description;
    string8     disposition_date;
    string15    suit_amount;
    string15    award_amount;
  end
  ;