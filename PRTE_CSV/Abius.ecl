EXPORT Abius := 

MODULE
	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	'20080611';
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	EXPORT string text_search__externalkey := string{maxLength(255)};
	
	EXPORT standard__name := RECORD
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING3 name_score;
  END;

  EXPORT standard__base := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
    STRING2 fips_state;
    STRING3 fips_county;
    STRING2 addr_rec_type;
  END;
	
  EXPORT rthor_data400__key__abius_fran :=  
  RECORD
	  STRING6 sic_code;
    STRING1 franchise_char;
    STRING42 description;
    UNSIGNED8 __internal_fpos__;
	END;

  EXPORT rthor_data400__key__abius_abi_number :=  
  RECORD	
	  STRING9 abi_number;
    UNSIGNED6 bdid;
    STRING8 process_date;
    STRING30 contact_name;
    STRING30 company_name;
    STRING30 street1;
    STRING16 city1;
    STRING2 state1;
    STRING5 zip1_5;
    STRING4 zip1_4;
    STRING4 carrier_cd;
    STRING2 state_cd;
    STRING3 county_cd;
    STRING10 phone;
    STRING2 filler1;
    STRING6 sic_cd;
    STRING6 franchise_cd;
    STRING1 ad_size_cd;
    STRING1 filler2;
    STRING1 population_cd;
    STRING1 individual_firm_cd;
    STRING4 year_started;
    STRING6 date_added;
    STRING14 contact_lname;
    STRING11 contact_fname;
    STRING3 contact_prof_title;
    STRING1 contact_title;
    STRING1 gender_cd;
    STRING1 employee_size_cd;
    STRING1 sales_volume_cd;
    STRING1 industry_specific_cd;
    STRING1 business_status_cd;
    STRING6 trad_date;
    STRING4 key_cd;
    STRING10 fax;
    STRING1 office_size_cd;
    STRING8 production_date;
    STRING9 subsidiary_parent_num;
    STRING9 ultimate_parent_num;
    STRING6 primary_sic;
    STRING6 secondary_sic_1;
    STRING6 secondary_sic_2;
    STRING6 secondary_sic_3;
    STRING6 secondary_sic_4;
    STRING1 total_employee_size_cd;
    STRING1 total_output_sales_cd;
    STRING1 public_co_indicator;
    STRING1 stock_exchange_cd;
    STRING6 stock_ticker_symbol;
    STRING6 num_employees_actual;
    STRING6 total_employees_actual;
    STRING30 secondary_address;
    STRING16 secondary_city;
    STRING2 secondary_state;
    STRING5 secondary_zip_code;
    STRING1 credit_code;
    STRING24 filler3;
    standard__name name;
    standard__base addr1;
    standard__base addr2;
    STRING17 ad_size;
    STRING20 population;
    STRING20 employee_size;
    STRING30 sales_volume;
    STRING40 industry_desc;
    STRING25 business_status;
    STRING20 office_size;
    STRING13 total_employee_size;
    STRING30 total_output_sales;
    STRING6 stock_exchange;
    STRING27 credit_desc;
    STRING10 individual_firm;
    STRING50 sic_desc;
    STRING50 secondary_sic_desc1;
    STRING50 secondary_sic_desc2;
    STRING50 secondary_sic_desc3;
    STRING50 secondary_sic_desc4;
    UNSIGNED8 __internal_fpos__;
	END;
	
  EXPORT rthor_data400__key__abius_doc_abinumber :=  
  RECORD	
	  UNSIGNED2 src;
    UNSIGNED6 doc;
    STRING9 abi_number;
    UNSIGNED8 __filepos;
	END;
	
	EXPORT rthor_data400__key__abius_address :=  
  RECORD
	  STRING28 prim_name;
    STRING10 prim_range;
    STRING2 st;
    UNSIGNED4 city_code;
    STRING5 zip;
    STRING8 sec_range;
    STRING6 dph_lname;
    STRING20 lname;
    STRING20 pfname;
    STRING20 fname;
    UNSIGNED8 states;
    UNSIGNED4 lname1;
    UNSIGNED4 lname2;
    UNSIGNED4 lname3;
    UNSIGNED4 lookups;
    UNSIGNED6 did;
	END;
	
	EXPORT rthor_data400__key__abius_addressb2 :=  
  RECORD
	  STRING28 prim_name;
    STRING10 prim_range;
    STRING2 st;
    UNSIGNED4 city_code;
    STRING5 zip;
    STRING8 sec_range;
    STRING40 cname_indic;
    STRING40 cname_sec;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
	END;
	
  EXPORT rthor_data400__key__abius_citystname := 
  RECORD
	  UNSIGNED4 city_code;
    STRING2 st;
    STRING6 dph_lname;
    STRING20 lname;
    STRING20 pfname;
    STRING20 fname;
    INTEGER4 dob;
    UNSIGNED8 states;
    UNSIGNED4 lname1;
    UNSIGNED4 lname2;
    UNSIGNED4 lname3;
    UNSIGNED4 city1;
    UNSIGNED4 city2;
    UNSIGNED4 city3;
    UNSIGNED4 rel_fname1;
    UNSIGNED4 rel_fname2;
    UNSIGNED4 rel_fname3;
    UNSIGNED4 lookups;
    UNSIGNED6 did;
	END;
	
	EXPORT rthor_data400__key__abius_citystnameb2 := 
  RECORD
    UNSIGNED4 city_code;
    STRING2 st;
    STRING40 cname_indic;
    STRING40 cname_sec;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
	END;
	
	EXPORT rthor_data400__key__abius_name := 
  RECORD
	  STRING6 dph_lname;
    STRING20 lname;
    STRING20 pfname;
    STRING20 fname;
    STRING1 minit;
    UNSIGNED2 yob;
    UNSIGNED2 s4;
    INTEGER4 dob;
    UNSIGNED8 states;
    UNSIGNED4 lname1;
    UNSIGNED4 lname2;
    UNSIGNED4 lname3;
    UNSIGNED4 city1;
    UNSIGNED4 city2;
    UNSIGNED4 city3;
    UNSIGNED4 rel_fname1;
    UNSIGNED4 rel_fname2;
    UNSIGNED4 rel_fname3;
    UNSIGNED4 lookups;
    UNSIGNED6 did;
	END;
	
	EXPORT rthor_data400__key__abius_nameb2 := 
  RECORD
	  STRING40 cname_indic;
    STRING40 cname_sec;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
  END;
		
	EXPORT rthor_data400__key__abius_namewords2 := 
  RECORD
    STRING40 word;
    STRING2 state;
    UNSIGNED1 seq;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
	END;
	
	EXPORT rthor_data400__key__abius_payload	:=
  RECORD
	  UNSIGNED6 fakeid;
    STRING9 abi_number;
    STRING10 phone;
    STRING30 company_name;
    UNSIGNED6 bdid;
    standard__name name;
    standard__base addr;
    UNSIGNED1 zero;
    UNSIGNED6 fdid;
  END;
	
	EXPORT rthor_data400__key__abius_phone2 := 
  RECORD
	  STRING7 p7;
    STRING3 p3;
    STRING6 dph_lname;
    STRING20 pfname;
    STRING2 st;
    UNSIGNED6 did;
    UNSIGNED4 lookups;
	END;
	
	EXPORT rthor_data400__key__abius_phoneb2 := 
  RECORD
	  STRING7 p7;
    STRING3 p3;
    STRING40 cname_indic;
    STRING40 cname_sec;
    STRING2 st;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
	END;
	
	EXPORT rthor_data400__key__abius_stname := 
  RECORD
	  STRING2 st;
    STRING6 dph_lname;
    STRING20 lname;
    STRING20 pfname;
    STRING20 fname;
    STRING1 minit;
    UNSIGNED2 yob;
    UNSIGNED2 s4;
    INTEGER4 zip;
    INTEGER4 dob;
    UNSIGNED8 states;
    UNSIGNED4 lname1;
    UNSIGNED4 lname2;
    UNSIGNED4 lname3;
    UNSIGNED4 city1;
    UNSIGNED4 city2;
    UNSIGNED4 city3;
    UNSIGNED4 rel_fname1;
    UNSIGNED4 rel_fname2;
    UNSIGNED4 rel_fname3;
    UNSIGNED4 lookups;
    UNSIGNED6 did;
	END;
	
	EXPORT rthor_data400__key__abius_stnameb2 := 
	RECORD
    STRING2 st;
    STRING40 cname_indic;
    STRING40 cname_sec;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
  END;

  EXPORT rthor_data400__key__abius_zip	:=
  RECORD
	  INTEGER4 zip;
    STRING6 dph_lname;
    STRING20 lname;
    STRING20 pfname;
    STRING20 fname;
    STRING1 minit;
    UNSIGNED2 yob;
    UNSIGNED2 s4;
    INTEGER4 dob;
    UNSIGNED8 states;
    UNSIGNED4 lname1;
    UNSIGNED4 lname2;
    UNSIGNED4 lname3;
    UNSIGNED4 city1;
    UNSIGNED4 city2;
    UNSIGNED4 city3;
    UNSIGNED4 rel_fname1;
    UNSIGNED4 rel_fname2;
    UNSIGNED4 rel_fname3;
    UNSIGNED4 lookups;
    UNSIGNED6 did;
	END;
	
	EXPORT rthor_data400__key__abius_zipb2	:=
  RECORD
    INTEGER4 zip;
    STRING40 cname_indic;
    STRING40 cname_sec;
    UNSIGNED6 bdid;
    UNSIGNED4 lookups;
	END;
	
  EXPORT rthor_data400__key__abius_bdid	:=
  RECORD	
	  UNSIGNED6 bdid;
	  STRING9 abi_number;
	  UNSIGNED8 __internal_fpos__;
  END;
		
  EXPORT rthor_data400__key__abius_linkids	:=
  RECORD	
	  UNSIGNED6 ultid;
    UNSIGNED6 orgid;
    UNSIGNED6 seleid;
    UNSIGNED6 proxid;
    UNSIGNED6 powid;
    UNSIGNED6 empid;
    UNSIGNED6 dotid;
    UNSIGNED2 ultscore;
    UNSIGNED2 orgscore;
    UNSIGNED2 selescore;
    UNSIGNED2 proxscore;
    UNSIGNED2 powscore;
    UNSIGNED2 empscore;
    UNSIGNED2 dotscore;
    UNSIGNED2 ultweight;
    UNSIGNED2 orgweight;
    UNSIGNED2 seleweight;
    UNSIGNED2 proxweight;
    UNSIGNED2 powweight;
    UNSIGNED2 empweight;
    UNSIGNED2 dotweight;
    UNSIGNED8 source_rec_id;
    UNSIGNED6 bdid;
    STRING8 process_date;
    STRING30 contact_name;
    STRING30 company_name;
    STRING30 street1;
    STRING16 city1;
    STRING2 state1;
    STRING5 zip1_5;
    STRING4 zip1_4;
    STRING4 carrier_cd;
    STRING2 state_cd;
    STRING3 county_cd;
    STRING10 phone;
    STRING2 filler1;
    STRING6 sic_cd;
    STRING6 franchise_cd;
    STRING1 ad_size_cd;
    STRING1 filler2;
    STRING1 population_cd;
    STRING1 individual_firm_cd;
    STRING4 year_started;
    STRING6 date_added;
    STRING14 contact_lname;
    STRING11 contact_fname;
    STRING3 contact_prof_title;
    STRING1 contact_title;
    STRING1 gender_cd;
    STRING1 employee_size_cd;
    STRING1 sales_volume_cd;
    STRING1 industry_specific_cd;
    STRING1 business_status_cd;
    STRING6 trad_date;
    STRING4 key_cd;
    STRING10 fax;
    STRING1 office_size_cd;
    STRING8 production_date;
    STRING9 abi_number;
    STRING9 subsidiary_parent_num;
    STRING9 ultimate_parent_num;
    STRING6 primary_sic;
    STRING6 secondary_sic_1;
    STRING6 secondary_sic_2;
    STRING6 secondary_sic_3;
    STRING6 secondary_sic_4;
    STRING1 total_employee_size_cd;
    STRING1 total_output_sales_cd;
    STRING1 public_co_indicator;
    STRING1 stock_exchange_cd;
    STRING6 stock_ticker_symbol;
    STRING6 num_employees_actual;
    STRING6 total_employees_actual;
    STRING30 secondary_address;
    STRING16 secondary_city;
    STRING2 secondary_state;
    STRING5 secondary_zip_code;
    STRING1 credit_code;
    STRING24 filler3;
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING3 name_score;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 z5;
    STRING4 zip4;
    STRING4 cart;
    STRING1 cr_sort_sz;
    STRING4 lot;
    STRING1 lot_order;
    STRING2 dpbc;
    STRING1 chk_digit;
    STRING2 rec_type;
    STRING5 county;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 msa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
    STRING10 prim_range2;
    STRING2 predir2;
    STRING28 prim_name2;
    STRING4 addr_suffix2;
    STRING2 postdir2;
    STRING10 unit_desig2;
    STRING8 sec_range2;
    STRING25 p_city_name2;
    STRING25 v_city_name2;
    STRING2 st2;
    STRING5 z52;
    STRING4 zip42;
    STRING4 cart2;
    STRING1 cr_sort_sz2;
    STRING4 lot2;
    STRING1 lot_order2;
    STRING2 dpbc2;
    STRING1 chk_digit2;
    STRING2 rec_type2;
    STRING5 county2;
    STRING10 geo_lat2;
    STRING11 geo_long2;
    STRING4 msa2;
    STRING7 geo_blk2;
    STRING1 geo_match2;
    STRING4 err_stat2;
    STRING1 lf;
    STRING17 ad_size;
    STRING20 population;
    STRING20 employee_size;
    STRING30 sales_volume;
    STRING40 industry_desc;
    STRING25 business_status;
    STRING20 office_size;
    STRING13 total_employee_size;
    STRING30 total_output_sales;
    STRING6 stock_exchange;
    STRING27 credit_desc;
    STRING10 individual_firm;
    STRING50 sic_desc;
    STRING50 secondary_sic_desc1;
    STRING50 secondary_sic_desc2;
    STRING50 secondary_sic_desc3;
    STRING50 secondary_sic_desc4;
    UNSIGNED8 append_rawaid;
    UNSIGNED8 append_aceaid;
    STRING100 prep_addr_line1;
    STRING50 prep_addr_last_line;
    INTEGER1 fp;
  END;

  EXPORT dthor_data400__key__abius__fran   	       := DATASET([], rthor_data400__key__abius_fran);
  EXPORT dthor_data400__key__abius__abi_number     := DATASET([], rthor_data400__key__abius_abi_number);
  EXPORT dthor_data400__key__abius__doc_abinumber  := DATASET([], rthor_data400__key__abius_doc_abinumber);
  EXPORT dthor_data400__key__abius__address 	     := DATASET([], rthor_data400__key__abius_address);
  EXPORT dthor_data400__key__abius__addressb2 	   := DATASET([], rthor_data400__key__abius_addressb2);
  EXPORT dthor_data400__key__abius__citystname     := DATASET([], rthor_data400__key__abius_citystname);
  EXPORT dthor_data400__key__abius__citystnameb2   := DATASET([], rthor_data400__key__abius_citystnameb2);
  EXPORT dthor_data400__key__abius__name 	         := DATASET([], rthor_data400__key__abius_name);
  EXPORT dthor_data400__key__abius__nameb2 	       := DATASET([], rthor_data400__key__abius_nameb2);
  EXPORT dthor_data400__key__abius__namewords2     := DATASET([], rthor_data400__key__abius_namewords2);
  EXPORT dthor_data400__key__abius__payload        := DATASET([], rthor_data400__key__abius_payload);
  EXPORT dthor_data400__key__abius__phone2         := DATASET([], rthor_data400__key__abius_phone2);
  EXPORT dthor_data400__key__abius__phoneb2        := DATASET([], rthor_data400__key__abius_phoneb2);
  EXPORT dthor_data400__key__abius__stname         := DATASET([], rthor_data400__key__abius_stname);
  EXPORT dthor_data400__key__abius__stnameb2       := DATASET([], rthor_data400__key__abius_stnameb2);
  EXPORT dthor_data400__key__abius__zip            := DATASET([], rthor_data400__key__abius_zip);
  EXPORT dthor_data400__key__abius__zipb2          := DATASET([], rthor_data400__key__abius_zipb2);
  EXPORT dthor_data400__key__abius__bdid 	         := DATASET([], rthor_data400__key__abius_bdid);
  //EXPORT dthor_data400__key__abius__linkids        := DATASET([], rthor_data400__key__abius_linkids);

END;