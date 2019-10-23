import GlobalWatchLists_Preprocess, STD, lib_StringLib, ut, Address, codes;

EXPORT ProcessDeniedPersons := FUNCTION

	GlobalWatchLists_Preprocess.Layouts.rDeniedPersons RemoveDoubleQuote(GlobalWatchLists_Preprocess.Layouts.rDeniedPersons L) := TRANSFORM
		self.Name 						:= STD.Str.FindReplace(L.Name, '"', '');
		self.eff_date 				:= STD.Str.FindReplace(L.eff_date, '"', '');
		self.exp_date 				:= STD.Str.FindReplace(L.exp_date, '"', '');
		self.Standard_Order 	:= STD.Str.FindReplace(L.Standard_Order, '"', '');
		self.Street_Address 	:= STD.Str.FindReplace(L.Street_Address, '"', '');
		self.Federal_Citation := STD.Str.FindReplace(L.Federal_Citation, '"', '');
		self.denial_type 			:= STD.Str.FindReplace(L.denial_type, '"', '');		
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout ParseIndividualCitiations(GlobalWatchLists_Preprocess.Layouts.rDeniedPersons L) := TRANSFORM
		string320 temp_federal_citations :=     STD.Str.FindReplace(
																						STD.Str.FindReplace(
																								regexreplace('[,]+',
																								regexreplace('^, ',
																								regexreplace('( [0-9][0-9] FR)|( [0-9][0-9] F.R.)|(NEW F.R.)|(FED REG NOT)',
																						STD.Str.FindReplace(
																						STD.Str.FindReplace(
																								regexreplace('FEDERAL REGISTER NOTICE TO BE PUBLISHED SOON|NEW F.R. NOTICE TO BE PUBLISHED SOON|NEW F.R. TO BE PUBLISHED SOON'
                                                    ,TRIM(L.Federal_Citation, left, right), 'FED REG NOTICE TO BE PUBLISHED SOON')
                                            ,'Appropriate Federal Register Citations: ', '')
                                            ,' and ', ' ')
																										,',&')
																										,'')
																										,',')
																						,'9/27/04 F.R. 77177'
																						,'9/27/04, F.R. 77177')
																						,'9/21/06 F.R. 55163'
																						,'9/21/06, F.R. 55163');
		
		v_fed_cit_count := if(TRIM(temp_federal_citations, left, right) <> '', length(STD.Str.Filter(temp_federal_citations, ',')) + 1, 0);
		string10 padding := ',,,,,,,,,,';
		
		self.mod_citation := L.Federal_Citation;
		self.Federal_Citation := TRIM(TRIM(temp_federal_citations, left, right) + if(10 - v_fed_cit_count > 0, padding[1..10 - v_fed_cit_count], ''), left, right);
		self := L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout1 AssignValues(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout L, INTEGER Ctr) := TRANSFORM
		self.ent_key 						:= 'DPL' + INTFORMAT(Ctr, 3, 1);
		self.source 							:= 'US Bureau of Industry and Security - Denied Person List';
		self.lst_vend_upd 	:= GlobalWatchlists_Preprocess.Versions.DeniedPersons_Version;
		self.lstd_entity 		:= if(length(TRIM(L.Name, left, right)) > 54 and STD.Str.Find(TRIM(L.Name, left, right), ',', 1) > 1
																											,TRIM(L.Name, left, right)[1..STD.Str.Find(TRIM(L.Name, left, right), ',', 1)-1]
																											,TRIM(L.Name, left, right));
		TempAddr1								:= L.Street_Address[1..STD.Str.Find(L.Street_Address, ',', 1)-1];
		self.address_1 		:= IF(REGEXFIND('P.OBOX|P.O. [0-9]+',TempAddr1,NOCASE), REGEXREPLACE('P.OBOX|P.O. ',TempAddr1,'PO BOX ', NOCASE),TempAddr1);
		TempAddr2 							:= STD.Str.FindReplace(
																STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(TRIM(L.Street_Address[STD.Str.Find(L.Street_Address, ',', 1)+2..200 + STD.Str.Find(L.Street_Address, ',', 1)+2-1], left, right),
																				'CORNER OF 7TH NARENJESTAN', 'CORNER 7TH NARENJESTAN'),
																		 'AVENUE', 'AVE'),
																	 'SQUARE', 'SQ'),
																 ', ', ','),
															 '. ', '');
		self.address_2					:= REGEXREPLACE('P.OBOX',TempAddr2,'PO BOX ', NOCASE);
		integer WordCount				:= STD.Str.FindCount(L.Street_Address,',');
		TempZip									:= trim(REGEXFIND('[0-9]+(-)*[0-9]*$',trim(L.Street_Address,left,right),0),left,right);
		TempCountry 						:= IF(REGEXFIND('[0-9]$',trim(L.Street_Address,left,right)),L.Street_Address[STD.Str.Find(L.Street_Address,',',WordCount)-2..],
																L.Street_Address[length(L.Street_Address)-1..2 + length(L.Street_Address)-1-1]);
		self.country						:= IF((length(TempZip) = 5 or length(TempZip) = 10) and codes.valid_st(TempCountry),'US',TempCountry);
		self.eff_date 					:= L.eff_date;
		self.exp_date 					:= L.exp_date;
		self.standard_order 		:= L.Standard_Order;
		self.mod_citation 			:= L.mod_citation;
		
		set of string words 		:= STD.STr.SplitWords(L.Federal_Citation, ',');
		self.Federal_Citation_1 := if(length(TRIM(words[1], left, right)) > 35
																,words[1][1..35]
																,TRIM(words[1], left, right));
		self.Federal_Citation_2 := TRIM(words[2], left, right)[1..35];
		self.Federal_Citation_3 := TRIM(words[3], left, right)[1..35];
		self.Federal_Citation_4 := TRIM(words[4], left, right)[1..35];
		self.Federal_Citation_5 := if(length(words[5]) > 35 
																	,TRIM(words[5][1..STD.Str.Find(words[5], '/04', 1) +3], left, right)
																	,TRIM(words[5], left, right)[1..35]);
		self.Federal_Citation_6 := if(length(words[5]) > 35
																	,TRIM(words[5][STD.Str.Find(words[5],'/04') + 3..35 + STD.Str.Find(words[5],'/04') + 3 - 1], left, right)
																	,TRIM(words[6], left, right));
		self.Federal_Citation_7 := if(length(words[5]) > 35
																	,TRIM(words[6], left, right)[1..35]
																	,TRIM(words[7], left, right)[1..35]);
		self.Federal_Citation_8 := if(length(words[5]) > 35
																	,TRIM(words[7], left, right)
																	,TRIM(words[8], left, right)[1..35]);
		self.Federal_Citation_9 := if(length(words[5]) > 35
																	,TRIM(words[8], left, right)
																	,TRIM(words[9], left, right));
		self.Federal_Citation_10:= if(length(words[5]) > 35
																	,TRIM(words[9], left, right)
																	,TRIM(words[10], left, right)[1..35]);
		self.orig_raw_name			:= ut.CleanSpacesAndUpper(L.Name);
	END;
	
	DeniedPersons := PROJECT(PROJECT(PROJECT(GlobalWatchLists_Preprocess.Files.dsDeniedPersons(Name <> ''),
																RemoveDoubleQuote(left))(TRIM(Name , left, right) <> ''), ParseIndividualCitiations(left))(Name <> 'Name and Address' and  eff_date <> 'Effective Date'), AssignValues(left, counter));

	GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout2 USDPNameANDaddress(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout1 L) := TRANSFORM
		v_name_cleaned 			:= if(STD.Str.Find(L.lstd_entity, ',', 1) > 0
															,Address.CleanPersonLFM73(STD.Str.FindReplace(
																													STD.Str.FindReplace(L.lstd_entity
																													,' P.M.', '')
																												,'M.E.I. JAPAN', ''))
															,Address.CleanPersonFML73(L.lstd_entity));
		
		self.the_name.name_prefix				:= v_name_cleaned[1..5];
		self.the_name.name_first				:= v_name_cleaned[6..25];
		self.the_name.name_middle				:= v_name_cleaned[26..45];
		self.the_name.name_last					:= v_name_cleaned[46..65];
		self.the_name.name_suffix				:= v_name_cleaned[66..70];
		self.the_name.name_score				:= v_name_cleaned[71..73];
		self.the_name.name							:= v_name_cleaned;
														
		Templine1 			  := REGEXREPLACE('^C/O(.*)|^INMATE(.*)|^REGIST(.*)|^USM(.*)|(.*)FEDERAL CORRECTION(.*)|(.*)COUNTY JAIL|^(.*)FDC|^NO. [0-9]+(.*)',
													STD.Str.FindReplace(
														STD.Str.FindReplace(ut.CleanSpacesAndUpper(L.Address_1), 'UPON THE DATE OF THE ORDER INCARCERATED AT ', ''),
													'CURRENTLY INCARCERATED AT:',''),
												 ' ');
		Templine2					:= REGEXREPLACE('^,|^-',
														REGEXREPLACE('(.*)CORRECTION(.*) INSTITUTION|(.*)CORRECTIONAL INSITUTION|(.*)CORRECTION(.*) INSTITUTE|(.*)DETENTION CENTER|(.*)PENITENTIARY|FCI SEAGOVILLE|(.*)OF PRISON(S)*|FCI SAFFORD'+
																				'|(.*)MEDICAL CENTER|(.*)PRISON CAMP| US,| US$'
														,L.Address_2,'')
													,'');
		string line1			:= IF(trim(Templine1,left,right) = '',Templine2[1..STD.Str.Find(Templine2,',',1)-1],TempLine1);
		string line2 			:= IF(trim(Templine1,left,right) = '',Templine2[STD.Str.Find(Templine2,',',1)+1..],Templine2 + '' + '' + '' + '');
																			
 		string182 clean_addr := Address.CleanAddress182(line1, line2);
		
		self.the_address.prim_range 	:=  clean_addr[1..10];
    self.the_address.predir 			:= 	clean_addr[11..12];
    self.the_address.prim_name 		:= 	clean_addr[13..40];
    self.the_address.addr_suffix 	:= 	clean_addr[41..44];
    self.the_address.postdir 			:= 	clean_addr[45..46];
    self.the_address.unit_desig 	:= 	clean_addr[47..56];
    self.the_address.sec_range 		:= 	clean_addr[57..64];
    self.the_address.p_city_name 	:= 	clean_addr[65..89];
    self.the_address.v_city_name 	:= 	clean_addr[90..114];
    self.the_address.st 					:= 	clean_addr[115..116];
    self.the_address.zip 					:= 	clean_addr[117..121];
    self.the_address.zip4 				:= 	clean_addr[122..125];
    self.the_address.cart 				:= 	clean_addr[126..129];
    self.the_address.cr_sort_sz 	:= 	clean_addr[130];
    self.the_address.lot 					:= 	clean_addr[131..134];
    self.the_address.lot_order 		:= 	clean_addr[135];
    self.the_address.dpbc 				:= 	clean_addr[136..137];
    self.the_address.chk_digit 		:= 	clean_addr[138];
    self.the_address.record_type 	:= 	clean_addr[139..140];
		self.the_address.ace_fips_st 	:= 	clean_addr[141..142];
    self.the_address.fipscounty 	:= 	clean_addr[143..145];
    self.the_address.geo_lat 			:= 	clean_addr[146..155];
    self.the_address.geo_long 		:= 	clean_addr[156..166];
    self.the_address.msa 					:= 	clean_addr[167..170];
    self.the_address.geo_blk 			:= 	clean_addr[171..177];
    self.the_address.geo_match 		:= 	clean_addr[178];
    self.the_address.err_stat 		:= 	clean_addr[179..182];
		self.the_address.address			:= 	clean_addr;
		
		self													:= L;
	END;
	
	DeniedPersonsNameAddress := PROJECT(DeniedPersons, USDPNameANDaddress(left));
	GoodUSAddress := DeniedPersonsNameAddress(TRIM(country, left, right) = 'US'
																										or the_address.geo_lat <> ''
																										or TRIM(the_address.err_stat, left, right) = 'E412');
	BadUSAddress	:= DeniedPersonsNameAddress - GoodUSAddress;
	
	fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
	];
	fmtout := '%Y%m%d';
	
	GlobalWatchLists_Preprocess.rOutLayout ReformatToCommonlayout(GlobalWatchLists_Preprocess.IntermediaryLayoutDeniedPersons.tempLayout2 L) := TRANSFORM
		temp_name := STD.Str.ToUpperCase(TRIM(L.lstd_entity, left, right));
		v_bus_name_flag := if (STD.Str.Find(temp_name, 'ELECTRICAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ELECTRONIC', 1) <> 0 or
		  STD.Str.Find(temp_name, 'NETWORK', 1) <> 0 or
		  STD.Str.Find(temp_name, ' DIGITAL ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TECHNIK ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SHIPPING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TELECOM', 1) <> 0 or
		  STD.Str.Find(temp_name, ' GMBH', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ING. DIETMAR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INTERNATIONAL', 1) <> 0 or
		  STD.Str.Find(temp_name, ' METALS ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TRADE ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' GLOBE ', 1) <> 0 or
		  STD.Str.WildMatch(temp_name, '^GLOBE ', false) <> false or
		  STD.Str.WildMatch(temp_name, '^DATA ', false) <> false or
		  STD.Str.WildMatch(temp_name, '^GLOBAL ',  false) <> false or
		  STD.Str.Find(temp_name, ' INTL ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' INT\'L', 1) <> 0 or
		  STD.Str.Find(temp_name, ' AB ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' AG ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' NV ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COMMUNICATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CORPORATE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ACCOUNTS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AMBULANCE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AMERICAN', 1) <> 0 or
		  STD.Str.Find(temp_name, 'NORTHERN', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SOUTHERN', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ADMINISTRATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ALIGNMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AMUSEMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ANTIQUE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'APARTMENTS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'REVOLUTIONARY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ORGANIZATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ORGANISATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'APLC', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ARCHITECT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ARCHETECT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AIR CONDITIONING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'APPLIANCE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ASSOCIATES') <> 0 or
		  STD.Str.Find(temp_name, 'ASSOCIATION') <> 0 or
		  STD.Str.Find(temp_name, 'AS AGENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AUTOMOTIVE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AVIATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'AIRLINES') <> 0 or
		  STD.Str.Find(temp_name, 'BOOKKEEPING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BOOKBINDER', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BROKERAGE', 1) <> 0 or
		  STD.Str.Find(temp_name, ' BROKERS ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BUILDING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BUSINESS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BOUTIQUE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CHEMICAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COMPUTER', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CORPORATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CORP.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CO.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CARBURETOR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CHIROPRACTIC', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CLEANING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COMPANY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CONSTRUCTION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CONST.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CONSULTANTS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COOPERATIVE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COTRICOM S.A.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CABLEVISION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COMMUNITY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'CMNTY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COMMUNICATIONS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'COUNTRY CLUB', 1) <> 0 or
		  STD.Str.Find(temp_name, ' COUNTY ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' CREDIT ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DEVELOPMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DETROIT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DVLPMNTL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DISTRICT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DISTRIBUTION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DISTRIBUTING', 1) <> 0 or
	   	STD.Str.Find(temp_name, 'DIVISION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ELEVATOR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ENTERPRISE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ENGINEERING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'ESTATES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'EQUIPMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'EQUITY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'EXCAVATING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'EXPRESS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FINANCIAL ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FINANCE ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FABRICATORS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FREIGHTLINER', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FREIGHT ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FULLFILLMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FULFILLMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FUNERAL HOME', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FURNITURE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'GOVERNMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'GVRNMNT', 1) <> 0 or
		  STD.Str.Find(temp_name, ' GROWERS ') <> 0 or
		  STD.Str.Find(temp_name, 'DEVELOPMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'DVLPMNTL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'FREIGHT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'HEALTHCARE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'HELLING KG', 1) <> 0 or
		  STD.Str.Find(temp_name, 'HM-EDV', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INNOVATIVE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'HOSPICE', 1) <> 0 or
		  STD.Str.Find(temp_name, ' HOSPITAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INDUSTRIES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INSTITUTE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INDUSTRIAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INTERNATIONAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INTERIORS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'INVESTMENTS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'KINTRACO', 1) <> 0 or
		  STD.Str.Find(temp_name, 'LABORATOR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'LANDSCAPING', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LEASING ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LEASE ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'LIMITED', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MACHINE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MANAGEMENT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MATUSHITA', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MATSUSHITA', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MISSIONARY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MINISTRIES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MNGMNT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MOBILE PARK', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MOBILE HOME', 1) <> 0 or
		  STD.Str.Find(temp_name, 'MOUNTAIN', 1) <> 0 or
		  STD.Str.Find(temp_name, 'NATIONAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'OPTICAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PACKAGING', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PARTNERSHIP', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PEDIATRICS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PEER REVIEW', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PHARMACY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PHARMACEUTICAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PENSION PLAN', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PRODUCTIONS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PROFESSIONAL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'PROPERTIES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'RAILROAD', 1) <> 0 or
		  STD.Str.Find(temp_name, 'REALTY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'REBUILDERS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'REPAIR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'RESTARAUNT', 1) <> 0 or
		  STD.Str.Find(temp_name, 'RESTAURANT', 1) <> 0 or
			STD.Str.WildMatch(TRIM(temp_name, left, right), '^SATS$', false) <> false or
		  STD.Str.Find(temp_name, 'SAVINGS', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SECURITIES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SEAFOOD', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SERVICES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SOCIETE ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SOLUTION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SPECIALTY', 1) <> 0 or
		  STD.Str.Find(temp_name, ' SQUARE ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SUNITRON', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SYSTEM', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SYSTEM', 1) <> 0 or
		  STD.Str.Find(temp_name, 'STATE BANK', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SPECIALIST', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SPRCNTR', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SCHOOL', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SUPERCENTER', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SUPPLIES', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SUPPLY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'SURGERY', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TELEPHONE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TRAVEL ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TRADE NAME', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TRUCKING', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TRANSPORT ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TECHNOLOG', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TRANSPORTATION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'TRANSMISSION', 1) <> 0 or
		  STD.Str.Find(temp_name, 'UNIVERSITY', 1) <> 0 or
		  STD.Str.Find(temp_name, ' STORAGE ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TRANSFER ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TRANSPORT ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'VALLEY ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'WAREHOUSE', 1) <> 0 or
		  STD.Str.Find(temp_name, 'WELLS FARGO', 1) <> 0 or
		  STD.Str.Find(temp_name, ' AGENCY', 1) <> 0 or
		  STD.Str.Find(temp_name, ' MARKET ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' SALES ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' RADIO', 1) <> 0 or
		  STD.Str.Find(temp_name, ' COUNCIL ') <> 0 or
		  STD.Str.Find(temp_name, ' PARTNERS', 1) <> 0 or
		  STD.Str.Find(temp_name, ' PLAZA', 1) <> 0 or
		  STD.Str.Find(temp_name, ' CLINIC', 1) <> 0 or
		  STD.Str.Find(temp_name, ' CENTER ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' REPAIR ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' SERVICE ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' GROUP ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' TRUST ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' INC ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' INC.', 1) <> 0 or
		  STD.Str.Find(temp_name, ',INC ', 1) <> 0 or
		  STD.Str.Find(temp_name, ',INC. ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LLC', 1) <> 0 or
		  STD.Str.Find(temp_name, ' L L C', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LTD', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LLP', 1) <> 0 or
		  STD.Str.Find(temp_name, ' L L P', 1) <> 0 or
		  STD.Str.Find(temp_name, ' LP', 1) <> 0 or
		  STD.Str.Find(temp_name, ' L.P.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BANK N.A.', 1) <> 0 or
		  STD.Str.Find(temp_name, 'BANK NA', 1) <> 0 or
		  STD.Str.Find(temp_name, ', N.A.', 1) <> 0 or
		  STD.Str.Find(temp_name, ', N. A.', 1) <> 0 or
		  STD.Str.Find(temp_name, ', N A', 1) <> 0 or
		  STD.Str.Find(temp_name, ',N.A.', 1) <> 0 or
		  STD.Str.Find(temp_name, ',N. A.', 1) <> 0 or
		  STD.Str.Find(temp_name, ' PSC', 1) <> 0 or
		  STD.Str.Find(temp_name, ' P S C', 1) <> 0 or
		  STD.Str.Find(temp_name, ' F S B', 1) <> 0 or
			STD.Str.Find(temp_name, 'CITY OF ', 1) <> 0 or
			STD.Str.Find(temp_name, 'COUNTY OF ', 1) <> 0 or
			STD.Str.Find(temp_name, 'STATE OF ', 1) <> 0 or
			STD.Str.Find(temp_name, 'PROVINCE OF ', 1) <> 0 or
		  STD.Str.Find(temp_name, 'LIQUOR ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' CORP ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' OFFICE ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' DELI ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' MOTEL ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' INN ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' USA ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' U S A ', 1) <> 0 or
		  STD.Str.Find(temp_name, ' AND SONS', 1) <> 0 or
		  STD.Str.Find(temp_name, ' & SONS', 1) <> 0 or
		  STD.Str.Find(temp_name, ' THE ', 1) <> 0, 'Y', ' ');
			
			v_keep_lfmname 	:= if(v_bus_name_flag = '' and L.the_name.name_score >= '75', 'Y', ' ');
			v_keep_compname := if(L.the_name.name_last = '' or v_bus_name_flag <> '', 'Y', ' ');
			
			self.pty_key 					:= L.ent_key;
			self.source 					:= L.source;
			self.orig_pty_name 		:= STD.Str.ToUpperCase(L.lstd_entity);
			self.orig_vessel_name := '';
			v_country_name_short 	:= GlobalWatchLists_Preprocess.CodetoCountryNameShort(L.country);
			self.country 					:= if(v_country_name_short <> '',	ut.CleanSpacesAndUpper(v_country_name_short), '');
			self.name_type 				:= '';
			self.addr_1 					:= ut.CleanSpacesAndUpper(L.address_1);
			self.addr_2 					:= ut.CleanSpacesAndUpper(L.address_2);
			self.addr_3 					:= '';
			self.remarks_1 				:= if(L.eff_date <> '', 'EFFECTIVE DATE: ' + L.eff_date, '');
			self.remarks_2 				:= if(L.exp_date <> '', 'EXPIRATION DATE: ' + L.exp_date, '');
			self.remarks_3 				:= if(TRIM(L.mod_citation, left, right) <> '', ut.CleanSpacesAndUpper(L.mod_citation), '');
			self.remarks_4 				:= if(v_country_name_short <> '', 'COUNTRY: ' + ut.CleanSpacesAndUpper(v_country_name_short)
																	,'');
			self.remarks_5 				:= if(TRIM(L.standard_order, left, right) <> '', 'DENIAL ORDER: ' + ut.CleanSpacesAndUpper(L.standard_order), '');
			self.cname_clean 			:= if(v_keep_compname = 'Y', STD.Str.ToUpperCase(L.lstd_entity), '');
			self.pname_clean 			:= if(v_keep_lfmname = 'Y', L.the_name.name, '');
			self.addr_clean 			:= if(L.the_address.err_stat[1..2] <> 'E5' and 
																	L.the_address.err_stat[1..4] <> 'E213' and
																	L.the_address.err_stat[1..4]	<> 'E101', L.the_address.address, '');
			self.date_first_seen 	:= L.lst_vend_upd;
			self.date_last_seen 	:= L.lst_vend_upd;
			self.date_vendor_first_reported := L.lst_vend_upd;
			self.date_vendor_last_reported 	:= L.lst_vend_upd;
			self.orig_first_name 	:= if(v_keep_lfmname = 'Y' and STD.Str.Find(L.lstd_entity, ',', 1) > 0
																		,ut.CleanSpacesAndUpper(L.lstd_entity[STD.Str.Find(L.lstd_entity, ',', 1)+1..54 + STD.Str.Find(L.lstd_entity, ',', 1)+1-1])
																		,'');
			self.orig_last_name 	:= if(v_keep_lfmname = 'Y' and STD.Str.Find(L.lstd_entity, ',', 1) > 0
																		,ut.CleanSpacesAndUpper(L.lstd_entity[1..STD.Str.Find(L.lstd_entity, ',', 1)-1])
																		,'');
			self.orig_aka_id 					:= '';
			self.orig_aka_type 				:= '';
			self.orig_aka_category 		:= '';
			self.orig_giv_designator 	:= if(v_keep_compname = 'Y', 'G', 'I');
			self.orig_address_id 			:= '';
			self.orig_address_line_1 	:= ut.CleanSpacesAndUpper(L.address_1);
			self.orig_address_line_2 	:= ut.CleanSpacesAndUpper(L.address_2);
			self.orig_address_country := ut.CleanSpacesAndUpper(L.country);
			self.orig_effective_date 	:= STD.Date.ConvertDateFormatMultiple(L.eff_date,fmtsin,fmtout);
			self.orig_expiration_date := STD.Date.ConvertDateFormatMultiple(L.exp_date,fmtsin,fmtout);
			self.orig_type_of_denial 	:= ut.CleanSpacesAndUpper(L.standard_order[1..12]);
			self.orig_federal_register_citation_1 := if(STD.Str.Find(L.Federal_Citation_1, '/', 1) = 0
																									,ut.CleanSpacesAndUpper(L.Federal_Citation_1)
																									,ut.CleanSpacesAndUpper(L.Federal_Citation_1[1..STD.Str.Find(L.Federal_Citation_1, '/', 1)-3]));
			self.orig_federal_register_citation_2 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_2[1..STD.Str.Find(L.Federal_Citation_2, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_3 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_3[1..STD.Str.Find(L.Federal_Citation_3, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_4 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_4[1..STD.Str.Find(L.Federal_Citation_4, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_5 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_5[1..STD.Str.Find(L.Federal_Citation_5, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_6 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_6[1..STD.Str.Find(L.Federal_Citation_6, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_7 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_7[1..STD.Str.Find(L.Federal_Citation_7, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_8 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_8[1..STD.Str.Find(L.Federal_Citation_8, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_9 := ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_9[1..STD.Str.Find(L.Federal_Citation_9, '/', 1)-3],'&',''));
			self.orig_federal_register_citation_10:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(L.Federal_Citation_10[1..STD.Str.Find(L.Federal_Citation_10, '/', 1)-3],'&',''));
			tempDate															:= (string)Std.Date.Today();
			CurrentYear														:= tempDate[3..4];
			TempCitationDate1											:= STD.Date.ConvertDateFormatMultiple(if(STD.Str.Find(L.Federal_Citation_1, '/', 1) = 0,''
																																				,TRIM(L.Federal_Citation_1[STD.Str.Find(L.Federal_Citation_1, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_1, '/', 1)-2 - 1],left,right)),fmtsin,fmtout);
			self.orig_federal_register_citation_date_1 := IF(length(TempCitationDate1) = 5, '200'+TempCitationDate1,
																											IF(length(TempCitationDate1) = 6 and TempCitationDate1[1..2] <= CurrentYear,
																											'20'+TempCitationDate1,
																											 IF(length(TempCitationDate1) = 6 and TempCitationDate1[1..2] > CurrentYear,
																											 '19'+TempCitationDate1,TempCitationDate1)));
			TempCitationDate2											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_2[STD.Str.Find(L.Federal_Citation_2, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_2, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_2 := IF(length(TempCitationDate2) = 5, '200'+TempCitationDate2,
																											IF(length(TempCitationDate2) = 6 and TempCitationDate2[1..2] <= CurrentYear,
																											'20'+TempCitationDate2,
																											 IF(length(TempCitationDate2) = 6 and TempCitationDate2[1..2] > CurrentYear,
																											 '19'+TempCitationDate2,TempCitationDate2)));
			TempCitationDate3											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_3[STD.Str.Find(L.Federal_Citation_3, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_3, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_3 := IF(length(TempCitationDate3) = 5, '200'+TempCitationDate3,
																											IF(length(TempCitationDate3) = 6 and TempCitationDate3[1..2] <= CurrentYear,
																											'20'+TempCitationDate3,
																											 IF(length(TempCitationDate3) = 6 and TempCitationDate3[1..2] > CurrentYear,
																											 '19'+TempCitationDate3,TempCitationDate3)));
			TempCitationDate4											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_4[STD.Str.Find(L.Federal_Citation_4, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_4, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_4 := IF(length(TempCitationDate4) = 5, '200'+TempCitationDate4,
																											IF(length(TempCitationDate4) = 6 and TempCitationDate4[1..2] <= CurrentYear,
																											'20'+TempCitationDate4,
																											 IF(length(TempCitationDate4) = 6 and TempCitationDate4[1..2] > CurrentYear,
																											 '19'+TempCitationDate4,TempCitationDate4)));
			TempCitationDate5											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_5[STD.Str.Find(L.Federal_Citation_5, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_5, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_5 := IF(length(TempCitationDate5) = 5, '200'+TempCitationDate5,
																											IF(length(TempCitationDate5) = 6 and TempCitationDate5[1..2] <= CurrentYear,
																											'20'+TempCitationDate5,
																											 IF(length(TempCitationDate5) = 6 and TempCitationDate5[1..2] > CurrentYear,
																											 '19'+TempCitationDate5,TempCitationDate5)));
			TempCitationDate6											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_6[STD.Str.Find(L.Federal_Citation_6, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_6, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_6 := IF(length(TempCitationDate6) = 5, '200'+TempCitationDate6,
																											IF(length(TempCitationDate6) = 6 and TempCitationDate6[1..2] <= CurrentYear,
																											'20'+TempCitationDate6,
																											 IF(length(TempCitationDate6) = 6 and TempCitationDate6[1..2] > CurrentYear,
																											 '19'+TempCitationDate6,TempCitationDate6)));
			TempCitationDate7											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_7[STD.Str.Find(L.Federal_Citation_7, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_7, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_7 := IF(length(TempCitationDate7) = 5, '200'+TempCitationDate7,
																											IF(length(TempCitationDate7) = 6 and TempCitationDate7[1..2] <= CurrentYear,
																											'20'+TempCitationDate7,
																											 IF(length(TempCitationDate7) = 6 and TempCitationDate7[1..2] > CurrentYear,
																											 '19'+TempCitationDate7,TempCitationDate7)));
			TempCitationDate8											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_8[STD.Str.Find(L.Federal_Citation_8, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_8, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_8 := IF(length(TempCitationDate8) = 5, '200'+TempCitationDate8,
																											IF(length(TempCitationDate8) = 6 and TempCitationDate8[1..2] <= CurrentYear,
																											'20'+TempCitationDate8,
																											 IF(length(TempCitationDate8) = 6 and TempCitationDate8[1..2] > CurrentYear,
																											 '19'+TempCitationDate8,TempCitationDate8)));
			TempCitationDate9											:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_9[STD.Str.Find(L.Federal_Citation_9, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_9, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_9 := IF(length(TempCitationDate9) = 5, '200'+TempCitationDate9,
																											IF(length(TempCitationDate9) = 6 and TempCitationDate9[1..2] <= CurrentYear,
																											'20'+TempCitationDate9,
																											 IF(length(TempCitationDate9) = 6 and TempCitationDate9[1..2] > CurrentYear,
																											 '19'+TempCitationDate9,TempCitationDate9)));
			TempCitationDate10										:= STD.Date.ConvertDateFormatMultiple(TRIM(L.Federal_Citation_10[STD.Str.Find(L.Federal_Citation_10, '/', 1)-2..20 + STD.Str.Find(L.Federal_Citation_10, '/', 1)-2 - 1],left,right),fmtsin,fmtout);
			self.orig_federal_register_citation_date_10 := IF(length(TempCitationDate10) = 5, '200'+TempCitationDate10,
																											IF(length(TempCitationDate10) = 6 and TempCitationDate10[1..2] <= CurrentYear,
																											'20'+TempCitationDate10,
																											 IF(length(TempCitationDate10) = 6 and TempCitationDate10[1..2] > CurrentYear,
																											 '19'+TempCitationDate10,TempCitationDate10)));
			self.orig_raw_name			:= L.orig_raw_name;
	END;
	
	return PROJECT(GoodUSAddress + BadUSAddress, ReformatToCommonlayout(left));
END;

