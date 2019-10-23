import ut;

EXPORT fnMap_Banko(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
										
	NullSet := INQL_v2.fncleanfunctions.nullset;

	inputfile := 
			choosen(INQL_v2.Standardize_input(fcra, logType).Banko(orig_company_id <> ''),IF(n > 0, n, choosen:ALL)); // choosen for testing purposes

	tinputfile := project(distribute(inputfile, random()), transform({string orig_global_company_id := '', recordof(inputfile)},
																									self := left)); 

	INQL_v2.fncleanfunctions.cleanfields(tinputfile, cleaned_fields);
	INQL_v2.File_MBSApp(cleaned_fields, 'BANKO', '', mbs_outfile)

	cleanInput := project(mbs_outfile, transform(INQL_v2.Layouts.Common_layout,
					self.PERSON_ORIG_IP_ADDRESS1 := INQL_v2.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS);
					self.ORIG_IP_ADDRESS2 := map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '');

					self.ORIG_FULL_NAME1 := stringlib.stringfindreplace(
																			stringlib.stringcleanspaces(left.orig_name_first + ' ' + left.orig_name_last)
																			, ',', ', ');
					self.ORIG_FULL_NAME2 := '';
					self.ORIG_FNAME := left.orig_name_first;
					self.ORIG_MNAME := '';
					self.ORIG_LNAME := left.orig_name_last;
					self.ORIG_NAMESUFFIX := '';
					
					self.ORIG_ADDR1 := left.orig_address;
					self.ORIG_LASTLINE1 := stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip);
					self.ORIG_CITY1 := left.orig_city;
					self.ORIG_STATE1 := left.orig_state;
					self.ORIG_ZIP1 := left.orig_zip ;

					fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.orig_date_added);
					fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
					self.DateTime := fixTime;
					self.SSN := INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);
					self.PERSONAL_PHONE := INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
					self.COMPANY_PHONE := INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
					self.DOB := INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);

					self.ORIG_COMPANY_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(left.ORIG_BUSINESS_NAME, ',', ', '));

					self.ORIG_GLOBAL_COMPANY_ID := left.ORIG_GLOBAL_COMPANY_ID;
					self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
					self.COMPANY_ID := left.orig_company_id;
					self.INDUSTRY_1_CODE := left.industry_code_1;
					self.INDUSTRY_2_CODE := left.industry_code_2;
					self.TRANSACTION_TYPE := left.orig_transaction_type;
					self.FUNCTION_DESCRIPTION := left.description;

					self.ALLOWFLAGS := left.allowflags;
					self.Login_History_ID := left.orig_login_history_id;
					self.TRANSACTION_ID := left.orig_transaction_id;
					self.SEQUENCE_NUMBER := '';
					self.METHOD := 'ONLINE';

					self.FCRA_purpose := left.orig_fcra_purpose;
					self.GLB_purpose  := left.orig_glb_purpose;
					self.DPPA_purpose := left.orig_dppa_purpose;
					SELF.PRODUCT_CODE := LEFT.PRODUCT_ID;
					SELF.PRIMARY_MARKET_CODE := LEFT.PRIMARY_MARKET_CODE;
					SELF.SECONDARY_MARKET_CODE := LEFT.SECONDARY_MARKET_CODE;
					SELF.SUB_MARKET := LEFT.SUB_MARKET;
					SELF.VERTICAL := LEFT.VERTICAL;
					SELF.INDUSTRY := LEFT.INDUSTRY;
					SELF.USE := LEFT.USE;

					SELF.SOURCE_FILE := 'BANKO';
					SELF := LEFT;			
					self := []));
					
		return if(logType = 5, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
END;