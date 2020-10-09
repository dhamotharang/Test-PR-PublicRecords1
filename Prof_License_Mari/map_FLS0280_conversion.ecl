// Purpose : map FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION raw data to common layout for MARI and PL use
//Input file location - \\Tapeload02b\k\professional_licenses\mari\fl\florida_real_estate_professionals_(en)
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, NID;

EXPORT map_FLS0280_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'FLS0280';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

		CORP_NAME_PATTERN := '(' +
							 //'^.* I[\\.]?N[\\.]?C[\\.]?[ |$]|' +     //various form of INC - not used b.c. not working
							 '^M3 [.]* INC\\.$|' +	//exception for INC
							 '\\D* INC |\\D* INC$|\\D* INC\\. |\\D* INC\\.$|\\D*  I\\.N\\.C\\. |\\D* I\\.N\\.C\\.$|' +	//various form of INC
							 '\\D* INC |\\D* INC$|\\D* INC\\. |\\D* INC\\.$|\\D*  I\\.N\\.C\\. |\\D* I\\.N\\.C\\.$|' +	//various form of INC
							 '\\D* LLC |\\D* LLC$|\\D* LLC\\. |\\D* LLC\\.$|\\D*  L\\.L\\.C\\. |\\D* L\\.L\\.C\\.$|' +	//various form of INC
							 '\\D* LLP |\\D* LLP$|\\D* LLP\\. |\\D* LLP\\.$|\\D*  L\\.L\\.P\\. |\\D* L\\.L\\.P\\.$|' +	//various form of INC
							 '\\D* APPRAISER$|\\D* PARTNERS |' +														 
							 '^\\D* CO |^\\D* CO$|^\\D* CO\\. |^\\D* CO\\.$|^\\D* COMPANY$|' +	                              //various form of CO
							 '^\\D* P\\.A\\.$|^\\D* PA$|' +	
							 '^.* LTD |^.* LTD$|^.* LTD\\. |^.* LTD\\.$|' +     													//various form of LTD
							 '^.* DBA *$|^.* D/B/A *$|^.* D\\.B\\.A\\. *$|' +															//various form of DBA
							 '^.* AKA *$|^.* A/K/A *$|^.* A\\.K\\.A\\. *$|' +															//various form of DBA
							 //'^.* A[/]?[\\.]?K[/]?[\\.]?A[/]?[\\.]? .*$|' +		//various form of AKA														 
							 '^T/A .*$|' +	
							 '^.* \\& ACCOUNTING$|' +	
							 '^.* PARTNERS$|.* PARTNERS |' +														 
							 '^\\D* CORP$|\\D* CORP\\.$|^\\D* CORPORATION$|' +														 
							 '^.* GROUP$|.* GROUP |' +														 
							 '^.* ASSOCIATES$|.* ASSOCIATES |' +														 
							 '^.* SERVICES |^.* SERVICES$|' +														 
							 '^.* AFFILIATES$|.* AFFILIATES |' +														 
							 '^(A-Z \\.) RESOURCES$|^(A-Z \\.) RESOURCES |' +		
							 '^(A-Z \\.) REALTY$|^(A-Z \\.) REALTY |' +														 
							 '^COLDWELL BANKER$|^COLDWELL BANKER .*$|^CENTURY 21$|^CENTURY 21 .*$|' +
							 '^THE KEYES .*$|' +
							 '^LA PETITE GARDETTE PIERREVER$|' +                      
							 '^STATE FARM$|^STATE FARM .*$|^RE/MAX .*|^REMAX .*|' +
							 '^[A-Z0-9 \\.]*\\.COM$|^[A-Z0-9 \\.]*\\.NET$|^[A-Z0-9 \\.]*\\.ORG$|' +
							 '^[A-Z0-9 \\.]*\\.GOV$|^[A-Z0-9 \\.]*\\.EDU$)';
								 // '.* SERVICES$|.* SERVICE$|.* SVC$|.* SVCS$|.* TITLE$|' +
												 // '.* PROPERTIES$|.* PROPERTIES NORTH|.* REGIONAL PROPERTIES |.* NETWORK$|.* FIRM$|^.*DEVELOPMENT.*$|SAVVYMOVES|.* AUTHORITY$|'+
												 // '.* APPRAISING$|.* CONSULTANTS$|' + 
												 // '.* TRANSPORTATION DEPARTMENT$|' + 
												 // '.* SAVOIE$||^.* RLTY MANAGEMENT |' +
												 // '^RESULTS REALTY .*$|^.* REALTY SOUTH$|^.* REALTY RESOURCES$|^.* REALTY$|^[A-Z ]* REALTY |' +
												 // '[A-Z]+ RICHARD [A-Z]+|^AMCON$|MEHLE .*$|^[A-Z]+ ADAM [A-Z]+$|^GROVER ANDERSON .*$|^KUEFLER .*$|' + 
		
									 // '^CENTURY 21 |^[A-Z\' ]+ NOTARY$|^[A-Z ]+ CREDIT UNION$|^[A-Z ]+ GILLESPIE REAL ESTATE)';

		//Extract Name from an address line
		//Output is NameFormat:Name where NameFormat can be O, N, FML, LFM, ...
		STRING extractNameFromAddr(STRING address) := FUNCTION

				trimName := ut.CleanSpacesAndUpper(address);
				//trimName2 := StringLib.StringFindReplace(trimName1,'(','"');
				//trimName := StringLib.StringFindReplace(trimName2,')','"');
				
				oname := MAP(REGEXFIND('[ ]*CO[ ]*GALWAY IRELAND', trimName) => '',   //not a company name
				             REGEXFIND('INTEGRA REALTY RESOURCES', trimName) => 'O:INTEGRA REALTY RESOURCES',
										 REGEXFIND('^(.* VISION CARE .*)$', trimName) => 'O:' + REGEXFIND('^(.* VISION CARE .*)$', trimName, 1),
				             REGEXFIND(CORP_NAME_PATTERN, trimName) => 'O:'+REGEXFIND(CORP_NAME_PATTERN, trimName,1),
										 REGEXFIND('C/O (.*)$',trimName,NOCASE) =>
											 MAP(trimName[1..12]='C/O MR & MRS' => 'L:' + trimName[13..],
											     Prof_License_Mari.func_is_company(REGEXFIND('^C/O (.*)$',trimName,1,NOCASE)) => 'O1:' + REGEXFIND('^C/O (.*)$',trimName,1,NOCASE),
										       REGEXFIND('^C/O GM SHANGHAI',trimName,NOCASE) => '',
										       REGEXFIND('C/O PHASE A CONDO',trimName,NOCASE) => '',
										       REGEXFIND('^C/O JONES LANG LASALLE$',trimName,NOCASE) => 'O:JONES LANG LASALLE',
										       REGEXFIND('^C/O NEWMARK KNIGHT FRANK$',trimName,NOCASE) => 'O:NEWMARK KNIGHT FRANK',
										       REGEXFIND('^C/O HOLLIDAY FENOGLIO$',trimName,NOCASE) => 'O:HOLLIDAY FENOGLIO',
													 REGEXFIND('C/O FOUR WINDS MARINA',trimName,NOCASE) => 'O:FOUR WINDS MARINA',
													 REGEXFIND('^C/O MR\\. SKORIC$',trimName,NOCASE) => 'L:SKORIC',  
													 REGEXFIND('^C/O CONTI ',trimName,NOCASE) => 'L:CONTI',  
													 REGEXFIND('^C/O MRS\\. (.*)$',trimName) => 'L:'+REGEXFIND('^C/O MRS\\. (.*)$',trimName,1),  
													 'P1:' + REGEXFIND('C/O (.*)$',trimName,1,NOCASE)),
										 Prof_License_Mari.func_is_company(REGEXFIND('^ATTN: (.*)$',trimName,1,NOCASE)) AND 
										 NOT REGEXFIND('OFFICE MANAGER',trimName,NOCASE)
										   => 'O1:' + REGEXFIND('^ATTN: (.*)$',trimName,1,NOCASE),
				             REGEXFIND('^P O BOX$', trimName) => '',
										 REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1} [A-Z\']{2,}) ',trimName,NOCASE)  => 'FML:'+ REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1} [A-Z\']{2,}) ',trimName,1,NOCASE),
										 REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1} [A-Z\']{2,})$',trimName,NOCASE)  => 'FML:'+ REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1} [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1}\\. [A-Z\']{2,})$',trimName,NOCASE)  => 'FML:'+ REGEXFIND('^ATTN: ([A-Z]+ [A-Z]{1}\\. [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FML:'+ REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z]+ [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FL:'+ REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z\']{2,}) ',trimName,NOCASE) => 'FL:'+ REGEXFIND('^ATTN: ([A-Z\\.]+ [A-Z\']{2,}) ',trimName,1,NOCASE),
										 REGEXFIND('^ATTN:([A-Z\\.]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FL:'+ REGEXFIND('^ATTN:([A-Z\\.]+ [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTN ([A-Z\\.]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FL:'+ REGEXFIND('^ATTN ([A-Z\\.]+ [A-Z\']{2,})$',trimName,1,NOCASE),
										 REGEXFIND('ATTN: ([A-Z\\.]+ [A-Z\']{2,}),',trimName,NOCASE) => 'FL:'+ REGEXFIND('ATTN: ([A-Z\\.]+ [A-Z\']{2,}),',trimName,1,NOCASE),
										 REGEXFIND('^ATTN. ([A-Z\\.]+ [A-Z]+ [A-Z\']+)$',trimName,NOCASE) => 'FML:'+ REGEXFIND('^ATTN. ([A-Z\\.]+ [A-Z]+ [A-Z\']+)$',trimName,1,NOCASE),
										 REGEXFIND('^ATTENTION:[ ]+([A-Z\\.]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FL:'+ REGEXFIND('^ATTENTION:[ ]+([A-Z\\.]+ [A-Z\\.]{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTENTION:[ ]+([A-Z]+ [A-Z]{1} [A-Z\']{2,})$',trimName,NOCASE) => 'FML:'+ REGEXFIND('^ATTENTION:[ ]+([A-Z]+ [A-Z]{1} [A-Z\\.]{2,})$',trimName,1,NOCASE),
										 REGEXFIND('^ATTENTION:[ ]+([A-Z\\.]+ [A-Z]+ [A-Z\']{2,})$',trimName,NOCASE) => 'FML:'+ REGEXFIND('^ATTENTION:[ ]+([A-Z]+ [A-Z]{1}\\. [A-Z\\.]{2,})$',trimName,1,NOCASE),
										 REGEXFIND('ATT: REAL ESTATE SOLUTIONS',trimName,NOCASE) => 'O:REAL ESTATE SOLUTIONS',
										 REGEXFIND('ATT: BETH',trimName,NOCASE) => 'F:BETH',
										 REGEXFIND('^DBA (.*)$',trimName,NOCASE)  => 'DBA:'+ REGEXFIND('^DBA (.*)$',trimName,1,NOCASE),
										 REGEXFIND('^TRADEWINDS W CONDOMINIUMS$',trimName,NOCASE) => '',
										 REGEXFIND('^CENTURY VILLAGE E$',trimName,NOCASE) => '',
										 REGEXFIND('^OCEANVIEW B BUILDING$',trimName,NOCASE) => '',
										 REGEXFIND('^PENTHOUSE II A$',trimName,NOCASE) => '',
										 REGEXFIND('^TOWER I SOUTH$',trimName,NOCASE) => '',
										 REGEXFIND('^[A-Z]+ [A-Z]{1} [A-Z]{2,}$',trimName,NOCASE) => 'FML:'+ trimName,
										 REGEXFIND('^[A-Z]+ [A-Z]{1}\\. [A-Z]{2,}$',trimName,NOCASE) => 'FML:'+ trimName,
										 REGEXFIND('^[A-Z]{2,} [A-Z]+ [A-Z]{1}$',trimName,NOCASE) AND trimName[1..3]<>'PO '=> 'LFM:'+ trimName,
										 REGEXFIND('^OWNER (.*)$',trimName,NOCASE) => 'FL:'+ REGEXFIND('^OWNER (.*)$',trimName,1,NOCASE),
										 REGEXFIND('^(TODD SCOTT FISCHER)$',trimName,NOCASE) => 'FML:TODD SCOTT FISCHER',
										 REGEXFIND('^(RON G FALCIANO JR)$',trimName,NOCASE) => 'FMLS:RON G FALCIANO JR',
										 REGEXFIND('^(RICH [A-Z]+)$',trimName,NOCASE) => 'FL:'+REGEXFIND('^(RICH [A-Z]+)$',trimName,1,NOCASE),
										 REGEXFIND('^(TERRAZA DEMAJAGUA)$',trimName,NOCASE) => 'FL:TERRAZA DEMAJAGUA',  
										 REGEXFIND('^(SIUFER GONZALEZ)$',trimName,NOCASE) => 'FL:SIUFER GONZALEZ',  
										 REGEXFIND('^(RON MCGUIRE/)',trimName,NOCASE) => 'FL:RON MCGUIRE',                     
										 REGEXFIND('^(REINHARD KRAFFT)$',trimName,NOCASE) => 'FL:REINHARD KRAFFT',  
										 REGEXFIND('^(R. MENENDEZ PIDAL)$',trimName,NOCASE) => 'FML:R. MENENDEZ PIDAL',  
										 REGEXFIND('^(NORTHMARQ)$',trimName,NOCASE) => 'N:NORTHMARQ',  
										 REGEXFIND('^(NAI/MERIN HUNTER CODMAN)$',trimName,NOCASE) => 'O2:NAI/MERIN HUNTER CODMAN',  
										 REGEXFIND('^(MR JULIO MESTAS)$',trimName,NOCASE) => 'FL:JULIO MESTAS',  
										 REGEXFIND('^(JR PUENTE Y CORTEZ)$',trimName,NOCASE) => 'FL:PUENTE Y CORTEZ',
										 REGEXFIND('^(MILDRED MARCH)$',trimName,NOCASE) => 'FL:MILDRED MARCH',  
										 REGEXFIND('^(MARIE ALICE PIERRE)$',trimName,NOCASE) => 'FML:MARIE ALICE PIERRE',  
										 REGEXFIND('^(L\'HERMITAGE)$',trimName,NOCASE) => 'N:L\'HERMITAGE',  
										 REGEXFIND('^(JORGE RODRIGUEZ-CHOMAT)$',trimName,NOCASE) => 'FL:JORGE RODRIGUEZ-CHOMAT',  
										 REGEXFIND('^(JOHN HENRY ROTH)$',trimName,NOCASE) => 'FML:JOHN HENRY ROTH',  
										 REGEXFIND('^(JOHN E LENNON III)$',trimName,NOCASE) => 'FMLS:JOHN E LENNON III',  
										 REGEXFIND('^(JACKELINE NAGY)$',trimName,NOCASE) => 'FL:JACKELINE NAGY',  
										 REGEXFIND('^(ILEANA LUGO)$',trimName,NOCASE) => 'FL:ILEANA LUGO',  
										 REGEXFIND('^(.* ARANGUREN)$',trimName,NOCASE) => 'FMNL:'+ REGEXREPLACE('"',trimName,''),  
										 REGEXFIND('^(CUTTHROAT)$',trimName,NOCASE) => 'N:CUTTHROAT',  
										 REGEXFIND('^(CHEZ GREBER)$',trimName,NOCASE) => 'FL:CHEZ GREBER',  
										 REGEXFIND('^(CARMEN SAYERS)$',trimName,NOCASE) => 'FL:CARMEN SAYERS',  
										 REGEXFIND('^(ANTHONY ELGIN)$',trimName,NOCASE) => 'FL:ANTHONY ELGIN',  
										 REGEXFIND('^(ANNIE GUY)$',trimName,NOCASE) => 'FL:ANNIE GUY',  
										 REGEXFIND('^(ALLEN HUNTER JR)$',trimName,NOCASE) => 'FLS:ALLEN HUNTER JR',  
										 REGEXFIND('^(KLAUS PETER ZAHN)$',trimName,NOCASE) => 'FML:KLAUS PETER ZAHN',  
										 REGEXFIND('^(CO/DEBORAH SAMUEL)$',trimName,NOCASE) => 'FL:DEBORAH SAMUEL',                                  
 										 REGEXFIND('^(UNIVERSITY OF .*)$',trimName,NOCASE) => 'O3:'+REGEXFIND('^(UNIVERSITY OF .*)$',trimName,1,NOCASE),
 										 REGEXFIND('RIGHT CHOICE REALTY',trimName,NOCASE) => 'O:RIGHT CHOICE REALTY',
 										 REGEXFIND('THE KEYES COMPANY REALTORS',trimName,NOCASE) => 'O:THE KEYES COMPANY REALTORS',                 
 										 REGEXFIND('KEYES COMPANY REALTORS',trimName,NOCASE) => 'O:KEYES COMPANY REALTORS',                 
										 '');
					//More processing for P1 (C/O name)
					oname1 := MAP(oname[1..3]='P1:' AND REGEXFIND('^PROLOGIS$', oname[4..]) => 'O:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.+) OR', oname[4..]) 
												        => 'FL:'+ REGEXFIND('^(.+) (.+) OR', oname[4..], 1) + ' ' + REGEXFIND('^(.+) (.+) OR', oname[4..], 2),
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.+)$', oname[4..]) => 'FL:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.{1}) (.+)$', oname[4..]) => 'FML:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.{1})\\. (.+)$', oname[4..]) => 'FML:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.+) (.{1})$', oname[4..]) => 'LFM:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^(.+) (.+) (.{1})\\.$', oname[4..]) => 'LFM:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('^([A-Z]+)$', oname[4..]) => 'L:'+ oname[4..],
					              oname[1..3]='P1:' AND REGEXFIND('M.PELLERIN', oname[4..]) => 'FL:M. PELLERIN',
												oname);
				RETURN TRIM(oname1,LEFT,RIGHT);

		END;
	
		STRING removeNameFromAddress(STRING address, STRING name) := FUNCTION
			//remove the leading name identifier, like FML:,O:
			tempName := IF(REGEXFIND('".*"',name),REGEXREPLACE('".*"',name,'\\(.*\\)'),name);  //nickname  can be in "name" or (name)
			prepName := IF(REGEXFIND('.*:(.*)',tempName),REGEXFIND('.*:(.*)',tempName,1),tempName);
			//prepName := IF(REGEXFIND('.*:(.*)',name),REGEXFIND('.*:(.*)',name,1),name);
			//preAddr1 := IF(REGEXFIND(prepName, address), REGEXREPLACE(prepName, address, ''), address);
			preAddr1 := StringLib.StringFindReplace(address,prepName,'');
			preAddr2 := REGEXREPLACE('(C/O |ATTN: |ATTENTION: |OWNER |T/A |ATTN:|ATTN|^[ ]*DBA[ ]*$|& MRS$)', preAddr1, '');
			//Remove left over title after removing the name
			preAddr3 := REGEXREPLACE('(OFFICE MANAGER|, BROKER|[0-9]* , MNGR|MANAGING BROKER|GATES/LEGAL|' + 
			                         'LIC REAL ESTATE BROKER|GENERAL DELIVERY|' +
															 'MR |JR |MR\\. | OR VALERIE LOWERISON|M\\.PELLERIN|C BERGER)', preAddr2, '');
			//More cleaning
			preAddr4 := REGEXREPLACE('- CUBE', preAddr3, 'CUBE');
			preAddr5 := REGEXREPLACE('C/O-IPS', preAddr4, 'IPS');
			preAddr5_1 := REGEXREPLACE('\\(TEMPORARY .*\\)', preAddr5, '');
			preAddr5_2 := REGEXREPLACE(' AVE/$', preAddr5_1, ' AVE');
			preAddr5_3 := REGEXREPLACE('^CO/$', preAddr5_2, '');
			preAddr5_4 := REGEXREPLACE('APT[ ]*:', preAddr5_3, 'APT ');
			preAddr5_5 := REGEXREPLACE('STE:', preAddr5_4, 'STE ');
			preAddr5_6 := REGEXREPLACE('UNIT:', preAddr5_5, 'UNIT ');
			preAddr5_7 := REGEXREPLACE('UNIT[ ]*[#]?[ ]*:[ ]*', preAddr5_6, 'UNIT ');
			preAddr5_8 := REGEXREPLACE('SUITE:', preAddr5_7, 'SUITE ');
			preAddr5_9 := REGEXREPLACE('APARTMENT[ ]*[#]?[ ]*:[ ]*', preAddr5_8, 'APARTMENT ');
			preAddr5_10 := REGEXREPLACE('P 0 ', preAddr5_9, 'PO ');
			preAddr5_11 := REGEXREPLACE('AKA .* ST$', preAddr5_10, '');  //REMOVE AKA 54 ST FROM  THE ADDRESS FIELD
			//strip .
			preAddr6 := StringLib.StringFindReplace(preAddr5_11,'.',' ');
			//Replace P O B by POB
			preAddr7 := StringLib.StringFindReplace(preAddr6,'P O  B ','POB ');
			//Replace P O by PO
			preAddr8 := StringLib.StringFindReplace(preAddr7,'P O ','PO ');
			//Replace N E by NE
			preAddr9 := StringLib.StringFindReplace(preAddr8,' N E ',' NE ');
			//Replace S W by SW
			preAddr10 := StringLib.StringFindReplace(preAddr9,' S W ',' SW ');
			//Replace U S by US
			preAddr11 := StringLib.StringFindReplace(preAddr10,' U S ',' US ');
			//Replace N W by NW
			preAddr12 := StringLib.StringFindReplace(preAddr11,' N W ',' NW ');
			//Replace S E by SE
			preAddr13 := StringLib.StringFindReplace(preAddr12,' S E ',' SE ');
			//strip #
			//preAddr14 := StringLib.StringFindReplace(preAddr13,'#',' ');
			//remove extra spaces
			preAddr14 := stringlib.stringcleanspaces(preAddr13);
			RETURN preAddr14;
		END;
		
		//Move input file from sprayed to using
		move_to_using		:= PARALLEL(
							Prof_License_Mari.func_move_file.MyMoveFile(code, 'lic64', 'sprayed', 'using');
							Prof_License_Mari.func_move_file.MyMoveFile(code, 're1', 'sprayed', 'using');
							// Prof_License_Mari.func_move_file.MyMoveFile(code, 're2', 'sprayed', 'using');
							// Prof_License_Mari.func_move_file.MyMoveFile(code, 're3', 'sprayed', 'using');
							// Prof_License_Mari.func_move_file.MyMoveFile(code, 're4', 'sprayed', 'using');
							// Prof_License_Mari.func_move_file.MyMoveFile(code, 're5', 'sprayed', 'using');
							Prof_License_Mari.func_move_file.MyMoveFile(code, 'corp', 'sprayed', 'using');
			);

	MD_Lic_types := ['25BK','25BK001','25SL','25ZH072','25ZH073', '64GA','64IR', '64RD','64RH','64RI','64RZ','64TP'];
	GR_Lic_types := ['25BO','25PR' ,'25CQ','641', '642', '64MC', '64FMC', '64PVDR'];
	defineTypes  := ['25BK','25BK001','25SL','64RD','64RI','64RZ'];

	//input files
	lic64	                  := Prof_License_Mari.files_FLS0280.lic64;
	Olic64		:= output(lic64);
	re_individual	:= Prof_License_Mari.files_FLS0280.re;
	Ore 		:= output(re_individual);

	corp	:= Prof_License_Mari.files_FLS0280.re;
	Ocorp 		:= output(corp);

  re_individual_plus_corp := re_individual + corp;

	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	Ocmv := output(Cmvtranslation);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';
	COMPANY_IND := '( LLC[\\.]?$| INC[\\.]?$| CORP[\\.]?$)';

	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';


	//Combine files into one common layout
	Prof_License_Mari.layout_FLS0280.common map_lic64(Prof_License_Mari.layout_FLS0280.lic64 L) := TRANSFORM
		SELF.alternate_lic_numr	:= ' ';
		SELF.officename_dba	:= ' ';
		SELF.officename		:= ' ';
		SELF.office_lic_numr		:= ' ';
		SELF.county		:= ' ';
		SELF	:= L;
	END;
	lic64common	:= PROJECT(lic64, map_lic64(left));
	
	//Remove bad records before processing
	ValidLic64	:= lic64common(TRIM(LICENSEE_NAME) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LICENSEE_NAME)));

	Prof_License_Mari.layout_FLS0280.common map_re(Prof_License_Mari.layout_FLS0280.re L) := TRANSFORM
		SELF.filler	:= ' ';
		//occupation_code is not provided. However it is in the board_number field.
		SELF.occupation_code := L.board_number;
		SELF.renewal_period := ' ';
		SELF.county_code := ' ';
		SELF	:= L;
	END;
	re_common	:= PROJECT(re_individual_plus_corp, map_re(left));
	
	//Remove bad records before processing
	ValidRE	:= re_common(TRIM(LICENSEE_NAME,LEFT,RIGHT) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LICENSEE_NAME)));

	ValidFile	:= ValidLic64 + ValidRE;

	ValidInFile	:= ValidFile(NOT StringLib.stringfind(LICENSEE_NAME,'NON-LICENSED OWNER\\EMPLOYER',1)>0 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LICENSEE_NAME)));
	//testFile  := choosen(ValidFile,10000);

	maribase_plus_dbas := record,maxlength(5000)
		Prof_License_Mari.layout_base_in;
		string60 dba;
		string60 dba1;
		string60 dba2;
		string60 dba3;
		string60 dba4;
		string60 dba5;
	end;


	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_FLS0280.common pInput) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE				:= pVersion; 					 		//yyyymmdd

		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC	:= ' ';
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_PROF_DESC		:= ' ';

		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.LICENSE_STATE		:= src_st;

		SELF.LICENSE_NBR	    := ut.CleanSpacesAndUpper(pInput.license_number);
		//There are some records starting with TEMP CERT. They are not defined in cmvtranslation. Remove them for now. 1/30/13 Cathy Tio
		//
		tmpRawLicenseStatus   := ut.CleanSpacesAndUpper(pInput.primary_status)+' '+
														 ut.CleanSpacesAndUpper(pInput.secondary_status);
		SELF.RAW_LICENSE_STATUS := TRIM(REGEXREPLACE('TEMP CERT',tmpRawLicenseStatus,'CURRENT'),LEFT, RIGHT);                              

		// initialize raw_license_type from raw data
		tempRawType 					:= TRIM(MAP(pInput.board_number = '64'  => ut.CleanSpacesAndUpper(pInput.board_number)+
																																ut.CleanSpacesAndUpper(pInput.occupation_code),
																      pInput.board_number != '64' => ut.CleanSpacesAndUpper(pInput.occupation_code)+' '+
																																ut.CleanSpacesAndUpper(pInput.class_code),
																      ' '),
																	LEFT, RIGHT);
													 
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																				
		// map raw license type to standard license type before profcode translations
		tempStdLicType 				:= MAP(pInput.board_number = '64' => tempRawType,     
																tempRawType = '2501 REAL ESTATE BROKER OR SALES BK BROKER' => '25BK',
																tempRawType = '2501 REAL ESTATE BROKER OR SALES BL BROKER SALES' => '25BK001',
																tempRawType = '2501 REAL ESTATE BROKER OR SALES TEML TEMP BL LICENSE' => '25BK001',	  //added 1/30/13 Cathy Tio	
																tempRawType = '2501 REAL ESTATE BROKER OR SALES TEMP TEMP BK LICENSE' => '25BK001',		//added 1/30/13 Cathy Tio
																tempRawType = '2501 REAL ESTATE BROKER OR SALES SL SALES ASSOCIATE' => '25SL',
																tempRawType = '2501 REAL ESTATE BROKER OR SALES TEMS TEMP SL LICENSE' => '25SL',				//added 1/30/13 Cathy Tio		
																tempRawType = '2502 REAL ESTATE CORPORATION CQ RE CORP.' => '25CQ',
																tempRawType = '2503 REAL ESTATE PARTNERSHIP PR RE PARTNERSHIP' => '25PR',
																tempRawType = '2504 REAL ESTATE BRANCH OFFICE BO RE BRANCH OFFIC' => '25BO',
																tempRawType = '2505 REAL ESTATE INSTRUCTOR ZH RE INSTRUCTOR' => '25ZH073',
																tempRawType = '2507 REAL ESTATE ADDITIONAL LOCATION ZH ADD SCH LOC' => '25ZH074', 
																' ');
																 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
				
		// assigning type code based on license type
		tempTypeCd		 				:= MAP(tempStdLicType in GR_lic_types => 'GR',									   
																	tempStdLicType in MD_lic_types => 'MD',
																	'');
										
		SELF.TYPE_CD      		:= tempTypeCd;
		tempMariParse     		:= tempTypeCd;

		mariParse         		:= map(tempStdLicType in defineTypes and prof_license_mari.func_is_company(pInput.licensee_name) = true => 'GR',
																 tempStdLicType in defineTypes and prof_license_mari.func_is_company(pInput.licensee_name) = false => 'MD',
																 prof_license_mari.func_is_company(pInput.licensee_name) => 'GR',
																 REGEXFIND('( INSTITUTE$| HOLDINGS$| PA$| PA 2$| P A$| P\\.A$|P\\.A\\.$| PL$| PLC$| PLLC$|' +
																           '4 LESS$|MY LAST FEW|L C$| VALUATIONS$|VALUATONS$|GREENSIGHT VALUE$| SEMINARS$| LAND TRUST$|' +
																					 'RENTER\'S MAGIC$|\\.COM$| CORPS$|,LLC$|HELP YOU BUY|FILE 108|REALPRO 100|' +
																					 'FOR BETTER HOUSING|RENTALS MIAMI BEACH| RENTALS$|INSIDERS RE$| INTERNAZIONALE$|'+
																					 'WEBSCHOOL$|L S I$)',pInput.licensee_name, nocase) => 'GR',
																 NOT prof_license_mari.func_is_company(pInput.licensee_name) => 'MD',
																 tempMariParse);
																		
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.licensee_name);
				
		// noquoteORG      := if(mariParse='GR',stringlib.stringfindreplace(TrimNAME_ORG,'"',''),TrimNAME_ORG);
				
		prepNAME_ORG					:= MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
																	StringLib.stringfind(TrimNAME_ORG,'DBA ',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'DBA ',' '),
																	StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
																	StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
																	StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
																	StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
																	StringLib.stringfind(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO',1) >0 
																					=> stringlib.stringfindreplace(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO','FLORIDA DEPARTMENT OF TRANSPORTATION'),
																								trimNAME_ORG);
												 
		tempNick							:= IF(StringLib.stringfind(prepNAME_ORG,'"',1) >0 and StringLib.stringfind(prepNAME_ORG,'(',1) >0,
																REGEXFIND('^([A-Za-z ][^("]+)[\\(][\\"]([A-Za-z ][^\\"]+)[\\"][\\)]',prepNAME_ORG,2),'');
		
		//Removing NickName from Corporate NAME field
		removeNick						:= IF(tempNick != ' ',REGEXREPLACE(tempNick,prepNAME_ORG,''), prepNAME_ORG);
		
		rmvQuoteORG     			:= stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
		StdNAME_ORG						:= IF(rmvQuoteORG != ' ' and NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
																rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
	
		// use the right parser for name field
		tmp_rmvQuoteORG  := if(tempTypeCd = 'MD' and mariParse = 'MD' and regexfind('^(([A-Z\\s\\,]+) PA$)', trim(rmvQuoteORG)),
															regexfind('^(([A-Z\\s\\,]+) PA$)', trim(rmvQuoteORG),2), rmvQuoteORG);
		tmpCleanNAME_ORG					:= map(// tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
																 tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 //tempTypeCd = 'GR' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(rmvQuoteORG),
																 tempTypeCd = 'GR' and mariParse = 'MD' AND REGEXFIND('[A-Z \']+, ',rmvQuoteORG) => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(rmvQuoteORG),
																 tempTypeCd = 'GR' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
																 tempTypeCd = 'MD' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanLFMName(tmp_rmvQuoteORG),
																 // tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
																 tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
																 StdNAME_ORG);
		
		//Recleaning Names that are not parsing correctly		
		reCleanNAME_ORG := MAP(tempTypeCd = 'MD' and mariParse = 'MD' and length(TRIM(tmpCleanNAME_ORG[46..65],left,right)) < 2 => NID.CleanPerson73(rmvQuoteORG),
												   tempTypeCd = 'GR' and mariParse = 'MD' and tmpCleanNAME_ORG = '' => rmvQuoteORG,
												   tempTypeCd = 'MD' and mariParse = 'GR' and tmpCleanNAME_ORG = '' => rmvQuoteORG,
													 tmpCleanNAME_ORG);
		
		CleanNAME_ORG := if(reCleanNAME_ORG != '', reCleanNAME_ORG, tmpCleanNAME_ORG); 
		
		tmpstr := trim(pInput.licensee_name)+' '+IF(prof_license_mari.func_is_company(pInput.licensee_name),' IS ',' IS NOT ')+'company|';
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
		
		//NAME_ORG should be LAST NAME + FIRST NAME for individuals
		self.NAME_ORG 				:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[6..25]),
																 StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 and self.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																 CleanNAME_ORG);
			
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
		tmpOrgSufx2						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
		tmpOrgSufx3						:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
				
	 // Parsed out ORG_NAME Suffix
		self.NAME_ORG_SUFX		:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
																 NOT REGEXFIND('LLP',StdNAME_ORG) and REGEXFIND('(LP)$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
																 REGEXFIND('(L[.]P[.])$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
																											Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
																											
		//Removed based on Terri's review comment for BUG 124107														
		//self.NAME_PREFX     	:= if(mariParse='MD',TRIM(CleanNAME_ORG[1..5],left,right),'');
		self.NAME_FIRST				:= if(mariParse='MD',TRIM(CleanNAME_ORG[6..25],left,right),'');
		self.NAME_MID					:= if(mariParse='MD',TRIM(CleanNAME_ORG[26..45],left,right),'');
		self.NAME_LAST				:= if(mariParse='MD',TRIM(CleanNAME_ORG[46..65],left,right),'');
		self.NAME_SUFX				:= if(mariParse='MD',TRIM(CleanNAME_ORG[66..70],left,right),'');
		self.NAME_NICK				:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
																	StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																	tempNick);
				
		// assign officename and office parse field : GR if company, MD if individual 
		trimNAME_DBA        	:= ut.CleanSpacesAndUpper(pInput.doing_bus_name);
		trimNAME_OFFICE     	:= ut.CleanSpacesAndUpper(pInput.officename);
		
		// assign address fields from raw
		trimADDR_ADDR1 				:= IF(REGEXFIND('^(PRIVATE ADDRESS|PRIVATE|NONE|NA|N/A|NOT PUBLIC|MAILING ADDRESS)$', pInput.address_line1, NOCASE),
		                            '',
		                            ut.CleanSpacesAndUpper(pInput.address_line1));
		trimADDR_ADDR21				:= IF(REGEXFIND('^(PRIVATE ADDRESS|PRIVATE|NONE|NA|N/A|NOT PUBLIC|MAILING ADDRESS)$', pInput.address_line2, NOCASE),
		                            '',
		                            ut.CleanSpacesAndUpper(pInput.address_line2));
		trimADDR_ADDR31				:= IF(REGEXFIND('^(PRIVATE ADDRESS|PRIVATE|NONE|NA|N/A|NOT PUBLIC|MAILING ADDRESS)$', pInput.address_line3, NOCASE),
		                            '',
		                            ut.CleanSpacesAndUpper(pInput.address_line3));
		
		//Combine line2 and line3 for special scenarios
		trimADDR_ADDR2				:= IF(trimADDR_ADDR21='GOLDSTEIN COMMERCIAL' AND trimADDR_ADDR31='PROPERTIES, INC.',
																trimADDR_ADDR21+' '+trimADDR_ADDR31,
																trimADDR_ADDR21);
		trimADDR_ADDR3				:= IF(trimADDR_ADDR21='GOLDSTEIN COMMERCIAL' AND trimADDR_ADDR31='PROPERTIES, INC.',
																'',
																trimADDR_ADDR31);
		//self.provnote_3:= tmpstr+'tempTypeCd='+tempTypeCd+'|mariParse='+mariParse+'|StdNAME_ORG='+StdNAME_ORG+'|rmvQuoteORG='+rmvQuoteORG+'|'+trimADDR_ADDR1+'|'+trimADDR_ADDR2+'|'+trimADDR_ADDR3;
		//Remove C/Os, ATTNs that do not serve a purpose, like C/O P O Box
		STRING cleanupAddrField(STRING iAddr) := FUNCTION
			RETURN MAP(REGEXFIND('C/O P[ ]*O BOX',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O',iAddr,''),LEFT,RIGHT),
										       REGEXFIND('MARY ESTHER C/O',iAddr,NOCASE) => TRIM(REGEXREPLACE('MARY ESTHER C/O',iAddr,'MARY ESTHER CUTOFF'),LEFT,RIGHT),
													 REGEXFIND('C/O$',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('C/O LEGAL DEPARTMENT',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O LEGAL DEPARTMENT',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('C/O[ ]*GENERAL COUNSEL',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O[ ]*GENERAL COUNSEL',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('C/O[ ]*GO TO NATIONS',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O[ ]*GO TO NATIONS',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('C/O[ ]*PALMS EAST OFFICE',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O[ ]*PALMS EAST OFFICE',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('^C O CUSH',iAddr,NOCASE) => TRIM(REGEXREPLACE('C O CUSH',iAddr,'C/O CUSH'),LEFT,RIGHT),
													 REGEXFIND('^C/O 345 20TH',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O 345 20TH',iAddr,'345 20TH'),LEFT,RIGHT),
													 REGEXFIND('C/O WORTH',iAddr,NOCASE) => TRIM(REGEXREPLACE('C/O WORTH',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN:[ ]*LEGAL DEPARTMENT',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN:[ ]*LEGAL DEPARTMENT',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN\\.:[ ]*LEGAL[ ]+DEPARTMENT',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN\\.:[ ]*LEGAL[ ]+DEPARTMENT',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN[\\.]?:[ ]*LEGAL[ ]+DEPT[\\.]?',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN[\\.]?:[ ]*LEGAL[ ]+DEPT[\\.]?',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN[\\.]?:[ ]*GATES/LEGAL',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN[\\.]?:[ ]*GATES/LEGAL',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN[\\.]?:[ ]*COMPLIANCE DEPT',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN[\\.]?:[ ]*COMPLIANCE DEPT',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN: LICENSING COMPLIANCE',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN: LICENSING COMPLIANCE',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTN[\\.]?:[ ]*OFFICE',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTN[\\.]?:[ ]*OFFICE',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('^ADMINISTRATION$',iAddr,NOCASE) => TRIM(REGEXREPLACE('^ADMINISTRATION$',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('^ANNT:',iAddr,NOCASE) => TRIM(REGEXREPLACE('ANNT:',iAddr,'ATTN:'),LEFT,RIGHT),
													 REGEXFIND('ATT: CORP COMPLIANCE',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATT: CORP COMPLIANCE ',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('ATTEN:',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATTEN:',iAddr,'ATTN:'),LEFT,RIGHT),
													 REGEXFIND('ATT:',iAddr,NOCASE) => TRIM(REGEXREPLACE('ATT:',iAddr,'ATTN:'),LEFT,RIGHT),
													 REGEXFIND('COUNTY:.*$',iAddr,NOCASE) => TRIM(REGEXREPLACE('COUNTY:.*$',iAddr,''),LEFT,RIGHT),
													 REGEXFIND('DBA/A',iAddr,NOCASE) => TRIM(REGEXREPLACE('DBA/A',iAddr,'DBA A'),LEFT,RIGHT),
													 REGEXFIND('\\(JONCO CONSULTING INC.\\)',iAddr,NOCASE) => 'JONCO CONSULTING INC',
													 REGEXFIND('VIA EMILIA',iAddr,NOCASE) => '',
													 StringLib.stringfind(iAddr,'C\\O ',1)> 0 => stringlib.stringfindreplace(iAddr,'C\\O ','C/O '),
													 StringLib.stringfind(iAddr,'(HOPE)',1)> 0 => StringLib.StringFindReplace(iAddr,'(HOPE)','HOPE'),
													 //StringLib.stringfind(iAddr,'C/O PO BOX 5130',1) >0 => stringlib.stringfindreplace(iAddr,'C/O PO BOX 5130','PO BOX 5130'),
													 //StringLib.stringfind(iAddr,'P O BOX 77 C/O CATANESE',1) >0 => stringlib.stringfindreplace(iAddr,'P O BOX 77 C/O CATANESE','P O BOX 77'),
													 //Remove C/O that does not serve a purpose, like C/O P O Box ...
													 // StringLib.stringfind(iAddr,'777 C/O CB RICHARD ELLIS, INC.',1) >0 => stringlib.stringfindreplace(iAddr,'777 C/O CB RICHARD ELLIS, INC.','C/O CB RICHARD ELLIS, INC.'),
													 iAddr);                            
		END;
		
		//Clean up C/O, ATTN, and others
	  prepADDR_ADDR1				:= cleanupAddrField(trimADDR_ADDR1);					
	  prepADDR_ADDR2				:= cleanupAddrField(trimADDR_ADDR2);					
	  prepADDR_ADDR3				:= cleanupAddrField(trimADDR_ADDR3);					


		//Extract company names or personal names from address lines
		name_ADDR1						:= extractNameFromAddr(prepADDR_ADDR1);
		name_ADDR2						:= extractNameFromAddr(prepADDR_ADDR2);
		name_ADDR3						:= extractNameFromAddr(prepADDR_ADDR3);
		//self.provnote_2 := name_ADDR1 + '|' + name_ADDR2 + '|' + name_ADDR3;
	
		tempCompanyName				:= MAP(name_ADDR1[1..2]='O:'  => name_ADDR1[3..],
																 name_ADDR1[1..3]='O1:' => name_ADDR1[4..],
																 name_ADDR1[1..3]='O2:' => REGEXFIND('O2:(.*)/',name_ADDR1,1),
																 name_ADDR1[1..3]='O3:' => name_ADDR1[4..],
																 name_ADDR1[1..2]='N:'  => name_ADDR1[3..],
																 name_ADDR2[1..2]='O:'  => name_ADDR2[3..],
																 name_ADDR2[1..3]='O1:' => name_ADDR2[4..],
																 name_ADDR2[1..3]='O2:' => REGEXFIND('O2:(.*)/',name_ADDR2,1),
																 name_ADDR2[1..3]='O3:' => name_ADDR2[4..],
																 name_ADDR2[1..2]='N:'  => name_ADDR2[3..],
																 name_ADDR3[1..2]='O:'  => name_ADDR3[3..],
																 name_ADDR3[1..3]='O1:' => name_ADDR3[4..],
																 name_ADDR3[1..3]='O2:' => REGEXFIND('O2:(.*)/',name_ADDR3,1),
																 name_ADDR3[1..3]='O3:' => name_ADDR3[4..],
																 name_ADDR3[1..2]='N:'  => name_ADDR3[3..],
																 '');
		cleanedCompanyName		:= REGEXREPLACE('(C/O |ATTN:|ATTENTION:|T/A)', tempCompanyName, '');
	
		tempDBAName						:= TRIM(MAP(name_ADDR1[1..4]='DBA:'  => name_ADDR1[5..],
																      name_ADDR2[1..4]='DBA:'  => name_ADDR2[5..],
																      name_ADDR3[1..4]='DBA:'  => name_ADDR3[5..],
																      ''), RIGHT, LEFT);
		cleanedDBAName				:= IF(tempDBAName<>'' AND tempDBAName<>trimNAME_OFFICE AND tempDBAName<>trimNAME_DBA,
		                            tempDBAName,
																'');

		tempContactFName			:= MAP(name_ADDR1[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR1,2),
																 name_ADDR1[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR1,2),
																 name_ADDR1[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..2]='F:'  	 => REGEXFIND('^F:(.*)$',name_ADDR1,1),
																 name_ADDR2[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR2,1),
																 name_ADDR2[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR2,1),
																 name_ADDR2[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR2,2),
																 name_ADDR2[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR2,1),
																 name_ADDR2[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR2,1),
																 name_ADDR2[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..2]='F:'  	 => REGEXFIND('^F:(.*)$',name_ADDR2,1),
																 name_ADDR3[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR3,2),
																 name_ADDR3[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR3,2),
																 name_ADDR3[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..2]='F:'  	 => REGEXFIND('F:(.*)$',name_ADDR3,1),
																 '');
		tempContactMName			:= MAP(name_ADDR1[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR1,2),
																 name_ADDR1[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR1,3),
																 name_ADDR1[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR1,3),
																 name_ADDR1[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR1,2),
																 name_ADDR1[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR1,2),
																 name_ADDR2[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR2,3),
																 name_ADDR2[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR2,3),
																 name_ADDR2[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR3[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR3,2),
																 name_ADDR3[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR3,3),
																 name_ADDR3[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR3,3),
																 name_ADDR3[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR3,2),
																 name_ADDR3[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR3,2),
																 '');
		tempContactLName			:= MAP(name_ADDR1[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR1,3),
																 name_ADDR1[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR1,2),
																 name_ADDR1[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR1,1),
																 name_ADDR1[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR1,4),
																 name_ADDR1[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR1,3),
																 name_ADDR1[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR1,4),
																 name_ADDR1[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR1,2),
																 name_ADDR1[1..2]='L:'    => REGEXFIND('^L:(.*)$',name_ADDR1,1),
																 name_ADDR2[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR2,3),
																 name_ADDR2[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR2,1),
																 name_ADDR2[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR2,4),
																 name_ADDR2[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR2,3),
																 name_ADDR2[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR2,4),
																 name_ADDR2[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR2,2),
																 name_ADDR2[1..2]='L:'    => REGEXFIND('^L:(.*)$',name_ADDR2,1),
																 name_ADDR3[1..4]='FML:'  => REGEXFIND('^FML:(.*) (.*) (.*)$',name_ADDR3,3),
																 name_ADDR3[1..3]='FL:'   => REGEXFIND('^FL:(.*) (.*)$',name_ADDR3,2),
																 name_ADDR3[1..4]='LFM:'  => REGEXFIND('^LFM:(.*) (.*) (.*)$',name_ADDR3,1),
																 name_ADDR3[1..3]='O2:'   => REGEXFIND('O2:(.*)/(.*) (.*) (.*)',name_ADDR3,4),
																 name_ADDR3[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR3,3),
																 name_ADDR3[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR3,4),
																 name_ADDR3[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR3,2),
																 name_ADDR3[1..2]='L:'    => REGEXFIND('^L:(.*)$',name_ADDR3,1),
																 '');
		tempContactNName			:= MAP(name_ADDR1[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR1,3),
																 name_ADDR2[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR2,3),
																 name_ADDR3[1..5]='FMNL:' => REGEXFIND('^FMNL:(.*) (.*) (.*) (.*)$',name_ADDR3,3),
																 '');
		tempContactSName			:= MAP(name_ADDR1[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR1,4),
																 name_ADDR1[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR1,3),
																 name_ADDR2[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR2,4),
																 name_ADDR2[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR2,3),
																 name_ADDR3[1..5]='FMLS:' => REGEXFIND('^FMLS:(.*) (.*) (.*) (.*)$',name_ADDR3,4),
																 name_ADDR3[1..4]='FLS:'  => REGEXFIND('^FLS:(.*) (.*) (.*)$',name_ADDR3,3),
																 '');
		clean1Addr1						:= removeNameFromAddress(prepADDR_ADDR1, name_ADDR1);
		clean1Addr2						:= removeNameFromAddress(prepADDR_ADDR2, name_ADDR2);
		clean1Addr3						:= removeNameFromAddress(prepADDR_ADDR3, name_ADDR3);

		//When the address fields contain more than 1 name, extraNameInfo is used to store them.
		extraNameInfo					:= MAP(clean1Addr2='J&J VISION CARE, UK' => 'J&J VISION CARE, UK',
		                             REGEXFIND('GM SHANGHAI', clean1Addr1) => 'GM SHANGHAI',
		                             clean1Addr3='BRIANA BRUMER' => 'BRIANA BRUMER',
																 clean1Addr2='MCCOLGAN' => 'MCCOLGAN',
																 clean1Addr2='/ CARPE DIEM MGMT' => '/ CARPE DIEM MGMT',
																 '');
		
		cleanedAddr1					:= MAP(REGEXFIND('^[0-9 ]+$',clean1Addr1) AND clean1Addr2!=''
																   => clean1Addr1+' '+clean1Addr2,			//combine line 1 and 2 if line1 has digits only
																 clean1Addr1=extraNameInfo => '',
																 REGEXFIND(TRIM(extraNameInfo), clean1Addr1) => TRIM(REGEXREPLACE(TRIM(extraNameInfo), clean1Addr1, '')),
																 clean1Addr1);
		cleanedAddr2					:= MAP(REGEXFIND('^[0-9 ]+$',clean1Addr1) AND clean1Addr2!='' =>'',
																 TRIM(clean1Addr2)=TRIM(extraNameInfo) => '',
																 clean1Addr2);
		cleanedAddr3					:= MAP(clean1Addr3=extraNameInfo => '',
		                             clean1Addr3);
		
		preADDR_ADDR1_1				:= MAP(cleanedAddr1='' AND cleanedAddr2='' => cleanedAddr3,
																 cleanedAddr1='' AND cleanedAddr2<>'' => cleanedAddr2,
																 cleanedAddr1);
		preADDR_ADDR2_1				:= MAP(preADDR_ADDR1_1='' => '',
																 cleanedAddr2=preADDR_ADDR1_1 => cleanedAddr3,
																 cleanedAddr2='' AND cleanedAddr3<>'' AND cleanedAddr3<>preADDR_ADDR1_1 => cleanedAddr3,
																 cleanedAddr2);
		preADDR_ADDR3_1				:= MAP(cleanedAddr3=preADDR_ADDR1_1 => '',
																 cleanedAddr3=preADDR_ADDR2_1 => '',
																 cleanedAddr3);

		 // self.provnote_3 := pInput.address_line1 + '|' + pInput.address_line2 + '|' + pInput.address_line3 +  '|' +
		                    // name_ADDR1 + '|' + name_ADDR2 + '|' + name_ADDR3 + 
												// '|prepADDR_ADDR1='+prepADDR_ADDR1+'|name_ADDR1='+name_ADDR1+'|clean1Addr1='+clean1Addr1 + 
												// '|prepADDR_ADDR2='+prepADDR_ADDR2+'|name_ADDR2='+name_ADDR2+'|clean1Addr2='+clean1Addr2 + 
												// '|clean1Addr1='+clean1Addr1 +
											  // '|extraNameInfo='+extraNameInfo+'|cleanedAddr1='+cleanedAddr1;
																 
/* 		self.provnote_2 := IF(tempCompanyName<>'' OR tempContactFName<>'' OR tempContactMName<>'' OR
   		                      tempContactLName<>'' OR tempContactSName<>'' OR tempContactNName<>'',
   													tempCompanyName+'|'+tempContactFName+'|'+ tempContactMName+'|'+tempContactLName+'|'+tempContactSName+'|'+tempContactNName,
   													'');
*/
		
		//Identifying Contact/Office Information
		getOFFICE							:= MAP(tempTypeCd = 'MD' AND REGEXFIND('^([0-9 ][^C/O]+)[ ](C/O[ ][A-Za-z ]+)',prepADDR_ADDR1) 
		                               => REGEXFIND('^([0-9 ][^C/O]+)[ ](C/O[ ][A-Za-z ]+)',prepADDR_ADDR1,2),
																 tempTypeCD = 'MD' AND REGEXFIND('^([0-9 ][^ATTN:]+)[ ](ATTN:[ ][A-Za-z ]+)',prepADDR_ADDR1)
																   => REGEXFIND('^([0-9 ][^ATTN:]+)[ ](ATTN:[ ][A-Za-z ]+)',prepADDR_ADDR1,2),
																 tempTypeCd = 'MD' AND REGEXFIND('^([(]?[Cc][/][Oo][)]?|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[%]|[(]?[T][/][A][)]?)',prepADDR_ADDR1)
																	 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR1),
																 tempTypeCd = 'MD' AND REGEXFIND(COMPANY_IND,prepADDR_ADDR1)
																   => prepADDR_ADDR1,
																 tempTypeCd = 'MD' AND REGEXFIND('^([(]?[Cc][/][Oo][)]?|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[%]|[(]?[T][/][A][)]?)',prepADDR_ADDR2)
																	=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR2),
																 tempTypeCd = 'MD' AND REGEXFIND(COMPANY_IND,prepADDR_ADDR2)
																   => prepADDR_ADDR2,
																 tempTypeCd = 'MD' AND REGEXFIND('^([(]?[Cc][/][Oo][)]?|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[%]|[(]?[T][/][A][)]?)',trimADDR_ADDR3)
																	=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimADDR_ADDR3),
																 tempTypeCd = 'MD' AND REGEXFIND(COMPANY_IND,trimADDR_ADDR3)
																   => trimADDR_ADDR3,
																 '');
		tmpNAME_OFFICE  := MAP(trimNAME_OFFICE = '' and trimNAME_DBA != ' ' and tempTypeCd = 'MD' => trimNAME_DBA,
								 trimNAME_OFFICE = '' and trimNAME_DBA = '' and tempTypeCd = 'MD' => getOFFICE,
													trimNAME_OFFICE); 
		
		tempNAME_OFFICE			:= MAP(StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'D/R/A',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'D/R/A ','DBA '),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'T/A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'T/A ',''),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'T/ A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'T/ A ',''),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'T\\A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'T\\A ',''),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'C/O',1)>0 => StringLib.StringFindReplace(tmpNAME_OFFICE,'C/O',''),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'/',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'/',' '),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'\\',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'\\',' '),
									 StringLib.stringfind(TRIM(tmpNAME_OFFICE,LEFT,RIGHT),'INDIVIDUAL',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE,'INDIVIDUAL',''),
																			tmpNAME_OFFICE);
		cleanNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempNAME_OFFICE);
		
		getOFFICE1 						:= IF(tempTypeCd='MD' AND cleanedCompanyName<>'',cleanedCompanyName,'');
		tmpNAME_OFFICE1  			:= MAP(trimNAME_OFFICE = '' and trimNAME_DBA != ' ' and tempTypeCd = 'MD' => trimNAME_DBA,
																 trimNAME_OFFICE = '' and trimNAME_DBA = '' and tempTypeCd = 'MD' => getOFFICE1,
																 trimNAME_OFFICE);
		tmpPROVNOTE_2					:= IF(getOFFICE1<>'' AND tmpNAME_OFFICE1<>getOFFICE1,
																getOFFICE1 + ';',
																'') + 
														 IF(extraNameInfo<>'',TRIM(extraNameInfo,LEFT,RIGHT)+';','');	
		SELF.PROVNOTE_2				:= IF(TRIM(tmpPROVNOTE_2,LEFT,RIGHT)<>'',
		                            'CONTACT INFO FROM ADDR:' + REGEXREPLACE('^/ ',tmpPROVNOTE_2,''),
																'');
		tempNAME_OFFICE1			:= MAP(StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'D/R/A',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'D/R/A ','DBA '),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'T/A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'T/A ',''),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'T/ A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'T/ A ',''),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'T\\A ',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'T\\A ',''),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'C/O',1)>0 => StringLib.StringFindReplace(tmpNAME_OFFICE1,'C/O',''),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'/',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'/',' '),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'\\',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'\\',' '),
																 StringLib.stringfind(TRIM(tmpNAME_OFFICE1,LEFT,RIGHT),'INDIVIDUAL',1)> 0 => stringlib.stringfindreplace(tmpNAME_OFFICE1,'INDIVIDUAL',''),
																 tmpNAME_OFFICE1);		
		cleanNAME_OFFICE1			:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempNAME_OFFICE1);
		
		self.NAME_OFFICE			:= MAP(StringLib.stringfind(TRIM(cleanNAME_OFFICE1,LEFT,RIGHT),'JUDY B SPAKE DBA',1)> 0 => StringLib.StringFindReplace(cleanNAME_OFFICE1,'JUDY B SPAKE DBA','JUDY B SPAKE'),
																 StringLib.stringfind(TRIM(cleanNAME_OFFICE1,LEFT,RIGHT),'DBA',1)> 0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(cleanNAME_OFFICE1),
																 StringLib.stringfind(TRIM(cleanNAME_OFFICE1,LEFT,RIGHT),' AKA ',1)> 0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(cleanNAME_OFFICE1),
																 TRIM(cleanNAME_OFFICE1,all) = TRIM(SELF.name_first,all) + TRIM(SELF.name_last,all) => '',
																 TRIM(cleanNAME_OFFICE1,all) = TRIM(SELF.name_first,all) + TRIM(SELF.name_mid,all) + TRIM(SELF.name_last,all) => '',
																 TRIM(cleanNAME_OFFICE1,all) = TRIM(SELF.name_last,all) + TRIM(SELF.name_first,all) => '',
																 TRIM(cleanNAME_OFFICE1) = TRIM(SELF.NAME_ORG) => '',
																 TRIM(cleanNAME_OFFICE1) = TRIM(TrimNAME_ORG) => '',
																 stringlib.stringcleanspaces(cleanNAME_OFFICE1));

/* 		self.NAME_OFFICE		:= MAP(StringLib.stringfind(TRIM(cleanNAME_OFFICE,LEFT,RIGHT),'JUDY B SPAKE DBA',1)> 0 => StringLib.StringFindReplace(cleanNAME_OFFICE,'JUDY B SPAKE DBA','JUDY B SPAKE'),
   										StringLib.stringfind(TRIM(cleanNAME_OFFICE,LEFT,RIGHT),'DBA',1)> 0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(cleanNAME_OFFICE),
   																			stringlib.stringcleanspaces(cleanNAME_OFFICE));
*/
										
		self.OFFICE_PARSE		:= MAP(self.NAME_OFFICE = ' ' => ' ',
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(self.NAME_OFFICE) =>'GR',
										 // self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
										 // self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
										 self.NAME_OFFICE != ' ' and REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',self.NAME_OFFICE) => 'GR', 'MD');
		
		self.OFF_LICENSE_NBR 	:= pInput.office_lic_numr;
		
		// Reformatting dates from MM/DD/YYYY to YYYYMMDD
		SELF.CURR_ISSUE_DTE				:= IF(pInput.EFFC_DATE<>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EFFC_DATE),'17530101');
		// tempIssueDte        		:= IF(pInput.orig_lic_date != '',Prof_License_Mari.DateCleaner.norm_date3(pInput.orig_lic_date),
																// '');														
		// SELF.ORIG_ISSUE_DTE		:= IF(tempIssueDte != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(tempIssueDte),'17530101');	
		SELF.ORIG_ISSUE_DTE				:= IF(pInput.ORIG_LIC_DATE <>'',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ORIG_LIC_DATE),'17530101');
		// SELF.EXPIRE_DTE				:= IF(pInput.EXP_DATE != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXP_DATE),'17530101');
		tmpExpireDate 						:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EXP_DATE);
		SELF.EXPIRE_DTE 					:= IF(tmpExpireDate < '20000101','20' + tmpExpireDate[3..],tmpExpireDate);
		
				// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG		:= TrimNAME_ORG;
		//New MARI field - NAME_FORMAT																																		
		SELF.NAME_FORMAT			:= MAP(REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => 'F',
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => 'F',
																 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => 'F',
																 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => 'F',
																 tempTypeCd = 'GR' and mariParse = 'GR' => 'F',
																 //tempTypeCd = 'GR' and mariParse = 'MD' => 'F',
																 tempTypeCd = 'GR' and mariParse = 'MD' AND REGEXFIND('[A-Z \']+, ',rmvQuoteORG) => 'L',
																 tempTypeCd = 'GR' and mariParse = 'MD' => 'F',
																 tempTypeCd = 'MD' and mariParse = 'MD' => 'L',
																 tempTypeCd = 'MD' and mariParse = 'GR' => 'F',
																 /*'F'*/mariParse[1..1]);
		SELF.NAME_DBA_ORIG		:= trimNAME_DBA;
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG		:= MAP(SELF.TYPE_CD ='GR' => StdNAME_ORG,
																 SELF.TYPE_CD ='MD' => self.NAME_OFFICE,
																 ' '); 
		//The address clean up process has been redone due to too many names are still left in the address fields. 7/11/13 Cathy	
		// Filter out Contact Information
/* 		SELF.ADDR_ADDR1_1	  	:= MAP(REGEXFIND('^([0-9 ][^C/O]+)[ ](C/O[ ][A-Za-z ]+)',prepADDR_ADDR1) => REGEXFIND('^([0-9 ][^C/O]+)[ ](C/O[ ][A-Za-z ]+)',prepADDR_ADDR1,1),
   										 REGEXFIND('^([0-9 ][^ATTN:]+)[ ](ATTN:[ ][A-Za-z ]+)',prepADDR_ADDR1) => REGEXFIND('^([0-9 ][^ATTN:]+)[ ](ATTN:[ ][A-Za-z ]+)',prepADDR_ADDR1,1),
   										 REGEXFIND('^([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|%|T/A)',prepADDR_ADDR1)=> stringlib.stringcleanspaces(prepADDR_ADDR2),
   										 REGEXFIND(COMPANY_IND,prepADDR_ADDR1)=> stringlib.stringcleanspaces(prepADDR_ADDR2),
   										 StringLib.stringfind(prepADDR_ADDR1,'  ',1) >0 and REGEXFIND('^(([0-9A-Za-z]+ )*)[ ]{2,2}([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												and prepADDR_ADDR2 = '' => REGEXFIND('^(([0-9A-Za-z]+ )*)[ ]{2,2}([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,1),
   										 StringLib.stringfind(prepADDR_ADDR1,',',1) > 0 and REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1)
   												and prepADDR_ADDR2 = '' => REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,1),
   											 StringLib.stringfind(prepADDR_ADDR1,',',1) > 0 and REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												and prepADDR_ADDR2 = '' => REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,1),
   										 StringLib.stringfind(prepADDR_ADDR1,'/',1) >0 and REGEXFIND('^([0-9A-Za-z ][^\\/]+)/([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												and prepADDR_ADDR2 = '' => REGEXFIND('^([0-9A-Za-z ][^\\/]+)/([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,1),
   																							stringlib.stringcleanspaces(prepADDR_ADDR1));
   
   		self.ADDR_ADDR2_1	  	:= MAP(StringLib.stringfind(prepADDR_ADDR2,'SIDERA INC DBA KAT KATURA',1)>0 => StringLib.StringFindReplace(prepADDR_ADDR2,'SIDERA INC DBA KAT KATURA',''),
   										 REGEXFIND('^([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%]|T/A)',prepADDR_ADDR1)=> stringlib.stringcleanspaces(trimADDR_ADDR3),
   										 REGEXFIND(COMPANY_IND,prepADDR_ADDR2)=> stringlib.stringcleanspaces(trimADDR_ADDR3),
   										 StringLib.stringfind(prepADDR_ADDR1,'  ',1) >0 and REGEXFIND('^(([0-9A-Za-z]+ )*)[ ]{2,2}([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												 and prepADDR_ADDR2 = '' => REGEXFIND('^(([0-9A-Za-z]+ )*)[ ]{2,2}([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,3),
   										 StringLib.stringfind(prepADDR_ADDR1,',',1) > 0 and REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1)
   												 and prepADDR_ADDR2 = ''=> REGEXFIND('^([0-9A-Za-z ][^\\,]+),[ ]([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,2),
   										 StringLib.stringfind(prepADDR_ADDR1,',',1) > 0 and REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												 and prepADDR_ADDR2 = ''=> REGEXFIND('^([0-9A-Za-z ][^\\,]+),([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,2),
   										 StringLib.stringfind(prepADDR_ADDR1,'/',1) >0 and REGEXFIND('^([0-9A-Za-z ][^\\/]+)/([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1) 
   												 and prepADDR_ADDR2 = '' => REGEXFIND('^([0-9A-Za-z ][^\\/]+)/([\\#0-9A-Za-z \\.]*)',prepADDR_ADDR1,2),
   																								 stringlib.stringcleanspaces(prepADDR_ADDR2));
	
		self.ADDR_ADDR3_1	  	:= MAP(REGEXFIND('^([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])',prepADDR_ADDR1)=> ' ',
																 REGEXFIND('^([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%]|T/A| LLC)',prepADDR_ADDR2)=> ' ',
																 REGEXFIND(COMPANY_IND,trimADDR_ADDR3)=> ' ',
																 trimADDR_ADDR3);
*/
	
/* 		SELF.ADDR_ADDR1_1 		:= TRIM(StringLib.StringFilterOut(preADDR_ADDR1_1, '`'),LEFT,RIGHT);
   		SELF.ADDR_ADDR2_1 		:= TRIM(StringLib.StringFilterOut(preADDR_ADDR2_1, '`'),LEFT,RIGHT);
   		SELF.ADDR_ADDR3_1 		:= TRIM(StringLib.StringFilterOut(preADDR_ADDR3_1, '`'),LEFT,RIGHT);
   
   		self.ADDR_CITY_1		:= ut.CleanSpacesAndUpper(pInput.city);
   		self.ADDR_STATE_1	  	:= ut.CleanSpacesAndUpper(pInput.state);
   		 
   		tmpZIPCODE 			    := ut.CleanSpacesAndUpper(pInput.zip);
   		self.ADDR_ZIP5_1		:= tmpZIPCODE[1..5];
   		self.ADDR_ZIP4_1		:= tmpZIPCODE[7..10];
*/

		FOREIGN_COUNTRY_PATTERN := '(ARGENTINA|AUSTRALIA|BELGIUM|BERMUDA|CANADA|ENGLAND|GERMANY|' +
		                           'ONTARIO| ON 99|VANCOUVER|VIENNA|BAHIA BLANCA|WINNIPEG|TAKAPUNA AUCKLAND|' +
		                           'SASKATCHEWAN|SWITZERLAND|TORONTO|U K |UK | UK|UNITED KINGDOM)';
		FOREIGN_STATE_SET			:= ['99','-','AB',/*'FA', 'FE',*/ 'MB', 'NL', 'ON','BC','AB','QC'];			 
   	TrimCity							:= ut.CleanSpacesAndUpper(pInput.city);
   	tmpState	  					:= ut.CleanSpacesAndUpper(pInput.state); 
   	tmpZIP	 			    		:= ut.CleanSpacesAndUpper(pInput.zip);
		TrimZIP								:= MAP(tmpState NOT IN FOREIGN_STATE_SET AND LENGTH(tmpZIP)=3 => '00'+tmpZIP,
																 tmpState NOT IN FOREIGN_STATE_SET AND LENGTH(tmpZIP)=4 => '0'+tmpZIP,
																 tmpZIP);
		TrimState							:= MAP(tmpState='FA' AND TrimCity='ROYAL PALM BEACH' => 'FL',
		                             tmpState='FA' AND TrimCity='ENGLEWOOD' => 'FL', 
		                             tmpState='FA' AND TrimCity='BRADENTON' => 'FL', 
		                             tmpState='FA' AND TrimCity='JACKSONVILLE' => 'FL', 
	                               tmpState='FA' AND TrimCity='MIAMI BEACH' => 'FL', 
																 TrimZIP='00982' AND TrimCity='CAROLINA' => 'PR',
																 TrimZIP='00968' AND TrimCity='GUAYNABO' => 'PR',
																 TrimZIP='00969' AND TrimCity='GUAYNABO' => 'PR',
																 TrimZIP='00754' AND TrimCity='SAN LORENZO' => 'PR',
																 TrimZIP='00830' AND TrimCity='ST. JOHN' => 'VI',
																 TrimZIP='00830' AND TrimCity='CRUZ BAY' => 'VI',
																 TrimZIP='00956' AND TrimCity[1..7]='BAYAMON' => 'PR',
																 TrimZIP='00957' AND TrimCity[1..7]='BAYAMON' => 'PR',
																 TrimZIP[1..5]='00960' AND TrimCity[1..7]='BAYAMON' => 'PR',
																 TrimZIP='00976' AND TrimCity='TRUJILLO ALTO' => 'PR',
																 TrimZIP='09128' AND TrimCity='APO' => 'AE',
																 TrimZIP='96260' AND TrimCity[1..3]='APO' => 'AP',
															   TrimZIP='33330' AND TrimCity='DAVIE' => 'FL',
																 tmpState);

		prepAddr_Line_1				:= preADDR_ADDR1_1+' '+preADDR_ADDR2_1+' '+preADDR_ADDR3_1;
		prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TrimZIP;
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1,prepAddr_Line_2);
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
		SELF.OOC_IND_1				:= IF((REGEXFIND(FOREIGN_COUNTRY_PATTERN, TrimCity) AND TrimState NOT IN ['CA','FL','OH','NY','VA','WA']) OR
		                            (TrimState IN FOREIGN_STATE_SET AND (NOT REGEXFIND('(^APO |^APO$)',TrimCity) OR
																                                     ut.CleanSpacesAndUpper(pInput.county)<>'BROWARD' OR
																																		 TrimZIP<>'00982')) OR
		                           // (TrimState IN ['-','99'] AND REGEXFIND('(WOODBRIDGE, SUFFOLK|EASTBOURNE|ORANJESTAD|KEELUNG|' +
															//	                                       'BOURNE|ALLENWINDEN|ZURICH|LANAKEN-REKEM|STRASSEN|99|'+
															//																				 'KENT|CAMBRIDGE|DUBLIN|BEDFORD|LONDON|WIRRAL)',TrimCity)) OR
																(ut.CleanSpacesAndUpper(pInput.county)='FOREIGN' AND TrimState<>'FL') OR
																REGEXFIND('(^GERMANY$|^CANADA$)',preADDR_ADDR3_1) OR
																REGEXFIND('(HERZLIA ISRAEL|CALGARY, ALBERTA|ROUYN-NORANDA, CANADA|TORONTO CANADA|'+
																          'ONTARIO CANADA|AURORA ONTARIO|BINGENHEIM GERMANY|HOMBURG GERMANY)', prepAddr_Line_1),
																1,
																0);										 

		//Populate address fields
		SELF.ADDR_ADDR1_1			:= MAP(SELF.OOC_IND_1=1 
		                               => preADDR_ADDR1_1,
		                             AddrWithContact != '' and tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' AND tmpADDR_ADDR2_1<>''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1='' AND prepAddr_Line_1<>''
																   => StringLib.StringCleanSpaces(prepAddr_Line_1),																 
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(SELF.OOC_IND_1=1 
		                               => preADDR_ADDR2_1,
																 AddrWithContact!='' => '',
																 TRIM(clnAddress[1..125])='' AND (TrimState in FOREIGN_STATE_SET OR SELF.OOC_IND_1=1)
																 AND TRIM(prepAddr_Line_2,LEFT,RIGHT)<>'0'
																   => prepAddr_Line_2,
																 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
	  SELF.ADDR_ADDR4_1			:= IF(SELF.OOC_IND_1=1,
		                            StringLib.StringCleanSpaces(TrimCity + ' ' + TrimState + ' ' + TrimZip), 
																'');
		SELF.ADDR_ADDR3_1			:= preADDR_ADDR3_1;
		SELF.ADDR_CITY_1			:= MAP(SELF.OOC_IND_1=1 => '',
		                             TRIM(clnAddress[65..89])='' => TrimCity,
																 TRIM(clnAddress[65..89]));
		SELF.ADDR_STATE_1			:= MAP(SELF.OOC_IND_1=1 => '',
		                             TRIM(clnAddress[115..116])='' => TrimState,
																 TRIM(clnAddress[115..116]));
   	SELF.ADDR_ZIP5_1			:= MAP(SELF.OOC_IND_1=1 => '',
																 LENGTH(TRIM(clnAddress[117..121]))<>5 => TrimZIP,
		                             TRIM(clnAddress[117..121])='' => TrimZIP,
																 TRIM(clnAddress[117..121]));
   	SELF.ADDR_ZIP4_1			:= IF(SELF.OOC_IND_1=1,'',clnAddress[122..125]);
   //	SELF.OOC_IND_1				:= IF(REGEXFIND(' BERMUDA',prepAddr_Line_2) OR REGEXFIND(' UK',prepAddr_Line_2),1,0);    

		self.ADDR_CNTY_1        := ut.CleanSpacesAndUpper(pInput.county);
	
		//self.provnote_1 := trim(pInput.address_line1)+'|'+trim(pInput.address_line2)+'|'+trim(pInput.address_line3);
		//self.provnote_3 := prepAddr_Line_1+'|'+prepAddr_Line_2+'|'+trim(clnAddress[1..125])+'|'+TrimState;
		// assign business address indicator to true (B) if business address fields are not empty
		self.ADDR_BUS_IND	:= IF(TRIM(pInput.address_line1 + pInput.city + pInput.state + pInput.zip,LEFT,RIGHT) != '','B','');
		
		
/* 		// Business rules to identify contacts in ADDRESS field(s)	
    		AttnNAME		:= MAP(StringLib.stringfind(prepADDR_ADDR1,'ATTN',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR1),
      								 StringLib.stringfind(prepADDR_ADDR2,'ATTN',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR2),
      								 StringLib.stringfind(trimADDR_ADDR3,'ATTN',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimADDR_ADDR3),'');
      		
      		ContNAME		:= MAP(tempTypeCd != 'MD' AND REGEXFIND('^([Cc][/][Oo]|[%])',prepADDR_ADDR1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR1),
      								 tempTypeCd != 'MD' AND REGEXFIND('^([Cc][/][Oo]|[%])',prepADDR_ADDR2) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR2),
      								 tempTypeCd != 'MD' AND REGEXFIND('^([Cc][/][Oo]|[%])',trimADDR_ADDR3) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimADDR_ADDR3), '');
      									
      		
      		getCONTACT			:= MAP(tempTypeCd = 'GR' and ContNAME != '' => ContNAME, 
      									 tempTypeCd = ' ' and ContNAME != '' => ContNAME,
      									 tempTypeCd = 'MD' and  trimNAME_OFFICE != '' and trimNAME_DBA != '' => getOFFICE,
      												AttnNAME);
      									 
      		prepContact			:= IF(StringLib.stringfind(getCONTACT,',',1)>0,REGEXFIND('^([A-Za-z ][^\\,]+)',getCONTACT,1),getCONTACT);
      											
      		
      		stripTitle			:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => StringLib.StringFindReplace(prepContact,'RECEIVER',''),
      									 StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => StringLib.StringFindReplace(prepContact,'CONSERVATOR',''),
      									 StringLib.stringfind(prepContact,'BROKER',1)>0 => StringLib.StringFindReplace(prepContact,'BROKER',''),
      									 StringLib.stringfind(prepContact,'MNGR',1)>0 => StringLib.StringFindReplace(prepContact,'MNGR',''),
      									 StringLib.stringfind(prepContact,'GENERAL COUNSEL',1)>0 => StringLib.StringFindReplace(prepContact,'GENERAL COUNSEL',''),
      									 StringLib.stringfind(prepContact,'C/O',1)>0 => StringLib.StringFindReplace(prepContact,'C/O',''),
      									 StringLib.stringfind(prepContact,'CAPITAL',1) >0 => StringLib.StringFindReplace(prepContact,'CAPITAL',''),
      									 StringLib.stringfind(prepContact,'LEGAL DEPARTMENT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPARTMENT',''),
      									 StringLib.stringfind(prepContact,'LEGAL DEPT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT',''),
      									 StringLib.stringfind(prepContact,'LEGAL DEPT.',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT.',''),
      									 StringLib.stringfind(prepContact,'OFFICE',1) >0 => StringLib.StringFindReplace(prepContact,'OFFICE',''),
      									 StringLib.stringfind(prepContact,'A PARTNERSHIP',1) >0 => StringLib.StringFindReplace(prepContact,'A PARTNERSHIP',''),
      																prepContact);
      		
      		parseContact		:= MAP(getCONTACT != '' and StringLib.stringfind(TRIM(stripTitle,left,right),' ',1)< 1 => ' ',
      									 getCONTACT != '' and NOT Prof_License_Mari.func_is_company(stripTitle) => datalib.NameClean(stripTitle),
      																					' ');
   
   		self.NAME_CONTACT_FIRST := TRIM(parseContact[1..15],left,right);
   		self.NAME_CONTACT_MID	:= TRIM(parseContact[41..56],left,right);
   		self.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],left,right);
   		self.NAME_CONTACT_SUFX	:= TRIM(parseContact[131..134],left,right);
   		self.NAME_CONTACT_TTL	:= MAP(StringLib.stringfind(GetContact,'RECEIVER',1)>0 => 'RECEIVER',
   										StringLib.stringfind(GetContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
   										StringLib.stringfind(GetContact,'BROKER',1)>0 => 'BROKER',
   										StringLib.stringfind(GetContact,'MNGR',1)>0 => 'MNGR',
   										'');
*/

		self.NAME_CONTACT_FIRST := Prof_License_Mari.mod_clean_name_addr.strippunctName(tempContactFName);
		self.NAME_CONTACT_MID	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempContactMName);
		self.NAME_CONTACT_LAST := Prof_License_Mari.mod_clean_name_addr.strippunctName(tempContactLName);
		self.NAME_CONTACT_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempContactSName);
		self.NAME_CONTACT_NICK	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tempContactNName);

				// Business rules to standardize DBA(s) for splitting into multiple records
/* 		getDBA		:= MAP(tempTypeCd != 'MD' AND REGEXFIND('DBA',prepADDR_ADDR1)
   									=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR1),
   								 tempTypeCd != 'MD' AND REGEXFIND('DBA',prepADDR_ADDR2)
   									=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepADDR_ADDR2),
   								 tempTypeCd != 'MD' AND REGEXFIND('DBA',trimADDR_ADDR3)
   									=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimADDR_ADDR3), '');
*/
		//Use existing logic to set get DBA	
		getDBA								:= IF(tempTypeCd!='MD', cleanedDBAName, '');
		
		tempDBA2      				:= MAP(StringLib.stringfind(TRIM(trimNAME_DBA,LEFT,RIGHT),'DBA',1)> 0 => trimNAME_DBA,
																 StringLib.stringfind(TRIM(trimNAME_DBA,LEFT,RIGHT),'D/R/A',1)> 0 => trimNAME_DBA,
																 tempTypeCd != 'MD' and getDBA != '' => getDBA,
																 trimNAME_DBA  = trimNAME_OFFICE or trimNAME_DBA = TrimNAME_ORG
																 OR tmpNAME_OFFICE1 = trimNAME_DBA => '',
																 trimNAME_DBA);
										
		prepNAME_DBA 					:= MAP(StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'D/R/A',1)> 0 => stringlib.stringfindreplace(tempDBA2,'D/R/A ','DBA '),
																 StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'T/A ',1)> 0 => stringlib.stringfindreplace(tempDBA2,'T/A ',''),
																 StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'T/ A ',1)> 0 => stringlib.stringfindreplace(tempDBA2,'T/ A ',''),
																 StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'T\\A ',1)> 0 => stringlib.stringfindreplace(tempDBA2,'T\\A ',''),
																 StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'\\',1)> 0 => stringlib.stringfindreplace(tempDBA2,'\\',' '),
																 StringLib.stringfind(TRIM(tempDBA2,LEFT,RIGHT),'INDIVIDUAL',1)> 0 => stringlib.stringfindreplace(tempDBA2,'INDIVIDUAL',''),
																 tempDBA2);
		
		StripDBA			:= IF(REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',prepNAME_DBA),
												 REGEXREPLACE('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',
													prepNAME_DBA, '/ '),prepNAME_DBA);
													
		// Populate if DBA exist in ORG_NAME field			
/* 		self.dba			:= MAP(tempTypeCd = 'MD' and  tmpNAME_OFFICE != getOFFICE => getOFFICE,
   									 stripTitle !='' and parseContact = '' => stripTitle,''); 
*/
 		self.dba			:= IF(StringLib.stringfind(TRIM(cleanNAME_OFFICE1,LEFT,RIGHT),' AKA ',1)> 0, Prof_License_Mari.mod_clean_name_addr.GetDBAName(cleanNAME_OFFICE1),
												IF(tempTypeCd = 'MD' and  tmpNAME_OFFICE1 != getOFFICE1, getOFFICE1,''));
 		
		self.dba1			:= MAP(StringLib.stringfind(StripDBA,'RE/MAX',1) > 0 => StripDBA,
									 StringLib.stringfind(StripDBA,'RE/QUEST',1) > 0 => StripDBA,
									 StringLib.stringfind(StripDBA,'M/I',1) > 0 => StripDBA,
									 StringLib.stringfind(StripDBA,'M/I',1) > 0 => StripDBA,
									 StringLib.stringfind(StripDBA,'K/C ENTERPRISES',1) > 0 => StripDBA,
									 StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,',',1) > 0 
											and trimNAME_OFFICE != ' '=> REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ' '=>
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ' ' =>
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,'/',1) > 0 and trimNAME_OFFICE != ''
											AND REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA) => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
									 StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ''
											AND REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA) => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
									 StringLib.stringfind(StripDBA,'/',1) > 0 and trimNAME_OFFICE = ''
											AND REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA) => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE = ''
											AND REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA) => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																															StripDBA);

		
		self.dba2			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ' '=>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ' '=>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
											 StringLib.stringfind(StripDBA,'/',1) > 0 and trimNAME_OFFICE != ' '
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA)=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
									 StringLib.stringfind(StripDBA,';',1) > 0 and trimNAME_OFFICE != ' '
										and REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA) => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
																						 ' ');
					
		self.dba3 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									 StringLib.stringfind(StripDBA,'/',2) > 0 =>
									REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																							'');
		
		self.dba4 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									 StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
									 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									 StringLib.stringfind(StripDBA,'/',3) > 0 =>
									REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																							 '');
		
		self.dba5 			:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
									REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');
											
		// Expected codes [CO,BR,IN]
		self.AFFIL_TYPE_CD		:= MAP(TRIM(tempStdLicType,left,right) = '25BO' => 'BR',
										 self.type_cd = 'MD'=> 'IN',
										 self.type_cd = 'GR' => 'CO',' ');
			 
		self.mltreckey		:= MAP(trim(self.dba,left,right) != ' ' and trim(self.dba1,left,right) != ' ' 
										and trim(self.dba,left,right) != trim(self.dba1,left,right) =>
																				hash64(trim(self.license_nbr,left,right) 
																						+trim(self.std_license_type,left,right)
																						+trim(self.std_source_upd,left,right)
																						+trim(trimNAME_DBA,left,right)
																						+trim(trimADDR_ADDR1,left,right)
																						+trim(trimADDR_ADDR2,left,right)
																						+trim(trimADDR_ADDR3,left,right)
																						+ut.CleanSpacesAndUpper(pInput.CITY)
																						+ut.CleanSpacesAndUpper(pInput.STATE)
																						+ut.CleanSpacesAndUpper(pInput.ZIP)),
																						
									trim(self.dba1,left,right) != ' ' and trim(self.dba2,left,right) != ' ' 
										and trim(self.dba1,left,right) != trim(self.dba2,left,right) =>
																	hash64(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(trimNAME_DBA,left,right)
																			+trim(trimADDR_ADDR1,left,right)
																			+trim(trimADDR_ADDR2,left,right)
																			+trim(trimADDR_ADDR3,left,right)
																			+ut.CleanSpacesAndUpper(pInput.CITY)
																			+ut.CleanSpacesAndUpper(pInput.STATE)
																			+ut.CleanSpacesAndUpper(pInput.ZIP)),0);

		//self.cmc_slpk         := hash32(//trim(self.LICENSE_NBR,left,right)
		//ut.CleanSpacesAndUpper(tempRawType)
		self.cmc_slpk         := HASH64(TRIM(self.LICENSE_NBR,left,right) + ' ,'
																		//Added per Terri's comment for BUG 124107
																		+trim(pInput.office_lic_numr,LEFT,RIGHT) + ' ,'
																		+trim(self.STD_LICENSE_TYPE,left,right) + ' ,'
																		+trim(self.STD_SOURCE_UPD,left,right) + ' ,'
																		//+trim(StringLib.StringToProperCase(StringLib.StringToLowerCase(self.NAME_ORG)),left,right) + ', '
																		//+trim(self.NAME_ORG,left,right) + ' ,'
																		//Use raw name field for office name - Terri's comment for BUG 124107
																		+TrimNAME_ORG + ' ,'
																		+trim(trimADDR_ADDR1,left,right) + ' ,'
																		+trim(trimADDR_ADDR2,left,right) + ' ,'
																		+trim(trimADDR_ADDR3,left,right) + ' ,'
																		+ut.CleanSpacesAndUpper(pInput.CITY) + ' ,'
																		+ut.CleanSpacesAndUpper(pInput.STATE) + ' ,'
																		+ut.CleanSpacesAndUpper(pInput.ZIP));
		
		SELF := [];		   		   
	END;


	//ds_map := project(prof_license_mari.file_FLS0280, transformToCommon(left));
	ds_map := project(ValidInFile, transformToCommon(left));					

	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas 		trans_lic_status(ds_map L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := JOIN(ds_map, Cmvtranslation,
								TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
									AND right.fld_name='LIC_STATUS',
								trans_lic_status(left,right),left outer,lookup);

	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 		trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
		//self.STD_PROF_CD := R.DM_VALUE1;
		//64MC has PROFCODE set to RLE. Overwrite this for now.
		self.STD_PROF_CD := IF(R.fld_value='64MC','APR',R.DM_VALUE1);
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);

	//std_license_type 64MC is not defined in cmvtranslation. Until it is defined we will overwrite it here
	maribase_plus_dbas 		set_std_prof_cd_64mc(ds_map_lic_trans L) := transform
		self.STD_PROF_CD := IF(L.STD_PROF_CD=' ',
													'RLE',
													L.STD_PROF_CD);
		self := L;
	end;

	//ds_map_lic_trans1 := project(ds_map_lic_trans,set_std_prof_cd_64mc(LEFT));
	ds_map_lic_trans1 := ds_map_lic_trans;

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_source_desc(affil_type_cd='CO');
	company_only_lookup := ds_map_lic_trans1(affil_type_cd='CO');

	//maribase_plus_dbas 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	maribase_plus_dbas 	assign_pcmcslpk(ds_map_lic_trans1 L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	//ds_map_affil := join(ds_map_source_desc, company_only_lookup,
	ds_map_affil := join(ds_map_lic_trans1, company_only_lookup,
							TRIM(left.name_org[1..50],left,right)	= TRIM(right.name_org[1..50],left,right)
							AND left.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(left,right),left outer,lookup);																		

	maribase_plus_dbas 	xTransPROVNOTE(ds_map_affil L) := transform
 		self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
   								TRIM(L.provnote_1,left,right)+ '|' + 'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',
   								 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
   								'THIS IS NOT A MAIN OFFICE.  IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.',L.PROVNOTE_1);
		self := L;
	end;

	OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

	// Normalized DBA records
	maribase_dbas := record,maxlength(5000)
		maribase_plus_dbas;
		string60 tmp_dba;
	end;

	//maribase_dbas	NormIT(ds_map_source_desc L, INTEGER C) := TRANSFORM
	maribase_dbas	NormIT(OutRecs L, INTEGER C) := TRANSFORM
			self := L;
		self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	//NormDBAs 	:= DEDUP(NORMALIZE(ds_map_source_desc,6,NormIT(left,counter)),all,record);
	NormDBAs 	:= DEDUP(NORMALIZE(OutRecs,6,NormIT(left,counter)),all,record);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;


	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layout_base_in xTransToBase(FilteredRecs L) := transform
			self.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
		
		tmpNAME_DBA			:=MAP(StringLib.stringfind(L.TMP_DBA,'C/O',1) > 0 => StringLib.StringCleanspaces(stringlib.stringfindreplace(L.TMP_DBA,'C/O','')),
									 StringLib.stringfind(L.TMP_DBA,'\\',1) > 0 => StringLib.StringCleanspaces(stringlib.stringfindreplace(L.TMP_DBA,'\\',' ')),
									 StringLib.stringfind(L.TMP_DBA,'/',1) > 0 => StringLib.StringCleanspaces(stringlib.stringfindreplace(L.TMP_DBA,'/',' ')),
									 StringLib.stringfind(L.TMP_DBA,'"',1) > 0 => StringLib.StringCleanspaces(StringLib.StringFilterOut(L.TMP_DBA, '"')),
																L.TMP_DBA);
		
			
		StdNAME_DBA			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_DBA);
		CleanNAME_DBA		:= MAP(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => StdNAME_DBA,
											 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
											 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
											 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
											 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
																		Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		
		tmpDBA_SUFX		:= MAP(NOT REGEXFIND('LLP',StdNAME_DBA) and REGEXFIND('(LP)$',StdNAME_DBA) and L.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_DBA,1),
											 REGEXFIND('(L[.]P[.])$',StdNAME_DBA) and L.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',StdNAME_DBA,1),
											 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => '',
											 REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => '',
																					Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 					
		
		self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
		self.NAME_DBA		:= CleanNAME_DBA;
		self.NAME_DBA_SUFX	:= StringLib.StringFilterOut(tmpDBA_SUFX, '.'); 
		self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
		self.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => StdNAME_DBA,
									 L.type_cd = 'MD' => StdNAME_DBA, ''); 
		
		self.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '.'),
											 StringLib.stringfind(L.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, ','),
											 // StringLib.stringfind(L.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '#'),	
																																						 L.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '.'),
											 StringLib.stringfind(L.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, ','),
											 StringLib.stringfind(L.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '#'),	
																																						 L.ADDR_ADDR2_1);
			
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '.'),
											 StringLib.stringfind(L.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, ','),
											 StringLib.stringfind(L.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '#'),	
																																						 L.ADDR_ADDR3_1);
		
		self := L;
	end;

	ds_map_base := project(FilteredRecs, xTransToBase(left));
	
	//remove dup records
 ds_map_deduped := dedup(sort(distribute(ds_map_base,hash(cmc_slpk,name_org,license_nbr,std_license_type,addr_addr1_1)),record,local),record,all,local);


	d_final 			:= output(ds_map_deduped, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
			
	// add_super 		:= sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_deduped);
	
	move_to_used	:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'lic64', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 're1', 'using', 'used'),
														// Prof_License_Mari.func_move_file.MyMoveFile(code, 're2', 'using', 'used'),
														// Prof_License_Mari.func_move_file.MyMoveFile(code, 're3', 'using', 'used'),
														// Prof_License_Mari.func_move_file.MyMoveFile(code, 're4', 'using', 'used'),
														// Prof_License_Mari.func_move_file.MyMoveFile(code, 're5', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'corp', 'using', 'used')
														);


	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);

	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, Olic64, Ore, Ocorp, Ocmv, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;
