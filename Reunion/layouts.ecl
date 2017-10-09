EXPORT layouts:=MODULE

  EXPORT lCustomerDB:=RECORD
    STRING1 record_type :='1';
    STRING12 main_adl;
    STRING20 orig_usernum;
    STRING250 orig_first_name;
    STRING200 orig_last_name;
    STRING150 orig_maiden_name;
    STRING10 orig_dob;
    STRING20 orig_gender;
    STRING20 orig_zip;
    STRING2 crlf :='\r\n';
  END;

  EXPORT lThirdPartyDB:=RECORD
    STRING1 record_type :='2';
    STRING12 main_adl;
    STRING20 orig_usernum;
    STRING250 orig_first_name;
    STRING200 orig_last_name;
    STRING90 orig_street;
    STRING50 orig_city;
    STRING2 orig_state;
    STRING10 orig_zip;
    STRING1 orig_gender;
    STRING10 orig_dob;
    STRING2 crlf :='\r\n';
  END;

  EXPORT lClean:=RECORD
    STRING1 vendor;
    STRING20 orig_vendor_id;
    STRING250 orig_fsn;
    STRING200 orig_last_name;
    STRING250 orig_first_name;
    STRING150 orig_maiden_name;
    STRING10 orig_dob;
    STRING1 orig_gender;
    STRING90 orig_strt;
    STRING50 orig_locnm;
    STRING2 orig_state;
    STRING10 orig_zip;
    STRING8 clean_dob;
    STRING8 clean_dob_yyyymm;
    STRING10 clean_phone;
    STRING1 clean_person_ind;
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
    STRING5 zip;
    STRING4 zip4;
    STRING4 cart;
    STRING1 cr_sort_sz;
    STRING4 lot;
    STRING1 lot_order;
    STRING2 dbpc;
    STRING1 chk_digit;
    STRING2 rec_type;
    STRING5 county;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 msa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
    UNSIGNED6 did:=0;
    INTEGER did_score:=0;
    UNSIGNED6 bdid:=0;
    INTEGER bdid_score:=0;
  END;

  EXPORT lMain:=RECORD
    STRING1 record_type:='M';
    STRING12 adl;
    STRING5 best_title;
    STRING20 best_fname;
    STRING20 best_mname;
    STRING20 best_lname;
    STRING5 best_name_suffix;
    STRING80 best_street;
    STRING25 best_city;
    STRING2 best_st;
    STRING10 best_zip; 
    STRING10 phone; //from gong
    STRING8 best_dob;
    STRING8 date_of_death;
    STRING60 prof_lic_job_desc;
    STRING2 crlf:='\r\n';
  END;

  EXPORT lMainRaw:=RECORD
    STRING1 came_from;
    UNSIGNED6 did;
    STRING8 dob;
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 city_name;
    STRING2 st;
    STRING5 zip;
    STRING4 zip4;
    STRING8 date_of_death :='';
    STRING10 phone :='';
    STRING60 job_desc :='';
  END;

  EXPORT lOldAddresses:=RECORD
    STRING1 record_type:='A';
    STRING12 main_adl;
    STRING80 old_street;
    STRING25 old_city;
    STRING2 old_st;
    STRING10 old_zip;
    STRING6 date_first_seen;
    STRING6 date_last_seen;
    STRING2 crlf:='\r\n';
  END;

  EXPORT lRelatives:=RECORD
   STRING1 record_type:='R';
    STRING12 main_adl;
    STRING12 relative_adl;
    STRING5 relative_title;
    STRING20 relative_fname;
    STRING20 relative_mname;
    STRING20 relative_lname;
    STRING5 relative_name_suffix;
    STRING80 relative_street;
    STRING25 relative_city;
    STRING2 relative_st;
    STRING10 relative_zip;
    STRING10 relative_phone;
    STRING8 relative_dob;
    STRING8 relative_date_of_death:='';
    STRING2 crlf:='\r\n';
  END;

  EXPORT lRelativesSlim:=RECORD
    UNSIGNED6 person1;
    UNSIGNED6 person2;
  END;
	
	EXPORT lAlias:=RECORD
    STRING12 main_adl;
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING2 crlf:='\r\n';
	END;
	
  EXPORT lADLScore:=RECORD
   STRING1 record_type:='S';
   STRING12 adl;
   STRING3 adl_score;
   STRING1 source_record_type;//’1’ or ‘2’
   STRING20 orig_user_num;//map the user_num depending on where this ADL match is from (1 or 2)
   STRING2 crlf:='\r\n';
  END;

  EXPORT lDID:=RECORD
    UNSIGNED6 did;
  END;

  EXPORT lIteration:=RECORD
    UNSIGNED6 did;
    STRING1 came_from;
  END;
	
	EXPORT lEmail := RECORD
    STRING1 record_type:='E';
    STRING12 adl;
		string200       Email1 := '';
		string200       Email2 := '';
		string200       Email3 := '';
    STRING2 crlf:='\r\n';
	END;
	
	EXPORT lCollege := RECORD
    STRING1 record_type:='C';
    STRING12 adl;
		string2         CLASS;
		//string9         COLLEGE_CLASS;
		string50        COLLEGE_NAME;
		string18				COLLEGE_MAJOR;
    STRING2 crlf:='\r\n';
	END;
	

	export l_deed := record
	 string1   record_type:='D';
	 string12  main_adl;
	 string2   state;
	 string40  county;
	 string45  apn;
	 string80  property_street;
	 string25  property_city;
	 string2   property_st;
	 string10  property_zip; 
	 string80  owner_street;
	 string25  owner_city;
	 string2   owner_st;
	 string10  owner_zip;
	 string80  owner1;
	 string80  owner2;
	 string80  seller1;
	 string80  seller2;
	 string70  document_type;
	 string20  document_number;
	 string10  recorder_book;
	 string10  recorder_page;
	 string8   recording_date;
	 string8   sale_date;
	 string11  sales_price;
	 string11  loan_amount;
	 string5   interest_rate;
	 string6   term;
	 string1   term_ind;
	 string40  lender;
	 string30  rate_change;
	 string60  title_company;
	 string30  type_financing;
	 string60  adjustable_index;
	 string4   change_index;
	 string8   due_date;
	 string30  lender_type;
	 string40  loan_type;
	 string45  property_use;
	 string80  land_use;
	 string10  lot_size;
	 string125 legal_description;
	 string2   crlf:='\r\n';
	end;
	
	export l_tax := record
	 string1	record_type:='T';
	 string12	main_adl;
	 string2    state;
	 string40   county;
	 string45	apn;
	 string80   property_street;
	 string25   property_city;
	 string2    property_st;
	 string10   property_zip;
	 string80   owner_street;
	 string25   owner_city;
	 string2    owner_st;
	 string10   owner_zip;
	 string80	owner1;
	 string80	owner2;
	 string4	tax_year;
	 string13	tax_amount;
	 string11	total_assessed_value;
	 string11	assessed_improvement_value;
	 string11	assessed_land_value;
	 string4	assessment_year;
	 string11	total_market_value;
	 string11	market_improvement_value;
	 string11	market_land_value;
	 string4	market_value_year;
	 string10	recorder_book;
	 string10	recorder_page;
	 string20	document_number;
	 string70	document_type;
	 string8	recording_date;
	 string8	sale_date;
	 string11	sale_price;
	 string1	exemption;
	 string80	land_use;
	 string125	legal_description;
	 string40	subdivision_name;
	 string4	year_built;
	 string30	stories;
	 string5	bedrooms;
	 string8	baths;
	 string5	total_rooms;
	 string1	fireplace_indicator;
	 string30	garage_type;
	 string5	garage_size;
	 string30	pool_spa;
	 string30	style;
	 string30	air_conditioning;
	 string30	heating;
	 string30	construction;
	 string30	basement;
	 string30	exterior_walls;
	 string35	foundation;
	 string30	roof;
	 string10	elevator;
	 string30	property_lot_size;
	 string10	building_area;
	 string2	crlf:='\r\n';
	end;
	
	export l_flags := record
			string1	record_type:='F';
			string12	main_adl;
			string1			judgments;
			string1			civilCourtRecords;
			string1			crimCourtRecords;
			string1			curr_incar_flag;
			string1			foreclosures;
			string1			bankruptcy;
    STRING2 crlf :='\r\n';
  end;		
	
END;