IMPORT BIPV2;

EXPORT Layouts := MODULE

 shared rec_source_layout := record
   string2 source;
	 string50 source_docid;
   unsigned8 source_rec_id; 
  end;

 shared rec_industry_section_fields := record
   string8 siccode; 
   string4 siccode_plus := ''; 
   string6 naics; 
   string350 industry_description;
   string1502 business_description;
  end;

 export rec_industry_combined_layout := record
	BIPV2.IDlayouts.l_key_ids;
	unsigned6 bdid;
  unsigned1 bdid_score;
	rec_source_layout;
	rec_industry_section_fields;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1   record_type;
  unsigned4 record_date;
 end;

 rec_license_section_fields := record
		string2   license_state;   // license issuing state, if applicable
		string160 license_board;   // the license issuing board or agency name
		string25  license_number;  // the license number issued
		string100 license_type;    // the type of license (pharmacy, pharmacist, etc.)
		string8   issue_date;      // the date the license was issued
		string8   expiration_date; // the date the license expires
  end;

 export rec_license_combined_layout := record
	BIPV2.IDlayouts.l_key_ids;
	unsigned6 bdid;
  unsigned1 bdid_score;
	rec_source_layout;
	rec_license_section_fields;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1   record_type;
  unsigned4 record_date;
	// ^--- OR ---v ???
	//string8   process_date; //???
 end;

 rec_associates_section_fields := record
			string5		title; // v--- Person associate name fields
			string20	fname;
			string20	mname;
			string20	lname;
			string5		name_suffix;
			//string3		name_score; //???
			//string3		name_cleaning_score;
			string60	company_name;  // <-- Business/company associate name field
			string10	prim_range;    // v--- Person/Business associate adress fields
			string2		predir;
			string28	prim_name;
			string4		suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	p_city_name;
			string25	v_city_name;
			string2		st;
			string5		zip5;
			string4		zip4;
			// v--- extra address related fields out of address cleaner that won't be needed???
			//string4		cart;
			//string1		cr_sort_sz;
			//string4		lot;
			//string1		lot_order;
			//string2		dpbc;
			//string1		chk_digit;
			//string2		rec_type;
		  //string5		county; //string5 or 3? FIPS 3/5 digit county#
			//string10	geo_lat;
			//string11	geo_long;
			//string4		msa;
			//string7		geo_blk;
			//string1		geo_match;
      //string4   err_stat;

			//string10  phone10; //???

      string20  where_associated; //string length??? - gui mockup = role???
			//^--- is this even needed or will source code be enough to display the info needed on the gui???
			//string?? how_associated; //debtor, creditor, secured party/assignee, attorney, buyer, seller, ???
			// ^--- is this one needed also???
 end;

 export rec_associates_combined_layout := record
	BIPV2.IDlayouts.l_key_ids;
	unsigned6 bdid;
  unsigned1 bdid_score;
	unsigned6 did;
	unsigned6	did_score;
	rec_source_layout;
	rec_associates_section_fields;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1   record_type; //???
  //unsigned4 record_date; //???
	// ^--- OR ---v ???
	string8   process_date; //???
 end;

 export rec_other_directories_layout := record
  string1 rec_type;//(I)ndustry or (C)ontacts
	BIPV2.IDlayouts.l_key_ids;
  rec_industry_combined_layout - BIPV2.IDlayouts.l_key_ids industry_fields;
	BIPV2.Layout_Business_Linking_Full contacts_fields;
  unsigned4 global_sid;
  unsigned8 record_sid;
 end;

END;