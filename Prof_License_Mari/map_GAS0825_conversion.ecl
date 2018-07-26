// Purpose : map Georgia Real Estate Commission & Appraisers Board / Multiple Professions raw data to common layout for MARI and PL use
// Source file location - \\Tapeload02b\k\professional_licenses\mari\ga\georgia_real_estate_professionals_(en)
//                        \\Tapeload02b\k\professional_licenses\mari\ga\georgia_real_estate_appraisers_(en)
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

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
	
	out_apr							:= OUTPUT(apr);
	out_re_act					:= OUTPUT(re_act);
	out_re_inact				:= OUTPUT(re_inact);
	
	//Must complete moving files from sprayed to using first
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD=src_cd);

	//Pattern for DBA
	// DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';
	
  //Pattern for Suffix Name
  SUFFIX_PATTERN  := '( JR.$| JR$| SR.$| SR$| III$| II$| IV$)';	
	
	//Use address cleaner to clean address
	CoPattern 	:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$' +
					 ')';
	RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|DBA .*$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|REGULAR BAPTIST CAMP|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';	
	
	Addr_Pattern     := '( DR$| DR. | DR | DRIVE| ROAD|SUITE|POST OFFICE|PO BOX|OFFICE CENTER| PK$| BUILDING| SE$| CT$| TWP$| COURT$)';

	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';

	//***********Combine files into one common layout******************
	// apr to common
	Prof_License_Mari.layout_GAS0825.common map_apr(Prof_License_Mari.layout_GAS0825.apr L) := TRANSFORM
		SELF.comp_name		        := ' ';
		SELF.off_slnum		        := ' ';
		SELF.qual_broker_lic_numr	:= ' ';
		SELF.comp_org_form	      	:= ' ';
		SELF.comp_address1		      := ' ';
		SELF.comp_address2        	:= ' ';
		SELF.comp_address3        	:= ' ';
		SELF.comp_city            	:= ' ';
		SELF.comp_state           	:= ' ';
		SELF.comp_zip             	:= ' ';
		SELF.comp_zip4            	:= ' ';
		SELF.comp_county          	:= ' ';
		SELF.comp_status          	:= ' ';
		SELF.comp_renew_due_date  	:= ' ';
		SELF.prof                 	:= 'APPRAISER';
		SELF	:= L;
	END;

	aprCommon	:= PROJECT(apr, map_apr(LEFT));

	//Remove bad records before processing
	ValidApr	:= aprCommon(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));
											

	// re active to common
	Prof_License_Mari.layout_GAS0825.common map_re_act(Prof_License_Mari.layout_GAS0825.re_active L) := TRANSFORM
		SELF.lic_issue_date := ' ';
		SELF.prof           := 'REAL ESTATE';
		SELF	:= L;
	END;

	re_act_common	:= PROJECT(re_act, map_re_act(LEFT));
	//Remove bad records before processing
	ValidRE_act	:= re_act_common(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(first_name))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(last_name)));
											
	// re inactive to common
	Prof_License_Mari.layout_GAS0825.common map_re_inact(Prof_License_Mari.layout_GAS0825.re_inactive L) := TRANSFORM
		SELF.lic_type             	:= ' ';
		SELF.comp_name		        := ' ';
		SELF.off_slnum		        := ' ';
		SELF.qual_broker_lic_numr	:= ' ';
		SELF.comp_org_form	      	:= ' ';
		SELF.comp_address1		    := ' ';
		SELF.comp_address2        	:= ' ';
		SELF.comp_address3        	:= ' ';
		SELF.comp_city            	:= ' ';
		SELF.comp_state           	:= ' ';
		SELF.comp_zip             	:= ' ';
		SELF.comp_zip4            	:= ' ';
		SELF.comp_county          	:= ' ';
		SELF.comp_status          	:= ' ';
		SELF.comp_renew_due_date  	:= ' ';
		SELF.prof                 	:= 'REAL ESTATE';
		SELF	:= L;
	END;

	re_inact_common	:= PROJECT(re_inact, map_re_inact(LEFT));
	//Remove bad records before processing
	ValidRE_inact	:= re_inact_common(TRIM(first_name,LEFT,RIGHT)+TRIM(last_name,LEFT,RIGHT) != ' ' 
											AND TRIM(lic_status,LEFT,RIGHT) <> ' '
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
											AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(LAST_NAME)));										

	// combine common layout files
	ValidFile	:= ValidApr + ValidRE_act + ValidRE_inact;

	//Pattern for DBA
	DBAType	:= '(DBA |D/B/A |C/O |ATTN: |ATTN )';
	DBATypeAddl	:= '(ATT |CARE OF)';

	maribase_plus_dbas := RECORD,MAXLENGTH(5000)
		Prof_License_Mari.layouts.base;
		STRING60 dba;
		STRING60 dba1;
		STRING60 dba2;
		STRING60 dba3;
		STRING60 dba4;
		STRING60 dba5;
	END;

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
		
		tempLicNum       			:= ut.CleanSpacesAndUpper(pInput.lic_numr);
		SELF.LICENSE_NBR			:= tempLicNum;
		SELF.LICENSE_STATE		:= src_st;
		SELF.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.lic_status);
		SELF.OFF_LICENSE_NBR 	:= pInput.off_slnum;
		
		// initialize raw_license_type from raw data
		tempRawType 					:= ut.CleanSpacesAndUpper(pInput.lic_type);
		SELF.RAW_LICENSE_TYPE := tempRawType;
																																		
		// map raw license type to standard license type before profcode translations
		tempStdLicType 				:= MAP(tempRawType = ' ' => 'RLEIND',
																 pInput.prof = 'APPRAISER' and tempRawType != ' ' => 'APR'+tempRawType,
																 pInput.prof = 'REAL ESTATE' and tempRawType != ' ' => 'RLE'+tempRawType, 
																 '');
																 
		SELF.STD_LICENSE_TYPE := tempStdLicType;
		
		// assigning type code based on license type
		tempTypeCd						:= 'MD';
		SELF.TYPE_CD      		:= tempTypeCd;
		
		tempMariParse     		:= tempTypeCd;
		mariParse         		:= MAP(tempTypeCd = 'MD' => 'MD',
																 tempTypeCd = 'GR' => 'GR',
																 ' ');
																
		trimLName							:= ut.CleanSpacesAndUpper(pInput.last_name);
		trimFName							:= ut.CleanSpacesAndUpper(pInput.first_name);
		trimMName							:= ut.CleanSpacesAndUpper(pInput.middle_name);
		trimSuffix						:= ut.CleanSpacesAndUpper(pInput.suffix);
		
		//Process nick names
		nickfirst							:= Prof_License_Mari.fGetNickname(trimFName,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(trimFName,'strip_nick');
		cleanFNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
		nicklast							:= Prof_License_Mari.fGetNickname(trimLNAME,'nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(trimLNAME,'strip_nick');
		removeSuffix          := stringlib.stringcleanspaces(Stringlib.Stringfindreplace(REGEXREPLACE(SUFFIX_PATTERN, removeLNick,''),'"',''));
		TmpSufx               := REGEXFIND(SUFFIX_PATTERN, removeLNick,0);				
		
		cleanLNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeSuffix);
		nickmid								:= Prof_License_Mari.fGetNickname(trimMName,'nick');
		removeMNick						:= Prof_License_Mari.fGetNickname(trimMName,'strip_nick');
		cleanMNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeMNick);
	
		tempNameOrg						:= IF(REGEXFIND('A/K/A',cleanLNAME),
		                            stringlib.stringcleanspaces(CleanMName+ ' '+ CleanFName),
		                            stringlib.stringcleanspaces(CleanLName+ ' '+ CleanFName));
																
		SELF.NAME_ORG 				:= stringlib.stringcleanspaces(tempNameOrg);
		SELF.name_first 			:= cleanFNAME;
		SELF.name_mid   			:= IF(REGEXFIND('A/K/A',cleanLNAME),'',cleanMNAME);
		SELF.name_last  			:= IF(REGEXFIND('A/K/A',cleanLNAME),cleanMNAME,cleanLNAME);
		SELF.name_sufx				:= IF(trimSuffix != '',trimSuffix, TmpSufx);											 	 
		// parse nick name
		
		
		
		stripNick							:= MAP(StringLib.stringfind(nicklast,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',nicklast,''),
																 nickfirst != '' => nickfirst,
																 nickmid != '' => nickmid,'');
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(stripNick);
							
		// Reformatting dates from MMDDYYYY to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= '17530101';
		
		// Incoming dates on some records are missing leading zero
		prep_orig_issue_dte := if(length(trim(pInput.lic_issue_date)) = 7, '0'+ pInput.lic_issue_date, pInput.lic_issue_date);
		prep_expire_dte 				:= if(length(trim(pInput.expiration_date)) = 7, '0'+ pInput.expiration_date, pInput.expiration_date);

		SELF.ORIG_ISSUE_DTE		:= IF(prep_orig_issue_dte != '' AND prep_orig_issue_dte[5..6] IN ['17','18','19','20'],
																														prep_orig_issue_dte[5..8]+ prep_orig_issue_dte[1..2]+prep_orig_issue_dte[3..4],
																																'17530101');	
		SELF.EXPIRE_DTE				:= 	IF(prep_expire_dte !='' AND prep_expire_dte[5..6] IN ['17','18','19','20'],
																												prep_expire_dte[5..8]+ prep_expire_dte[1..2]+ prep_expire_dte[3..4],
																														'17530101');
		
		// assign officename and office parse field : GR if company, MD if individual 
		tempOff1            	:= ut.CleanSpacesAndUpper(pInput.comp_name);
		tempOff2            	:= stringlib.stringfindreplace(tempOff1,' D/R/A ',' DBA ');
		tempOff3            	:= IF(tempOff2[1..4]='T/A ',tempOff2[5..],tempOff2);  
																						
		// assign address fields from raw 
		trimAddress1					:= ut.CleanSpacesAndUpper(pInput.address1);
		trimAddress2					:= ut.CleanSpacesAndUpper(pInput.address2);
		trimAddress3					:= ut.CleanSpacesAndUpper(pInput.address3);
		
		trimCompAddress1			:= ut.CleanSpacesAndUpper(pInput.comp_address1);
		trimCompAddress2			:= ut.CleanSpacesAndUpper(pInput.comp_address2);
		trimCompAddress3			:= ut.CleanSpacesAndUpper(pInput.comp_address3);
		
	  //Extract company name
		clnAddress1 					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern); 
		clnAddress2 					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress2, RemovePattern);
		clnAddress3 					:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress3, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1 + ' ' + clnAddress2 + ' ' + clnAddress3); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(pInput.CITY+' '+pInput.STATE +' '+pInput.ZIP); 
		clnAddrAddr1				 	:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	  //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		SELF.ADDR_ADDR1_1		:= IF(AddrWithContact != ' ' AND tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																           StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		SELF.ADDR_ADDR2_1		:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		 := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),ut.CleanSpacesAndUpper(pInput.CITY));
		SELF.ADDR_STATE_1		:= IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),ut.CleanSpacesAndUpper(pInput.STATE));
		SELF.ADDR_ZIP5_1		 := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(pInput.ZIP,LEFT,RIGHT)[1..5]);
		SELF.ADDR_ZIP4_1		 := clnAddrAddr1[122..125];
		
		SELF.ADDR_CNTY_1    := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.county);

		// assign business address indicator to true (B) if business address fields are not empty
		SELF.ADDR_BUS_IND	:= IF(TRIM(pInput.address1 + pInput.address2 + pInput.city + pInput.state + pInput.zip) != '','B','');

		// Extracted company from address field
		TrimCompany      := MAP(REGEXFIND(CoPattern,trimAddress1) AND NOT REGEXFIND(Addr_Pattern,trimAddress1) => trimAddress1,
                       		  REGEXFIND(CoPattern,trimAddress2) AND NOT REGEXFIND(Addr_Pattern,trimAddress2) => trimAddress2,
           									REGEXFIND(CoPattern,trimAddress3) AND NOT REGEXFIND(Addr_Pattern,trimAddress3) => trimAddress3,
		                        Prof_License_Mari.func_is_company(trimAddress1) = TRUE AND Prof_License_Mari.func_is_address(trimAddress1) = false
												               AND NOT REGEXFIND(Addr_Pattern,trimAddress1) => trimAddress1,
															           Prof_License_Mari.func_is_company(trimAddress2) = TRUE AND Prof_License_Mari.func_is_address(trimAddress2) = false
																			        AND NOT REGEXFIND(Addr_Pattern,trimAddress2) => trimAddress2,
																	         Prof_License_Mari.func_is_company(trimAddress3) = TRUE AND Prof_License_Mari.func_is_address(trimAddress3) = false
																				       AND NOT REGEXFIND(Addr_Pattern,trimAddress3) => trimAddress3,
	                         '');
	 preNAME_OFFICE 		:= MAP(REGEXFIND('C/O ',TrimCompany[1..4])=> Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimCompany),
																	          TrimCompany = '' AND TrimCompany[1..4]='C/O '=>  TrimCompany[5..],
																	          TrimCompany = '' AND TrimCompany[1..4]='DBA '=> '',																
																	          TrimCompany = '' AND TrimCompany <> '' => TrimCompany,
																	          TrimCompany);
	 tmpNAME_OFFICE			:= MAP(preNAME_OFFICE[1..4]='DBA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE[1..4]='AKA ' => preNAME_OFFICE[5..],
		                             preNAME_OFFICE);
		clnOfficeName				:= IF(REGEXFIND('(.COM|.NET|.ORG)',tmpNAME_OFFICE),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNAME_OFFICE),
		                            tmpNAME_OFFICE);
																
		SELF.NAME_OFFICE	:= MAP(clnOfficeName = 'NA' => '',
															           clnOfficeName = 'NONE' => '',
															           TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
															           TRIM(clnOfficeName,ALL) = TRIM(SELF.NAME_FIRST,ALL) + TRIM(SELF.NAME_MID,ALL) + TRIM(SELF.NAME_LAST,ALL) => '',
			                       clnOfficeName);
														 
		SELF.OFFICE_PARSE		:= MAP(SELF.NAME_OFFICE = ' ' => ' ',
										 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)>1 AND Prof_License_Mari.func_is_company(SELF.NAME_OFFICE) =>'GR',
										 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'THE ',1)> 0 AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'CO',1)>0 => 'GR',
										 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),'BANK',1)> 0 => 'GR', 
										 SELF.NAME_OFFICE != ' ' AND StringLib.stringfind(TRIM(SELF.NAME_OFFICE,LEFT,RIGHT),' ',1)<1 => 'GR',
										 SELF.NAME_OFFICE != ' ' AND REGEXFIND('^([A-Za-z ]*)[ ](CO)[ ]',SELF.NAME_OFFICE) => 'GR', 'MD');		
		
		// assign two holders for raw data per mari business rules
		SELF.NAME_ORG_ORIG	:= StringLib.StringCleanSpaces(trimLName+' '+ TRIM(SELF.name_sufx,LEFT,RIGHT)
									+' '+trimFName+' '+trimMName);
		SELF.NAME_FORMAT		:= 'L';
		SELF.NAME_DBA_ORIG	:= IF(REGEXFIND('(DBA [A-Za-z \\/]+)$',TRIM(tempOff1)),StringLib.StringCleanSpaces(tempOff1),'');
		
		// assign mari_org with semi-clean name data per business rules
		SELF.NAME_MARI_ORG	:= IF(tempTypeCd='MD',SELF.NAME_OFFICE,'');
		SELF.NAME_MARI_DBA	:= ' ';
		
		
		// Strip Fax Number from Address(s)
		tmpPHN_FAX		:= MAP(StringLib.stringfind(trimAddress1[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'FAX ',''),
												 StringLib.stringfind(trimAddress2[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'FAX ',''),
												 StringLib.stringfind(trimAddress3[1..4],'FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'FAX ',''),
												 StringLib.stringfind(trimAddress1,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'OFF FAX ',''),
												 StringLib.stringfind(trimAddress2,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'OFF FAX ',''),
												 StringLib.stringfind(trimAddress3,'OFF FAX ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'OFF FAX ',''),'');
		TempFax         := IF(TRIM(tmpPHN_FAX,LEFT,RIGHT) != ' ',StringLib.StringFilter(tmpPHN_FAX,'0123456789'),' ');						 
		SELF.PHN_FAX_1	:= ut.CleanPhone(TempFax);
		SELF.PHN_MARI_FAX_1	:= ut.CleanPhone(TempFax);
		
		// Strip Phone Number from Address(s)
		tmpPHONE		:= MAP(StringLib.stringfind(trimAddress1[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress1,'CELL ',''),
							StringLib.stringfind(trimAddress2[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress2,'CELL ',''),
							StringLib.stringfind(trimAddress3[1..5],'CELL ',1) > 0 => StringLib.StringFindReplace(trimAddress3,'CELL ',''),'');
		TempPhone         := IF(TRIM(tmpPHONE,LEFT,RIGHT) != ' ',StringLib.StringFilter(tmpPHONE,'0123456789'),' ');
		SELF.PHN_PHONE_1	:= ut.CleanPhone(TempPhone);
		SELF.PHN_MARI_1	  := ut.CleanPhone(TempPhone);
		
		// office address fields
		SELF.ADDR_MAIL_IND	:= IF(TRIM(pInput.comp_address1 + pInput.comp_city + pInput.comp_state + pInput.comp_zip,LEFT,RIGHT) != '','M','');

		
					
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
								 filterCompAddr2 != '' AND LENGTH(TRIM(filterCompAddr2,LEFT,RIGHT)) = 1 => '#' + filterCompAddr2,
								 REGEXFIND('(?!^[0-9 ]*$)(?!^[a-zA-Z ]*$)^([a-zA-Z0-9 ]{1, })$',filterCompAddr2) => filterCompAddr2,
								 ' ');
								 
		prepCompAddr3	:= MAP(slamwsCompAddr1 != '' AND slamwsCompAddr3 != '' AND slamwsCompAddr1[1..10] = slamwsCompAddr3[1..10] => '',
								  filterCompAddr3!= '' AND REGEXFIND('^[0-9]*$',FilterCompAddr3) => '#' + filterCompAddr3,
								  filterCompAddr3 != '' AND Prof_License_Mari.func_is_address(filterCompAddr3) => StringLib.StringCleanSpaces(filterCompAddr3),
									REGEXFIND('^(\\d{1,6}.?\\d[a-zA-Z]{1,30})',filterCompAddr3)
									OR REGEXFIND('^(\\d{1,6}[a-zA-Z]{1,30})',filterCompAddr3) => filterCompAddr3,'');
		
		TrimCompCity					:= ut.CleanSpacesAndUpper(pInput.comp_city);
		TrimCompState					:= ut.CleanSpacesAndUpper(pInput.comp_state);
		TrimCompZip						:= TRIM(pInput.comp_zip+pInput.comp_zip4);
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
	
		SELF.ADDR_CNTY_2 	:= ut.CleanSpacesAndUpper(pInput.comp_county);
	
		// populate contact license number field
		SELF.license_nbr_contact := pInput.qual_broker_lic_numr; 
		SELF.BRKR_LICENSE_NBR	:= TRIM(pInput.qual_broker_lic_numr);
		
		//Obtain Contact Names from Address fields
		tmpNameContact	:= MAP(StringLib.stringfind(trimAddress1,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),
								 StringLib.stringfind(trimAddress2,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress2),
								 StringLib.stringfind(trimAddress3,'ATTN',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress3),'');
		
		tmpContactAddr	:= MAP(REGEXFIND(DBATypeAddl,trimAddress1) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress1,3),
								 REGEXFIND(DBATypeAddl,trimAddress2) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress2,3),
								 REGEXFIND(DBATypeAddl,trimAddress3) => REGEXFIND('^(.*)(ATT |CARE OF )(.*)',trimAddress3,3),'');
		
		clnNameContact	:= IF(tmpNameContact != '', datalib.NameClean(tmpNameContact),datalib.NameClean(tmpContactAddr));
		SELF.NAME_CONTACT_FIRST	:= TRIM(clnNameContact[1..30],LEFT,RIGHT);
		SELF.NAME_CONTACT_MID	:= TRIM(clnNameContact[41..70],LEFT,RIGHT);
		SELF.NAME_CONTACT_LAST	:= TRIM(clnNameContact[81..120],LEFT,RIGHT);
		SELF.NAME_CONTACT_SUFX	:= TRIM(clnNameContact[131..136],LEFT,RIGHT);
								 
		//populate email field
		SELF.email := ut.CleanSpacesAndUpper(pInput.email);
		SELF.AFFIL_TYPE_CD	:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
									 SELF.TYPE_CD = 'GR' => 'CO','');
						
		// Business rules to standardize DBA(s) for splitting into multiple records
		// Populate if DBA exist in ORG_NAME/Address field(s)
		StripDBA     := MAP(tempOff3 != '' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempoff3),
							StringLib.stringfind(trimAddress1,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress1),
							StringLib.stringfind(trimAddress2,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress2),
							StringLib.stringfind(trimAddress3,'DBA ',1) > 0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddress3),'');
							
		SELF.dba	:= StripDBA;
		SELF.dba_flag := IF(StripDBA != ' ', 1, 0);
		SELF.dba1	:= '';
		SELF.dba2	:= '';
		SELF.dba3	:= '';
		SELF.dba4	:= '';
		SELF.dba5	:= '';
					 
		mltreckeyHash := HASH64(TRIM(tempLicNum,LEFT,RIGHT) 
														 +TRIM(tempStdLicType,LEFT,RIGHT)
								 +TRIM(src_cd,LEFT,RIGHT)
								 +ut.CleanSpacesAndUpper(tempOff3)
								 +ut.CleanSpacesAndUpper(pInput.ADDRESS1)
								 +ut.CleanSpacesAndUpper(pInput.off_slnum));

		SELF.mltreckey		:= IF(TRIM(SELF.dba1,LEFT,RIGHT) != ' ' and TRIM(SELF.dba2,LEFT,RIGHT) != ' ' 
									 and TRIM(SELF.dba1,LEFT,RIGHT) != TRIM(SELF.dba2,LEFT,RIGHT),mltreckeyhash,0);
									
		SELF.cmc_slpk        := hash64(TRIM(tempLicNum,LEFT,RIGHT) 
																				+TRIM(tempStdLicType,LEFT,RIGHT)
																				+TRIM(src_cd,LEFT,RIGHT)
																				+ut.CleanSpacesAndUpper(tempNameOrg)
																				+ut.CleanSpacesAndUpper(pInput.ADDRESS1)
																				+TRIM(pInput.zip+pInput.zip4)
																				+ut.CleanSpacesAndUpper(pInput.off_slnum));
									 
		SELF.pcmc_slpk	:= 0;
		
		
		SELF := [];		   		   
	END;

	ds_map := PROJECT(ValidFile(lic_status<>''), transformToCommon(LEFT));


	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	maribase_plus_dbas trans_lic_status(ds_map L, Cmvtranslation R) := TRANSFORM
		SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_stat_trans := JOIN(ds_map, Cmvtranslation,
								TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
									AND RIGHT.fld_name='LIC_STATUS',
								trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := TRANSFORM
		SELF.STD_PROF_CD := R.DM_VALUE1;
		SELF := L;
	END;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	maribase_plus_dbas 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := TRANSFORM
		SELF.pcmc_slpk := R.cmc_slpk;
		SELF := L;
	END;

	ds_map_affil := JOIN(ds_map_lic_trans, company_only_lookup,
							TRIM(LEFT.LICENSE_NBR[1..10],LEFT,RIGHT)= TRIM(RIGHT.OFF_LICENSE_NBR[1..10],LEFT,RIGHT)
							AND LEFT.LICENSE_NBR != ''
							AND LEFT.AFFIL_TYPE_CD = 'IN',
							assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		

	maribase_plus_dbas 	xTransPROVNOTE(ds_map_affil L) := TRANSFORM
		SELF.provnote_1 := IF(L.license_nbr_contact != '','ASSOCIATE BROKER LICENSE NUMBER:'+' '+ L.license_nbr_contact,'');
		SELF := L;

	END;
									 
	OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));
						

	// Normalized DBA records
	maribase_dbas := RECORD,MAXLENGTH(5000)
		maribase_plus_dbas;
		STRING60 tmp_dba;
	END;

	maribase_dbas	NormIT(OutRecs L, INTEGER C) := TRANSFORM
			SELF := L;
		SELF.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
	END;

	NormDBAs 	:= DEDUP(NORMALIZE(OutRecs,6,NormIT(LEFT,COUNTER)),ALL,RECORD);

	NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
					AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
	DBARecs 	:= NormDBAs(TMP_DBA != '');

	FilteredRecs  := DBARecs + NoDBARecs;

	// Transform expanded dataset to MARIBASE layout
	// Apply DBA Business Rules
	Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
			
		TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
												 NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
												 '');
		DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
		
		SELF.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
		SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: false
		SELF.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		SELF.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
									 L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,LEFT,RIGHT),
									 L.type_cd = 'MD' => TRIM(L.TMP_DBA,LEFT,RIGHT), ''); 
		
		
		SELF.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, ','),
										 StringLib.stringfind(L.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '#'),	
																																						 L.ADDR_ADDR1_1);
		SELF.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, ','),
																																						 L.ADDR_ADDR2_1);
			
		SELF.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, ','),
																																						 L.ADDR_ADDR3_1);

		SELF.ADDR_ADDR1_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR1_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, ','),
										 StringLib.stringfind(L.ADDR_ADDR1_2,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_2, '#'),	
																																						 L.ADDR_ADDR1_2);
		SELF.ADDR_ADDR2_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR2_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_2, ','),
																																						 L.ADDR_ADDR2_2);
			
		SELF.ADDR_ADDR3_2		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_2,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_2, '.'),
										 StringLib.stringfind(L.ADDR_ADDR3_2,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_2, ','),
																																						 L.ADDR_ADDR3_2);

		SELF := L;
	END;

	ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));
																
							
	//Adding to Superfile
	d_final := OUTPUT(ds_map_base, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
			
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