export Layout_Liens_Service_Abstract := 
record
string100  PUBLICATION;
string30   Filing_type;
string50   TMSID;
string50 RMSID;
string25   Filing_jurisdiction;
string8    process_date;
string15   case_number;
string7    court_id;
string80   court_desc;
string2    court_state;
string4    record_code;
string20   debtor_f_name;
string20   debtor_m_name;
string30   debtor_l_name;
string3    generation;
string9    ssn;
string75   business_debtor;
string9    FEI_nbr ;
string50   debtor_addr1;
string10   debtor_addr2;
string30   debtor_city;
string2    debtor_state;
string9    debtor_zip_code;
string8    filing_date;
string8    paid_date;
string10   amount ;
string20   docket_number;
string75   credtor_name;
string50   credtor_street;
string30   credtor_city;
string2    credtor_st;
string9    credtor_zip;
string5    ecoa_code;
string50   attorney;
string50   atty_addr;
string30   atty_city;
string2    atty_st;
string9    atty_zip;
string15   atty_phone;
string20   tax_code;
string25   serial_number;
string8    perfected_date;
string15   county_origin;
string2    court_origin;
string6    debtor_type;
string1    debtor_type_designation;
string185  delete_amended_code;

string182  clean_debtor_addr;
string182  clean_credtor_addr;
string182  clean_atty_addr;

string73   clean_debtor_pname;
string75   clean_debtor_cname;

string73   clean_credtor_pname;
string75   clean_credtor_cname;


string73   clean_atty_pname;
string70   clean_atty_cname;




end;
