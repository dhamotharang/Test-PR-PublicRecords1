Import CrashCarrier,address;

EXPORT Layouts := module

Export keybuild:=CrashCarrier.layouts.keybuild;
Export base:=CrashCarrier.layouts.base;

Export crashcarrier_In := RECORD
string9 fein;
string8 inc_date;
string9 ssn;
string8 dob;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
string8 carrier_id;
string8 crash_id;
string1 carrier_source_code;
string120 carrier_name;
string50 carrier_street;
string25 carrier_city;
string5 carrier_city_code;
string2 carrier_state;
string10 carrier_zip_code;
string25 crash_colonia;
string2 prefix;
string8 docket_number;
string1 interstate;
string1 no_id_flag;
string12 state_number;
string2 state_issuing_number;
string2 source;
string60 carrier_name_source_desc;
string20 interstate_desc;
string20 no_census_number_desc;
string10 cust_name;
string10 bug_num;
 END;

 end;