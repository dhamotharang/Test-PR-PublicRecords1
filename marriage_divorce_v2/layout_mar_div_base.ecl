export layout_mar_div_base := record
 
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_vendor_last_reported;
  
 unsigned6 record_id;  //unique record identifier that'll be used to link main and search files
 
 //current values are "3" for marriages and "7" for divorces
 //Additions:
 //"0" for unknown
 //"1" for annulment
 //-> we want to expand to include dissolutions, etc
 string1   filing_type;
 string25  filing_subtype;
 
 string5   vendor;
 string25  source_file;
 string8   process_date;
 string2   state_origin;
 
 //Same sex marriages in production reveal we can't assume Husband/Spouse relations
 string1   party1_type; //"G" for Groom, "H" for Husband, "S" for Spouse, "W" for Wife, etc
 string1   party1_name_format; //"L" for last name first, "F" for first name first
 string70  party1_name;
 string70  party1_alias;
 string8   party1_dob;
 string2   party1_birth_state;
 string3   party1_age;
 string30  party1_race;
 //string5   party1_residence_cds;//what is this? //stats reveal max length is 4
 string50  party1_addr1;
 string50  party1_csz;
 string35  party1_county;
 string20  party1_previous_marital_status;
 string20  party1_how_marriage_ended;
 string2   party1_times_married;
 string8   party1_last_marriage_end_dt;

 string1   party2_type;
 string1   party2_name_format;
 string70  party2_name;
 string70  party2_alias;
 string8   party2_dob;
 string2   party2_birth_state;
 string3   party2_age;
 string30  party2_race;
 //string5   party2_residence_cds;//what is this?
 string50  party2_addr1;
 string50  party2_csz;
 string35  party2_county;
 string20  party2_previous_marital_status;
 string20  party2_how_marriage_ended;
 string2   party2_times_married;
 string8   party2_last_marriage_end_dt;
 
 string2   number_of_children;
 
 string8   marriage_filing_dt;
 string8   marriage_dt;
 string30  marriage_city;
 string35  marriage_county;
 string10  place_of_marriage;
 string10  type_of_ceremony;
 string25  marriage_filing_number; //stats reveal current max length is 20
 string30  marriage_docket_volume;
 string8   divorce_filing_dt;
 string8   divorce_dt;
 string30  divorce_docket_volume;
 string25  divorce_filing_number;
 string30  divorce_city;
 string35  divorce_county;
 string50  grounds_for_divorce;
 string1   marriage_duration_cd;
 string3   marriage_duration;

 unsigned8 persistent_record_id := 0;			//persistent record id
end;