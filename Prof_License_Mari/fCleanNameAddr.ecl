IMPORT ut,lib_fileservices,_Control,lib_stringlib,AID,address,idl_header,NID, prof_license_mari, Address, STD;

EXPORT fCleanNameAddr(DATASET(RECORDOF(Prof_License_Mari.layouts.intermediate)) pBaseFile) := FUNCTION

valid_military_states					:=	['AA','AE','AP','FM','MH','MP','PW'];
canadian_states_abbv := ['AB','BC','MB','NF','NT','NS','CN','ON','PE','QC','SK','YT'];
begin_paren := '^\\((.*)\\)(.*)$'; 
paren_pattern := '^(.*)\\((.*)\\)$';
single_paren := '^(.*)\\((.*)$';
sign_pattern := '^(.*)@(.*)$'; 
misc_pattern := '^(.*)(NO MAIL|NEED CHECK FOR|PAID FOR )(.*)$';
address_accept := '(PO BOX|GENERAL DELIVERY|^ONE |^TWO |^THREE |^SIX |^SIXTH |^EIGHT|^NINTH |^TEN |OFFICE CENTER|OFFICE PARK|PLAZA| PLZ|EXECUTIVE PARK)';
valid_unit_desig := '(^#| APT|^APT|BSMT|BLDG|^FL |FRNT|HNGR|LBBY|^LOT |LOWR|OFC|^PH |PIER|^PMB |^REAR|^RM |^SIDE|SLIP|SPC|^STOP|^STE |TRLR|^UNIT|^UPPR)';
city_addr := '(^BLDG |^SUITE |^STE |^#|^B1D )';
DBApattern	:= '^(.*)(DBA - |/ DBA | DBA/|DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA| D/B/A|C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION:|ATN:| AKA |^AKA | A/K/A | A/K/A|T/A )(.*)';									

set_name_excluded :=  ['CONSUMER AFFAIRS TESTER','ONLINE TESTING','ONLINE TESTING 2','XXX','TEST ACCOUNT1','TEST SALES','TRAINEE TEST APPRAISER',
											'RESIDENTIAL T APPRAISER','STATE T APPRAISER','GENERAL T APPRAISER','LAST NAME','FIRST NAME',
			                'RECORD DUPLICATE .','PAGE -1 OF 1','SORT NAME',',',''];	
                                                                                                                                                                                                                                                     

set_dba_excluded  := ['MULTIPLE BROKERS LICENSE','MULTIPLE BROKER','MULTIPLE BROKER LICENSE','(INSTRUCTOR)',
											'MUTLIPLE BROKERS LICENSE','MULTIPLE BROKERS LICENS','INDIVIDUAL','MULTIPLE BROKER\'S LICENSE',
											'SECOND BROKER LICENSE'];		
											
website_pattern_1 := '(HTTP://|)(WWW\\.)?([^\\.]+)\\.(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';

//Validate Suffix																			
	setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	string fGetSuffix(string SuffixIn)	:=		map(SuffixIn = '1' => 'I'
																								,SuffixIn in ['2','ND'] => 'II'
																								,SuffixIn in ['3','RD'] => 'III'
																								,SuffixIn = '4' => 'IV'
																								,SuffixIn = '5' => 'V'
																								,SuffixIn = '6' => 'VI'
																								,SuffixIn = '7' => 'VII'
																								,SuffixIn = '8' => 'VIII'
																								,SuffixIn = '9' => 'IX'
																								,SuffixIn in setValidSuffix => SuffixIn
																								,'');
	filtered_suffix := ['CEO','MBA','PA','PE'];

//Filtering Test Records
pBaseFile_test := pBaseFile(name_org_orig in set_name_excluded);
pBaseFile_comma := pBaseFile(trim(name_org_orig) in [',','/','-',''] and (trim(name_org) = '' or length(trim(name_org)) < 1));
dsBaseFile := pBaseFile - pBaseFile_test - PBaseFile_comma;

		seqRec	:=	record
				Prof_License_Mari.layouts.final;
				unsigned4	unique_id;
		end;			
	
		seqrec into_seq(dsBaseFile L, integer cnt) := transform
		
				// FullName	 := StringLib.StringCleanSpaces(L.NAME_FIRST + ' ' + L.NAME_MID + ' ' + L.NAME_LAST);
				IsCompany	 := IF(Prof_License_Mari.mod_clean_name_addr.IsCompanyName(L.NAME_ORG_ORIG) != '' AND L.NAME_ORG_ORIG not in set_name_excluded,
														L.NAME_ORG_ORIG,'');
				ParsedNameExist := if(length(trim(StringLib.StringCleanSpaces(L.NAME_FIRST + L.NAME_MID + L.NAME_LAST+ L.NAME_SUFX))) > 0,1,0);
				
				fml	 := StringLib.StringCleanSpaces(trim(L.NAME_FIRST,right) + ' ' + trim(L.NAME_MID,right) + ' ' + trim(L.NAME_LAST,right) + ', ' + trim(L.NAME_SUFX,right));
				FullName	 := StringLib.StringCleanSpaces(L.NAME_LAST +', '+ L.NAME_FIRST + ' ' + L.NAME_MID + ' ' + L.NAME_SUFX );
				
//Bug:Â 180662- Indvidual Names not cleaning Properly w/o comma 				
				removeNick	:= MAP(L.name_format = 'L' and STD.Str.Find(L.name_org_orig, ',', 1) = 0 and L.name_last <> '' and STD.Str.Find(trim(L.name_org_orig), ' JR ', 1) > 0 =>
													 StringLib.StringFindReplace(L.name_org_orig, ' JR ', ' JR, '),
													 
													 L.name_format = 'L' and STD.Str.Find(L.name_org_orig, ',', 1) = 0 and L.name_last <> '' and STD.Str.Find(trim(L.name_org_orig), ' SR ', 1) > 0 =>
													 StringLib.StringFindReplace(L.name_org_orig, ' SR ', ' SR, '),
													 
													 L.name_format = 'L' and STD.Str.Find(L.name_org_orig, ',', 1) = 0 and L.name_last <> '' 
													 and trim(L.name_org_orig[1..STD.Str.Find(L.name_org_orig, ' ', 1) -1], right) <> trim(L.name_last, right) => fml,
													 
													 IsCompany = '' and L.std_source_upd = 'S0404' and ParsedNameExist = 0 => '',
													 IsCompany = '' and ParsedNameExist = 0 =>  Prof_License_Mari.fGetNickname(L.NAME_ORG_ORIG,'strip_nick'),
													 // isCompany = '' and ParsedNameExist = 1 => FullName,
													 FullName
													   );
														
				// removeNick			:= if(isCompany = '',Prof_License_Mari.fGetNickname(L.NAME_ORG_ORIG,'strip_nick'),
																	// FullName);
			  clean_name  := NID.CleanPerson73(removeNick);
				tmp_name_cmpny := MAP(length(trim(L.name_org)) < 1 and L.NAME_ORG_ORIG not in set_name_excluded and clean_name = '' and FullName = '' =>  L.NAME_ORG_ORIG,
															isCompany != '' and L.NAME_MARI_ORG != '' => StringLib.StringCleanSpaces(L.NAME_ORG + ' '+ L.NAME_ORG_SUFX),
															isCompany != '' and L.NAME_MARI_ORG = ''	 => StringLib.StringCleanSpaces(L.NAME_ORG + ' '+ L.NAME_ORG_SUFX),
															isCompany = ''  and clean_name = '' and FullName = ''  and  L.NAME_ORG != ''   => StringLib.StringCleanSpaces(L.name_org + ' '+ L.NAME_ORG_SUFX),
															// isCompany = '' and FullName = ''  and  L.NAME_ORG != ''   => StringLib.StringCleanSpaces(L.name_org + ' '+ L.NAME_ORG_SUFX),
															isCompany = ''  and clean_name = '' and L.name_org = ''
																				and L.NAME_ORG_ORIG not in set_name_excluded => L.NAME_ORG_ORIG,
															isCompany = ''  and L.NAME_OFFICE != '' => L.NAME_OFFICE,				
															L.STD_SOURCE_UPD[1] = 'T' AND L.NAME_ORG != '' => StringLib.StringCleanSpaces(L.name_org + ' '+ L.NAME_ORG_SUFX),
															 								StringLib.StringCleanSpaces(L.NAME_MARI_ORG +' '+ L.NAME_ORG_SUFX)
															); 																			
				self.unique_id	:= 	cnt;
				self.TITLE				:= clean_name[1..5];
				self.FNAME				:= IF(clean_name != '',clean_name[6..25],L.NAME_FIRST);
				self.MNAME				:= IF(clean_name != '',clean_name[26..45],L.NAME_MID);
				self.LNAME				:= IF(clean_name != '',clean_name[46..65],L.NAME_LAST);
				self.NAME_SUFFIX	:= IF(clean_name[66..70] not in filtered_suffix, trim(clean_name[66..70],left,right),
																IF(trim(l.NAME_SUFX) not in filtered_suffix, fGetSuffix(l.name_sufx),
																		''));
				// self.NAME_SUFFIX	:= IF(trim(l.NAME_SUFX) not in filtered_suffix, fGetSuffix(l.name_sufx),
																// IF(clean_name[66..70] not in filtered_suffix, clean_name[66..70],
																		// ''));
			 self.NAME_COMPANY	:= if(regexfind(website_pattern_1, trim(tmp_name_cmpny)), tmp_name_cmpny, NID.clnBizName(tmp_name_cmpny));
			 
			 tmp_DBA_NAME := IF(L.NAME_MARI_DBA <> '' and (L.NAME_MARI_DBA NOT IN set_dba_excluded OR L.NAME_DBA_ORIG NOT IN set_dba_excluded), 
																			L.NAME_MARI_DBA, 
																					StringLib.StringCleanSpaces(L.NAME_DBA +' '+ L.NAME_DBA_SUFX)
																					);
		   self.NAME_COMPANY_DBA := if(regexfind(website_pattern_1, trim(tmp_DBA_NAME)),tmp_DBA_NAME, NID.clnBizName(tmp_DBA_NAME));
				
				trimLicenseNbr := trim(L.license_nbr);
				SELF.CLN_LICENSE_NBR	:= IF(trimLicenseNbr = '', '',
																		IF(trimLicenseNbr = 'NR','',
																				 Prof_license_mari.fCleanLicenseNbr(trimLicenseNbr)));
				self 						:= 	L;
				self						:= 	[];
		end;

		SeqFile := distribute(project(dsBaseFile,into_seq(LEFT,COUNTER)),unique_id);

		addresslayout :=	record
				unsigned8	UNIQUE_ID;			// to tie back to original record
				unsigned4	ADDRESS_TYPE;		// physical or mailing
				string5 	STD_SOURCE_UPD;
			  string10	ADDR_ID;
		    string50	ADDR_ADDR1;
		    string50	ADDR_ADDR2;
		    string25	ADDR_CITY;
		    string2		ADDR_STATE;
		    string5		ADDR_ZIP5;
		    string4		ADDR_ZIP4;
		    string10	PHN_PHONE;
		    string10	PHN_FAX;
		    string35	ADDR_CNTY;
		    string25	ADDR_CNTRY;
		    string5		SUD_KEY;
		    integer1	OOC_IND;
		    string2		RESULT_CD;
		    string4		ADDR_CARRIER_RTE;
		    string3		ADDR_DELIVERY_PT;
				string50	PREP_ADDR_ADDR1;
		    string50	PREP_ADDR_ADDR2;
				string100	CONTACT_INFO;
				string100					Append_Prep_AddressFirst;
				string50					Append_Prep_AddressLast;
				AID.Common.xAID		Append_RawAID;		
				AID.Common.xAID		Append_AceAID;			
		end;



		addresslayout tNormalizeAddress(seqrec l, unsigned4 cnt) := transform
				self.unique_id					:= 	l.unique_id;
				self.address_type				:= 	cnt;
				self.STD_SOURCE_UPD			:= l.std_source_upd;
			  self.ADDR_ID						:= choose(cnt	,l.ADDR_ADDR1_1, l.ADDR_ADDR1_2);
		    self.ADDR_ADDR1					:= choose(cnt	,l.ADDR_ADDR1_1, l.ADDR_ADDR1_2);
		    self.ADDR_ADDR2					:= choose(cnt	,l.ADDR_ADDR2_1, l.ADDR_ADDR2_2);
			  self.ADDR_CITY					:= choose(cnt	,l.ADDR_CITY_1, l.ADDR_CITY_2);
		    self.ADDR_STATE					:= choose(cnt	,l.ADDR_STATE_1, l.ADDR_STATE_2);
		    self.ADDR_ZIP5					:= choose(cnt	,l.ADDR_ZIP5_1, l.ADDR_ZIP5_2);
		    self.ADDR_ZIP4					:= choose(cnt	,l.ADDR_ZIP4_1, l.ADDR_ZIP4_2);
		    self.PHN_PHONE					:= choose(cnt	,l.PHN_PHONE_1, l.PHN_PHONE_2);
		    self.PHN_FAX						:= choose(cnt	,l.PHN_FAX_1, l.PHN_FAX_2);
		    self.ADDR_CNTY					:= choose(cnt	,l.ADDR_CNTY_1, l.ADDR_CNTY_2);
		    self.ADDR_CNTRY					:= choose(cnt	,l.ADDR_CNTRY_1, l.ADDR_CNTRY_2);
		    self.SUD_KEY						:= choose(cnt	,l.SUD_KEY_1, l.SUD_KEY_2);
		    self.OOC_IND						:= choose(cnt	,l.OOC_IND_1, l.OOC_IND_2);
				self.RESULT_CD					:= choose(cnt	,l.RESULT_CD_1, l.RESULT_CD_2);
		    self.ADDR_CARRIER_RTE		:= choose(cnt	,l.ADDR_CARRIER_RTE_1, l.ADDR_CARRIER_RTE_2);
		    self.ADDR_DELIVERY_PT		:= choose(cnt	,l.ADDR_DELIVERY_PT_1, l.ADDR_DELIVERY_PT_2);
		    self.Append_Prep_AddressFirst	:= 	choose(cnt	,l.Append_BusAddrFirst, l.Append_MailAddrFirst);
				self.Append_Prep_AddressLast	:= 	choose(cnt	,l.Append_BusAddrLast, l.Append_MailAddrLast);
				self.Append_RawAID						:=	choose(cnt	,l.Append_BusRawAID, l.Append_MailRawAID);
				self.Append_ACEAID						:=	choose(cnt	,l.Append_BusAceAID, l.Append_MailAceAID);
				self.CONTACT_INFO				:= '';
				self.PREP_ADDR_ADDR1		:= '';
				self.PREP_ADDR_ADDR2		:= '';
		end;
				
		dAddressNormalized			:= 	normalize(SeqFile, 2, tNormalizeAddress(left,counter),local);
		
		
addresslayout tAppendPrepAddr(dAddressNormalized l) := TRANSFORM
	
	care_of_pattern := '^(C/O|ATTN[:]?)([A-Za-z ][^0-9]+)([0-9A-Z \\-\\.\\,]+)*$';
	care_of_suite 	:= '^(C/O RFC)([0-9A-Za-z ]+)$';
	
// REMOVE CONTACT INFO FROM ADDRESS FIELDS
		rmvContactAddr1	:= if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(care_of_pattern,trim(l.ADDR_ADDR1)), regexfind(care_of_pattern,trim(l.ADDR_ADDR1),3),
													if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(DBApattern, trim(l.ADDR_ADDR1)), Prof_License_Mari.mod_clean_name_addr.GetCorpName(L.ADDR_ADDR1),''));
		rmvContactAddr2	:= if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(care_of_suite, trim(l.ADDR_ADDR2)),regexfind(care_of_suite, trim(l.ADDR_ADDR2),2),
													if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(DBApattern, trim(l.ADDR_ADDR2)), Prof_License_Mari.mod_clean_name_addr.GetCorpName(L.ADDR_ADDR2),''));
		
//GET CONTACT INFO FROM ADDRESS FIELDS
		getContactAddr1	:= if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(care_of_pattern,trim(l.ADDR_ADDR1)), regexfind(care_of_pattern,trim(l.ADDR_ADDR1),2),
													if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(DBApattern, trim(l.ADDR_ADDR1)), Prof_License_Mari.mod_clean_name_addr.GetDBAName(L.ADDR_ADDR1),''));
		getContactAddr2	:= if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(care_of_suite, trim(l.ADDR_ADDR2)),regexfind(care_of_suite, trim(l.ADDR_ADDR2),1),
													if(L.STD_SOURCE_UPD = 'S0900' AND regexfind(DBApattern, trim(l.ADDR_ADDR2)), Prof_License_Mari.mod_clean_name_addr.GetDBAName(L.ADDR_ADDR2),''));
													
		tmpAddrZip := TRIM(TRIM(l.ADDR_ZIP5,LEFT,RIGHT) + IF(l.ADDR_ZIP4 <> '','-',''),LEFT) 
												+ TRIM(l.ADDR_ZIP4,LEFT,RIGHT);
												
		tmpCitySTZip := StringLib.StringCleanSpaces(l.Addr_City + l.Addr_State + l.addr_zip5);
		prepAddress1 := MAP(
												regexfind(DBApattern, trim(l.ADDR_ADDR1)) => StringLib.StringFilterOut(rmvContactAddr1,'('),
												TRIM(l.ADDR_ADDR1) in ['PO BOX #','PO BOX BOX','PO BOX NUMBER','PO BOX OFFICE','PO BOX BIN','PO BOX POB','PO BOX DRWR','PO BOX DRAWER'] and l.ADDR_ADDR2 = '' => '',			
												StringLib.Stringfind(l.ADDR_ADDR1[1..7],'DRAWER ',1) > 0 => StringLib.Stringfindreplace(l.ADDR_ADDR1,'DRAWER ', 'PO BOX '),
												StringLib.Stringfind(l.ADDR_ADDR1[1..4],'BOX ',1) > 0 => StringLib.Stringfindreplace(TRIM(l.ADDR_ADDR1),'BOX ', 'PO BOX '),
												StringLib.Stringfind(l.ADDR_ADDR1,'(',1) > 0 and l.ADDR_ADDR1[1] <> '(' and REGEXFIND(single_paren,l.ADDR_ADDR1)=> REGEXFIND(single_paren,l.ADDR_ADDR1,1),
												StringLib.Stringfind(TRIM(l.ADDR_ADDR1[1]),'(',1) > 0 and REGEXFIND(begin_paren,l.ADDR_ADDR1)=> REGEXFIND(begin_paren,l.ADDR_ADDR1,2),
												StringLib.Stringfind(l.ADDR_ADDR1,'NEED CHECK',1) > 1 => REGEXFIND(misc_pattern,l.ADDR_ADDR1,1),
												StringLib.Stringfind(l.ADDR_ADDR1,'NO MAIL',1) > 1 => REGEXFIND(misc_pattern,l.ADDR_ADDR1,1),
											  StringLib.Stringfind(TRIM(l.ADDR_ADDR1),'@',1) > 0 and not StringLib.stringfind(l.ADDR_ADDR1,'@COM',1) > 0 
														and REGEXFIND(sign_pattern,l.ADDR_ADDR1)  => REGEXFIND(sign_pattern,l.ADDR_ADDR1,1),
												StringLib.stringfind(l.ADDR_ADDR1,'\\',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,'\\','/'),
												StringLib.stringfind(l.ADDR_ADDR1,'; STE',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,'; STE',', STE'),
												StringLib.stringfind(l.ADDR_ADDR1,'; SUITE',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,'; SUITE',', SUITE'),
												StringLib.stringfind(l.ADDR_ADDR1,'; FLOOR',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,'; FLOOR',', FLOOR'),
												StringLib.stringfind(l.ADDR_ADDR1,'; BLDG',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,'; BLDG',', BLDG'),
												StringLib.stringfind(l.ADDR_ADDR1,';. ',1)> 0 => StringLib.StringFindReplace(l.ADDR_ADDR1,';. ',', '),
												l.std_source_upd = 'S0645'and REGEXFIND('([0-9]+)', TRIM(l.ADDR_CITY)) => l.ADDR_CITY,
																		Prof_License_Mari.mod_clean_name_addr.strippunctMisc(l.ADDR_ADDR1));
																		
		prepAddress2 := MAP(regexfind(DBApattern, trim(l.ADDR_ADDR2)) => StringLib.StringFilterOut(rmvContactAddr2,'('),
												StringLib.Stringfind(l.ADDR_ADDR2[1..7],'DRAWER ',1) > 0 => StringLib.Stringfindreplace(l.ADDR_ADDR2,'DRAWER ', 'PO BOX '),
												REGEXFIND(city_addr,l.ADDR_CITY) => l.ADDR_CITY,
												l.std_source_upd = 'S0900' and trim(l.addr_addr2) = 'COMPLIANCE/MEMBER ADMINISTRATION' => '',
												l.std_source_upd = 'S0900' and stringlib.stringfind(L.ADDR_ADDR2,';',1) > 0 => stringlib.stringfindreplace(L.ADDR_ADDR2,';',','),												
																	l.ADDR_ADDR2);	
																	
		prepCity     := MAP(TRIM(l.ADDR_ADDR1) = TRIM(l.ADDR_CITY) => '', 
												TRIM(l.ADDR_CITY) = TRIM(tmpAddrZip) => '',
												REGEXFIND(city_addr,l.ADDR_CITY) => '',
												TRIM(l.ADDR_CITY) IN ['N/A','TEMP EXP 11/03','ING 4/25/91'] => '',
												l.std_source_upd = 'S0645' and REGEXFIND('([0-9]+)', TRIM(l.ADDR_CITY)) => '',
												StringLib.stringfind(l.ADDR_CITY,'%20',1)> 0 => StringLib.StringFindReplace(l.ADDR_CITY,'%20',' '),
														l.ADDR_CITY);
    
		self.PREP_ADDR_ADDR1	:= rmvContactAddr1;
		self.PREP_ADDR_ADDR2	:= rmvContactAddr2;
    self.contact_info	:= if( getContactAddr1 != '', getContactAddr1,getContactAddr2);	
		self.Append_Prep_AddressFirst			:=	MAP(l.ADDR_CNTRY <> '' and trim(l.ADDR_CNTRY) not in ['US','UNITED STATES'] => '',
  																						tmpCitySTZip = '' => '',
																							Address.fn_addr_clean_prep(TRIM(TRIM(prepAddress1, LEFT,RIGHT) + ' ' 
																																		+ TRIM(prepAddress2,LEFT,RIGHT)),'first'));	
																																			
																							
		self.Append_Prep_AddressLast	:=	MAP(l.ADDR_CNTRY <> '' and trim(l.ADDR_CNTRY) not in ['US','UNITED STATES'] => '',
																					tmpCitySTZip = '' => '',
																					Address.fn_addr_clean_prep(TRIM(TRIM(prepCity,LEFT,RIGHT) 
																																+ IF(prepCity <> '',', ','') + TRIM(l.ADDR_STATE,LEFT,RIGHT)) 
																																+ ' ' + TRIM(tmpAddrZip,LEFT,RIGHT),'last'));
    self := l;
	END;

	dAddressPrep	:= PROJECT(dAddressNormalized, tAppendPrepAddr(LEFT)); //: persist('~thor_data400::persist::proflic_mari::pre_clean');;
	
		
	// HasCanAddr 				:= dAddressPrep(addr_cntry = 'CANADA' or Addr_State[1..2] in canadian_states_abbv or 
													// (StringLib.StringFind(Addr_City,'CANADA',1) > 0 and Addr_City[1..9] not in ['LA CANADA', 'LITTLE CA','NEW CANAD']));

	// HasNoCanAddr		 := dAddressPrep - HasCanAddr;

	HasAddress				:= 	trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';
												
	dWith_address			:= 	dAddressPrep(HasAddress);
	dWithout_address	:= 	dAddressPrep(not(HasAddress));
										
		dStandardizeInput_dist 	:= distribute(SeqFile	,unique_id);

		cleanedAddrLayout :=	record
			addresslayout;
			address.Layout_Clean182		Clean_Address;
		end;

	//AID process
		unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
		AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_AddressFirst, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
		cleanedAddrLayout	tCleanAddressAppended(dAddressCleaned pInput)	:=	transform
				self.Append_RawAID			:=	pInput.AIDWork_RawAID;
				self.Append_ACEAID			:=	pInput.aidwork_acecache.aid;		
				self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
				self.clean_address			:=	pInput.AIDWork_ACECache;
				self										:=	pInput;
		end;
					
		dCleanAddressAppended				:=	project(dAddressCleaned,tCleanAddressAppended(left));	
				
		dCleanAddressAppended_dist	:= 	distribute(dCleanAddressAppended	,unique_id);
		
		
		seqRec tGetStandardizedAddress(seqRec l	,cleanedAddrLayout r) :=	transform
				self.Append_BusRawAID	:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_busRawAID);
				self.Append_BusACEAID	:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_busACEAID);
				self.bus_prim_range		:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.bus_prim_range);
				self.bus_predir				:= if(r.address_type = 1	,r.Clean_address.predir				,l.bus_predir);
				self.bus_prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.bus_prim_name);
				self.bus_addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.bus_addr_suffix);
				self.bus_postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.bus_postdir);
				self.bus_unit_desig		:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.bus_unit_desig);
				self.bus_sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.bus_sec_range);
				self.bus_p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.bus_p_city_name);
				self.bus_v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.bus_v_city_name);
				self.bus_state				:= if(r.address_type = 1	,r.Clean_address.st						,l.bus_state);
				self.bus_zip5					:= if(r.address_type = 1	,r.Clean_address.zip					,l.bus_zip5);
				self.bus_zip4					:= if(r.address_type = 1	,r.Clean_address.zip4					,l.bus_zip4);		
				self.bus_cart					:= if(r.address_type = 1	,r.Clean_address.cart					,l.bus_cart);
				self.bus_cr_sort_sz		:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.bus_cr_sort_sz);
				self.bus_lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.bus_lot);
				self.bus_lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.bus_lot_order);
				self.bus_dpbc					:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.bus_dpbc);
				self.bus_chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.bus_chk_digit);
				self.bus_rec_type			:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.bus_rec_type);
				self.bus_ace_fips_st	:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.bus_ace_fips_st);
				self.bus_county				:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.bus_county);
				self.bus_geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.bus_geo_lat);
				self.bus_geo_long			:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.bus_geo_long);
				self.bus_msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.bus_msa);
				self.bus_geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.bus_geo_blk);
				self.bus_geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.bus_geo_match);
				self.bus_err_stat			:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.bus_err_stat);
		
				self.Append_MailRawAID:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_MailRawAID);
				self.Append_MailAceAID:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_MailAceAID);
				self.mail_prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.mail_prim_range);
				self.mail_predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.mail_predir);
				self.mail_prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.mail_prim_name);
				self.mail_addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.mail_addr_suffix);
				self.mail_postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.mail_postdir);
				self.mail_unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.mail_unit_desig);
				self.mail_sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.mail_sec_range);
				self.mail_p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.mail_p_city_name);
				self.mail_v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.mail_v_city_name);
				self.mail_state				:= if(r.address_type = 2	,r.Clean_address.st						,l.mail_state);
				self.mail_zip5				:= if(r.address_type = 2	,r.Clean_address.zip					,l.mail_zip5);
				self.mail_zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.mail_zip4);		
				self.mail_cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.mail_cart);
				self.mail_cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.mail_cr_sort_sz);
				self.mail_lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.mail_lot);
				self.mail_lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.mail_lot_order);
				self.mail_dpbc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.mail_dpbc);
				self.mail_chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.mail_chk_digit);
				self.mail_rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.mail_rec_type);
				self.mail_ace_fips_st	:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.mail_ace_fips_st);
				self.mail_county			:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.mail_county);
				self.mail_geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.mail_geo_lat);
				self.mail_geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.mail_geo_long);
				self.mail_msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.mail_msa);
				self.mail_geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.mail_geo_blk);
				self.mail_geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.mail_geo_match);
				self.mail_err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.mail_err_stat);
				self									:= l;
				self									:= [];
		end;
				
		dCleanPhysAddrAppended		:= join(
																			dStandardizeInput_dist
																			,dCleanAddressAppended_dist(address_type = 1)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
																			
		dCleanMailAddrAppended		:= join(
																			dCleanPhysAddrAppended
																			,dCleanAddressAppended_dist(address_type = 2)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);

		ut.mac_flipnames(dCleanMailAddrAppended,name_first,name_mid,name_last,cleanNames);
		
		CleanedUpFile	:=	project(cleanNames,TRANSFORM(Prof_License_Mari.layouts.final,SELF := LEFT));
		// : persist('~thor_data400::persist::proflic_mari::pre_rollup');
		
		return CleanedUpFile;
		
end;

