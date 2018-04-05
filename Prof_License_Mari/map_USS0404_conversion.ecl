/* Converting Veterans Administration / Mortgage Lenders // Professions Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT ut, Address, Prof_License_Mari, lib_stringlib, Lib_FileServices,STD;

EXPORT map_USS0404_conversion(STRING pVersion) := FUNCTION

code								:= 'USS0404';
src_st							:= code[1..2];	//License state
src_cd							:= code[3..7];

//Dataset reference files for lookup joins
SrcCmvTrans				:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
oCMV							:= OUTPUT(SrcCmvTrans);
	
inFile 						:= Prof_License_Mari.file_USS0404;
oMtg							:= OUTPUT(inFile);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD = src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = src_cd);
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

//Pattern to various company overflow into Address fields
secondary_address_ind := '(^BLD.*$|^BOX|^BUILDING|^DEPARTMENT|^DEPT|^MAIL|^MAC |^MC |^NC1|^PMB|^RD|^ROOM|^ROUTE|^STE |^SUITE|^UNIT |^#| FLOOR$| LEVEL$|LOCATION|'+
													 '^PH |^RM |^POST |^POB |^PO BOX |^P O |^P. O. |^PO |^SUTIE |^STE\\. |^MS |^PMB |^TERMINAL ANNEX|^HLMC - PENINSULA$)';
Inactive_Status 		:= '(^BAD | BAD |CANCEL|CEASE|CLOSE|CLOSING|DECEASED|DELETE|DO NOT|DUPLICATE |INACTIVE|INCORRECT|' +
												 'N/A|NONE |NO VALID|NOT CURRENTLY|SAME |UNKNOWN|TBD|XXX|^SEE |^USE |^REF |^REFER|UNABLE|' +
												 'RETURNED MAIL|TERMINAT|NO LONGER|VOID|MERGE|INVALID|^ONLY|^ACQUIRED)';
                                 

agent_addr_ind := '( AGENT$|^AGENT[S]? |^AGENT-|^AGENTF|^AGT|^AKA|^A/K/A|^ALSO |^AS AGENT|^AS RECEIVER|^D/B/A|^DBA| DBA |^FOR |^MTG |^OF |^&|^T/A|^PEOPLES|'+
										'CREDIT UNION$|^PROVIDENT| AGENT-MELLON|^AGENG |^AGENR'+
										')';

AGENT_Ind := '(AGENT FOR$|AGENT FO$| AGENT F$| AGENT$|AGEN$| AGE$|AGT$| AG$| A/K/A$| DBA$| D/B/A$| FOR FT$| OF$| T/A$| FOR$| THE$|AGENT 4$| AGENTS$|AGENT/AGENTFOR|AGENTF OR|^DIVISION$| &$|\\-$)';

branch_ind  := '(^STATE|^SUBSIDIARY|^FORMERLY|^A DIV|^DIV|DIV$)';

website_pattern := '(HTTP://|)(WWW\\.)?([^\\.]+)\\.(\\w{2}|(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO))$';

// Concatenate Lender Nmae and Address because of overflow into Address field
Expand_Layout := RECORD
	STRING6   	LENDER_ID;
	STRING4  	 	BRANCH_UNIQUE_ID;
	STRING20   	VA_LENDER_ID;
	STRING100   ADDRESS1;
	STRING100   ADDRESS2;
	STRING50		CITY;
	STRING5		 	ZIP5;
	STRING4		 	ZIP4;
	STRING2			STATE;
  STRING200  	LENDER_NAME;
	STRING10   	STATE_UNIQUE_ID;
	STRING10   	BRANCH_STATE_CODE;
	STRING8		 	LN_FILEDATE;
	STRING200		CONVERT_LENDER_NAME;
	STRING200		CONVERT_OFFICE_NAME;
	STRING100		CORRECTED_ADDRESS1;
	STRING100		CORRECTED_ADDRESS2;
	STRING50		CORRECTED_ADDR_SUITE;
	STRING50		CORRECTED_ADDR_CITY;
	STRING100 	LENDER_STATUS;
	STRING20 		LENDER_STATUS_ADDL;
END;

Expand_Layout				xformLenderFile(inFile pInput) := TRANSFORM

TrimLender				:= STD.Str.FilterOut(ut.CleanSpacesAndUpper(pInput.LENDER_NAME),'"');
TrimAddress1			:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
TrimAddress2			:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);

// Flip Address																			
flip_address1 := IF(REGEXFIND(secondary_address_ind, TrimAddress1) AND REGEXFIND('^[0-9]', TrimAddress2) AND TrimAddress2 != '', TrimAddress2, TrimAddress1);
flip_address2	:= IF(REGEXFIND(secondary_address_ind, TrimAddress1) AND REGEXFIND('^[0-9]', TrimAddress2) AND TrimAddress2 != '', TrimAddress1, TrimAddress2);

concat_addr1		:= IF(REGEXFIND('(^USE |^SEE |^DELETE|TERMINATED )', TRIM(flip_address2)), flip_address1 + ' ' + flip_address2, 
													IF(REGEXFIND('(^AS RECEIVER| WITH$|^INCORRECT )', TRIM(flip_address1)), flip_address1 + ' ' + flip_address2, flip_address1));
blank_addr2			:= IF(REGEXFIND('(^USE |^SEE |^DELETE|TERMINATED)', TRIM(flip_address2)), '', 
													IF(REGEXFIND('(^AS RECEIVER| WITH$|^INCORRECT|INACTIVATED)', TRIM(flip_address1)), '',flip_address2));

filter_addr1 		:= IF(REGEXFIND(Inactive_Status, TRIM(concat_addr1)) AND NOT REGEXFIND('( CLOSE$| CLOSE )', TRIM(concat_addr1)),'',concat_addr1);


// Concatenate Lender Names
concat_lender_1	:= IF(REGEXFIND(agent_addr_ind, TRIM(filter_addr1)) AND NOT REGEXFIND('(^AGENT$)',TRIM(filter_addr1)), STD.Str.CleanSpaces(TrimLender + ' '+ filter_addr1), TrimLender);
concat_lender_2	:= IF(REGEXFIND(branch_ind,TRIM(filter_addr1)) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX|^SUITE)',filter_addr1), STD.Str.CleanSpaces(concat_lender_1 + ',' + filter_addr1), concat_lender_1); 
concat_lender_3	:= IF(REGEXFIND(agent_Ind, TRIM(concat_lender_2)) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX|^ONE |^SEE |^TWO |^SUITE |^AGENT$)',filter_addr1), STD.Str.CleanSpaces(concat_lender_2 + ' '+ filter_addr1), concat_lender_2);
concat_lender_4 := IF(STD.Str.Find(TRIM(concat_addr1,LEFT,RIGHT),' ',1) < 1 AND NOT REGEXFIND('[0-9]{2,}',filter_addr1) AND NOT REGEXFIND('(^AGENT$|\\-$|.COM$)', TRIM(filter_addr1)), 
													STD.Str.CleanSpaces(concat_lender_3 + ' '+ filter_addr1), concat_lender_3);
concat_lender_5	:= IF(REGEXFIND('( DBA$| FOR$| NORTH$|[.]DBA$)', TRIM(concat_lender_4)) AND REGEXFIND('(^1ST |^AMERICAN | FUNDING$|^PROGRESSIVE| HOME )', filter_addr1), STD.Str.CleanSpaces(concat_lender_4 + ' '+ filter_addr1), concat_lender_4);
concat_lender_6	:= IF(REGEXFIND(agent_addr_ind, TRIM(blank_addr2)), STD.Str.CleanSpaces(concat_lender_5 + ' '+ blank_addr2), concat_lender_5);


// Strip Address Suite from Lender Name
suite_ind := '^([A-Z \\.\\,\\-\\/\\&]+)(( STE | SUITE )([0-9A-Z \\-])+)$';
strip_lender_ste := IF(REGEXFIND(suite_ind, TRIM(concat_lender_6)), REGEXFIND(suite_ind, TRIM(concat_lender_6),1),
													IF(REGEXFIND('( STE$| SUITE$)', TRIM(concat_lender_6)), REGEXFIND('^([A-Z \\.\\,\\-\\/\\&]+)( STE$| SUITE$)$', TRIM(concat_lender_6),1),
													 		concat_lender_6));
SELF.convert_lender_name 	:= strip_lender_ste;

SELF.convert_office_name  := IF(REGEXFIND(agent_addr_ind, TRIM(filter_addr1)),filter_addr1,
																	IF(REGEXFIND(branch_ind,TRIM(filter_addr1)) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX|^SUITE)',filter_addr1), filter_addr1,
																	   IF(REGEXFIND(agent_Ind, TRIM(concat_lender_2)) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX|^ONE |^SEE |^TWO |^SUITE |^AGENT$)',filter_addr1), filter_addr1,
																		    '')));

SELF.corrected_address1			:= MAP(REGEXFIND(agent_addr_ind,filter_addr1) => '',
																	 REGEXFIND(AGENT_Ind,TrimLender) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX|^SUITE|^ONE |^SEE |^TWO |^SUITE |^AGENT$)',filter_addr1)=> '',
																	 REGEXFIND(branch_ind,TRIM(concat_addr1)) AND NOT REGEXFIND('(^[0-9]|^P.O.|^PO BOX|^P O BOX)',filter_addr1) => '',
																	 REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(concat_addr1)) AND NOT REGEXFIND('(SEE)', TRIM(concat_addr1)) => REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(concat_addr1),2),
																	 REGEXFIND('( DBA$| FOR$| NORTH$|[.]DBA$)', TRIM(concat_lender_4)) AND REGEXFIND('(^1ST |^AMERICAN | FUNDING$|^PROGRESSIVE| HOME )', filter_addr1) => '',
																	 STD.Str.Find(TRIM(concat_addr1,LEFT,RIGHT),' ',1) < 1 AND NOT REGEXFIND('[0-9]{2,}',filter_addr1) AND NOT REGEXFIND('(^AGENT$|\\-$|.COM$)', TRIM(filter_addr1)) => '',
																	 filter_addr1);
																	 
																	 
SELF.corrected_address2			:= MAP(REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(blank_addr2)) AND NOT REGEXFIND('(SEE)', TRIM(blank_addr2)) => REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(blank_addr2),2),
																	 REGEXFIND(Inactive_Status, blank_addr2) => '',
																	 REGEXFIND(agent_addr_ind, blank_addr2) => '',
																	 STD.Str.Find(pInput.CITY,'PO BOX',1) > 0 => pInput.CITY,
																			blank_addr2);
																			
SELF.corrected_addr_suite		:= IF(REGEXFIND('^([A-Z \\.\\,\\-\\/\\&]+)(( STE |SUITE )([0-9A-Z \\-])+)$', TRIM(concat_lender_6)), REGEXFIND('^([A-Z \\.\\,\\-\\/\\&]+)(( STE |SUITE )([0-9A-Z \\-])+)$', TRIM(concat_lender_6),2),
																	IF(REGEXFIND('( STE$| SUITE$)', TRIM(concat_lender_6)), REGEXFIND('^([A-Z \\.\\,\\-\\/\\&]+)( STE$| SUITE$)$', TRIM(concat_lender_6),2),
																		''));

RemovePattern	  := '(^P O B 19007)';
parsed_city_1								:= IF(STD.Str.Find(pInput.CITY,',',1) > 0,TRIM(pInput.CITY[..STD.Str.Find(pInput.CITY,',',1)-1], LEFT,RIGHT),pInput.CITY);
parsed_city_2								:= IF(STD.Str.Find(parsed_city_1,'(',1) > 0,TRIM(parsed_city_1[..STD.Str.Find(parsed_city_1,'(',1)-1], LEFT,RIGHT),parsed_city_1);
parsed_city_3	  						:= IF(STD.Str.Find(pInput.CITY,'(',1) > 0,TRIM(pInput.CITY[LENGTH(parsed_city_2) + 1..],LEFT,RIGHT),'');
clnCity									    := Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(parsed_city_2, RemovePattern);

SELF.corrected_addr_city		:= IF(STD.Str.Find(parsed_city_2,'PO BOX',1) > 0,'',clnCity);
addr_close_exception := '( CLOSE$| CLOSE ST$)';
                
SELF.lender_status					:= IF(REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(concat_addr1)) AND NOT REGEXFIND('(SEE)', TRIM(concat_addr1)), REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(concat_addr1),1),
																	IF(REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(blank_addr2)) AND NOT REGEXFIND('(SEE)', TRIM(blank_addr2)), REGEXFIND('(^BAD ADDRESS ([0-9A-Z ]+))', TRIM(blank_addr2),1),
																		IF(REGEXFIND(inactive_status,concat_addr1) AND NOT REGEXFIND(addr_close_exception, concat_addr1), concat_addr1,
																			IF(REGEXFIND(inactive_status,blank_addr2), blank_addr2,
																			 ''))));

SELF.lender_status_addl			:= parsed_city_3;
SELF.lender_name 						:= TrimLender;
SELF.address1								:= TrimAddress1;
SELF.address2								:= TrimAddress2;
SELF := pInput;
END;

dsExpandFile	 := PROJECT(inFile, xformLenderFile(LEFT));
oExpand	       := OUTPUT(dsExpandFile(VA_LENDER_ID != '5300090000'));

//Filtering out BAD RECORDS
FilterRec 	:= dsExpandFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LENDER_NAME)));
ut.CleanFields(FilterRec,CleanRec);

maribase_plus_dbas := RECORD,MAXLENGTH(5500)
Prof_License_Mari.layouts.base;
STRING60 dba1;
STRING60 dba2;
STRING60 dba3;
STRING60 dba4;
STRING60 dba5;
END;

//Real Estate License to common MARIBASE layout
maribase_plus_dbas 		xformToCommon(CleanRec pInput) 
	:= 
	 TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
		SELF.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		
		//Standardize Fields
		NAME_ORG_temp		:= ut.CleanSpacesAndUpper(pInput.LENDER_NAME);
		TrimNAME_ORG    := STD.Str.FilterOut(NAME_ORG_temp, '"');
		ConvertedName_Org := STD.Str.FilterOut(ut.CleanSpacesAndUpper(pInput.Convert_Lender_Name),'"');
		TrimCity				:= ut.CleanSpacesAndUpper(pInput.CITY);
		TrimState				:= ut.CleanSpacesAndUpper(pInput.STATE);
			
		// License Information
		SELF.LICENSE_NBR	  		:= 'NR';
		SELF.OFF_LICENSE_NBR		:= '';
		SELF.LICENSE_STATE	 		:= src_st;
		SELF.RAW_LICENSE_TYPE		:= '';
		SELF.STD_LICENSE_TYPE  	:= '';
		SELF.STD_LICENSE_DESC		:= '';
	  SELF.RAW_LICENSE_STATUS := '';
		SELF.STD_LICENSE_STATUS := MAP(REGEXFIND('(BAD |DUPLICATE|INCORRECT |REFER |SEE |USE|XXX|INVALID)', TRIM(pInput.address1)) => 'A',
		                               REGEXFIND('(BAD |DUPLICATE|INCORRECT |REFER |SEE |USE|XXX|INVALID)', TRIM(pInput.address2)) => 'A',
																	 REGEXFIND(Inactive_Status,pInput.address1) => 'I',
		                               REGEXFIND(Inactive_Status,pInput.address2) => 'I','A');
		SELF.STD_STATUS_DESC		:= IF(SELF.STD_LICENSE_STATUS = 'A','ACTIVE',
																		IF(SELF.STD_LICENSE_STATUS = 'I','INACTIVE',''));
		SELF.TYPE_CD						:= 'GR';
		SELF.CURR_ISSUE_DTE			:= '17530101';
		SELF.ORIG_ISSUE_DTE			:= '17530101';
		SELF.RENEWAL_DTE				:= '17530101';
		
	//Extract Closing Dates	
		status_dte_1 := '(BRANCH CLOSE[ED]|BRANCH|CANCEL[ED]|NO LONGER IN BUSINESS|INACTIVE CLOSE[ED]|CLOSE[ED]|INACTIVE)[ ]([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})';
		status_dte_2 := '(CANCELED)[ ]([0-9]{1,2}-[0-9]{1,2}-[0-9]{2,4})';
		status_dte_alpha := '(TERMINATED BUSINESS WITH VA ON)[ ]([A-Z]{1,3}\\.\\s[0-9]{1,3}\\,\\s[0-9]{2,4})';
		get_status_date := MAP(REGEXFIND(status_dte_1,TRIM(pInput.LENDER_STATUS)) => REGEXFIND(status_dte_1,TRIM(pInput.LENDER_STATUS),2),
													 REGEXFIND(status_dte_alpha,TRIM(pInput.LENDER_STATUS)) => REGEXFIND(status_dte_alpha,TRIM(pInput.LENDER_STATUS),2),
															'');
	//Fix date format M-DD-YY
		get_status_dte_dash := IF(REGEXFIND(status_dte_2,TRIM(pInput.LENDER_STATUS)),REGEXFIND(status_dte_2,TRIM(pInput.LENDER_STATUS),2),'');
		fix_status_dte := Prof_License_Mari.DateCleaner.fix_date(get_status_dte_dash,'-');
	  repl_status_dte := STD.Str.FindReplace(fix_status_dte, '-','/');
									
    filter_status_dte := IF(get_status_date != '',StringLib.StringFilterOut(get_status_date,'.'),repl_status_dte);
		prep_status_dte := Prof_License_Mari.DateCleaner.ToYYYYMMDD(filter_status_dte);													
		SELF.EXPIRE_DTE				:= prep_status_dte;
		SELF.ACTIVE_FLAG			:= '';

//Use address cleaner to clean address
		CoPattern	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.* CORP\\.$|^.*APPRAISAL[S]?$|^.* MORTGAGE$|^FIRST BANK .*$|^BANK OF .*$|' +
									'^.* APP[.]?$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^.*HOMESERVICES|^FLAGSTAR BANK|^DMR MORTGAGE SERV ICES|' +
									'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O .*$|^ATTN.*$| ATTN.*$| \\-ATTN.*$| ATTN:.*$|^VALLEY BANK .*$|^.* MORTGAGE AND .*$|' +
									'^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* LIBERTY BUILDING$|^CHANCELLOR HOMESERVICES LENDIN$|' +
									'^.* MTG LEND[I]?$|^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|^ATT:.*$|^ATT .*$|^A\\.K\\.A\\.:.*$|^.* OFFICE$|BOATMENS NATL BANK OF AUSTIN|' +
									'^CENTER STAT MORTGAGE |^.* SAVING BANK|^.*TEMPLE-INLAND MORTGAGE|^.* FUNDING$|^.*MORTGAGE AND LOAN|^.*MORTGAGE SERV|^.* MTG$|^BURNET HOME LOANS|'+
									'^.*MORTGAGE CONNECTION|^.* FCU$|^ONE MONTGOMERY BANK$|^.*PREFERRED CASH FLOW SOLUTIONS$|^UNITED BANK .*$|^.* NATL BANK|^.* FIRM$|^BANCORP HOME LOANS.*$|'+
									'^.*MORTGAGE LOANS$|^NATIONAL LENDING NETWORK.*$|^INTERSTATE PACIFIC MORTGAGE CO.*$|^NATIONAL AFFORDABLE LENDING.*$|^.*MORTGAGE BANKING GROUP$|'+
									'^WASHINGTON MUTUAL$|^HOMEFINDERSCENTER.COM$|^CAROL HENKEL$|^SUSAN AUSTIN$|PATRICIA NU$|SANDY DAVIS$|^1ST BANK DIVISION$|RETAIL CLIENT SERVICES GRP #16$|' +
									'^FLEET MORTGAGE GROUP|^LEGACY FUNDING GROUP|PRINCIPAL LENDING GROUP|^RETAIL CLIENT SERVICES GRP.*$|^NATIONWIDE 1ST MORTGAGE.*$|^LA CROSSE - MADISON$|'+
									'^.* MORTGAGE VENTURE.*$|^.* FCU$|^FLAGSTAR BANK.*$'+
                 ')';
							  	
	RemovePattern	  := '(^.* LLC[.]?$|^.* INC[.]?$|^.* COMPANY$|^.* CORP[.]?$|^.*APPRAISAL[S]?$|^.* MORTGAGE$|^HOMEFINDERSCENTER.COM$|^AGENT$|^BANK OF .*$|^CENTRAL REGION.*$|' +
											'^.* APPR\\.$|^.*APPRAISAL.*$|^APPRAISAL .*$|^.* FINANCIAL$|^.* SECTION$|^RLS ADMINISTRATION MP\\-5$|^FIRST BANK.*$|BOATMENS NATL BANK OF AUSTIN|' +
											'^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/O.*$|^ATTN.*$|^.* ATTN$|^ATT:.*$|^ATT .*$| -ATTN.*$| ATTN .*$| ATTN:.*|' +
											'^.* REALTY$|^.* REAL ESTATE.*$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.*PROCESSING CENTER$|^.*PROCESSING CTR.*$|^.*PROCESSING|' +
											'^C-21 .*$|^.* REALTORS$|^.* PROPERTIES$|^.* MANAGE$|^.*SUPPORT$|^VALLEY BANK .*$|^PRINCIPAL LENDING GROUP$|^PROPERTY MANAGEMENT SECTION.*$|' +
											'^.* MANAGER$|^.* OPERATION[S]?$|^.* PROCESSING CENTER$|^MTGE LOAN PROCESSING.*$|^RETAIL CLIENT SERVICES GRP #16$|^REAL ESTATE SERVICE[S]? DIVISION[S]?$|' +
											'^.*HOME LOAN.*$|^.* MTG LEND[I]?$|^.*UNDERWRITING.*$|^.*MILITARY BANKING|^.* LOAN DEPARTMENT|^.* SERVICES|'+
											'^COMPLIANCE DE$|^GOVERNMENT PR|^.* FUNDING$|^REAL ESTATE DIVISION$|BELVOIR FCU$|^NATIONWIDE. *$|^.* BRANCH$|^.* LENDING$|'+
											'^.*HEADQUATERS$|^OPERATIONS MANAGER LSR$|^MORTGAGE UNIT$|^RE POST CLOSI$|^TEMPLE-INLAND MORTGAGE.*$|^CHANCELLOR HOMESERVICES LENDIN$|'+
											'^.*VA LOANS$|LA CROSSE - MADISON|^.* OFFICER$|^MORTGAGE DIV$|^DMR MORTGAGE SERV ICES|^.* MTG$|^BRANCH .*$|'+
											'^ONE MONTGOMERY BANK$|^.*PREFERRED CASH FLOW SOLUTIONS$|^UNITED BANK .*$|^.* NATL BANK|^.* FIRM$|'+
											'^SERVICING ONLY$|NATIONAL LENDING NETWORK.*$|^NATIONAL AFFORDABLE LENDING.*|^MRBP DIVISION-.*$|'+
											'^WASHINGTON MUTUAL$|RESIDENTIAL LENDING|^CAROL HENKEL$|^SUSAN AUSTIN$|^.* OFFICE$|^.* MORTGAGE VENTURE.*$|'+
 										  '^.*SPECIAL LOAN DEPT PL5$|^ASSUMPTIONS DEPT MWI0308.*$|^.* DEPT[\\.]?$|PATRICIA NU$| MORTGAGE PROCESSIN$|' +
											'^WHOLESALE DIVISION$.*$|^WHOLSALE DIVISION.*$|^MTGE DIVISION[S]?$|^.*MORTGAGE BANKING.*$|^.*PRODUCT DIVISION.*$|'+
											'^.*SERVICES DIVISION[S]?|^MORTGAGE BANKING.*$|^REAL ESTATE DIVISION[S]?$|^THE .*$|^RESIDENTIAL .*$|^RETAIL .*$|'+
											'^RESIDENTIAL MORTGAGE DIVISION$|^1ST BANK DIVISION|^MORTGAGE.*$|^.*WHOLSALE.*$|^.* RESIDENTIAL|'+
											'^.*BANKING DIVISION[S]?$|^.*PRODUCT DIVISION[S]?|^ISD/DOCUMENT.*$|^FLEET MORTGAGE GROUP$|^LEGACY FUNDING GROUP$|'+
											'^CENTER STAT MORTGAGE|^.* MORTGAGE LOAN[S]?$|^.* MORTGAGE AND .*$|^.* AND MORTGAGE .*$|^.* MORTGAGE CO$|'+
											'^. OFFICE BLDG$|^.* BANK BLDG$|^MALL DRIVE OFFICE PARK|^NATIONWIDE 1ST MORTGAGE.*$|^.* BRANCH$|^LA CROSSE - MADISON$|'+
											'^WHOLESALE DIVISION\\-$|^.* MORTGAGE VENTURE.*$|^.* FCU$|^FLAGSTAR BANK.*$|^MAIL STOP LIC$|'+
											'^.* MORTGAGE CENTER$|^.* LENDING CENTER$|^.* FINANCIAL CENTER$|^.* BANKING CENTER$|^PEERLESS CENTER$|^.* EXECUTIVE CENTER$|'+
											'^ALLIANCE CENTER$|^.* BANK BUILDING$|^.* FEDERAL BUILDING$'+
											')';

		TrimAddress1		:= ut.CleanSpacesAndUpper(pInput.corrected_address1);
		TrimAddress2		:= ut.CleanSpacesAndUpper(pInput.corrected_address2);
		
//Clean Addresses    
 	  clnAddress1						:= IF(REGEXFIND('^(C/O MARINEVEST)\\s([A-Z\\s]+)$', TrimAddress1),REGEXFIND('^(C/O MARINEVEST)\\s([A-Z\\s]+)$', TrimAddress1,2), 
																Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress1, RemovePattern));
																
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress1, CoPattern);
																			
																	
    clnAddress2						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimAddress2, RemovePattern);		
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(TrimAddress2, CoPattern);
	
	
		temp_preaddr1 				:= IF(REGEXFIND(website_pattern, clnAddress1), clnAddress1,
																	STD.Str.CleanSpaces(clnAddress1)); 
		temp_preaddr2 				:= IF(REGEXFIND(website_pattern, clnAddress2), clnAddress2,
																STD.Str.CleanSpaces(clnAddress2)); 
																
//Prepping ORG_DBA field for parsing
		prepNAME_ORG := MAP(STD.Str.Find(ConvertedName_Org,' T/A ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,' T/A ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,'.T/A ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,'.T/A ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,' T/A',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,' T/A',' D/B/A'),
												 STD.Str.Find(ConvertedName_Org,'.DBA',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,'.DBA',' D/B/A'),
												 STD.Str.Find(ConvertedName_Org,'/DBA/ ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,'/DBA/ ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,'/DBA ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,'/DBA ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,'/DB/A',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,'/DB/A',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,', DBA, ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,', DBA, ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,', DBA ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,', DBA ',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,' D.B.A: ',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,' D.B.A: ',' DBA '),
												 STD.Str.Find(ConvertedName_Org,' DB',1) > 0 AND NOT STD.Str.Find(ConvertedName_Org,' DBA',1) > 0
																			=> STD.Str.FindReplace(ConvertedName_Org,' DB',' D/B/A '),
												 STD.Str.Find(ConvertedName_Org,' A DIVISION OF',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,' A DIVISION OF',', A DIVISION OF '),
												 STD.Str.Find(ConvertedName_Org,' AS AGENT FOR',1) > 0 => STD.Str.FindReplace(ConvertedName_Org,' AS AGENT FOR',' AGENT FOR'),
												 REGEXFIND('( FOR$)',ConvertedName_Org) AND NOT REGEXFIND('( AGENT FOR| AGT FOR| AGENTFOR)',ConvertedName_Org)
																			=> REGEXREPLACE(' FOR',ConvertedName_Org,' AGENT FOR'),
												 STD.Str.Find(ConvertedName_Org,'(',1) > 0 AND NOT STD.Str.Find(ConvertedName_Org,')',1) > 0 
																				=> ConvertedName_Org +')',							
								 				 													ConvertedName_Org);

		DBA_Ind := '( D/B/A | DBA | AKA | DBA$| A/K/A$| D/B/A$| AKA$|A/K/A)';																							
		std_org_name					:= IF(REGEXFIND(DBA_Ind,TRIM(prepNAME_ORG)),REGEXREPLACE(DBA_Ind,prepNAME_ORG,' / '),prepNAME_ORG);
	
		AgentPattern	:= '( AS RECEIVER .*$| AS AGENT .*$| AGENT\\/.*$| AGENT[S]? .*$| AGENT-.*$| AGENR .*$|AGENTFOR .*$| AGT .*$| AGEN .*$|\\,A DIV.*$|, A BRANCH .*$| A,STATE OF .*$|'+
								 ',STATE OF .*$|A DIVISION .*$| DIV OF .*$| DIVISION OF .*$| AGENG .*$| AGENTF .*$| AGENTS .*$| FOR .*$|\\,SUBSIDIARY .*$|\\,FORMERLY .*$|MTG CREDIT POLICY.*$| AG .*$|'+
								 '\\, AGE .*$| AGE .*$|\\,DIV.*$|- GUARDIAN.*$| A DIV$'+
								 ')';
								                                          
		strip_agent 		:= IF(std_org_name[1..3] = 'DBA','',
														IF(std_org_name[1..12] = 'ELITE AGENTS','',
															Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(std_org_name, AgentPattern)));
		clean_name_org 	:= IF(std_org_name[1..9] = 'THE AGENT', std_org_name, 
													IF(std_org_name[1..3] = 'DBA', std_org_name,
													  IF(std_org_name[1..12] = 'ELITE AGENTS',std_org_name,
															Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(std_org_name, AgentPattern))));

    slashchar 						:= STD.Str.Find(clean_name_org,' /',1);
		getCorpOnly						:= IF(REGEXFIND(' /', clean_name_org),clean_name_org[..slashchar-1],clean_name_org);		 //get names without DBA names
		tmpNameOrg						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly); //business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);																							
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
		SELF.NAME_ORG					:= IF(REGEXFIND('.COM',getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')));  //Without punct. and Sufx removed
		SELF.NAME_ORG_SUFX 		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		SELF.STORE_NBR				:= '';
	
// Retrieve Contact Names
    attention := '(^ATT[N?|:?|.?|\\s?])';
		getNAME_OFFICE	:= IF(tmpNameContact1 != '', tmpNameContact1, 
													IF(REGEXFIND(website_pattern, TrimAddress1), TrimAddress1,
														   tmpNameContact2));
		prepOfficeName := MAP(getNAME_OFFICE[1..4] = 'C/O ' => getNAME_OFFICE[5..],
													REGEXFIND(attention,getNAME_OFFICE) AND prof_license_mari.func_is_company(getNAME_OFFICE) => 
														REGEXFIND('(^ATT[N?|:?|.?|\\s?])(.*)',getNAME_OFFICE,2),
													REGEXFIND(attention,getNAME_OFFICE) AND NOT prof_license_mari.func_is_company(getNAME_OFFICE) => '',
									              getNAME_OFFICE);
   
	  filter_offfice_in := '(^.* OFFICE[S]?$|^.* BRANCH$|^.* DIVISION[S]?$|^MORTGAGE SERVICE[S]?$|^.* DEPT.*$|LENDING$|'+
												 'ORIGINATION[S]?|MANAGEMENT|DEPARTMENT|UNDERWRITING|UNIT|PROCESSING|SECONDARY MARKET)';
		filterOffice      :=  IF(REGEXFIND(filter_offfice_in,prepOfficeName),'',prepOfficeName);
   SELF.NAME_OFFICE	    := filterOffice;
		SELF.OFFICE_PARSE			:= IF(SELF.NAME_OFFICE = '', '',
																IF(SELF.NAME_OFFICE != '' AND prof_license_mari.func_is_company(TRIM(SELF.NAME_OFFICE)),'GR','MD'));
																
//Clean Contact Name-Attention
		 tmpContactName := IF(REGEXFIND(attention, tmpNameContact1), REGEXFIND('(^ATT[N?|:?|.?|\\s?])(.*)',tmpNameContact1,2),
			                     IF(REGEXFIND(attention, tmpNameContact2), REGEXFIND('(^ATT[N?|:?|.?|\\s?])(.*)',tmpNameContact2,2),''));
		 tmpContactName_strip := IF(STD.Str.Find(tmpContactName, ' MAC ',1) > 0,TRIM(tmpContactName[1..STD.Str.Find(tmpContactName, ' MAC ', 1) -1], right),tmpContactName);	
		 
			clnContactName := IF(prof_license_mari.func_is_company(tmpContactName_strip),'',Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tmpContactName_strip));
			clnContactName_First		:= clnContactName[6..25];
			clnContactName_Mid			:= clnContactName[26..45];
			clnContactName_Last			:= clnContactName[46..65];
			clnContactName_Sufx			:= clnContactName[66..70];
			SELF.NAME_CONTACT_PREFX := '';
			SELF.NAME_CONTACT_FIRST	:= clnContactName_First;
			SELF.NAME_CONTACT_MID		:= clnContactName_Mid;
			SELF.NAME_CONTACT_LAST	:= clnContactName_Last;
			SELF.NAME_CONTACT_SUFX	:= clnContactName_Sufx;
			SELF.NAME_CONTACT_NICK	:= '';
			SELF.NAME_CONTACT_TTL		:= '';																
									
	//Populating MARI Name Fields
	  SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_DBA_ORIG	  := '';
		SELF.NAME_MARI_ORG	  := TRIM(tmpNameOrg);
		SELF.NAME_MARI_DBA		:= '';
		SELF.PHN_MARI_1				:= '';
		SELF.PHN_MARI_2				:= '';
		
		prep_address1 := IF(TrimNAME_ORG = TRIM(pInput.corrected_address1),'',temp_preaddr1);
		temp_address1 := IF(prep_address1 = '', temp_preaddr2, temp_preaddr1);
		temp_address2 := IF(prep_address1 != '', temp_preaddr2,
												IF(prep_address1 = '' AND pInput.corrected_address2 != '' AND pInput.corrected_addr_suite != '', pInput.corrected_addr_suite,
													IF(prep_address1 = '' AND pInput.corrected_address2 = '', pInput.corrected_addr_suite,
															'')));
    temp_address3	:= pInput.corrected_addr_suite;	
		
		SELF.ADDR_BUS_IND			:= IF(temp_address1 + temp_address2 + pInput.ZIP5 != '','B','');																					
		SELF.ADDR_ADDR1_1 		:= 	IF(REGEXFIND('(^SUITE|^UNIT)', temp_address1) AND temp_address2 != '', temp_address2,
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(temp_address1, RemovePattern));
																	
		SELF.ADDR_ADDR2_1			:= 	IF(REGEXFIND('(^SUITE|^UNIT|^,SUITE)', temp_address1) AND temp_address2 != '', TRIM(temp_address1,LEFT,RIGHT),
																   TRIM(temp_address2,LEFT,RIGHT));
		SELF.ADDR_ADDR3_1			:= '';
		SELF.ADDR_ADDR4_1			:= '';
		SELF.ADDR_CITY_1			:= STD.Str.FilterOut(pinput.corrected_addr_city,'.');
		SELF.ADDR_STATE_1     := TrimState;
		SELF.ADDR_ZIP5_1			:= IF(LENGTH(TRIM(pInput.ZIP5)) = 4,0+pInput.ZIP5,pInput.ZIP5);
		SELF.ADDR_ZIP4_1			:= IF(pinput.ZIP4 = '0000' or pinput.ZIP4 = '0','',pInput.Zip4);
		
		
		SELF.ADDR_ADDR1_2			:= '';
		SELF.ADDR_ADDR2_2			:= '';
		SELF.ADDR_ADDR3_2			:= '';
		SELF.ADDR_ADDR4_2 		:= '';
		SELF.ADDR_CITY_2			:= '';
		SELF.OOC_IND_1				:= 0;    
		SELF.OOC_IND_2				:= 0;
		
		 // Identified DBA names
		temp_dba  						:= REGEXFIND('^(.*) /(.*)',clean_name_org,2);		
		SELF.dba1							:= temp_dba;
		SELF.dba2							:= REGEXFIND('^(.*) /(.*)/(.*)',clean_name_org,3);
		SELF.dba3							:= REGEXFIND('^(.*) /(.*)/(.*)/(.*)',clean_name_org,4);
		SELF.dba4							:= REGEXFIND('^(.*) /(.*)/(.*)/(.*)/(.*)',clean_name_org,5);
		SELF.dba5							:= REGEXFIND('^(.*) /(.*)/(.*)/(.*)/(.*)/(.*)',clean_name_org,6);

															
	//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD	:= IF(pInput.BRANCH_UNIQUE_ID = '0000', 'CO','BR');
		SELF.mltreckey			:= 0;

	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       := HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ',' 
		                              +TRIM(pInput.VA_LENDER_ID,LEFT,RIGHT) + ',' 
																	+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																	+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																	+TRIM(SELF.NAME_ORG,LEFT,RIGHT) + ','
																	+TRIM(pInput.address1,LEFT,RIGHT)	+ ','
																	+TRIM(pInput.address2,LEFT,RIGHT)	+ ','
																	+TRIM(pInput.ZIP5));
																			
		SELF.PCMC_SLPK		  	:= 0;
		tmpStripAgent         := IF(strip_agent[1] = ',',strip_agent[2..], strip_agent);
		SELF.PROVNOTE_1				:= IF(STD.Str.Find(tmpStripAgent,' / ',1) > 0,STD.Str.FindReplace(tmpStripAgent, ' / ', ' DBA '),tmpStripAgent);
		SELF.PROVNOTE_2				:= IF(pInput.VA_LENDER_ID != '', 'VA LENDER ID: ' +pInput.VA_LENDER_ID,'');
		SELF.PROVNOTE_3 			:= IF(pInput.lender_status != '', 'LENDER ADDL STATUS: ' + STD.Str.CleanSpaces(pInput.lender_status+ ' ' + pInput.lender_status_addl),''); 
		SELF.AGENCY_ID				:= pInput.VA_LENDER_ID;
		SELF := [];	
		   
END;
inFileLic	:= PROJECT(CleanRec,xformToCommon(LEFT));

// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(inFileLic L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1,LEFT,RIGHT));
	SELF := L;
END;

ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
						TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
						AND RIGHT.fld_name='LIC_TYPE' 
						AND RIGHT.dm_name1 = 'PROFCODE',
						trans_lic_type(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);


// Normalized DBA records
maribase_dbas := RECORD,MAXLENGTH(5000)
maribase_plus_dbas;
STRING60 tmp_dba;
END;

	maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
		SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' AND DBA2 = '' 
					     AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
  SELF.NAME_ORG 				:= IF(REGEXFIND('(%|")',L.NAME_ORG),
															STD.Str.CleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.NAME_ORG)),
																STD.Str.CleanSpaces(STD.Str.FindReplace(L.NAME_ORG,' /',' ')));
  
	tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TRIM(L.TMP_DBA,LEFT,RIGHT)); //business name with standard corp abbr.
	tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);										
	SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
	SELF.NAME_DBA 				:= IF(LENGTH(TRIM(L.TMP_DBA,LEFT,RIGHT)) < 3,'',Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
	SELF.NAME_DBA_SUFX		:= STD.Str.CleanSpaces(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
	SELF.DBA_FLAG					:= IF(TRIM(SELF.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
	SELF.NAME_OFFICE		 	:= STD.Str.CleanSpaces(STD.Str.FindReplace(L.NAME_OFFICE,' /',' '));																
	SELF.NAME_MARI_ORG		:= STD.Str.CleanSpaces(STD.Str.FindReplace(L.NAME_MARI_ORG,' /',' '));
	SELF.NAME_MARI_DBA		:= STD.Str.CleanSpaces(STD.Str.FindReplace(tmpNameDBA,' /',' '));
	SELF := L;
END;

ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));

// Adding to Superfile
d_final   := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base(NAME_ORG_ORIG != ''));

move_to_used := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg_license','using', 'used'));

notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion, Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
RETURN SEQUENTIAL(oCMV, oMtg, oExpand, d_final, add_super,  move_to_used, notify_missing_codes, notify_invalid_address);

END;