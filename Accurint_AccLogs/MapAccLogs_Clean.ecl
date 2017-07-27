import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, inquiry_acclogs;

inputFile := accurint_acclogs.MapAccLogs_PreProcess(orig_END_USER_ID <> 'END_USER_ID' and orig_detail in ['GOV','LE'] and orig_transaction_code = '110');

/////////////////NAME AND BUSINESS CLEAN NEW FILE - REMOVE NULL IDENTIFIERS - ASSIGN UNIQUE ID FIELDS/////////////////////////////////////////////////////////

NullSet := ['NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null'];
																
reconName := project(inputFile, TRANSFORM({RecordOf(accurint_acclogs.MapAccLogs_PreProcess), 
									address.Layout_Clean_Name - name_score, string fullname,
										string user_title,
										string user_fname,
										string user_mname,
										string user_lname,
										string user_name_suffix,
										string user_cname,
										string user_name_append}, //new
////// Clean Queried Name			
		cleanName := map(left.orig_fname = '' and left.orig_full_name <> '' and left.orig_full_name not in ['','NULL','UKNOWN','null','unknown'] => address.CleanPersonFML73(left.orig_full_name),
					left.orig_lname not in ['','NULL','UKNOWN','null','unknown'] => address.CleanPersonLFM73(stringlib.stringcleanspaces(regexreplace('(NULL)|(UNKNOWN)', left.orig_lname +  ', ' + left.orig_fname + ' ' + left.orig_mname, '', nocase))),
					address.CleanPersonFML73(stringlib.stringcleanspaces(regexreplace('(NULL)|(UNKNOWN)', left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname, '', nocase))));
			
			self.title := stringlib.stringfilter(cleanName[1..5], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
			self.fname := stringlib.stringfilter(cleanName[6..25], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
			self.mname := stringlib.stringfilter(cleanName[26..45], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
			self.lname := stringlib.stringfilter(cleanName[46..65], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
			self.name_suffix := stringlib.stringfilter(cleanName[66..70], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
			self.fullname := stringlib.stringcleanspaces(map(self.fname + self.lname + self.mname = '' => left.orig_full_name, 
										self.fname + ' ' + self.lname + ' ' + self.mname));
////// Clean User Name
		UserNameConcat := left.orig_user_firstname + ' ' + stringlib.stringfindreplace(stringlib.stringtouppercase(left.orig_user_lastname), 'XML ID', '');
		UserCleanName := address.CleanPersonFML73(stringlib.stringcleanspaces(regexreplace('(NULL)|(UNKNOWN)', UserNameConcat, '', nocase)));
			
			self.user_title := UserCleanName[1..5];
			self.user_fname := UserCleanName[6..25];
			self.user_mname := UserCleanName[26..45];
			self.user_lname := UserCleanName[46..65];
			self.user_name_suffix := UserCleanName[66..70];
			self.user_name_append := map(stringlib.stringfind(left.orig_user_lastname, 'XML ID', 1) = 0 => '', 'XML ID');

/* remove null identifiers */							
			self.ORIG_END_USER_ID		:= map(left.orig_END_USER_ID in NullSet => '', left.orig_END_USER_ID);
			self.ORIG_LOGINID			:= map(left.orig_LOGINID in NullSet => '', left.orig_LOGINID);
			self.ORIG_BILLING_CODE		:= map(left.orig_BILLING_CODE in NullSet => '', left.orig_BILLING_CODE);
			self.ORIG_TRANSACTION_ID	:= map(left.orig_TRANSACTION_ID in NullSet => '', left.orig_TRANSACTION_ID);
			self.ORIG_TRANSACTION_TYPE	:= map(left.orig_TRANSACTION_TYPE in NullSet => '', left.orig_TRANSACTION_TYPE);
			self.ORIG_NEIGHBORS			:= map(left.orig_NEIGHBORS in NullSet => '', left.orig_NEIGHBORS);
			self.ORIG_RELATIVES			:= map(left.orig_RELATIVES in NullSet => '', left.orig_RELATIVES);
			self.ORIG_ASSOCIATES		:= map(left.orig_ASSOCIATES in NullSet => '', left.orig_ASSOCIATES);
			self.ORIG_PROPERTY			:= map(left.orig_PROPERTY in NullSet => '', left.orig_PROPERTY);
			self.ORIG_COMPANY_ID		:= map(left.orig_COMPANY_ID in NullSet => '', left.orig_COMPANY_ID);
			self.ORIG_REFERENCE_CODE	:= map(left.orig_REFERENCE_CODE in NullSet => '', left.orig_REFERENCE_CODE);
			self.ORIG_FNAME				:= map(left.orig_FNAME in NullSet => '', left.orig_FNAME);
			self.ORIG_MNAME				:= map(left.orig_MNAME in NullSet => '', left.orig_MNAME);
			self.ORIG_LNAME				:= map(left.orig_LNAME in NullSet => '', left.orig_LNAME);
			self.ORIG_ADDRESS			:= map(left.orig_ADDRESS in NullSet => '', left.orig_ADDRESS);
			self.ORIG_CITY				:= map(left.orig_CITY in NullSet => '', left.orig_CITY);
			self.ORIG_STATE				:= map(left.orig_STATE in NullSet => '', left.orig_STATE);
			self.ORIG_ZIP				:= map(left.orig_ZIP in NullSet => '', left.orig_ZIP);
			self.ORIG_ZIP4				:= map(left.orig_ZIP4 in NullSet => '', left.orig_ZIP4);
			self.ORIG_PHONE				:= map(left.orig_PHONE in NullSet => '', left.orig_PHONE);
			self.ORIG_SSN				:= map(left.orig_SSN in NullSet => '', left.orig_SSN);
			self.ORIG_FREE				:= map(left.orig_FREE in NullSet => '', left.orig_FREE);
			self.ORIG_RECORD_COUNT		:= map(left.orig_RECORD_COUNT in NullSet => '', left.orig_RECORD_COUNT);
			self.ORIG_PRICE				:= map(left.orig_PRICE in NullSet => '', left.orig_PRICE);
			self.ORIG_BANKRUPTCY		:= map(left.orig_BANKRUPTCY in NullSet => '', left.orig_BANKRUPTCY);
			self.ORIG_TRANSACTION_CODE	:= map(left.orig_TRANSACTION_CODE in NullSet => '', left.orig_TRANSACTION_CODE);
			self.ORIG_DATEADDED			:= map(left.orig_DATEADDED in NullSet => '', left.orig_DATEADDED);
			self.ORIG_FULL_NAME			:= map(left.orig_FULL_NAME in NullSet => '', left.orig_FULL_NAME);
			self.ORIG_BILLINGDATE		:= map(left.orig_BILLINGDATE in NullSet => '', left.orig_BILLINGDATE);
			self.ORIG_BUSINESS_NAME		:= map(left.orig_business_name in NullSet => '', left.orig_business_name);
			self.ORIG_PRICING_ERROR_CODE		:= map(left.orig_pricing_error_code in NullSet => '', left.orig_pricing_error_code);
			self.ORIG_DL_PURPOSE		:= map(left.orig_dl_purpose in NullSet => '', left.orig_dl_purpose);
			self.ORIG_RESULT_FORMAT		:= map(left.orig_result_format in NullSet => '', left.orig_result_format);
			self.ORIG_DOB				:= map(left.orig_dob in NullSet => '', left.orig_dob);
			self.ORIG_UNIQUE_ID			:= map(left.orig_unique_id in NullSet => '', left.orig_unique_id);
			self.ORIG_DLS				:= map(left.orig_dls in NullSet => '', left.orig_dls);
			self.ORIG_MVS				:= map(left.orig_mvs in NullSet => '', left.orig_mvs);
			self.ORIG_FUNCTION_NAME		:= map(left.orig_FUNCTION_NAME in NullSet => '', left.orig_FUNCTION_NAME);
			self.ORIG_RESPONSE_TIME		:= map(left.orig_response_time in NullSet => '', left.orig_response_time);
			self.ORIG_DATA_SOURCE		:= map(left.orig_data_source in NullSet => '', left.orig_data_source);
			self.ORIG_GLB_PURPOSE		:= map(left.orig_glb_purpose in NullSet => '', left.orig_glb_purpose);
			self.ORIG_REPORT_OPTIONS	:= map(left.orig_REPORT_OPTIONS in NullSet => '', left.orig_REPORT_OPTIONS);
			self.ORIG_UNUSED			:= map(left.orig_UNUSED in NullSet => '', left.orig_UNUSED);
			self.ORIG_LOGIN_HISTORY_ID	:= map(left.orig_login_history_id in NullSet => '', left.orig_login_history_id);
			self.ORIG_ASEID				:= map(left.orig_ASEID in NullSet => '', left.orig_ASEID);
			self.ORIG_YEARS				:= map(left.orig_years in NullSet => '', left.orig_years);
			self.ORIG_IP_ADDRESS		:= map(left.orig_IP_ADDRESS in NullSet => '', left.orig_IP_ADDRESS);
			self.ORIG_SOURCE_CODE		:= map(left.orig_SOURCE_CODE in NullSet => '', left.orig_SOURCE_CODE);
			self.ORIG_RETAIL_PRICE		:= map(left.orig_RETAIL_PRICE in NullSet => '', left.orig_RETAIL_PRICE);
			self.orig_User_CompanyName	:= map(left.orig_User_CompanyName in NullSet => '', left.orig_User_CompanyName);
					self.user_cname 	:= ut.CleanCompany(self.orig_User_CompanyName);
			self.orig_User_FirstName	:= map(left.orig_User_FirstName in NullSet => '', left.orig_User_FirstName);
			self.orig_User_LastName		:= map(left.orig_User_LastName in NullSet => '', left.orig_User_LastName);
			self.orig_searchdescription	:= map(left.orig_searchdescription in NullSet => '', left.orig_searchdescription);
			self := LEFT));
						
/////////////////CLEAN ADDRESSES, DATES, SSN, PHONE - NO AID, FIELDS INCONSISTENT//////////////////////////////////////////////////////////////////////////////////////////

BasicClean := PROJECT(reconName, 
						TRANSFORM(	{RecordOf(reconName) - fullname, 
									string cname,
									address.Layout_Clean182,
									string phone,
									string ssn,
									string dob,
									string8 dt_vendor_first_reported;
									string8 dt_vendor_last_reported;
									unsigned6 DID := 0;
									unsigned6 BDID := 0;
									string search_description,
									string user_id},
								 
								 pclean_ssn		 := stringlib.stringfilter(left.orig_ssn, '0123456789');
								 clean_ssn		 := if(length(pclean_ssn) in [4,6], 
														intformat((unsigned8)stringlib.stringfilter(pclean_ssn, '0123456789'), 9, 0),
														stringlib.stringfilter(pclean_ssn, '0123456789'));

								 aclean_phone := stringlib.stringfilter(left.orig_phone, '0123456789');
								 bclean_phone := map(length(aclean_phone) = 3 => aclean_phone + '       ',
													 length(aclean_phone) = 7 => '   ' + aclean_phone,
													 aclean_phone);
								 pclean_phone := if(bclean_phone[1..3]  = '000', '   ', bclean_phone[1..3])+ bclean_phone[4..10]; /* empty area codes standardized */
									NPAg := pclean_phone[1..3] in ['800','811','822','833','844','855','866','877','888','899'] or pclean_phone[1..3] between '200' and '999'; /* toll free area codes */
									NXXg := pclean_phone[4..6] between '001' and '999'; /* valid nxx */
									TBg  := pclean_phone[7..10] between '0000' and '9999'; /* valid tb+ */
								 clean_phone := map(NPAg and NXXg and TBg => pclean_phone,
													NXXg and TBg => '   ' + pclean_phone[7..10], 
													NPAg => pclean_phone[1..3] + '       ', pclean_phone);

								 clean_yr := map((unsigned8)left.orig_dob[1..4] between ((unsigned8)ut.getdate[1..4]) - 123 and (unsigned8)ut.getdate[1..4] => left.orig_dob[1..4], '0000');
								 clean_mn := map(left.orig_dob[5..6] between '01' and '12' => left.orig_dob[5..6], '00');
								 clean_dy := map(clean_mn <> '00' and clean_yr <> '0000' and (unsigned8)left.orig_dob[7..8] between 1 and ut.Month_Days((unsigned8)(clean_yr+clean_mn)) => left.orig_dob[7..8],
													clean_mn in ['01','03','05','07','08','10','12'] and left.orig_dob[7..8] between '01' and '31' => left.orig_dob[7..8],
													clean_mn in ['04','06','09','11'] and left.orig_dob[7..8] between '01' and '30' => left.orig_dob[7..8],
													clean_mn = '02' and left.orig_dob[7..8] between '01' and '29' => left.orig_dob[7..8],
													'00');
							
								gd_address	:= left.orig_address not in NullSet and left.orig_address <> '';
								gd_lastline	:= map((left.orig_state <> '' and stringlib.stringfindreplace(left.orig_city, 'NULL', '') <> '') or left.orig_zip <> '' => true,
														false);
								cleanaddr	:= address.CleanAddress182(
														stringlib.stringcleanspaces(if(gd_address, stringlib.stringfindreplace(left.orig_address, 'NULL', ''), '')),
														stringlib.stringcleanspaces(if(gd_lastline, left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip + left.orig_zip4, 
																if(gd_address, 'XXXXX, YY 99999', ''))));
								tDateAdded(string indate) := function //dates like Dec  1 2009 5:35:32:011AM
										upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);
										needsTrans := ~regexfind('[B-LN-OQ-Z]', upcaseit);
										month 	:= map(upcaseit[1..3] = 'JAN' => '01',
														upcaseit[1..3] = 'FEB' => '02',
														upcaseit[1..3] = 'MAR' => '03',
														upcaseit[1..3] = 'APR' => '04',
														upcaseit[1..3] = 'MAY' => '05',
														upcaseit[1..3] = 'JUN' => '06',
														upcaseit[1..3] = 'JUL' => '07',
														upcaseit[1..3] = 'AUG' => '08',
														upcaseit[1..3] = 'SEP' => '09',
														upcaseit[1..3] = 'OCT' => '10',
														upcaseit[1..3] = 'NOV' => '11',
														upcaseit[1..3] = 'DEC' => '12', '');
										DyYr 	:= (string)intformat((integer6)stringlib.stringfilter(upcaseit[4..11], '0123456789'), 6, 1);
										Dy		:= DyYr[1..2];
										Yr		:= DyYr[3..6];
								return if(needsTrans, stringlib.stringfilter(upcaseit, '1234567980')[1..8], yr+month+dy);
								end;	

			self.cname			:= ut.CleanCompany(left.orig_business_name);
			self.orig_address 	:= stringlib.stringfindreplace(left.orig_address, 'NULL', '');
			self.ssn			:= if(clean_ssn not in ['000000000', '0', '0000', '00000'] and clean_ssn not in ut.Set_BadSSN and clean_ssn not in NullSet,  clean_ssn, '');
			self.phone			:= clean_phone;
			self.dob			:= stringlib.stringfindreplace(clean_yr + clean_mn + clean_dy, '00000000', '');
			self.dt_vendor_first_reported	:= tDateAdded(left.orig_dateadded);
			self.dt_vendor_last_reported	:= tDateAdded(left.orig_dateadded);
							
			self.prim_range := cleanaddr[1..10];
			self.predir := cleanaddr[11..12];
			self.prim_name := cleanaddr[13..40];
			self.addr_suffix := cleanaddr[41..44];
			self.postdir := cleanaddr[45..46];
			self.unit_desig := cleanaddr[47..56];
			self.sec_range := cleanaddr[57..64];
			self.p_city_name := if(cleanaddr[65..89] <> 'XXXXX', cleanaddr[65..89], '');
			self.v_city_name := if(cleanaddr[90..114] <> 'XXXXX', cleanaddr[90..114], '');
			self.st := if(cleanaddr[115..116] <> 'YY', cleanaddr[115..116], '');
			self.zip :=if( cleanaddr[117..121] <> '99999',  cleanaddr[117..121], '');
			self.zip4 := cleanaddr[122..125];
			self.cart := cleanaddr[126..129];
			self.cr_sort_sz := cleanaddr[130];
			self.lot := cleanaddr[131..134];
			self.lot_order := cleanaddr[135];
			self.dbpc := cleanaddr[136..137];
			self.chk_digit := cleanaddr[138];
			self.rec_type := cleanaddr[139..140];
			self.county := cleanaddr[141..145];
			self.geo_lat := cleanaddr[146..155];
			self.geo_long := cleanaddr[156..166];
			self.msa := cleanaddr[167..170];
			self.geo_blk := cleanaddr[171..177];
			self.geo_match := cleanaddr[178];
			self.err_stat := cleanaddr[179..182];

			self.user_cname := if(left.user_cname in ['0',''], stringlib.stringtouppercase(left.orig_loginid), left.user_cname); 
			self.search_description := stringlib.stringcleanspaces(stringlib.stringtouppercase(if(left.orig_searchdescription = '', trim(left.orig_transaction_type, left, right) + '-' + left.orig_function_name, left.orig_searchdescription))); 
			self.user_id := stringlib.stringtouppercase(if(left.orig_login_history_id <= '0', left.orig_loginid, left.orig_billing_code));
						
			self.orig_ein 				:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_ein), 			'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_charter_nbr 		:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_charter_nbr), 	'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_ucc_nbr 			:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_ucc_nbr), 		'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_filing_nbr 		:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_filing_nbr), 	'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_did 				:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_did), 			'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_domain 			:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_domain), 		'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self.orig_dl 				:= stringlib.stringfilter(stringlib.stringtouppercase(left.orig_dl), 			'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			self := LEFT));

/////////////////DID and BDID//////////////////////////////////////////////////////////////////////////////////////////

did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(BasicClean(fname <> '' and lname <> ''), did_match_set,
						ssn, dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip, st, phone,
						did, recordof(BasicClean),false,'',
						75, DIDFile);
						
DIDready := DIDFile + BasicClean(fname = '' or lname ='');
//////

inBDID := DIDready(cname <> '');

bdid_match_set := ['A','P'];  

Business_Header_SS.MAC_Match_Flex(inBDID, bdid_match_set,
									cname,
									prim_range, prim_name, zip, sec_range, st, phone, foo,
									bdid, recordof(DIDready), 
									false, '', BDIDFile);
									
appendedFile := BDIDFile + DIDready(cname = '');

export MapAccLogs_Clean := appendedFile : persist('~accurint_acclogs::clean');
// export MapAccLogs_Clean := dataset('~accurint_acclogs::clean', recordof(appendedFile), thor);
