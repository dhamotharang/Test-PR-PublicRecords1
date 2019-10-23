/* Converting Commissioner of Financial Inst of Puerto Rico Mulitple Licenses File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
#workunit('name','Prof License MARI- PRS0889')
#workunit('protect',true)
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_PRS0889_conversion(STRING pVersion) := FUNCTION

	code 								:= 'PRS0889';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Reference Files for lookup joins
	cmvTranslation			:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	ocmvTranslation			:= output(cmvTranslation);
	
	//Move to using
	move_to_using				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'cbanks','sprayed','using');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'lenders','sprayed','using');	
												         );

	cbanks 							:= Prof_License_Mari.files_PRS0889.cbanks;
	lenders 						:= Prof_License_Mari.files_PRS0889.lenders;


	AddrExceptions 			:= '(DRIVE|CENTER|BUILDING|CENTRE|PLANTATION|MAIN &|BUSINESS PARK| WAY|APTS|SQUARE|PLAZA|PLACE|TWO )';
	CorpExceptions 			:= '(BANCO |BANK|CONDOMINIUM|AUTO|FINANC|PUERTO RICO|^ASOCIACION |NEW YORK)';
	C_O_Ind 						:= '(C/O |ATTN: |ATTN )';
	DBA_Ind 						:= '(.DBA| DBA |D/B/A |/DBA )';

	inFileComb 					:= cbanks + lenders;
	ut.CleanFields(inFileComb, ClnUnprintable);

	oFile								:= OUTPUT(ClnUnprintable);
	
	//Filtering out BAD RECORDS
	TITLE_LINE_NAMES 		:= '(NOMBRE INSTITUCIÓN|INSTITUCIONES HIPOTECARIAS|INTERMEDIARIOS FINANCIEROS|PRESTAMOS PERSONALES PEQUEÑOS|TOTAL:)';
	NonBlankRec					:= ClnUnprintable(SLNUM<>'' AND NOT REGEXFIND('(NUM\\.|[0-9]+/[0-9]+)',SLNUM));
	GoodFilterRec 			:= NonBlankRec(ORG_NAME != '' AND ADDRESS1 != '' AND NOT REGEXFIND(TITLE_LINE_NAMES,ORG_NAME,NOCASE));                                                                                      
                                                                                                                                       
	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in 		xformToCommon(Prof_License_Mari.layout_PRS0889.other_bank pInput) := TRANSFORM
	
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
		SELF.LICENSE_STATE	 	:= src_st;

		//Standardize Fields
		TrimNAME_ORG					:= ut.fnTrim2Upper(pInput.ORG_NAME);
		TrimNAME_DBA					:= ut.fnTrim2Upper(pInput.DBA);
		TrimAddress1					:= ut.fnTrim2Upper(pInput.ADDRESS1);
		TrimCity							:= ut.fnTrim2Upper(pInput.CITY);
		TrimSLNUM							:= ut.fnTrim2Upper(pInput.SLNUM);

		//Use license number prefix to determin license type
		sl_num_prefix					:= IF(REGEXFIND('(^[A-Z]+)-',TrimSLNUM),REGEXFIND('(^[A-Z]+)-',TrimSLNUM,1),'');
		temp_lic_type					:= CASE(sl_num_prefix,
		                              'B' => 'CBK',
		                              'BG' => 'CBK',
		                              'IH' => 'MI',
		                              'H' => 'MI',
		                              'IF' => 'FI',
		                              'F' => 'FI',
		                              'PPP' => 'SLC',
		                              'PP' => 'SLC',
																	'');
		self.TYPE_CD					:= IF(temp_lic_type in ['BRK','CBK','FI','MI','SLC'], 'GR','MD');
		self.LICENSE_NBR	  	:= IF(TrimSLNUM='','NR',pInput.SLNUM);
		self.RAW_LICENSE_TYPE	:= temp_lic_type;
		self.STD_LICENSE_TYPE := TRIM(SELF.RAW_LICENSE_TYPE);
		self.RAW_LICENSE_STATUS := 'A';
		
	  // Corporation Names
		prepNAME_ORG := MAP(StringLib.Stringfind(TrimNAME_ORG,',INC.',1) >0 => StringLib.Stringfindreplace(TrimNAME_ORG,',INC.',', INC.'),
												StringLib.Stringfind(TrimNAME_ORG,',INC',1) >0 => StringLib.Stringfindreplace(TrimNAME_ORG,',INC',', INC'),
												TrimNAME_ORG);
		StdNAME_ORG := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_ORG);
		CleanNAME_ORG	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= CleanNAME_ORG;
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	                  Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));

		//Identifying DBA NAMES
		StdNAME_DBA := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_DBA);
		CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		self.NAME_DBA					:= StringLib.StringFindReplace(CleanNAME_DBA,'/','');
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		self.DBA_FLAG		    	:= If(TRIM(self.NAME_DBA)<>'',1,0);
	  self.NAME_OFFICE	    := '';
		self.OFFICE_PARSE			:= '';
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= IF(pInput.ISSUE_DATE != '' and NOT REGEXFIND('########',pInput.ISSUE_DATE),
		                            Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUE_DATE),
																'17530101');
		self.EXPIRE_DTE				:= '17530101';
		self.RENEWAL_DTE			:= '';
		self.ACTIVE_FLAG			:= '';
			
		//Populating MARI Name Fields
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		SELF.NAME_FORMAT			:= IF(TRIM(self.NAME_ORG_ORIG)<>'','F','');
		self.NAME_DBA_ORIG	  := TrimNAME_DBA;
		self.NAME_MARI_ORG	  := IF(self.TYPE_CD = 'GR',StdNAME_ORG,'');
		self.NAME_MARI_DBA	  := IF(self.TYPE_CD = 'GR',StdNAME_DBA,'');
		
		//Clean address
		clnAddrAddr						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(TrimAddress1,TRIM(TrimCity+' PR '+TRIM(pInput.ZIP),LEFT,RIGHT));
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[57..64],LEFT,RIGHT);
		SELF.ADDR_ADDR1_1			:= TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT);
		SELF.ADDR_ADDR2_1			:= TRIM(tmpADDR_ADDR1_2,LEFT,RIGHT); 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr[122..125];
	  self.ADDR_BUS_IND			:= IF(clnAddrAddr!='','B','');
		TrimPhone							:= TRIM(StringLib.StringFilter(pInput.PHONE,'0123456789'));
		self.PHN_MARI_1				:= IF(TrimPhone IN ['0000000000','1111111111'],'',StringLib.StringCleanSpaces(pInput.PHONE));
		self.PHN_PHONE_1			:= IF(TrimPhone IN ['0000000000','1111111111'],'',TrimPhone);
							  
	  //Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD		:= MAP(self.TYPE_CD = 'MD' => 'IN',
															 self.TYPE_CD = 'GR' => 'CO','');		

		self.MLTRECKEY				:= 0;
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK       	:= hash64(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(self.NAME_ORG,left,right)
																			+trim(self.NAME_DBA,left,right)
																			+trim(SELF.ADDR_ADDR1_1)
																			+trim(SELF.ADDR_CITY_1)
																			+trim(SELF.ADDR_ZIP5_1));																								   
		self.PROVNOTE_3 			:= IF(TRIM(self.RAW_LICENSE_TYPE)<>'','{LICENSE TYPE ASSIGNED}',''); 
		
		SELF 									:= [];	
		   
	END;
	inFileLic	:= project(GoodFilterRec,xformToCommon(left));

	// Populate STD_STATUS_CD field via translation on statu field
	Prof_License_Mari.layout_base_in 	trans_lic_status(inFileLic L, cmvTranslation R) := transform
		self.STD_LICENSE_STATUS :=  IF(L.STD_LICENSE_STATUS = '',StringLib.stringtouppercase(trim(R.DM_VALUE1,left,right)),
																			L.STD_LICENSE_STATUS);
		self := L;
	end;

	ds_map_status_trans := JOIN(inFileLic, cmvTranslation,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
							AND right.fld_name='LIC_STATUS' ,
							trans_lic_status(left,right),left outer,lookup);

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(ds_map_status_trans L, cmvTranslation R) := transform
		self.STD_PROF_CD := StringLib.stringtouppercase(trim(R.DM_VALUE1,LEFT,RIGHT));
		self := L;
	end;

	ds_map_lic_trans := JOIN(ds_map_status_trans, cmvTranslation,
													 TRIM(left.raw_license_type,left,right)= TRIM(right.fld_value,left,right)
													 AND right.fld_name='LIC_TYPE' 
													 AND right.dm_name1 = 'PROFCODE',
													 trans_lic_type(left,right),left outer,lookup);

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	// Adding to Superfile
	d_final := output(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);
	
//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));		
	// add_super := sequential(fileservices.startsuperfiletransaction(),
														// fileservices.addsuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
														// fileservices.finishsuperfiletransaction()
														// );

	move_to_used				:= parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'cbanks','using','used');	
																	Prof_License_Mari.func_move_file.MyMoveFile(code, 'lenders','using','used');	
												         );

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;

