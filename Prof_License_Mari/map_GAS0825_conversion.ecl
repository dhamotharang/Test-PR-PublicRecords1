// Purpose : map Georgia Real Estate Commission & Appraisers Board / Multiple Professions raw data to common layout for MARI and PL use
// Source file location - \\Tapeload02b\k\professional_licenses\mari\ga\georgia_real_estate_professionals_(en)
//                        \\Tapeload02b\k\professional_licenses\mari\ga\georgia_real_estate_appraisers_(en)
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_GAS0825_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'GAS0825';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move input file from sprayed to using
	move_to_using := PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr_actv', 'sprayed', 'using'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr_inact', 'sprayed', 'using'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rebk_actv', 'sprayed', 'using'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rebk_inact', 'sprayed', 'using'));

	//input files
	apr      						:= Prof_License_Mari.files_GAS0825.apr;
	re_act	  					:= Prof_License_Mari.files_GAS0825.re_active;
	re_inact						:= Prof_License_Mari.files_GAS0825.re_inactive;
	
	out_apr							:= output(apr);
	out_re_act					:= output(re_act);
	out_re_inact				:= output(re_inact);
	
	//Must complete moving files from sprayed to using first
	//sequential(move_to_using,apr,re_act,re_inact);

	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD=src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';

	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';


	//***********Combine files into one common layout******************
	// apr to common
	Prof_License_Mari.layout_GAS0825.common map_apr(Prof_License_Mari.layout_GAS0825.apr L) := TRANSFORM
		self.comp_name		        := ' ';
		self.off_slnum		        := ' ';
		self.qual_broker_lic_numr	:= ' ';
		self.comp_org_form	      	:= ' ';
		self.comp_address1		    := ' ';
		self.comp_address2        	:= ' ';
		self.comp_address3        	:= ' ';
		self.comp_city            	:= ' ';
		self.comp_state           	:= ' ';
		self.comp_zip             	:= ' ';
		self.comp_zip4            	:= ' ';
		self.comp_county          	:= ' ';
		self.comp_status          	:= ' ';
		self.comp_renew_due_date  	:= ' ';
		self.prof                 	:= 'APPRAISER';
		self	:= L;
	END;

	aprCommon	:= project(apr, map_apr(left));

	//Remove bad records before processing
	ValidApr	:= aprCommon(TRIM(first_name,left,right)+trim(last_name,left,right) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
											

	// re active to common
	Prof_License_Mari.layout_GAS0825.common map_re_act(Prof_License_Mari.layout_GAS0825.re_active L) := TRANSFORM
		self.lic_issue_date := ' ';
		self.prof           := 'REAL ESTATE';
		self	:= L;
	END;

	re_act_common	:= project(re_act, map_re_act(left));
	//Remove bad records before processing
	ValidRE_act	:= re_act_common(TRIM(first_name,left,right)+trim(last_name,left,right) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(first_name))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(last_name)));
											
	// re inactive to common
	Prof_License_Mari.layout_GAS0825.common map_re_inact(Prof_License_Mari.layout_GAS0825.re_inactive L) := TRANSFORM
		self.lic_type             	:= ' ';
		self.comp_name		        := ' ';
		self.off_slnum		        := ' ';
		self.qual_broker_lic_numr	:= ' ';
		self.comp_org_form	      	:= ' ';
		self.comp_address1		    := ' ';
		self.comp_address2        	:= ' ';
		self.comp_address3        	:= ' ';
		self.comp_city            	:= ' ';
		self.comp_state           	:= ' ';
		self.comp_zip             	:= ' ';
		self.comp_zip4            	:= ' ';
		self.comp_county          	:= ' ';
		self.comp_status          	:= ' ';
		self.comp_renew_due_date  	:= ' ';
		self.prof                 	:= 'REAL ESTATE';
		self	:= L;
	END;

	re_inact_common	:= project(re_inact, map_re_inact(left));
	//Remove bad records before processing
	ValidRE_inact	:= re_inact_common(TRIM(first_name,left,right)+trim(last_name,left,right) != ' ' 
											AND TRIM(lic_status,left,right) <> ' '
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));										

	// combine common layout files
	ValidFile	:= ValidApr + ValidRE_act + ValidRE_inact;

	//Pattern for DBA
		DBAType	:= '(DBA |D/B/A |C/O |ATTN: |ATTN )';
		DBATypeAddl	:= '(ATT |CARE OF)';

	maribase_plus_dbas := record,maxlength(5000)
		Prof_License_Mari.layouts.base;
		string60 dba;
		string60 dba1;
		string60 dba2;
		string60 dba3;
		string60 dba4;
		string60 dba5;
	end;


	//GA real estate and appraisers to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_GAS0825.common pInput) := TRANSFORM
	
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
		
		tempLicNum       			:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_numr);
		self.LICENSE_NBR			:= tempLicNum;
		self.LICENSE_STATE		:= src_st;
		self.RAW_LICENSE_STATUS := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_status);
		self.OFF_LICENSE_NBR 	:= pInput.off_slnum;
		
		// initialize raw_license_type from raw data
		tempRawType 					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_type);
		self.RAW_LICENSE_TYPE := tempRawType;
																																		
		// map raw license type to standard license type before profcode translations
		tempStdLicType 				:= map(tempRawType = ' ' => 'RLEIND',
																 pInput.prof = 'APPRAISER' and tempRawType != ' ' => 'APR'+tempRawType,
																 pInput.prof = 'REAL ESTATE' and tempRawType != ' ' => 'RLE'+tempRawType, 
																 '');
																 
		self.STD_LICENSE_TYPE := tempStdLicType;
		
		// assigning type code based on license type
		tempTypeCd						:= 'MD';
		self.TYPE_CD      		:= tempTypeCd;
		
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= map(tempTypeCd = 'MD' => 'MD',
																 tempTypeCd = 'GR' => 'GR',
																 ' ');
																
		trimLName							:= stringlib.stringcleanspaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.last_name));
		trimFName							:= stringlib.stringcleanspaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.first_name));
		trimMName							:= stringlib.stringcleanspaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.middle_name));
		trimSuffix						:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.suffix);
		
		//Process nick names
		nickfirst							:= Prof_License_Mari.fGetNickname(trimFName,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(trimFName,'strip_nick');
		cleanFNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
		nicklast							:= Prof_License_Mari.fGetNickname(trimLNAME,'nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(trimLNAME,'strip_nick');
		cleanLNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick);
		nickmid								:= Prof_License_Mari.fGetNickname(trimMName,'nick');
		removeMNick						:= Prof_License_Mari.fGetNickname(trimMName,'strip_nick');
		cleanMNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick);
	
		tempNameOrg						:= IF(REGEXFIND('A/K/A',cleanLNAME),
		                            stringlib.stringcleanspaces(CleanMName+ ' '+ CleanFName),
		                            stringlib.stringcleanspaces(CleanLName+ ' '+ CleanFName));
		self.NAME_ORG 				:= stringlib.stringcleanspaces(tempNameOrg);
		self.name_first 			:= cleanFNAME;
		self.name_mid   			:= IF(REGEXFIND('A/K/A',cleanLNAME),'',cleanMNAME);
		self.name_last  			:= IF(REGEXFIND('A/K/A',cleanLNAME),cleanMNAME,cleanLNAME);
		self.name_sufx				:= trimSuffix;											 	 
		// parse nick name
		stripNick							:= MAP(StringLib.stringfind(nicklast,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',nicklast,''),
																 nickfirst != '' => nickfirst,
																 nickmid != '' => nickmid,'');
		self.NAME_NICK				:= StringLib.StringCleanSpaces(stripNick);
							
		// Reformatting dates from MM/DD/YYYY to YYYYMMDD
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= IF(pInput.lic_issue_date != '' AND pInput.lic_issue_date[5..6] IN ['17','18','19','20'],
																pInput.lic_issue_date[5..8]+pInput.lic_issue_date[1..2]+pInput.lic_issue_date[3..4],
																'17530101');	
		self.EXPIRE_DTE				:= IF(pInput.expiration_date!='' AND pInput.expiration_date[5..6] IN ['17','18','19','20'],
																pInput.expiration_date[5..8]+pInput.expiration_date[1..2]+pInput.expiration_date[3..4],
																'17530101');
		
		// assign officename and office parse field : GR if company, MD if individual 
		tempOff1            	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.comp_name);
		tempOff2            	:= stringlib.stringfindreplace(tempOff1,' D/R/A ',' DBA ');
		tempOff3            	:= if(tempOff2[1..4]='T/A ',tempOff2[5..],tempOff2);  
																						
		// assign address fields from raw
		trimAddress1					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.address1);
		trimAddress2					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.address2);
		trimAddress3					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.address3);
		
		trimCompAddress1			:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_address1);
		trimCompAddress2			:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_address2);
		trimCompAddress3			:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_address3);
		
		//Filter out bad and duplicate addresses
		filterAddr1						:= MAP(REGEXFIND('^(SAME |(NONE)|FAX |XXXX|OFF FAX|CELL |LLLLL)',trimAddress1[1..5]) => '',
															 trimAddress1[1..3] = 'NA '=> '',
															 REGEXFIND(DBAType,trimAddress1) => '',
															 StringLib.stringfind(trimAddress1,'ADDRESS NOT TO BE GIVEN OUT UNDER ANY CIRCUMSTANCE',1) > 0 => '',
															 tempOff1 != '' and trimAddress1 != '' and tempOff1 = trimAddress1 => '',
																trimAddress1);
							 	
		filterAddr2	:= MAP(REGEXFIND('(SAME |NA  |(NONE)|FAX |OFF FAX |XXXX|CELL |LLLLL)',trimAddress2[1..5]) => '',
							 REGEXFIND('(X )',trimAddress2[1..2]) => '',
							 REGEXFIND(DBAType,trimAddress2) => '',
							 trimAddress1 != '' AND trimAddress2 != '' AND trimAddress1 = trimAddress2 => '',
							 trimAddress1 != '' AND trimAddress2 != '' AND trimAddress1[1..10] = trimAddress2[1..10] => '',
							 tempOff1 != '' and trimAddress2 != '' AND tempOff1 = trimAddress2 => '',
										trimAddress2);
		filterAddr3	:= MAP(REGEXFIND('(SAME |NA  |(NONE)|FAX |OFF FAX |XXXX |CELL |LLLLL)',trimAddress3[1..5]) => '',
								 REGEXFIND('(X )',trimAddress3[1..2]) => '',
								 REGEXFIND(DBAType,trimAddress3) => '',
								 trimAddress2 != '' AND trimAddress3 != '' AND trimAddress2 = trimAddress3 => '',
								 trimAddress1 != '' AND trimAddress3 != '' AND trimAddress1 = trimAddress3 => '',
								 trimAddress2 != '' AND trimAddress3 != '' AND trimAddress2[1..10] = trimAddress3[1..10] => '',
								 trimAddress1 != '' AND trimAddress3 != '' AND trimAddress1[1..10] = trimAddress3[1..10] => '',
								 
								 tempOff1 != '' and trimAddress3 != '' and tempOff1 = trimAddress3 => '',
									trimAddress3);
		
		//Indicates whether overflow data in address_1 is an address or business name	
		IsAddr_1			:= IF(StringLib.Stringfind(filterAddr1,'PO DRAWER',1) >0
								OR StringLib.Stringfind(filterAddr1,'P O BOX',1) >0
								OR StringLib.Stringfind(filterAddr1,'PO BOX',1) >0
								OR StringLib.Stringfind(filterAddr1,' DRIVE',1) >0
								OR StringLib.Stringfind(filterAddr1,' AVENUE ',1)>0 
								OR StringLib.Stringfind(filterAddr1,' LANE',1)>0
								OR StringLib.Stringfind(filterAddr1,' TRAIL',1)>0
								OR StringLib.Stringfind(filterAddr1,' DR ',1)>0
								OR StringLib.Stringfind(filterAddr1,' COURT',1)>0,
								true,
								false);
		
		
		//Indicates whether overflow data in address_2 is an address or business name	
		IsAddr			:= IF(StringLib.Stringfind(filterAddr2,' DRIVE',1) >0
								OR StringLib.Stringfind(filterAddr2,'PENTHOUSE ',1) >0
								OR StringLib.Stringfind(filterAddr2,'POINT',1) >0
								OR StringLib.Stringfind(filterAddr2,'NBR ',1) >0
								OR StringLib.Stringfind(filterAddr2,' AVENUE ',1)>0 
								OR StringLib.Stringfind(filterAddr2,' AVEUNUE',1)>0 
								OR StringLib.Stringfind(filterAddr2,'SUIT ',1)>0
								OR StringLib.Stringfind(filterAddr2,' TRACE',1)>0
								OR StringLib.Stringfind(filterAddr2,'CIRCLE ',1)>0
								OR StringLib.Stringfind(filterAddr2,' TRAIL',1)>0
								OR StringLib.Stringfind(filterAddr2,' DR',1)>0
								OR StringLib.Stringfind(filterAddr2[1..5],'SIDE ',1)>0
								OR StringLib.Stringfind(filterAddr2[1..5],'COURT',1)>0
								OR StringLib.Stringfind(filterAddr2[1..3],'PH ',1)>0
								OR StringLib.Stringfind(filterAddr2[1..3],'NE ',1)>0
								OR StringLib.Stringfind(filterAddr2[1..3],'NW ',1)>0
								OR StringLib.Stringfind(filterAddr2[1..3],'SE ',1)>0,
								true,
								false);
		//Filterout Whitespaces
		slamwsAddr1		:= StringLib.StringFilterOut(filterAddr1,' ');
		slamwsAddr2		:= StringLib.StringFilterOut(filterAddr2,' ');
		slamwsAddr3		:= StringLib.StringFilterOut(filterAddr3,' ');
		
		//Prepping Filtered Address Field for more verification
		prepAddress1	:= MAP(REGEXFIND('^(ONE |TWO |THREE |FOUR |FIVE |SIX |SEVEN |EIGHT |NINE |TEN |ELEVEN|TWELVE )',filterAddr1) => filterAddr1,
												 REGEXFIND('^([a-zA-z\\s]{2,})$',filterAddr1) AND NOT IsAddr_1 
														=> filterAddr1,
												 REGEXFIND('^([a-zA-z\\s]{2,})$',filterAddr1) AND NOT IsAddr_1 
														=> '',
												 REGEXFIND(' LLC$',filterAddr1) AND NOT IsAddr_1
														=> '',
												 filterAddr1 != '' AND Prof_License_Mari.func_is_address(filterAddr1)
														=> filterAddr1,
												 REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterAddr1) OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterAddr1) 
												    => filterAddr1,
												 ' ');

		prepAddress2	:= MAP(filterAddr1 != '' AND filterAddr2 != '' AND slamwsAddr1[1..10] = slamwsAddr2[1..10] => '',		
								 REGEXFIND('^(ONE |TWO |THREE |FOUR |TWELVE)',filterAddr2) => filterAddr2,
								 filterAddr2 != '' AND REGEXFIND('^[0-9]*$',filterAddr2) => '#' + filterAddr2,
								 filterAddr2 != '' AND Prof_License_Mari.func_is_address(filterAddr2) => filterAddr2,
								 REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterAddr2)
									OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterAddr2) => filterAddr2,
								 LENGTH(TRIM(filterAddr2,left,right)) = 1 => '#' + filterAddr2,
								 REGEXFIND('(?!^[0-9 ]*$)(?!^[a-zA-Z ]*$)^([a-zA-Z0-9 ]{1, })$',filterAddr2) => filterAddr2,
								 REGEXFIND('CO ',filterAddr2[1..3]) => '',
								 REGEXFIND('^([a-zA-z\\s]{2,})$',filterAddr2)
									AND IsAddr = TRUE => filterAddr2,
								 REGEXFIND('^([a-zA-z\\s]{2,})$',filterAddr2)
									AND IsAddr = FALSE => '',
													'');
								 
		prepAddress3	:= MAP(filterAddr1 != '' AND filterAddr3 != '' AND slamwsAddr1[1..10] = slamwsAddr3[1..10] => '',
								 filterAddr3!= '' AND REGEXFIND('^[0-9]*$',filterAddr3) => '#' + filterAddr3,
								 filterAddr3 != '' AND Prof_License_Mari.func_is_address(filterAddr3) => StringLib.StringCleanSpaces(filterAddr3),
								 REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterAddr3)
									OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterAddr3) => filterAddr3,'');


								
		//Obtaining OFFICE NAME from address field
		tmpADDR_OFFICE	:= MAP(REGEXFIND('^C/O (.*)$',filterAddr1)
															=> REGEXFIND('^C/O (.*)$',filterAddr1, 1),
													 REGEXFIND('^BOX ', filterAddr1)
															=> '',
													 REGEXFIND('^POBOX', filterAddr1)
															=> '',
											     REGEXFIND('^([a-zA-z\\s]{2,})$',filterAddr1) 
													 AND NOT REGEXFIND('^(ONE |TWO |THREE |FOUR )',filterAddr1)
													 AND IsAddr_1 != TRUE 
															=> filterAddr1,
													 REGEXFIND('^(1ST |2ND |3RD |4TH |5TH |6TH |7TH |8TH |9TH)',filterAddr1) 
															=> filterAddr1,
													 REGEXFIND('^(SECURE 21|THE CLAIREMONT 109|COLDWELL BANKER SUCCESS 2000|KELLER WILLIAMS REALTY 1ST ATL)',filterAddr1) => filterAddr1,
													 REGEXFIND('A/K/A',cleanLNAME)
															=> cleanLNAME,
													 '');
		
		//Populating NAME OFFICE Field
/* 		self.NAME_OFFICE	:= MAP(tempOff3 != ' ' and REGEXFIND('(DBA [A-Za-z \\/]+)$',trim(tempOff1))=> StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempOff1)),
   									 tempOff3 != ' ' and REGEXFIND('(DBA )',tempOff1) 
   										AND NOT REGEXFIND('(DBA [A-Za-z \\/]+)$',trim(tempOff1))=> stringlib.stringfindreplace(tempOff1,'DBA ',''),
   											StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpADDR_OFFICE)));
*/
 		prepOfficeName				:= MAP(tempOff3 != ' ' and REGEXFIND('(DBA [A-Za-z \\/]+)$',trim(tempOff1))
																		=> StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempOff1)),
																 tempOff3 != ' ' and REGEXFIND('(DBA )',tempOff1) 
																 AND NOT REGEXFIND('(DBA [A-Za-z \\/]+)$',trim(tempOff1))
																		=> stringlib.stringfindreplace(tempOff1,'DBA ',''),
																 StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpADDR_OFFICE)));

		SELF.NAME_OFFICE			:= IF(REGEXFIND('(A/K/A| DBA)',prepOfficeName),
		                            StringLib.StringCleanSpaces(REGEXREPLACE('(A/K/A| DBA)',prepOfficeName,'')),
																prepOfficeName);
		self.OFFICE_PARSE		:= MAP(self.NAME_OFFICE = ' ' => ' ',
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(self.NAME_OFFICE) =>'GR',
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
										 self.NAME_OFFICE != ' ' and StringLib.stringfind(TRIM(self.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
										 self.NAME_OFFICE != ' ' and REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',self.NAME_OFFICE) => 'GR', 'MD');		
		
		
		// assign two holders for raw data per mari business rules
		self.NAME_ORG_ORIG	:= StringLib.StringCleanSpaces(trimLName+' '+ trim(self.name_sufx,left,right)
									+' '+trimFName+' '+trimMName);
		SELF.NAME_FORMAT		:= 'L';
		self.NAME_DBA_ORIG	:= IF(REGEXFIND('(DBA [A-Za-z \\/]+)$',trim(tempOff1)),StringLib.StringCleanSpaces(tempOff1),'');
		
		// assign mari_org with semi-clean name data per business rules
		self.NAME_MARI_ORG	:= IF(tempTypeCd='MD',SELF.NAME_OFFICE,'');
		self.NAME_MARI_DBA	:= ' ';
		
		
		//Populate Address fields
		self.ADDR_BUS_IND	:= IF(TRIM(pInput.address1 + pInput.address2 + pInput.city + pInput.state + pInput.zip) != '','B','');
		
/* 		self.ADDR_ADDR1_1	:= IF(prepAddress1 = '' and prepAddress2 != '',StringLib.StringCleanSpaces(prepAddress2),
   									IF(prepAddress1 = '' and prepAddress2 = '' and prepAddress3 != '',StringLib.StringCleanSpaces(prepAddress3),
   													StringLib.StringCleanSpaces(prepAddress1)));
   													
   		self.ADDR_ADDR2_1	:= IF(prepAddress1 = '' and prepAddress2 != '' and prepAddress3 != '', StringLib.StringCleanSpaces(prepAddress3),
   									IF(prepAddress1 != '' and prepAddress2 = '' and prepAddress3 != '',StringLib.StringCleanSpaces(prepAddress3),
   										IF(prepAddress1 != '' and prepAddress2 != '',StringLib.StringCleanSpaces(prepAddress2),'')));
   										
   		self.ADDR_ADDR3_1		:= IF(prepAddress1 != '' and prepAddress2 != '',StringLib.StringCleanSpaces(prepAddress3),'');
   								
   		trimADDR_CITY_1	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.city);
   		self.ADDR_CITY_1   	:= IF(REGEXFIND('(SAME |NA  |(NONE)|FAX |OFF FAX |XXXX|CELL |LLLLL)',trimADDR_CITY_1[1..5]),'',trimADDR_CITY_1);
   									
   		self.ADDR_STATE_1  	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.state);
   		self.ADDR_ZIP5_1   	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.zip);
   		self.ADDR_ZIP4_1   	:= IF(StringLib.stringfind(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.zip4),'N/A',1) >0,
   											' ',Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.zip4));
*/

		TrimCity							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.city);
		TrimState							:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.state);
		TrimZip								:= TRIM(pInput.zip+pInput.zip4);
		//prepAddr_Line_1				:= preADDR_ADDR1_1+' '+preADDR_ADDR2_1+' '+preADDR_ADDR3_1;
		prepAddr_Line_1				:= TRIM(IF(tmpADDR_OFFICE=trimAddress1 OR REGEXFIND('(C/O |ATTENTION |ATTN )',prepAddress1),'',TRIM(prepAddress1)) + ' ' +
																  IF(REGEXFIND('(C/O |ATTENTION |ATTN )',prepAddress2),'',TRIM(prepAddress2)) + ' ' +
																  IF(REGEXFIND('(C/O |ATTENTION |ATTN )',prepAddress3),'',TRIM(prepAddress3)),LEFT,RIGHT);
		prepAddr_Line_2				:= TrimCity + ' ' + TrimState + ' ' + TrimZIP;
		clnAddress						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_1,prepAddr_Line_2);
//self.provnote_2 := prepAddr_Line_1+'|'+prepAddr_Line_2+'|'+clnAddress;
//self.provnote_3 := trimAddress1+'|'+trimAddress2+'|'+trimAddress3+'|'+prepAddr_Line_1+'|'+tmpADDR_OFFICE;
		tmpADDR_ADDR1_1				:= TRIM(clnAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnAddress[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnAddress[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

		SELF.ADDR_ADDR1_1			:= MAP(AddrWithContact != '' and tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact!='' => '',
																	 tmpADDR_ADDR2_1='' => '',
																 TRIM(tmpADDR_ADDR2_1)=TRIM(tmpADDR_ADDR1_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= IF(TRIM(clnAddress[65..89])='',TrimCity,TRIM(clnAddress[65..89]));
		SELF.ADDR_STATE_1			:= IF(TRIM(clnAddress[115..116])='',TrimState,TRIM(clnAddress[115..116]));
   	SELF.ADDR_ZIP5_1			:= IF(TRIM(clnAddress[117..121])='',StringLib.StringFilter(TrimZIP,'0123456789'),TRIM(clnAddress[117..121]));
   	SELF.ADDR_ZIP4_1			:= clnAddress[122..125];

		self.ADDR_CNTY_1    := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.county);
		
		// Strip Fax Number from Address(s)
		tmpPHN_FAX		:= MAP(StringLib.stringfind(trimAddress1[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'FAX ',''),
												 StringLib.stringfind(trimAddress2[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'FAX ',''),
												 StringLib.stringfind(trimAddress3[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'FAX ',''),
												 StringLib.stringfind(trimAddress1,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'OFF FAX ',''),
												 StringLib.stringfind(trimAddress2,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'OFF FAX ',''),
												 StringLib.stringfind(trimAddress3,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'OFF FAX ',''),'');
								 
		self.PHN_FAX_1	:= ut.CleanPhone(tmpPHN_FAX);
		self.PHN_MARI_FAX_1	:= ut.CleanPhone(tmpPHN_FAX);
		
		// Strip Phone Number from Address(s)
		tmpPHONE		:= MAP(StringLib.stringfind(trimAddress1[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'CELL ',''),
							StringLib.stringfind(trimAddress2[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'CELL ',''),
							StringLib.stringfind(trimAddress3[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'CELL ',''),'');
		
		self.PHN_PHONE_1	:= tmpPHONE;
		self.PHN_MARI_1	:= self.PHN_PHONE_1;
		
		// office address fields
		self.ADDR_MAIL_IND	:= IF(TRIM(pInput.comp_address1 + pInput.comp_city + pInput.comp_state + pInput.comp_zip,LEFT,RIGHT) != '','M','');

		
					
		//Filter out bad and duplicate addresses
		filterCompAddr1	:= MAP(REGEXFIND('^(SAME |(NONE)|FAX |XXXX|OFF FAX|CELL )',trimCompAddress1[1..5]) => '',
								trimCompAddress1[1..3] = 'NA '=> '',
								StringLib.stringfind(trimCompAddress1,'ADDRESS NOT TO BE GIVEN OUT UNDER ANY CIRCUMSTANCE',1) > 0 => '',
								REGEXFIND(DBAType,trimCompAddress1) => '',StringLib.StringCleanSpaces(trimCompAddress1));
		
		filterCompAddr2	:= MAP(REGEXFIND('(SAME |(NONE)|FAX |OFF FAX |XXXX|CELL )',trimCompAddress2[1..5]) => '',
									 trimCompAddress2[1..3] = 'NA '=> '',
								 REGEXFIND('(X )',trimCompAddress2[1..2]) => '',
								REGEXFIND(DBAType,trimCompAddress2) => '',
								trimCompAddress1 != '' AND trimCompAddress2 != '' AND trimCompAddress1 = trimCompAddress2 => '',
								trimCompAddress1 != '' AND trimCompAddress2 != '' AND trimCompAddress1[1..10] = trimCompAddress2[1..10] => '',
										StringLib.StringCleanSpaces(trimCompAddress2));
		
		filterCompAddr3	:= MAP(REGEXFIND('(SAME |(NONE)|FAX |OFF FAX |XXXX |CELL )',trimCompAddress3[1..5]) => '',
								 trimCompAddress1[1..3] = 'NA '=> '',
								 REGEXFIND('(X )',trimCompAddress3[1..2]) => '',
								 REGEXFIND(DBAType,trimCompAddress3) => '',
								 trimCompAddress2 != '' AND trimCompAddress3 != '' AND trimCompAddress2 = trimCompAddress3 => '',
								 trimCompAddress2 != '' AND trimCompAddress3 != '' AND trimCompAddress2[1..10] = trimCompAddress3[1..10] => '',
								 trimCompAddress1 != '' AND trimCompAddress3 != '' AND trimCompAddress1 = trimCompAddress3 => '',
								 trimCompAddress1 != '' AND trimCompAddress3 != '' AND trimCompAddress1[1..10] = trimCompAddress3[1..10] => '',
										StringLib.StringCleanSpaces(trimCompAddress3));
		
		//Filterout Whitespaces
		slamwsCompAddr1		:= StringLib.StringFilterOut(filterCompAddr1,' ');
		slamwsCompAddr2		:= StringLib.StringFilterOut(filterCompAddr2,' ');
		slamwsCompAddr3		:= StringLib.StringFilterOut(filterCompAddr3,' ');
		
		
		prepCompAddr1	:= MAP(REGEXFIND('^(ONE |TWO |THREE |FOUR |FIVE |SIX |SEVEN |EIGHT |NINE |TEN |ELEVEN|TWELVE )',filterCompAddr1) => filterCompAddr1,
												 REGEXFIND('( INC$| LLC$| COMPANY$)',filterCompAddr1) => '',
												 filterCompAddr1 != '' AND Prof_License_Mari.func_is_address(filterCompAddr1)=> filterCompAddr1,
												 REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterCompAddr1)
												 OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterCompAddr1) => filterCompAddr1,
												 REGEXFIND('(PO)',filterCompAddr1) 
												 AND StringLib.stringfind(filterCompAddr2[1..3],'BOX',1) >0 => filterCompAddr1,
												 '');
								
		prepCompAddr2	:= MAP(slamwsCompAddr1 != '' AND slamwsCompAddr2 != '' AND slamwsCompAddr1[1..10] = slamwsCompAddr2[1..10] => '',
								 REGEXFIND('^(ONE |TWO |THREE |FOUR |TWELVE|AVENUE NE|BOX)',filterCompAddr2) => filterCompAddr2,
								 filterCompAddr2 != '' AND REGEXFIND('^[0-9]*$',FilterCompAddr2) => '#' + filterCompAddr2,
								 filterCompAddr2 != '' AND Prof_License_Mari.func_is_address(filterCompAddr2) => filterCompAddr2,
								 REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterCompAddr2)
									OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterCompAddr2) => filterCompAddr2,
								 filterCompAddr2 != '' AND LENGTH(TRIM(filterCompAddr2,left,right)) = 1 => '#' + filterCompAddr2,
								 REGEXFIND('(?!^[0-9 ]*$)(?!^[a-zA-Z ]*$)^([a-zA-Z0-9 ]{1, })$',filterCompAddr2) => filterCompAddr2,
								 ' ');
								 
		prepCompAddr3	:= MAP(slamwsCompAddr1 != '' AND slamwsCompAddr3 != '' AND slamwsCompAddr1[1..10] = slamwsCompAddr3[1..10] => '',
								filterCompAddr3!= '' AND REGEXFIND('^[0-9]*$',FilterCompAddr3) => '#' + filterCompAddr3,
								filterCompAddr3 != '' AND Prof_License_Mari.func_is_address(filterCompAddr3) => StringLib.StringCleanSpaces(filterCompAddr3),
									REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterCompAddr3)
									OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterCompAddr3) => filterCompAddr3,'');
		
		
/* 		self.ADDR_ADDR1_2	:= IF(prepCompAddr1 = '' and prepCompAddr2 != '' and prepCompAddr3 != '',StringLib.StringCleanSpaces(prepCompAddr2),
   									IF(prepCompAddr1 = '' and prepCompAddr2 = '' and prepCompAddr3 != '',StringLib.StringCleanSpaces(prepCompAddr3),
   													StringLib.StringCleanSpaces(prepCompAddr1)));
   													
   		self.ADDR_ADDR2_2	:= IF(prepCompAddr1 = '' and prepCompAddr2 != '' and prepCompAddr3 != '', StringLib.StringCleanSpaces(prepCompAddr3),
   									IF(prepCompAddr1 != '' and prepCompAddr2 = '' and prepCompAddr3 != '',StringLib.StringCleanSpaces(prepCompAddr3),
   										IF(prepCompAddr1 != '' and prepCompAddr2 != '',StringLib.StringCleanSpaces(prepCompAddr2),'')));
   		
   		self.ADDR_ADDR3_2	:= IF(prepCompAddr1 != '' and prepCompAddr2 != '',prepCompAddr3,'');
   		self.ADDR_CITY_2 	:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_city);
   		self.ADDR_STATE_2 	:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_state);
   		self.ADDR_ZIP5_2 	:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_zip);
   		self.ADDR_ZIP4_2 	:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_zip4);
*/

		TrimCompCity					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.comp_city);
		TrimCompState					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.comp_state);
		TrimCompZip						:= TRIM(pInput.comp_zip+pInput.comp_zip4);
		//prepAddr_Line_1			:= preADDR_ADDR1_1+' '+preADDR_ADDR2_1+' '+preADDR_ADDR3_1;
		COMPANY_PATTERN				:= '( INC$| LLC$| COMPANY$)';
		prepComp_Addr_Line_1	:= TRIM(IF(REGEXFIND(COMPANY_PATTERN,prepCompAddr1) OR REGEXFIND('(C/O |ATTENTION |ATTN )',prepCompAddr1),'',TRIM(prepCompAddr1)) + ' ' +
																  IF(REGEXFIND(COMPANY_PATTERN,prepCompAddr2) OR REGEXFIND('(C/O |ATTENTION |ATTN )',prepCompAddr2),'',TRIM(prepCompAddr2)) + ' ' +
																  IF(REGEXFIND(COMPANY_PATTERN,prepCompAddr3) OR REGEXFIND('(C/O |ATTENTION |ATTN )',prepCompAddr3),'',TRIM(prepCompAddr3)),LEFT,RIGHT);
		prepComp_Addr_Line_2	:= TrimCompCity + ' ' + TrimCompState + ' ' + TrimCompZip;
		clnCompAddress				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepComp_Addr_Line_1,prepComp_Addr_Line_2);
		tmp_COMP_ADDR_ADDR1_2	:= TRIM(clnCompAddress[1..10],LEFT,RIGHT)+' '+TRIM(clnCompAddress[11..12],LEFT,RIGHT)+' '+TRIM(clnCompAddress[13..40],LEFT,RIGHT)+' '+TRIM(clnCompAddress[41..44],LEFT,RIGHT)+' '+TRIM(clnCompAddress[45..46],LEFT,RIGHT);																	
		tmp_COMP_ADDR_ADDR2_2	:= TRIM(clnCompAddress[47..56],LEFT,RIGHT)+' '+TRIM(clnCompAddress[57..64],LEFT,RIGHT);
		CompAddrWithContact		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmp_COMP_ADDR_ADDR1_2); //Looks for any stray ATTN and C/O in address

		SELF.ADDR_ADDR1_2			:= MAP(CompAddrWithContact != '' and tmp_COMP_ADDR_ADDR2_2 != ''
																   => StringLib.StringCleanSpaces(tmp_COMP_ADDR_ADDR2_2),
																 tmp_COMP_ADDR_ADDR1_2=''
																   => StringLib.StringCleanSpaces(tmp_COMP_ADDR_ADDR2_2),
																 StringLib.StringCleanSpaces(tmp_COMP_ADDR_ADDR1_2));
		SELF.ADDR_ADDR2_2			:= MAP(CompAddrWithContact!='' => '',
																 tmp_COMP_ADDR_ADDR2_2='' => '',
																 TRIM(tmp_COMP_ADDR_ADDR2_2)=TRIM(tmp_COMP_ADDR_ADDR1_2) => '',
															   StringLib.StringCleanSpaces(tmp_COMP_ADDR_ADDR2_2)); 
		SELF.ADDR_CITY_2			:= IF(TRIM(clnCompAddress[65..89])='',TrimCompCity,TRIM(clnCompAddress[65..89]));
		SELF.ADDR_STATE_2			:= IF(TRIM(clnCompAddress[115..116])='',TrimCompState,TRIM(clnCompAddress[115..116]));
   	SELF.ADDR_ZIP5_2			:= IF(TRIM(clnCompAddress[117..121])='',StringLib.StringFilter(pInput.comp_zip,'0123456789'),TRIM(clnCompAddress[117..121]));
   	SELF.ADDR_ZIP4_2			:= IF(TRIM(clnCompAddress[122..125])='',StringLib.StringFilter(pInput.comp_zip4,'0123456789'),TRIM(clnCompAddress[122..125]));
	
		self.ADDR_CNTY_2 	:= prof_license_mari.mod_clean_name_addr.trimupper(pInput.comp_county);
//self.provnote_3:=	trimCompAddress1+'|'+trimCompAddress2 +'|'+trimCompAddress3;	
		
		// populate contact license number field
		self.license_nbr_contact := pInput.qual_broker_lic_numr; 
		SELF.BRKR_LICENSE_NBR	:= TRIM(pInput.qual_broker_lic_numr);
		
		//Obtain Contact Names from Address fields
		tmpNameContact	:= MAP(StringLib.stringfind(trimAddress1,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),
								 StringLib.stringfind(trimAddress2,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress2),
								 StringLib.stringfind(trimAddress3,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress3),'');
		
		tmpContactAddr	:= MAP(REGEXFIND(DBATypeAddl,trimAddress1) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress1,3),
								REGEXFIND(DBATypeAddl,trimAddress2) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress2,3),
								REGEXFIND(DBATypeAddl,trimAddress3) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress3,3),'');
		
		clnNameContact	:= IF(tmpNameContact != '', datalib.NameClean(tmpNameContact),datalib.NameClean(tmpContactAddr));
		self.NAME_CONTACT_FIRST	:= TRIM(clnNameContact[1..30],left,right);
		self.NAME_CONTACT_MID	:= TRIM(clnNameContact[41..70],left,right);
		self.NAME_CONTACT_LAST	:= TRIM(clnNameContact[81..120],left,right);
		self.NAME_CONTACT_SUFX	:= TRIM(clnNameContact[131..136],left,right);
								 
		//populate email field
		self.email := Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.email);
		self.AFFIL_TYPE_CD	:= MAP(self.TYPE_CD = 'MD' => 'IN',
									 self.TYPE_CD = 'GR' => 'CO','');
						
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME/Address field(s)
		StripDBA     := MAP(tempOff3 != '' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempoff3),
							StringLib.stringfind(trimAddress1,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),
							StringLib.stringfind(trimAddress2,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress2),
							StringLib.stringfind(trimAddress3,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress3),'');
							
		self.dba	:= StripDBA;
		self.dba_flag := if(StripDBA != ' ', 1, 0);
		self.dba1	:= '';
		self.dba2	:= '';
		self.dba3	:= '';
		self.dba4	:= '';
		self.dba5	:= '';
					 
		mltreckeyHash := hash64(trim(tempLicNum,left,right) 
														 +trim(tempStdLicType,left,right)
								 +trim(src_cd,left,right)
								 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempOff3)
												 // +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempNameOrg)
								 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1)
								 +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.off_slnum));
								 // +Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(StripDBA)); 
		
		// self.mltrec_key := if(dba1 != '' and dba2 != ''
									// ,mltreckeyHash, 0);
									
		self.mltreckey		:= IF(trim(self.dba1,left,right) != ' ' and trim(self.dba2,left,right) != ' ' 
									 and trim(self.dba1,left,right) != trim(self.dba2,left,right),mltreckeyhash,0);
									
		self.cmc_slpk        := hash64(trim(tempLicNum,left,right) 
																				+trim(tempStdLicType,left,right)
																				+trim(src_cd,left,right)
																				+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempNameOrg)
																				+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1)
																				+trim(pInput.zip+pInput.zip4)
																				+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.off_slnum));
									 
		self.pcmc_slpk	:= 0;
		
		
		SELF := [];		   		   
	END;

	ds_map := project(ValidFile(lic_status<>''), transformToCommon(left));


	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := JOIN(ds_map, Cmvtranslation,
								TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
									AND right.fld_name='LIC_STATUS',
								trans_lic_status(left,right),left outer,lookup);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);
																		
/* // Populate prof code description
   maribase_plus_dbas  trans_prof_desc(ds_map_lic_trans L, Prof_Desc R) := transform
     self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
   	self := L;
   end;
   
   ds_map_prof_desc := JOIN(ds_map_lic_trans, Prof_Desc,
   						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
   						 trans_prof_desc(left,right),left outer,lookup);
   																		
   
   // Populate License Status Description field
   maribase_plus_dbas trans_status_desc(ds_map_prof_desc L, Status_Desc R) := transform
     self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
     self := L;
   end;
   
   ds_map_status_desc := jOIN(ds_map_prof_desc, Status_Desc,
   							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
   							trans_status_desc(left,right),left outer,lookup);
   																		
   																		
   //Populate License Type Description field
   maribase_plus_dbas trans_type_desc(ds_map_status_desc L, License_Desc R) := transform
     self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
     self := L;
   end;
   
   ds_map_type_desc := JOIN(ds_map_status_desc, License_Desc,
   						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
   						trans_type_desc(left,right),left outer,lookup);
   						
   						
   //Populate Source Description field
   maribase_plus_dbas trans_source_desc(ds_map_type_desc L, Src_Desc R) := transform
     self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
     self := L;
   end;
   
   ds_map_source_desc := join(ds_map_type_desc, Src_Desc,
   						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
   						trans_source_desc(left,right),left outer,lookup);
   
*/


	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_source_desc(affil_type_cd='CO');
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	//maribase_plus_dbas 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	maribase_plus_dbas 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	//ds_map_affil := join(ds_map_source_desc, company_only_lookup,
	ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
							TRIM(left.LICENSE_NBR[1..10],left,right)= TRIM(right.OFF_LICENSE_NBR[1..10],left,right)
							AND left.LICENSE_NBR != ''
							AND left.AFFIL_TYPE_CD = 'IN',
							assign_pcmcslpk(left,right),left outer,lookup);																		

	maribase_plus_dbas 	xTransPROVNOTE(ds_map_affil L) := transform
		self.provnote_1 := IF(L.license_nbr_contact != '','ASSOCIATE BROKER LICENSE NUMBER:'+' '+ L.license_nbr_contact,'');
		self := L;

	end;
									 
	OutRecs := project(ds_map_affil, xTransPROVNOTE(left));
						

	// Normalized DBA records
	maribase_dbas := record,maxlength(5000)
		maribase_plus_dbas;
		string60 tmp_dba;
	end;

	maribase_dbas	NormIT(OutRecs L, INTEGER C) := TRANSFORM
			self := L;
		self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(OutRecs,6,NormIT(left,counter)),all,record);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := transform
			
		TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		
		self.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
		self.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		self.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,left,right),
									 L.type_cd = 'MD' => TRIM(L.TMP_DBA,left,right), ''); 
		
		
		self.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, ','),
										 StringLib.stringfind(L.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '#'),	
																																						 L.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, ','),
										 // StringLib.stringfind(L.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '#'),	
																																						 L.ADDR_ADDR2_1);
			
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, ','),
										 // StringLib.stringfind(L.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '#'),	
																																						 L.ADDR_ADDR3_1);

		self.ADDR_ADDR1_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR1_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, ','),
										 StringLib.stringfind(L.ADDR_ADDR1_2,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, '#'),	
																																						 L.ADDR_ADDR1_2);
		self.ADDR_ADDR2_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR2_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_2, ','),
										 // StringLib.stringfind(L.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '#'),	
																																						 L.ADDR_ADDR2_2);
			
		self.ADDR_ADDR3_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR3_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_2, ','),
										 // StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '#'),	
																																						 L.ADDR_ADDR3_2);

		self := L;
	end;

	ds_map_base := project(FilteredRecs, xTransToBase(left));
																
																
// output(ds_map_base(name_dba != ''));   																				

// output(ds_map_base(name_contact_first !=''));


// output(ds_map_base(StringLib.stringfind(NAME_DBA_ORIG,'DBA ',1) > 0));
				
						
// output(ds_map_base(StringLib.stringfind(NAME_ORG_ORIG,'(',1) > 0
				// OR StringLib.stringfind(NAME_ORG_ORIG,'"',1) > 0
					// OR StringLib.stringfind(NAME_ORG_ORIG,'/',1) > 0));


// output(ds_map_base(REGEXFIND('^(SAME|(NONE)|XXXX|CELL |OFF FAX |FAX )', StringLib.StringToUpperCase(ADDR_ADDR1_1[1..4]))
				// OR REGEXFIND('^(SAME|(NONE)|XXXX|CELL |OFF FAX |FAX  )',StringLib.StringToUpperCase(ADDR_ADDR2_1[1..4]))
					// OR REGEXFIND('^(SAME|(NONE)|XXXX|CELL |OFF FAX |FAX )',StringLib.StringToUpperCase(ADDR_ADDR3_1[1..4]))));
					

// output(choosen(ds_map_base(ADDR_ADDR1_1[1..10] = ADDR_ADDR2_1[1..10] and ADDR_ADDR1_1 != ''),1000));
// output(choosen(ds_map_base(ADDR_ADDR2_1[1..10] = ADDR_ADDR3_1[1..10] and ADDR_ADDR2_1 != ''),1000));
// output(choosen(ds_map_base(ADDR_ADDR3_1[1..10] = ADDR_ADDR1_1[1..10] and ADDR_ADDR3_1 != ''),1000));


// output(choosen(ds_map_base(ADDR_ADDR1_2[1..10] = ADDR_ADDR2_2[1..10] and ADDR_ADDR1_2 != ''),1000));
// output(choosen(ds_map_base(ADDR_ADDR2_2[1..10] = ADDR_ADDR3_2[1..10] and ADDR_ADDR2_2 != ''),1000));
// output(choosen(ds_map_base(ADDR_ADDR3_2[1..10] = ADDR_ADDR1_2[1..10] and ADDR_ADDR3_2 != ''),1000));



// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR1_1) and ADDR_ADDR1_1 != ' '),1000));
// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR2_1) and ADDR_ADDR2_1 != ' '),1000));
// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR3_1) and ADDR_ADDR3_1 != ' '),1000));

// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR1_2) and ADDR_ADDR1_2 != ' '),1000));
// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR2_2) and ADDR_ADDR2_2 != ' '),1000));
// output(choosen(ds_map_base(REGEXFIND('^([a-zA-z\\s]{2,})$',ADDR_ADDR3_2) and ADDR_ADDR3_2 != ' '),1000));


// output(count(ds_map_base(license_nbr_contact != '')));




	//Adding to Superfile
		
	d_final := output(ds_map_base, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
			
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);
	
	move_to_used := parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr_actv', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr_inact', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rebk_actv', 'using', 'used'),
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rebk_inact', 'using', 'used'));

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, out_apr,out_re_act,out_re_inact, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;






