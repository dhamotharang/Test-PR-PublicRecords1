IMPORT AID;

EXPORT Layout_Base := MODULE

EXPORT base := RECORD
	// unsigned6 			rcid;
	unsigned6 			did;
	string8					process_date;
	string8					date_first_seen;
	string8					date_last_seen;
	string8					date_vendor_first_reported;
	string8					date_vendor_last_reported;
	string8					DateAdded;										//Source: File_Student_In
	string8					DateUpdated;									//Source: File_Student_In
	string					StudentID;										//Source: File_Student_In
	string4					DartID;												//Source: File_Student_In
	string					CollegeID;										//Source: File_Student_In
	string100				ProjectSource;								//Source: File_Student_In
	string20				CollegeState;									//Source: File_Student_In/State
	string100				College;											//Source: File_Student_In
	string6					Semester;											//Source: File_Student_In
	string4					Year;													//Source: File_Student_In
	string50				FirstName;										//Source: File_Student_In
	string50				MiddleName;										//Source: File_Student_In
	string50				LastName;											//Source: File_Student_In
	string10				Suffix;												//Source: File_Student_In
	string150				Major;												//Source: File_Student_In
	string50				Grade;												//Source: File_Student_In
	string75				Email;												//Source: File_Student_In
	string75				CleanEmail;
	string8					DateofBirth;									//Source: File_Student_In
	string8					DOB_Formatted;
	string					AttendanceDate;								//Source: File_Student_In
	string50				EnrollmentStatus;							//Source: File_Student_In
	string10				AddressType;
	string100				Address_1;
	string100				Address_2;
	string50				City;
	string50				State;
	string5   			z5;
	string4   			z4;
	string5					PhoneTyp;
	string					PhoneNumber;
	string1					tier;
	string1					school_size_code;
	string1					competitive_code;
	string1					tuition_code;
	
	string5 				title;
	string20 				fname;
	string20 				mname;
	string20 				lname;
	string5 				name_suffix;
	string3 				name_score;
	AID.Common.xAID	RawAID;
	string10  			prim_range;
	string2   			predir;
	string28  			prim_name;
	string4   			addr_suffix;
	string2   			postdir;
	string10  			unit_desig;
	string8   			sec_range;
	string25  			p_city_name;
	string25  			v_city_name;
	string2   			st;
	string5					Zip;
	string4					Zip4;
	string4   			cart;
	string1   			cr_sort_sz;
	string4   			lot;
	string1   			lot_order;
	string2   			dpbc;
	string1   			chk_digit;
	string2   			rec_type;
	string5 				county;
	string2   			fips_state;
	string3					fips_county;
	string10  			geo_lat;
	string11  			geo_long;
	string4   			msa;
	string7   			geo_blk;
	string1   			geo_match;
	string4   			err_stat;
	string10				TELEPHONE;
	STRING5					tier2;
	string2					source := '';
	//ASL fields
	integer8        KEY;
	string9					SSN:='';
	string1					HISTORICAL_FLAG:='';
	string60				FULL_NAME;
	string2         COLLEGE_CLASS:='';
	string50        COLLEGE_NAME;
	string50        LN_COLLEGE_NAME;
	string1					COLLEGE_MAJOR:='';
	string4					NEW_COLLEGE_MAJOR:='';
	string1         COLLEGE_CODE:='';
	string20  			COLLEGE_CODE_EXPLODED:='';
	string1         COLLEGE_TYPE:='';
	string25				COLLEGE_TYPE_EXPLODED:='';
	string1         FILE_TYPE:='';
	STRING4					CollegeUpdate := '';
	//CCPA-7 Add 2 new fields for CCPA
	unsigned4 global_sid;
	unsigned8 record_sid
	
end;

EXPORT base_intermediate := RECORD
		string10 CleanCollegeId;
		string CleanAddr1;
		string CleanAddr2;
		string CleanAttendanceDte;
		string CleanCity;
		string CleanState;
		string CleanZip;
		string CleanZip4;
		string cleanfullAddr;
		// string CleanDateAdded;
		string CleanDOB;
		string CleanUpdateDte;
		string CleanEmail;
		string append_email_username;
		string append_domain;
		string append_domain_type;
		string append_domain_root;
		string append_domain_ext;	
		boolean append_is_tld_state;
		boolean append_is_tld_generic;
		boolean append_is_tld_country;
		boolean append_is_valid_domain_ext;	
		string CleanTitle;
		string CleanFirstName;
		string CleanMidName;
		string CleanLastName;
		string CleanSuffixName;
		string CleanMajor;
		string CleanPhone;
		base;
	END;

EXPORT base_scrubs := RECORD
			base_intermediate - [DateAdded,SSN,FULL_NAME,COLLEGE_CLASS,COLLEGE_NAME,LN_COLLEGE_NAME,COLLEGE_MAJOR,NEW_COLLEGE_MAJOR,COLLEGE_CODE,COLLEGE_CODE_EXPLODED,COLLEGE_TYPE,COLLEGE_TYPE_EXPLODED,FILE_TYPE,CollegeUpdate,KEY];
	END;
END;
