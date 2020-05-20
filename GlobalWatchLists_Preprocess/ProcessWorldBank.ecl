import std, address, bo_address, ut;

EXPORT ProcessWorldBank := FUNCTION

	WorldBankHdrFilteredRecs := GlobalWatchLists_Preprocess.Files.dsWorldBank(~REGEXFIND('^(Name: |SortFirm Name|Downloaded)',orig_firm_name)
																																							and address <> 'Address'
																																							and TRIM(orig_firm_name) <> '');
							
	//Clean and Uppercase fields
	GlobalWatchLists_Preprocess.Layouts.rWorldBank ClnFields(WorldBankHdrFilteredRecs L) := TRANSFORM
		self.orig_firm_name := STD.Str.CleanSpaces(REGEXREPLACE('\\*[0-9]+',REGEXREPLACE('ALSO KNOWN AS ',ut.CleanSpacesAndUpper(L.orig_firm_name),'AKA '),''));
		self.address				:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(REGEXREPLACE('^,',L.address,''),';',','));
		self.country				:= ut.CleanSpacesAndUpper(L.country);
		self.IneligibilityPeriodfrom	:= ut.CleanSpacesAndUpper(L.IneligibilityPeriodfrom);
		self.Ineligibilityperiodto		:= ut.CleanSpacesAndUpper(L.Ineligibilityperiodto);
		self.grounds				:= ut.CleanSpacesAndUpper(L.grounds);
		self.addl_firm_name        := ut.CleanSpacesAndUpper(REGEXREPLACE('(\\([?]+\\)|\\*[0-9]+)',L.addl_firm_name,''));
	END;
	
	dsCleanUpper	:= PROJECT(WorldBankHdrFilteredRecs, ClnFields(LEFT));
													 
 	GlobalWatchLists_Preprocess.IntermediaryLayoutWorldBank.Baselayout AssignValues(dsCleanUpper L, INTEGER Ctr) := TRANSFORM
	  self.ent_key 								:= 'WBI' + INTFORMAT(Ctr, 4, 1);
		self.source 								:= 'World Bank Ineligible Firms';
		self.lst_vend_up 						:= GlobalWatchLists_Preprocess.Versions.WorldBankDeb_Version;
		ClnName											:= IF(STD.Str.Find(L.orig_firm_name,'*',1) >0, REGEXREPLACE('(.*)[\\*](.*)',L.orig_firm_name,'$1'),L.orig_firm_name);
		TempName										:= STD.Str.FilterOut(ClnName, '",*');
		ParseEntity			 						:= IF(REGEXFIND('^(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),'',
																			IF(REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
																					REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,1,NOCASE),
																					TempName));
		self.lstd_entity						:= STD.Str.CleanSpaces(REGEXREPLACE('(\\([?]+\\))',
																												REGEXREPLACE('(\\(CURRENTLY|\\()$',trim(ParseEntity,left,right),'',NOCASE),
																												''));
		ParseAKA			 							:= IF(REGEXFIND('^(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
																			REGEXFIND('^(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,2,NOCASE),
																			IF(REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
																					REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,3,NOCASE),
																					''));
		self.lstd_aka 							:= STD.Str.CleanSpaces(STD.Str.FilterOut(ParseAKA,'()'));
		self.aka_type								:= STD.Str.Filter(IF(self.lstd_aka <> '',
																											REGEXFIND('(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',ClnName,1,NOCASE),''),
																									'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
		self.address 								:= STD.Str.CleanSpaces(STD.Str.Filter(TRIM(STD.Str.FindReplace(L.address,'"','')), ' ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890()[]-_/\':;,!@%$^&*+=?<>.'));
		self.country 								:= STD.Str.CleanSpaces(TRIM(STD.Str.FindReplace(L.country,'"','')))[1..30];
		self.ineligible_st_dt 			:= STD.Str.CleanSpaces(L.IneligibilityPeriodfrom);
		self.ineligible_end_dt 			:= STD.Str.CleanSpaces(L.Ineligibilityperiodto);
		self.grounds 								:= TRIM(STD.Str.FindReplace(L.grounds,'"',''), left, right);
		self.rep_date 							:= '';
		self.comments 							:= '';
		self.orig_raw_name					:= STD.Str.CleanSpaces(TempName);
	END;
	
	parseFirmName	:= PROJECT(dsCleanUpper, AssignValues(left,counter));

fmtsin := '%d-%b-%y';
fmtout := '%Y%m%d';
	
	GlobalWatchLists_Preprocess.rOutLayout wbi(GlobalWatchLists_Preprocess.IntermediaryLayoutWorldBank.Baselayout L, INTEGER C) := TRANSFORM
		v_address_clean	:=  if(STD.Str.Find(TRIM(L.address, left, right), ',', 1) > 0
													,bo_address.CleanAddress182(TRIM(L.address, left, right)[1..STD.Str.Find(TRIM(L.address, left, right), ',')-1], TRIM(L.address, left, right)[STD.Str.Find(TRIM(L.address, left, right), ',', 1)+1..(length(TRIM(L.address, left, right))-STD.Str.Find(TRIM(L.address, left, right), ',', 1) + STD.Str.Find(TRIM(L.address, left, right), ',', 1)+1-1)])
													,bo_address.CleanAddress182(' ', L.address + ' ' + ' ' + ' ' + ' '));
		self.pty_key			 		:= STD.Str.CleanSpaces(L.ent_key);
		self.source 					:= L.source;
		self.orig_pty_name 		:= STD.Str.CleanSpaces(CHOOSE(C,L.lstd_entity,L.lstd_aka));
		self.orig_vessel_name := '';
		self.country 					:= STD.Str.CleanSpaces(L.country);
		self.name_type 				:= CHOOSE(C,'',L.aka_type);
		self.addr_1 					:= STD.Str.CleanSpaces(L.address);
		self.remarks_1 				:= STD.Str.CleanSpaces(if(L.ineligible_st_dt <> '' and TRIM(L.source, left, right) = 'WORLD BANK REPRIMAND LIST'
															,'REPRIMAND DATE: ' + L.ineligible_st_dt
															,if(L.ineligible_st_dt <> '' and TRIM(L.source, left, right) <> 'WORLD BANK REPRIMAND LIST'
																,'INELIGIBLE START DATE: ' + L.ineligible_st_dt
																,'')));
		self.remarks_2 				:= STD.Str.CleanSpaces(if(L.ineligible_end_dt <> '', 'INELIGIBLE END DATE: ' + L.ineligible_end_dt, ''));
		self.remarks_3 				:= STD.Str.CleanSpaces(if(L.grounds <> '', 'GROUNDS: ' + TRIM(L.grounds, left, right), ''));
		self.remarks_4 				:= STD.Str.CleanSpaces(if(L.rep_date <> '', 'LETTER OF REPRIMAND ONLY: ' + L.rep_date[5..6] + '/' + L.rep_date[7..8] + '/' + L.rep_date[1..4], ''));
		self.remarks_5 				:= STD.Str.CleanSpaces(if(L.comments <> '', 'COMMENTS: ' + L.comments, ''));
		self.remarks_6 				:= STD.Str.CleanSpaces(if(L.country <> '', 'COUNTRY: ' + L.country, ''));
		v_name_cleaned 				:= Address.CleanPersonFML73(regexreplace('DRS.', self.orig_pty_name, '',NOCASE));
		temp_name							:= STD.Str.CleanSpaces(TRIM(self.orig_pty_name, left, right));
		v_bus_name_flag 			:= if(STD.Str.Find(temp_name,'ELECTRICAL', 1) <> 0 or STD.Str.Find(temp_name,'NETWORK', 1)  <> 0 or STD.Str.Find(temp_name,'SHIPPING', 1) <> 0
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
																	or STD.Str.Find(temp_name,'AUTO ', 1) <> 0 or STD.Str.Find(temp_name,'EQUIPOS ', 1) <> 0 or STD.Str.Find(temp_name,' THE ', 1) <> 0 or STD.Str.Find(temp_name,'&', 1) <> 0
															,'Y'
															,' ');
		v_keep_lfmname  			:= if(v_bus_name_flag = '' and v_name_cleaned[71..73] >= '65', 'Y', ' ');
		v_keep_compname				:= if(v_name_cleaned[46..65] = '' or v_bus_name_flag <> ''
																,'Y'
																,' ');
		self.cname_clean 			:= if(v_keep_compname = 'Y',  STD.Str.CleanSpaces(self.orig_pty_name), '');
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
		self.orig_address_line_1 				:= STD.Str.CleanSpaces(L.address);
		self.orig_address_country 			:= STD.Str.CleanSpaces(L.country);
		self.orig_remarks 							:= STD.Str.CleanSpaces(L.comments);
		self.orig_date_added_to_list 		:= L.rep_date;
		self.orig_effective_date 				:= Std.Date.ConvertDateFormat(L.ineligible_st_dt, fmtsin, fmtout);
		self.orig_expiration_date 			:= Std.Date.ConvertDateFormat(L.ineligible_end_dt, fmtsin, fmtout);
		self.orig_grounds 							:= STD.Str.CleanSpaces(L.grounds);
		self.orig_raw_name							:= L.orig_raw_name;
	END;
	
	ds_out := NORMALIZE(parseFirmName,2,wbi(left,counter))(orig_pty_name <> '');
	
	RETURN DEDUP(ds_out,ALL, EXCEPT PTY_KEY, orig_raw_name); //Duplicate AKA records as AKA was coming with original name as well as its own record 
	
END;