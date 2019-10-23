Import POE;
EXPORT Layouts := module

Export source_hierarchy:= Poe.Layouts.source_hierarchy;

export Base := POE.Layouts.Base;
export keybuild:=POE.layouts.keybuild;
	     
Export Poe_Base := RECORD
string2 source;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
string40 vendor_id;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string10 subject_prim_range;
string2 subject_predir;
string28 subject_prim_name;
string4 subject_addr_suffix;
string2 subject_postdir;
string10 subject_unit_desig;
string8 subject_sec_range;
string25 subject_city_name;
string2 subject_st;
string5 subject_zip;
string4 subject_zip4;
unsigned5 subject_phone;
unsigned4 subject_ssn;
unsigned4 subject_dob;
string35 subject_job_title;
string120 company_name;
string10 company_prim_range;
string2 company_predir;
string28 company_prim_name;
string4 company_addr_suffix;
string2 company_postdir;
string5 company_unit_desig;
string25 company_city_name;
string2 company_st;
string5 company_zip;
string4 company_zip4;
unsigned5 company_phone;
unsigned4 company_fein;
unsigned8 company_rawaid;
unsigned8 company_aceaid;
string20  CustomerID;
string10 cust_name;
String10  bug_num;
string9		link_ssn;
string8		link_dob;
string9		link_fein;
string8		link_inc_date;
string5		name_format;
string50	raw_indv_name;
string40	raw_subj_addr1;
string30	raw_subj_addr2;
string40	raw_cmpy_addr1;
string30	raw_cmpy_addr2;	
END;

END;