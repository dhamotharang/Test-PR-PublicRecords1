import std, address, bo_address, ut;

EXPORT ProcessWorldBank := FUNCTION

	WorldBankHdrFilteredRecs := GlobalWatchLists_Preprocess.Files.dsWorldBank(TRIM(orig_firm_name, left, right) <> 'Name:'
							and TRIM(orig_firm_name, left, right) <> 'SortFirm Name'
							and address <> 'Address');
							
	//Add counter to link addresses to name record
	l_AddCount	:= RECORD
		unsigned2 RecNum;
		GlobalWatchLists_Preprocess.Layouts.rWorldBank;
	END;
	
	l_AddCount AddRecNum(WorldBankHdrFilteredRecs L, INTEGER C) := TRANSFORM
		self.RecNum	:= IF(L.orig_firm_name <> '',C,0);
		self := L;
	END;
	
	dsAddRecIdentifier	:= PROJECT(WorldBankHdrFilteredRecs, AddRecNum(left,counter));
	
	//Iterate to populate blank FirmName records with prev RecNum to identify full record
	l_AddCount PopRecNum(dsAddRecIdentifier L, dsAddRecIdentifier R) := TRANSFORM
		self.RecNum					:= IF(R.RecNum = 0 and R.orig_firm_name = '',L.RecNum,R.RecNum);
		self.orig_firm_name := REGEXREPLACE('ALSO KNOWN AS ',ut.CleanSpacesAndUpper(R.orig_firm_name),'AKA ');
		self.address				:= ut.CleanSpacesAndUpper(REGEXREPLACE('^,',R.address,''));
		self.country				:= ut.CleanSpacesAndUpper(R.country);
		self.IneligibilityPeriodfrom	:= ut.CleanSpacesAndUpper(R.IneligibilityPeriodfrom);
		self.Ineligibilityperiodto		:= ut.CleanSpacesAndUpper(R.Ineligibilityperiodto);
		self.grounds				:= ut.CleanSpacesAndUpper(R.grounds);
		self.addl_firm_name        := ut.CleanSpacesAndUpper(R.addl_firm_name);
	END;
	
	dsPopulateRecNum	:= ITERATE(dsAddRecIdentifier, PopRecNum(left,right));
  
	//Denormalize Addresses
	l_AddAddressFields := RECORD
		l_AddCount;
		string100 address1;
		string100 address2;
		string100 address3;
		string100 address4;
		string100 address5;
		string100 address6;
	END;
	
	pAddAddrFields	:= Project(dsPopulateRecNum, TRANSFORM(l_AddAddressFields, self := left; self := []));
	
	l_AddAddressFields DeNormAddr(pAddAddrFields L, dsPopulateRecNum R, integer C) := TRANSFORM
		self.address1	:= IF(C = 1, R.address, L.address1);
		self.address2	:= IF(C = 2, R.address, L.address2);
		self.address3	:= IF(C = 3, R.address, L.address3);
		self.address4	:= IF(C = 4, R.address, L.address4);
		self.address5 := IF(C = 5, R.address, L.address5);
		self.address6 := IF(C = 6, R.address, L.address6);
		self := L;
	END;
	
	DeNormRec	:= DENORMALIZE(pAddAddrFields, dsPopulateRecNum,
													 LEFT.RecNum = RIGHT.RecNum,
													 DeNormAddr(left,right,counter));

	GlobalWatchLists_Preprocess.IntermediaryLayoutWorldBank.Baselayout AssignValues(DeNormRec L, INTEGER Ctr) := TRANSFORM
	  self.ent_key 								:= 'WBI' + INTFORMAT(Ctr, 4, 1);
		self.source 								:= 'World Bank Ineligible Firms';
		self.lst_vend_up 						:= GlobalWatchLists_Preprocess.Versions.WorldBankDeb_Version;
		ClnName											:= IF(STD.Str.Find(L.orig_firm_name,'*',1) >0, REGEXREPLACE('(.*)[\\*](.*)',L.orig_firm_name,'$1'),L.orig_firm_name);
		TempName										:= STD.Str.FilterOut(ClnName, '",*');
		ParseEntity			 						:= IF(REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
																			REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,1,NOCASE),
																			IF(REGEXFIND('^(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),'',TempName));
		self.lstd_entity						:= ut.CleanSpacesAndUpper(REGEXREPLACE('(\\([?]+\\))',
																																	REGEXREPLACE('(\\(CURRENTLY|\\()$',trim(ParseEntity,left,right),'',NOCASE),
																																	''));
		ParseAKA			 							:= IF(REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
																		REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,3,NOCASE),
																		IF(REGEXFIND('^(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),TempName,''));
		self.lstd_aka 							:= ut.CleanSpacesAndUpper(STD.Str.FilterOut(ParseAKA,'()'));
		self.aka_type								:= STD.Str.Filter(IF(self.lstd_aka <> '',
																											REGEXFIND('(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',ClnName,1,NOCASE),''),
																									'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
		FullAddress									:= STD.Str.CleanSpaces(TRIM(L.address1,left,right)+' '+TRIM(L.address2,left,right)+' '+TRIM(L.address3,left,right)+' '+
																											TRIM(L.address4,left,right)+' '+TRIM(L.address5,left,right)+' '+TRIM(L.address6,left,right));
		self.address 								:= STD.Str.ToUpperCase(STD.Str.Filter(TRIM(STD.Str.FindReplace(FullAddress,'"',''), left, right), ' ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890()[]-_/\':;,!@%$^&*+=?<>.'));
		self.country 								:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.country,'"',''), left, right))[1..30];
		self.ineligible_st_dt 			:= TRIM(L.IneligibilityPeriodfrom, left, right);
		self.ineligible_end_dt 			:= TRIM(L.Ineligibilityperiodto, left, right);
		self.grounds 								:= TRIM(STD.Str.FindReplace(L.grounds,'"',''), left, right);
		self.rep_date 							:= '';
		self.comments 							:= '';
		self.orig_raw_name					:= ut.CleanSpacesAndUpper(self.lstd_entity);
	END;
	
	parseFirmName	:= PROJECT(DeNormRec, AssignValues(left,counter));
	
fmtsin := '%d-%b-%y';
fmtout := '%Y%m%d';
	
	GlobalWatchLists_Preprocess.rOutLayout wbi(GlobalWatchLists_Preprocess.IntermediaryLayoutWorldBank.Baselayout L, INTEGER C) := TRANSFORM
		v_name_cleaned 	:= Address.CleanPersonFML73(regexreplace('DRS.', L.lstd_entity, '',NOCASE));
		v_address_clean	:=  if(STD.Str.Find(TRIM(L.address, left, right), ',', 1) > 0
													,bo_address.CleanAddress182(TRIM(L.address, left, right)[1..STD.Str.Find(TRIM(L.address, left, right), ',')-1], TRIM(L.address, left, right)[STD.Str.Find(TRIM(L.address, left, right), ',', 1)+1..(length(TRIM(L.address, left, right))-STD.Str.Find(TRIM(L.address, left, right), ',', 1) + STD.Str.Find(TRIM(L.address, left, right), ',', 1)+1-1)])
													,bo_address.CleanAddress182(' ', L.address + ' ' + ' ' + ' ' + ' '));
		temp_name				:= STD.Str.ToUpperCase(TRIM(L.lstd_entity, left, right));
		v_bus_name_flag := if(STD.Str.Find(temp_name,'ELECTRICAL', 1) <> 0 or STD.Str.Find(temp_name,'NETWORK', 1)  <> 0 or STD.Str.Find(temp_name,'SHIPPING', 1) <> 0
														or STD.Str.Find(temp_name,'TELECOM', 1) <> 0 or STD.Str.Find(temp_name,'CANADA', 1) <> 0 or STD.Str.Find(temp_name,'COMMUNICATION', 1) <> 0            
														or STD.Str.Find(temp_name,'CORPORATE', 1) <> 0 or STD.Str.Find(temp_name,'GRAPHIC ', 1) <> 0 or STD.Str.Find(temp_name,'ACCOUNTS', 1) <> 0             
                            or STD.Str.Find(temp_name,'REVOLUTIONARY', 1) <> 0 or STD.Str.Find(temp_name,' GROUP ', 1) <>  0 or STD.Str.Find(temp_name,'ORGANIZATION', 1) <> 0
														or STD.Str.Find(temp_name,'ORGANISATION', 1) <> 0 or regexfind('^CV ', temp_name) <> false or regexfind('^PT ', temp_name) <> false
														or regexfind(' CV ', temp_name) <> false or regexfind(' PT ', temp_name) <> false or regexfind(' KB ', temp_name) <> false         
                            or regexfind('^CV. ', temp_name) <> false or regexfind('^PT. ', temp_name) <> false or regexfind(' CV. ', temp_name) <> false
														or regexfind(' PT. ', temp_name) <> false or regexfind(' KB. ', temp_name) <> false or STD.Str.Find(temp_name,'AMBULANCE', 1) <> 0
														or regexfind('^AB ', temp_name) <> false or regexfind(' AB$', TRIM(temp_name, left, right)) <> false or STD.Str.Find(temp_name,'CATUR BANGUN MANUNGGAL SEPAKAT', 1) <> 0
														or STD.Str.Find(temp_name,'INDUSTRIE', 1) <> 0 or STD.Str.Find(temp_name,'AMERICAN', 1) <> 0 or STD.Str.Find(temp_name,'NORTHERN', 1) <> 0
														or STD.Str.Find(temp_name,'SOUTHERN', 1) <> 0 or STD.Str.Find(temp_name,'ADMINISTRATION', 1) <> 0 or STD.Str.Find(temp_name,'ALIGNMENT', 1) <> 0
														or STD.Str.Find(temp_name,'AMUSEMENT', 1) <> 0 or STD.Str.Find(temp_name,'ANTIQUE', 1) <> 0 or STD.Str.Find(temp_name,'APARTMENTS', 1) <> 0
														or STD.Str.Find(temp_name,'APLC', 1) <> 0 or STD.Str.Find(temp_name,'ARCHITECT', 1) <> 0 or STD.Str.Find(temp_name,'ARCHETECT', 1) <> 0
														or STD.Str.Find(temp_name,'AIR CONDITIONING', 1) <> 0 or STD.Str.Find(temp_name,'APPLIANCE', 1) <> 0 or STD.Str.Find(temp_name,'ASSOCIATES', 1) <> 0
														or STD.Str.Find(temp_name,'ASSOCIATION', 1) <> 0 or STD.Str.Find(temp_name,'AS AGENT', 1) <> 0 or STD.Str.Find(temp_name,'AUTOMOTIVE', 1) <> 0
														or STD.Str.Find(temp_name,'AVIATION', 1) <> 0 or STD.Str.Find(temp_name,'AIRLINES', 1) <> 0 or STD.Str.Find(temp_name,'BOOKKEEPING', 1) <> 0
														or STD.Str.Find(temp_name,'BOOKBINDER', 1) <> 0 or STD.Str.Find(temp_name,'BROKERAGE', 1) <> 0 or STD.Str.Find(temp_name,' BROKERS ', 1) <> 0
														or STD.Str.Find(temp_name,'BUILDING', 1) <> 0 or STD.Str.Find(temp_name,'BUSINESS', 1) <> 0 or STD.Str.Find(temp_name,'BOUTIQUE', 1) <> 0
														or STD.Str.Find(temp_name,'CHEMICAL', 1) <> 0 or STD.Str.Find(temp_name,'COMPUTER', 1) <> 0 or STD.Str.Find(temp_name,'CORPORATION', 1) <> 0
														or STD.Str.Find(temp_name,'CORP.', 1) <> 0 or STD.Str.Find(temp_name,'CO.', 1) <> 0 or STD.Str.Find(temp_name,'CARBURETOR', 1) <> 0
														or STD.Str.Find(temp_name,'CHIROPRACTIC', 1) <> 0 or STD.Str.Find(temp_name,'CLEANING', 1) <> 0 or STD.Str.Find(temp_name,'COMPANY', 1) <> 0
														or STD.Str.Find(temp_name,'CONSTRUCTION', 1) <> 0 or STD.Str.Find(temp_name,'CONST.', 1) <> 0 or STD.Str.Find(temp_name,'CONSULT', 1) <> 0
														or STD.Str.Find(temp_name,'COOPERATIVE', 1) <> 0 or STD.Str.Find(temp_name,'CABLEVISION', 1) <> 0 or STD.Str.Find(temp_name,'COMMUNITY', 1) <> 0
														or STD.Str.Find(temp_name,'CMNTY', 1) <> 0 or STD.Str.Find(temp_name,'COMMUNICATIONS', 1) <> 0 or STD.Str.Find(temp_name,'COUNTRY CLUB', 1) <> 0
														or STD.Str.Find(temp_name,' COUNTY ', 1) <> 0 or STD.Str.Find(temp_name,' CREDIT ', 1) <> 0 or STD.Str.Find(temp_name,'DEVELOPMENT', 1) <> 0
														or STD.Str.Find(temp_name,'DETROIT', 1) <> 0 or STD.Str.Find(temp_name,'DVLPMNTL', 1) <> 0 or STD.Str.Find(temp_name,'DISTRICT', 1) <> 0
														or STD.Str.Find(temp_name,'DISTRIBUTION', 1) <> 0 or STD.Str.Find(temp_name,'DISTRIBUTING', 1) <> 0 or STD.Str.Find(temp_name,'DIVISION', 1) <> 0
														or STD.Str.Find(temp_name,'ELEVATOR', 1) <> 0 or STD.Str.Find(temp_name,'ENTERPRISE', 1) <> 0 or STD.Str.Find(temp_name,'ENGINEERING', 1) <> 0
														or STD.Str.Find(temp_name,'ESTATES', 1) <> 0 or STD.Str.Find(temp_name,'EQUIPMENT', 1) <> 0 or STD.Str.Find(temp_name,'EQUITY', 1) <> 0
														or STD.Str.Find(temp_name,'EXCAVATING', 1) <> 0 or STD.Str.Find(temp_name,'EXPRESS', 1) <> 0 or STD.Str.Find(temp_name,'FINANCIAL ', 1) <> 0
														or STD.Str.Find(temp_name,'FINANCE ', 1) <> 0 or STD.Str.Find(temp_name,'FABRICATORS', 1) <> 0 or STD.Str.Find(temp_name,'FREIGHTLINER', 1) <> 0
														or STD.Str.Find(temp_name,'FREIGHT ', 1) <> 0 or STD.Str.Find(temp_name,'FULLFILLMENT', 1) <> 0 or STD.Str.Find(temp_name,'FULFILLMENT', 1) <> 0
														or STD.Str.Find(temp_name,'FUNERAL HOME', 1) <> 0 or STD.Str.Find(temp_name,'FURNITURE', 1) <> 0 or STD.Str.Find(temp_name,'GOVERNMENT', 1) <> 0
														or STD.Str.Find(temp_name,'GVRNMNT', 1) <> 0 or STD.Str.Find(temp_name,' GROWERS ', 1) <> 0 or STD.Str.Find(temp_name,'DEVELOPMENT', 1) <> 0
														or STD.Str.Find(temp_name,'DVLPMNTL', 1) <> 0 or STD.Str.Find(temp_name,'FREIGHT', 1) <> 0 or STD.Str.Find(temp_name,'HEALTHCARE', 1) <> 0
														or STD.Str.Find(temp_name,'INNOVATIVE', 1) <> 0 or STD.Str.Find(temp_name,'HOSPICE', 1) <> 0 or STD.Str.Find(temp_name,' HOSPITAL', 1) <> 0
														or STD.Str.Find(temp_name,'IKIP MALANG', 1) <> 0 or STD.Str.Find(temp_name,'INDUSTRIES', 1) <> 0 or STD.Str.Find(temp_name,'INSTITUTE', 1) <> 0
														or STD.Str.Find(temp_name,'INDUSTRIAL', 1) <> 0 or  STD.Str.Find(temp_name,'INTERNATIONAL', 1) <> 0 or STD.Str.Find(temp_name,'INTERIORS', 1) <> 0
														or STD.Str.Find(temp_name,'INVESTMENTS', 1) <> 0 or STD.Str.Find(temp_name,'LANDSCAPING', 1) <> 0 or STD.Str.Find(temp_name,' LEASING ', 1) <> 0
														or STD.Str.Find(temp_name,' LEASE ', 1) <> 0 or STD.Str.Find(temp_name,'LIMITED', 1) <> 0 or STD.Str.Find(temp_name,'MACHINE', 1) <> 0
														or STD.Str.Find(temp_name,'MANAGEMENT', 1) <> 0 or STD.Str.Find(temp_name,'MATUSHITA', 1) <> 0 or STD.Str.Find(temp_name,'MATSUSHITA', 1) <> 0
														or STD.Str.Find(temp_name,'MISSIONARY', 1) <> 0 or STD.Str.Find(temp_name,'MINISTRIES', 1) <> 0 or STD.Str.Find(temp_name,'MNGMNT', 1) <> 0
														or STD.Str.Find(temp_name,'MOBILE PARK', 1) <> 0 or STD.Str.Find(temp_name,'MOBILE HOME', 1) <> 0 or STD.Str.Find(temp_name,'MOUNTAIN', 1) <> 0
														or STD.Str.Find(temp_name,'NATIONAL', 1) <> 0 or STD.Str.Find(temp_name,'OPTICAL', 1) <> 0 or STD.Str.Find(temp_name,'PACKAGING', 1) <> 0
														or STD.Str.Find(temp_name,'PARTNERSHIP', 1) <> 0 or STD.Str.Find(temp_name,'PEDIATRICS', 1) <> 0 or STD.Str.Find(temp_name,'PEER REVIEW', 1) <> 0
														or STD.Str.Find(temp_name,'PHARMACY', 1) <> 0 or STD.Str.Find(temp_name,'PHARMACEUTICAL', 1) <> 0 or STD.Str.Find(temp_name,'PENSION PLAN', 1) <> 0
														or STD.Str.Find(temp_name,'PRODUCTIONS', 1) <> 0 or STD.Str.Find(temp_name,'PROFESSIONAL', 1) <> 0 or STD.Str.Find(temp_name,'PROJECT', 1) <> 0
														or STD.Str.Find(temp_name,'PROPERTIES', 1) <> 0 or STD.Str.Find(temp_name,'RAILROAD', 1) <> 0 or STD.Str.Find(temp_name,'REALTY', 1) <> 0
														or STD.Str.Find(temp_name,'REBUILDERS', 1) <> 0 or STD.Str.Find(temp_name,'REPAIR', 1) <> 0 or STD.Str.Find(temp_name,'RESTARAUNT', 1) <> 0
														or STD.Str.Find(temp_name,'RESTAURANT', 1) <> 0 or STD.Str.Find(temp_name,'SAVINGS', 1) <> 0 or STD.Str.Find(temp_name,'SECURITIES', 1) <> 0
														or STD.Str.Find(temp_name,'SEAFOOD', 1) <> 0 or STD.Str.Find(temp_name,'SERVICES', 1) <> 0 or STD.Str.Find(temp_name,'SOLUTION', 1) <> 0
														or STD.Str.Find(temp_name,'SPECIALTY', 1) <> 0 or STD.Str.Find(temp_name,' SQUARE ', 1) <> 0 or STD.Str.Find(temp_name,'SYSTEMS', 1) <> 0
														or STD.Str.Find(temp_name,'STATE BANK', 1) <> 0 or STD.Str.Find(temp_name,'SPECIALIST', 1) <> 0 or STD.Str.Find(temp_name,'SPRCNTR', 1) <> 0
														or STD.Str.Find(temp_name,'SCHOOL', 1) <> 0 or STD.Str.Find(temp_name,'SUPERCENTER', 1) <> 0 or STD.Str.Find(temp_name,'SUPPLY', 1) <> 0
														or STD.Str.Find(temp_name,'SURGERY', 1) <> 0 or STD.Str.Find(temp_name,'TELEPHONE', 1) <> 0 or STD.Str.Find(temp_name,'TRAVEL ', 1) <> 0
														or STD.Str.Find(temp_name,'TRADE NAME', 1) <> 0 or STD.Str.Find(temp_name,'TRUCKING', 1) <> 0 or STD.Str.Find(temp_name,' TRANSPORT ', 1) <> 0
														or STD.Str.Find(temp_name,'TECHNOLOGY', 1) <> 0 or STD.Str.Find(temp_name,'TRANSPORTATION', 1) <> 0 or STD.Str.Find(temp_name,'TRANSMISSION', 1) <> 0
														or STD.Str.Find(temp_name,' STORAGE ', 1) <> 0 or STD.Str.Find(temp_name,' TRANSFER ', 1) <> 0 or STD.Str.Find(temp_name,' TRANSPORT ', 1) <> 0
														or STD.Str.Find(temp_name,'VALLEY ', 1) <> 0 or STD.Str.Find(temp_name,'WAREHOUSE', 1) <> 0 or STD.Str.Find(temp_name,'WELLS FARGO', 1) <> 0
														or STD.Str.Find(temp_name,' AGENCY', 1) <> 0 or STD.Str.Find(temp_name,' MARKET ', 1) <> 0 or STD.Str.Find(temp_name,' SALES ', 1) <> 0
														or STD.Str.Find(temp_name,' RADIO', 1) <> 0 or STD.Str.Find(temp_name,' COUNCIL ', 1) <> 0 or STD.Str.Find(temp_name,' PARTNERS', 1) <> 0
														or STD.Str.Find(temp_name,' PLAZA', 1) <> 0 or STD.Str.Find(temp_name,' CLINIC', 1) <> 0 or STD.Str.Find(temp_name,' CENTER ', 1) <> 0
														or STD.Str.Find(temp_name,' REPAIR ', 1) <> 0 or STD.Str.Find(temp_name,' SERVICE ', 1) <> 0 or STD.Str.Find(temp_name,' GROUP ', 1) <> 0
														or STD.Str.Find(temp_name,' TRUST ', 1) <> 0 or STD.Str.Find(temp_name,' INC ', 1) <> 0 or STD.Str.Find(temp_name,' INC.', 1) <> 0
														or STD.Str.Find(temp_name,',INC ', 1) <> 0 or STD.Str.Find(temp_name,',INC. ', 1) <> 0 or STD.Str.Find(temp_name,' LLC', 1) <> 0
														or STD.Str.Find(temp_name,' L L C', 1) <> 0 or STD.Str.Find(temp_name,' LTD', 1) <> 0 or STD.Str.Find(temp_name,' LLP', 1) <> 0
														or STD.Str.Find(temp_name,' L L P', 1) <> 0 or STD.Str.Find(temp_name,' LP', 1) <> 0 or STD.Str.Find(temp_name,' L.P.', 1) <> 0
														or STD.Str.Find(temp_name,'BANK N.A.', 1) <> 0 or STD.Str.Find(temp_name,'BANK NA', 1) <> 0 or STD.Str.Find(temp_name,', N.A.', 1) <> 0
														or STD.Str.Find(temp_name,', N. A.', 1) <> 0 or STD.Str.Find(temp_name,', N A', 1) <> 0 or STD.Str.Find(temp_name,',N.A.', 1) <> 0
														or STD.Str.Find(temp_name,',N. A.', 1) <> 0 or STD.Str.Find(temp_name,' PSC', 1) <> 0 or STD.Str.Find(temp_name,' P S C', 1) <> 0
														or STD.Str.Find(temp_name,' F S B', 1) <> 0 or STD.Str.Find(temp_name,'CITY OF ', 1) <> 0 or STD.Str.Find(temp_name,'COUNTY OF ', 1) <> 0
														or STD.Str.Find(temp_name,'STATE OF ', 1) <> 0 or STD.Str.Find(temp_name,'PROVINCE OF ', 1) <> 0 or STD.Str.Find(temp_name,'LIQUOR ', 1) <> 0
														or STD.Str.Find(temp_name,' CORP ', 1) <> 0 or STD.Str.Find(temp_name,' OFFICE ', 1) <> 0 or STD.Str.Find(temp_name,' DELI ', 1) <> 0
														or STD.Str.Find(temp_name,' MOTEL ', 1) <> 0 or STD.Str.Find(temp_name,' INN ', 1) <> 0 or STD.Str.Find(temp_name,' USA ', 1) <> 0
														or STD.Str.Find(temp_name,' U S A ', 1) <> 0 or STD.Str.Find(temp_name,' AND SONS', 1) <> 0 or STD.Str.Find(temp_name,' & SONS', 1) <> 0
														or STD.Str.Find(temp_name,' & ', 1) <> 0 or STD.Str.Find(temp_name,'SH.P.K.', 1) <> 0 or STD.Str.Find(temp_name,'SISTEMAS ', 1) <> 0
														or STD.Str.Find(temp_name,'CONSULTING ', 1) <> 0 or STD.Str.Find(temp_name,'GROUP ', 1) <> 0 or STD.Str.Find(temp_name,'DIGIDATA ', 1) <> 0
														or STD.Str.Find(temp_name,'UNIVERSAL ', 1) <> 0 or STD.Str.Find(temp_name,'TECHNOLOGIES', 1) <> 0 or STD.Str.Find(temp_name,'LASSERVICE ', 1) <> 0
														or STD.Str.Find(temp_name,'EQUIPOS ', 1) <> 0 or STD.Str.Find(temp_name,' THE ', 1) <> 0 or STD.Str.Find(temp_name,'&', 1) <> 0
              					,'Y'
												,' ');
		v_keep_lfmname  			:= if(v_bus_name_flag = '' and v_name_cleaned[71..73] >= '65', 'Y', ' ');
		v_keep_compname				:= if(v_name_cleaned[46..65] = '' or v_bus_name_flag <> ''
																,'Y'
																,' ');
		self.pty_key			 		:= ut.CleanSpacesAndUpper(L.ent_key);
		self.source 					:= L.source;
//		cName									:= ut.CleanSpacesAndUpper(CHOOSE(C,L.lstd_entity,L.lstd_aka));
		self.orig_pty_name 		:= ut.CleanSpacesAndUpper(CHOOSE(C,L.lstd_entity,L.lstd_aka));
		self.orig_vessel_name := '';
		self.country 					:= ut.CleanSpacesAndUpper(L.country);
		self.name_type 				:= CHOOSE(C,'',L.aka_type);
		self.addr_1 					:= ut.CleanSpacesAndUpper(L.address);
		self.remarks_1 				:= ut.CleanSpacesAndUpper(if(L.ineligible_st_dt <> '' and TRIM(L.source, left, right) = 'WORLD BANK REPRIMAND LIST'
															,'REPRIMAND DATE: ' + L.ineligible_st_dt
															,if(L.ineligible_st_dt <> '' and TRIM(L.source, left, right) <> 'WORLD BANK REPRIMAND LIST'
																,'INELIGIBLE START DATE: ' + L.ineligible_st_dt
																,'')));
		self.remarks_2 				:= ut.CleanSpacesAndUpper(if(L.ineligible_end_dt <> '', 'INELIGIBLE END DATE: ' + L.ineligible_end_dt, ''));
		self.remarks_3 				:= ut.CleanSpacesAndUpper(if(L.grounds <> '', 'GROUNDS: ' + TRIM(L.grounds, left, right), ''));
		self.remarks_4 				:= ut.CleanSpacesAndUpper(if(L.rep_date <> '', 'LETTER OF REPRIMAND ONLY: ' + L.rep_date[5..6] + '/' + L.rep_date[7..8] + '/' + L.rep_date[1..4], ''));
		self.remarks_5 				:= ut.CleanSpacesAndUpper(if(L.comments <> '', 'COMMENTS: ' + L.comments, ''));
		self.remarks_6 				:= ut.CleanSpacesAndUpper(if(L.country <> '', 'COUNTRY: ' + L.country, ''));
		self.cname_clean 			:= if(v_keep_compname = 'Y',  ut.CleanSpacesAndUpper(L.lstd_entity), '');
		self.pname_clean 			:= if(v_keep_lfmname = 'Y', v_name_cleaned, '');
		self.addr_clean 			:= if(v_address_clean[179..180] <> 'E5'
																and	 v_address_clean[179..182] <> 'E213'
																and  v_address_clean[179..182] <> 'E101'
															,v_address_clean
															,'');
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.WorldBankDeb_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.WorldBankDeb_Version;
		self.date_vendor_first_reported := L.rep_date;
		self.date_vendor_last_reported 	:= L.rep_date;
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= '';
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= if(v_keep_compname = 'Y', 'G', 'I');
		self.orig_address_id 						:= '';
		self.orig_address_line_1 				:= ut.CleanSpacesAndUpper(L.address);
		self.orig_address_country 			:= ut.CleanSpacesAndUpper(L.country);
		self.orig_remarks 							:= ut.CleanSpacesAndUpper(L.comments);
		self.orig_date_added_to_list 		:= L.rep_date;
		self.orig_effective_date 				:= ut.ConvertDate(L.ineligible_st_dt, fmtsin, fmtout);
		self.orig_expiration_date 			:= ut.ConvertDate(L.ineligible_end_dt, fmtsin, fmtout);
		self.orig_grounds 							:= ut.CleanSpacesAndUpper(L.grounds);
		self.orig_raw_name							:= L.orig_raw_name;
	END;
	
	return NORMALIZE(parseFirmName,2,wbi(left,counter))(orig_pty_name <> '');
	
END;