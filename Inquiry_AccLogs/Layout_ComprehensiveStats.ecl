EXPORT Layout_ComprehensiveStats := module

EXPORT NonFCRA_CompanyIDsProducts := RECORD
	string8 source;
	unsigned8 total;
	string15 newest_date;
	string10 global_company_id;
	string10 company_id;
	string12 product_code;
	string30 product;
	string30 vertical;
	string30 industry;
	string30 sub_market;
	string10 use;
	string11 opt_out;
	unsigned8 monthback_0;
	unsigned8 monthback_1;
	unsigned8 monthback_2;
	unsigned8 monthback_3;
	unsigned8 monthback_4;
	unsigned8 monthback_5;
	unsigned8 monthback_6;
	unsigned8 monthback_7;
	unsigned8 monthback_8;
	unsigned8 monthback_9;
	unsigned8 monthback_10;
	unsigned8 monthback_11;
	unsigned8 monthback_12;
	unsigned8 monthback_13;
	unsigned8 monthback_14;
	unsigned8 monthback_15;
	unsigned8 monthback_16;
	unsigned8 monthback_17;
	unsigned8 monthback_18;
	unsigned8 monthback_19;
	unsigned8 monthback_20;
	unsigned8 monthback_21;
	unsigned8 monthback_22;
	unsigned8 monthback_23;
 END;

EXPORT NonFCRA_CompanyIDs := RECORD
  string global_company_id;
  string company_id;
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cnt;
 END;


EXPORT NonFCRA_NoDate := RECORD
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cntsum;
 END;


EXPORT NonFCRA_YYYYMMDD := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cntsum;
 END;


EXPORT NonFCRA_YYYYMMDDOnly := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string source;
  string product_code;
  integer8 cntsum;
 END;


EXPORT NonFCRA_BlankIndustry := RECORD
  string global_company_id;
  string company_id;
  string4 transaction_datey;
  string2 transaction_datem;
  string vertical;
  string sub_market;
  string use;
  string source;
  string product_code;
  integer8 cntsum;
 END;


EXPORT NonFCRA_Population := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string source;
  string global_company_id;
  string company_id;
  string product_code;
  string use;
  string product;
  string stat_type;
  string allowflags_translation;
  string has_full_name;
  string has_first_name;
  string has_middle_name;
  string has_last_name;
  string has_address;
  string has_city;
  string has_state;
  string has_zip;
  string has_personal_phone;
  string has_work_phone;
  string has_dob;
  string has_dl;
  string has_dl_st;
  string has_email;
  string has_ssn;
  string has_linkid;
  string has_ipaddr;
  string has_cname;
  string has_fname;
  string has_lname;
  string err_stat;
  string has_adl;
  string has_appended_ssn;
  string appended_ssn_same;
  integer8 cntsum;
  data16 result_id;
 END;


EXPORT NonFCRA_PopulationSlim := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string global_company_id;
  string company_id;
  string product_code;
  string use;
  string allowflags_translation;
  string has_full_name;
  string has_first_name;
  string has_middle_name;
  string has_last_name;
  string has_address;
  string has_city;
  string has_state;
  string has_zip;
  string has_personal_phone;
  string has_work_phone;
  string has_dob;
  string has_dl;
  string has_dl_st;
  string has_email;
  string has_ssn;
  string has_linkid;
  string has_ipaddr;
  string has_cname;
  string has_fname;
  string has_lname;
  string err_stat;
  string has_adl;
  string has_appended_ssn;
  string appended_ssn_same;
  integer8 cntsum2;
 END;



EXPORT FCRA_CompanyIDs := RECORD
  string global_company_id;
  string company_id;
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string fcra_permissions;
  string glb_permissions;
  string dppa_permissions;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cnt;
 END;


EXPORT FCRA_NoDate := RECORD
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string fcra_permissions;
  string glb_permissions;
  string dppa_permissions;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cntsum;
 END;


EXPORT FCRA_YYYYMMDD := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string2 transaction_dated;
  string stat_type;
  string industry;
  string vertical;
  string sub_market;
  string use;
  string product;
  string source;
  string product_code;
  string fcra_permissions;
  string glb_permissions;
  string dppa_permissions;
  string has_ssn;
  string has_email;
  string has_ein;
  string has_dob;
  string has_address;
  string has_phone;
  string has_adl;
  string has_bdid;
  boolean opt_out;
  integer8 cntsum;
 END;


EXPORT FCRA_YYYYMMDDOnly := RECORD
  string4 transaction_datey;
  string2 transaction_datem;
  string source;
  string product_code;
  integer8 cntsum;
 END;


EXPORT FCRA_BlankIndustry := RECORD
  string global_company_id;
  string company_id;
  string4 transaction_datey;
  string2 transaction_datem;
  string vertical;
  string sub_market;
  string use;
  string source;
  string product_code;
  integer8 cntsum;
 END;


end;