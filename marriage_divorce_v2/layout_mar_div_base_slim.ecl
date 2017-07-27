export layout_mar_div_base_slim := record
 
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
 