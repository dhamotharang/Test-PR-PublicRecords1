IMPORT Prof_License_Mari, Lib_FileServices, ut;

EXPORT fNotifyError := MODULE

	SHARED mari_dest						:= '~thor_data400::in::proflic_mari::';

	//This function search a MARI base super file specified by code (e.g. S0280) and pVersion (YYYYMMDD) and 
	//send a notification email if there is any record that has blank std_license_status
	EXPORT MissingStdLicenseStatus(string code, string src_cd, string pVersion,string email_addr) := FUNCTION
		
		inFileName := mari_dest + pVersion + '::' + src_cd;
		inFile := dataset(inFileName, Prof_License_Mari.layout_base_in, FLAT);
		cnt := count(inFile(std_license_status=' '));
		err_msg := 'MARI - vendor file(s) to MARI base file conversion\n\n' + 
							 'Error Type:\t\tMissing STD_LICENSE_STATUS\n' +
		           'Error description:\tThere are ' + cnt + ' records that do not have STD_LICENSE_STATUS\n' +
		           'Source Code:\t\t' + code + '\n' +
							 'Vendor Date:\t\t' + pVersion + '\n' +
							 'Work Unit:\t\t' + thorlib.wuid() + '\n' +
							 'File Name:\t\t' + inFileName + '\n';
		notifyError := IF(cnt > 0,
		                  fileservices.sendemail(email_addr,'ERROR: Missing STD_LICENSE_STATUS in '+inFileName, err_msg),
											output('OK'));

		RETURN notifyError;
		
	END;

	//This function search a MARI base super file specified by code (e.g. S0280) and pVersion (YYYYMMDD) and 
	//send a notification email if there is any record that has blank prof_cd, std_license_status, or std_license_type
	EXPORT MissingStdCodes(string code, string src_cd, string pVersion,string email_addr) := FUNCTION
		
		inFileName := mari_dest + pVersion + '::' + src_cd;
		inFile := dataset(inFileName, Prof_License_Mari.layout_base_in, FLAT);
		missing_std_prof_cd_cnt := count(inFile(std_prof_cd=' '));
		missing_std_license_status_cnt := count(inFile(std_license_status=' '));
		missing_std_license_type_cnt := count(inFile(std_license_type=' '));
		err_msg_hdr	:= 'MARI - vendor file(s) to MARI base file conversion\n\n' +
									 'Source Code:\t\t' + code + '\n' +
									 'Vendor Date:\t\t' + pVersion + '\n' +
									 'Work Unit:\t\t' + thorlib.wuid() + '\n' +
									 'File Name:\t\t' + inFileName + '\n\n';

		err_msg1	:= IF(missing_std_prof_cd_cnt<>0,
									  err_msg_hdr +
									 'Error Type:\t\tMissing STD_PROF_CD\n' +
									 'Error description:\tThere are ' + missing_std_prof_cd_cnt + ' records that do not have STD_PROF_CD\n\n',
									 err_msg_hdr);
									 
		err_msg2	:= IF(missing_std_license_status_cnt<>0,
									  err_msg1 +
									 'Error Type:\t\tMissing STD_LICENSE_STATUS\n' +
									 'Error description:\tThere are ' + missing_std_license_status_cnt + ' records that do not have STD_LICENSE_STATUS\n\n',
									 err_msg1);
		err_msg3	:= IF(missing_std_license_type_cnt<>0,
									  err_msg2 +
									 'Error Type:\t\tMissing STD_LICENSE_TYPE\n' +
									 'Error description:\tThere are ' + missing_std_license_type_cnt + ' records that do not have STD_LICENSE_TYPE\n\n',
									 err_msg2);
									 
		notifyError := IF(missing_std_prof_cd_cnt+missing_std_license_status_cnt+missing_std_license_type_cnt > 0,
		                  fileservices.sendemail(email_addr,'ERROR: Missing MARI Standardized Codes in '+inFileName, err_msg3),
											output('OK'));

		RETURN notifyError;
		
	END;

	//This function search a MARI base super file specified by code (e.g. S0280) and pVersion (YYYYMMDD) and 
	//send a notification email if there is any record that has blank prof_cd, std_license_status, or std_license_type
	EXPORT NameInAddressFields(string code, string src_cd, string pVersion,string email_addr) := FUNCTION
		
		PATTERN_NAME := '( LLC$| LLC | INC$| INC | CORP$| COMPANY$| COMPANY | ATTN | ATTN:|^ATTN|C/O| DBA |^DBA | T/A | AKA |^AKA)';
		//List of legit address pattern
		PATTERN_EXCEPT_NAME := '( COMPANY ST)';
		inFileName := mari_dest + pVersion + '::' + src_cd;
		inFile := dataset(inFileName, Prof_License_Mari.layout_base_in, FLAT);
		invalid_addr1 := inFile(REGEXFIND(PATTERN_NAME,addr_addr1_1+' '+addr_addr2_1+' '+addr_addr3_1+' '+addr_addr4_1) AND
		                        NOT REGEXFIND(PATTERN_EXCEPT_NAME,addr_addr1_1+' '+addr_addr2_1+' '+addr_addr3_1+' '+addr_addr4_1) );
		invalid_addr1_cnt := count(invalid_addr1);	
		output(invalid_addr1);
		
		//Do not check city. There are too many valid cities that are treated as invalid.
	//	invalid_city1	:= inFile(addr_city_1<>'' AND NOT ut.IsCityName(addr_city_1));			
	//	invalid_city1_cnt	:= count(invalid_city1);			
		//output(invalid_city1);
		
		invalid_addr2 := inFile(REGEXFIND(PATTERN_NAME,addr_addr1_2+' '+addr_addr2_2+' '+addr_addr3_2+' '+addr_addr4_2) AND
		                        NOT REGEXFIND(PATTERN_EXCEPT_NAME,addr_addr1_2+' '+addr_addr2_2+' '+addr_addr3_2+' '+addr_addr4_2));
		invalid_addr2_cnt := count(invalid_addr2);																					 
		output(invalid_addr2);
		//invalid_city2	:= inFile(addr_city_2<>'' AND NOT ut.IsCityName(addr_city_2));			
		//invalid_city2_cnt	:= count(invalid_city2);			
		//output(invalid_city2);
		
		err_msg_hdr	:= 'MARI - vendor file(s) to MARI base file conversion\n\n' +
									 'Source Code:\t\t' + code + '\n' +
									 'Vendor Date:\t\t' + pVersion + '\n' +
									 'Work Unit:\t\t' + thorlib.wuid() + '\n' +
									 'File Name:\t\t' + inFileName + '\n\n';

		err_msg1	:= IF(invalid_addr1_cnt<>0,
									  err_msg_hdr +
									 'Error Type:\t\tInvalid data in Address 1 fields\n' +
									 'Error description:\tThere are ' + invalid_addr1_cnt + ' records that have company/person name in the address 1 fields\n\n',
									 err_msg_hdr);
									 
		//err_msg2	:= IF(invalid_city1_cnt<>0,
		//							  err_msg1 +
		//							 'Error Type:\t\tInvalid city 1 name\n' +
		//							 'Error description:\tThere are ' + invalid_city1_cnt + ' records that have invalid city names in addr_city_1\n\n',
		//							 err_msg1);
		err_msg3	:= IF(invalid_addr2_cnt<>0,
									  err_msg1 +
									 'Error Type:\t\tInvalid data in Address 2 fields\n' +
									 'Error description:\tThere are ' + invalid_addr2_cnt + ' records that have company/person name in the address 2 fields\n\n',
									 err_msg1);
		// err_msg4	:= IF(invalid_city2_cnt<>0,
									  // err_msg3 +
									 // 'Error Type:\t\tInvalid city 2 name\n' +
									 // 'Error description:\tThere are ' + invalid_city2_cnt + ' records that have invalid city names in addr_city_2\n\n',
									 // err_msg3);
									 
		notifyError := IF(invalid_addr1_cnt+/*invalid_city1_cnt+*/invalid_addr2_cnt/*+invalid_city2_cnt*/ > 0,
		                  fileservices.sendemail(email_addr,'ERROR: Found ERRORs in address fields in '+inFileName, err_msg3),
											output('OK'));

		RETURN notifyError;
		
	END;
	
END;

