IMPORT ut, _control;

wuname := 'Weekly - Distributions, Populations, and Audits';

#workunit('name',wuname)

valid_state := ['blocked','compiled','submitted','running'];

d := sort(WorkunitServices.WorkunitList('',,,'','')(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);

active_workunit :=  count(d) > 0;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sc 			:= fileservices.superfilecontents('~thor100_21::out::inquiry_tracking::weekly_historical')[1].name;
		findex 	:= stringlib.stringfind(sc, '::', 3)+2;
		lindex 	:= stringlib.stringfind(sc, '::', 4)-1;

HistoryVersion := sc[findex..lindex]: independent; //version of base file
// HistoryVersion := '20120816' : independent; //version of base file

MakeNewCompCounts := ~fileservices.fileexists('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyids'); //do counts exist?

FirstWeek := (ut.DayOfYear((integer1)ut.GetDate[..4],(integer1)ut.GetDate[5..6],(integer1)ut.GetDate[7..])/7)%4 = 0; // dedup base file every 4 weeks

inq_file := inquiry_acclogs.File_Inquiry_MBS( ~(mbs.company_id = '1446154' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201303' and '201304') and //TEMPORARY
											 ~(mbs.company_id = '1590195' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201304' and '201304') and //TEMPORARY
											 ~((mbs.company_id = '1534586' or mbs.global_company_id = '16952912') and search_info.function_description = 'FRAUDPOINT' and search_info.datetime[..6] between '201301' and '201302') and //TEMPORARY
												~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
											 mbs.company_id + mbs.global_company_id <> '');

slim_Entity := record
/* Unique Identifiers */
	string datetime;
	string4 transaction_datey;
	string2 transaction_datem;
	string2 transaction_dated;	
	string transaction_id;
	string sequence_number;
	string login_history_id;
	string source;

/* Customer Information */
	string global_company_id;
	string company_id;
	string product_code;
	string industry;
	string vertical;
	string sub_market;
	string use;
	string product;
	integer4 allowflags;
	boolean opt_out;

/* Search Information */	
	string transaction_type;
	string function_description;

/* Population Stats */
	string stat_type;
	
	string has_full_name;
	string has_first_name;
	string has_middle_name;
	string has_last_name;
	string has_address;
	string has_city;
	string has_state;
	string has_zip;
	string has_linkid;
	string has_ipaddr;
	string has_Personal_Phone;
	string has_Work_Phone;
	string has_Company_Phone;
	string has_DOB;
	string has_SSN;
	string has_EIN;
	string has_Email;
	string has_dl;
	string has_dl_st;

	string has_phone;
	string has_adl;
	string has_bdid;
	string has_appended_ssn;
	string Appended_SSN_Same;

	string has_cname;
	string has_fname;
	string has_lname;
	string err_stat;
	
/* Clean Fields for Comparisons Stats */
	string fname;
	string lname;
	string prim_range;
	string  predir;
	string prim_name;
	string  sec_range;
	string v_city_name;
	string  st;
	string  zip5;
	string  zip4;
	string Personal_Phone;
	string Work_Phone;
	string Company_Phone;
	unsigned DOB;
	string SSN;
	string EIN;
	string Email_Address;
	string dl;
	string dl_st;
	
/* Appended Fields */
	
	unsigned Appended_Adl;
	string Appended_SSN;
	unsigned Appended_BDID;
	
	
	string allowflags_translation;

end;


slim_Entity t_map_slim (inq_file le) := transform
								
	boolean is_business := trim(le.Bus_Q.CName + 
								le.Bus_Q.Address + 
								le.Bus_Q.City + 
								le.Bus_Q.State + 
								le.Bus_Q.Zip + 
								le.Bus_Q.Company_Phone + 
								le.Bus_Q.EIN, all)  <> '' and 
								trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) = ''
								;
	boolean is_buser := trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) <> '';
								
		boolean is_person := ((~is_business and ~is_buser) or trim(
								le.Person_Q.Full_Name + 
								le.Person_Q.First_Name + 
								le.Person_Q.Middle_Name + 
								le.Person_Q.Last_Name + 
								le.Person_Q.Address + 
								le.Person_Q.City + 
								le.Person_Q.State + 
								le.Person_Q.Zip + 
								le.Person_Q.Personal_Phone + 
								le.Person_Q.Work_Phone + 
								le.Person_Q.DOB + 
								le.Person_Q.DL + 
								le.Person_Q.DL_St +
								le.Person_Q.Email_Address + 
								le.Person_Q.SSN, all)  <> '');

		self.Appended_ssn 	:= map(is_person => le.Person_Q.Appended_ssn,
									is_buser => le.BusUser_Q.Appended_ssn,
								 '');								
		self.Appended_Adl 	:= map(is_person => le.Person_Q.Appended_Adl,
									is_buser => le.BusUser_Q.Appended_Adl,
								 0);
		self.Appended_BDID 	:= map(is_business or is_buser => le.Bus_Q.Appended_BDID,
									0);
		self.prim_range   	:= map(is_person => le.Person_Q.prim_range,
																is_business => le.Bus_Q.prim_range,
																is_buser => le.BusUser_Q.prim_range,
																'');
		self.predir 		:= map(is_person => le.Person_Q.predir,
								   is_business => le.Bus_Q.predir,
									 is_buser => le.BusUser_Q.predir,
																'');
		self.prim_name 		:= map(is_person => le.Person_Q.prim_name,
								   is_business => le.Bus_Q.prim_name,
									 is_buser => le.BusUser_Q.prim_name,
								   '');
		self.sec_range 		:= map(is_person => le.Person_Q.sec_range ,
								   is_business => le.Bus_Q.sec_range ,
									 is_buser => le.BusUser_Q.sec_range,
								   '');
		self.v_city_name 	:= map(is_person => le.Person_Q.v_city_name ,
								   is_business => le.Bus_Q.v_city_name,
									 is_buser => le.BusUser_Q.v_city_name,
								   '');
		self.st 			:= map(is_person => le.Person_Q.st ,
								   is_business => le.Bus_Q.st,
								   is_buser => le.BusUser_Q.st,
								   '');
		self.zip5 			:= map(is_person => le.Person_Q.zip5 ,
								   is_business => le.Bus_Q.zip5,
									 is_buser => le.BusUser_Q.zip5,
								   '');
		self.zip4 			:= map(is_person => le.Person_Q.zip4 ,
								   is_business => le.Bus_Q.zip4,
									 is_buser => le.BusUser_Q.zip4,
								   '');
		self.err_stat 			:= map(is_person => le.Person_Q.err_stat ,
								   is_business => le.Bus_Q.err_stat,
									 is_buser => le.BusUser_Q.err_stat,
								   '');
		self.Personal_Phone := map(is_person => le.Person_Q.Personal_Phone ,
								   is_buser => le.BusUser_Q.Personal_Phone,
								   '');
		self.Work_Phone		:= map(is_person => le.Person_Q.Work_Phone,
								   '');
		self.Company_Phone	:= map(is_business => le.Bus_Q.Company_Phone,
								   '');						   
		self.DOB			:= map(is_person => (unsigned)le.Person_Q.DOB ,
								   is_buser => (unsigned)le.BusUser_Q.DOB,
								   0);
		self.SSN 			:= map(is_person => le.Person_Q.SSN ,
								   is_buser => le.BusUser_Q.SSN,
								   '');
		self.EIN			:= map(is_business => le.Bus_Q.EIN,
								   '');
		self.Email_Address	:= map(is_person => le.Person_Q.Email_Address,
								   '');
		self.stat_type		:= map(is_person => 'PERSON' ,
								   is_business => 'BUSINESS',
								   is_buser => 'BUSINESS_USER',
								   '');
		self.has_address	:= (string)(self.prim_name <> '' and (self.zip5 <> '' or (self.v_city_name + self.st <> '')));
		self.has_phone		:= (string)(length(trim(self.personal_phone, all)) >= 7 or length(trim(self.company_phone, all)) >= 7 or length(trim(self.work_phone, all)) >= 7);
		self.has_personal_phone		:= (string)(length(trim(self.personal_phone, all)) >= 7);
		self.has_work_phone		:= (string)(length(trim(self.work_phone, all)) >= 7);
		self.has_company_phone		:= (string)(length(trim(self.company_phone, all)) >= 7);
		self.has_adl			:= (string)(self.Appended_Adl > 0);
		self.has_Appended_SSN			:= map((unsigned)self.SSN = 0 => '0',
														 (unsigned)self.SSN[4..] = 0 => '3',
														 (unsigned)self.SSN[6..] = 0 => '5',
														 (unsigned)self.SSN[..5] = 0 => '4',
														 (unsigned)self.SSN[..3] = 0 => '6',
														 '9');
		self.has_ssn			:= map((unsigned)self.SSN = 0 => '0',
														 (unsigned)self.SSN[4..] = 0 => '3',
														 (unsigned)self.SSN[6..] = 0 => '5',
														 (unsigned)self.SSN[..5] = 0 => '4',
														 (unsigned)self.SSN[..3] = 0 => '6',
														 '9');
		self.appended_ssn_same	:= if((unsigned)self.appended_ssn = (unsigned)self.ssn and (unsigned)self.ssn > 0, '1', '0');			
											 
		self.has_bdid			:= (string)(self.Appended_bdid > 0);
		self.has_ein			:= (string)(self.ein <> '');
		self.has_dob			:=if((unsigned)self.DOB=0, '0', '') +
														 if((unsigned)self.DOB[1..4] between 1900 and 2100, 'Y', '') +
														 if((unsigned)self.DOB[5..6] between 01 and 12, 'M', '') +
														 if((unsigned)self.DOB[7..8] between 01 and 31, 'D', '') ;
		self.has_email		:= (string)(self.Email_Address <> '');
		self.opt_out			:= inquiry_acclogs.fnTranslations.is_opt_out(le.allow_flags.allowflags);;
		self.allowflags		:= le.allow_flags.allowflags;
		self.allowflags_translation			:= inquiry_acclogs.fnTranslations.allowflags_str(le.allow_flags.allowflags);;

		self.industry 		:= le.bus_intel.industry;
		self.vertical 		:= le.bus_intel.vertical;
		self.sub_market 	:= le.bus_intel.sub_market;
		self.use 					:= le.bus_intel.use;
		self.product 			:= le.search_info.function_description;
		self.product_code := le.search_info.product_code;
		self.transaction_datey := le.search_info.datetime[..4];	
		self.transaction_datem := le.search_info.datetime[5..6];	
		self.transaction_dated := le.search_info.datetime[7..8];	
		self.source				:= le.source;
		self.global_company_id := le.mbs.global_company_id;
		self.company_id		:= le.mbs.company_id;

		self.transaction_id 				:= le.search_info.transaction_id;
		self.transaction_type 			:= le.search_info.transaction_type;
		self.sequence_number 				:= le.search_info.sequence_number;
		self.function_description		:= le.search_info.function_description;
		self.datetime 							:= le.search_info.datetime;
		self.login_history_id 			:= le.search_info.login_history_id;
		self.lname 									:= le.person_q.lname;
		self.fname 									:= le.person_q.fname;
		self.dl 										:= le.person_q.dl;
		self.dl_st 									:= le.person_q.dl_st;

		self.has_full_name							:= (string)(le.person_q.full_name <> '');
		self.has_first_name							:= (string)(le.person_q.first_name <> '');
		self.has_middle_name						:= (string)(le.person_q.middle_name <> '');
		self.has_last_name							:= (string)(le.person_q.last_name <> '');
		self.has_city										:= (string)(le.person_q.city <> '');
		self.has_state									:= (string)(le.person_q.state <> '');
		self.has_zip										:= (string)(le.person_q.zip <> '');
		self.has_linkid									:= (string)(le.person_q.linkid <> '');
		self.has_ipaddr									:= (string)(le.person_q.ipaddr <> '');
		self.has_dl											:= (string)(le.person_q.dl <> '');
		self.has_dl_st									:= (string)(le.person_q.dl_st <> '');
		self.has_cname									:= (string)(le.bus_q.cname <> '');
		self.has_fname									:= (string)(le.person_q.fname <> '');
		self.has_lname									:= (string)(le.person_q.lname <> '');
	  self := le;
	end;

prep_slim_inq := project(inq_file, t_map_slim(left)) : independent;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

slim_inq := distribute(prep_slim_inq, 
						hash(global_company_id, company_id, transaction_datey, transaction_datem, transaction_dated, stat_type, product, source, product_code, has_address, has_phone, has_adl, has_bdid));
									
prefix_comprehensive_table := table(slim_inq, {global_company_id, company_id, transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out,
															cnt := count(group)},
															global_company_id, company_id, transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out, local);

pcomprehensive_table_yyyymmdd := join(prefix_comprehensive_table, dedup(inquiry_acclogs.File_Function_Description_Rollups,rollup_string,all),
															regexreplace('[^A-Z0-9]', left.product, '') = right.rollup_string,
															transform({recordof(prefix_comprehensive_table)},
																self.product := if(right.rollup_string <> '', right.selected_version, left.product);
																self := left), lookup, left outer)
																: independent;

comprehensive_table_yyyymmdd				:=	table(pcomprehensive_table_yyyymmdd, 
																		{transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out,
																		 cntsum := sum(group, cnt)},
																		 transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out, few)
															;
	
comprehensive_table_yyyymmdd_only		:=	table(pcomprehensive_table_yyyymmdd, 
																		{transaction_datey, transaction_datem, source, product_code,
																		 cntsum := sum(group, cnt)},
																		 transaction_datey, transaction_datem, source, product_code, few)
															;

comprehensive_table_nodate 					:= table(pcomprehensive_table_yyyymmdd, 
																		{stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out, 
																		 cntsum := sum(group, cnt)},
																		 stat_type, industry, vertical, sub_market,use, product, source, product_code, has_ssn, has_email, has_ein, has_dob, has_address, has_phone, has_adl, has_bdid, opt_out, few)
															;

comprehensive_table_blankindustry		:=	table(pcomprehensive_table_yyyymmdd(industry = ''), 
																		{global_company_id, company_id, transaction_datey, transaction_datem, vertical, sub_market,use, source, product_code,
																		 cntsum := sum(group, cnt)},
																		 global_company_id, company_id, transaction_datey, transaction_datem, vertical, sub_market,use, source, product_code, few)
															;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

top100 := dataset([{'1420464','ACCOUNTNOW INC'},
										{'1400764','ACS STATE & LOCAL SOLUTIONS, INC'},
										{'1240494','ADVANTAGE CREDIT BUREAU'},
										{'1523430','ADVANTAGE CREDIT BUREAU'},
										{'1542285','ADVANTAGE CREDIT BUREAU'},
										{'101160','ALLY MORTGAGE CORPORATION'},
										{'112425','AMERICAN CREDIT ACCEPTANCE'},
										{'1535225','AMERICAN EXPRESS'},
										{'100990','AMERICAN EXPRESS'},
										{'1498780','AMERICAN EXPRESS..'},
										{'1385345','AMERICAN EXPRESS-SALT LAKE CITY'},
										{'101742','AMERICREDIT FINANCIAL SERVICES'},
										{'1245081','ATMOS ENERGY'},
										{'101761','ATMOS ENERGY - DEVELOPMENT'},
										{'1379995','AVANTE TELAVANCE CHECK N GO'},
										{'1502670','AVON PRODUCTS'},
										{'1486294','BANK OF AMERICA - INVESTIGATIVE SERVICES'},
										{'1487384','BANK OF AMERICA...'},
										{'1470264','BANK OF NEW YORK MELLON'},
										{'1372044','BB & T CORPORATION'},
										{'101000','BEST BUY CORP CAMPUS'},
										{'101010','CAPITAL ONE'},
										{'1425734','CAR.COM INC (AUTOBYTEL)'},
										{'1527185','CASH CURE LLC'},
										{'1316831','CASH EXPRESS, LLC'},
										{'101130','CHASE CARD SERVICES'},
										{'106506','CHEX SYSTEMS INC.'},
										{'1159810','CL VERIFY CREDIT SOLUTIONS, LLC'},
										{'1403644','COLUMBUS DATA SERVICES'},
										{'1502245','CREDIT ACCEPTANCE CORP'},
										{'105586','CRESCENT BANK & TRUST'},
										{'1378524','CSC CREDIT SERVICES INC'},
										{'1488240','CSC CREDIT SERVICES INC.'},
										{'1480235','DAC FINANCE LLC'},
										{'1522205','DATAX LTD..'},
										{'101661','DECISIONING SOLUTIONS'},
										{'101040','DELL COMPUTER CORPORATION'},
										{'105616','DRIVETIME AUTOMOTIVE GROUP INC'},
										{'1512350','DST SYSTEMS'},
										{'1400630','EDATA SOLUTIONS, LLC'},
										{'101060','EQUIFAX'},
										{'1166160','ETRADE FINANCIAL CORP'},
										{'101070','FACTUAL DATA'},
										{'1434334','FIND YOUR CUSTOMERS INC'},
										{'101100','FIRST DATA SOLUTIONS'},
										{'1488800','FISERV AUTOMOTIVE SOLUTIONS GROUP'},
										{'1460324','GE CAPITAL AMERICAS'},
										{'101140','GE MONEY AMERICAS PA LOCATION'},
										{'1334365','GECC INC'},
										{'1343334','GENEVA ROTH VENTURES, INC.'},
										{'1471150','GLOBAL PROCESSING SOLUTIONS, LLC/GLOBAL CLIENT SOLUTIONS, LLC'},
										{'1383125','GREEN DOT CORP'},
										{'1387294','HIGHER ONE'},
										{'101210','HP SHOPPING'},
										{'1509335','I2C INC'},
										{'1573755','IBO CREDIT SERVICES'},
										{'1524195','ILD CORP'},
										{'1192190','INTERSECTIONS, INC.'},
										{'1459214','JP MORGAN CHASE - EFS DIVISION'},
										{'101270','KEYBANK N.A.'},
										{'1490524','KOUNT INC- WHITE LABEL TEST'},
										{'1216650','LEXIS NEXIS SPECIAL XML ONLY ACCOUNT'},
										{'1428270','LPL FINANCIAL CORP'},
										{'1211080','LTS MANAGEMENT SERVICES, LLC'},
										{'104596','MICROBILT'},
										{'1454874','MORGAN STANLEY SMITH BARNEY'},
										{'1485524','NATIONAL PAYMENT CARD ASSOCIATION'},
										{'1387534','NETSPEND'},
										{'1441864','NFINANSE INC'},
										{'1491334','OPTUMHEALTH BANK, INC'},
										{'1258654','PARO DECISION SUPPORT LLC'},
										{'1289801','PAYMENT ONE CORPORATION'},
										{'1429754','PAYPAL, INC.'},
										{'1447684','PIEDMONT NATURAL GAS COMPANY INC'},
										{'1453944','PNC BANK'},
										{'1414855','PRECASH INC'},
										{'1424314','PRESTIGE FINANCIAL'},
										{'101611','REGIONAL ACCEPTANCE CORPORATION'},
										{'1443234','RELAYHEALTH'},
										{'105636','REPUBLIC BANK & TRUST CO DBA TAX REFUND SOLUTIONS'},
										{'1104341','REPUBLIC BANK & TRUST COMPANY - TAX REFUND SOLUTIONS'},
										{'1501335','SANTA BARBARA TAX PRODUCT GROUP'},
										{'103201','SANTANDER CONSUMER USA INC DBA DRIVE FINANCIAL SERVICES'},
										{'1481410','SPRINT - CO'},
										{'1417740','SPRINT - DENVER'},
										{'1506390','STEVEN M. WELLS, LLC'},
										{'1498244','SURE ADVANCE LLC'},
										{'101510','TARGET NATIONAL BANK'},
										{'1447270','TD BANKNORTH NA.'},
										{'104041','TELETRACK, INC'},
										{'1418210','THE BANCORP, INC.'},
										{'1398670','THE HUNTINGTON NATIONAL BANK'},
										{'1446154','TRACFONE WIRELESS INC'},
										{'1440244','TXVIA INC'},
										{'1408235','UNIRUSH LLC'},
										{'1499035','UVEST FINANCIAL SERVICES GROUP'},
										{'103661','VALUED SERVICES LLC'},
										{'1512510','WACHOVIA BANK'},
										{'1415885','WEBSTER FINANCIAL CORPORATION'},
										{'1498125','WESTERN UNION LLC'},
										{'101560','WFS / WELLS FARGO DEALER SERVICES'},
										{'1520395','XOOM CORPORATION'}], {string company_id, string mbs_company_name});

sTop102 := set(top100, company_id);

filtMBS := table(dedup(inquiry_acclogs.File_MBS.File(company_id in sTop102), gc_id, all), {mbs_company_name, translation, gc_id}, 
							mbs_company_name, gc_id, few);

pflagged := table(prep_slim_inq, 
														 {transaction_datey;
															transaction_datem;
															transaction_dated;
															global_company_id;
															company_id;
															product_code;
															allowflags_translation;
															use;
															source;
															product;
															stat_type;
															has_Full_Name;
															has_First_Name;
															has_Middle_Name;
															has_Last_Name;
															has_Address;
															has_City;
															has_State;
															has_Zip;
															has_Personal_Phone;
															has_Work_Phone;
															has_DOB;
															has_DL;
															has_DL_St;
															has_Email;
															has_SSN;
															has_LinkID;
															has_IPAddr; 
															has_cname;
															has_fname;
															has_lname;
															err_stat;
															has_adl;
															has_appended_ssn;
															appended_ssn_same;
															data16 result_id := '';
															});
															
create_id := project(pflagged,
														transform({recordof(pflagged)},
															self.result_id		:= hashmd5(
																											left.stat_type +
																											left.has_Full_Name +
																											left.has_First_Name +
																											left.has_Middle_Name +
																											left.has_Last_Name +
																											left.has_Address +
																											left.has_City +
																											left.has_State +
																											left.has_Zip +
																											left.has_Personal_Phone +
																											left.has_Work_Phone +
																											left.has_DOB +
																											left.has_DL +
																											left.has_DL_St +
																											left.has_Email +
																											left.has_SSN +
																											left.has_LinkID +
																											left.has_IPAddr +
																											left.has_cname +
																											left.has_fname +
																											left.has_lname +
																											left.err_stat +
																											left.has_adl +
																											left.has_appended_ssn +
																											left.appended_ssn_same);
																self := left));

dFlagged := distribute(create_id, hash(transaction_datey, transaction_datem, transaction_dated, source, global_company_id, company_id, product_code, product, result_id));

comprehensive_population_stats := 
						table(dFlagged, {transaction_datey, transaction_datem, transaction_dated, source, global_company_id, company_id, product_code, use, product,
															stat_type, allowflags_translation, has_Full_Name, has_First_Name, has_Middle_Name, has_Last_Name, 
															has_Address, has_City, has_State, has_Zip, 
															has_Personal_Phone, has_Work_Phone, has_DOB, has_DL, has_DL_St, has_Email, has_SSN, 
															has_LinkID, has_IPAddr, 
															has_cname, has_fname, has_lname, err_stat, has_adl, has_appended_ssn, appended_ssn_same,
															cntsum := count(group), result_id},
															transaction_datey, transaction_datem, transaction_dated, source, global_company_id, company_id, product_code, use, product, result_id, local)
															: independent;

comprehensive_population_stats_slimmed := table(comprehensive_population_stats(stat_type = 'PERSON' and company_id in sTop102), 
														{transaction_datey, transaction_datem, global_company_id, company_id, product_code, use, 
															allowflags_translation, has_Full_Name, has_First_Name, has_Middle_Name, has_Last_Name, 
															has_Address, has_City, has_State, has_Zip, 
															has_Personal_Phone, has_Work_Phone, has_DOB, has_DL, has_DL_St, has_Email, has_SSN, 
															has_LinkID, has_IPAddr, 
															has_cname, has_fname, has_lname, err_stat, has_adl, has_appended_ssn, appended_ssn_same, 
															cntsum2 := sum(group, cntsum)},
																transaction_datey, transaction_datem, global_company_id, company_id, product_code, use, 
																has_Full_Name, has_First_Name, has_Middle_Name, has_Last_Name, 
																has_Address, has_City, has_State, has_Zip, 
																has_Personal_Phone, has_Work_Phone, has_DOB, has_DL, has_DL_St, has_Email, has_SSN, 
																has_LinkID, has_IPAddr, 
																has_cname, has_fname, has_lname, err_stat, has_adl, has_appended_ssn, appended_ssn_same, local);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Trim_MBSFile := table(inquiry_acclogs.File_MBS.File, {company_name := mbs_company_name,
																											global_company_id := gc_id, company_id, product_id,sub_acct_id,
																											industry, vertical, use, translation},
																											mbs_company_name,
																											gc_id, company_id, product_id,sub_acct_id,
																											industry, vertical, use, translation, few);
																											
comp_stats := dataset('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyids', recordof(pcomprehensive_table_yyyymmdd), csv(separator('\t')));

Trim_Comp_stats := table(comp_stats, {cntsum := sum(group, cnt), global_company_id, company_id, product_code},
																			global_company_id, company_id, product_code, few);
																			
MBS_Audit_Jn1 := join(Trim_Comp_stats(global_company_id <> ''), Trim_MBSFile(global_company_id <> ''),
										left.global_company_id= right.global_company_id, left outer);
										
MBS_Audit_Jn2 := join(Trim_Comp_stats(global_company_id = ''), Trim_MBSFile(global_company_id = ''),
										left.company_id= right.company_id and
										left.product_code= right.product_id, left outer);
										
MBS_Audit_Jn := MBS_Audit_Jn1 + MBS_Audit_Jn2;
										
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mxDT := max(pcomprehensive_table_yyyymmdd(transaction_datey+transaction_datem <= ut.getdate[..6]),transaction_datey+transaction_datem);

subtract_months(string c, integer b) := FUNCTION
	Year :=	MAP((integer)c[5..6] - b between -11 and 0 => (integer)c[..4] - 1, 
							(integer)c[5..6] - b > 0 => (integer)c[..4],
							(integer)c[..4] - 2);
	Month := MAP((integer)c[5..6] - b > 0 => (integer)c[5..6] - b,
							 (integer)c[5..6] - b = 0 => 12,
							 12 + ((integer)c[5..6] - b) % 12);
RETURN (STRING)Year+INTFORMAT(Month, 2, 1)+C[7..];
END;							 

header_t := dataset([{'SOURCE',0,'NEWEST DATE','GLOBAL CID','COMPANY ID','PRODUCT CODE','PRODUCT','VERTICAL','INDUSTRY','SUB MARKET', 'USE', 'OPT OUT',
										subtract_months(mxDT, 0),subtract_months(mxDT, 1),subtract_months(mxDT, 2),subtract_months(mxDT, 3),subtract_months(mxDT, 4),
										subtract_months(mxDT, 5),subtract_months(mxDT, 6),subtract_months(mxDT, 7),subtract_months(mxDT, 8),subtract_months(mxDT, 9),
										subtract_months(mxDT, 10),subtract_months(mxDT, 11),subtract_months(mxDT, 12),subtract_months(mxDT, 13),subtract_months(mxDT, 14),
										subtract_months(mxDT, 15),subtract_months(mxDT, 16),subtract_months(mxDT, 17),subtract_months(mxDT, 18),subtract_months(mxDT, 19),
										subtract_months(mxDT, 20),subtract_months(mxDT, 21),subtract_months(mxDT, 22),subtract_months(mxDT, 23)}], 
										{STRING8 SOURCE, UNSIGNED8 total, STRING15 newest_date, STRING10 global_company_id, STRING10 company_id , STRING12 product_code , 
										 STRING30 product , STRING30 vertical , STRING30 industry , STRING30 sub_market , 
										 STRING10 use , STRING11 opt_out , UNSIGNED8 MonthBack_0 , UNSIGNED8 MonthBack_1 , UNSIGNED8 MonthBack_2 , UNSIGNED8 MonthBack_3 , 
											UNSIGNED8 MonthBack_4 , UNSIGNED8 MonthBack_5 , UNSIGNED8 MonthBack_6 , UNSIGNED8 MonthBack_7 , UNSIGNED8 MonthBack_8 , 
											UNSIGNED8 MonthBack_9 , UNSIGNED8 MonthBack_10 , UNSIGNED8 MonthBack_11 , UNSIGNED8 MonthBack_12 , UNSIGNED8 MonthBack_13 , 
											UNSIGNED8 MonthBack_14 , UNSIGNED8 MonthBack_15 , UNSIGNED8 MonthBack_16 , UNSIGNED8 MonthBack_17 , UNSIGNED8 MonthBack_18 , 
											UNSIGNED8 MonthBack_19 , UNSIGNED8 MonthBack_20 , UNSIGNED8 MonthBack_21 , UNSIGNED8 MonthBack_22 , UNSIGNED8 MonthBack_23});


t := table(pcomprehensive_table_yyyymmdd(subtract_months(mxDT, 23) <= transaction_datey+transaction_datem), 
							{STRING8 SOURCE := 'NONFCRA', UNSIGNED8 TOTAL := sum(group, cnt), STRING15 newest_date := max(group, transaction_datey+transaction_datem+transaction_dated), 
							 STRING10 global_company_id := global_company_id, STRING10 company_id := company_id, STRING12 product_code := product_code, STRING30 product := product, 
							 STRING30 vertical := vertical, STRING30 industry := industry, STRING30 sub_market := sub_market, STRING10 use := use, STRING11 opt_out := opt_out,
										UNSIGNED8 MonthBack_0 := sum(group, IF(subtract_months(mxDT, 0) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_1 := sum(group, IF(subtract_months(mxDT, 1) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_2 := sum(group, IF(subtract_months(mxDT, 2) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_3 := sum(group, IF(subtract_months(mxDT, 3) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_4 := sum(group, IF(subtract_months(mxDT, 4) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_5 := sum(group, IF(subtract_months(mxDT, 5) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_6 := sum(group, IF(subtract_months(mxDT, 6) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_7 := sum(group, IF(subtract_months(mxDT, 7) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_8 := sum(group, IF(subtract_months(mxDT, 8) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_9 := sum(group, IF(subtract_months(mxDT, 9) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_10 := sum(group, IF(subtract_months(mxDT, 10) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_11 := sum(group, IF(subtract_months(mxDT, 11) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_12 := sum(group, IF(subtract_months(mxDT, 12) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_13 := sum(group, IF(subtract_months(mxDT, 13) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_14 := sum(group, IF(subtract_months(mxDT, 14) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_15 := sum(group, IF(subtract_months(mxDT, 15) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_16 := sum(group, IF(subtract_months(mxDT, 16) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_17 := sum(group, IF(subtract_months(mxDT, 17) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_18 := sum(group, IF(subtract_months(mxDT, 18) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_19 := sum(group, IF(subtract_months(mxDT, 19) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_20 := sum(group, IF(subtract_months(mxDT, 20) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_21 := sum(group, IF(subtract_months(mxDT, 21) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_22 := sum(group, IF(subtract_months(mxDT, 22) = transaction_datey+transaction_datem, cnt, 0)), 
										UNSIGNED8 MonthBack_23 := sum(group, IF(subtract_months(mxDT, 23) = transaction_datey+transaction_datem, cnt, 0))
										},
							 company_id, product_code, product, vertical, industry, sub_market, opt_out, use, few);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


comprehensive_changes_sumary := table(inquiry_acclogs._SCH_NonFCRACountChanges, {status, cid_cnt := count(group, new_dt <> ''), total := sum(group, s), min_dt := min(group, min_), max_dt := max(group, max_), 
									 cid_previous_cnt := count(group, old_dt <> ''), total_previous := sum(group, previous_s), min_dt_previous := min(group, previous_min_), max_dt_previous := max(group, previous_max_)}, status, few);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

despray(string dsnm, string unixnm) := 
fileservices.Despray(dsnm, 
										 _control.IPAddress.bctlpedata10, 
										 '/data/inquiry_data_01/stats/Non_FCRA/'+unixnm,
										 , 
										 , 
										 , 
										 true);
										 
Distribution_Cnts := sequential(
	output(sort(header_t&t, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyid_products',overwrite, csv(heading(single), quote('"'), separator('\t')));
	output(sort(pcomprehensive_table_yyyymmdd, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyids', overwrite, csv(heading(single), quote('"'), separator('\t')));
	output(sort(comprehensive_table_yyyymmdd, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_yyyymmdd', overwrite, csv(heading(single), quote('"'), separator('\t')));
	output(sort(comprehensive_table_nodate, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_nodate', overwrite, csv(heading(single),quote('"'), separator('\t')));
	output(sort(comprehensive_table_yyyymmdd_only, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_yyyymmdd_only', overwrite, csv(heading(single),quote('"'), separator('\t'), heading(single)));
	output(sort(comprehensive_table_blankindustry, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_blankindustry', overwrite, csv(heading(single),quote('"'), separator('\t'), heading(single)));
	output(sort(comprehensive_changes_sumary, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_changessummary', overwrite, csv(heading(single),quote('"'), separator('\t'), heading(single)));
	output(sort(inquiry_acclogs._SCH_NonFCRACountChanges, record),,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_changes', overwrite, csv(heading(single),quote('"'), separator('\t'), heading(single)));

	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyid_products', 'comprehensive_table_companyid_products_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyids', 'comprehensive_table_companyids_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_yyyymmdd', 'comprehensive_table_yyyymmdd_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_nodate', 'comprehensive_table_nodate_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_blankindustry', 'comprehensive_table_blankindustry_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_yyyymmdd_only', 'comprehensive_table_yyyymmdd_only_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_changessummary', 'comprehensive_table_changessummary_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_changes', 'comprehensive_table_changes_'+HistoryVersion+'.csv')

);

Population_Cnts := sequential(

	output(comprehensive_population_stats,,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_population', overwrite, csv(heading(single), quote('"'), separator('\t')));
	output(comprehensive_population_stats_slimmed,,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_populationslim', overwrite, csv(heading(single), quote('"'), separator('\t')));

	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_population', 'comprehensive_table_population_'+HistoryVersion+'.csv'),
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_populationslim', 'comprehensive_table_populationslim_'+HistoryVersion+'.csv')

);

MBSAudit := if(~fileservices.fileexists('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_table_companyids'),
	sequential(
	output(MBS_Audit_Jn,,'~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_mbs_audit', overwrite, csv(heading(single), quote('"'), separator('\t')));
	despray('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_mbs_audit', 'comprehensive_mbs_audit_'+HistoryVersion+'.csv')
	));


DoComprehensive := sequential(Distribution_Cnts, Population_Cnts);
DoMBSAudit 			:= if(~fileservices.fileexists('~thor100_21::out::inquiry_acclogs::'+HistoryVersion+'::comprehensive_mbs_audit'), 
										MBSAudit);

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

IP      := 'bctlpedata10.risk.regn.net';
infiles  := '/data/inquiry_data_01/stats/Non_FCRA/';

eData12FileList := fileservices.RemoteDirectory(IP,infiles,,FALSE)(~regexfind('(fcra)', name));

MoveEData12Files(string name) := function

	del := fileservices.DeleteExternalFile(IP, infiles+'old/'+name); 
	mov := fileservices.MoveExternalFile(IP, infiles+name, infiles+'old/'+name);

RETURN SEQUENTIAL(del, mov);

end;

EXPORT _SCH_NonFCRAComprehensiveStats := SEQUENTIAL(
																					docomprehensive
																				 ,NOTIFY('Comprehensive Complete', 'x')
																				 ,dombsaudit);
// EXPORT _SCH_NonFCRAComprehensiveStats := SEQUENTIAL(APPLY(eData12FileList, MoveEData12Files(name)); docomprehensive; NOTIFY('Comprehensive Complete', 'x'), dombsaudit)
											// : WHEN(CRON('0 10 * * 7'))
											