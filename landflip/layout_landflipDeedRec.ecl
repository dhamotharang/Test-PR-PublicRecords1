EXPORT layout_landflipDeedRec
	:=
		RECORD
			string12  ln_fares_id;									//Needed to join on addl_deed
			string5   vendor_source_flag; 					//previously string5 -> new values 'F' for 'FAR_F', 'S' for 'FAR_S', 'O' for 'OKCTY', and 'D' for 'DAYTN'
			string5		fips_cd;											//Keep the fips
			string2   state_cd;											//STATE - Two char state code
			string3   cnty_cd;											//FIPS_CODE - Last three chars of fips_cd
			string18  county_name;									//COUNTY_NAME
			string45  apn_num;											//APNT_OR_PIN_NUMBER
			string80  buyer;												//NAME1
			string80  seller;												//SELLER1
			string40  lender;												//LENDER_NAME
			string5   loan_type_code;								//FIRST_TD_LOAN_TYPE_CODE
			string330	loan_type_desc;								//Maps to FARES_1080 description loan_type_code
			string8		transfer_dt;									//More recent of the CONTRACT_DATE or RECORDING_DATE
			string11  transfer_value;								//SALES_PRICE
			string76  str_info;											//PROPERTY_FULL_STREET_ADDRESS+PROPERTY_ADDRESS_UNIT_NUMBER
			string41  str_city;											//property_address_citystatezip
			string10	str_zip9;											//property_address_citystatezip
			string127	owner_mail_addr;							//MAIL_STREET+MAIL_UNIT_NUMBER+MAILING_CSZ
			string60  title_company_name;						//TITLE_COMPANY_NAME
			string80  snd_buyer;										//NAME2
			string1   foreclosure_flag;							//DOCUMENT_TYPE_CD = 'FC', flag = 'Y'
			string30  muni_cd;											//Only used for BLJ recs
		END
		;