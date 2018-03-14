/*2017-02-23T01:39:29Z (Fernando Incarnacao)
DF-18515 - Update Inquiry Tracking vertical filters according to the current exclusion criteria
*/

/*2016-10-27T18:07:01Z (Fernando Incarnacao)
RQ-13003 - Fix removing parenthesis from the ROLLPERSEARCH function description. 
*/

import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, lib_word;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fnCleanFunctions := module

	export FCRA_ReappendDay := ['friday'] : stored('FCRA_Append_Date');

	export fnCleanUp(string instring) := trim(stringlib.stringtouppercase(stringlib.stringfilterout(
																			if(trim(stringlib.stringtouppercase(instring), all) = 'COLLECTION', 'COLLECTIONS', stringlib.stringtouppercase(instring)),
																			'?')), left, right);

	// Reviewed as per doc update of 03/31/2017																		
	export FilterCds := 
	['AUTO'
	,'AUTO CLAIMS SUMMARY'
	,'AUTO MARKETING'
	,'AUTO UNDERWRITING'
	,'BACKGROUND SCREENING'
	,'COMMERCIAL'
	,'COPLOGIC SOLUTIONS'
	,'CORE'
	,'DATA SERVICES'
	,'DATA/BULK OKC'
	,'DISCONTINUEDOPS'
	,'DIRECT MARKETING'
	,'ECLA INTERNATIONAL'
	,'GOVERNMENT'
	,'GOVERNMENT CORE'
	,'GOVERNMENT CORE FED'
	,'GOVERNMENT CORE SL'
	,'GOVERNMENT RISK'
	,'GOVERNMENT & ACADEMIC'
	,'GOVERNMENT HEALTHCARE'
	,'HEALTHCARE'
	,'HEALTHCARE – COMMERCIAL'
	,'HEALTHCARE-GOV FED'
	,'HEALTHCARE-GOV SL'
	,'HEALTHCARE – GOVERNMENT'
	,'HEALTHCARE – INITIATIVE'
	,'HEALTHCARE ANALYTICS'
	,'HEALTHCARE INITIATIVE'
	,'HOME'
	,'HOME OWNERS'
	,'INSURANCE'
	,'INSURANCE EXCHANGE'
	,'INSURANCE INTERNATIONAL'
	,'INSURANCE-OTHER'
	,'INSURANCE OTHER'
	,'INSURANCE UNASSIGNED'
	,'INTERNAL'
	,'INTERNATIONAL VERTICAL'
	,'LIFE'
	,'LIFE INSURANCE'
	,'LIFE SCIENCES'
	,'LNSSI'
	,'PAYER'
	,'PENDING ASSIGNMENT'
	,'PHARMACY'
	,'PI/BACKGROUND'
	,'PROVIDER'
	,'SIGNATURE INFO SERVICES'
	,'USLM'
	,'VITALCHE'
	,''];

	export FilterCds_extra := 'HEALTH|AUTO|HOME|INSURANCE|INTERNATIONAL|UNDERWRITING|LIFE';

	export Industry_FilterCds := 
	['BACKGROUND SCREENING'
	,'CHILD SUPPORT'
	,'EMPLOYMENT SCREENING'
	,'GOVERNMENT'
	,'HEALTHCARE'
	,'HEATHCARE'
	,'INSURANCE'
	,'INTERNAL'
	,'TEST ACCOUNT'];

	export SubMarket_FilterCds := 
	['BACKGROUND SCREENING'
	,'HEALTH & HUMAN SERVICES'
	,'HEALTH & HUMAN SERVICES.FEDERAL'
	,'HEALTH & HUMAN SERVICES.LOCAL'
	,'HEALTH & HUMAN SERVICES.STATE'
	,'HEALTHCARE'
	,'INTERNAL'
	,'PRIVATE INVESTIGATORS'
	,'PUBLIC SAFETY'
	,'PUBLIC SAFETY.FEDERAL'
	,'PUBLIC SAFETY.LOCAL'
	,'PUBLIC SAFETY.STATE'
	,'REG & ADMIN'
	,'REG & ADMIN.FEDERAL'
	,'REG & ADMIN. LOCAL'
	,'REG & ADMIN.STATE'
	,'SM-BACKGROUND SCREENING'
	,'SM-HEALTHCARE'
	,'SM-PUBLIC SAFETY.FEDERAL'
	,'SM-PUBLIC SAFETY.LOCAL'
	,'SM-REG & ADMIN.FEDERAL'
	,'SM-REG & ADMIN.LOCAL'
	,'SM-TAX & REVENUE.FEDERAL'
	,'SM-HEALTH & HUMAN SERVICES.FED'
	,'SM-HEALTH & HUMAN SERVICES.LOC'
	,'SM-HEALTH & HUMAN SERVICES.STA'
	,'SM-HEALTHCARE'
	,'SM-PRIVATE INVESTIGATORS'
	,'SM-PUBLIC SAFETY.FEDERAL'
	,'SM-PUBLIC SAFETY.LOCAL'
	,'SM-PUBLIC SAFETY.STATE'
	,'SM-REG & ADMIN.FEDERAL'
	,'SM-REG & ADMIN.LOCAL'
	,'SM-REG & ADMIN.STATE'
	,'SM-TAX & REVENUE.FEDERAL'
	,'SM-TAX & REVENUE.LOCAL'
	,'SM-TAX & REVENUE.STATE'
	,'TAX & REVENUE'
	,'TAX & REVENUE.FEDERAL'
	,'TAX & REVENUE.LOCAL'
	,'TAX & REVENUE.STATE'];

	export healthcare_FilterCds_extra :=  'BLOOD CENTER|CANCER CENTER|CHIROPRACTIC|CLINIC|DENTAL|DOCTOR|HEALTH|HEALTHCARE|HOSPITAL |HOSPITAL$|HOSPITAL,|MEDICAL|MEDICINE|ONCOLOGY|PHARMACY|PHYSICAL THERAPY|PHYSICIAN|SURGERY|SURGERIES|SURGICAL|THERAPY|BLUE CROSS|BLUE SHIELD|BLUECROSS|BLUESHIELD';

	export ProductCode_FilterCds := ['I','B','7']; //not used anymore - 20131005. bridger is now the assigned product code from MBS ('1')

	export Source_FilterCds := ['IDM/BLS','IDM','IDM_BLS','BLS','BRIDGER']; //20131005 created for filtering in risk_indicators key without manipulating the product code field

	export nullset := ['none','NONE','','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null','\'N', '\\N', '\'\\N'];

	export rll2months(DATASET(INQL_v2.Layouts.Common_ThorAdditions) base_file) := FUNCTION

		HashBaseFile := project(base_file, 
																transform({unsigned8 person_q_id, unsigned8 bus_q_id, unsigned8 bususer_q_id, 
																					 integer8 seqcnt := 0, integer8 daysbetween := 0, boolean m2flag := false,
																					 recordof(base_file)},
																	self.person_q_id := hash64(left.person_q.title + left.person_q.fname + left.person_q.mname + left.person_q.lname + left.person_q.name_suffix + left.person_q.Work_Phone + left.person_q.Personal_Phone + left.person_q.DOB + left.person_q.SSN + left.person_q.prim_range + left.person_q.prim_name + left.person_q.sec_range + left.person_q.st + left.person_q.zip5),
																	self.bus_q_id := hash64(left.bus_q.CName + left.bus_q.Company_Phone + left.bus_q.EIN + left.bus_q.prim_range + left.bus_q.prim_name + left.bus_q.sec_range + left.bus_q.st + left.bus_q.zip5),
																	self.bususer_q_id := hash64(left.bususer_q.title + left.bususer_q.fname + left.bususer_q.mname + left.bususer_q.lname + left.bususer_q.name_suffix + left.bususer_q.Personal_Phone + left.bususer_q.DOB + left.bususer_q.SSN + left.bususer_q.prim_range + left.bususer_q.prim_name + left.bususer_q.sec_range + left.bususer_q.st + left.bususer_q.zip5),
																	SELF.Search_info.start_monitor	:= if(left.search_info.start_monitor = '', left.search_info.datetime[..8], left.search_info.start_monitor);
																	SELF.Search_info.stop_monitor	:= if(left.search_info.stop_monitor = '', left.search_info.datetime[..8], left.search_info.stop_monitor);
																	self := left));
																	
		dHashBaseFile := distribute(HashBaseFile, 
																		hash(mbs.company_id, mbs.global_company_id, bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id));
																		
		gsHashBaseFile := sort(dHashBaseFile, 
														mbs.company_id, mbs.global_company_id, bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id ,search_info.datetime[..8], local);

		iHashBaseFile := iterate(gsHashBaseFile, transform({recordof(gsHashBaseFile)},
														fDaysBetween(string dt_l, string dt_r) := ut.DaysApart(dt_l, dt_r);
														matches := left.bus_intel.industry = right.bus_intel.industry and
																				left.bus_intel.sub_market = right.bus_intel.sub_market and
																				left.mbs.company_id = right.mbs.company_id and
																				left.mbs.global_company_id = right.mbs.global_company_id and
																				left.bus_intel.vertical = right.bus_intel.vertical and
																				left.bus_INTEL.USE = right.bus_INTEL.USE and
																				left.allow_flags.allowflags = right.allow_flags.allowflags and
																				left.search_info.product_code = right.search_info.product_code and
																				left.search_info.method = right.search_info.method and
																				left.search_info.function_description = right.search_info.function_description and
																				left.bususer_q_id = right.bususer_q_id and
																				left.person_q_id = right.person_q_id and
																				left.bus_q_id = right.bus_q_id;
		 
														self.DaysBetween 		:= fDaysBetween(if(~matches, right.search_info.datetime[..8], left.search_info.datetime[..8]), right.search_info.datetime[..8]);
														self.M2flag 				:= self.DaysBetween > 60 or ~matches; //greater than 2 months or new record
														self.seqcnt					:= map(~matches => 1, self.M2flag => counter, left.seqcnt);
														self.search_info.start_monitor	:= map(self.M2flag => right.search_info.start_monitor[..8], (string)ut.Min2((integer)left.search_info.start_monitor[..8],(integer) right.search_info.start_monitor[..8]));
														self.search_info.stop_monitor		:= map(self.M2flag => right.search_info.stop_monitor[..8], (string)ut.max2((integer)left.search_info.stop_monitor[..8],(integer) right.search_info.stop_monitor[..8]));
														self := right), local);

		ddpBaseFile := dedup(iHashBaseFile, mbs.company_id, mbs.global_company_id, bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id, seqcnt, right, local);
		prjBaseFile := project(ddpBaseFile, INQL_v2.Layouts.Common_ThorAdditions);

		RETURN prjBaseFile;

	END;

	export CleanFields(inputFile,outputFile) := macro

		LOADXML('<xml/>');
		#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

		#uniquename(myCleanFunction)
		string %myCleanFunction%(string x) := stringlib.stringcleanspaces(regexreplace('[^[:print:]]+',trim(stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringtouppercase(
																					map(trim(x,all) in INQL_v2.fnCleanFunctions.nullset => '',
																					    if (stringlib.stringfind(x,'(ROLLUP)',1)>0,
																									stringlib.stringcleanspaces(stringlib.stringfilterout(x,'{}|_><+=*~[]!@#$%^&*?;\"`')),
																									stringlib.stringcleanspaces(stringlib.stringfilterout(x,'{}|_><+=*~[]!@#$%^&*()?;\"`'))
																									)
																							)		
																					), '&amp;', '&'), '\\N',''), left, right),' '));

		#uniquename(tra)
		inputFile %tra%(inputFile le) :=
		TRANSFORM
		#IF (%'doCleanFieldText'%='')
		 #DECLARE(doCleanFieldText)
		#END
		#SET (doCleanFieldText, false)
		#FOR (doCleanFieldMetaInfo)
		 #FOR (Field)
			#IF (%'@type'% = 'string' )
			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunction'% + '(le.')
			#APPEND (doCleanFieldText, %'@name'%)
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#END
		 #END
		#END
			SELF := le;
		END;

		outputFile := PROJECT(inputFile, %tra%(LEFT));

	endmacro;

	export clean_ssn(string orig_ssn):= function
					pclean_ssn := stringlib.stringfilter(orig_ssn, '0123456789');
					qclean_ssn := if(pclean_ssn not in ['000000000', '0', '0000', '00000'] and pclean_ssn not in ut.Set_BadSSN and pclean_ssn not in NullSet,  pclean_ssn, '');
					return if(length(trim(qclean_ssn, all)) in [4,6], 
															intformat((unsigned8)stringlib.stringfilter(trim(qclean_ssn, all), '0123456789'), 9, 0),
															stringlib.stringfilter(trim(qclean_ssn, all), '0123456789'));
	end;

	export clean_phone(string orig_phone) := function
					pclean_phone := if(orig_phone[1..3] in ['000','XXX','xxx'], '   ', orig_phone[1..3])+ orig_phone[4..10]; /* empty area codes standardized */
					NPAg := pclean_phone[1..3] in ['800','811','822','833','844','855','866','877','888','899'] or orig_phone[1..3] between '200' and '999'; /* toll free area codes */
					NXXg := pclean_phone[4..6] between '001' and '999'; /* valid nxx */
					TBg  := pclean_phone[7..10] between '0000' and '9999'; /* valid tb+ */
					return  map(NPAg and NXXg and TBg => pclean_phone, NXXg and TBg => '   ' + pclean_phone[7..10], '');
	end;

	export tDateAdded(string indate) := function //dates like Dec  1 2009 5:35:32:011AM
		upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);
		noTrans := ~regexfind('[B-LN-OQ-Z]', upcaseit); // do not find more than AM PM
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
		return stringlib.stringcleanspaces(if(noTrans, stringlib.stringfilterout(upcaseit, '-'), yr+month+dy+' '+upcaseit[12..]));
	end;	

	export tTimeAdded(string dt) := function //dates like 20110101 10:15:123456AM

		time_only 				:= stringlib.stringtouppercase(trim(dt, all)[9..]);
		
		a	:= (string)intformat((integer)time_only[..2], 2, 1);

		remove_nonalphnum1 := regexreplace('[^AMP0-9]', a, '');
		remove_nonalphnum2 := regexreplace('[^AMP0-9]', time_only[3..], '');

		remove_nonalphnum := remove_nonalphnum1 + remove_nonalphnum2;

		ampm 							:= regexreplace('[^AMP]', remove_nonalphnum, '')[..2];
		has_ampm					:= ampm in ['AM','PM'];

		numbs							:= regexreplace('[^0-9]', remove_nonalphnum, '');
		
		hr								:= (integer)numbs[..2];
		
		hr_ampm						:= intformat(map(~has_ampm => hr,
														 has_ampm and ampm = 'AM' and hr < 12 => hr,
														 has_ampm and ampm = 'AM' and hr = 12 => 0,
														 has_ampm and ampm = 'PM' and hr < 12 => hr + 12, 
														 has_ampm and ampm = 'PM' and hr = 12 => 12, 
														 99), 2, 1);
														 
		dt_hr := trim(dt, all)[..8] + ' ' + trim(((string)hr_ampm + numbs[3..8] + '00000000'), all)[..8];

		return dt_hr;
	end;

	export clean_dob(string orig_dob) := function
		clean_yr := map((unsigned8)orig_dob[1..4] between ((unsigned8)ut.getdate[1..4]) - 123 and (unsigned8)ut.getdate[1..4] => orig_dob[1..4], '0000');
		clean_mn := map(orig_dob[5..6] between '01' and '12' => orig_dob[5..6], '00');
		clean_dy := map(clean_mn <> '00' and clean_yr <> '0000' and (unsigned8)orig_dob[7..8] between 1 and ut.Month_Days((unsigned8)(clean_yr+clean_mn)) => orig_dob[7..8],
							clean_mn in ['01','03','05','07','08','10','12'] and orig_dob[7..8] between '01' and '31' => orig_dob[7..8],
							clean_mn in ['04','06','09','11'] and orig_dob[7..8] between '01' and '30' => orig_dob[7..8],
							clean_mn = '02' and orig_dob[7..8] between '01' and '29' => orig_dob[7..8],
							'00');
							
		return stringlib.stringfindreplace(clean_yr + clean_mn + clean_dy, '00000000', '');
	end;

	export repflag(string function_description, string orig_lname, string orig_full_name)
		:=  map(function_description = 'BUSINESS INSTANT ID' and (orig_lname <> '' or orig_full_name <> '') => 'Y', '');

	export fraudback(string function_description, string orig_ip_address)
		:= map(stringlib.stringfind(function_description, 'CHARGEBACK',1) > 0
				or stringlib.stringfind(function_description, 'FRAUDPOINT',1) > 0 => ORIG_IP_ADDRESS, ''); // for PERSON_ORIG_IP_ADDRESS1
				
	export common_clean_layout := record
		STRING	SOURCE_FILE;
		STRING	ORIG_IP_ADDRESS;
		STRING	ORIG_IP_ADDRESS2;
		STRING	ORIG_FULL_NAME;
		STRING	ORIG_FNAME;
		STRING	ORIG_MNAME;
		STRING	ORIG_LNAME;
		STRING	ORIG_ADDRESS;
		STRING	ORIG_CITY;
		STRING	ORIG_STATE;
		STRING	ORIG_ZIP;
		STRING	ORIG_COMPANY_NAME;
		STRING	FULLNAME;
		STRING	FULLNAME1 := '';
		STRING	FULLNAME2 := '';
		STRING	LINE1;
		STRING	LINE2;
		STRING	CNAME,
		STRING	CNAME2 := '',
		STRING	CLEAN_NAME;
		STRING	CLEAN_ADDR;
		STRING	CLEAN_NAME2 := '';
		STRING	CLEAN_ADDR2 := '';
		STANDARD.NAME;				
		STANDARD.ADDR;
		UNSIGNED6	APPENDADL := 0;
		UNSIGNED6	APPENDBDID := 0;
		STRING	APPENDTAXID := '';
		STRING	APPENDSSN := '';

		INQL_v2.LAYOUTS.MBSLAYOUT,
		INQL_v2.LAYOUTS.ALLOWLAYOUT,
		
		STRING	REPFLAG, 
		STRING	SUB_MARKET;
		STRING	PRIMARY_MARKET_CODE;
		STRING	SECONDARY_MARKET_CODE;
		STRING	INDUSTRY_CODE_1;
		STRING	INDUSTRY_CODE_2;
		STRING	VERTICAL;	
		STRING	ADDRESS,
		STRING	SSN,
		STRING	PHONE,
		STRING	WORK_PHONE,
		STRING	COMPANY_PHONE,
		STRING	EMAIL_ADDRESS;
		STRING	DOB,
		STRING	INDUSTRY,
		STRING	DL,
		STRING	DL_STATE,
		STRING	DOMAIN_NAME,
		STRING	EIN,
		STRING	CHARTER_NUMBER,
		STRING	UCC_NUMBER,
		STRING	LINKID,
		STRING	DPPA_PURPOSE,
		STRING	GLB_PURPOSE,
		STRING	FCRA_PURPOSE,
		STRING	DATETIME;
		STRING	LOGIN_HISTORY_ID ;
		STRING	TRANSACTION_ID ;
		STRING	SEQUENCE_NUMBER ;
		STRING	JOB_ID;
		STRING	METHOD ;
		STRING	PRODUCT_CODE;
		STRING	USE;
		STRING	TRANSACTION_TYPE ;
		STRING	FUNCTION_DESCRIPTION,
		STRING	ORIG_VERTICAL;
		STRING	ORIG_COMPANY_ID;
		STRING	ORIG_GLOBAL_COMPANY_ID;
		STRING	ORIG_REFERENCE_CODE;
		STRING	ORIG_TRANSACTION_CODE;
		STRING	ORIG_BUSINESS_NAME;
		STRING	ORIG_UNIQUE_ID;
		STRING	ORIG_DL_PURPOSE;
		STRING	ORIG_GLB_PURPOSE;
		STRING	ORIG_LOGIN_HISTORY_ID;
		STRING	ORIG_STOP_MONITOR;
		STRING	ORIG_SOURCE_CODE := '';
	end;

end;