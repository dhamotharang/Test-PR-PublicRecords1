//************************************************************************************************************* */	
//  The purpose of this development is take IN Department of Financial Institutions raw files and convert them
//   to a common professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;
	
EXPORT map_INS0644_conversion(STRING pVersion) := FUNCTION

	code 								:= 'INS0644';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								

	//Move to using
	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg_lender','sprayed','using');	
												 );

	//IN input files
	// ds_IN_Company		:= Prof_License_Mari.files_INS0644.ds_company;
	// ds_IN_Branch			:= Prof_License_Mari.files_INS0644.ds_branch;
	ds_mtg_lender 			:= Prof_License_Mari.files_INS0644.mtg_lender(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, ORG_NAME, NOCASE));
	oMtg								:= OUTPUT(ds_mtg_lender);
	
	//Dataset reference files for lookup joins
	Cmvtranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	//Pattern for DBA
	DBApattern					:= '^(.*)(DBA |D B A |D/B/A | DBA )(.*)';
	//Pattern for Internet companies
	IPpattern						:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//No Longer Valid
	//Combine datasets into a single layout.  Add 'NR' for SLNUM for branch file which doesn't have an SLNUM
	// layout_IN_combined	:= RECORD
			// string30   SLNUM;
			// string150  ORG_NAME;
			// string30   CITY;
			// string80	 ADDRESS1;
			// string30   STATE;
			// string30   ZIP;
			// string30	 IN_CITY;
			// string30	 IN_PHONE;
			// string30   COUNTY;
			// string30   TELE;
			// string30   OFFTYPE;
	// END;

	// layout_IN_combined map_company(ValidINCompany L)	:= TRANSFORM
			// SELF	:= L;
			// SELF := [];
	// END;

	// ds_Corp_Combined	:= project(ValidINCompany,map_company(left));

	// layout_IN_combined map_branch(ValidINBranch L)	:= TRANSFORM
			// SELF.SLNUM	:= 'NR';  //no license number
			// SELF	:= L;
			// SELF := [];
	// END;

	// ds_Branch_Combined	:= project(ValidINBranch,map_branch(left));

	//Combine both common datasets
	// ds_IN_combined	:=  ds_Corp_Combined + ds_Branch_Combined;

	//layout to Common
	Prof_License_Mari.layout_base_in	transformToCommon(Prof_License_Mari.layout_INS0644.Corp L) := TRANSFORM

		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];

		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		self.LICENSE_STATE	 	:= src_st;

		self.TYPE_CD					:= 'GR';
		
		//Clean and parse Org_name
		//DBA is actually first name prior to '/' and org_name is second name
		trim_org_name					:= ut.CleanSpacesAndUpper(L.ORG_NAME);
		// ClnParen1						:= StringLib.StringFindReplace(trim_org_name,'(','');
		// ClnParen2						:= StringLib.StringFindReplace(ClnParen1,')','');
		// slashchar 					:= StringLib.stringfind(ClnParen2,'/',1);
		// getCorpOnly					:= IF(REGEXFIND('/', ClnParen2),ClnParen2[slashchar..],ClnParen2); //get names without DBA names
		rmv_slashchar					:= If(StringLib.stringfind(trim_org_name,'/',1)> 0 and NOT StringLib.stringfind(trim_org_name,'D/B/A',1)> 0, 
																	StringLib.StringFindReplace(trim_org_name,'/',' '),trim_org_name);
		getCorpOnly						:= IF(REGEXFIND(DBApattern, rmv_slashchar),Prof_License_Mari.mod_clean_name_addr.GetCorpName(rmv_slashchar),rmv_slashchar); //get names without DBA names
		std_org_name					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('/',getCorpOnly,''));	//business name with standard corp abbr.
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(std_org_name);
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(std_org_name);
		self.NAME_ORG					:= IF(REGEXFIND(IPpattern,std_org_name),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',std_org_name,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',std_org_name,' CO')));   //Without punct. and Sufx removed
		self.NAME_ORG_SUFX 		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
		
	 //get names with DBA prefix
		// temp_dba_name				:= IF(REGEXFIND('/', trim_org_name),trim_org_name[..slashchar-1],' ');
		temp_dba_name					:= IF(REGEXFIND(DBApattern, trim_org_name),Prof_License_Mari.mod_clean_name_addr.GetDBAName(trim_org_name),'');
		tmpNameDBA						:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_dba_name); //business name with standard corp abbr.
		tmpNameDBASufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameDBA);
		self.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameDBA); //split corporation prefix from name
		self.NAME_DBA					:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameDBA,' CO')));
		self.NAME_DBA_SUFX		:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		self.DBA_FLAG					:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		tempLicNum           	:= ut.CleanSpacesAndUpper(L.SLNUM);
		self.LICENSE_NBR	   	:= IF(tempLicNum = '','NR',tempLicNum);
		
		self.RAW_LICENSE_STATUS	:= 'A';  //All records are active
		self.STD_LICENSE_STATUS	:= 'A';  //All records are active
		self.STD_STATUS_DESC		:= '';
		tempLicType						:= ut.CleanSpacesAndUpper(L.OFFTYPE);
		self.RAW_LICENSE_TYPE := tempLicType;
		self.STD_LICENSE_TYPE	:= map(Stringlib.stringfind(tempLicType,'FIRST LIEN MORTGAGE LENDER',1) > 0=> 'FLML',
																	Stringlib.stringfind(tempLicType,'SUBORDINATE LIEN MORTGAGE LENDING',1) > 0 => 'SLML','');
		// Use default date of 17530101 for blank dates.  Expires 01/31 every year
		SELF.CURR_ISSUE_DTE		:= '17530101';
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		next_year 						:= ((integer2) StringLib.GetDateYYYYMMDD()[1..4])+1;
		self.EXPIRE_DTE				:= MAP(self.LAST_UPD_DTE[1..4] < SELF.PROCESS_DATE[1..4] 
																		and self.LAST_UPD_DTE[5..8] < '0131' => self.LAST_UPD_DTE[1..4] +'0131',
																 self.LAST_UPD_DTE[1..4] < SELF.PROCESS_DATE[1..4] 
																		and self.LAST_UPD_DTE[5..8] > '0131' => SELF.PROCESS_DATE[1..4]  +'0131',		
																self.LAST_UPD_DTE[5..8]< '0131' => StringLib.GetDateYYYYMMDD()[1..4]+'0131',
																self.LAST_UPD_DTE[5..8] > '0131' => (string4)next_year+'0131','17530101');
		
		self.ADDR_BUS_IND			:= IF(TRIM(L.ADDRESS1) != ' ','B',' ');
		self.NAME_ORG_ORIG		:= TRIM(trim_org_name,LEFT,RIGHT);
		SELF.NAME_FORMAT			:= IF(TRIM(self.NAME_ORG_ORIG)<>'','F','');
		self.NAME_MARI_ORG		:= IF(TRIM(std_org_name)!='',TRIM(std_org_name,LEFT,RIGHT),'');
		self.NAME_MARI_DBA		:= temp_dba_name;
		
		//Clean phone and removenon-numerics
		self.PHN_MARI_1				:= REGEXREPLACE('-',TRIM(L.TELE),'');					//PHN_MARI_1: phone number provided by vendor before cleaning.
																																				//However, we need to remove - so that this field has enough
																																				//room to store extension.
		self.PHN_PHONE_1			:= StringLib.StringFilter(L.TELE,'0123456789');
		// self.PHN_MARI_2				:= StringLib.StringFilter(L.IN_PHONE,'0123456789'); //temporary for affiliation comparison
		
		//Use address cleaner to clean address
		RemovePattern	  := '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$|' +
					 '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
					 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^ATTN.*$|' +
					 '^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|' +
					 '^C-21 .*$|^PRUDENTIAL .*$|^.* REALTORS$|^.* PROPERTIES$|' +
					 '^SACKS$|^.* AT GLACIER$|^.* RENTALS$|^.* BY WYNDHAM$|^.* OFFICE$|GENERAL DELIVERY| VISTA VILLAGE$|' +
					 '^.* BUILDING$|^.* LAKE RESORT$' +
					 ')';

    trimAddress1        	:= ut.CleanSpacesAndUpper(L.ADDRESS1);
		trimCity							:= ut.CleanSpacesAndUpper(L.CITY);
		trimState							:= ut.CleanSpacesAndUpper(L.STATE);
		tmpZip	            	:= MAP(LENGTH(TRIM(L.ZIP))=3 => '00'+TRIM(L.ZIP),
																 LENGTH(TRIM(L.ZIP))=4 => '0'+TRIM(L.ZIP),
																 TRIM(L.ZIP));
  		
	  //Extract company name
		clnAddress1						:= Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(trimAddress1, RemovePattern);

		//Prepare the input to address cleaner
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(trimCity+' '+trimState+' '+tmpZip); 
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and tmpADDR_ADDR2_1 != '',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),trimCity);
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),trimState);
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),tmpZip[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		
		ClnCounty							:= ut.CleanSpacesAndUpper(L.COUNTY);
		self.ADDR_CNTY_1			:= IF(TRIM(ClnCounty,LEFT,RIGHT) = 'OUT-OF-STATE','',ClnCounty);
		// self.ADDR_CITY_2			:= ut.CleanSpacesAndUpper(REGEXREPLACE(',',L.IN_CITY,'')); //temporary for affiliation comparison
		
		// Expected codes [CO,BR]
		self.AFFIL_TYPE_CD		:= IF(self.TYPE_CD = 'GR','CO','');	
		self.PROVNOTE_3 	    := '{LICENSE_STATUS ASSIGNED}';	

		/* fields used to create mltreckey key are:
		 license number
		 license type
		 source update
		 name
		 address_1
		 dba
		 officename
		*/				 
		SELF.MLTRECKEY 				:= 0; //This file doesn't have multiple DBA's
				
		/* fields used to create cmc_slpk unique key are :
		license number
		office license number
		license type
		source update
		standard name_org w/o DBA
		raw address */	
		SELF.CMC_SLPK     		:= hash64(trim(self.license_nbr,left,right)
																		+trim(self.std_source_upd,left,right)
																		+trim(self.NAME_ORG_ORIG,left,right)
																		+trim(self.ADDR_ADDR1_1,left,right)
																		+trim(L.CITY,left,right)
																		+trim(L.STATE,left,right)
																		+trim(L.ZIP,left,right));
		
		SELF 									:= [];	
		
	END;

	ds_map := PROJECT(ds_mtg_lender, transformToCommon(left));

// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layout_base_in trans_lic_type(ds_map L, Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
end;

ds_map_lic_trans := JOIN(ds_map, Cmvtranslation,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		
//No Longer Valid
//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
//Use IN_CITY and IN_PHONE in comparison then blank out the temporary fields they were assigned to
// company_only_lookup := ds_map_source_desc(affil_type_cd='CO');

// Prof_License_Mari.layouts_reference.MARIBASE	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	// self.pcmc_slpk 		:= R.cmc_slpk;
	// self.PHN_MARI_1		:= IF(TRIM(L.PHN_MARI_1,LEFT,RIGHT) = ' ',L.PHN_MARI_2,L.PHN_MARI_1);
	// self.PHN_MARI_2		:= '';
	// self.ADDR_CITY_2	:= '';
	// self := L;
// end;

// ds_map_affil := join(ds_map_source_desc, company_only_lookup,
						// TRIM(left.name_org[1..50],left,right)	= TRIM(right.name_org[1..50],left,right)
						// AND TRIM(left.PHN_MARI_2,LEFT,RIGHT) = TRIM(right.PHN_MARI_1,LEFT,RIGHT)
						// AND TRIM(left.ADDR_CITY_2,LEFT,RIGHT) = TRIM(right.ADDR_CITY_1,LEFT,RIGHT)
						// AND left.AFFIL_TYPE_CD = 'BR',
						// assign_pcmcslpk(left,right),left outer,lookup);																		

// Prof_License_Mari.layouts_reference.MARIBASE	xTransPROVNOTE(ds_map_affil L) := transform
	// self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
							// TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
						   // L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
							// 'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

	// self := L;
	// end;

	// OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

	d_final 						:= output(ds_map_lic_trans, ,mari_dest+pVersion +'::'+src_cd ,__compressed__,overwrite);			
			
	// add_super 					:= sequential(fileservices.startsuperfiletransaction(),
																		// fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
																		// fileservices.finishsuperfiletransaction()
																		// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans);
	
	move_to_used				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'mtg_lender','using','used');	
												 );

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oMtg, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);
	

END;

