Import prte2;
EXPORT Layouts := MODULE

Export zipprlname := RECORD
  string6 zip;
  string10 prim_range;
  string20 lname;
  unsigned4 lookups;
  unsigned6 did;
 END;


Export zipb2 :=RECORD
  string6 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export zip:=RECORD
  string6 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned6 did;
  unsigned4 lookups;
 END;


Export stnameb2 := RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export stname:=RECORD
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


Export Phoneb2:=RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

Export Phone2:=RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
  unsigned4 lookups;
 END;

Export namewords2:=RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export nameb2 :=RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export name :=RECORD
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


Export citystnameb2:=RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export citystname:=RECORD
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


Export addressb2:=RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string6 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


Export address:=RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string6 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned4 lookups;
  unsigned6 did;
 END;

 

 Export fdid:=RECORD
  unsigned6 fdid;
  string8 date_first_reported;
  string8 date_last_reported;
  string2 vendor;
  string20 source_file;
  string20 lastname;
  string15 firstname;
  string15 middlename;
  string50 name;
  string15 nickname;
  string3 generational;
  string4 title;
  string4 professionalsuffix;
  string10 housenumber;
  string3 directional;
  string35 streetname;
  string7 streetsuffix;
  string9 suitenumber;
  string30 suburbancity;
  string30 postalcity;
  string2 province;
  string6 postalcode;
  string2 provincecode;
  string3 county_code;
  string10 phonenumber;
  string4 phonetypeflag;
  string4 nosolicitation;
  string4 cmacode;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 state;
  string6 zip;
  string2 rec_type;
  string1 language;
  string6 errstat;
  string60 company_name;
  string10 record_id;
  string1 record_use_indicator;
  string25 city;
  string6 pub_date;
  string10 latitude;
  string10 longitude;
  string1 lat_long_level_applied;
  string6 book_number;
  string30 secondary_name;
  string4 room_number;
  string3 room_code;
  string1 record_type;
  string6 yphc_1;
  string6 yphc_2;
  string6 yphc_3;
  string6 yphc_4;
  string6 yphc_5;
  string6 yphc_6;
  string8 sic_1;
  string8 sic_2;
  string8 sic_3;
  string8 sic_4;
  string1 bus_govt_indicator;
  string1 status_indicator;
  string6 selected_sic;
  string6 franchise_codes;
  string1 ad_size;
  string1 french_flag;
  string1 population_code;
  string1 individual_firm_code;
  string4 year_of_1st_appearance_ccyy;
  string6 date_added_to_db_ccyymm;
  string1 title_code;
  string1 contact_gender_code;
  string1 employee_size_code;
  string1 sales_volume_code;
  string1 industry_specific_code;
  string1 business_status_code;
  string10 key_code;
  string10 fax_phone;
  string1 office_size_code;
  string8 production_date_mmddccyy;
  string9 abi_number;
  string9 subsidiary_parent_number;
  string9 ultimate_parent_number;
  string6 primary_sic;
  string6 secondary_sic_code_1;
  string6 secondary_sic_code_2;
  string6 secondary_sic_code_3;
  string6 secondary_sic_code_4;
  string1 total_employee_size_code;
  string1 total_output_sales_code;
  string6 number_of_employees_actual;
  string6 total_no_employees_actual;
  string9 postal_mode;
  string9 postal_bag_bundle;
  string1 transaction_code;
  string1 listing_type;
	Prte2.layouts.DEFLT_CPA;
  unsigned6 did;
  integer3 did_score;
 END;

 end;





