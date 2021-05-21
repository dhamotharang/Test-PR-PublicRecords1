//California Real Estate Appraisers - CAS0847
import ut, Prof_License_Mari, lib_stringlib, lib_datalib;

EXPORT map_CAS0847_conversion(STRING pVersion) := FUNCTION
 
	code 								:= 'CAS0847';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';								
	//Dataset reference files for lookup joins
	Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);

	//Move input file from sprayed to using
	move_to_using				:= Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'sprayed', 'using');

	// Filter heading and records w/o ORG_NAME and SLNUM not populated
	ValidMTGFile	:= Prof_License_Mari.file_CAS0847.appraisers(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(FIRST_NAME))
	                                                           AND TRIM(FIRST_NAME+LAST_NAME)<>''
																														 );
	oFile					:= OUTPUT(ValidMTGFile);
	
	maribase_plus_dbas := record,maxlength(5000)
		Prof_License_Mari.layout_base_in;
		string60 dba;
		string60 dba1;
		string60 dba2;
		string60 dba3;
		string60 dba4;
		string60 dba5;
	end;

	//mortgage and lenders to MARIBASE layout
	maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_CAS0847 pInput) := TRANSFORM
	
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

		SELF.TYPE_CD		  		:= 'MD';
																			 			
		trimFName							:= ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
		trimLName							:= ut.CleanSpacesAndUpper(pInput.LAST_NAME);
		trimAddress      			:= ut.CleanSpacesAndUpper(pInput.mail_address);
		trimCity							:= ut.CleanSpacesAndUpper(pInput.mail_city);	
		trimState							:= ut.CleanSpacesAndUpper(pInput.mail_state);	
		trimZip								:= ut.CleanSpacesAndUpper(pInput.mail_zip);	
			
		// Identify NICKNAME in the various format 
		/*tempFNick							:= MAP(StringLib.stringfind(trimFName,'""',1) >0 
																	and REGEXFIND('^([A-Za-z ][^\\"]+)[\\"][\\"]([A-ZA-Z ][^\\"]+)[\\"][\\"]',trimFName) 
																	=> REGEXFIND('^([A-Za-z ][^\\"]+)[\\"][\\"]([A-ZA-Z ][^\\"]+)[\\"][\\"]',trimFName,2),
																	StringLib.stringfind(trimFName,'"',1) >0 
																	=> REGEXFIND('^([A-Za-z ][^\\"]+)[ ][\\"]([A-Za-z ][^\\"]+)[\\"][ ]([A-Za-z ].*)',trimFName,2),
																	StringLib.stringfind(trimFName,'(',1) >0 
																	and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)]',trimFName) 
																	=> REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)]',trimFName,2),' ');			
				
		tempLNick							:= MAP(StringLib.stringfind(trimLName,'""',1) >0 
																	and REGEXFIND('^([A-Za-z ][^\\"]+)[\\"][\\"]([A-ZA-Z ][^\\"]+)[\\"][\\"]',trimLName) 
																	=> REGEXFIND('^([A-Za-z ][^\\"]+)[\\"][\\"]([A-ZA-Z ][^\\"]+)[\\"][\\"]',trimLName,2),
																	StringLib.stringfind(trimLName,'"',1) >0 
																	=> REGEXFIND('^([A-Za-z ][^\\"]+)[ ][\\"]([A-Za-z ][^\\"]+)[\\"][ ]([A-Za-z ].*)',trimLName,2),
																	StringLib.stringfind(trimLName,'(',1) >0 
																	and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)][ ]([A-Za-z ].*)',trimLName)
																	=> REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)][ ]([A-Za-z ].*)',trimLName,2),
																	StringLib.stringfind(trimLName,'(',1) >0 
																	and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)]',trimLName) 
																	=> REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ][^\\)]+)[\\)]',trimLName,2),' ');
				
		//Removing NickName from Parsed First/Last Name fields
		removeFNick						:= IF(tempFNick != ' ',REGEXREPLACE(tempFNick,trimFName,''), trimFName);
		removeLNick						:= IF(tempLNick != ' ',REGEXREPLACE(tempLNick,trimLName,''), trimLName);
		
		cleanFNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
		cleanLNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick);
*/
		//Process nick names
		tempFNick							:= Prof_License_Mari.fGetNickname(trimFName,'nick');
		removeFNick						:= Prof_License_Mari.fGetNickname(trimFName,'strip_nick');
		cleanFNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeFNick);
		tempLNick							:= Prof_License_Mari.fGetNickname(trimLNAME,'nick');
		removeLNick						:= Prof_License_Mari.fGetNickname(trimLNAME,'strip_nick');
		cleanLNAME						:= Prof_License_Mari.mod_clean_name_addr.strippunctName(removeLNick);
			
		self.NAME_ORG 				:= IF(pInput.last_name != ' ',
																StringLib.StringCleanSpaces(TRIM(cleanLNAME) + ' ' + cleanFNAME),
																' ');
		
		// Prepping OFFICE_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
				
		// Populate if DBA exist in OFFICE NAME field	
		//trimOFFICE          	:= ut.CleanSpacesAndUpper(pInput.company_name);
		//Company name is not provided in the vendor file
/* 		trimOFFICE						:= ' ';
   		prepNAME_OFFICE				:= MAP(StringLib.StringFind(trimOffice,'N/I',1)>0 => '',
   																	StringLib.StringFind(trimOffice,'N/A',1)>0 => '', 
   																	StringLib.StringFind(trimOffice,'(DBA)',1)>0 => StringLib.StringFindReplace(trimOffice,'(DBA)','DBA'),
   																	trimOffice);
*/
		prepNAME_OFFICE				:= MAP(StringLib.StringFind(trimAddress,'(DBA)',1)>0 => StringLib.StringFindReplace(trimAddress,'(DBA)','DBA'),
		                             REGEXFIND('(^.* INC[\\.]?) ',trimAddress) => REGEXFIND('(^.* INC[\\.]?) ',trimAddress,1),
																 '');

			tempDBA							:= IF(StringLib.StringFind(prepNAME_OFFICE,'DBA',1)>0, Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
			   												' ');

			StdNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tempDBA);
			
			self.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);
			self.NAME_DBA				:= IF(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0, StdNAME_DBA,
																Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
			self.NAME_DBA_SUFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);
			self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
			
			
			tmpNAME_OFFICE			:= MAP(StringLib.StringFind(prepNAME_OFFICE,'JIM JONES APPRAISALS DBA',1)>0 =>  StringLib.StringFindReplace(prepNAME_OFFICE,'DBA',''),
																	StringLib.StringFind(prepNAME_OFFICE,'DBA',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																	prepNAME_OFFICE);
																									
			stripNAME_OFFICE		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(tmpNAME_OFFICE);
			self.NAME_OFFICE		:= IF(StringLib.StringFind(stripNAME_OFFICE,'/',1)>0, 
																StringLib.StringFindReplace(stripNAME_OFFICE,'/',' '),stripNAME_OFFICE);
			self.OFFICE_PARSE   := MAP(trim(self.name_office,left,right)!='' and Prof_License_Mari.func_is_company(self.name_office) => 'GR',
																	// StringLib.stringfind(TRIM(self.name_office,LEFT,RIGHT),'',1)<1 => 'GR',
																	trim(self.name_office,left,right)= '' => ' ', 'MD');
											
				
			self.NAME_FIRST 		:= cleanFName;
			self.NAME_MID   		:= ut.CleanSpacesAndUpper(pInput.MID_NAME);
			self.NAME_LAST  		:= cleanLName;
			
			stripNick						:= IF(StringLib.stringfind(tempLNick,'AKA',1)> 0,REGEXREPLACE('(AKA)',tempLNick,''),tempFNick);
			self.NAME_NICK			:= StringLib.StringCleanSpaces(stripNick);

			self.LICENSE_NBR	  := ut.CleanSpacesAndUpper(pInput.lic_num);
			self.LICENSE_STATE	:= src_st;
			self.RAW_LICENSE_TYPE := ut.CleanSpacesAndUpper(pInput.lic_lev);
			self.STD_LICENSE_TYPE := self.raw_license_type; 
				
			//Reformatting date from MM/DD/YYYY to YYYYMMDD	 									
			//self.CURR_ISSUE_DTE		:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUE_DATE);
			//Current issue date is not provided any more
			self.CURR_ISSUE_DTE	:= '17530101';
			self.ORIG_ISSUE_DTE	:= '17530101';
			self.EXPIRE_DTE			:= Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.DATE_EXPIRED);
	
			//license status is not provided in the input file anymore. Use expire_dte to determine if a license is still active
			SELF.RAW_LICENSE_STATUS := IF(self.EXPIRE_DTE >= pVersion,
																		'ACTIVE',
																		'LICENSE EXPIRED');
			//self.RAW_LICENSE_STATUS := ut.CleanSpacesAndUpper(pInput.license_status);

			self.ADDR_BUS_IND		:= IF(TRIM(pInput.mail_address + pInput.mail_zip,LEFT,RIGHT) != '','B','');
			//self.NAME_ORG_ORIG	:= IF(pInput.FULL_NAME != ' ',ut.CleanSpacesAndUpper(pInput.FULL_NAME),
			//Full name is not in the input file. 1/22/13 Cathy Tio
			self.NAME_ORG_ORIG	:= StringLib.StringCleanSpaces(TRIM(trimFName,LEFT,RIGHT) + IF(trimFName <> ' ',' ',' ')
																													+ TRIM(self.NAME_MID ,LEFT,RIGHT) + IF(self.NAME_MID  <> ' ',' ',' ')
																													+ TRIM(trimLName,LEFT,RIGHT));
			SELF.NAME_FORMAT		:= 'F';

			self.NAME_DBA_ORIG	:= ' ';
			self.NAME_MARI_ORG	:= stripNAME_OFFICE;
			self.NAME_MARI_DBA	:= IF(StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0, StdNAME_DBA,
																Prof_License_Mari.mod_clean_name_addr.strippunctName(StdNAME_DBA)); 
			self.PHN_PHONE_1    := IF(TRIM(pInput.PHONE,left,right) != '000-000-0000',ut.CleanPhone(pInput.phone),' ');
			self.PHN_MARI_1     := self.PHN_PHONE_1;		 
				
			// Address fields is could be populated with address1, address2, address3 separated by variations of comma(s), and semi-colon(s)
			tmpAddress1					:= IF(prepNAME_OFFICE<>'', REGEXREPLACE(prepNAME_OFFICE,trimAddress,''),trimAddress);
			//self.provnote_1 := 	trimAddress + '|' + 	prepNAME_OFFICE+ '|' + 	tmpAddress1;			 
			tmpAddress2					:= trimCity + ' ' + trimState + ' ' + trimZip;
			clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(tmpAddress1,tmpAddress2);
			tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
			tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
			AddrWithContact1		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
			SELF.ADDR_ADDR1_1		:= MAP(AddrWithContact1 != '' and tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
		SELF.ADDR_ADDR2_1			:= MAP(AddrWithContact1!='' => '',
																 tmpADDR_ADDR2_1='' => '',
																 REGEXFIND('^(PEAK .* LLC)$',tmpADDR_ADDR1_1, NOCASE)	=> '',
																 TRIM(tmpADDR_ADDR1_1)=TRIM(tmpADDR_ADDR2_1) => '',
															   StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr1[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr1[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr1[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr1[122..125];
		//SELF.provnote_2 := tmpAddress1 + '|' + tmpAddress2;
			
/* 			self.ADDR_ADDR1_1			:= MAP(StringLib.stringfind(trimAddress,',',1)>0 and StringLib.stringfind(trimAddress,'/',1)>0 =>
   																		REGEXREPLACE('/',trimAddress, ' '),
   																		StringLib.stringfind(trimAddress,',,',1)>0 => 
   																		REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)',trimAddress,1),
   																		StringLib.stringfind(trimAddress,', ,',1)>0 => 
   																		REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)',trimAddress,1),
   																		StringLib.stringfind(trimAddress,', #',1)>0 =>						
   																		REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([#]?[0-9A-Za-z ]*)',trimAddress,1),						
   																		StringLib.stringfind(trimAddress,',',1)>0 =>						
   																		REGEXFIND('^([\\#]?[0-9A-Za-z \'\\.\\"]+[ ]*.),[ ]*([\\# 0-9A-Za-z \\#\\-]+[ ]*.)', trimAddress,1),
   																		trimAddress);
   				 
   				self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(trimAddress,',,',1)>0 
   																		and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([\\#]?[0-9A-Za-z ]+[^\\,]*)[\\,]?',trimAddress) 
   																		=> 	REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([\\#]?[0-9A-Za-z ]+[^\\,]*)[\\,]?',trimAddress,2),
   																		StringLib.stringfind(trimAddress,', ,',1)>0 
   																		and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([\\# 0-9A-Za-z \\. \\# \\- \\& ][^\\,]+)',trimAddress)
   																		=> REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([\\# 0-9A-Za-z \\. \\# \\- \\& ][^\\,]+)',trimAddress,2),
   																		StringLib.stringfind(trimAddress,', #',1)>0 
   																		and REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([#]?[0-9A-Za-z ]*)',trimAddress)						
   																		=> 	REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([#]?[0-9A-Za-z ]*)',trimAddress,2),						
   																		StringLib.stringfind(trimAddress,',',1)>0 
   																		and REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([\\#]?[0-9A-Za-z ][^\\,]+)[\\,]?', trimAddress)
   																		=>	REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([\\#]?[0-9A-Za-z ][^\\,]+)[\\,]?', trimAddress,2),
   																		' ');
   													
   				self.ADDR_ADDR3_1			:= MAP(StringLib.stringfind(trimAddress,',,',1)>0 
   																			and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',trimAddress)
   																			=> REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',trimAddress,3),
   																		 StringLib.stringfind(trimAddress,', ,',1)>0 
   																			and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([0-9A-Za-z \\.][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',trimAddress)
   																			=> REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([0-9A-Za-z \\.][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',trimAddress,3),
   																		 StringLib.stringfind(trimAddress,',',2)>0 
   																			and REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z ][^\\,]+)', trimAddress) 
   																			=> REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z ][^\\,]+)', trimAddress,3),
   																			' ');
   				self.ADDR_ADDR4_1    	:= '';
   				self.ADDR_CITY_1			:= ut.CleanSpacesAndUpper(pInput.mail_city);
   				self.ADDR_STATE_1			:= ut.CleanSpacesAndUpper(pInput.mail_state);
   				 
   				tmpZIPCODE 						:= ut.CleanSpacesAndUpper(pInput.mail_zip);
   				self.ADDR_ZIP5_1			:= tmpZIPCODE[1..5];
   				self.ADDR_ZIP4_1			:= tmpZIPCODE[7..10];
   				self.addr_cnty_1 			:= ut.CleanSpacesAndUpper(pInput.county);
*/
				//following code is commented out because compilance is not provided in vendor input file any more 1/22/13 Cathy Tio			
				//self.disp_type_cd 		:= if(pInput.compliance <> '', pInput.compliance, '');
				
				// Expected codes [CO,BR,IN]
				self.AFFIL_TYPE_CD		:= MAP(self.type_cd = 'MD' => 'IN',
																		 self.type_cd = 'GR'=> 'CO', 
																		 ' ');  
		
				self.MLTRECKEY				:= 0;
					 
				//Use hash64 instead of hash32 to avoid dup keys	 
				self.cmc_slpk         := hash64(trim(self.license_nbr,left,right) 
																				+trim(self.std_license_type,left,right)
																				+trim(self.std_source_upd,left,right)
																				+trim(self.name_org_orig,left,right)
																				+ut.CleanSpacesAndUpper(pInput.mail_address)
																				+ut.CleanSpacesAndUpper(pInput.mail_city)
																				+ut.CleanSpacesAndUpper(pInput.mail_state)
																				+ut.CleanSpacesAndUpper(pInput.mail_zip));
				//Full name is no longer provided in vendor's input file 1/22/13 Cathy Tio
				//Company name is no longer provided in vendor's input file 1/22/13 Cathy Tio
											 
				SELF := [];		 
				
	END;

	//ds_map := project(prof_license_mari.file_CAS0847, transformToCommon(left));
	ds_map := project(ValidMTGFile, transformToCommon(left));

	// Populate Standardized License field
	maribase_plus_dbas 		trans_lic_status(ds_map L, Cmvtranslation R) := transform
		self.STD_LICENSE_STATUS := R.DM_VALUE1;
		self := L;
	end;

	ds_map_stat_trans := JOIN(ds_map, Cmvtranslation,
								TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
								and TRIM(left.std_source_upd,left,right)= TRIM(right.SOURCE_UPD,left,right)
									AND right.fld_name='LIC_STATUS',
								trans_lic_status(left,right),left outer,lookup);


	// Populate STD_PROF_CD field via translation on license type field
	maribase_plus_dbas 		trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
		self.STD_PROF_CD := R.DM_VALUE1;
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
							TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
							and TRIM(left.std_source_upd,left,right)= TRIM(right.SOURCE_UPD,left,right)
							AND right.fld_name='LIC_TYPE' 
							AND right.dm_name1 = 'PROFCODE',
							trans_lic_type(left,right),left outer,lookup);
																		
// Populate prof code description
/* 	maribase_plus_dbas  	trans_prof_desc(ds_map_lic_trans L, SrcCmvProf R) := transform
   		self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
   		self := L;
   	end;
   
   	ds_map_prof_desc := JOIN(ds_map_lic_trans, SrcCmvProf,
   							 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
   							 trans_prof_desc(left,right),left outer,lookup);
*/
																		

// Populate License Status Description field
/* 	maribase_plus_dbas 		trans_status_desc(ds_map_prof_desc L, SrcCmvStatus R) := transform
   		self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
   		self := L;
   	end;
   
   	ds_map_status_desc := jOIN(ds_map_prof_desc, SrcCmvStatus,
   								TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
   								trans_status_desc(left,right),left outer,lookup);
*/
																		
																		
//Populate License Type Description field
/* 	maribase_plus_dbas 		trans_type_desc(ds_map_status_desc L, SrcCmvType R) := transform
   		self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
   		self := L;
   	end;
   
   	ds_map_type_desc := JOIN(ds_map_status_desc, SrcCmvType,
   							TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right)
   							and TRIM(left.std_source_upd,left,right)= TRIM(right.SRC_UPD,left,right),
   							trans_type_desc(left,right),left outer,lookup);
*/
						
						
/* 	//Populate Source Description field
   	maribase_plus_dbas 		trans_source_desc(ds_map_type_desc L, SrcCmv R) := transform
   		self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
   		self := L;
   	end;
   
   	ds_map_source_desc := join(ds_map_type_desc, SrcCmv,
   							TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
   							trans_source_desc(left,right),left outer,lookup);
   							
*/

	//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
	//company_only_lookup := ds_map_source_desc(affil_type_cd='CO');
	company_only_lookup := ds_map_lic_trans(affil_type_cd='CO');

	maribase_plus_dbas  	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
	end;

	ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
							TRIM(left.name_org[1..50],left,right)	= TRIM(right.name_org[1..50],left,right)
							AND left.AFFIL_TYPE_CD = 'BR',
							assign_pcmcslpk(left,right),left outer,lookup);																		

	maribase_plus_dbas 		xTransPROVNOTE(ds_map_affil L) := transform
		self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
								 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
								'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

		self := L;
	end;

	OutRecs := project(ds_map_affil, xTransPROVNOTE(left));


	// Transform expanded dataset to MARIBASE layout
	Prof_License_Mari.layout_base_in 	xTransToBase(OutRecs L) := transform
			DBA_SUFX				:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.NAME_DBA);						   
		self.NAME_DBA_SUFX		:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		
		self.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, ','),
										 StringLib.stringfind(L.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '#'),
										 StringLib.stringfind(L.ADDR_ADDR1_1,'"',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR1_1, '"'),
																																							 L.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, ','),
										 StringLib.stringfind(L.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '#'),	
										 StringLib.stringfind(L.ADDR_ADDR2_1,'"',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR2_1, '"'),
																																						 L.ADDR_ADDR2_1);
			
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(L.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '.'),
										 StringLib.stringfind(L.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, ','),
										 StringLib.stringfind(L.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '#'),	
										 StringLib.stringfind(L.ADDR_ADDR3_1,'"',1) > 0 => StringLib.StringFilterOut(L.ADDR_ADDR3_1, '"'),
																																						 L.ADDR_ADDR3_1);
			
		self := L;
	end;

	ds_map_base := project(OutRecs, xTransToBase(left));

	// Adding to Superfile
	d_final := output(ds_map_base, ,mari_dest+pVersion+'::'+src_cd,__compressed__,overwrite);
			
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_base);
	
	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oFile, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

