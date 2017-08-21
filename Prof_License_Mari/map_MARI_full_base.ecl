import ut, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date, address;


export  map_Mari_full_base (string pVersion) := function
#workunit('name','MARI Full Base' + pVersion);
	   
// Standard Date Format YYYYMMDD
Format_Date(integer2 year, integer1 month, integer1 day)       
     :=
        (string4)year+intformat(month,2,1)+intformat(day,2,1);

quote_pattern	:= '^(.*)\\"(.*)\\"(.*)$';
paren_pattern := '^(.*)\\((.*)\\)(.*)$';
begin_paren := '^\\((.*)\\)(.*)$';
dbl_quote_pattern := '^(.*)\\"\\"(.*)\\"\\"(.*)$';
CO_pattern := '^(.*)(C/O |%| C/0|ATTN:|ATTN |ATT:)(.*)$';

C_O_Ind := '(C/O |ATTN:| ATTN |ATTENTION:|ATT:|%|ATN:)';
DBA_Ind := '( DBA$|D/B/A | D/B/A|/DBA | DBA |DBA:|/DBA|^DBA| A/K/A| AKA |^AKA |T/A |A/K/A |A/K/A$|^D B A|/DBA/)';
AGENT_Ind := '(AGENT FOR|AGENT OR|AGENT 4|AGENT FO|AGENT OF|AGENTS| AGENT|AGENT/|AGENTFOR|AGENTF OR|AGENT-|AS RECEIVER|AGT FOR|AGT | AG$|'+
								'AGENG FOR|AGENR FOR|AGE FOR| AGEN$| AGENT$)';

BusExceptions := '(2.5% |-2-|.COM|A.M.E.|AM CAN CO|ASSIST 2 |E.P.A.|EVOFI ONE|EXCLUSIVE| HOME |HOSPITLAL|INTEGRITY 1ST|IRELAND|JD R E|KEYSTONE|'+
									'L.C.|L[.]L[.]C[.]| LP\\>|LONG AND FOSTER|NEWS DISPATCH|PALM HARBOR |PIERRE|PIERCE|POLICE|P.W.H.O.A.|'+
									'OWENS CORNING FIBE|SACRED HEART| SERVS|STOCKING|SVC|STATION|TECH PROD|TELEPHONE|TERMINAL|TRNTY PROP SERV| WORKS|WEBSTER HALL|'+
									'BASE, TN|PLANT EMPLOYEE)';

AddrExceptions := '(PLAZA| PLZ|^BLDG |^BLGD | BLDG|BLDING|BUILDING | BLD |APARTMENT|ONE | AVE |AVENUE| AV |^AVE | TOWER| BLVD|GENERAL DELIVERY| ESTS|'+
									'ROAD|^R D | AND MAIN\\>| & MAIN\\>|^THREE |^THIRD |THOUSAND|^FOUR|^SIX |^SIXTH |^ELEVENTH|^FIFTH|^FIVE|^NINTH |^EIGHTH |^SEVENTH |^TENTH |^TWELFTH|^TWELVETH|RIVERWALK|'+
									' ALLEY|SECOND|FLOOR|PAVILION|PAVILLION| RD|TOWN$|LEVEL|LOWR LL|CREEK|ROUTE|^RTE|CENTRE| CTR\\>| CT\\>| DR\\>| PARK|DRIVE| SQUARE| SQ\\>| WAY|LOCATION|^UNIT |UNIT |'+
									'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND| MALL| VILLA$|P M B|PMB | LODGE|^BOOTH |ACRES|AIRPORT|'+
									'UPPER|TRACE|#|LANE|LAGOONS|PENTHOUSE |POST OFFICE|^POST| STS\\>| AVES\\>| ST\\>|STREET|FRONT|FAIR GROUNDS|FAIRGROUNDS|BETWEEN|'+
									'APT.|APT |APT[.] |APT$|APARTMENT |P O |PO |POB |PO DRAWER|P O DRAWER|^DRAWER |BOX |BOX|ROOM |^RT | RT |HIGHWAY|HWY|RIDGE| PL\\>|'+
									'EXPRESSWAY| STE |^STE |^SUIT |STE |SUITE|SU | PKWY|CROSSING|CORNER OF|& MAINLAND| AT MAIN|MAIN AND|MAIN &|^HCR|MAIL STOP| LN\\>| MANOR\\>| MNR\\>| TPKE\\>|'+
									'METROPLEX|PARKWAY|^COURT |^PH |^RM | RM\\>|^ROOM |LBBY|^SPC |BSMT|OFC|TRLR|^LOT | LOT\\>|^FL | CENTER WEST| TERRACE\\>| TRAIL\\>| TR\\>| TRL\\>|'+
									'STUDIO|MARKETPLACE| COMMONS\\>|CORPORATE CENTER|COMMERCE CENTER|EXECUTIVE CENTER|PROFESSIONAL CEN|SHOPPING|SHOPPING CTR|CITY CENTER|SUBDIVISION|'+
									'SHOPPING CENTER|BUSINESS OFFICE|SHOP COMPLEX|NAVAL STATION|NAVAL AIR STATION|AIR FORCE BASE|PROFESSIONAL COMPLEX|VETERANS HOME|MARINA|RESIDENTIAL|'+
									'METROPOLITAN|^LAKE | LAKE\\>| TWP| CONDO|COTTAGE|RESORT|HALF DAY|FREEWAY| CIRCLE\\>| CIR\\>|HARBOR|^NORTHERN|^NORTH| COVE\\>|ARENA|CAFE|AISLE| PATH\\>)'; 

valid_unit_desig := '( APT|^APT|BSMT|BLDG|^FL |FRNT|HNGR|LBBY|^LOT |LOWR|OFC|^PH |PIER|^REAR|^RM |^SIDE|SLIP|SPC|^STOP|^STE |TRLR|^UNIT|^UPPR)';


inFile_base 	:= Prof_License_Mari.file_cmrflat;

//Filter Bad records
FilterHeadings := inFile_base(NOT REGEXFIND(Prof_License_Mari.filters.BadAddrFilter, Trim(ADDR_ADDR1_1)));
NonBlankOrg		:= FilterHeadings(NAME_ORG_ORIG <> '' and NAME_ORG <> '');
NonSkewRecs 	:= NonBlankOrg(ADDR_ID_2 <> 'False');
FilterMiscRecs := NonSkewRecs(name_org_orig[1] <> '|' and name_org[1] <> '|');
GoodRecs			:= FilterMiscRecs(not (StringLib.stringfind(name_org_orig,'|',1)  > 0 and Stringlib.stringfind(name_org,'|',1) >0));

maribase_plus_dbas := record, maxsize(5000)
 Prof_License_Mari.layouts.base,
	// unsigned integer PREV_PRIMARY_KEY,
	string50 tmpNAME_OFFICE,

end;

//Mapping MARIFLAT Full Dump file into MARIFLAT_out Layout
maribase_plus_dbas xformCmrFlat(Prof_License_Mari.layouts.mari_in pInput) 
    := 
	   TRANSFORM
	       self.PRIMARY_KEY		:= pInput.PRIMARY_KEY;
				
		   // Reformatting the following date format: M/D/YYYY, MM/D/YYYY, MM/DD/YYYY, and YYYY-MM-DD to YYYYMMDD
	     self.CREATE_DTE			:= MAP(REGEXFIND('[0-9]+/[0-9]+/[0-9]{4}',pInput.CREATE_DTE) =>	ut.date_slashed_MMDDYYYY_to_YYYYMMDD(pInput.CREATE_DTE),
																	 	 REGEXFIND('[0-9]{4}\\-[0-9]+\\-[0-9]+', pInput.CREATE_DTE) => Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.CREATE_DTE),
																											'');
										   
		   self.LAST_UPD_DTE		:= pInput.LAST_UPD_DTE[1..4] + pInput.LAST_UPD_DTE[6..7] + pInput.LAST_UPD_DTE[9..10];
		   self.STAMP_DTE				:= pInput.STAMP_DTE[1..4] + pInput.STAMP_DTE[6..7] + pInput.STAMP_DTE[9..10];
			 self.DATE_FIRST_SEEN := self.STAMP_DTE;
			 self.DATE_LAST_SEEN 	:= self.STAMP_DTE;
			 self.PROCESS_DATE		:= thorlib.wuid()[2..9];
			 self.DATE_VENDOR_FIRST_REPORTED := self.STAMP_DTE;
			 self.DATE_VENDOR_LAST_REPORTED 	:= self.STAMP_DTE;
			 self.GEN_NBR					:= pInput.GEN_NBR;
			 TrimTypeCd := ut.fnTrim2Upper(pInput.TYPE_CD);
		   self.TYPE_CD					:= TrimTypeCd;
			 self.STD_SOURCE_DESC	:= '';
			 self.STD_PROF_DESC 		:= '';
			 self.RAW_LICENSE_TYPE := '';
			 self.STD_LICENSE_DESC := '';
			 self.RAW_LICENSE_STATUS := '';
			 self.STD_STATUS_DESC 	:= '';
			 
			 TrimNAME := ut.fnTrim2Upper(pInput.NAME_ORG);
			 TrimNAME_DBA := ut.fnTrim2Upper(pInput.NAME_DBA);
			 TrimNAME_ORG := StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.NAME_ORG_ORIG));
			 TrimDBA_ORIG := StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.NAME_DBA_ORIG));
			 TrimNAME_OFFICE := ut.fnTrim2Upper(pInput.NAME_OFFICE);
			 TrimAddr1_Bus := ut.fnTrim2Upper(pInput.ADDR_ADDR1_1);
			 TrimAddr2_Bus	:= ut.fnTrim2Upper(pInput.ADDR_ADDR2_1);
			 
			 tmpNAME_ORG := IF(TrimTypeCd = 'GR' and REGEXFIND('^([^0-9])*$',TrimAddr1_Bus) and REGEXFIND('( BRANCH\\>|^CREDIT UNION)',TrimAddr1_Bus)
														and not Prof_License_Mari.BogusAddress(TrimAddr1_Bus),
																	StringLib.StringCleanSpaces(TrimNAME_ORG + ' ('+ TrimAddr1_Bus +')'),TrimNAME);
													
			 rmvNAME_AGT := IF(pInput.std_source_upd = 'S0404' and REGEXfIND(Agent_Ind,tmpNAME_ORG) 
														and not REGEXFIND('(AGENTFOR$|AGENTS$|AGENT$|^AGENTS|^AGENT|THE AGENT|ELITE AGENTS|WONDERAGENTS|AGT INC$)',tmpNAME_ORG),
														REGEXFIND('([A-Za-z0-9 \\&\\,\\.\\-\\/\\*\\+\'\\#]+)(AS AGENT FO$|AS AGENT FOR$|AGENT FOR$|AGENT OR|AGENT 4|AGENT FO|AGENT OF|AGENTFOR|AGENTF OR|AGENT-|AGENTS |AGENT/|AGENT |AS RECEIVER|AS RECEIVER FOR|AGT FOR|AGT |AGE FOR|AGENR FOR|AGENG FOR| AGEN$|AG$|AS$)',tmpNAME_ORG,1),
													tmpNAME_ORG);
			 self.NAME_ORG_PREFX	:= ut.fnTrim2Upper(pInput.NAME_ORG_PREFX);																	
			 self.NAME_ORG				:= rmvNAME_AGT;
			 self.NAME_ORG_SUFX		:= ut.fnTrim2Upper(pInput.NAME_ORG_SUFX);
			 self.NAME_DBA_PREFX	:= ut.fnTrim2Upper(pInput.NAME_DBA_PREFX);
			 // self.NAME_DBA				:= TrimNAME_DBA;
			 self.NAME_DBA_SUFX		:= ut.fnTrim2Upper(pInput.NAME_DBA_SUFX);
			 self.NAME_PREFX			:= ut.fnTrim2Upper(pInput.NAME_PREFX);
			 self.NAME_FIRST			:= ut.fnTrim2Upper(pInput.NAME_FIRST);
		   self.NAME_MID				:= ut.fnTrim2Upper(pInput.NAME_MID);
		   self.NAME_LAST				:= ut.fnTrim2Upper(pInput.NAME_LAST);
		   self.NAME_SUFX				:= ut.fnTrim2Upper(pInput.NAME_SUFX);
			 
			 TrimNAME_NICK := ut.fnTrim2Upper(pInput.NAME_NICK);
			 // prepNAME_NICK := StringLib.StringFindReplace(TrimNAME_NICK, 'A/K/A ','');
			 // self.NAME_NICK				:= prepNAME_NICK;
			 self.NAME_NICK					:= StringLib.StringFindReplace(TrimNAME_NICK, 'A/K/A ','');
		   self.LICENSE_NBR				:= pInput.LICENSE_NBR;
		   self.OFF_LICENSE_NBR		:= pInput.OFF_LICENSE_NBR;
			 self.PREV_LICENSE_NBR 	:= '';
			 self.PREV_LICENSE_TYPE := '';
			 self.CURR_ISSUE_DTE	:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.CURR_ISSUE_DTE[1..10]);
		   self.ORIG_ISSUE_DTE	:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.ORIG_ISSUE_DTE[1..10]);
		   self.EXPIRE_DTE			:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.EXPIRE_DTE[1..10]);
			 self.RENEWAL_DTE			:= '';
			 self.NAME_FORMAT			:= '';
			 self.NAME_ORG_ORIG   := TrimNAME_ORG;
			 self.NAME_DBA_ORIG		:= ut.fnTrim2Upper(pInput.NAME_DBA_ORIG);
	     self.PHN_MARI_1			:= IF(pInput.PHN_MARI_1 = '0000000000','',stringlib.stringfilter(pInput.PHN_MARI_1,'0123456789')[1..10]); 
			 self.PHN_MARI_FAX_1	:= IF(pInput.PHN_MARI_FAX_1 = '0000000000','',stringlib.stringfilter(pInput.PHN_MARI_FAX_1,'0123456789')[1..10]); 
		
		// Removing "Agent" variation from ORG NAME
			 getNAME_ORG := MAP(REGEXFIND(AGENT_Ind,TrimNAME_ORG) and REGEXFIND('^([^0-9])*$',TrimAddr1_Bus) and pInput.STD_SOURCE_UPD = 'S0404'
																=> StringLib.StringCleanSpaces(TrimNAME_ORG + ' '+ pInput.ADDR_ADDR1_1),
													REGEXFIND('( FOR$| AGEN$| AGT$| AG$| OF$|&$| AGE$)',TrimNAME_ORG) and not REGEXFIND('[0-9]',TrimAddr1_Bus)
													and not REGEXFIND('(SUITE$|STE$|SUITE|STE| PO BOX| P O BOX| PBM| UNIT| ST$|0-9)',TrimAddr1_Bus)
																	=> StringLib.StringCleanSpaces(TrimNAME_ORG + ' '+ TrimAddr1_Bus),
													REGEXFIND('( FOR$| AGEN$| AG$| OF$|&$|OF THE$)',TrimNAME_ORG) and REGEXFIND('(MORTGAGE|BANK OF|^1ST|MTG)',TrimAddr1_Bus)
																	=> StringLib.StringCleanSpaces(TrimNAME_ORG + ' '+ TrimAddr1_Bus),
													pInput.STD_SOURCE_UPD = 'S0404'  and REGEXFIND(AGENT_Ind,TrimAddr1_Bus)
													and not Prof_License_Mari.BogusAddress(TrimAddr1_Bus) => StringLib.StringCleanSpaces(TrimNAME_ORG + ' '+ TrimAddr1_Bus),
																TrimNAME_ORG);
			  prepNAME_ORG := MAP(StringLib.Stringfind(getNAME_ORG,' D.B.A: ',1) > 0 => StringLib.StringFindReplace(getNAME_ORG,' D.B.A: ',' D/B/A '),
			                      StringLib.Stringfind(getNAME_ORG,'D B A ',1) > 0 => StringLib.StringFindReplace(getNAME_ORG,'D B A ','D/B/A '),
													  StringLib.Stringfind(getNAME_ORG,'/DBA/',1) > 0 => StringLib.StringFindReplace(getNAME_ORG,'/DBA/',' D/B/A '),
																					getNAME_ORG);													
			 BlankOutAddr1_Bus := If(TrimAddr1_Bus != '' and Prof_License_Mari.BogusAddress(TrimAddr1_Bus),'',TrimAddr1_Bus);
			 BlankOutAddr2_Bus := If(TrimAddr2_Bus != '' and Prof_License_Mari.BogusAddress(TrimAddr2_Bus),'',TrimAddr2_Bus);
			 BlankBogusOffice := If(TrimName_OFFICE != '' and Prof_License_Mari.BogusAddress(TrimName_OFFICE),'',TrimName_OFFICE);
			 tmpAddr1_Bus := MAP(REGEXFIND('^(DBA |AND |COMPANY|OR |SR VP)',BlankOutAddr2_Bus) => BlankOutAddr1_Bus +' '+ TrimAddr2_Bus,
														REGEXFIND('^(INC |CORP |LLC )',BlankOutAddr2_Bus) => BlankOutAddr1_Bus +' '+ TrimAddr2_Bus[1..4],
														pInput.NAME_ORG_ORIG <> '' and pInput.NAME_ORG_ORIG[1..20] = BlankOutAddr1_Bus[1..20] => '',
														pInput.STD_SOURCE_UPD = 'S0404' and REGEXFIND(AGENT_Ind,TrimNAME_ORG) and REGEXFIND('^([^0-9])*$',BlankOutAddr1_Bus) => '',
														REGEXFIND('( FOR$| AGEN$| AGT$| AG$| OF$|&$| AGE$)',TrimNAME_ORG) and not REGEXFIND('[0-9]',BlankOutAddr1_Bus)
														and not REGEXFIND('(SUITE$|STE$|SUITE|STE| PO BOX| P O BOX| PBM| UNIT| ST$|0-9)',BlankOutAddr1_Bus)
																=> '',
														pInput.STD_SOURCE_UPD = 'S0404' and REGEXFIND(AGENT_Ind,BlankOutAddr1_Bus) => '',
													
														REGEXFIND('( FOR$| AGEN$| AG$| OF$|&$|OF THE$)',TrimNAME_ORG) and REGEXFIND('(MORTGAGE|BANK OF|^1ST|MTG)',BlankOutAddr1_Bus) => '', 
														
														REGEXFIND('^([^A-Z])*$',BlankOutAddr1_Bus) and REGEXFIND('^([^0-9])*$',BlankOutAddr2_Bus)
														and not REGEXFIND(BusExceptions,TrimAddr2_Bus)=> BlankOutAddr1_Bus +' '+ BlankOutAddr2_Bus,
														BlankOutAddr1_Bus);
			
			prepAddr1_Bus := MAP(REGEXFIND(C_O_Ind,tmpAddr1_Bus) and REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$',tmpAddr1_Bus)
																=> REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$',tmpAddr1_Bus,2),
														REGEXFIND(C_O_Ind,tmpAddr1_Bus) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpAddr1_Bus),
														REGEXFIND(DBA_Ind,tmpAddr1_Bus) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpAddr1_Bus),
														REGEXFIND('(CARE OF)',tmpAddr1_Bus) => '',
														StringLib.stringFind(tmpAddr1_Bus,'C\\O ',1) > 0 => StringLib.StringFindReplace(tmpAddr1_Bus,'C\\O ',''),
														pInput.ADDR_CNTRY_1 <> '' => tmpAddr1_Bus,
														REGEXFIND('^(&|AND |OF |OR )',tmpAddr1_Bus) => '',
														REGEXFIND(begin_paren,tmpAddr1_Bus) => REGEXFIND(begin_paren,tmpAddr1_Bus,2),
														REGEXFIND('^(.*)( CORP | INC | LLC | LTD )(.*)$',trim(tmpAddr1_Bus)) and REGEXFIND('([0-9])',tmpAddr1_Bus) 
														and REGEXFIND('( AVE$| BLDG$| BLVD$| CT$| DORA$| DR$| EAST | HIGHWAY| HWY | LANE | PKWY$| RD$| RT | ST$| ST$| TR$| S | SO | E | NW$| S$|TH$| PAXTON$| MAUCHLY$)',tmpAddr1_Bus)
																=> REGEXFIND('^(.*)( CORP | INC | LLC | LTD )(.*)$',trim(tmpAddr1_Bus),3),
													  	tmpAddr1_Bus);
														
														
			 prepNAME_OFFICE := MAP(TrimTypeCd = 'MD' and trim(pInput.ADDR_STATE_1) <> 'PR' and trim(pInput.ADDR_CNTRY_1) = ''
															and BlankBogusOffice = ''
															and REGEXFIND('^([^0-9])*$',prepAddr1_Bus)
															// and not REGEXFIND('^(&|AND |OF |OR )',prepAddr1_Bus)
															and not REGEXFIND(AddrExceptions,prepAddr1_Bus)
															and Prof_License_Mari.func_is_company(prepAddr1_Bus)=> prepAddr1_Bus,
															
															REGEXFIND('^([^0-9])*$',prepAddr1_Bus) and TrimTypeCd = 'MD'
															  and BlankBogusOffice = '' and pInput.ADDR_CNTRY_1 = ''
																and REGEXFIND(AddrExceptions,prepAddr1_Bus)
															  // and not REGEXFIND('^(&|AND |OF |OR )',prepAddr1_Bus)
															  and Prof_License_Mari.func_is_company(prepAddr1_Bus) 
														   	and REGEXFIND('(CORP| INC$|INSURANCE$|REAL ESTATE|REALTOR|RLTY|RLTR)',prepAddr1_Bus)=> prepAddr1_Bus,
																
															TrimTypeCd = 'MD'	and REGEXFIND('^([0-9])',prepAddr1_Bus) 
																and REGEXFIND('^(.*)( DR | PLAZA | LANE | AVE | RD | COURT | ST | PLACE | SOUTH )(.*)$',trim(prepAddr1_Bus)) 
																and REGEXFIND('( INC$| INC | CORP | LLC$|LTD |L L C )',prepAddr1_Bus)
																=> REGEXFIND('^(.*)( AVE | DR | LANE | PLAZA | PLACE | RD | COURT | ST | SOUTH )(.*)$',trim(prepAddr1_Bus),3),	
															
																'');
															
																	
			 self.BIRTH_DTE := pInput.DOB_YYYY + pInput.DOB_MM + pInput.DOB_DD;	
			 self.ADDR_BUS_IND := (STRING1)pInput.ADDR_BUS_IND_1;
		   self.ADDR_ADDR1_1	:= IF(prepNAME_OFFICE <> ' ', ' ',prepAddr1_Bus);
			 
			 prepAddr2_Bus := MAP(REGEXFIND('^(DBA |AND |COMPANY|OR |SR VP)',BlankOutAddr2_Bus) => '',
														REGEXFIND('^(INC |CORP |LLC )', BlankOutAddr2_Bus) => BlankOutAddr2_Bus[5..],
														BlankOutAddr2_Bus[1] = '%' and REGEXFIND('([0-9]+)',BlankOutAddr2_Bus) => REGEXFIND('^(%[A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$',TrimAddr2_Bus,2),
														REGEXFIND(C_O_Ind,BlankOutAddr2_Bus) and REGEXFIND(CO_pattern,BlankOutAddr2_Bus) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddr2_Bus),
														REGEXFIND(C_O_Ind,BlankOutAddr2_Bus) and REGEXFIND('([0-9]+)',BlankOutAddr2_Bus) => REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$',TrimAddr2_Bus,2),
													  REGEXFIND(DBA_Ind,BlankOutAddr2_Bus) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(BlankOutAddr2_Bus),
														REGEXFIND('^([^A-Z])*$',BlankOutAddr1_Bus) and REGEXFIND('^([^0-9])*$',BlankOutAddr2_Bus) => '',
																				BlankOutAddr2_Bus);
		   self.ADDR_ADDR2_1	:= prepAddr2_Bus;
			 self.ADDR_ADDR3_1	:= '';
			 self.ADDR_ADDR4_1	:= '';
			 TrimCity_1 := ut.fnTrim2Upper(pInput.ADDR_CITY_1);
		   self.ADDR_CITY_1		:= IF(length(TrimCity_1) < 3 and TrimCity_1 = 'NA','',TrimCity_1);
			 TrimState_1 := ut.fnTrim2Upper(pInput.ADDR_STATE_1);
		   self.ADDR_STATE_1	:= IF(REGEXFIND('([^A-Za-z])',TrimState_1) and TrimState_1 <> '','',TrimState_1);
		   self.ADDR_ZIP5_1		:= pInput.ADDR_ZIP5_1;
		   self.ADDR_ZIP4_1		:= pInput.ADDR_ZIP4_1;
			 self.ADDR_CNTRY_1 	:= ut.fnTrim2Upper(pInput.ADDR_CNTRY_1);
		 
			 TrimAddr1_Mail := ut.fnTrim2Upper(pInput.ADDR_ADDR1_2);
			 TrimAddr2_Mail := ut.fnTrim2Upper(pInput.ADDR_ADDR2_2);
			 BlankOutAddr1_Mail := If(TrimAddr1_Mail != '' and Prof_License_Mari.BogusAddress(TrimAddr1_Mail),'',TrimAddr1_Mail);
			 BlankOutAddr2_Mail := If(TrimAddr2_Mail != '' and Prof_License_Mari.BogusAddress(TrimAddr2_Mail),'',TrimAddr2_Mail);
			 tmpAddr1_Mail := MAP(pInput.NAME_ORG_ORIG <> '' and pInput.NAME_ORG_ORIG[1..20] = BlankOutAddr1_Mail[1..20] => '',
														 StringLib.StringFind(BlankOutAddr1_Bus,'BROKER',1) > 0 => '',
														 REGEXFIND('^(DBA |AND |COMPANY|OR |SR VP )',BlankOutAddr2_Mail) => BlankOutAddr1_Mail +' '+ BlankOutAddr2_Mail,
														 REGEXFIND('^(INC |CORP |LLC )',BlankOutAddr2_Mail) => BlankOutAddr1_Mail +' '+ TrimAddr2_Mail[1..4],
														 REGEXFIND('^([^A-Z])*$',BlankOutAddr1_Mail) and REGEXFIND('^([^0-9])*$',BlankOutAddr2_Mail)
														 and not REGEXFIND(BusExceptions,TrimAddr2_Mail) => BlankOutAddr1_Mail +' '+ TrimAddr2_Mail,
																BlankOutAddr1_Mail);
																
			 prepAddr1_Mail := MAP(REGEXFIND(C_O_Ind,tmpAddr1_Mail) and REGEXFIND(CO_pattern,tmpAddr1_Mail) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpAddr1_Mail),
														 REGEXFIND(C_O_Ind,tmpAddr1_Mail) and REGEXFIND('([0-9]+)',tmpAddr1_Mail) => REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$',tmpAddr1_Mail,2),
														 REGEXFIND(DBA_Ind,tmpAddr1_Mail) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpAddr1_Mail),
														 StringLib.stringFind(tmpAddr1_Mail,'C\\O ',1) > 0 => StringLib.StringFindReplace(tmpAddr1_Mail,'C\\O ',''),
														 tmpAddr1_Mail);
			 self.ADDR_MAIL_IND			:= (STRING1)pInput.Addr_Mail_Ind_2;										 
			 self.ADDR_ADDR1_2			:=  prepAddr1_Mail;
			 			 
			 prepAddr2_Mail := MAP(REGEXFIND('^(DBA |AND |COMPANY|OR |SR VP)', BlankOutAddr2_Mail) => '',
														 REGEXFIND('^(INC |CORP |LLC )', BlankOutAddr2_Mail) => BlankOutAddr2_Mail[5..],
														 REGEXFIND(C_O_Ind, BlankOutAddr2_Mail) and REGEXFIND('([0-9]+)', BlankOutAddr2_Mail) => REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z ]+)$', BlankOutAddr2_Mail,2),
														 REGEXFIND('^([^A-Za-z])*$', BlankOutAddr1_Mail) and REGEXFIND('^([^0-9])*$', BlankOutAddr2_Mail) => '',
														 StringLib.StringFind( BlankOutAddr2_Mail,'(',1) > 0 and REGEXFIND(CO_pattern, BlankOutAddr2_Mail)=> REGEXFIND(CO_pattern,TrimAddr2_Mail,1),
														 REGEXFIND('^(ATN:)', BlankOutAddr2_Mail) => REGEXFIND('^(ATN:[A-Za-z ][^0-9]+)([0-9A-Za-z ]+)', BlankOutAddr2_Mail,2),
														 REGEXFIND(CO_pattern, BlankOutAddr2_Mail) => Prof_License_Mari.mod_clean_name_addr.GetCorpName( BlankOutAddr2_Mail),
														 REGEXFIND(DBA_Ind, BlankOutAddr2_Mail) => Prof_License_Mari.mod_clean_name_addr.GetCorpName( BlankOutAddr2_Mail),
															 BlankOutAddr2_Mail);
		   self.ADDR_ADDR2_2		:= prepAddr2_Mail;
			 self.ADDR_ADDR3_2		:= '';
			 self.ADDR_ADDR4_2		:= '';
		   self.ADDR_CITY_2			:= ut.fnTrim2Upper(pInput.ADDR_CITY_2);
		   self.ADDR_STATE_2		:= ut.fnTrim2Upper(pInput.ADDR_STATE_2);
		   self.ADDR_ZIP5_2			:= pInput.ADDR_ZIP5_2;
		   self.ADDR_ZIP4_2			:= pInput.ADDR_ZIP4_2;
			 self.ADDR_CNTRY_2		:= ut.fnTrim2Upper(pInput.ADDR_CNTRY_2);
			 self.PHN_MARI_2			:= IF(pInput.PHN_MARI_2 = '0000000000','',stringlib.stringfilter(pInput.PHN_MARI_2,'0123456789')[1..10]); 
			 self.PHN_MARI_FAX_2	:= IF(pInput.PHN_MARI_FAX_2 = '0000000000','',stringlib.stringfilter(pInput.PHN_MARI_FAX_2,'0123456789')[1..10]); 
			 
			
			 getNAME_DBA := MAP(REGEXFIND(DBA_Ind, prepNAME_ORG) and pInput.std_source_upd <> 'S0033' 
																and not REGEXFIND('^(DBA |AKA )',prepNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_ORG),
			                          REGEXFIND('^(D B A )',tmpAddr1_Bus) => REGEXFIND('^(D B A ([A-Za-z ][^0-9]+))([0-9A-Za-z ]+)',tmpAddr1_Bus,2),
													 REGEXFIND(DBA_Ind, pInput.NAME_OFFICE) and pInput.std_source_upd <> 'S0033' 
																and not REGEXFIND('^(DBA |AKA )',pInput.NAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(pInput.NAME_OFFICE),		 
													 REGEXFIND(DBA_Ind,tmpAddr1_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpAddr1_Bus),
													 REGEXFIND(DBA_Ind,TrimAddr2_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr2_Bus),'');
			 self.NAME_DBA := MAP(REGEXFIND('(^[0-9]+)',getNAME_DBA)=> '',
														TrimNAME_DBA <> ''   => TrimNAME_DBA,
														length(getNAME_DBA) < 2 => '',getNAME_DBA);
														 
			 
			tempNAME_OFFICE := MAP(tmpAddr1_Bus[1] = '%' => tmpAddr1_Bus[2..],
														  TrimAddr2_Bus[1] = '%' => TrimAddr2_Bus[2..],
														  TrimAddr1_Mail[1] = '%' => TrimAddr1_Mail[2..],
														  TrimAddr2_Mail[1] = '%' => TrimAddr2_Mail[2..],
															TrimAddr2_Bus[1..4] = 'C/P ' => TrimAddr2_Bus[5..],
															REGEXFIND(DBA_Ind,tmpAddr1_Bus)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(tmpAddr1_Bus),
															REGEXFIND('(C/O)',tmpAddr1_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpAddr1_Bus),
															tmpAddr1_Bus[1..7] = 'CARE OF ' => trim(tmpAddr1_Bus[8..],left,right),
															// REGEXFIND('^(CARE OF ([A-Za-z ][^0-9]+))',tmpAddr1_Bus,2),
															REGEXFIND('(C/O)',BlankOutAddr2_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr2_Bus),
														  REGEXFIND('(C/O)',BlankOutAddr1_Mail) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr1_Mail),
														  REGEXFIND('(C/O)',BlankOutAddr2_Mail) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr2_Mail),
															REGEXFIND('^(AND |COMPANY|OR |INC )',BlankOutAddr2_Bus) and TrimTypeCd = 'MD' => REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z \\-]+)*$',prepAddr1_Bus,1),
															REGEXFIND('^(AND |COMPANY|OR |INC )',BlankOutAddr2_Mail) and TrimTypeCd = 'MD' => REGEXFIND('^([A-Za-z ][^0-9]+)([0-9A-Za-z \\-]+)*$',prepAddr1_Mail,1),
															REGEXFIND('^([^0-9])*$',prepAddr2_Bus) and TrimTypeCd = 'MD'
															  and BlankBogusOffice = '' and pInput.ADDR_CNTRY_1 = ''
																and not REGEXFIND(AddrExceptions,prepAddr2_Bus)
															  and not REGEXFIND('^(&|AND |OF |OR )',prepAddr2_Bus)
															  and Prof_License_Mari.func_is_company(prepAddr2_Bus) 
														   	and NOT REGEXFIND('^(BLDG |DEPT |#|APT |UNIT |LOT|RM |ROUTE |STE )',prepAddr2_Bus) => prepAddr2_Bus,
																
															  '');
																
			tempAddr1 := IF(REGEXFIND('^(.*)( DR | PLAZA | LANE | AVE | RD | COURT | ST | PLACE | SOUTH )(.*)$',trim(prepAddr1_Bus)) 
																			and REGEXFIND('^([0-9])',prepAddr1_Bus) 
																			and REGEXFIND('( INC$| INC | CORP | LLC$|LTD |L L C )',prepAddr1_Bus), REGEXFIND('^(.*)( AVE | DR | LANE | PLAZA | PLACE | RD | COURT | ST | SOUTH )(.*)$',trim(prepAddr1_Bus),3),
												IF(REGEXFIND('^(.*)( CORP | INC | LLC | LTD )(.*)$',trim(prepAddr1_Bus)) 
																			and REGEXFIND('([0-9])',prepAddr1_Bus) 
																			and REGEXFIND('( AVE$| BLDG$| BLVD$| CT$| DORA$| DR$| EAST | HIGHWAY| HWY | LANE | PKWY$| RD$| RT | ST$| ST$| TR$| S | SO | E | NW$| S$|TH$| PAXTON$| MAUCHLY$)',prepAddr1_Bus), REGEXFIND('^(.*)( CORP | INC | LLC | LTD )(.*)$',trim(prepAddr1_Bus),3),
																	
																			''));
			self.tmpNAME_OFFICE	:= 	prepAddr1_Bus[..(length(prepAddr1_Bus) - length(tempAddr1))];			
			
			
			self.NAME_OFFICE := MAP(BlankBogusOffice = '' and prepNAME_OFFICE != '' => prepNAME_OFFICE,
															BlankBogusOffice = '' and tempNAME_OFFICE != '' => StringLib.StringCleanSpaces(tempNAME_OFFICE),
															BlankBogusOffice = 'C/O ' => BlankBogusOffice[5..],
														  									BlankBogusOffice);	
			self.OFFICE_PARSE := IF(pInput.OFFICE_PARSE = '' and prepNAME_OFFICE != '', 'GR',
															If(pInput.OFFICE_PARSE = '' and tempNAME_OFFICE != '', 'GR',pInput.OFFICE_PARSE));
															
			TrimMARI_ORG := ut.fnTrim2Upper(pInput.NAME_MARI_ORG);
			TrimMARI_DBA := ut.fnTrim2Upper(pInput.NAME_MARI_DBA);
			self.NAME_MARI_ORG	    := IF(self.NAME_OFFICE != '' and TrimTypeCd = 'MD' and TrimMARI_ORG = '', self.NAME_OFFICE, TrimMARI_ORG);
			self.NAME_MARI_DBA	    := MAP(StringLib.StringFind(TrimMARI_DBA,'--',1) > 0 => '',
																		length(TrimMARI_DBA) < 2 => '',
																		NOT REGEXFIND('[A-Za-z]', TrimMARI_DBA) => '',
																		length(trim(TrimMARI_DBA)) < 5 => TrimDBA_ORIG,
																		self.NAME_DBA != '' and TrimTypeCd = 'MD' and TrimNAME_DBA = '' => self.NAME_DBA,
																		TrimMARI_DBA);
																		
				
			getNAME_CONTACT := MAP(REGEXFIND('(ATN:|ATTN|ATTENTION|ATT:)',tmpAddr1_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpAddr1_Bus),
														   REGEXFIND('(ATN:|ATTN|ATTENTION|ATT:)',BlankOutAddr2_Bus) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr2_Bus),
														   REGEXFIND('(ATN:|ATTN|ATTENTION|ATT:)',BlankOutAddr1_Mail) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr1_Mail),
														   REGEXFIND('(ATN:|ATTN|ATTENTION|ATT:)',BlankOutAddr2_Mail) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(BlankOutAddr2_Mail),
																	'');
		  tmpContactName := IF(getNAME_CONTACT <> '' and not REGEXFIND('(GENERAL|LICENSING|COMPLIANCE)',getNAME_CONTACT),getNAME_CONTACT,'');
			stripContactName	:= IF(REGEXFIND('^([A-Za-z ][^0-9]+)',tmpContactName),
																REGEXFIND('^([A-Za-z ][^0-9]+)',tmpContactName,1),tmpContactName);
		  ParseContact			:= IF(stripContactName != '' and StringLib.StringFind(stripContactName,'VP',1) > 0,
																			Address.CleanPersonFML73(stripContactName),
															IF(stripContactName != '' and NOT Prof_License_Mari.func_is_company(stripContactName),
																Address.CleanPersonFML73(stripContactName),''));
				
		  self.NAME_CONTACT_FIRST	:= IF(pInput.NAME_CONTACT_FIRST <> '',ut.fnTrim2Upper(pInput.NAME_CONTACT_FIRST),
																						TRIM(ParseContact[6..25],left,right));
		  self.NAME_CONTACT_MID	:= IF(pInput.NAME_CONTACT_MID <> '',ut.fnTrim2Upper(pInput.NAME_CONTACT_MID),
																						 TRIM(ParseContact[26..45],left,right));
		  self.NAME_CONTACT_LAST	:= IF(pInput.NAME_CONTACT_LAST <> '',ut.fnTrim2Upper(pInput.NAME_CONTACT_LAST),
																							TRIM(ParseContact[46..65],left,right));
		  self.NAME_CONTACT_SUFX	:= IF(pInput.NAME_CONTACT_SUFX <> '',ut.fnTrim2Upper(pInput.NAME_CONTACT_SUFX),
																							TRIM(ParseContact[66..70],left,right));
			self.NAME_CONTACT_NICK	:= ut.fnTrim2Upper(pInput.NAME_CONTACT_NICK);
			self.NAME_CONTACT_TTL	:= ut.fnTrim2Upper(pInput.NAME_CONTACT_TTL);
			self.PROVNOTE_1 := MAP(pInput.std_source_upd = 'S0404' and REGEXFIND(Agent_Ind,getNAME_ORG) AND NOT REGEXFIND('(^AGENTS|^AGENT|THE AGENT|ELITE AGENTS|WONDERAGENTS|AGT INC$|AGENT INC)',getNAME_ORG)
															=>  REGEXFIND('^([A-Za-z0-9 \\&\\,\\.\\-\\/]+)((AS AGENT FOR|AGENT FOR|AGENT OR|AGENT 4|AGENT FO|AGENT F|AGENT OF|AGENTFOR|AGENTF OR|AGENT-|AGENTS |AGENT/|AGENT |AS RECEIVER FOR|RECEIVER FOR|AGT FOR|AGT | AG |AGE FOR |AGENG FOR|AGENR FOR| AGEN$)[A-Za-z0-9 \\&\\.\\,\\-\\(\\)]+)',getNAME_ORG,2),
															pInput.std_source_upd = 'S0404' and REGEXfIND(Agent_Ind,tmpNAME_ORG) 
																	and not REGEXFIND('(AGENTFOR$|AGENTS$|AGENT$|^AGENTS|^AGENT|THE AGENT|ELITE AGENTS|WONDERAGENTS|AGT INC$)',tmpNAME_ORG)
																	=> REGEXFIND('([A-Za-z0-9 \\&\\,\\.\\-\\/\\*\\+\'\\#]+)((AS AGENT FO$|AS AGENT FOR$|AGENT FOR$|AGENT OR|AGENT 4|AGENT FO|AGENT OF|AGENTFOR|AGENTF OR|AGENT-|AGENTS |AGENT/|AGENT |AS RECEIVER|AS RECEIVER FOR|AGT FOR|AGT |AGE FOR|AGENR FOR|AGENG FOR| AGEN$|AG$|AS$)[A-Za-z0-9 \\&\\.\\,\\-\\(\\)]+)',tmpNAME_ORG,2),
																			ut.fnTrim2Upper(pInput.PROVNOTE_1));
																													
			self.PROVNOTE_2 := ut.fnTrim2Upper(pInput.PROVNOTE_2);
			self.PROVNOTE_3 := ut.fnTrim2Upper(pInput.PROVNOTE_3);
			self.MLTRECKEY := pInput.MLTRECKEY;
			self.AFFIL_KEY		:= pInput.AFFIL_Key;
			self := pInput;
			self := [];
			
	   
END;

dist_PrepFile     := sort(distribute(PROJECT(GoodRecs, xformCmrFlat(left)),hash(STD_SOURCE_UPD)),STD_SOURCE_UPD,local);


Prof_License_Mari.layouts.base xformToMariKey(dist_PrepFile pInput) := TRANSFORM
	self.PRIMARY_KEY			:= 0;
  self.ADDR_BUS_IND			:= IF(StringLib.StringCleanSpaces(pInput.ADDR_ADDR1_1 + pInput.ADDR_CITY_1 + pInput.ADDR_STATE_1 + pInput.ADDR_ZIP5_1) <> '','B','');
  self.ADDR_MAIL_IND			:= IF(StringLib.StringCleanSpaces(pInput.ADDR_ADDR1_2 + pInput.ADDR_CITY_2 + pInput.ADDR_STATE_2 + pInput.ADDR_ZIP5_2) <> '','M','');
	self.MLTRECKEY				:= IF(pInput.MLTRECKEY != 0,hash32(trim(pInput.license_nbr,left,right) 
																													+trim(pInput.std_license_type,left,right)
																													+trim(pInput.std_source_upd,left,right)
																													+trim(pInput.NAME_ORG,left,right)
																													+trim(pInput.NAME_DBA_ORIG,left,right)),0);
																													
	tmp_std_org := StringLib.StringCleanSpaces(pInput.NAME_ORG_PREFX + ' '+ pInput.NAME_ORG +' '+ pInput.NAME_ORG_SUFX);
	self.CMC_SLPK					:=  IF(pInput.NAME_DBA_ORIG <> '',
																hash32(ut.fnTrim2Upper(pInput.license_nbr) + ','
																			+ut.fnTrim2Upper(pInput.off_license_nbr) + ','
																			+ut.fnTrim2Upper(pInput.std_license_type) + ','
																			+ut.fnTrim2Upper(pInput.std_source_upd) + ','
																			+ut.fnTrim2Upper(pInput.NAME_ORG) + ','
																			+ut.fnTrim2Upper(pInput.NAME_DBA_ORIG) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ADDR1_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ADDR2_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_CITY_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ZIP5_1)),															
	
																HASH32(ut.fnTrim2Upper(pInput.license_nbr) + ','
																			+ut.fnTrim2Upper(pInput.off_license_nbr) + ','
																			+ut.fnTrim2Upper(pInput.std_license_type) + ','
																			+ut.fnTrim2Upper(pInput.std_source_upd) + ','
																			+tmp_std_org + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ADDR1_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ADDR2_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_CITY_1) + ','
																			+ut.fnTrim2Upper(pInput.ADDR_ZIP5_1)));
	self.PCMC_SLPK 				:= 0;					
	self.AFFIL_KEY					:= pInput.AFFIL_KEY;
	self.PREV_PRIMARY_KEY := pInput.PRIMARY_KEY;
	self.PREV_MLTRECKEY	  := pInput.MLTRECKEY;
	self.PREV_CMC_SLPK		:= pInput.CMC_SLPK;
	self.PREV_PCMC_SLPK 	:= pInput.PCMC_SLPK;
	self  := pInput;
	// self := [];
		
END;		
rsMARIRec_dist     := distribute(PROJECT(dist_PrepFile, xformToMariKey(left)),hash(std_source_upd,PREV_CMC_SLPK));

// Create self-join to relate Main records to Branch records
rsMARILink  := distribute(rsMARIRec_dist,hash(std_source_upd,PREV_PCMC_SLPK));
Prof_License_Mari.layouts.base	doKeyJoin(rsMARILink L, rsMARIRec_dist R) := TRANSFORM
			self.PCMC_SLPK		:= R.CMC_SLPK;
			self := L;
END;
	  

ds_RelatePCMC	:= JOIN(rsMARILink,rsMARIRec_dist,
										 LEFT.PREV_PCMC_SLPK = RIGHT.PREV_CMC_SLPK 
										  and LEFT.PREV_PCMC_SLPK <> 0,
											doKeyJoin(LEFT,RIGHT), LEFT OUTER, LOCAL,LOOKUP);


d_final := output(ds_RelatePCMC	, ,'~thor_data400::in::proflic_mari::'+pVersion+'::full_dump',__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::cmrflat','~thor_data400::in::proflic_mari::'+pVersion+'::full_dump'),
													fileservices.finishsuperfiletransaction()
													);

return sequential(d_final, add_super);

end;



