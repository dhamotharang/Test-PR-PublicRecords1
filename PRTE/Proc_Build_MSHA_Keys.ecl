import	_control;

export Proc_Build_MSHA_Keys(string pIndexVersion) := function

rKeyMSHA__autokey__contractor_address := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__contractor_addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__contractor_citystname := RECORD
  unsigned4 city_code;
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__contractor_citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__contractor_name := RECORD
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__contractor_nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__contractor_namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__contractor_payload := RECORD
  unsigned6 fakeid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string7 contractor_id;
  string7 contractor_id_cleaned;
  string1 commodity_type;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string50 sub_unit_description;
  string80 contractor_name;
  string8 contractor_start_date;
  string8 contractor_end_date;
  string4 calendar_year;
  string7 hours_reported_for_year;
  string8 annual_coal_production;
  string5 avg_annual_employee_ct;
  string4 production_year;
  string1 production_quarter;
  string4 fiscal_year;
  string1 fiscal_quarter;
  string5 avg_employee_ct;
  string7 employee_hours_worked;
  string8 coal_production;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 zero;
END;

rKeyMSHA__autokey__contractor_stname := RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 zip;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__contractor_stnameb2 := RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__contractor_zip := RECORD
  integer4 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__contractor_zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_address := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_controller_addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_citystname := RECORD
  unsigned4 city_code;
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_controller_citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_name := RECORD
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_controller_nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_payload := RECORD
  unsigned6 fakeid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string80 mine_name;
  string7 controller_id;
  string7 controller_id_cleaned;
  string80 controller_name;
  string80 controller_name_cleaned;
  string80 controller_name_business;
  string1 controller_name_name_flag;
  string20 controller_name_cln_fname;
  string20 controller_name_cln_mname;
  string20 controller_name_cln_lname;
  string5 controller_name_cln_suffix;
  string7 operator_id;
  string7 operator_id_cleaned;
  string80 operator_name;
  string80 operator_name_cleaned;
  string80 operator_name_business;
  string1 operator_name_name_flag;
  string20 operator_name_cln_fname;
  string20 operator_name_cln_mname;
  string20 operator_name_cln_lname;
  string5 operator_name_cln_suffix;
  string8 date_added;
  string8 date_updated;
  string50 website;
  string2 state;
  string1 coal_or_metal_mine;
  string20 mine_type;
  string20 mine_status;
  string8 mine_status_date;
  string2 mine_state;
  string80 county;
  string8 begin_date;
  string6 sic;
  string80 sic_description;
  string12 commodity_code;
  string50 commodity_description;
  string6 naics_code;
  string4 sic_code;
  string2 suffix_code;
  string5 old_sic_code;
  string1 activity_indicator;
  string8 activity_date;
  string8 inactivity_date;
  string2 bureau_mines_state_code;
  string3 fips_county_code;
  string2 congress_dist_code;
  string50 company_type;
  string3 district;
  string5 office_code;
  string50 office_name;
  string20 assess_control_no;
  string4 sic_suffix;
  string6 second_sic_code;
  string50 second_sic_description;
  string4 second_sic_suffix;
  string2 second_sic_group;
  string1 primary_industry_group;
  string50 primary_industry_code_desc;
  string1 second_industry_group;
  string50 second_industry_code_desc;
  string50 classification_desc;
  string50 classification_code;
  string50 classification_date;
  string1 portable_mine_indicator;
  string2 portable_mine_fips;
  string1 days_per_week;
  string2 hours_per_shift;
  string2 production_shifts_per_day;
  string2 maintenance_shifts_per_day;
  string5 number_of_emp;
  string1 training_indicator;
  string8 longitude;
  string8 latitude;
  string5 average_mine_height;
  string3 mine_gas_category;
  string8 methane_liberation;
  string2 no_of_producing_pits;
  string2 no_of_non_producing_pits;
  string2 no_of_tailing_ponds;
  string1 pilliar_recovery_indicator;
  string1 highwall_mine_indicator;
  string1 multiple_pits_indicator;
  string1 miner_rep_indicator;
  string1 safety_committee_indicator;
  string5 miles_from_mine;
  string150 direction_to_mine;
  string80 nearest_town;
  string8 controller_start_date;
  string8 controller_end_date;
  string8 operator_start_date;
  string8 operator_end_date;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 zero;
END;

rKeyMSHA__autokey__mine_controller_stname := RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 zip;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_controller_stnameb2 := RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_controller_zip := RECORD
  integer4 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_controller_zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_address := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_citystname := RECORD
  unsigned4 city_code;
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_name := RECORD
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_payload := RECORD
  unsigned6 fakeid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string80 mine_name;
  string7 controller_id;
  string7 controller_id_cleaned;
  string80 controller_name;
  string80 controller_name_cleaned;
  string80 controller_name_business;
  string1 controller_name_name_flag;
  string20 controller_name_cln_fname;
  string20 controller_name_cln_mname;
  string20 controller_name_cln_lname;
  string5 controller_name_cln_suffix;
  string7 operator_id;
  string7 operator_id_cleaned;
  string80 operator_name;
  string80 operator_name_cleaned;
  string80 operator_name_business;
  string1 operator_name_name_flag;
  string20 operator_name_cln_fname;
  string20 operator_name_cln_mname;
  string20 operator_name_cln_lname;
  string5 operator_name_cln_suffix;
  string8 date_added;
  string8 date_updated;
  string50 website;
  string2 state;
  string1 coal_or_metal_mine;
  string20 mine_type;
  string20 mine_status;
  string8 mine_status_date;
  string2 mine_state;
  string80 county;
  string8 begin_date;
  string6 sic;
  string80 sic_description;
  string12 commodity_code;
  string50 commodity_description;
  string6 naics_code;
  string4 sic_code;
  string2 suffix_code;
  string5 old_sic_code;
  string1 activity_indicator;
  string8 activity_date;
  string8 inactivity_date;
  string2 bureau_mines_state_code;
  string3 fips_county_code;
  string2 congress_dist_code;
  string50 company_type;
  string3 district;
  string5 office_code;
  string50 office_name;
  string20 assess_control_no;
  string4 sic_suffix;
  string6 second_sic_code;
  string50 second_sic_description;
  string4 second_sic_suffix;
  string2 second_sic_group;
  string1 primary_industry_group;
  string50 primary_industry_code_desc;
  string1 second_industry_group;
  string50 second_industry_code_desc;
  string50 classification_desc;
  string50 classification_code;
  string50 classification_date;
  string1 portable_mine_indicator;
  string2 portable_mine_fips;
  string1 days_per_week;
  string2 hours_per_shift;
  string2 production_shifts_per_day;
  string2 maintenance_shifts_per_day;
  string5 number_of_emp;
  string1 training_indicator;
  string8 longitude;
  string8 latitude;
  string5 average_mine_height;
  string3 mine_gas_category;
  string8 methane_liberation;
  string2 no_of_producing_pits;
  string2 no_of_non_producing_pits;
  string2 no_of_tailing_ponds;
  string1 pilliar_recovery_indicator;
  string1 highwall_mine_indicator;
  string1 multiple_pits_indicator;
  string1 miner_rep_indicator;
  string1 safety_committee_indicator;
  string5 miles_from_mine;
  string150 direction_to_mine;
  string80 nearest_town;
  string8 controller_start_date;
  string8 controller_end_date;
  string8 operator_start_date;
  string8 operator_end_date;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 zero;
END;

rKeyMSHA__autokey__mine_stname := RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 zip;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_stnameb2 := RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_zip := RECORD
  integer4 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_operator_address := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_operator_addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_operator_citystname := RECORD
  unsigned4 city_code;
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_operator_citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyMSHA__autokey__mine_operator_name := RECORD
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_operator_nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_operator_namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_operator_payload := RECORD
  unsigned6 fakeid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string80 mine_name;
  string7 controller_id;
  string7 controller_id_cleaned;
  string80 controller_name;
  string80 controller_name_cleaned;
  string80 controller_name_business;
  string1 controller_name_name_flag;
  string20 controller_name_cln_fname;
  string20 controller_name_cln_mname;
  string20 controller_name_cln_lname;
  string5 controller_name_cln_suffix;
  string7 operator_id;
  string7 operator_id_cleaned;
  string80 operator_name;
  string80 operator_name_cleaned;
  string80 operator_name_business;
  string1 operator_name_name_flag;
  string20 operator_name_cln_fname;
  string20 operator_name_cln_mname;
  string20 operator_name_cln_lname;
  string5 operator_name_cln_suffix;
  string8 date_added;
  string8 date_updated;
  string50 website;
  string2 state;
  string1 coal_or_metal_mine;
  string20 mine_type;
  string20 mine_status;
  string8 mine_status_date;
  string2 mine_state;
  string80 county;
  string8 begin_date;
  string6 sic;
  string80 sic_description;
  string12 commodity_code;
  string50 commodity_description;
  string6 naics_code;
  string4 sic_code;
  string2 suffix_code;
  string5 old_sic_code;
  string1 activity_indicator;
  string8 activity_date;
  string8 inactivity_date;
  string2 bureau_mines_state_code;
  string3 fips_county_code;
  string2 congress_dist_code;
  string50 company_type;
  string3 district;
  string5 office_code;
  string50 office_name;
  string20 assess_control_no;
  string4 sic_suffix;
  string6 second_sic_code;
  string50 second_sic_description;
  string4 second_sic_suffix;
  string2 second_sic_group;
  string1 primary_industry_group;
  string50 primary_industry_code_desc;
  string1 second_industry_group;
  string50 second_industry_code_desc;
  string50 classification_desc;
  string50 classification_code;
  string50 classification_date;
  string1 portable_mine_indicator;
  string2 portable_mine_fips;
  string1 days_per_week;
  string2 hours_per_shift;
  string2 production_shifts_per_day;
  string2 maintenance_shifts_per_day;
  string5 number_of_emp;
  string1 training_indicator;
  string8 longitude;
  string8 latitude;
  string5 average_mine_height;
  string3 mine_gas_category;
  string8 methane_liberation;
  string2 no_of_producing_pits;
  string2 no_of_non_producing_pits;
  string2 no_of_tailing_ponds;
  string1 pilliar_recovery_indicator;
  string1 highwall_mine_indicator;
  string1 multiple_pits_indicator;
  string1 miner_rep_indicator;
  string1 safety_committee_indicator;
  string5 miles_from_mine;
  string150 direction_to_mine;
  string80 nearest_town;
  string8 controller_start_date;
  string8 controller_end_date;
  string8 operator_start_date;
  string8 operator_end_date;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 zero;
END;

rKeyMSHA__autokey__mine_operator_stname := RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 zip;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_operator_stnameb2 := RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__autokey__mine_operator_zip := RECORD
  integer4 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned2 yob;
  unsigned2 s4;
  integer4 dob;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 city1;
  unsigned4 city2;
  unsigned4 city3;
  unsigned4 rel_fname1;
  unsigned4 rel_fname2;
  unsigned4 rel_fname3;
  unsigned4 lookups;
  unsigned6 did;
END;

rKeyMSHA__autokey__mine_operator_zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

rKeyMSHA__contractorid__accident := RECORD
  string7 contractor_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string7 contractor_id_cleaned;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string50 sub_unit_description;
  string8 accident_date;
  string40 degree_of_injury;
  string50 accident_classification_description;
  string50 occupation_code_description;
  string40 miner_activity;
  udecimal4_2 total_experience;
  udecimal4_2 mine_experience;
  udecimal4_2 job_experience;
  string1000 accident_narrative;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__contractorid__contractor := RECORD
  string7 contractor_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string7 contractor_id_cleaned;
  string1 commodity_type;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string50 sub_unit_description;
  string80 contractor_name;
  string8 contractor_start_date;
  string8 contractor_end_date;
  string4 calendar_year;
  string7 hours_reported_for_year;
  string8 annual_coal_production;
  string5 avg_annual_employee_ct;
  string4 production_year;
  string1 production_quarter;
  string4 fiscal_year;
  string1 fiscal_quarter;
  string5 avg_employee_ct;
  string7 employee_hours_worked;
  string8 coal_production;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__contractorid__events := RECORD
  string7 contractor_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id;
  string7 mine_id_cleaned;
  string7 event_no;
  string7 event_no_cleaned;
  string7 contractor_id_cleaned;
  string3 inspection_activity_code;
  string3 inspection_activity_code_cleaned;
  string50 inspection_activity_code_description;
  string8 inspection_begin_date;
  string8 inspection_end_date;
  string5 inspector_office_code;
  string5 active_sections;
  string2 idle_sections;
  string3 number_of_shaft_slope_sinking;
  string3 impoundment_construction;
  string3 building_construction_sites;
  string3 drag_lines;
  string3 number_of_unclassified_construction;
  string1 company_records;
  string1 surface_underground_indicator;
  string1 surf_facility_indicator;
  string1 refuse_pile_indicator;
  string1 explosive_storage;
  string1 out_by_area_indicator;
  string1 major_construction_indicator;
  string1 shaft_slope_indicator;
  string1 impoundment_indicator;
  string1 miscellaneous_area;
  string60 program_area;
  string7 number_of_air_samples;
  string7 number_of_dust_samples;
  string7 number_of_survey_samples;
  string7 number_of_respiratory_dust_samples;
  string7 number_of_noise_samples;
  string7 number_of_other_samples;
  string2 number_of_inspectors;
  string8 total_on_site_hours;
  string8 total_inspection_hours;
  string1 coal_metal_indicator;
  string7 violation_no;
  string7 violation_no_cleaned;
  string8 date_issued;
  string1 s_s_designation;
  string20 section_of_act;
  string20 type_of_issuance;
  string20 cfr_30;
  string8 date_terminated;
  string7 violator_id;
  string7 violator_id_cleaned;
  string80 violator_name;
  string9 proposed_penalty_amount;
  string9 current_assessment_amount;
  string9 paid_proposed_penalty_amount;
  string30 last_action_code;
  string8 final_order_date;
  string10 violator_type;
  string8 violation_occur_date;
  string4 violation_calendar_year;
  string1 violation_calendar_quarter;
  string4 violation_fiscal_year;
  string1 violation_fiscal_quarter;
  string4 violation_issue_time;
  string20 section_of_act2;
  string8 orig_termination_due_date;
  string4 orig_termination_due_time;
  string8 latest_termination_due_date;
  string4 latest_termination_due_time;
  string4 termination_time;
  string20 termination_type;
  string10 initial_violation_no;
  string10 replaced_order_no;
  string20 likelihood;
  string20 injury_illness;
  string5 no_of_person_affected;
  string20 negligence;
  string1 written_notice;
  string20 enforcement_area;
  string1 special_assess;
  string20 primary_or_assoc_mill;
  string8 right_to_conference_date;
  string1 violator_type_indicator;
  string8 bill_print_date;
  string8 last_action_date;
  string50 docket_no;
  string20 docket_status_code;
  string1 contested_indicator;
  string8 contested_date;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__mineid__accident := RECORD
  string7 mine_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id_cleaned;
  string7 contractor_id;
  string7 contractor_id_cleaned;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string50 sub_unit_description;
  string8 accident_date;
  string40 degree_of_injury;
  string50 accident_classification_description;
  string50 occupation_code_description;
  string40 miner_activity;
  udecimal4_2 total_experience;
  udecimal4_2 mine_experience;
  udecimal4_2 job_experience;
  string1000 accident_narrative;
  unsigned8 __internal_fpos__;
end;

rKeyMSHA__mineid__contractor := RECORD
  string7 mine_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id_cleaned;
  string7 contractor_id;
  string7 contractor_id_cleaned;
  string1 commodity_type;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string50 sub_unit_description;
  string80 contractor_name;
  string8 contractor_start_date;
  string8 contractor_end_date;
  string4 calendar_year;
  string7 hours_reported_for_year;
  string8 annual_coal_production;
  string5 avg_annual_employee_ct;
  string4 production_year;
  string1 production_quarter;
  string4 fiscal_year;
  string1 fiscal_quarter;
  string5 avg_employee_ct;
  string7 employee_hours_worked;
  string8 coal_production;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__mineid__events := RECORD
  string7 mine_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id_cleaned;
  string7 event_no;
  string7 event_no_cleaned;
  string7 contractor_id;
  string7 contractor_id_cleaned;
  string3 inspection_activity_code;
  string3 inspection_activity_code_cleaned;
  string50 inspection_activity_code_description;
  string8 inspection_begin_date;
  string8 inspection_end_date;
  string5 inspector_office_code;
  string5 active_sections;
  string2 idle_sections;
  string3 number_of_shaft_slope_sinking;
  string3 impoundment_construction;
  string3 building_construction_sites;
  string3 drag_lines;
  string3 number_of_unclassified_construction;
  string1 company_records;
  string1 surface_underground_indicator;
  string1 surf_facility_indicator;
  string1 refuse_pile_indicator;
  string1 explosive_storage;
  string1 out_by_area_indicator;
  string1 major_construction_indicator;
  string1 shaft_slope_indicator;
  string1 impoundment_indicator;
  string1 miscellaneous_area;
  string60 program_area;
  string7 number_of_air_samples;
  string7 number_of_dust_samples;
  string7 number_of_survey_samples;
  string7 number_of_respiratory_dust_samples;
  string7 number_of_noise_samples;
  string7 number_of_other_samples;
  string2 number_of_inspectors;
  string8 total_on_site_hours;
  string8 total_inspection_hours;
  string1 coal_metal_indicator;
  string7 violation_no;
  string7 violation_no_cleaned;
  string8 date_issued;
  string1 s_s_designation;
  string20 section_of_act;
  string20 type_of_issuance;
  string20 cfr_30;
  string8 date_terminated;
  string7 violator_id;
  string7 violator_id_cleaned;
  string80 violator_name;
  string9 proposed_penalty_amount;
  string9 current_assessment_amount;
  string9 paid_proposed_penalty_amount;
  string30 last_action_code;
  string8 final_order_date;
  string10 violator_type;
  string8 violation_occur_date;
  string4 violation_calendar_year;
  string1 violation_calendar_quarter;
  string4 violation_fiscal_year;
  string1 violation_fiscal_quarter;
  string4 violation_issue_time;
  string20 section_of_act2;
  string8 orig_termination_due_date;
  string4 orig_termination_due_time;
  string8 latest_termination_due_date;
  string4 latest_termination_due_time;
  string4 termination_time;
  string20 termination_type;
  string10 initial_violation_no;
  string10 replaced_order_no;
  string20 likelihood;
  string20 injury_illness;
  string5 no_of_person_affected;
  string20 negligence;
  string1 written_notice;
  string20 enforcement_area;
  string1 special_assess;
  string20 primary_or_assoc_mill;
  string8 right_to_conference_date;
  string1 violator_type_indicator;
  string8 bill_print_date;
  string8 last_action_date;
  string50 docket_no;
  string20 docket_status_code;
  string1 contested_indicator;
  string8 contested_date;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__mineid__mine := RECORD
  string7 mine_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id_cleaned;
  string80 mine_name;
  string7 controller_id;
  string7 controller_id_cleaned;
  string80 controller_name;
  string80 controller_name_cleaned;
  string80 controller_name_business;
  string1 controller_name_name_flag;
  string20 controller_name_cln_fname;
  string20 controller_name_cln_mname;
  string20 controller_name_cln_lname;
  string5 controller_name_cln_suffix;
  string7 operator_id;
  string7 operator_id_cleaned;
  string80 operator_name;
  string80 operator_name_cleaned;
  string80 operator_name_business;
  string1 operator_name_name_flag;
  string20 operator_name_cln_fname;
  string20 operator_name_cln_mname;
  string20 operator_name_cln_lname;
  string5 operator_name_cln_suffix;
  string8 date_added;
  string8 date_updated;
  string50 website;
  string2 state;
  string1 coal_or_metal_mine;
  string20 mine_type;
  string20 mine_status;
  string8 mine_status_date;
  string2 mine_state;
  string80 county;
  string8 begin_date;
  string6 sic;
  string80 sic_description;
  string12 commodity_code;
  string50 commodity_description;
  string6 naics_code;
  string4 sic_code;
  string2 suffix_code;
  string5 old_sic_code;
  string1 activity_indicator;
  string8 activity_date;
  string8 inactivity_date;
  string2 bureau_mines_state_code;
  string3 fips_county_code;
  string2 congress_dist_code;
  string50 company_type;
  string3 district;
  string5 office_code;
  string50 office_name;
  string20 assess_control_no;
  string7 assess_control_no_real;
  string4 sic_suffix;
  string6 second_sic_code;
  string50 second_sic_description;
  string4 second_sic_suffix;
  string2 second_sic_group;
  string1 primary_industry_group;
  string50 primary_industry_code_desc;
  string1 second_industry_group;
  string50 second_industry_code_desc;
  string50 classification_desc;
  string50 classification_code;
  string50 classification_date;
  string1 portable_mine_indicator;
  string2 portable_mine_fips;
  string1 days_per_week;
  string2 hours_per_shift;
  string2 production_shifts_per_day;
  string2 maintenance_shifts_per_day;
  string5 number_of_emp;
  string1 training_indicator;
  string8 longitude;
  string8 latitude;
  string5 average_mine_height;
  string3 mine_gas_category;
  string8 methane_liberation;
  string2 no_of_producing_pits;
  string2 no_of_non_producing_pits;
  string2 no_of_tailing_ponds;
  string1 pilliar_recovery_indicator;
  string1 highwall_mine_indicator;
  string1 multiple_pits_indicator;
  string1 miner_rep_indicator;
  string1 safety_committee_indicator;
  string5 miles_from_mine;
  string150 direction_to_mine;
  string80 nearest_town;
  string8 controller_start_date;
  string8 controller_end_date;
  string8 operator_start_date;
  string8 operator_end_date;
  unsigned8 __internal_fpos__;
END;

rKeyMSHA__mineid__operator := RECORD
  string7 mine_id;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string7 mine_id_cleaned;
  string2 sub_unit;
  string2 sub_unit_cleaned;
  string4 calendar_year;
  string7 hours_reported_for_year;
  string8 annual_coal_production;
  string5 avg_annual_employee_ct;
  string50 sub_unit_description;
  string4 production_year;
  string1 production_quarter;
  string4 qt_fiscal_year;
  string1 qt_fiscal_quarter;
  string5 avg_employee_ct;
  string7 employee_hours_worked;
  string8 coal_production;
  unsigned8 __internal_fpos__;
END;

ds_contractor_address				:=dataset([],rKeyMSHA__autokey__contractor_address);	
ds_contractor_addressb2			:=dataset([],rKeyMSHA__autokey__contractor_addressb2);	
ds_contractor_citystname		:=dataset([],rKeyMSHA__autokey__contractor_citystname);	
ds_contractor_citystnameb2	:=dataset([],rKeyMSHA__autokey__contractor_citystnameb2);	
ds_contractor_name					:=dataset([],rKeyMSHA__autokey__contractor_name);	
ds_contractor_nameb2				:=dataset([],rKeyMSHA__autokey__contractor_nameb2);
ds_contractor_namewords2		:=dataset([],rKeyMSHA__autokey__contractor_namewords2);	
ds_contractor_payload				:=dataset([],rKeyMSHA__autokey__contractor_payload);
ds_contractor_stname				:=dataset([],rKeyMSHA__autokey__contractor_stname);	
ds_contractor_stnameb2			:=dataset([],rKeyMSHA__autokey__contractor_stnameb2);	
ds_contractor_zip						:=dataset([],rKeyMSHA__autokey__contractor_zip);	
ds_contractor_zipb2					:=dataset([],rKeyMSHA__autokey__contractor_zipb2);	
ds_controller_address				:=dataset([],rKeyMSHA__autokey__mine_controller_address);	
ds_controller_addressb2			:=dataset([],rKeyMSHA__autokey__mine_controller_addressb2);	
ds_controller_citystname		:=dataset([],rKeyMSHA__autokey__mine_controller_citystname);	
ds_controller_citystnameb2	:=dataset([],rKeyMSHA__autokey__mine_controller_citystnameb2);	
ds_controller_name					:=dataset([],rKeyMSHA__autokey__mine_controller_name);	
ds_controller_nameb2				:=dataset([],rKeyMSHA__autokey__mine_controller_nameb2);	
ds_controller_namewords2		:=dataset([],rKeyMSHA__autokey__mine_controller_namewords2);	
ds_controller_payload				:=dataset([],rKeyMSHA__autokey__mine_controller_payload);	
ds_controller_stname				:=dataset([],rKeyMSHA__autokey__mine_controller_stname);	
ds_controller_stnameb2			:=dataset([],rKeyMSHA__autokey__mine_controller_stnameb2);	
ds_controller_zip						:=dataset([],rKeyMSHA__autokey__mine_controller_zip);	
ds_controller_zipb2					:=dataset([],rKeyMSHA__autokey__mine_controller_zipb2);	
ds_mine_address							:=dataset([],rKeyMSHA__autokey__mine_address);	
ds_mine_addressb2						:=dataset([],rKeyMSHA__autokey__mine_addressb2);	
ds_mine_citystname					:=dataset([],rKeyMSHA__autokey__mine_citystname);	
ds_mine_citystnameb2				:=dataset([],rKeyMSHA__autokey__mine_citystnameb2);	
ds_mine_name								:=dataset([],rKeyMSHA__autokey__mine_name);
ds_mine_nameb2							:=dataset([],rKeyMSHA__autokey__mine_nameb2);	
ds_mine_namewords2					:=dataset([],rKeyMSHA__autokey__mine_namewords2);	
ds_mine_payload							:=dataset([],rKeyMSHA__autokey__mine_payload);
ds_mine_stname							:=dataset([],rKeyMSHA__autokey__mine_stname);	
ds_mine_stnameb2						:=dataset([],rKeyMSHA__autokey__mine_stnameb2);	
ds_mine_zip									:=dataset([],rKeyMSHA__autokey__mine_zip);	
ds_mine_zipb2								:=dataset([],rKeyMSHA__autokey__mine_zipb2);	
ds_operator_address					:=dataset([],rKeyMSHA__autokey__mine_operator_address);	
ds_operator_addressb2				:=dataset([],rKeyMSHA__autokey__mine_operator_addressb2);	
ds_operator_citystname			:=dataset([],rKeyMSHA__autokey__mine_operator_citystname);	
ds_operator_citystnameb2		:=dataset([],rKeyMSHA__autokey__mine_operator_citystnameb2);	
ds_operator_name						:=dataset([],rKeyMSHA__autokey__mine_operator_name);	
ds_operator_nameb2					:=dataset([],rKeyMSHA__autokey__mine_operator_nameb2);	
ds_operator_namewords2			:=dataset([],rKeyMSHA__autokey__mine_operator_namewords2);	
ds_operator_payload					:=dataset([],rKeyMSHA__autokey__mine_operator_payload);	
ds_operator_stname					:=dataset([],rKeyMSHA__autokey__mine_operator_stname);	
ds_operator_stnameb2				:=dataset([],rKeyMSHA__autokey__mine_operator_stnameb2);	
ds_operator_zip							:=dataset([],rKeyMSHA__autokey__mine_operator_zip);	
ds_operator_zipb2						:=dataset([],rKeyMSHA__autokey__mine_operator_zipb2);	
ds_contractorid_accident		:=dataset([],rKeyMSHA__contractorid__accident);
ds_contractorid_contractor	:=dataset([],rKeyMSHA__contractorid__contractor);	
ds_contractorid_events			:=dataset([],rKeyMSHA__contractorid__events);	
ds_mineid_accident					:=dataset([],rKeyMSHA__mineid__accident);
ds_mineid_contractor				:=dataset([],rKeyMSHA__mineid__contractor);
ds_mineid_events						:=dataset([],rKeyMSHA__mineid__events);	
ds_mineid_mine							:=dataset([],rKeyMSHA__mineid__mine);	
ds_mineid_operator					:=dataset([],rKeyMSHA__mineid__operator);	
 		

contractor_address_in  			:=index(ds_contractor_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups,did}, {ds_contractor_address}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::address');	
contractor_addressb2_in  		:=index(ds_contractor_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_contractor_addressb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::addressb2');	
contractor_citystname_in  	:=index(ds_contractor_citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_contractor_citystname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::citystname');	
contractor_citystnameb2_in  :=index(ds_contractor_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {ds_contractor_citystnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::citystnameb2');	
contractor_name_in  				:=index(ds_contractor_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_contractor_name}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::name');	
contractor_nameb2_in  			:=index(ds_contractor_nameb2, {cname_indic,cname_sec,bdid}, {ds_contractor_nameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::nameb2');
contractor_namewords2_in 		:=index(ds_contractor_namewords2, {word,state,seq,bdid}, {ds_contractor_namewords2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::namewords2');	
contractor_payload_in			  :=index(ds_contractor_payload, {fakeid}, {ds_contractor_payload}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::payload');
contractor_stname_in			  :=index(ds_contractor_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_contractor_stname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::stname');	
contractor_stnameb2_in  		:=index(ds_contractor_stnameb2, {st,cname_indic,cname_sec,bdid,lookups}, {ds_contractor_stnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::stnameb2');	
contractor_zip_in  					:=index(ds_contractor_zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_contractor_zip}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::zip');	
contractor_zipb2_in  				:=index(ds_contractor_zipb2, {zip,cname_indic,cname_sec,bdid,lookups}, {ds_contractor_zipb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_contractor::zipb2');	
controller_address_in  			:=index(ds_controller_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups,did}, {ds_controller_address}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::address');	
controller_addressb2_in  		:=index(ds_controller_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid,lookups}, {ds_controller_addressb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::addressb2');	
controller_citystname_in  	:=index(ds_controller_citystname,    {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_controller_citystname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::citystname');	
controller_citystnameb2_in  :=index(ds_controller_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {ds_controller_citystnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::citystnameb2');	
controller_name_in  				:=index(ds_controller_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_controller_name}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::name');	
controller_nameb2_in  			:=index(ds_controller_nameb2, {cname_indic,cname_sec,bdid}, {ds_controller_nameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::nameb2');	
controller_namewords2_in  	:=index(ds_controller_namewords2, {word,state,seq,bdid}, {ds_controller_namewords2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::namewords2');	
controller_payload_in  			:=index(ds_controller_payload, {fakeid}, {ds_controller_payload}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::payload');	
controller_stname_in  			:=index(ds_controller_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_controller_stname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::stname');	
controller_stnameb2_in  		:=index(ds_controller_stnameb2, {st,cname_indic,cname_sec,bdid,lookups}, {ds_controller_stnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::stnameb2');	
controller_zip_in  					:=index(ds_controller_zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_controller_zip}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::zip');	
controller_zipb2_in  				:=index(ds_controller_zipb2, {zip,cname_indic,cname_sec,bdid,lookups}, {ds_controller_zipb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::controller::zipb2');	
mine_address_in  						:=index(ds_mine_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups,did}, {ds_mine_address}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::address');	
mine_addressb2_in  					:=index(ds_mine_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid,lookups}, {ds_mine_addressb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::addressb2');	
mine_citystname_in  				:=index(ds_mine_citystname,    {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_mine_citystname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::citystname');	
mine_citystnameb2_in  			:=index(ds_mine_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {ds_mine_citystnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::citystnameb2');	
mine_name_in  							:=index(ds_mine_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_mine_name}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::name');
mine_nameb2_in  						:=index(ds_mine_nameb2, {cname_indic,cname_sec,bdid}, {ds_mine_nameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::nameb2');	
mine_namewords2_in  				:=index(ds_mine_namewords2, {word,state,seq,bdid}, {ds_mine_namewords2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::namewords2');	
mine_payload_in  						:=index(ds_mine_payload, {fakeid}, {ds_mine_payload}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::payload');
mine_stname_in 							:=index(ds_mine_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_mine_stname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::stname');	
mine_stnameb2_in					  :=index(ds_mine_stnameb2, {st,cname_indic,cname_sec,bdid,lookups}, {ds_mine_stnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::stnameb2');	
mine_zip_in  								:=index(ds_mine_zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_mine_zip}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::zip');	
mine_zipb2_in  							:=index(ds_mine_zipb2, {zip,cname_indic,cname_sec,bdid,lookups}, {ds_mine_zipb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::mine::zipb2');	
operator_address_in  				:=index(ds_operator_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups,did}, {ds_operator_address}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::address');	
operator_addressb2_in  			:=index(ds_operator_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid,lookups}, {ds_operator_addressb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::addressb2');	
operator_citystname_in  		:=index(ds_operator_citystname,    {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_operator_citystname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::citystname');	
operator_citystnameb2_in  	:=index(ds_operator_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid,lookups}, {ds_operator_citystnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::citystnameb2	');	
operator_name_in  					:=index(ds_operator_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_operator_name}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::name');	
operator_nameb2_in  				:=index(ds_operator_nameb2, {cname_indic,cname_sec,bdid}, {ds_operator_nameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::nameb2');	
operator_namewords2_in  		:=index(ds_operator_namewords2, {word,state,seq,bdid}, {ds_operator_namewords2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::namewords2');	
operator_payload_in  				:=index(ds_operator_payload, {fakeid}, {ds_operator_payload}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::payload');	
operator_stname_in  				:=index(ds_operator_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_operator_stname}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::stname	');	
operator_stnameb2_in  			:=index(ds_operator_stnameb2, {st,cname_indic,cname_sec,bdid,lookups}, {ds_operator_stnameb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::stnameb2	');	
operator_zip_in  						:=index(ds_operator_zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {ds_operator_zip}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::zip');	
operator_zipb2_in  					:=index(ds_operator_zipb2, {zip,cname_indic,cname_sec,bdid,lookups}, {ds_operator_zipb2}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::autokey::base_mine::operator::zipb2');	
contractorid_accident_in  	:=index(ds_contractorid_accident, {contractor_id}, {ds_contractorid_accident}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::contractorid_accident');
contractorid_contractor_in  :=index(ds_contractorid_contractor, {contractor_id}, {ds_contractorid_contractor}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::contractorid_contractor');	
contractorid_events_in  		:=index(ds_contractorid_events, {contractor_id}, {ds_contractorid_events}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::contractorid_events');	
mineid_accident_in  				:=index(ds_mineid_accident, {mine_id}, {ds_mineid_accident}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::mineid_accident');
mineid_contractor_in  			:=index(ds_mineid_contractor, {mine_id}, {ds_mineid_contractor}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::mineid_contractor');
mineid_events_in  					:=index(ds_mineid_events, {mine_id}, {ds_mineid_events}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::mineid_events');	
mineid_mine_in  						:=index(ds_mineid_mine, {mine_id}, {ds_mineid_mine}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::mineid_mine');	
mineid_operator_in  				:=index(ds_mineid_operator, {mine_id}, {ds_mineid_operator}, '~prte::key::LaborActions_MSHA::'+pIndexVersion+'::mineid_operator');		

return	sequential(
										parallel(	
																build(contractor_address_in, update),				
																build(contractor_addressb2_in, update),			
																build(contractor_citystname_in, update),			
																build(contractor_citystnameb2_in, update),			
																build(contractor_name_in, update),			
																build(contractor_nameb2_in, update),			
																build(contractor_namewords2_in, update),			
																build(contractor_payload_in, update),			
																build(contractor_stname_in, update),			
																build(contractor_stnameb2_in, update),			
																build(contractor_zip_in, update),			
																build(contractor_zipb2_in, update),			
																build(controller_address_in, update),			
																build(controller_addressb2_in, update),
																build(controller_citystname_in, update),			
																build(controller_citystnameb2_in, update),			
																build(controller_name_in, update),			
																build(controller_nameb2_in, update),			
																build(controller_namewords2_in, update),			
																build(controller_payload_in, update),			
																build(controller_stname_in, update),			
																build(controller_stnameb2_in, update),			
																build(controller_zip_in, update),			
																build(controller_zipb2_in, update),			
																build(mine_address_in, update),			
																build(mine_addressb2_in, update),			
																build(mine_citystname_in, update),			
																build(mine_citystnameb2_in, update),			
																build(mine_name_in, update),			
																build(mine_nameb2_in, update),			
																build(mine_namewords2_in, update),			
																build(mine_payload_in, update),			
																build(mine_stname_in, update),			
																build(mine_stnameb2_in, update),			
																build(mine_zip_in, update),			
																build(mine_zipb2_in, update),			
																build(operator_address_in, update),
																build(operator_addressb2_in, update),			
																build(operator_citystname_in, update),			
																build(operator_citystnameb2_in, update),			
																build(operator_name_in, update),			
																build(operator_nameb2_in, update),			
																build(operator_namewords2_in, update),			
																build(operator_payload_in, update),			
																build(operator_stname_in, update),			
																build(operator_stnameb2_in, update),			
																build(operator_zip_in, update),			
																build(operator_zipb2_in, update),	
																build(contractorid_accident_in , update),																
																build(contractorid_contractor_in, update),			
																build(contractorid_events_in, update),			
																build(mineid_accident_in, update),			
																build(mineid_contractor_in, update),			
																build(mineid_events_in, update),			
																build(mineid_mine_in, update),			
																build(mineid_operator_in, update)																														
															 ),								
								PRTE.UpdateVersion('LaborActionsMSHAKeys',					//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );
end;
