EXPORT Regulatory := MODULE;

	
	export drop_american_student_base_v2_layout := RECORD
		// integer8        KEY;
		string9					SSN;

		// unsigned6       DID;
		string12				DID;
		string8         PROCESS_DATE;
		string8         DATE_FIRST_SEEN;
		string8         DATE_LAST_SEEN;
		string8         DATE_VENDOR_FIRST_REPORTED;
		string8         DATE_VENDOR_LAST_REPORTED;
		string1					HISTORICAL_FLAG;
		string60        FULL_NAME;
		string25        FIRST_NAME;
		string25        LAST_NAME;
		string64        ADDRESS_1;
		string64        ADDRESS_2;
		string26        CITY;
		string2         STATE;
		string5         ZIP;
		string4         ZIP_4;
		string4         CRRT_CODE;
		string2         DELIVERY_POINT_BARCODE;
		string1         ZIP4_CHECK_DIGIT;
		string1         ADDRESS_TYPE_CODE;
		string30        ADDRESS_TYPE;
		string3         COUNTY_NUMBER;
		string26        COUNTY_NAME;
		string1         GENDER_CODE;
		string10				GENDER;
		string2         AGE;
		string6         BIRTH_DATE;
		string8					DOB_FORMATTED;
		string10        TELEPHONE;
		string2         CLASS;
		string2         COLLEGE_CLASS;
		string50        COLLEGE_NAME;
		string50        LN_COLLEGE_NAME;
		string1					COLLEGE_MAJOR;
		string4					NEW_COLLEGE_MAJOR;
		string1         COLLEGE_CODE;
		string20  			COLLEGE_CODE_EXPLODED;
		string1         COLLEGE_TYPE;
		string25				COLLEGE_TYPE_EXPLODED;
		string40        HEAD_OF_HOUSEHOLD_FIRST_NAME;
		string1         HEAD_OF_HOUSEHOLD_GENDER_CODE;
		string10				HEAD_OF_HOUSEHOLD_GENDER;
		string1         INCOME_LEVEL_CODE;
		string20				INCOME_LEVEL;
		string1         NEW_INCOME_LEVEL_CODE;
		string20				NEW_INCOME_LEVEL;
		string1         FILE_TYPE;

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

//		unsigned8				RawAID; //  AID.Common.xAID	RawAID;  export		xAID								:=	unsigned8;
		string25				RawAID; 

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
		string5   			z5;
		string4   			zip4;
		string4   			cart;
		string1   			cr_sort_sz;
		string4   			lot;
		string1   			lot_order;
		string2   			dpbc;
		string1   			chk_digit;
		string2   			rec_type;
		string5 				county;
		string2   			ace_fips_st;
		string3					fips_county;
		string10  			geo_lat;
		string11  			geo_long;
		string4   			msa;
		string7   			geo_blk;
		string1   			geo_match;
		string4   			err_stat;
		//Added for Shell 5.0 project 6/3/13
		STRING5					tier2;
		//Added for OKC Student List 7/10/17 DF-19691
		STRING5					CollegeID := '';
		STRING4					CollegeUpdate := '';
		string2					source := '';
		//CCPA-7 Add 2 new fields for CCPA
		// unsigned4 global_sid;
		// unsigned8 record_sid;
	END;


	EXPORT prepBase(base_ds) := FUNCTIONMACRO
		import American_student_list;
		
		local _dsSup := American_student_list.Regulatory.applyAslSup(base_ds);
		return American_student_list.Regulatory.applyAslInj(_dsSup);
	ENDMACRO;

	EXPORT applyAslSup(base_ds) := FUNCTIONMACRO
		import American_student_list, Suppress;

		local _DidAddressAslHash (recordof(base_ds) L) :=  hashmd5(
															l.did,(string)l.state,(string)l.zip,(string)l.city,
															(string)l.prim_name,(string)l.prim_range,(string)l.predir,
															(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
							
		local _dsUpdated := Suppress.applyRegulatory.simple_sup(base_ds, 'file_asl_sup.txt', _DidAddressAslHash);
		return (_dsUpdated);


	ENDMACRO;

	EXPORT applyAslInj(base_ds) := FUNCTIONMACRO
		import American_student_list, Suppress, Std;
		local _Base_File_Append_In := suppress.applyregulatory.getFile('file_asl_inj.txt', American_student_list.Regulatory.drop_american_student_base_v2_layout);
		
		string8 cpd := max(base_ds, process_date);
		recordof(base_ds) reformat_key(American_student_list.Regulatory.drop_american_student_base_v2_layout pInput) := 
			 transform
				self.key := HASH64(pInput.FULL_NAME, 
											pInput.ZIP, 
											Std.Str.CleanSpaces(pInput.Address_1 + ' ' + pInput.Address_2), 
											pInput.DOB_FORMATTED, 
											pInput.LN_COLLEGE_NAME, 
											pInput.COLLEGE_MAJOR, 
											pInput.telephone);
				self.did := (unsigned6) pInput.did;
				self.RawAID := (unsigned8) pInput.RawAID;
				self.process_date := cpd;
				self.date_last_seen := cpd;
				self.date_vendor_last_reported := cpd;
				self.global_sid := 24261;
				self.record_sid := 0;

				self := pInput;
				self := [];
		end;
 
		local _Base_File_Append := project(_Base_File_Append_In, reformat_key(LEFT)); 
		
		return base_ds + _Base_File_Append;
	ENDMACRO;



END;