Import Infutor_NARE, AID;

EXPORT layouts := MODULE

	EXPORT layout_raw := RECORD
			string50	IDNum;
			string50	FirstName;
			string50	MiddleName;
			string50	LastName;
			string10	Suffix;
			string1		RecType;
			string1		Gender;
			string8		DOB;
			string64	AddrLine1;
			string10	StreetNum;
			string2		StreetPreDir;
			string28	StreetName;
			string4		StreetSuffix;
			string2		StreetPostDir;
			string4		AptType;
			string8		AptNum;
			string28	City;
			string2		State;
			string5		Zip5;
			string4		Zip4;
			string3		DPC;
			string1		Z4Type;
			string4		CRTE;
			string3		FIPSCounty;
			string3		DPV;
			string3		VacantFlag;
			string10	Phone;
			string10	Phone2;
			string10	Fax;
			string100	Email;
			string100	URL;
			string100	IPAddr;
			string10	Internal1;
			string100	WesiteType;
			string8		DateFirstSeen;
			string8		DateLastSeen;
			string8		FileDate;
			string1		ConfidenceScore;
			string10	Occurance;
			string50	Internal2;
			string10	PersistID;
			string50	EmailSuppressionCd;
			string2		Internal3;
			string2		Internal4;
			string2		Age;
			STRING Filler1;
			STRING Filler2;
			STRING Filler3;
			STRING Filler4;
			STRING Filler5;
			STRING Filler6;
			STRING Filler7;
			STRING Filler8;
			STRING Filler9;
			STRING Filler10;
			STRING Filler11;
			STRING Filler12;
			STRING Filler13;
			STRING Filler14;
			STRING Filler15;
			STRING Filler16;
			STRING Filler17;
			STRING Filler18;
			STRING Filler19;
			STRING Filler20;
			STRING Filler21;
			STRING Filler22;
			STRING Filler23;
			STRING Filler24;
			STRING Filler25;
	END;
	
	//Remove internal filler fields
	EXPORT layout_raw_slim := RECORD
			string50	IDNum;
			string50	FirstName;
			string50	MiddleName;
			string50	LastName;
			string10	Suffix;
			string1		RecType;
			string1		Gender;
			string8		DOB;
			string64	AddrLine1;
			string10	StreetNum;
			string2		StreetPreDir;
			string28	StreetName;
			string4		StreetSuffix;
			string2		StreetPostDir;
			string4		AptType;
			string8		AptNum;
			string28	City;
			string2		State;
			string5		ZipCode;
			string4		ZipPlus4;
			string3		DPC;
			string1		Z4Type;
			string4		CRTE;
			string3		FIPSCounty;
			string3		DPV;
			string3		VacantFlag;
			string10	Phone;
			string10	Phone2;
			string100	Email;
			string100	URL;
			string100	IPAddr;
			string100	WesiteType;
			string8		DateFirstSeen;
			string8		DateLastSeen;
			string8		FileDate;
			string1		ConfidenceScore;
			string10	Occurance;
			string10	PersistID;
			string50	EmailSuppressionCd;
			string2		Age;
	END;
	
	//append clean and prepped fields
	export prepped := RECORD
				//integer8  append_row_id;  //append rowid for a unique rec identifier
				layout_raw_slim;
				//string		FullName := '';				
				string 		clean_phone1 := '';
				string 		clean_phone2 := '';
		//clean and parse email field
				string append_domain 			   := '';
				string append_domain_type	   := '';
				string append_domain_root		 := '';
				string append_domain_ext		 := '';
				string append_email_username := '';
				string append_cln_email 		 := '';
		END;
		
	//Append clean name/address fields
	export Cleaned := RECORD,maxlength(50000)
				Prepped;
				STRING100 Clean_Name := '';
				string73 pname1 := '';
				string60 cname1 := '';
				string5 	title;
				string20 	fname;
				string20 	mname;
				string20 	lname;
				string5 	name_suffix;
				string3 	name_score;				
				string10	prim_range;
				string2		predir;
				string28	prim_name;
				string4		addr_suffix;
				string2		postdir;
				string10	unit_desig;
				string8		sec_range;
				string25	p_city_name;
				string25	v_city_name;
				string2		st;
				string5		zip5;
				string4		zip4;
				string4		cart;
				string1		cr_sort_sz;
				string4		lot;
				string1		lot_order;
				string2		dbpc;
				string1		chk_digit;
				string2		rec_type;
				string5		county;
				string10	geo_lat;
				string11	geo_long;
				string4		msa;
				string7		geo_blk;
				string1		geo_match;
				string4		err_stat;
			END;
			
	export did_out := RECORD,maxlength(50000)
			integer8	DID := 0;
			integer8	DID_Score := 0;	
			Cleaned;
		END;
		
 //address only fields for lookup
 export slim_address := RECORD
	//AID Fields
			AID.Common.xAID	RawAID;
			string77	Append_Prep_Address_Situs;
			string54	Append_Prep_Address_Last_Situs;	
	//Clean address fields
			string10	clean_prim_range;
			string2		clean_predir;
			string28	clean_prim_name;
			string4		clean_addr_suffix;
			string2		clean_postdir;
			string10	clean_unit_desig;
			string8		clean_sec_range;
			string25	clean_p_city_name;
			string25	clean_v_city_name;
			string2		clean_st;
			string5		clean_zip;
			string4		clean_zip4;
			string4		clean_cart;
			string1		clean_cr_sort_sz;
			string4		clean_lot;
			string1		clean_lot_order;
			string2		clean_dbpc;
			string1		clean_chk_digit;
			string2		clean_rec_type;
			string5		clean_county;
			string10	clean_geo_lat;
			string11	clean_geo_long;
			string4		clean_msa;
			string7		clean_geo_blk;
			string1		clean_geo_match;
			string4		clean_err_stat;
	END;
		
	//Final base output layout
	export base := RECORD
			layout_raw_slim;
			unsigned8	persistent_record_id := 0;	//unique record identifier
		
		//DID fields
			unsigned8 DID;
			unsigned8 DID_Score;

		//Clean name fields
			string5		clean_title;
			string20	clean_fname;
			string20	clean_mname;
			string20	clean_lname;
			string5		clean_name_suffix;
			string3		clean_name_score;

	//Clean Address fields		
		slim_address;
		
		// Instance tracking fields
			string8		process_date;
			string8		date_first_seen;
			string8		date_last_seen;
			string8		date_vendor_first_reported;
			string8		date_vendor_last_reported;
		END;
		
	//Add current record indicator	
		export base_new := RECORD
			base;
			string1 current_rec_flag := '';
		end;
		
	//Base layout with scrubbits appended
		export Scrubs	:= RECORD
			base_new;
			unsigned scrubsbits1;
			unsigned scrubsbits2;
		END;
		
END;




