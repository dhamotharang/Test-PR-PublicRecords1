//************************************************************************************************************* */	
//  The purpose of this development is take MO Real Estate raw files and convert them to a 
//  common professional license (MARIFLAT_out) layout to be used for MARI, and PL_BASE development.
//************************************************************************************************************* */

import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;
#workunit('name','Yogurt: map_MOS0820_conversion');

EXPORT map_MOS0820_conversion(STRING pVersion) := FUNCTION

	code 								:= 'MOS0820';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	MD_Lic_types := ['IAS','INB','BRA','BRO','BRP','BRS','PCB','PCS','SAL','BRK','SCG','RSL','RAP', 'ACM'];

	//Move file from sprayed to using
	move_to_using := PARALLEL(
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'bra','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'bro','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'brp','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'brs','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'pcb','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'pcs','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rea','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rec','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rpf','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'sal','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'brk','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'ias','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'inb','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rap','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'rsl','sprayed', 'using');	
														Prof_License_Mari.func_move_file.MyMoveFile(code, 'scg','sprayed', 'using');
														);

	//MO input files
	ds_MO_RealEstate	:= Prof_License_Mari.files_MOS0820.RealEstate;
	ds_MO_Appraiser 	:= Prof_License_Mari.files_MOS0820.Appraiser;

	//Dataset reference files for lookup joins
	// ds_License_Desc	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0820');
	// ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
	// ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;
	// ds_Src_Desc			:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0820');
	ds_Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Pattern for DBA
	DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A |AKA )(.*)';
	CoPattern		:= '(^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.*APPRAISAL$|^.*APPRAISALS$|' +
	               '^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|' +
								 '^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$' +
	               ')';
	//Pattern for Internet companies
	IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

	//Date Pattern
	Datepattern := '^(.*)-(.*)-(.*)$';

	//Combine files into one common layout
	Prof_License_Mari.layout_MOS0820.RealEstate map_appraiser(Prof_License_Mari.layout_MOS0820.Appraiser L) := TRANSFORM
		self	:= L;
		self	:= [];
	END;

	ds_map_appraiser	:= project(ds_MO_Appraiser, map_appraiser(left));

	ds_MO_combined	:= ds_MO_RealEstate + ds_map_appraiser;
	oRE							:= OUTPUT(ds_MO_RealEstate);
	cRE							:= COUNT(ds_MO_RealEstate);
	oApr						:= OUTPUT(ds_map_appraiser);
	cApr						:= COUNT(ds_map_appraiser);
	
	//MO Real Estate/Appraisers layout to Common
	Prof_License_Mari.layouts.base	transformToCommon(Prof_License_Mari.layout_MOS0820.RealEstate L) := TRANSFORM
	
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

		tempLastName					:= IF(TRIM(L.PRC_LAST_NAME,LEFT,RIGHT)='\'',' ',TRIM(L.PRC_LAST_NAME,LEFT,RIGHT));
		tempTypeCd						:= IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) != ' ' AND TRIM(tempLastName,LEFT,RIGHT) != ' ', 'MD','GR'); 
		SELF.TYPE_CD					:= tempTypeCd;
	
		//Clean and parse Org_name
		tempIndvName					:= IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) != ' ' AND tempLastName != ' ' AND tempTypeCd != 'GR',
																StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempLastName+' '+L.PRC_FIRST_NAME)),
																IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) != ' ' AND tempLastName != ' ' AND tempTypeCd = 'GR',
																	 StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.PRC_FIRST_NAME+' '+L.PRC_MIDDLE_NAME+' '+tempLastName+' '+L.PRC_SUFFIX)),' '));
		tempBusName						:= IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) = ' ' AND tempLastName != ' ',
																StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(tempLastName)),
																IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) = ' ' AND TRIM(L.PRC_ENTITY_NAME,LEFT,RIGHT) != ' ',
																	 StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.PRC_ENTITY_NAME)),' '));
		std_org_name 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tempBusName);
		tmpNameOrgSufx				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(std_org_name);
		clnBusName						:= IF(REGEXFIND(IPpattern,std_org_name),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(std_org_name),
																Prof_License_Mari.mod_clean_name_addr.cleanFName(std_org_name));
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(std_org_name);
		self.NAME_ORG					:= IF(self.TYPE_CD = 'GR',REGEXREPLACE(' COMPANY',clnBusName,' CO'),
																Prof_License_Mari.mod_clean_name_addr.strippunctMisc(REGEXREPLACE('[0-9]',tempIndvName,'')));
		self.NAME_ORG_SUFX 		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));

		//Get contact from address1
		tempContact					:= MAP(REGEXFIND(DBApattern,StringLib.StringToUpperCase(L.BA_ADDRESS1))
																=> REGEXFIND(DBApattern,StringLib.StringToUpperCase(L.BA_ADDRESS1),0),
															 REGEXFIND(CoPattern,StringLib.StringToUpperCase(L.BA_ADDRESS1))
																=> REGEXFIND(CoPattern,StringLib.StringToUpperCase(L.BA_ADDRESS1),1),	
		                           '');
		tempContact2				:= MAP(REGEXFIND(DBApattern,StringLib.StringToUpperCase(L.REL_ADDRESS1))
																=> REGEXFIND(DBApattern,StringLib.StringToUpperCase(L.REL_ADDRESS1),0),
															 REGEXFIND(CoPattern,StringLib.StringToUpperCase(L.REL_ADDRESS1))
																=> REGEXFIND(CoPattern,StringLib.StringToUpperCase(L.REL_ADDRESS1),1),	
		                           '');
		IsIndv							:= IF(Prof_License_Mari.func_is_company(REGEXREPLACE('C/O|ATTN',tempContact,'')) = true,' ',
															Prof_License_Mari.mod_clean_name_addr.cleanFMLName(tempContact));

		//DBA Names
		temp_dba_name				:= IF(tempTypeCd = 'GR' AND TRIM(L.REL_FIRST_NAME,LEFT,RIGHT) = ' ' AND TRIM(L.REL_ENTITY_NAME,LEFT,RIGHT) != ' ',
															L.REL_ENTITY_NAME,' ');
		clnDBA_name					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('/',temp_dba_name,' '));
		tmpNameDBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(clnDBA_name); //business name with standard corp abbr.
		tmpNameDBASufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(clnDBA_name);
		self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(clnDBA_name); //split corporation prefix from name
		self.NAME_DBA				:= IF(REGEXFIND(IPpattern,tmpNameDBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(tmpNameDBA),
													Prof_License_Mari.mod_clean_name_addr.cleanFName(tmpNameDBA));
		self.NAME_DBA_SUFX	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameDBASufx, ''));
		self.DBA_FLAG				:= IF(trim(self.NAME_DBA) != ' ', 1, 0); // 1: true  0: false
		
		//Parsed Name
		self.NAME_FIRST			:= IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) != ' ' AND tempLastName != ' ',
														Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.PRC_FIRST_NAME),'');
		self.NAME_MID				:= IF(TRIM(L.PRC_MIDDLE_NAME,LEFT,RIGHT) != ' ',
														Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.PRC_MIDDLE_NAME),'');
		self.NAME_LAST			:= IF(TRIM(L.PRC_FIRST_NAME,LEFT,RIGHT) != ' ' AND tempLastName != ' ',
														Prof_License_Mari.mod_clean_name_addr.TrimUpper(tempLastName),'');
		self.NAME_SUFX			:= IF(TRIM(L.PRC_SUFFIX,LEFT,RIGHT) != ' ',
														Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.PRC_SUFFIX),'');
		
		tempLicNum           := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.LIC_NUMBER);
		self.LICENSE_NBR	   := tempLicNum;
		self.LICENSE_STATE	 := src_st;			

		// initialize raw_license_type from raw data
		tempRawType  					:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.LIC_PROFESSION);												 
		self.RAW_LICENSE_TYPE := tempRawType;
		tempStdType						:= tempRawType;
		self.STD_LICENSE_TYPE := tempStdType;
		
		// initialize raw_license_status from raw data
		tempLicStatus						:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.STATUS);
		self.RAW_LICENSE_STATUS	:= IF(tempRawType in ['IAS','INB'] AND tempLicStatus = 'ACTIVE','INACTIVE ACTIVE',tempLicStatus);
	
		// assigning dates per business rules
		tempExpYr            := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_EXP_DATE),1),LEFT,RIGHT);
		tempExpMon					 := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_EXP_DATE),2),LEFT,RIGHT);
		TempExpDay					 := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_EXP_DATE),3),LEFT,RIGHT);
		self.EXPIRE_DTE		   := IF(TRIM(L.LIC_EXP_DATE) != ' ',tempExpYr+tempExpMon+TempExpDay,'17530101');
		tempOrigIssYr        := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_ORIG_ISSUE_DATE),1),LEFT,RIGHT);
		tempOrigIssMon			 := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_ORIG_ISSUE_DATE),2),LEFT,RIGHT);
		TempOrigIssDay			 := TRIM(REGEXFIND(Datepattern,TRIM(L.LIC_ORIG_ISSUE_DATE),3),LEFT,RIGHT);
		self.ORIG_ISSUE_DTE  := IF(REGEXFIND('^[0-9]{8}$',tempOrigIssYr+tempOrigIssMon+TempOrigIssDay),
		                           tempOrigIssYr+tempOrigIssMon+TempOrigIssDay,
															 '17530101');
		//self.ORIG_ISSUE_DTE  := '17530101';
		self.CURR_ISSUE_DTE  := '17530101';
		
		self.ADDR_BUS_IND			:= IF(TRIM(L.BA_ADDRESS1) != ' ','B',' ');
		self.NAME_ORG_ORIG		:= IF(tempIndvName != ' ',
																StringLib.StringCleanSpaces(
																  Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(
																	  tempLastName+IF(L.PRC_SUFFIX<>'',' '+L.PRC_SUFFIX,'')+', '+L.PRC_FIRST_NAME+' '+L.PRC_MIDDLE_NAME)),
																tempBusName);
		self.NAME_FORMAT			:= IF(self.TYPE_CD = 'GR','F','L');
		
		//IF ba_address = name, move br_address2 to br_address1.
/* 		CleanAddr1						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_ADDRESS1);
   		preAddress1						:= IF(REGEXFIND('^C/O',CleanAddr1),REGEXREPLACE('^C/O',CleanAddr1,''),CleanAddr1);
   		clnAddress1						:= StringLib.StringCleanSpaces(
   																	          Prof_License_Mari.mod_clean_name_addr.strippunctMisc(preAddress1));
   		cleanAddr2						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_ADDRESS2);
   		preAddress2						:= IF(REGEXFIND('^C/O',CleanAddr2),REGEXREPLACE('^C/O',CleanAddr2,''),CleanAddr2);
   		clnAddress2						:= StringLib.StringCleanSpaces(
   																	          Prof_License_Mari.mod_clean_name_addr.strippunctMisc(preAddress2));
   		tempAddr1							:= MAP(tempContact='' AND cleanAddr2='' => CleanAddr1,
   															   tempContact!='' AND cleanAddr2!='' => clnAddress2, 
   																 REGEXFIND('( INC$| LLC$)',CleanAddr1) => clnAddress2,
   																 tempContact='' AND cleanAddr2!='' AND NOT REGEXFIND('^([0-9]+|ONE |TWO |P[ ]*O |BOX |RT )',CleanAddr1)
   																   => clnAddress2,
   																 clnAddress1);
*/
		// self.ADDR_ADDR1_1			:= tempAddr1;
		// tempAddr2							:= MAP(TRIM(self.ADDR_ADDR1_1)=clnAddress2 => '',
			//													  REGEXFIND('ATTN:', cleanAddr2) => '',
				//												  clnAddress2);
		// self.ADDR_ADDR2_1			:= tempAddr2;
		// self.ADDR_CITY_1		  := IF(TRIM(L.BA_CITY) != ' ',Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_CITY),' ');
		// self.ADDR_STATE_1			:= IF(TRIM(L.BA_STATE) != ' ',Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_STATE),' ');
		// tempZip2							:= IF(TRIM(L.BA_ZIP) != ' ',TRIM(L.BA_ZIP,left,right)[1..5],' ');
		// self.ADDR_ZIP5_1		  := tempZip2;
		// self.ADDR_ZIP4_1		  := IF(StringLib.StringFind(tempZip2,'-',1)>0,TRIM(tempZip2,left,right)[7..11],
																 // TRIM(tempZip2,left,right)[6..10]);
		// self.ADDR_CNTY_1			:= IF(self.ADDR_BUS_IND != ' ' AND Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.BA_CNTY) != 'UNKNOWN/OUT OF STATE',
																// Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.BA_CNTY),' ');	
		//The following temp fields attempt to remove the contact name from address 
		//Put in name_contact_last/office for further cleaning
		trimAddr_1						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_ADDRESS1);
		trimAddr_2						:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_ADDRESS2);
		//tmpNameContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_1); //Get contact name from address
		tmpNameContact1				:= MAP(REGEXFIND(CoPattern, trimAddr_1) => REGEXFIND(CoPattern, trimAddr_1, 1),
		                             REGEXFIND('C/O DOAH', trimAddr_1) => 'C/O DOAH',
		                             //Prof_License_Mari.mod_clean_name_addr.GetContactName(trimAddr_1)<>''
																 //  => Prof_License_Mari.mod_clean_name_addr.GetContactName(trimAddr_1),
		                             Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_1)<>''
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_1), //Get contact name from address
																 '');
		tmpNameContact2				:= MAP(REGEXFIND(CoPattern, trimAddr_2) => REGEXFIND(CoPattern, trimAddr_2, 1),
		                             //Prof_License_Mari.mod_clean_name_addr.GetContactName(trimAddr_2)<>''
																 //  => Prof_License_Mari.mod_clean_name_addr.GetContactName(trimAddr_2),
		                             Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_2)<>''
																   => Prof_License_Mari.mod_clean_name_addr.GetDBAName(trimAddr_2), //Get contact name from address
																 '');
		clnAddr_1							:= IF(tmpNameContact1<>'',REGEXREPLACE(tmpNameContact1, trimAddr_1, ''), trimAddr_1);
		clnAddr_2							:= IF(tmpNameContact2<>'',REGEXREPLACE(tmpNameContact2, trimAddr_2, ''), trimAddr_2);
		//temp_preaddr1 				:= StringLib.StringCleanSpaces(trimAddr_1+' '+trimAddr_2); //Concat addr1 and addr2 for cleaning
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddr_1+' '+clnAddr_2); //Concat addr1 and addr2 for cleaning
		temp_preaddr2 				:= StringLib.StringCleanSpaces(L.BA_CITY+' '+L.BA_STATE +' '+L.BA_ZIP); //Concat city, state, zipe for cleaning
		clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(temp_preaddr1,temp_preaddr2); //Address cleaner to remove 'c/o' and 'attn' from address
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
		AddrWithContact				:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	 //Uses addr_2 if addr_1 contains a contact name, then blanks addr_2
		self.ADDR_ADDR1_1			:= IF(AddrWithContact != ' ' and trimAddr_2 != '',StringLib.StringCleanSpaces(trimAddr_2),
																StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));	
		self.ADDR_ADDR2_1			:= IF(AddrWithContact != '','',StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1		  := IF(TRIM(clnAddrAddr1[65..89])<>'',TRIM(clnAddrAddr1[65..89]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_CITY));
		SELF.ADDR_STATE_1		  := IF(TRIM(clnAddrAddr1[115..116])<>'',TRIM(clnAddrAddr1[115..116]),Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.BA_STATE));
		SELF.ADDR_ZIP5_1		  := IF(TRIM(clnAddrAddr1[117..121])<>'',TRIM(clnAddrAddr1[117..121]),TRIM(L.BA_ZIP,left,right)[1..5]);
		SELF.ADDR_ZIP4_1		  := clnAddrAddr1[122..125];
		self.ADDR_CNTY_1			:= IF(self.ADDR_BUS_IND != ' ' AND Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.BA_CNTY) != 'UNKNOWN/OUT OF STATE',
																Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.BA_CNTY),' ');
		//IF rel_address != ba_address then rel_address = addr_addr1_2 else blank
		CleanAddr1_2					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_ADDRESS1);
		cleanAddr2_2					:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_ADDRESS2);
		IsMailingAddr					:= IF(trimAddr_1 != CleanAddr1_2
																	AND CleanAddr1_2 != ' ','M',' ');
		self.ADDR_MAIL_IND		:= IsMailingAddr;
		tempAddr1_2							:= IF(IsMailingAddr != 'M',' ',
																IF(IsMailingAddr = 'M' AND tempContact2 = ' ' AND cleanAddr2_2 = ' ',CleanAddr1_2,
																	IF(IsMailingAddr = 'M' AND tempContact2 != ' ' AND cleanAddr2_2 != ' ',cleanAddr2_2,
																		IF(IsMailingAddr = 'M' AND tempContact2 = ' ' AND cleanAddr2_2 != ' ' AND NOT REGEXFIND('^([0-9]+|ONE |TWO |P[ ]*O |BOX |RT )',CleanAddr1_2),CleanAddr2_2,CleanAddr1_2))));
		self.ADDR_ADDR1_2			:= IF(REGEXFIND('^.* LLC$',tempAddr1_2),'',tempAddr1_2);
		tempAddr2_2						:= IF(IsMailingAddr != 'M',' ',
															IF(IsMailingAddr = 'M' AND tempContact2 != ' ' AND cleanAddr2_2 != ' ',' ',
																IF(IsMailingAddr = 'M' AND tempContact2 = ' ' AND cleanAddr2_2 != ' ' AND NOT REGEXFIND('^([0-9]+|ONE |TWO |P[ ]*O |BOX |RT )',CleanAddr1_2),CleanAddr1_2,CleanAddr2_2)));
		self.ADDR_ADDR2_2			:= IF(REGEXFIND('(^ATTN|^C/O)',tempAddr2_2),'',tempAddr2_2);
		self.ADDR_CITY_2		  := IF(self.ADDR_MAIL_IND = 'M' AND TRIM(L.REL_CITY) != ' ',Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_CITY),' ');
		self.ADDR_STATE_2			:= IF(self.ADDR_MAIL_IND = 'M' AND TRIM(L.REL_STATE) != ' ',Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_STATE),' ');
		tempZip2_2							:= IF(IsMailingAddr = 'M' AND TRIM(L.REL_ZIP) != ' ',TRIM(L.REL_ZIP,left,right)[1..5],' ');
		self.ADDR_ZIP5_2		  := IF(LENGTH(TRIM(tempZip2_2))=4,'0'+tempZip2_2,tempZip2_2);
		self.ADDR_ZIP4_2		  := IF(StringLib.StringFind(tempZip2_2,'-',1)>0,TRIM(tempZip2_2,left,right)[7..11],
																 TRIM(tempZip2_2,left,right)[6..10]);
			
		//If ATTN: or C/O is in address field, move to contact name
		self.NAME_CONTACT_FIRST	:= IF(tempTypeCd = 'GR' AND TRIM(L.REL_FIRST_NAME) != ' ',Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.REL_FIRST_NAME),
																	IF(IsIndv != ' ',IsIndv[6..25],' '));
		self.NAME_CONTACT_MID		:= IF(tempTypeCd = 'GR' AND TRIM(L.REL_MIDDLE_NAME) != ' ',Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.REL_MIDDLE_NAME),
																	IF(IsIndv != ' ',IsIndv[26..45],' '));
		self.NAME_CONTACT_LAST	:= IF(tempTypeCd = 'GR' AND TRIM(L.REL_FIRST_NAME) != ' ',Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.REL_LAST_NAME),
																	IF(IsIndv != ' ',IsIndv[46..65],' '));
		self.NAME_CONTACT_SUFX	:= IF(tempTypeCd = 'GR' AND TRIM(L.REL_SUFFIX) != ' ',Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(L.REL_SUFFIX),
																	IF(IsIndv != ' ',IsIndv[66..70],' '));
		self.NAME_CONTACT_TTL		:= IF(tempRawType in ['RPF','REC','REA'] AND self.NAME_CONTACT_FIRST != ' ','DESIGNATED BROKER','');

		OfficeName							:= MAP(tempTypeCd='MD' AND TRIM(L.REL_FIRST_NAME,LEFT,RIGHT)='' AND TRIM(L.REL_ENTITY_NAME,LEFT,RIGHT)!=' '
																		 => L.REL_ENTITY_NAME,
																	 tempTypeCd='MD' AND tmpNameContact1<>'' => tmpNameContact1, 
																	 tempTypeCd='MD' AND tmpNameContact2<>'' => tmpNameContact2, 
																	 ' ');
		temp_OfficeName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.TrimUpper(OfficeName));
		stdOfficeName						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName));
		self.NAME_OFFICE				:= IF(REGEXFIND('.COM',stdOfficeName),stdOfficeName,REGEXREPLACE(' COMPANY',stdOfficeName,' CO'));
		self.OFFICE_PARSE				:= MAP(self.NAME_OFFICE<>'' AND Prof_License_Mari.func_is_company(self.NAME_OFFICE)
		                                 => 'GR',
																	 self.NAME_OFFICE<>'' AND NOT Prof_License_Mari.func_is_company(self.NAME_OFFICE)
																	   => 'MD',
																	 '');	 

	//self.provnote_1:= trimAddr_1+'|'+trimAddr_2+'|'+trim(self.ADDR_ADDR1_1)+'|'+trim(self.ADDR_ADDR2_1);
	//self.provnote_2:= tmpNameContact1;
	//self.provnote_3:= tmpNameContact2;
	

		self.NAME_DBA_ORIG		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(temp_dba_name);
		self.NAME_MARI_ORG		:= IF(self.TYPE_CD = 'GR',REGEXREPLACE('/',clnBusName,' '),
																IF(self.TYPE_CD = 'MD' AND TRIM(stdOfficeName) != ' ',self.NAME_OFFICE,' '));	
		self.NAME_MARI_DBA	  := IF(self.NAME_DBA != ' ',tmpNameDBA,' ');
		
		tempOffLicenseNbr			  := Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_LIC_NUMBER);
		self.OFF_LICENSE_NBR	  := tempOffLicenseNbr;	
		SELF.OFF_LICENSE_NBR_TYPE := IF(tempOffLicenseNbr<>'',
																	  Prof_License_Mari.mod_clean_name_addr.TrimUpper(L.REL_TYPE),'');  //REL_TYPE defines the relationship type
		
		//Expected codes [CO,BR,IN]
		self.AFFIL_TYPE_CD		:= IF(tempTypeCd = 'GR', 'CO', 'IN');
		
		/* fields used to create mltreckey key are:
	 license number
	 license type
	 source update
	 name
	 address_1
	 dba
	 officename
		*/
				 
		self.mltreckey := 0; //This file doesn't have multiple DBA's
		
		/* fields used to create cmc_slpk unique key are :
		license number
		license type
		source update
		standard name_org
		raw address */	
		//Use hash64 instead of hash32
		self.CMC_SLPK     := hash64(trim(self.license_nbr,left,right)
																+trim(self.std_license_type,left,right)
																+trim(self.std_source_upd,left,right)
																+trim(self.NAME_ORG,left,right)
																+trim(self.ADDR_ADDR1_1,left,right)
																+trim(self.ADDR_ADDR2_1,left,right)
																+trim(L.BA_CITY,left,right)
																+trim(L.BA_STATE,left,right)
																+trim(L.BA_ZIP,left,right));
		self	:= [];
	END;

	ds_map := project(ds_MO_combined, transformToCommon(left))(name_org+name_office<>'');

	//Clean office name from address2 field
	Prof_License_Mari.layouts.base trans_officename(ds_map L) := transform
		OfficeInAddress		:= IF(Prof_License_Mari.func_is_company(L.ADDR_ADDR2_1) = true,L.ADDR_ADDR2_1,' ');
		Officename				:= IF(L.TYPE_CD = 'MD' AND TRIM(L.NAME_OFFICE) = ' ' AND OfficeInAddress != ' ',
														Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(REGEXREPLACE('/',OfficeInAddress,' ')),REGEXREPLACE('/',L.NAME_OFFICE,' '));
		self.NAME_OFFICE	:= IF(REGEXFIND('.COM',Officename),Officename,
														Prof_License_Mari.mod_clean_name_addr.strippunctName(REGEXREPLACE(' COMPANY',Officename,' CO')));
		self.ADDR_ADDR2_1	:= IF(OfficeInAddress != ' ',' ',L.ADDR_ADDR2_1);
		self.NAME_MARI_ORG := IF(L.NAME_MARI_ORG = ' ' AND self.NAME_OFFICE != ' ', self.NAME_OFFICE,L.NAME_MARI_ORG);
		self	:= L;
	end;

	//ds_map_officename	:= project(ds_map, trans_officename(left));

	// populate prof code field via translation on license type field
	Prof_License_Mari.layouts.base trans_lic_type(ds_map L, ds_Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_lic_trans := join(ds_map, ds_Cmvtranslation,
																left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_TYPE' AND StringLib.StringToUpperCase(trim(left.STD_LICENSE_TYPE,left,right))=trim(right.fld_value,left,right),
																			trans_lic_type(left,right),left outer,lookup);
	Prof_License_Mari.layouts.base trans_status_trans(ds_map_lic_trans L, ds_Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_status_trans := join(ds_map_lic_trans, ds_Cmvtranslation,
																left.STD_SOURCE_UPD=right.source_upd AND right.fld_name='LIC_STATUS' AND StringLib.StringToUpperCase(trim(left.RAW_LICENSE_STATUS,left,right))=trim(right.fld_value,left,right),
																			trans_status_trans(left,right),left outer,lookup);


/*																		
// look up prof code description
Prof_License_Mari.layouts_reference.MARIBASE trans_prof_desc(ds_map_lic_trans L, ds_Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := join(ds_map_lic_trans, ds_Prof_Desc,
															StringLib.StringToUpperCase(trim(left.std_prof_cd,left,right))=trim(right.prof_cd,left,right),
																		trans_prof_desc(left,right),left outer,lookup);
																		
*/

/*
// look up license status description
Prof_License_Mari.layouts_reference.MARIBASE trans_status_desc(ds_map_status_trans L, ds_Status_Desc R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
	self := L;
end;

ds_map_status_desc := join(ds_map_status_trans, ds_Status_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_status,left,right))=trim(right.license_status,left,right),
																		trans_status_desc(left,right),left outer,lookup);
																		
																		
// look up license type description
Prof_License_Mari.layouts_reference.MARIBASE trans_type_desc(ds_map_status_desc L, ds_License_Desc R) := transform													
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
	self := L;
end;

ds_map_type_desc := join(ds_map_status_desc, ds_License_Desc,
															StringLib.StringToUpperCase(trim(left.std_license_type,left,right))=trim(right.license_type,left,right),
																		trans_type_desc(left,right),left outer,lookup);
																		
//look up standard source description
Prof_License_Mari.layouts_reference.MARIBASE trans_src_desc(ds_map_type_desc L, ds_Src_Desc R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
	self := L;
end;

ds_map_src_desc := join(ds_map_type_desc, ds_Src_Desc,
															StringLib.StringToUpperCase(trim(left.std_source_upd,left,right))=trim(right.src_nbr,left,right),
																		trans_src_desc(left,right),left outer,lookup); 
*/																		
	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_src_desc(affil_type_cd='CO');
	company_only_lookup := ds_map_status_trans(affil_type_cd='CO');

	//Perform affiliation lookup for affil_type_cd = 'IN'
	Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_status_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := IF(TRIM(L.affil_type_cd,LEFT,RIGHT) = 'IN',R.cmc_slpk,L.pcmc_slpk);
		self := L;
	end;

	ds_map_affil := join(ds_map_status_trans, company_only_lookup,
												trim(left.off_license_nbr,left,right)	= trim(right.license_nbr,left,right)
												and left.affil_type_cd = 'IN',
												assign_pcmcslpk(left,right),left outer,lookup);

	//remove dup records
	ds_map_deduped := dedup(sort(distribute(ds_map_affil,hash(cmc_slpk,name_org,license_nbr,std_license_type,addr_addr1_1)),record,local),record,all,local);

	//Discard records that do not have a license number											
	d_final := output(ds_map_deduped(TRIM(NAME_FIRST) != 'PRC_FIRST_NAME' AND TRIM(LICENSE_NBR,LEFT,RIGHT)!=' '),, mari_dest + pVersion + '::' + src_cd, __compressed__, overwrite);
			
	// add_super := sequential(fileservices.startsuperfiletransaction(),
													// fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
													// fileservices.finishsuperfiletransaction()
													// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_deduped(TRIM(NAME_FIRST) != 'PRC_FIRST_NAME' AND TRIM(LICENSE_NBR,LEFT,RIGHT)!=' '));
	
	move_to_used := PARALLEL(
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'bra','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'bro','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'brp','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'brs','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'pcb','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'pcs','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'rea','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'rec','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'rpf','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'sal','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'brk','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'ias','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'inb','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'rap','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'rsl','using','used');	
													Prof_License_Mari.func_move_file.MyMoveFile(code, 'scg','using','used');	
													);

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oRE, cRE, oApr, cApr, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;	

//export map_MOS0820_conversion := '';