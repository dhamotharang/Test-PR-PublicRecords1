import YellowPages;

#workunit('name', 'Experian YP Stats ');

yp := YellowPages.File_YellowPages;

Layout_YP_Slim := record
STRING9   seq_no;
STRING10  primary_key;
STRING125 business_name;
STRING100 orig_street;
STRING75  orig_city;
STRING2   orig_state;
STRING9   orig_zip;
STRING9   orig_latitude;
STRING10  orig_longitude;
STRING10  orig_phone10;
STRING140 heading_string;
STRING8   sic_code;
STRING1   toll_free_indicator;
STRING1   fax_indicator;
STRING6   pub_date;
STRING9   index_value;
STRING6   naics_code;
STRING50  web_address;
STRING35  email_address;
STRING1   employee_code;
STRING10  executive_title;
STRING33  executive_name;
STRING1   derog_legal_indicator;
STRING1   record_type;
STRING1   addr_suffix_flag;
string4   err_stat;
end;

Layout_YP_Slim InitYP(YellowPages.Layout_YellowPages l) := transform
self := l;
end;

yp_init := project(yp, InitYP(left));

Layout_YP_Stat := record
yp_init.orig_state;
integer4 seq_no_cnt := count(group, yp_init.seq_no <> '');
integer4 primary_key_cnt := count(group, yp_init.primary_key <> '');
integer4 business_name_cnt := count(group, yp_init.business_name <> '');
integer4 orig_street_cnt := count(group, yp_init.orig_street <> '');
integer4 orig_city_cnt := count(group, yp_init.orig_city <> '');
integer4 orig_state_cnt := count(group, yp_init.orig_state <> '');
integer4 orig_zip_cnt := count(group, yp_init.orig_zip <> '');
integer4 orig_latitude_cnt := count(group, yp_init.orig_latitude <> '');
integer4 orig_longitude_cnt := count(group, yp_init.orig_longitude <> '');
integer4 orig_phone10_cnt := count(group, yp_init.orig_phone10 <> '');
integer4 heading_string_cnt := count(group, yp_init.heading_string <> '');
integer4 sic_code_cnt := count(group, yp_init.sic_code <> '');
integer4 toll_free_indicator_cnt := count(group, yp_init.toll_free_indicator <> '');
integer4 fax_indicator_cnt := count(group, yp_init.fax_indicator <> '');
integer4 pub_date_cnt := count(group, yp_init.pub_date <> '');
integer4 index_value_cnt := count(group, yp_init.index_value <> '');
integer4 naics_code_cnt := count(group, yp_init.naics_code <> '');
integer4 web_address_cnt := count(group, yp_init.web_address <> '');
integer4 email_address_cnt := count(group, yp_init.email_address <> '');
integer4 employee_code_cnt := count(group, yp_init.employee_code <> '');
integer4 executive_title_cnt := count(group, yp_init.executive_title <> '');
integer4 executive_name_cnt := count(group, yp_init.executive_name <> '');
integer4 derog_legal_indicator_cnt := count(group, yp_init.derog_legal_indicator <> '');
integer4 record_type_cnt := count(group, yp_init.record_type <> '');
integer4 addr_suffix_flag_cnt := count(group, yp_init.addr_suffix_flag <> '');

// clean address error stats
integer4 err_stat_S := count(group, yp_init.err_stat[1] = 'S');
integer4 err_stat_E := count(group, yp_init.err_stat[1] = 'E');
integer4 err_stat_U := count(group, yp_init.err_stat[1] = 'U');
integer4 err_stat_other := count(group, yp_init.err_stat[1] not in ['S','E','U']);

integer4 total:= count(group);
END;

yp_stat := table(yp_init, Layout_YP_Stat, orig_state, few);

output(yp_stat);