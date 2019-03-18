IMPORT corp2, corp2_mapping, std;

EXPORT Functions := Module

		//****************************************************************************
		//StateDescriptionTranslation: returns the us state code.
		//****************************************************************************
		EXPORT StateDescriptionTranslation(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(uc_s = 'ALABAMA' 													=> 'AL',
											uc_s = 'ALASKA' 													=> 'AK', 
											uc_s = 'ARKANSAS'													=> 'AR', 
											uc_s = 'AMERICAN SAMOA' 									=> 'AS',
											uc_s = 'ARIZONA' 													=> 'AZ', 
											uc_s = 'CALIFORNIA' 											=> 'CA',
											uc_s = 'CAYMAN ISLANDS'										=> 'CYM', //modified from 2 digit iso "KY" to 3 digit iso "CYM"
											uc_s = 'COLORADO' 												=> 'CO',
											uc_s = 'CONNECTICUT' 											=> 'CT',
											uc_s = 'CANAL ZONE' 											=> 'CZ',							
											uc_s = 'DISTRICT OF COLUMBIA' 						=> 'DC',
											uc_s = 'DELAWARE' 												=> 'DE',
											uc_s = 'FLORIDA' 													=> 'FL',
											uc_s = 'GEORGIA' 													=> 'GA',
											uc_s = 'GUAM' 														=> 'GU',
											uc_s = 'HAWAII' 													=> 'HI',
											uc_s = 'IOWA' 														=> 'IA',
											uc_s = 'IDAHO' 														=> 'ID',
											uc_s = 'ILLINOIS' 												=> 'IL',
											uc_s = 'INDIANA' 													=> 'IN',
											uc_s = 'KANSAS' 													=> 'KS',
											uc_s = 'KENTUCKY' 												=> 'KY',
											uc_s = 'LOUISIANA' 												=> 'LA',
											uc_s = 'MASSACHUSETTS' 										=> 'MA',
											uc_s = 'MARYLAND' 												=> 'MD',
											uc_s = 'MAINE'														=> 'ME',
											uc_s = 'MICHIGAN'													=> 'MI', 
											uc_s = 'MINNESOTA'												=> 'MN',
											uc_s = 'MISSOURI'													=> 'MO',
											uc_s = 'MISSISSIPPI'											=> 'MS',
											uc_s = 'MONTANA'													=> 'MT',
											uc_s = 'NORTH CAROLINA'										=> 'NC',
											uc_s = 'NORTH DAKOTA'											=> 'ND',
											uc_s = 'NEBRASKA'													=> 'NE',
											uc_s = 'NEW HAMPSHIRE'										=> 'NH',
											uc_s = 'NEW HAMSHIRE'											=> 'NH',
											uc_s = 'NEW JERSEY'												=> 'NJ',
											uc_s = 'NEW MEXICO'												=> 'NM',
											uc_s = 'NEVADA'														=> 'NV',
											uc_s = 'NEW YORK'													=> 'NY',
											uc_s = 'OHIO'															=> 'OH',
											uc_s = 'OKLAHOMA'													=> 'OK',
											uc_s = 'OREGON'														=> 'OR',
											uc_s = 'PENNSYLVANIA'											=> 'PA',
											uc_s = 'PUERTO RICO'											=> 'PR',
											uc_s = 'RHODE ISLAND'											=> 'RI',
											uc_s = 'SOUTH CAROLINA'										=> 'SC',
											uc_s = 'SOUTH DAKOTA'											=> 'SD',
											uc_s = 'TENNESSEE'												=> 'TN',
											uc_s = 'TEXAS'														=> 'TX',
											uc_s = 'UNITED STATES'										=> 'US',
											uc_s = 'UTAH'														 	=> 'UT',
											uc_s = 'VIRGINIA'													=> 'VA',
											uc_s = 'VIRGIN ISLANDS'										=> 'VI',
											uc_s = 'VERMONT'													=> 'VT',
											uc_s = 'WASHINGTON'												=> 'WA',
											uc_s = 'WISCONSIN'												=> 'WI',
											uc_s = 'WEST VIRGINIA'										=> 'WV',
											uc_s = 'WYOMING'													=> 'WY',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//ForeignDescriptionTranslation: returns the country based upon the input.  The codes
		//										 					 left blank are unknown.
		//****************************************************************************
		EXPORT ForeignDescriptionTranslation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(
											uc_s = 'ALBERTA'																		=> 'AB',
											uc_s = 'BRITISH COLUMBIA'														=> 'BC',
											uc_s = 'FEDERATED STATES OF MICRONESIA'							=> 'FSM',
											uc_s = 'MANITOBA'																		=> 'MB',        
											uc_s = 'NEW BRUNSWICK'															=> 'NB',   
											uc_s = 'NEW SOUTH WALES'														=> 'AUS', 
											uc_s = 'NORTHERN MARIANA ISLANDS'										=> 'MNP',      
											uc_s = 'NOVA SCOTIA'																=> 'NS',     
											uc_s = 'ONTARIO'																		=> 'ON',
											uc_s = 'QUEBEC'																			=> 'PQ', 
											uc_s = 'SASKATCHEWAN'																=> 'SK',    
											uc_s = 'SOUTH AUSTRALIA'														=> 'AUS', 
											uc_s = 'TASMANIA'																		=> 'AUS',        
											uc_s = 'TRUST TERRITORY OF THE PACIFIC ISLANDS'			=> 'TTP',
											uc_s = 'VIRGIN ISLAND'															=> 'VI',   
											uc_s = 'YUKON'																			=> 'YT',  
											uc_s = 'CANADA'																			=> 'CAN',                                                   
											'**|'+uc_s
											);
		END;

		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(StateDescriptionTranslation(uc_s)[1..2] 	<> '**' => StateDescriptionTranslation(uc_s),
											ForeignDescriptionTranslation(uc_s)[1..2] <> '**' => ForeignDescriptionTranslation(uc_s),
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(StateDescriptionTranslation(uc_s)[1..2] 	<> '**'	=> uc_s,
											ForeignDescriptionTranslation(uc_s)[1..2] <> '**' => uc_s,
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//ARStatusComment: Returns the "ar_comment" or ar_status.
		//****************************************************************************
		EXPORT ARStatusComment(string s) := FUNCTION

					 PatternInvalidWords	:= 'HAWAII|HI|UNITED STATES|US|BODHI BE';

					 uc_s1 := corp2.t2u(s);

					 //If any word (as indicated in "PatternInvalidWords") exists in the field, 
					 //then blank out the field; it is an invalid status (e.g. UNITED STATES)
					 uc_s2 := if(regexfind(PatternInvalidWords,uc_s1,0)<>'','',uc_s1);

					 uc_s  := uc_s2;

					 RETURN uc_s;
										 
		END;

		//****************************************************************************
		//ARYear: Returns the "ar_year".
		//****************************************************************************
		EXPORT ARYear(string s, integer currentyear) := FUNCTION
			uc_s		:= corp2.t2u(stringlib.stringfilter(s,'0123456789'));
			int_s 	:= (integer)uc_s;

			//Determine if the input data exceeds the current year, if so, it is an invalid
			//ar_year.
			ar_year	:= if(int_s > currentyear,'',uc_s);
			
			RETURN ar_year;
			
		END;

		//****************************************************************************
		//CorpAddlInfo: Returns the "corp_addl_info".
		//****************************************************************************
		EXPORT CorpAddlInfo(string pm, string pt, string im, string vt, string cn, string sn) := FUNCTION
			uc_pm 	:= corp2.t2u(pm); //partner maintenance
			uc_pt		:= corp2.t2u(pt); //partner terms
			uc_im		:= corp2.t2u(im); //initial llc members
			uc_vt		:= corp2.t2u(vt); //vote
			uc_cn		:= corp2.t2u(cn); //consent name
			uc_sn		:= corp2.t2u(sn); //similar name
			pm_desc := map(uc_pm = 'MGR'=>'MANAGED BY MANAGERS; ',
										 uc_pm = 'MEM'=>'MANAGED BY MEMBERS; ',
										 ''
										); 
			pt_desc := if(uc_pt <> '','PARTNER TERMS: ' + uc_pt + '; ','');						 
			im_desc := if(uc_im <> '','INITIAL LLC MEMBERS: ' + uc_im + '; ','');						  
			vt_desc := if(uc_vt <> '','AMENDMENT APPROVAL REQUIREMENT: ' + uc_vt + '; ',''); 
			cn_desc := if(uc_cn <> '','NAME CONSENT FROM: ' + uc_cn + '; ','');
			sn_desc := if(uc_sn <> '','SIMILAR NAME IS: ' + uc_sn + '; ','');

			addinfo	:= corp2.t2u(pm_desc + pt_desc  + im_desc + vt_desc + cn_desc + sn_desc);
			
			RETURN regexreplace('(\\;)( )*$', addinfo, '');

		END;


		//****************************************************************************
		//FormatDate: Returns a formatted date in a MM/DD/CCYY format.
		//****************************************************************************
		EXPORT FormatDate(string d) := FUNCTION
				dt := Corp2_Mapping.fValidateDate(d,'DD_MMM_CCYY').PastDate;
				RETURN if(dt<>'','DATE OF CERTIFICATION: ' + STD.date.ConvertDateFormat(dt, '%Y%m%d','%m/%d/%Y'),'');
		END;

		//****************************************************************************
		//CorpForgnDate: Returns the "corp_forgn_date".
		//
		//Note:  input: l -> locality, c -> country, f -> filesuffix, d -> date
		//****************************************************************************
		EXPORT CorpForgnDate(string l, string c, string f, string d) := FUNCTION
					 uc_l 					 := corp2.t2u(l);
					 uc_c 		 			:= corp2.t2u(c);
					 uc_f 		 			:= corp2.t2u(f);
					 
					 isblank	 			:= if(uc_l = '' and uc_c = '',true,false);
					 
					 isForeignCode 	:= map(uc_f = 'C6' 	 	=> true,
																 uc_f = 'F1'  	=> true,
																 uc_f = 'F2'		=> true,
																 uc_f = 'G6'  	=> true,
																 uc_f = 'K6'		=> true,
																 uc_f = 'L6'  	=> true,
																 uc_f = 'Q6'		=> true,
																 false
																);
													 
					 isForeign 			:= map(uc_l not in ['HAWAII','']					=> true,
																 isblank and isForeignCode	 				=> true,
																 uc_c not in ['UNITED STATES','']		=> true,
																 false
																);
																
						RETURN if(isForeign,corp2_mapping.fValidateDate(d,'DD_MMM_CCYY').PastDate,'');
		END;

		//****************************************************************************
		//CorpForgnDomesticInd: Returns the "corp_forgn_domestic_ind".
		//Note: s => filesuffix and t => companytype
		//****************************************************************************
		EXPORT CorpForgnDomesticInd(string s, string t) := FUNCTION
					 uc_s := corp2.t2u(s);
					 uc_t := corp2.t2u(stringlib.stringfilter(t,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_t = 'DOMESTICLLLP'		=> 'D',
											uc_t = 'FOREIGNLLLP'   	=> 'F',
											uc_s = 'A2' 						=> 'D',
											uc_s = 'CA' 						=> 'D',			 
											uc_s = 'C5' 						=> 'D',
											uc_s = 'C6' 						=> 'F',
											uc_s = 'D1' 						=> 'D',
											uc_s = 'D2' 						=> 'D',
											uc_s = 'D9' 						=> 'D',
											uc_s = 'F1' 						=> 'F',
											uc_s = 'F2' 						=> 'F',
											uc_s = 'G5' 						=> 'D',
											uc_s = 'G6' 						=> 'F',
											uc_s = 'K5' 						=> 'D',
											uc_s = 'K6' 						=> 'F',
											uc_s = 'L5' 						=> 'D',
											uc_s = 'L6' 						=> 'F',
											uc_s = 'P1' 						=> 'D',
											uc_s = 'Q5' 						=> 'D',
											uc_s = 'Q6' 						=> 'F',
											uc_s = 'R7' 						=> '', //known code - set to blank
											uc_s = 'T8' 						=> '', //known code - set to blank
											uc_s = 'ZZ' 						=> '', //known code - set to blank
											''
										 );
		END;

		//****************************************************************************
		//CorpLegalName: Returns the "corp_legal_name/corp_ra_full_name/cont_full_name".
		//Note: There is a vendor issue where the legal name we receive does not
		//			match the data on the vendor's website. There are three issues: 
		//			1. Less-Than signs ("<") appearing in the data.  The vendor stated they
		//				 cannot remove these because they are used by their system for sorting
		//				 purposes.  Since the vendor's website doesn't display the "<", even
		//				 though they are sending it to us, we are removing all "<" signs in
		//				 order to match their website.
		//			2. Astericks at the end of the business_name.  The vendor stated that 
		//				 "*" that appear at the end of the business_name was a practice used
		//				 by a prior business system to indicate an internal note existed for the
		//				 business.  Even though the HI SOS website shows the astericks, we have
		//				 been asked to remove all astericks that appear at the end of the 
		//				 business name.
		//			3. Special characters appearing in the business name.  It has been found
		//				 that a question mark is replacing "special characters" within the 
		//				 vendor's data.  This is a vendor issue.  So a question mark can 
		//				 represent a question mark or another special character.  Until the 
		//				 data is received correctly, all question marks that appear at the
		//				 beginning of the business name or if there is more than one question
		//				 mark then those question marks are being removed.
		//****************************************************************************
		EXPORT CorpLegalName(string state_origin, string state_desc, string business_name) := FUNCTION
					 uc_state_origin 				:= corp2.t2u(state_origin);
					 uc_state_desc	 				:= corp2.t2u(state_desc);
					 //check if the business_name begins with a question mark
					 beginswithQM					:= if(corp2.t2u(business_name)[1] = '?',true,false);
					 //check if there is more than one question mark
					 ismorethan1QM					:= if(stringlib.stringfindcount(business_name,'?')>1,true,false);
					 //remove "<" (less than symbols - hex "x3c") and astericks
					 uc_business_name 			:= if(beginswithQM or ismorethan1QM
																			 ,corp2.t2u(regexreplace('(\\?)*|(\\x3c)*|(\\*){1,}$',business_name,'')) 	//also remove question marks
																			 ,corp2.t2u(regexreplace('(\\x3c)*|(\\*){1,}$',business_name,''))					//do not remove question marks
																			);

					 RETURN Corp2_Mapping.fCleanBusinessName(uc_state_origin,uc_state_desc,uc_business_name).BusinessName;

		END;

		//****************************************************************************
		//CorpLNNameTypeCD: Returns the "corp_ln_name_type_cd".
		//****************************************************************************
		EXPORT CorpLNNameTypeCD(string s, string t='') := FUNCTION
					 uc_s 	:= corp2.t2u(s);
					 uc_t	  := corp2.t2u(stringlib.stringfilter(corp2.t2u(t),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_t = 'TRADEMARK'	 									=> '03',
											uc_t = 'TRADENAME' 										=> '04',
											uc_t = 'SERVICEMARK' 									=> '05',
											uc_s = 'A2' 													=> '01',
											uc_s = 'CA' 													=> '01',
											uc_s = 'C5' 													=> '01',
											uc_s = 'C6' 													=> '01',
											uc_s = 'D1' 													=> '01',
											uc_s = 'D2' 													=> '01',
											uc_s = 'D9' 													=> '01',
											uc_s = 'F1' 													=> '01',
											uc_s = 'F2' 													=> '01',
											uc_s = 'G5'														=> '01',
											uc_s = 'G6'														=> '01',
											uc_s = 'K5' 													=> '01',
											uc_s = 'K6' 													=> '01',
											uc_s = 'L5' 													=> '01',
											uc_s = 'L6' 													=> '01',
											uc_s = 'P1' 													=> '01',
											uc_s = 'Q5' 													=> '01',
											uc_s = 'Q6' 													=> '01',
											uc_s = 'R7' 													=> '01',
											uc_s = 'T8' 													=> '07',
											uc_s = 'X1' 													=> 'X1', //derived
											uc_s = 'X2' 													=> 'X2', //derived
											''
										 );
														 
		END; 	

		//****************************************************************************
		//CorpLNNameTypeDesc: Returns the "corp_ln_name_type_desc".
		//****************************************************************************
		EXPORT CorpLNNameTypeDesc(string s, string t='') := FUNCTION
					 uc_s := corp2.t2u(s);
					 uc_t := corp2.t2u(stringlib.stringfilter(corp2.t2u(t),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_t = 'TRADEMARK'	 									=> 'TRADEMARK',
											uc_t = 'TRADENAME' 										=> 'TRADENAME',
											uc_t = 'SERVICEMARK' 									=> 'SERVICEMARK',
											uc_s = 'A2'														=> 'LEGAL',											
											uc_s = 'CA'														=> 'LEGAL',
											uc_s = 'C5' 													=> 'LEGAL',
											uc_s = 'C6' 													=> 'LEGAL',
											uc_s = 'D1' 													=> 'LEGAL',
											uc_s = 'D2' 													=> 'LEGAL',
											uc_s = 'D9' 													=> 'LEGAL',
											uc_s = 'F1' 													=> 'LEGAL',
											uc_s = 'F2' 													=> 'LEGAL',
											uc_s = 'G5'														=> 'LEGAL',
											uc_s = 'G6'														=> 'LEGAL',
											uc_s = 'K5' 													=> 'LEGAL',
											uc_s = 'K6' 													=> 'LEGAL',
											uc_s = 'L5' 													=> 'LEGAL',
											uc_s = 'L6' 													=> 'LEGAL',
											uc_s = 'P1' 													=> 'LEGAL',
											uc_s = 'Q5' 													=> 'LEGAL',
											uc_s = 'Q6' 													=> 'LEGAL',
											uc_s = 'R7' 													=> 'LEGAL',
											uc_s = 'T8' 													=> 'RESERVED',
											uc_s = 'X1' 													=> 'CROSS REFERENCE NAME', 				//derived
											uc_s = 'X2' 													=> 'SECOND CROSS REFERENCE NAME', //derived
											''
										 );

		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: Returns the "corp_orig_org_structure_desc".
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(string s, string t) := FUNCTION
					 uc_s := corp2.t2u(s);
					 uc_t := corp2.t2u(stringlib.stringfilter(t,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_t = 'DOMESTICLLLP'		=> 'DOMESTIC LLLP',
											uc_t = 'FOREIGNLLLP'   	=> 'FOREIGN LLLP',
											uc_s = 'A2' 						=> 'COOPERATIVE',
											uc_s = 'C5' 						=> 'DOMESTIC LIMITED LIABILITY COMPANY (LLC)',
											uc_s = 'C6' 						=> 'FOREIGN LIMITED LIABILITY COMPANY (LLC)',
											uc_s = 'CA' 						=> 'INDIVIDUAL/REGISTERED CRA',
											uc_s = 'D1' 						=> 'DOMESTIC PROFIT CORPORATION',
											uc_s = 'D2' 						=> 'DOMESTIC NONPROFIT CORPORATION',
											uc_s = 'D9' 						=> 'CORPORATION SOLE',
											uc_s = 'F1' 						=> 'FOREIGN PROFIT CORPORATION',
											uc_s = 'F2' 						=> 'FOREIGN NONPROFIT CORPORATION',
											uc_s = 'G5' 						=> 'GENERAL DOMESTIC PARTNERSHIP',
											uc_s = 'G6' 						=> 'GENERAL FOREIGN PARTNERSHIP',
											uc_s = 'K5' 						=> 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'K6' 						=> 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'L5' 						=> 'DOMESTIC LIMITED PARTNERSHIP',
											uc_s = 'L6' 						=> 'FOREIGN LIMITED PARTNERSHIP',
											uc_s = 'P1' 						=> 'DOMESTIC PROFESSIONAL CORPORATION',
											uc_s = 'Q5' 						=> 'DOMESTIC PROFESSIONAL LLP',
											uc_s = 'Q6' 						=> 'FOREIGN PROFESSIONAL LLP',
											uc_s = 'R7' 						=> '', //known code - set to blank
											uc_s = 'T8' 						=> '', //known code - set to blank
											uc_s = 'ZZ' 						=> '', //known code - set to blank
											''
										 );
		END;

		//****************************************************************************
		//CorpStatusCD: Returns the "corp_status_cd".
		//****************************************************************************
		EXPORT CorpStatusCD(string s) := FUNCTION
					 uc_s := corp2.t2u(s);

					 RETURN map(uc_s = '1' 								=> '1',
											uc_s = '2' 								=> '2',
											uc_s = 'ACTIVE' 					=> 'A',
											uc_s = 'ADM. TERMINATED' 	=> 'V',
											uc_s = 'BOUNCED CHECK' 		=> 'B',
											uc_s = 'CANCELLED' 				=> 'C',
											uc_s = 'CONSOLIDATED' 		=> '6',
											uc_s = 'CONVERTED' 				=> '9',
											uc_s = 'DISSOLVED' 				=> 'D',
											uc_s = 'EXPIRED' 					=> 'E',
											uc_s = 'HELD' 						=> 'H',
											uc_s = 'INV. CANCELLED' 	=> 'X',
											uc_s = 'INV. DISSOLVED' 	=> 'I',
											uc_s = 'INV. REVOKED' 		=> 'R',
											uc_s = 'MERGED' 					=> 'M',
											uc_s = 'NEW' 							=> 'Y',
											uc_s = 'NM. CHG.' 				=> 'N',
											uc_s = 'NULL' 						=> '',
											uc_s = 'PURGED' 					=> 'P',
											uc_s = 'RECORDS FROZEN' 	=> 'F',
											uc_s = 'REVOKED' 					=> '8',
											uc_s = 'SUSPENDED' 				=> 'S',
											uc_s = 'TERMINATED' 			=> 'T',
											uc_s = 'WITHDRAWN' 				=> 'W',
											''
										 );

		END;

		//****************************************************************************
		//CorpStatusDesc: Returns the "corp_status_desc".
		//****************************************************************************
		EXPORT CorpStatusDesc(string s) := FUNCTION
					 uc_s := corp2.t2u(s);

					 RETURN map(uc_s = '1' 								=> 'ANNUAL REPORT 1 YEAR DELINQUENT',
											uc_s = '2' 								=> 'ANNUAL REPORT 2 YEARS DELINQUENT',
											uc_s = 'ACTIVE' 					=> 'ACTIVE',
											uc_s = 'ADM. TERMINATED' 	=> 'ADMINISTRATIVELY TERMINATED',
											uc_s = 'BOUNCED CHECK' 		=> 'CHECK BOUNCED',
											uc_s = 'CANCELLED' 				=> 'CANCELLED',
											uc_s = 'CONSOLIDATED' 		=> 'CONSOLIDATED',
											uc_s = 'CONVERTED' 				=> 'CONVERTED',
											uc_s = 'DISSOLVED' 				=> 'DISSOLVED',
											uc_s = 'EXPIRED' 					=> 'EXPIRED',
											uc_s = 'HELD' 						=> 'HELD',
											uc_s = 'INV. CANCELLED' 	=> 'INVOLUNTARILY CANCELLED',
											uc_s = 'INV. DISSOLVED' 	=> 'INVOLUNTARILY DISSOLVED',
											uc_s = 'INV. REVOKED' 		=> 'INVOLUNTARILY REVOKED',
											uc_s = 'MERGED' 					=> 'MERGED',
											uc_s = 'NEW' 							=> 'NEW',
											uc_s = 'NM. CHG.' 				=> 'NAME CHANGE',
											uc_s = 'NULL' 						=> '',
											uc_s = 'PURGED' 					=> 'PURGED',
											uc_s = 'RECORDS FROZEN' 	=> 'RECORDS FROZEN',
											uc_s = 'REVOKED' 					=> 'REVOKED',
											uc_s = 'SUSPENDED' 				=> 'SUSPENDED',
											uc_s = 'TERMINATED' 			=> 'TERMINATED',
											uc_s = 'WITHDRAWN' 				=> 'WITHDRAWN',
											''
										 );

		END;

		//****************************************************************************
		//StockAddlInfo: Returns the "stock_addl_info".
		//****************************************************************************
		EXPORT StockAddlInfo(string limit1) := FUNCTION

					 PatternInvalidWords1	:= 'HAWAII|HI|NONE|SEE FILE|SEE CERT|VARIOUS SEE|X|';
					 PatternInvalidWords2	:= 'JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC';
					 PatternInvalidWords 	:= PatternInvalidWords1 + PatternInvalidWords2;
					 
					 limit1a := corp2.t2u(limit1);
					 
					 //remove any value that contains no digits, or contains only zeroes
					 limit1b := if(corp2.t2u(stringlib.stringfilterout(limit1a,' 0ABCDEFGHIJKLMNOPQRSTUVWXYZ.,/)(&@'))='','',corp2.t2u(limit1a));

					 //remove any invalid words specified in "PatternInvalidWords"
					 limit1c := if(regexfind(PatternInvalidWords,limit1b,0)<>'','',limit1b);

					 //remove all special characters except for those allowed (except for those shown below)
					 limit1d := stringlib.stringfilter(limit1c,' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,/)(&@'); 
					 
					 //remove "at sign" that appears at the end of limit1
					 limit1e := regexreplace('(\\@)$',corp2.t2u(limit1d),'');
					 
					 //remove "ampersand" that appears at the end of limit1
					 limit1f := regexreplace('(\\&)$',corp2.t2u(limit1e),'');

					 //remove "period" that appears at the end of limit1
					 limit1g := regexreplace('(\\.)$',corp2.t2u(limit1f),'');
					 
					 //remove "/" that appears at the end of limit1
					 limit1h := regexreplace('(\\/)$',corp2.t2u(limit1g),'');
					 
					 //remove "PER" from the beginning of limit1
					 limit1i := regexreplace('^(PER)*',corp2.t2u(limit1h),'');
					 
					 uc_limit:= corp2.t2u(limit1i);
					 
					 RETURN if(uc_limit<>'','STOCK LIMIT COMMON: '+uc_limit,'');

		END;

		//****************************************************************************
		//StockClass: Returns the "stock_class".
		//****************************************************************************
		EXPORT StockClass(string s) := FUNCTION

					 PatternInvalidWords	:= 'CAPITAL|COMMA|ERROR|NONE|SEE FILE';
					 ValidWords						:= 'PREF|COM';

					 //remove "dollar amount" after stock class (e.g. PREFERRED ($100))
					 uc_s1 := corp2.t2u(regexreplace('(\\()+(\\$)+(.)*(\\))+',s,''));
					 
					 //remove special characters as shown below (e.g. COMMON``)
					 uc_s2 := stringlib.stringfilterout(uc_s1,'`"');           
					 
					 //If any word (as indicated in "PatternInvalidWords") exists in the field, 
					 //then blank out the field; it is an invalid stock class (e.g. *ERROR IN ART)
					 uc_s3 := if(regexfind(PatternInvalidWords,uc_s2,0)<>'','',uc_s2);

					 uc_s  := uc_s3;

					 RETURN map(uc_s = 'C' 				=> 'COMMON',
											uc_s = 'CINNIB'   => 'COMMON B',
											uc_s = 'CMMON'		=> 'COMMON',
											uc_s = 'CMOMMON'  => 'COMMON',
											uc_s = 'COMMO'    => 'COMMON',
											uc_s = 'COM,MON'  => 'COMMON',
											uc_s = 'COMM,ON'  => 'COMMON',									
											uc_s = 'COMMLON' 	=> 'COMMON',
											uc_s = 'CONNOM'   => 'COMMON',
											uc_s = 'COMMONM'  => 'COMMON',
											uc_s = 'COMMOMN'  => 'COMMON',
											uc_s = 'COMM LON' => 'COMMON',
											uc_s = 'COMMON0'  => 'COMMON',
											uc_s = 'COMMONA'  => 'COMMON A',
											uc_s = 'COMMONB'  => 'COMMON B',
											uc_s = 'COMMONN'  => 'COMMON',
											uc_s = 'CPMMON'   => 'COMMON',
											uc_s = 'D1'       => '',
											uc_s = 'P' 				=> 'PREFERRED',
											uc_s = 'PREFRRED' => 'PREFERRED',
											uc_s
										 );
										 
		END;

		//****************************************************************************
		//SharesPaidFor: Returns the "stock_number_of_shares_paid_for" or
		//							 "stock_total_value_of_shares_paid_for".
		//Note:  "Stock_number_of_shares_paid_for/stock_total_value_of_shares_paid_for"
		//			 are "integer" values and when the raw data contains the words
		//			 "Million,Billion,Trillion,B,M,T", the value is being converted to
		//       a numeric value.
		//****************************************************************************
		EXPORT SharesPaidFor(string s) := FUNCTION

					 Million							:= 1000000;
					 Billion							:= 1000000000;
					 Trillion							:= 1000000000000;
					 
					 PatternInvalidWords	:= 'COMMON|NIL|NONE|NPV|STOCK';

					 uc_s1	 := corp2.t2u(s);
			
					 //remove any invalid words specified in "PatternInvalidWords"
					 uc_s2 	 := if(regexfind(PatternInvalidWords,uc_s1,0)<>'','',uc_s1);	
			
					 //remove all special characters except for those allowed (periods, commas, dash, and backslash)
					 uc_s3	 := stringlib.stringfilter(uc_s2,' BILMNORT0123456789.-/'); 

					 //any value that contains only numbers and the letter "O", replace the "O" with zeroes (e.g. 1OO should be 100)
					 uc_s4	 := if(length(stringlib.stringfilter(uc_s3,'O0123456789.,'))=length(uc_s3),regexreplace('O',uc_s3,'0'),uc_s3);

					 //remove any periods that appear at the end of the value e.g. 2000.
					 uc_s5   := regexreplace(('(\\.)*$'),uc_s4,'');

					 //check if a decimal point exists and replace with a "pipe" for splitwords FUNCTION
					 uc_s6 	 := stringlib.splitwords(regexreplace('\\.',uc_s5,'|'),'|',true);
					 
					 //if a "real" value only keep significant digits (left of decimal point)
					 uc_s		 := corp2.t2u(uc_s6[1]);

					 RETURN map(regexfind('BILLION',uc_s,0)  <> ''											=> (integer)uc_s*Billion, 	 	 //need integer value
											regexfind('MILLION',uc_s,0)  <> ''											=> (integer)uc_s*Million,		 	 //need integer value
											regexfind('TRILLION',uc_s,0) <> ''											=> (integer)uc_s*Trillion,	 	 //need integer value
											regexfind('(^([0-9]{1,})(B)+)$',uc_s,0) <> ''						=> (integer)uc_s*Billion,	 		 //need integer value 
											regexfind('(^([0-9]{1,})(M)+)$',uc_s,0) <> ''						=> (integer)uc_s*Million,	 		 //need integer value
											regexfind('(^([0-9]{1,})(T)+)$',uc_s,0) <> ''						=> (integer)uc_s*Trillion,	 	 //need integer value
											regexfind('[^[:digit:]]',uc_s,0) <> '' 									=> 0,													 //values with non-digits
											(integer)uc_s
										 );

		END;

		//****************************************************************************
		//StockParValue: Returns the "stock_par_value".
		//****************************************************************************
		EXPORT StockParValue(string s) := FUNCTION
					 PatternInvalidWords	:= 'FILE';

					 uc_s1	 := corp2.t2u(s);

					 //remove all dashes
					 uc_s2	 := stringlib.stringfilterout(uc_s1,'-');

					 //any value that contains only numbers and the letter "O", replace the "O" with zeroes (e.g. 1OO should be 100)
					 uc_s3	 := if(length(stringlib.stringfilter(uc_s2,'$O0123456789.,'))=length(uc_s2),regexreplace('O',uc_s2,'0'),uc_s2);

					 //remove any invalid words specified in "PatternInvalidWords"
					 uc_s4 	 := if(regexfind(PatternInvalidWords,uc_s3,0)<>'','',uc_s3);
					 
					 uc_s5  	 := regexreplace(('(\\/)*$'),uc_s4,'');				//remove any "/" that appears at the end of the value (e.g. 1/)
					 uc_s6  	 := regexreplace(('(D)*(\\.)*$'),uc_s5,'');		//remove any "D" that appears at the end of the value (e.g. 1D)
					 uc_s7  	 := regexreplace(('(L)*(\\.)*$'),uc_s6,'');		//remove any "L" that appears at the end of the value (e.g. L)
					 uc_s8  	 := regexreplace(('(X)*(\\.)*$'),uc_s7,'');		//remove any "X" that appears at the end of the value (e.g. 1X)
					 uc_s9  	 := regexreplace(('(\\.)*$'),uc_s8,'');				//remove any periods that appears at the end of the value (e.g. 20.)
					 
					 uc_s	  	 := corp2.t2u(uc_s9);

					 RETURN map(stringlib.stringfilter(uc_s,'-0') in ['0','-0-']				=> '',
											regexfind('NPV',uc_s,0)  		 <> ''											=> 'NPV',
											regexfind('NP',uc_s,0)			 <> ''											=> 'NPV',
											regexfind('NVD',uc_s,0)  		 <> ''											=> 'NVD',
											regexfind('NVP',uc_s,0)  		 <> ''											=> 'NPV',
											regexfind('NV',uc_s,0)  		 <> ''											=> 'NVP',
											regexfind('CAV',uc_s,0)  		 <> ''											=> 'CAV',
											regexfind('CA',uc_s,0)       <> ''											=> 'CAV',
											uc_s
										 );

		END;

		//****************************************************************************
		//StockSharesIssued: Returns the "stock_shares_issued".
		//****************************************************************************
		EXPORT StockSharesIssued(string s) := FUNCTION
					 PatternInvalidWords	:= 'ELIMINATED|VARIOUS|SEE|FILE|STOCK';

					 //remove any value that contains a '/'
					 uc_s1	 := if(regexfind('///',corp2.t2u(s),0)<>'','',corp2.t2u(s));
					 
					 //remove all special characters except for those allowed (periods, commas, dash)
					 uc_s2	 := stringlib.stringfilter(uc_s1,' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,-');

					 //any value that contains only numbers and the letter "O", replace the "O" with zeroes (e.g. 1OO should be 100)
					 uc_s3	 := if(length(stringlib.stringfilter(uc_s2,'O0123456789.,'))=length(uc_s2),regexreplace('O',uc_s2,'0'),uc_s2);

					 //remove any invalid words specified in "PatternInvalidWords"
					 uc_s4 	 := if(regexfind(PatternInvalidWords,uc_s3,0)<>'','',uc_s3);

					 //remove any periods that appear at the end of the value e.g. 2000.
					 uc_s5  	 := regexreplace(('(\\.)*$'),uc_s4,'');
					 
					 //remove any "R" or "-R" that appear at the end of the value e.g. 150,000-R      
					 uc_s6 	 := regexreplace(('((\\-)*R)*$'),uc_s5,'');

					 //remove any single character (except for B,M,N,T) that appears at the end of the value (e.g. 2000X)
					 uc_s7 	 := regexreplace(('(([A_C-L_O-S_U-Z])?)$'),uc_s6,'');
					 
					 uc_s		 := corp2.t2u(uc_s7);
					 
					 RETURN map(corp2.t2u(uc_s) in ['0','-0-']										=> '',
											regexfind('BILLION',uc_s,0)  <> ''											=> stringlib.stringfilterout(uc_s,','), //to allow for BILLION
											regexfind('MILLION',uc_s,0)  <> ''											=> stringlib.stringfilterout(uc_s,','),	//to allow for MILLION
											regexfind('TRILLION',uc_s,0) <> ''											=> stringlib.stringfilterout(uc_s,','),	//to allow for TRILLION
											regexfind('(^([0-9]{1,})(B)*(M)*(T)*)$',uc_s,0) <> ''		=> uc_s, 																//to allow for 1B, 1M, 1T, etc.
											regexfind('[^[:digit:](\\,)*(\\.)*]',uc_s,0) <> '' 			=> '',																	//values with non-digits or commas or periods are blanked out	
											uc_s
										 );
		END;

		//****************************************************************************
		//StockTotalCapital: Returns the "stock_total_capital".
		//Note: \054 is a ","
		//			\056 is a "."
		//****************************************************************************
		EXPORT StockTotalCapital(string s) := FUNCTION
			
			fGetPattern(string pInp,boolean pAllowCommas = true) := function
						AllowDigitsCommas	 			 := '[^[:digit:]\054]';
						AllowDigitsCommasPeriods := '[^[:digit:]\054\056e]';
						isWholeNumber						 := if(stringlib.stringfind(corp2.t2u(pinp),'.',1) = length(corp2.t2u(pInp)),true,false);
						return if(isWholeNumber,AllowDigitsCommas,AllowDigitsCommasPeriods);
			end;
			
			stocktotalcapital := regexreplace(fGetPattern(s),s,'');
			
			RETURN if(stocktotalcapital = '0','',corp2.t2u(stocktotalcapital));
				
		END;

		//****************************************************************************
		//TitleLookupTable: Returns the "cont_title1_desc".
		//****************************************************************************
		EXPORT TitleLookupTable(string s) := FUNCTION

		  uc_s 		:= corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-'));
						 
			RETURN map(	uc_s = '1AVP' 			=> 		'1ST ASSISTANT VICE-PRESIDENT',
									uc_s = '1CHP' 			=> 		'1ST CHAIRMAN/CHAIRPERSON',
									uc_s = '1EV' 				=> 		'1ST EXECUTIVE VICE-PRESIDENT',
									uc_s = '1RR' 				=> 		'1ST READER',
									uc_s = '1S' 				=> 		'1ST SECRETARY',
									uc_s = '1STVP' 			=> 		'1ST VICE PRESIDENT',									
									uc_s = '1T' 				=> 		'1ST TREASURER',
									uc_s = '1V' 				=> 		'1ST VICE PRESIDENT',
									uc_s = '1VC' 				=> 		'1ST VICE CHAIRMAN',
									uc_s = '1VCB' 			=> 		'1ST VICE CHAIRMAN OF THE BOARD',
									uc_s = '1VP' 				=> 		'1ST VICE PRESIDENT',									
									uc_s = '1VRG' 			=> 		'1ST VICE REGENT',
									uc_s = '2AVP' 			=> 		'2ND ASSISTANT VICE-PRESIDENT',
									uc_s = '2CHP' 			=> 		'2ND CHAIRMAN/CHAIRPERSON',
									uc_s = '2EV' 				=> 		'2ND EXECUTIVE VICE-PRESIDENT',
									uc_s = '2NDVP'			=> 		'2ND VICE PRESIDENT',									
									uc_s = '2RR' 				=> 		'2ND READER',
									uc_s = '2S' 				=> 		'2ND SECRETARY',
									uc_s = '2T' 				=> 		'2ND TREASURER',
									uc_s = '2V' 				=> 		'2ND VICE PRESIDENT',
									uc_s = '2VC' 				=> 		'2ND VICE CHAIRMAN',
									uc_s = '2VCB' 			=> 		'2ND VICE CHAIRMAN OF THE BOARD',
									uc_s = '2VP' 				=> 		'2ND VICE PRESIDENT',									
									uc_s = '2VRG' 			=> 		'2ND VICE REGENT',
									uc_s = '3AVP' 			=> 		'3RD ASSISTANT VICE-PRESIDENT',
									uc_s = '3CHP' 			=> 		'3RD CHAIRMAN/CHAIRPERSON',
									uc_s = '3EV' 				=> 		'3RD EXECUTIVE VICE-PRESIDENT',
									uc_s = '3RR' 				=> 		'3RD READER',
									uc_s = '3S' 				=> 		'3RD SECRETARY',
									uc_s = '3T' 				=> 		'3RD TREASURER',
									uc_s = '3V' 				=> 		'3RD VICE PRESIDENT',										 									
									uc_s = '3VC' 				=> 		'3RD VICE CHAIRMAN',
									uc_s = '3VCB' 			=> 		'3RD VICE CHAIRMAN OF THE BOARD',
									uc_s = '3VP'				=> 		'3RD VICE PRESIDENT',										 
									uc_s = '3VRG' 			=> 		'3RD VICE REGENT',
									uc_s = '4AVP' 			=> 		'4TH ASSISTANT VICE-PRESIDENT',
									uc_s = '4CHP' 			=> 		'4TH CHAIRMAN/CHAIRPERSON',
									uc_s = '4EV' 				=> 		'4TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '4RR'	 			=> 		'4TH READER',
									uc_s = '4S' 				=> 		'4TH SECRETARY',
									uc_s = '4T' 				=> 		'4TH TREASURER',
									uc_s = '4V' 				=> 		'4TH VICE PRESIDENT',
									uc_s = '4VC' 				=> 		'4TH VICE CHAIRMAN',
									uc_s = '4VCB' 			=> 		'4TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '4VRG' 			=> 		'4TH VICE REGENT',
									uc_s = '5AVP' 			=> 		'5TH ASSISTANT VICE-PRESIDENT',
									uc_s = '5CHP' 			=> 		'5TH CHAIRMAN/CHAIRPERSON',
									uc_s = '5EV' 				=> 		'5TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '5RR' 				=> 		'5TH READER',
									uc_s = '5S' 				=> 		'5TH SECRETARY',
									uc_s = '5T' 				=> 		'5TH TREASURER',
									uc_s = '5VC' 				=> 		'5TH VICE CHAIRMAN',
									uc_s = '5VCB' 			=> 		'5TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '5VRG' 			=> 		'5TH VICE REGENT',
									uc_s = '6AVP' 			=> 		'6TH ASSISTANT VICE-PRESIDENT',
									uc_s = '6CHP' 			=> 		'6TH CHAIRMAN/CHAIRPERSON',
									uc_s = '6EV' 				=> 		'6TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '6RR' 				=> 		'6TH READER',
									uc_s = '6S' 				=> 		'6TH SECRETARY',
									uc_s = '6T' 				=> 		'6TH TREASURER',
									uc_s = '6VC' 				=> 		'6TH VICE CHAIRMAN',
									uc_s = '6VCB' 			=> 		'6TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '6VRG' 			=> 		'6TH VICE REGENT',
									uc_s = '7AVP' 			=> 		'7TH ASSISTANT VICE-PRESIDENT',
									uc_s = '7CHP' 			=> 		'7TH CHAIRMAN/CHAIRPERSON',
									uc_s = '7EV' 				=> 		'7TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '7RR' 				=> 		'7TH READER',
									uc_s = '7S' 				=> 		'7TH SECRETARY',
									uc_s = '7T' 				=> 		'7TH TREASURER',
									uc_s = '7VC' 				=> 		'7TH VICE CHAIRMAN',
									uc_s = '7VCB' 			=> 		'7TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '7VRG' 			=> 		'7TH VICE REGENT',
									uc_s = '8AVP' 			=> 		'8TH ASSISTANT VICE-PRESIDENT',
									uc_s = '8CHP' 			=> 		'8TH CHAIRMAN/CHAIRPERSON',
									uc_s = '8D'					=> 		'8TH DIRECTOR',
									uc_s = '8EV' 				=> 		'8TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '8G'					=> 		'8G',
									uc_s = '8RR' 				=> 		'8TH READER',
									uc_s = '8S' 				=> 		'8TH SECRETARY',
									uc_s = '8T' 				=> 		'8TH TREASURER',
									uc_s = '8V'	 				=> 		'8TH VICE PRESIDENT',
									uc_s = '8VC' 				=> 		'8TH VICE CHAIRMAN',
									uc_s = '8VCB' 			=> 		'8TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '8VP' 				=> 		'8TH VICE PRESIDENT',
									uc_s = '8VRG' 			=> 		'8TH VICE REGENT',
									uc_s = '9AVP' 			=> 		'9TH ASSISTANT VICE-PRESIDENT',
									uc_s = '9CHP' 			=> 		'9TH CHAIRMMAN/CHAIRPERSON',
									uc_s = '9EV' 				=> 		'9TH EXECUTIVE VICE-PRESIDENT',
									uc_s = '9RR' 				=> 		'9TH READER',
									uc_s = '9S' 				=> 		'9TH SECRETARY',
									uc_s = '9T' 				=> 		'9TH TREASURER',
									uc_s = '9VC' 				=> 		'9TH VICE CHAIRMAN',
									uc_s = '9VCB' 			=> 		'9TH VICE CHAIRMAN OF THE BOARD',
									uc_s = '9VRG' 			=> 		'9TH VICE REGENT',
									uc_s = 'A' 					=> 		'ACTUARY',
									uc_s = 'AA' 				=> 		'ASSISTANT ADMINISTRATOR/ADMINISTRATIVE ASSISTANT',
									uc_s = 'AAG' 				=> 		'ASSISTANT ATTORNEY GENERAL',
									uc_s = 'AAGC' 			=> 		'ADMINISTRATIVE ASSISTANT TO THE GENERAL COUNSEL',
									uc_s = 'AAU' 				=> 		'ASSISTANT AUDITOR',
									uc_s = 'AB' 				=> 		'ARCHBISHOP',
									uc_s = 'ABSO' 			=> 		'ASSISTANT BANK SECRETARY OFFICER',
									uc_s = 'AC' 				=> 		'ASSISTANT COMPTROLLER/CONTROLLER',
									uc_s = 'ACC' 				=> 		'ASSISTANT CORPORATE COMPTROLLER/CONTROLLER',
									uc_s = 'ACCEO' 			=> 		'ACTING CHIEF EXECUTIVE OFFICER',
									uc_s = 'ACCH' 			=> 		'ACADEMY CHAIRMAN',
									uc_s = 'ACD' 				=> 		'ASSOCIATE CREATIVE DIRECTOR',
									uc_s = 'ACEO' 			=> 		'ASSISTANT CHIEF EXECUTIVE OFFICER',
									uc_s = 'ACFO' 			=> 		'ASSISTANT CHIEF FINANCIAL OFFICER',
									uc_s = 'ACH' 				=> 		'ACTING CHAIRMAN/PERSON',
									uc_s = 'ACL' 				=> 		'ASSISTANT CLERK',
									uc_s = 'ACM' 				=> 		'ACCOUNTING MANAGER',
									uc_s = 'ACN' 				=> 		'ASSISTANT COUNSEL',
									uc_s = 'ACO' 				=> 		'ASSISTANT COMPLIANCE OFFICER',
									uc_s = 'ACOP' 			=> 		'ASSISTANT CHIEF OPERATING OFFICER',
									uc_s = 'ACOR' 			=> 		'ACTIVITY COORDINATOR',
									uc_s = 'ACOS' 			=> 		'ASSISTANT CORRESPONDING SECRETARY',
									uc_s = 'ACS' 				=> 		'ASSISTANT CORPORATE SECRETARY',
									uc_s = 'ACSO' 			=> 		'ASSOCIATE CLIENT SERVICE OFFICER',
									uc_s = 'ACSV' 			=> 		'ACCOUNT SERVICE',
									uc_s = 'AD' 				=> 		'ASSISTANT DIRECTOR',
									uc_s = 'ADCH' 			=> 		'ADMINISTRATIVE CHAIRMAN',
									uc_s = 'ADD' 				=> 		'ADMINISTRATIVE DIRECTOR',
									uc_s = 'ADEDT' 			=> 		'ADMINISTRATIVE EDITOR',
									uc_s = 'ADIR' 			=> 		'ADVISORY DIRECTOR',
									uc_s = 'ADJ' 				=> 		'ADJUTANT',
									uc_s = 'ADO' 				=> 		'ADMINISTRATIVE OFFICER',
									uc_s = 'ADR' 				=> 		'ADMINISTRATOR',
									uc_s = 'ADS' 				=> 		'ADVISOR',
									uc_s = 'ADV' 				=> 		'ADMINISTRATIVE VICE-PRESIDENT',
									uc_s = 'AED' 				=> 		'ASSISTANT EXECUTIVE DIRECTOR',
									uc_s = 'AES' 				=> 		'ASSISTANT EXECUTIVE SECRETARY',
									uc_s = 'AFO' 				=> 		'ASSISTANT FINANCIAL OFFICER',
									uc_s = 'AGC' 				=> 		'ASSISTANT GENERAL COUNSEL',
									uc_s = 'AGCO' 			=> 		'ASSISTANT GENERAL COMPTROLLER/CONTROLLER',
									uc_s = 'AGM' 				=> 		'ASSISTANT GENERAL MANAGER',
									uc_s = 'AGT' 				=> 		'AGENT',
									uc_s = 'AGTC' 			=> 		'ASSISTANT GENERAL TAX COUNSEL',
									uc_s = 'ALTCMR' 		=> 		'ALTERNATE EXECUTIVE COMMANDER',
									uc_s = 'ALTCS' 			=> 		'ALTERNATE CORPORATE SECRETARY',
									uc_s = 'ALTD' 			=> 		'ALTERNATE DIRECTOR',
									uc_s = 'ALTP' 			=> 		'ALTERNATE PRESIDENT',
									uc_s = 'AM' 				=> 		'ASSISTANT MANAGER',
									uc_s = 'AMC' 				=> 		'ANNUAL MEETINGS COORDINATOR',
									uc_s = 'AMCN' 			=> 		'ADMINISTRATIVE COUNCIL',
									uc_s = 'AMS' 				=> 		'ADMINISTRATIVE SECRETARY',
									uc_s = 'AO' 				=> 		'ACCOUNTING OFFICER',
									uc_s = 'AP' 				=> 		'ACTING PRESIDENT',
									uc_s = 'APS' 				=> 		'ASSISTANT PASTOR',
									uc_s = 'AR' 				=> 		'AUTHORIZED REPRESENTATIVE',
									uc_s = 'ARCO' 			=> 		'ARCHITECTURAL OFFICER',
									uc_s = 'ARED' 			=> 		'ASSISTANT REGIONAL EXECUTIVE DIRECTOR',
									uc_s = 'ARM' 				=> 		'ASSOCIATE REGIONAL MANAGER',
									uc_s = 'ARS' 				=> 		'ASSISTANT RECORDING SECRETARY',
									uc_s = 'ARV' 				=> 		'AREA VICE-PRESIDENT',
									uc_s = 'AS'	 				=> 		'ASSISTANT SECRETARY',
									uc_s = 'ASA' 				=> 		'ASSET ADMINISTRATOR',
									uc_s = 'ASC' 				=> 		'ASSOCIATE COUNSEL',
									uc_s = 'ASCH' 			=> 		'ASSISTANT CHAIRMAN/ASSISTANT TO THE CHAIRMAN',
									uc_s = 'ASD' 				=> 		'ASSOCIATE DIRECTOR',
									uc_s = 'ASDE' 			=> 		'ASSOCIATE DEAN',
									uc_s = 'ASGC' 			=> 		'ASSOCIATE GENERAL COUNSEL',
									uc_s = 'ASP' 				=> 		'ASSISTANT TO THE PRESIDENT',
									uc_s = 'ASPA' 			=> 		'ASSOCIATE PASTOR',
									uc_s = 'ASPT' 			=> 		'ASSISTANT SUPERINTENDENT',
									uc_s = 'ASPV' 			=> 		'ASSOCIATE PROVOST',
									uc_s = 'ASR' 				=> 		'ASSIGNOR',
									uc_s = 'ASVP' 			=> 		'ASSOCIATE VICE-PRESIDENT',
									uc_s = 'AT' 				=> 		'ASSISTANT TREASURER',
									uc_s = 'ATGC' 			=> 		'ACTING GENERAL COUNSEL',
									uc_s = 'ATO' 				=> 		'ASSISTANT TRUST OFFICER',
									uc_s = 'ATR' 				=> 		'ACTING TREASURER',
									uc_s = 'ATS' 				=> 		'ACTING SECRETARY',
									uc_s = 'ATTSE' 			=> 		'ATTESTING SECRETARY',
									uc_s = 'ATTY' 			=> 		'ATTORNEY',
									uc_s = 'ATXO'				=> 		'ASSISTANT TAX OFFICER',
									uc_s = 'AU' 				=> 		'AUDITOR',
									uc_s = 'AUCD' 			=> 		'AUCD',
									uc_s = 'AUD' 				=> 		'AUTHORIZED DIRECTOR',
									uc_s = 'AV' 				=> 		'ACTING VICE-PRESIDENT',
									uc_s = 'AVC' 				=> 		'ASSISTANT VICE CHAIRMAN',
									uc_s = 'AVP' 				=> 		'ASSISTANT VICE-PRESIDENT',																
									uc_s = 'AVT' 				=> 		'ASSISTANT VICE TREASURER',
									uc_s = 'AXTR' 			=> 		'AUXILIARY TRUSTEE',
									uc_s = 'B' 					=> 		'BROKER',
									uc_s = 'BCH' 				=> 		'BOARD CHAIRMAN',
									uc_s = 'BD' 				=> 		'BD',
									uc_s = 'BEX' 				=> 		'BEX',
									uc_s = 'BGM' 				=> 		'BUILDING & GROUNDS MEMBER',
									uc_s = 'BK' 				=> 		'BOOKKEEPER',
									uc_s = 'BM' 				=> 		'BOARD MEMBER',
									uc_s = 'BMA' 				=> 		'BUSINESS MANAGER',
									uc_s = 'BO' 				=> 		'BENEFIT OFFICER',
									uc_s = 'BOD' 				=> 		'BOARD OF DIRECTORS',
									uc_s = 'BOF' 				=> 		'BANKING OFFICER',
									uc_s = 'BOG' 				=> 		'BOARD OF GOVERNOR',
									uc_s = 'BOM' 				=> 		'BOARD OF MANAGEMENT',
									uc_s = 'BP' 				=> 		'BUSINESS PRESIDENT',
									uc_s = 'BRM' 				=> 		'BRANCH',
									uc_s = 'BRMM' 			=> 		'BRANCH MANAGER',
									uc_s = 'BRP'	 			=> 		'BROADCAST PRODUCTION',
									uc_s = 'BS' 				=> 		'BISHOP',
									uc_s = 'BSC' 				=> 		'BOARD SECRETARY',
									uc_s = 'C' 					=> 		'CHAIRMAN/WOMAN OF THE BOARD',
									uc_s = 'CA' 				=> 		'CHIEF ACTUARY',
									uc_s = 'CAA' 				=> 		'CORPORATE AFFAIRS ASSISTANT',
									uc_s = 'CAD' 				=> 		'CHURCH ADMINISTRATOR',
									uc_s = 'CADO' 			=> 		'CHIEF ADMINISTRATIVE OFFICER',
									uc_s = 'CAFO' 			=> 		'CHIEF ADMINISTRATIVE & FINANCIAL OFFICER',
									uc_s = 'CAO' 				=> 		'CHIEF ACCOUNTING OFFICER',
									uc_s = 'CAP' 				=> 		'CAP',
									uc_s = 'CAPC' 			=> 		'CAMPAIGN CHAIRMAN',
									uc_s = 'CAPV' 			=> 		'CAMPAIGN VICE CHAIRMAN',
									uc_s = 'CAS' 				=> 		'CORPORATE AFFAIRS SECRETARY',
									uc_s = 'CB' 				=> 		'CORPORATE BROKER',
									uc_s = 'CC' 				=> 		'CORPORATE COMPTROLLER/CONTROLLER',
									uc_s = 'CCB' 				=> 		'CO-CHAIRMAN OF THE BOARD',
									uc_s = 'CCC' 				=> 		'CHIEF CORPORATE COUNSEL',
									uc_s = 'CCEO' 			=> 		'CO-CHIEF EXECUTIVE OFFICER',
									uc_s = 'CCHEO' 			=> 		'CO-CHAIRMAN EXECUTIVE OFFICER',
									uc_s = 'CCLO' 			=> 		'CHIEF CLINICAL OFFICER',
									uc_s = 'CCN' 				=> 		'CORPORATE COUNSEL',
									uc_s = 'CCO' 				=> 		'CHIEF COMPLIANCE OFFICER',
									uc_s = 'CVCB'				=> 		'CO-VICE CHAIRMAN OF THE BOARD',
									uc_s = 'CCOF' 			=> 		'CORPORATE CREDIT OFFICER',
									uc_s = 'CCOO' 			=> 		'CCOO',									
									uc_s = 'CCOP' 			=> 		'CO-CHIEF OPERATING OFFICER',
									uc_s = 'CCOR' 			=> 		'CHIEF COORDINATOR',
									uc_s = 'CCRO' 			=> 		'CHIEF CREDIT OFFICER',
									uc_s = 'CCSO' 			=> 		'CHIEF CORPORATE STAFF OFFICER',
									uc_s = 'CD' 				=> 		'CHAIRMAN OF THE DIRECTORS',
									uc_s = 'CDE' 				=> 		'CHAIRMAN OF THE DEACONS',
									uc_s = 'CDL' 				=> 		'CHIEF DELEGATE',
									uc_s = 'CDM' 				=> 		'CORPORATE DEVELOPMENT MANAGER',
									uc_s = 'CDO' 				=> 		'CDO',
									uc_s = 'CDR' 				=> 		'CHIEF DIRECTOR',
									uc_s = 'CDT' 				=> 		'CORPORATE DIRECTOR OF TAXES',
									uc_s = 'CE' 				=> 		'CHIEF ECONOMIST',
									uc_s = 'CEC' 				=> 		'CHAIRMAN OF THE EXECUTIVE',
									uc_s = 'CED' 				=> 		'CHRIST EDUCATION',
									uc_s = 'CEL' 				=> 		'CHAIRMAN ELECT',
									uc_s = 'CEN' 				=> 		'CHIEF ENGINEER',
									uc_s = 'CEO' 				=> 		'CHIEF EXECUTIVE OFFICER',
									uc_s = 'CEOP' 			=> 		'CEOP',
									uc_s = 'CEOR' 			=> 		'CHIEF EXECUTIVE COORDINATOR',
									uc_s = 'CEOT' 			=> 		'CEOT',
									uc_s = 'CEP' 				=> 		'CEP',
									uc_s = 'CES' 				=> 		'CHIEF ESTIMATOR',
									uc_s = 'CEXC' 			=> 		'CHAIRMAN OF EXECUTIVE COMMITTEE',
									uc_s = 'CFADO'	 		=> 		'CHIEF FINANCIAL ADMINISTRATIVE OFFICER',
									uc_s = 'CFC' 				=> 		'CHIEF COACH',
									uc_s = 'CFD' 				=> 		'CFD',
									uc_s = 'CFL' 				=> 		'CHIEF LENDING OFFICER',
									uc_s = 'CFO' 				=> 		'CHIEF FINANCIAL OFFICER',
									uc_s = 'CFN' 				=> 		'CFN',
									uc_s = 'CFR' 				=> 		'CHIEF REFEREE',
									uc_s = 'CFRA' 			=> 		'CHIEF FINANCIAL REPORTING & ANALYSIS',
									uc_s = 'CFT' 				=> 		'CFT',
									uc_s = 'CGC' 				=> 		'CHIEF GROUP COUNSEL',
									uc_s = 'CH' 				=> 		'CHAIRMAN',
									uc_s = 'CHA' 				=> 		'CHIEF APPRAISER',
									uc_s = 'CHAP' 			=> 		'CHAPLAIN',
									uc_s = 'CHC' 				=> 		'CHURCH COUNCIL',
									uc_s = 'CHCN' 			=> 		'CHIEF COUNCIL',
									uc_s = 'CHD' 				=> 		'CHD',
									uc_s = 'CHE' 				=> 		'CHRISTIAN EDUCATOR',
									uc_s = 'CHEM' 			=> 		'CHAIRMAN EMERITUS',
									uc_s = 'CHF' 				=> 		'CHIEF',
									uc_s = 'CHJ' 				=> 		'CHIEF JUSTICE',
									uc_s = 'CHMO' 			=> 		'CHIEF MEDICAL OFFICER',
									uc_s = 'CHN' 				=> 		'CHANCELLOR',
									uc_s = 'CHO' 				=> 		'CHIEF CLAIMS OFFICER',
									uc_s = 'CHP' 				=> 		'CHIEF PRIEST',
									uc_s = 'CHPB' 			=> 		'CHAIRPERSON OF THE BOARD',
									uc_s = 'CHPO' 			=> 		'CHIEF PURCHASING OFFICER',
									uc_s = 'CHR' 				=> 		'CHAIRMAN OF THE BOARD OF TRUSTEES',
									uc_s = 'CHR' 				=> 		'CHAIRMAN OF THE BOARD OF TRUSTEES/CHIEF RESEARCHER',
									uc_s = 'CHRCO' 			=> 		'CHIEF HUMAN RESOURCES COMMUNICATION OFFICER',
									uc_s = 'CHS' 				=> 		'CHIEF SCIENTIST',
									uc_s = 'CHSO' 			=> 		'CHIEF SCIENTIFIC OFFICER',
									uc_s = 'CHTO' 			=> 		'CHIEF TECHNOLOGY OFFICER',
									uc_s = 'CIN' 				=> 		'CHIEF INFORMATION OFFICER',
									uc_s = 'CINO' 			=> 		'CHIEF INTERNATIONAL OFFICER',
									uc_s = 'CIO' 				=> 		'CHIEF INVESTMENT OFFICER',
									uc_s = 'CISO' 			=> 		'CHIEF INFORMATION SYSTEMS OFFICER',
									uc_s = 'CL' 				=> 		'CLERK',
									uc_s = 'CLC' 				=> 		'CHIEF LEGAL COUNSEL',
									uc_s = 'CLO' 				=> 		'CHIEF LEGAL OFFICER',
									uc_s = 'CLP' 				=> 		'CHIEF LOAN POLICY OFFICER',
									uc_s = 'CM' 				=> 		'CM',
									uc_s = 'CMD' 				=> 		'CHIEF MEDICAL DIRECTOR',
									uc_s = 'CMDR'				=> 		'CHIEF MEDICAL DIRECTOR',
									uc_s = 'CMLO' 			=> 		'COMMUNITY LIAISON OFFICER',
									uc_s = 'CMM' 				=> 		'COMMODORE',
									uc_s = 'CMO' 				=> 		'CHIEF MARKETING OFFICER',
									uc_s = 'CMOS' 			=> 		'COMMANDER OF SAILS',
									uc_s = 'CMPO' 			=> 		'COMPLIANCE OFFICER',
									uc_s = 'CMR' 				=> 		'COMMANDER',
									uc_s = 'CMT' 				=> 		'COMMANDANT',
									uc_s = 'CN' 				=> 		'COUNSEL',
									uc_s = 'CNC' 				=> 		'COUNCIL CHAIRMAN',
									uc_s = 'CNE' 				=> 		'CNE',
									uc_s = 'CNM' 				=> 		'COUNCIL MEMBER',
									uc_s = 'CNS' 				=> 		'COUNCIL SECRETARY',
									uc_s = 'CNT' 				=> 		'COUNCIL TREASURER',
									uc_s = 'CO' 				=> 		'COMPTROLLER/CONTROLLER',
									uc_s = 'COA' 				=> 		'CORPORATE ACTUARY',
									uc_s = 'COB' 				=> 		'CHAIRMAN OF THE BOARD',
									uc_s = 'COC' 				=> 		'CO-CHAIRMAN',
									uc_s = 'CO-COO'			=> 		'CO-CHAIRMAN OPERATING OFFICER',
									uc_s = 'CO-FN' 			=> 		'COMPTROLLER-FOUNDER',
									uc_s = 'COD' 				=> 		'CO-DIRECTOR',
									uc_s = 'COMDR' 			=> 		'CO-MODERATOR',
									uc_s = 'COMM' 			=> 		'COMM',
									uc_s = 'CON' 				=> 		'CON',
									uc_s = 'CONS' 			=> 		'CONSULTANT',
									uc_s = 'COO' 				=> 		'CHAIRMAN OPERATING OFFICER',
									uc_s = 'COP' 				=> 		'CHIEF OPERATION OFFICER',
									uc_s = 'COR' 				=> 		'COORDINATOR',
									uc_s = 'COS' 				=> 		'CORRESPONDING SECRETARY',
									uc_s = 'COT' 				=> 		'CHAIRMAN OF TRUSTEES',
									uc_s = 'COV' 				=> 		'CONVEYOR',
									uc_s = 'CP' 				=> 		'CO-PRESIDENT',
									uc_s = 'CPC' 				=> 		'CHIEF PATENT COUNSEL',
									uc_s = 'CPO' 				=> 		'CHIEF PERSONNEL OFFICER',
									uc_s = 'CPS' 				=> 		'CORPORATION SOLE',
									uc_s = 'CQO' 				=> 		'CHIEF QUALITY OFFICER',
									uc_s = 'CR' 				=> 		'CHIEF RANGER',
									uc_s = 'CRE' 				=> 		'CHIEF REVENUE OFFICER',
									uc_s = 'CRO' 				=> 		'CREDIT OFFICER',
									uc_s = 'CROP' 			=> 		'COMPLIANCE REGISTERED OPTIONS PRINCIPAL',
									uc_s = 'CRT' 				=> 		'CREATIVE',
									uc_s = 'CS' 				=> 		'CORPORATE SECRETARY',
									uc_s = 'CSD' 				=> 		'CORPORATE SERVICES DIRECTOR',
									uc_s = 'CSH' 				=> 		'CASHIER',
									uc_s = 'CSO' 				=> 		'CHIEF SERVICES OFFICER',
									uc_s = 'CST' 				=> 		'CHIEF STRATEGIC OFFICER',
									uc_s = 'CT' 				=> 		'CORPORATE TREASURER',
									uc_s = 'CTA' 				=> 		'CHIEF TAX ATTORNEY',
									uc_s = 'CTC' 				=> 		'CORPORATE TAX COUNSEL',
									uc_s = 'CTO' 				=> 		'CHIEF TAX OFFICER',
									uc_s = 'CTQ' 				=> 		'CORPORATE TOTAL QUALITY COORDINATOR',
									uc_s = 'CTR' 				=> 		'CO-TRUSTEE',
									uc_s = 'CTSO' 			=> 		'CLIENT SERVICE OFFICER',
									uc_s = 'CU' 				=> 		'CHIEF UNDERWRITER',
									uc_s = 'CUO' 				=> 		'CUO',
									uc_s = 'CVC' 				=> 		'CO-VICE CHAIRPERSON',
									uc_s = 'CVCB'				=> 		'CO-VICE CHAIRMAN OF THE BOARD',
									uc_s = 'CVP' 				=> 		'CORPORATE VICE-PRESIDENT',
									uc_s = 'D' 					=> 		'DIRECTOR',
									uc_s = 'DA' 				=> 		'DIRECTOR OF ADMINISTRATION',
									uc_s = 'DAL' 				=> 		'DIRECTOR AT LARGE',
									uc_s = 'DAOR' 			=> 		'DIRECTOR ACQUISITION & OWNER RELATIONS',
									uc_s = 'DASPT' 			=> 		'DISTRICT ASSISTANT SUPERINTENDENT',
									uc_s = 'DAVP' 			=> 		'DAVP',
									uc_s = 'DB' 				=> 		'DEACON BOARD',
									uc_s = 'DC' 				=> 		'DIRECTOR CHAIRMAN',
									uc_s = 'DCC' 				=> 		'DIRECTOR OF CORPORATE COMMUNICATIONS',
									uc_s = 'DCEO' 			=> 		'DEPUTY CHIEF EXECUTIVE OFFICER',
									uc_s = 'DCH' 				=> 		'DEPUTY CHAIRMAN',
									uc_s = 'DCM' 				=> 		'DIRECTOR COMPENSATION',
									uc_s = 'DCO' 				=> 		'DEPUTY COMPTROLLER/CONTROLLER',
									uc_s = 'DCOO' 			=> 		'DEPUTY CHIEF OPERATING OFFICER',
									uc_s = 'DCPD' 			=> 		'DIRECTOR CORPORATE PLANNING & DEVELOPMENT',
									uc_s = 'DCS' 				=> 		'DEPUTY CORPORATE SECRETARY',
									uc_s = 'DD' 				=> 		'DEPUTY DIRECTOR',
									uc_s = 'DDO' 				=> 		'DUE DILIGENCE OFFICER',
									uc_s = 'DE' 				=> 		'DIRECTOR OF ENGINEERING',
									uc_s = 'DEAL' 			=> 		'DEAF AT LARGE',
									uc_s = 'DEC' 				=> 		'DEACON',
									uc_s = 'DEL' 				=> 		'DELEGATE',
									uc_s = 'DEM' 				=> 		'DIRECTOR EMERITUS',
									uc_s = 'DEPGME'			=> 		'DEPGME',
									uc_s = 'DF' 				=> 		'DIRECTOR OF FINANCE',
									uc_s = 'DFS' 				=> 		'DIRECTOR OF FEDERAL SALES',
									uc_s = 'DGC' 				=> 		'DEPUTY GENERAL COUNSEL',
									uc_s = 'DGM' 				=> 		'DEPUTY GRAND MASTER',
									uc_s = 'DLA' 				=> 		'DIRECTOR LABOR RELATIONS',
									uc_s = 'DLC' 				=> 		'DIRECTOR LEASES & CONTRACTS',
									uc_s = 'DM' 				=> 		'DISTRICT MANAGER',
									uc_s = 'DMEN'				=> 		'DMEN',
									uc_s = 'DMG' 				=> 		'DEPUTY GENERAL MANAGER',
									uc_s = 'DMM' 				=> 		'DIVISIONAL MERCHANDISE MANAGER',
									uc_s = 'DN' 				=> 		'DEAN',
									uc_s = 'DO' 				=> 		'DIRECTOR OF OPERATIONS',
									uc_s = 'DOC'	 			=> 		'DIRECTOR OF COMPLIANCE',
									uc_s = 'DP' 				=> 		'DIVISIONAL PRESIDENT',
									uc_s = 'DPM'	 			=> 		'DEPARTMENT MANAGER',
									uc_s = 'DPO' 				=> 		'DATA PROCESSING OFFICER',
									uc_s = 'DPP' 				=> 		'DEPUTY PRESIDENT',
									uc_s = 'DPR' 				=> 		'DIRECTOR PUBLIC RELATIONS',
									uc_s = 'DR' 				=> 		'DIRECTOR OF REAL ESTATE',
									uc_s = 'DS' 				=> 		'DIRECTOR OF SCIENCE',
									uc_s = 'DSE' 				=> 		'DISTRICT SECRETARY',
									uc_s = 'DSM' 				=> 		'DIRECTOR OF STATISTICAL METHODS',
									uc_s = 'DSPT' 			=> 		'DISTRICT SUPERINTENDENT',
									uc_s = 'DST' 				=> 		'DIRECTOR STAFFING',
									uc_s = 'DT' 				=> 		'DIRECTOR OF TAXES',
									uc_s = 'DTA'	 			=> 		'DIRECTOR OF TAX ADMINISTRATION',
									uc_s = 'DTR' 				=> 		'DEPUTY TREASURER',
									uc_s = 'DTRS' 			=> 		'DISTRICT TREASURER',
									uc_s = 'DV' 				=> 		'DIVISIONAL VICE-PRESIDENT',
									uc_s = 'DVGM' 			=> 		'DIVISION GENERAL MANAGER',
									uc_s = 'DVM' 				=> 		'DIVISION MANAGER',
									uc_s = 'E' 					=> 		'ELDER',
									uc_s = 'EA' 				=> 		'EXECUTIVE ASSISTANT TO THE CHAIRMAN',
									uc_s = 'EAU' 				=> 		'EXECUTIVE AUDITOR',
									uc_s = 'EC' 				=> 		'EXECUTIVE COMMITTEE',
									uc_s = 'ECH' 				=> 		'EXECUTIVE CHAIRMAN',
									uc_s = 'ECP'				=> 		'ECP',
									uc_s = 'ED' 				=> 		'EXECUTIVE DIRECTOR',
									uc_s = 'EDC' 				=> 		'ENGLISH DIVISION COUNCIL',
									uc_s = 'EDT' 				=> 		'EDITOR',
									uc_s = 'ELD' 				=> 		'ELDER DEACON',
									uc_s = 'EMD' 				=> 		'EXECUTIVE MANAGING DIRECTOR',
									uc_s = 'EME'				=> 		'EME',
									uc_s = 'ENO' 				=> 		'ENGINEERING OFFICER',
									uc_s = 'ENS' 				=> 		'ENGLISH SECRETARY',
									uc_s = 'EO' 				=> 		'EXECUTIVE OFFICE',
									uc_s = 'EP' 				=> 		'ELDER PASTOR',
									uc_s = 'ER' 				=> 		'EXALTED RULER',
									uc_s = 'ERO' 				=> 		'ENVIRONMENTAL REGULATIONS OFFICER',
									uc_s = 'ES' 				=> 		'EXECUTIVE SECRETARY',
									uc_s = 'ESC' 				=> 		'EXECUTIVE SENIOR COUNSEL',
									uc_s = 'ET' 				=> 		'EXECUTIVE TREASURER',
									uc_s = 'EU' 				=> 		'EXECUTIVE MINISTER',
									uc_s = 'EV' 				=> 		'EXECUTIVE VICE-PRESIDENT',
									uc_s = 'EVC' 				=> 		'EXECUTIVE VICE CHAIRMAN',
									uc_s = 'EVP' 				=> 		'EXTERNAL VICE-PRESIDENT',
									uc_s = 'EXA' 				=> 		'EXECUTIVE ASSISTANT',
									uc_s = 'EXO' 				=> 		'EX-OFFICIO',
									uc_s = 'F' 					=> 		'FATHER',
									uc_s = 'FAC' 				=> 		'FACILITATOR',
									uc_s = 'FAO' 				=> 		'FINANCIAL ADMINISTRATIVE OFFICER',
									uc_s = 'FC' 				=> 		'FINANCIAL OFFICER',
									uc_s = 'FDR' 				=> 		'FUND RAISER',
									uc_s = 'FFS' 				=> 		'FIELD FORCE SUPERVISOR',
									uc_s = 'FL' 				=> 		'FAMILY LIAISON',
									uc_s = 'FLC' 				=> 		'FLEET CAPTAIN',
									uc_s = 'FLO' 				=> 		'FINANCIAL LIAISON OFFICER',
									uc_s = 'FN' 				=> 		'FOUNDER',
									uc_s = 'FNC' 				=> 		'FOUNDLING CHAIRMAN',
									uc_s = 'FNOP' 			=> 		'FINANCIAL & OPERATIONS PRINCIPAL',
									uc_s = 'FP' 				=> 		'FINANCIAL PRINCIPAL',
									uc_s = 'FR' 				=> 		'FIELD REPRESENTATIVE',
									uc_s = 'FS' 				=> 		'FINANCIAL SECRETARY',
									uc_s = 'FSU' 				=> 		'FIELD SUPERINTENDENT',
									uc_s = 'FVP' 				=> 		'FINANCE VICE-PRESIDENT',
									uc_s = 'G' 					=> 		'GENERAL PARTNER',
									uc_s = 'GA' 				=> 		'GENERAL ATTORNEY',
									uc_s = 'GAL'				=> 		'GAL',
									uc_s = 'GAU' 				=> 		'GENERAL AUDITOR',
									uc_s = 'GC' 				=> 		'GENERAL COUNSEL',
									uc_s = 'GCH'	 			=> 		'GENERAL CHAIRMAN',
									uc_s = 'GCO' 				=> 		'GENERAL COMPTROLLER/CONTROLLER',
									uc_s = 'GD'				 	=> 		'GENERAL DIRECTOR',
									uc_s = 'GE' 				=> 		'GROUP EXECUTIVE',
									uc_s = 'GM' 				=> 		'GENERAL MANAGER',
									uc_s = 'GMD' 				=> 		'GROUP MANAGING DIRECTOR',
									uc_s = 'GMM' 				=> 		'GENERAL MERCHANDISE MANAGER',
									uc_s = 'GMS' 				=> 		'GRAND MASTER',
									uc_s = 'GOF' 				=> 		'GUARDIAN OF THE FOUNDATION',
									uc_s = 'GOP' 				=> 		'GROUP OPERATION OFFICER',
									uc_s = 'GOV' 				=> 		'GOVERNOR',
									uc_s = 'GP' 				=> 		'GROUP PRESIDENT',
									uc_s = 'GPC' 				=> 		'GENERAL PATENT COUNSEL',
									uc_s = 'GPCO' 			=> 		'GROUP COMPTROLLER/CONTROLLER',
									uc_s = 'GS' 				=> 		'GENERAL SOLICITOR',
									uc_s = 'GSC' 				=> 		'GRAND SECRETARY',
									uc_s = 'GSM' 				=> 		'GENERAL SALES MANAGER',
									uc_s = 'GSPT' 			=> 		'GENERAL SUPERINTENDENT',
									uc_s = 'GT' 				=> 		'GRAND TREASURER',
									uc_s = 'GTC'	 			=> 		'GENERAL TAX COUNSEL',
									uc_s = 'GTO' 				=> 		'GENERAL TAX OFFICER',
									uc_s = 'GV' 				=> 		'GROUP VICE-PRESIDENT',
									uc_s = 'GVD' 				=> 		'GOVERNING DIRECTOR',
									uc_s = 'GVP' 				=> 		'GROUP VICE PRESIDENT',
									uc_s = 'HC' 				=> 		'HONORARY COUNSEL',
									uc_s = 'HCAS' 			=> 		'HIGH COURT ASSISTANT SECRETARY',
									uc_s = 'HCH' 				=> 		'HONORARY CHAIRMAN',
									uc_s = 'HCR' 				=> 		'HIGH CHIEF RANGER',
									uc_s = 'HCS' 				=> 		'HIGH COURT SECRETARY',
									uc_s = 'HCT' 				=> 		'HIGH COURT TREASURER',
									uc_s = 'HD' 				=> 		'HONORARY DIRECTOR',
									uc_s = 'HDC' 				=> 		'HEAD DEACON',
									uc_s = 'HEAL' 			=> 		'HEARING AT LARGE',
									uc_s = 'HFT' 				=> 		'HOUSING FUND TREASURER',
									uc_s = 'HLM' 				=> 		'HONORARY LIFE MEMBER',
									uc_s = 'HM' 				=> 		'HEAD MINISTER',
									uc_s = 'HP' 				=> 		'HIGH PRIEST',
									uc_s = 'HR' 				=> 		'HONORARY TRUSTEE',
									uc_s = 'HRO' 				=> 		'HUMAN RESOURCES OFFICER',
									uc_s = 'HS' 				=> 		'HISTORIAN',
									uc_s = 'HSCR' 			=> 		'HIGH SUB-CHIEF RANGER',
									uc_s = 'HV' 				=> 		'HONORARY VICE-PRESIDENT',
									uc_s = 'IA' 				=> 		'INTERNAL AUDITOR',
									uc_s = 'IAS' 				=> 		'INVESTMENT ASSOCIATES',
									uc_s = 'IC' 				=> 		'INTERNATIONAL COUNSEL',
									uc_s = 'IGC' 				=> 		'INTERNATIONAL GENERAL COUNSEL',
									uc_s = 'IM' 				=> 		'INTERNATIONAL MANAGER',
									uc_s = 'IN' 				=> 		'INCORPORATOR',
									uc_s = 'INO' 				=> 		'INSURANCE OFFICER',
									uc_s = 'IO'			 		=> 		'INVESTMENT OFFICER',
									uc_s = 'IP' 				=> 		'INTERIM PASTOR',
									uc_s = 'IPC' 				=> 		'IMMEDIATE PAST CHAIRMAN',
									uc_s = 'IPDC' 			=> 		'IMMEDIATE PAST DEPARTMENT COMMANDER',
									uc_s = 'IPP' 				=> 		'IMMEDIATE PAST PRESIDENT',
									uc_s = 'ISP' 				=> 		'INSPECTOR',
									uc_s = 'IVP' 				=> 		'INTERNAL VICE-PRESIDENT',
									uc_s = 'JAS' 				=> 		'JAPANESE SECRETARY',
									uc_s = 'JAT' 				=> 		'JUNIOR ASSISTANT TREASURER',
									uc_s = 'JB' 				=> 		'JUNIOR BEADLE',
									uc_s = 'JGAV' 			=> 		'JUDGE ADVOCATE',
									uc_s = 'JGW' 				=> 		'JUNIOR GRAND WARDEN',
									uc_s = 'JP' 				=> 		'JUNIOR PRESIDENT',
									uc_s = 'JPCR' 			=> 		'JUNIOR PAST CHIEF RANGER',
									uc_s = 'JPP' 				=> 		'JUNIOR PAST PRESIDENT',
									uc_s = 'JR' 				=> 		'JUNIOR WOODWARD',
									uc_s = 'JRSC' 			=> 		'JUNIOR SCHOOL CHAIRMAN',
									uc_s = 'JS' 				=> 		'JUNIOR SECRETARY',
									uc_s = 'JVCMR'			=> 		'JUNIOR VICE COMMANDER',
									uc_s = 'K' 					=> 		'KAPUNA',
									uc_s = 'L' 					=> 		'LIMITED PARTNER',
									uc_s = 'LA' 				=> 		'LEGAL ADVISOR',
									uc_s = 'LB' 				=> 		'LEADING BROTHER',
									uc_s = 'LC' 				=> 		'LEGAL COUNSEL',
									uc_s = 'LCR' 				=> 		'LEGISLATIVE CHAIR',
									uc_s = 'LIB'				=> 		'LIB',
									uc_s = 'LK' 				=> 		'LEADING KNIGHT',
									uc_s = 'LL' 				=> 		'LAY LEADER',
									uc_s = 'LLK' 				=> 		'LOYAL KNIGHT',
									uc_s = 'LO' 				=> 		'LICENSING OFFICER',
									uc_s = 'LQ' 				=> 		'LIQUIDATOR',
									uc_s = 'LS' 				=> 		'LEGAL SECRETARY',
									uc_s = 'LTDA' 			=> 		'LIQUIDATING TRUSTEE & DISBURSING AGENT',
									uc_s = 'LTK' 				=> 		'LECTURING KNIGHT',
									uc_s = 'LYK'				=> 		'LYK',
									uc_s = 'M' 					=> 		'MEMBER/MOTHER',
									uc_s = 'MADS' 			=> 		'MEDICAL ADVISOR',
									uc_s = 'MAL' 				=> 		'MEMBER AT LARGE',
									uc_s = 'MCN' 				=> 		'MANAGING COUNSEL',
									uc_s = 'MCO' 				=> 		'MARKETING COMPTROLLER/CONTROLLER',
									uc_s = 'MD' 				=> 		'MANAGING DIRECTOR',
									uc_s = 'MDO' 				=> 		'MISSION DIRECTOR OFFICER',
									uc_s = 'MDR' 				=> 		'MODERATOR',				
									uc_s = 'ME' 				=> 		'MANAGING ENGINEER',
									uc_s = 'MED' 				=> 		'MEDICAL DIRECTOR',
									uc_s = 'MEM' 				=> 		'MEMBER',
									uc_s = 'MG' 				=> 		'MANAGER',
									uc_s = 'MGE' 				=> 		'MANAGER',
									uc_s = 'MGR' 				=> 		'MANAGER',
									uc_s = 'MIN' 				=> 		'MINISTER',
									uc_s = 'ML' 				=> 		'MEMBERSHIP LIAISON',
									uc_s = 'MMS' 				=> 		'MEMBERSHIP SECRETARY',
									uc_s = 'MO' 				=> 		'MARKETING OFFICER',
									uc_s = 'MOD'				=> 		'MOD',
									uc_s = 'MOO' 				=> 		'MANAGER OF OPERATIONS',
									uc_s = 'MPRN' 			=> 		'MANAGING PRINCIPAL',
									uc_s = 'MS' 				=> 		'MARKETING SERVICES',
									uc_s = 'MSE'	 			=> 		'MONOGRAPH SERIES EDITOR',
									uc_s = 'MTO' 				=> 		'MORTGAGE OFFICER',
									uc_s = 'MUD' 				=> 		'MUSIC DIRECTOR',
									uc_s = 'MV'					=> 		'MV',
									uc_s = 'NC' 				=> 		'NATIONAL COMMITTEEMAN',
									uc_s = 'NE' 				=> 		'NEWSLETTER EDITOR',
									uc_s = 'NI'					=> 		'NI',
									uc_s = 'NP' 				=> 		'NATIONAL PRESIDENT',
									uc_s = 'NPR'	 			=> 		'NEW PARENT REPRESENTATIVE',
									uc_s = 'NR' 				=> 		'NATIONAL REPRESENTATIVE',
									uc_s = 'NSD' 				=> 		'NATIONAL SALES DIRECTOR',
									uc_s = 'NV' 				=> 		'NATIONAL VICE-PRESIDENT',
									uc_s = 'O' 					=> 		'OWNER/OTHER',
									uc_s = 'OB' 				=> 		'OPERATING BOARD',
									uc_s = 'OBS'	 			=> 		'ORGANIZATIONAL BISHOP',
									uc_s = 'OCC'				=> 		'OCC',
									uc_s = 'OF' 				=> 		'OFFICER',
									uc_s = 'OM' 				=> 		'OFFICE MANAGER',
									uc_s = 'OO' 				=> 		'OPERATIONS OFFICER',
									uc_s = 'OP' 				=> 		'OPERATIONS',
									uc_s = 'OPM' 				=> 		'OPERATIONS MANAGER',
									uc_s = 'OXO' 				=> 		'OFFICER EX-OFFICIO',
									uc_s = 'P' 					=> 		'PRESIDENT',
									uc_s = 'PA' 				=> 		'PURCHASING AGENT',
									uc_s = 'PAGT' 			=> 		'PLAYER AGENT',
									uc_s = 'PAO' 				=> 		'PRINCIPAL ACCOUNTING OFFICER',
									uc_s = 'PAR' 				=> 		'PARLIAMENTARIAN',
									uc_s = 'PB' 				=> 		'PRINCIPAL BROKER',
									uc_s = 'PC' 				=> 		'PATENT COUNSEL',
									uc_s = 'PCD' 				=> 		'PLANNING/CONTROL DIRECTOR',
									uc_s = 'PCH' 				=> 		'PAST CHAIRMAN',
									uc_s = 'PCMR' 			=> 		'POST COMMANDER',
									uc_s = 'PCO' 				=> 		'PROGRAM COORDINATOR',
									uc_s = 'PD' 				=> 		'PROTOCOL DIRECTOR',
									uc_s = 'PE' 				=> 		'PRESIDENT ELECT',
									uc_s = 'PED' 				=> 		'PRESIDENT EMERITUS',
									uc_s = 'PF' 				=> 		'PROFESSOR',
									uc_s = 'PFM'	 			=> 		'PROJECT FOREMAN',
									uc_s = 'PFO' 				=> 		'PRINCIPAL FINANCIAL OFFICER',
									uc_s = 'PFS' 				=> 		'PERSONAL FINANCIAL SERVICES',
									uc_s = 'PJC' 				=> 		'PROJECT CONSULTANT',
									uc_s = 'PM' 				=> 		'PROGRAM MANAGER',
									uc_s = 'PO' 				=> 		'POTENTATE',
									uc_s = 'POD' 				=> 		'PRESIDENT OF BOARD',
									uc_s = 'PP' 				=> 		'PAST PRESIDENT',
									uc_s = 'PPC'	 			=> 		'PUBLIC POLICY COORDINATOR',
									uc_s = 'PPD' 				=> 		'PRINT PRODUCTION DIRECTOR',
									uc_s = 'PR' 				=> 		'PRIMATE',
									uc_s = 'PRA' 				=> 		'PRINCIPAL ARCHITECT',
									uc_s = 'PRN' 				=> 		'PRINCIPAL',
									uc_s = 'PRO' 				=> 		'PUBLIC RELATIONS OFFICER',
									uc_s = 'PRS' 				=> 		'PRINCIPAL SCIENTIST',
									uc_s = 'PS' 				=> 		'PASTOR',
									uc_s = 'PT'					=> 		'PT',
									uc_s = 'PTC'	 			=> 		'PORT CAPTAIN',
									uc_s = 'PTO' 				=> 		'PORTFOLIO OFFICER',
									uc_s = 'PU' 				=> 		'PUBLISHER',
									uc_s = 'PV' 				=> 		'PROVOST',
									uc_s = 'PY' 				=> 		'PUBLICITY',
									uc_s = 'QM' 				=> 		'QUARTERMASTER',
									uc_s = 'R' 					=> 		'TRUSTEE',
									uc_s = 'RA' 				=> 		'REGIONAL ADMINISTRATOR',
									uc_s = 'RAC' 				=> 		'RACE COMMISSIONER',
									uc_s = 'RAS' 				=> 		'RACE SECRETARY',
									uc_s = 'RBD' 				=> 		'REGIONAL BRANCH DIRECTOR',
									uc_s = 'RC' 				=> 		'REAR COMMODORE',
									uc_s = 'RCH' 				=> 		'REGIONAL CHAIRMAN',
									uc_s = 'RD' 				=> 		'REPRESENTATIVE DIRECTOR/REGIONAL DIRECTOR',
									uc_s = 'RDR'	 			=> 		'RESPONSIBLE OFFICER',
									uc_s = 'REC' 				=> 		'RECEIVER',
									uc_s = 'RED' 				=> 		'REGIONAL EXECUTIVE DIRECTOR',
									uc_s = 'REDR' 			=> 		'READER',
									uc_s = 'REM'	 			=> 		'RESIDENT MANAGER',
									uc_s = 'REO' 				=> 		'REAL ESTATE OFFICER',
									uc_s = 'RFDM' 			=> 		'REGIONAL FIELD SERVICES MANAGER',
									uc_s = 'RG' 				=> 		'REGENT',
									uc_s = 'RGT'	 			=> 		'REGISTRAR',
									uc_s = 'RM' 				=> 		'REGIONAL MANAGER',
									uc_s = 'RME' 				=> 		'RESPONSIBLE MANAGING EMPLOYEE',
									uc_s = 'RMG' 				=> 		'RISK MANAGER',
									uc_s = 'RO' 				=> 		'RECORDS OFFICER',
									uc_s = 'ROF' 				=> 		'REGIONAL OFFICER',
									uc_s = 'RP' 				=> 		'REGIONAL PRESIDENT',
									uc_s = 'RS' 				=> 		'RECORDING SECRETARY',
									uc_s = 'RSI' 				=> 		'REGIONAL SUPERINTENDENT',
									uc_s = 'RSM' 				=> 		'REGIONAL SALES MANAGER',
									uc_s = 'RSU' 				=> 		'REGIONAL SUPERVISOR',
									uc_s = 'RSV' 				=> 		'REGIONAL SENIOR VICE-PRESIDENT',
									uc_s = 'RV' 				=> 		'RESIDENT VICE-PRESIDENT',
									uc_s = 'RVP' 				=> 		'REGIONAL VICE-PRESIDENT',
									uc_s = 'S' 					=> 		'SECRETARY',
									uc_s = 'SA' 				=> 		'STATUTORY AUDITOR',
									uc_s = 'SAA' 				=> 		'SENIOR ASSIST ACTUARY',
									uc_s = 'SAC' 				=> 		'SENIOR ASSISTANT COMPTROLLER/CONTROLLER',
									uc_s = 'SAD' 				=> 		'SENIOR ADVISOR',
									uc_s = 'SADS' 			=> 		'SPIRITUAL ADVISORS',
									uc_s = 'SAE' 				=> 		'SENIOR ACCOUNT EXECUTIVE',
									uc_s = 'SAG' 				=> 		'STATUTORY AGENT',
									uc_s = 'SAO' 				=> 		'SECURITIES ACCOUNTING OFFICER',
									uc_s = 'SAP' 				=> 		'SPECIAL APPOINTEE',
									uc_s = 'SAS' 				=>		'SENIOR ASSISTANT SECRETARY',
									uc_s = 'SAT' 				=> 		'SENIOR ASSISTANT TREASURER',
									uc_s = 'SB' 				=> 		'SCRIBE',
									uc_s = 'SC' 				=> 		'SENIOR COMPTROLLER/CONTROLLER',
									uc_s = 'SCA'	 			=> 		'SENIOR COMPLIANCE ANALYST',
									uc_s = 'SCE' 				=> 		'SENIOR CLAIMS EXECUTIVE',
									uc_s = 'SCM' 				=> 		'SPECIAL COMMITTEE',
									uc_s = 'SCN' 				=> 		'SPECIAL COUNCIL',
									uc_s = 'SCO'	 			=> 		'SENIOR CREDIT OFFICER',
									uc_s = 'SCON' 			=> 		'SENIOR CONSULTANT',
									uc_s = 'SCOO' 			=> 		'SECURITIES COMPLIANCE OFFICER',
									uc_s = 'SCR' 				=> 		'SUB-CHIEF RANGER',
									uc_s = 'SCSO' 			=> 		'SENIOR CLIENT SERVICE OFFICER',
									uc_s = 'SD' 				=> 		'SENIOR DIRECTOR',
									uc_s = 'SE' 				=> 		'SECURITY',
									uc_s = 'SEC' 				=> 		'STATE EXECUTIVE COMMITTEEMEN',
									uc_s = 'SED' 				=> 		'SENIOR EXECUTIVE DIRECTOR',
									uc_s = 'SEV' 				=> 		'SENIOR EXECUTIVE VICE-PRESIDENT',
									uc_s = 'SEVP'				=> 		'SECURITY VICE PRESIDENT',													
									uc_s = 'SFC' 				=> 		'SENIOR FRANCHISE COUNSEL',
									uc_s = 'SFO'				=> 		'SFO',
									uc_s = 'SGA' 				=> 		'SERGEANT AT ARMS',
									uc_s = 'SGW' 				=> 		'SENIOR GRAND WARDEN',
									uc_s = 'SH' 				=> 		'STOCK HOLDER',
									uc_s = 'SLA'	 			=> 		'SENIOR LOAN ADMINISTRATIVE OFFICER',
									uc_s = 'SLD' 				=> 		'SOLE DIRECTOR',
									uc_s = 'SM' 				=> 		'SENIOR MANAGER',
									uc_s = 'SMD'	 			=> 		'SENIOR MANAGING DIRECTOR',
									uc_s = 'SME' 				=> 		'SENIOR MARKETING EXECUTIVE',
									uc_s = 'SMG' 				=> 		'SERVICING MANAGER',
									uc_s = 'SO' 				=> 		'SECURITY OFFICER',
									uc_s = 'SOB'	 			=> 		'SECRETARY OF BOARD',
									uc_s = 'SP' 				=> 		'SUPERVISOR',
									uc_s = 'SPA'	 			=> 		'SPECIAL ASSISTANT',
									uc_s = 'SPE' 				=> 		'SPECIAL PUBLICATIONS EDITOR',
									uc_s = 'SPM' 				=> 		'SENIOR PORTFOLIO MANAGER',
									uc_s = 'SPO'	 			=> 		'SPECIAL PROJECTS OFFICER',
									uc_s = 'SPS'				=> 		'SPS',
									uc_s = 'SPT' 				=> 		'SUPERINTENDENT',
									uc_s = 'SRA' 				=> 		'SENIOR ATTORNEY',
									uc_s = 'SRB' 				=> 		'SENIOR BEADLE',
									uc_s = 'SRC' 				=> 		'SENIOR COUNSEL',
									uc_s = 'SRCC' 			=> 		'SENIOR CORPORATE COUNSEL',
									uc_s = 'SRCH' 			=> 		'SENIOR CHAIRMAN OF THE BOARD',
									uc_s = 'SRF' 				=> 		'SENIOR RESEARCH FELLOW',
									uc_s = 'SRH' 				=> 		'SHARE HOLDER',
									uc_s = 'SRIO' 			=> 		'SENIOR INVESTMENT OFFICER',
									uc_s = 'SRMO' 			=> 		'SENIOR MERCHANDISING OFFICER',
									uc_s = 'SRO' 				=> 		'SENIOR OFFICER',
									uc_s = 'SROP' 			=> 		'SENIOR REGISTERED OPTIONS PRINCIPAL',
									uc_s = 'SRPS'				=> 		'SRPS',
									uc_s = 'SRRV' 			=> 		'SENIOR REGIONAL VICE-PRESIDENT',
									uc_s = 'SRTO' 			=> 		'SENIOR TRUST OFFICER',
									uc_s = 'SRTXO'	 		=> 		'SENIOR TAX OFFICER',
									uc_s = 'SRV' 				=> 		'SENIOR VICE-PRESIDENT',
									uc_s = 'SRVCH' 			=> 		'SENIOR VICE CHAIRMAN',
									uc_s = 'SSO' 				=> 		'SPECIAL SERVICE OFFICER',
									uc_s = 'ST' 				=> 		'SPECIAL TREASURER',
									uc_s = 'STA' 				=> 		'STANDING AUDITOR',
									uc_s = 'STATT' 			=> 		'STAFF ATTORNEY',
									uc_s = 'STC'				=> 		'STC',
									uc_s = 'STCMM'	 		=> 		'STAFF COMMODORE',
									uc_s = 'STM' 				=> 		'STUDENT MEMBER',
									uc_s = 'STR' 				=> 		'STAFF REPS',
									uc_s = 'STV' 				=> 		'STAFF VICE-PRESIDENT',
									uc_s = 'STW' 				=> 		'STEWARDSHIP',
									uc_s = 'SUPRPONT'		=> 		'SUPREME PONTIFF',
									uc_s = 'SURG' 			=> 		'SURGEON',
									uc_s = 'SV'					=> 		'SV',
									uc_s = 'SVC'				=> 		'SVC',
									uc_s = 'SVCMR'	 		=> 		'SENIOR VICE COMMANDER',
									uc_s = 'SVO' 				=> 		'SERVICE OFFICER',
									uc_s = 'SVP' 				=> 		'SENIOR VICE PRESIDENT',
									uc_s = 'SVT' 				=> 		'SERVANT',
									uc_s = 'SW' 				=> 		'SENIOR WOODWARD',
									uc_s = 'T' 					=> 		'TREASURER',
									uc_s = 'TA' 				=> 		'TAX ADMINISTRATOR',
									uc_s = 'TC' 				=> 		'TAX COUNSEL',
									uc_s = 'TCO' 				=> 		'TAX COMPTROLLER/CONTROLLER',
									uc_s = 'TD' 				=> 		'TAX DIRECTOR',
									uc_s = 'TDM' 				=> 		'TRUST DEPARTMENT MANAGER',
									uc_s = 'TE' 				=> 		'TREASURER ELECT',
									uc_s = 'TL' 				=> 		'TRUSTEE AT LARGE',
									uc_s = 'TO' 				=> 		'TRUST OFFICER',
									uc_s = 'TOB' 				=> 		'TREASURER OF THE BOARD',
									uc_s = 'TR' 				=> 		'TREASURER',
									uc_s = 'TXO' 				=> 		'TAX OFFICER',
									uc_s = 'V' 					=> 		'VICE-PRESIDENT',
									uc_s = 'VC' 				=> 		'VICE CHAIRMAN',
									uc_s = 'VCB' 				=> 		'VICE CHAIRMAN OF THE BOARD',
									uc_s = 'VCH' 				=> 		'VICE CHAIRMAN',
									uc_s = 'VCHEM' 			=> 		'VICE CHAIRMAN EMERITUS',
									uc_s = 'VCHR' 			=> 		'VICE CHAIRMAN OF THE BOARD OF TRUSTEES',
									uc_s = 'VCHP'				=> 		'VCHP',
									uc_s = 'VCMM' 			=> 		'VICE COMMODORE',
									uc_s = 'VCMR' 			=> 		'VICE COMMANDER',
									uc_s = 'VCMT' 			=> 		'VICE COMMANDANT',
									uc_s = 'VCNC' 			=> 		'VICE COUNCIL CHAIRMAN',
									uc_s = 'VD'					=> 		'VD',
									uc_s = 'VE' 				=> 		'VICE-PRESIDENT ELECT',
									uc_s = 'VMDR' 			=> 		'VICE MODERATOR',
									uc_s = 'VP' 				=> 		'VICAR PRIEST',
									uc_s = 'VPO' 				=> 		'VICE-PRESIDENT OPERATOR',
									uc_s = 'VRG'				=> 		'VICE REGENT',
									uc_s = 'VS'					=> 		'VICE PRESIDENT/SECRETARY',
									uc_s = 'VT'					=> 		'VICE TREASURER',
									uc_s = 'WB' 				=> 		'WORSHIP BOARD',
									uc_s = 'WL' 				=> 		'WOMEN LEADER',
									uc_s = 'WM' 				=> 		'WAYS AND MEANS',
									uc_s = 'WMO' 				=> 		'WOMEN\'S MISSION OFFICER',
									uc_s = 'YDO' 				=> 		'YOUTH DIRECTOR OFFICER',
									uc_s = 'YOUTH PS' 	=> 		'YOUTH PASTOR',
									uc_s = 'ZA' 				=> 		'ZONE ADMINISTRATOR',
									uc_s = 'ZM' 				=> 		'ZONE MANAGER',
									''
								 );

		END;
		
		//****************************************************************************
		//ContTitleDesc: Returns the "cont_title1_desc" or "cont_title2_desc" or
		//															 "cont_title3_desc" or "cont_title4_desc" or
		//															 "cont_title5_desc" based upon the input
		//															 parms.
		//Note:  input: t -> title, n -> title number
		//****************************************************************************
		EXPORT ContTitleDesc(string t, string n) := FUNCTION
					 
					 PatternInvalidWords	:= 'SEE FILE|SEE RPT|AT LARGE';

					 //remove all references to *, #, (, and )
					 uc_t1					:= corp2.t2u(stringlib.stringfilterout(t,'*#)('));

					 //remove any dashes "-" or periods that appear at the end of the value e.g. V-
					 uc_t2  				:= corp2.t2u(regexreplace(('(\\-)*(\\.)*$'),uc_t1,''));

					 //remove any titles that are "invalid words"
					 uc_t3 := if(regexfind(PatternInvalidWords,uc_t2,0)<>'','',uc_t2);

					 //remove any commas or periods that appears at the beginning of the value (e.g. ,GR)
					 uc_t4  				:= regexreplace(('^(\\,)*(\\.)*(\\&)*'),uc_t3,'');

					 uc_t5  				:= regexreplace('CHEIF',uc_t4,'CHIEF');  //fix misspellings here
					 
					 uc_t						:= corp2.t2u(uc_t5);
					 
					 uc_n 		 			:= corp2.t2u(n);
					 
					 title				 	:= map(uc_n = '1' => stringlib.splitwords(uc_t,'/',true)[1],
																 uc_n = '2' => stringlib.splitwords(uc_t,'/',true)[2],
																 uc_n = '3' => stringlib.splitwords(uc_t,'/',true)[3],
																 uc_n = '4' => stringlib.splitwords(uc_t,'/',true)[4],
																 uc_n = '5' => stringlib.splitwords(uc_t,'/',true)[5],
																 ''
																);

					 //if only digits, then RETURN a blank
					 title_cleaned := if(corp2.t2u(stringlib.stringfilterout(title,'0123456789'))='','',corp2.t2u(title));

					 //remove all special characters except for those allowed (see below)
					 title_code		 := corp2.t2u(stringlib.stringfilter(title_cleaned,' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,-/&\\\'')); 

					 RETURN TitleLookupTable(title_code);
	
		END;
		
END;