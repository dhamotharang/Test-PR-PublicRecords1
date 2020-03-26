/* Converting South Dakota Revenue and Regulation Real Estate Appraisers License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/
IMPORT Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib, standard;

EXPORT map_SDS0810_conversion(STRING pVersion) := FUNCTION
#workunit('name',' Yogurt:Prof License MARI - SDS0810  Build   ' + pVersion);
	code 										:= 'SDS0810';
	src_cd									:= code[3..7];
	src_st									:= code[1..2];	//License state
	mari_dest								:= '~thor_data400::in::proflic_mari::';	
	#workunit('name','Prof License MARI- '+code);
	AddrExceptions := '(DRIVE|CENTER|BUILDING)';
	Valid_License_Type := ['CG','CR','SL','SR'];
	
	//Dataset reference files for lookup joins
	Cmvtranslation					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCmvtranslation					:= OUTPUT(Cmvtranslation);
	
	//Move to using
	move_to_using						:= PARALLEL(Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr','sprayed','using');
																			);	

	inFile 									:= Prof_License_Mari.file_SDS0810;
	ut.CleanFields(inFile, ClnUnprintable);
	oFile										:= OUTPUT(ClnUnprintable);

	//Filtering out BAD RECORDS
	ValidLicenseType 				:= ClnUnprintable(REGEXFIND('[0-9]', StringLib.StringToUpperCase(LIC_NO))); 
	GoodNameRec 						:= ValidLicenseType(TRIM(ORG_NAME + LIC_NO) != '');
	// ValidLicenseType			:= ClnUnprintable(TRIM(LIC_TYPE) IN Valid_License_Type);
	// GoodNameRec					:= ClnUnprintable(TRIM(ORG_NAME + LIC_NO) != '');

	//Real Estate License to common MARIBASE layout
	Prof_License_Mari.layout_base_in			xformToCommon(GoodNameRec pInput) := TRANSFORM
		SELF.PRIMARY_KEY			:= 0;											//Generate sequence number (not yet initiated)
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9];		//yyyymmdd
		SELF.LAST_UPD_DTE			:= pVersion;							//it was set to process_date before
		SELF.STAMP_DTE      	:= pVersion;
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.STD_PROF_CD		  := ' ';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.LICENSE_STATE	 	:= code[1..2];
		SELF.TYPE_CD					:= 'MD';

		//Standardize Fields
		TrimNAME_ORG					:= ut.CleanSpacesAndUpper(pInput.ORG_NAME);
		TrimAddress 					:= ut.CleanSpacesAndUpper(pInput.ADDRESS);
		TrimState							:= ut.CleanSpacesAndUpper(pInput.STATE);
		TrimCity              := ut.CleanSpacesAndUpper(pInput.CITY);
		TrimZip								:= ut.CleanSpacesAndUpper(pInput.ZIP);	

		// License Information
		TrimSLNUM 						:= ut.CleanSpacesAndUpper(pInput.LIC_NO);
		SELF.LICENSE_NBR	  	:= TrimSLNUM;
		GetOriginCd						:= REGEXFIND('^([0-9A-Za-z][^\\-]+)[\\-]([0-9]{4})([A-Z])?',TrimSLNUM,3);
		SELF.ORIGIN_CD				:= GetOriginCd;
		// SELF.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(pInput.LIC_TYPE);
		trimLic_Type					:= REGEXFIND('[0-9]([A-Z]{2})(-[A-Z])?',TrimSLNUM,1);
		SELF.RAW_LICENSE_TYPE	:= trimLic_Type;
		SELF.STD_LICENSE_TYPE := trimLic_Type;
		SELF.STD_LICENSE_desc := MAP(trimLic_Type='CG' => 'STATE-CERTIFIED GENERAL APPRAISER',
																 trimLic_Type='CR' => 'STATE-CERTIFIED RESIDENTIAL APPRAISER',
																 trimLic_Type='SL' => 'STATE-LICENSED APPRAISER',
																 trimLic_Type='SR' => 'STATE-REGISTERED',
																 '');
															 
		//Clean individual name
		SELF.NAME_FORMAT			:= IF(pVersion>'20130731','L','F');
		tempNick 							:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'nick');
		stripNickName 				:= Prof_License_Mari.fGetNickname(TrimNAME_ORG,'strip_nick');
		GoodName							:= IF(tempNick != '',stripNickName,TrimNAME_ORG);
		ParsedName						:= IF(SELF.NAME_FORMAT='F',
		                            TRIM(Address.CleanPersonFML73(GoodName)),
																TRIM(Address.CleanPersonLFM73(GoodName)));
		FirstName 						:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		MidName   						:= TRIM(ParsedName[26..45],LEFT,RIGHT);	
		LastName  						:= TRIM(ParsedName[46..65],LEFT,RIGHT); 
		Suffix	  						:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		ConcatNAME_FULL 			:= StringLib.StringCleanSpaces(LastName +' '+FirstName);
		SELF.NAME_ORG		    	:= ConcatNAME_FULL;
		SELF.NAME_FIRST		   	:= FirstName;
		SELF.NAME_MID					:= MidName;							
		SELF.NAME_LAST		   	:= LastName;
		SELF.NAME_SUFX				:= Suffix;
		SELF.NAME_NICK				:= StringLib.StringCleanSpaces(tempNick);
		SELF.NAME_ORG_ORIG	  := TrimNAME_ORG;
		
		//Reformatting date to YYYYMMDD
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.CURR_ISSUE_DTE		:= '17530101';
		// SELF.CURR_ISSUE_DTE		:= IF(pInput.ISSUEDT != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ISSUEDT),'17530101');
		SELF.EXPIRE_DTE				:= IF(TrimSLNUM != '',
																//license expires on 0930 of the issue year, unless it is issued after the first week of July.
																MAP(SELF.CURR_ISSUE_DTE[1..4]='2012' AND SELF.CURR_ISSUE_DTE[5..8]>'0707'=> '20130930',
																    SELF.CURR_ISSUE_DTE[1..4]='2012' AND SELF.CURR_ISSUE_DTE[5..8]<='0707'=> '20120930',
																		SELF.CURR_ISSUE_DTE[1..4]='2013' AND SELF.CURR_ISSUE_DTE[5..8]>'0706'=> '20140930',
																    SELF.CURR_ISSUE_DTE[1..4]='2013' AND SELF.CURR_ISSUE_DTE[5..8]<='0706'=> '20130930',
																		SELF.CURR_ISSUE_DTE[1..4]='2014' AND SELF.CURR_ISSUE_DTE[5..8]>'0705'=> '20150930',
																    SELF.CURR_ISSUE_DTE[1..4]='2014' AND SELF.CURR_ISSUE_DTE[5..8]<='0705'=> '20140930',
																		SELF.CURR_ISSUE_DTE[1..4]='2015' AND SELF.CURR_ISSUE_DTE[5..8]>'0704'=> '20160930',
																    SELF.CURR_ISSUE_DTE[1..4]='2015' AND SELF.CURR_ISSUE_DTE[5..8]<='0704'=> '20150930',
																		SELF.CURR_ISSUE_DTE[1..4]='2016' AND SELF.CURR_ISSUE_DTE[5..8]>'0706'=> '20170930',
																    SELF.CURR_ISSUE_DTE[1..4]='2016' AND SELF.CURR_ISSUE_DTE[5..8]<='0706'=> '20160930',
																		StringLib.StringCleanSpaces(pVersion[1..4] +'0930')),
																'17530101');
		
		SELF.RAW_LICENSE_STATUS := '';			
		SELF.STD_LICENSE_STATUS := IF(pVersion>SELF.EXPIRE_DTE,'I','A');			
		SELF.STD_STATUS_DESC	  := IF(pVersion>SELF.EXPIRE_DTE,'INACTIVE','ACTIVE');

		//Phone
		TrimPhone             := StringLib.StringFilter(pInput.PHONE,'0123456789');
		SELF.PHN_MARI_1				:= IF(TrimPhone = '0000000000','',ut.CleanPhone(TrimPhone));
		SELF.PHN_PHONE_1    	:= IF(TrimPhone = '0000000000','',ut.CleanPhone(TrimPhone));
	
		
		TempAddress1          := IF(REGEXFIND('(^.*) (PO BOX .*$)',TrimAddress),REGEXFIND('(^.*) (PO BOX .*$)',TrimAddress,1),TrimAddress);
		TempAddress2          := IF(REGEXFIND('(^.*) (PO BOX .*$)',TrimAddress),REGEXFIND('(^.*) (PO BOX .*$)',TrimAddress,2),'');
		clnAddrAddr						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(TrimAddress,TrimCity+' '+TrimState+' '+TrimZip);
		tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[45..46],LEFT,RIGHT);																	
		tmpADDR_ADDR1_2				:= TRIM(clnAddrAddr[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr[57..64],LEFT,RIGHT);

		SELF.ADDR_ADDR1_1			:= REGEXREPLACE('# ',TempAddress1,'#');
		SELF.ADDR_ADDR2_1			:= TempAddress2; 
		SELF.ADDR_CITY_1			:= TRIM(clnAddrAddr[65..89]);
		SELF.ADDR_STATE_1			:= TRIM(clnAddrAddr[115..116]);
   	SELF.ADDR_ZIP5_1			:= TRIM(clnAddrAddr[117..121]);
   	SELF.ADDR_ZIP4_1			:= clnAddrAddr[122..125];
	  SELF.ADDR_BUS_IND			:= IF(clnAddrAddr!='','B','');
			  
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= MAP(SELF.TYPE_CD = 'MD' => 'IN',
																 SELF.TYPE_CD = 'GR' => 'CO','');		

		SELF.MLTRECKEY				:= 0;
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK       	:= HASH64(TRIM(SELF.license_nbr,LEFT,RIGHT) +','
																				+TRIM(SELF.std_license_type,LEFT,RIGHT) +','
																				+TRIM(SELF.std_source_upd,LEFT,RIGHT) +','
																				+TRIM(SELF.NAME_ORG,LEFT,RIGHT) +','
																				+pInput.PHONE +','
																				+TrimAddress +','
																				+TrimZip); 
																										 
		SELF.PCMC_SLPK				:= 0;
		SELF.PROVNOTE_3 			:= '{LIC_STATUS ASSIGNED}'; 
		SELF 									:= [];	
		   
	END;
	
	inFileLic	:= PROJECT(GoodNameRec,xformToCommon(LEFT));

	// Populate STD_PROF_CD field via translation on license type field
	Prof_License_Mari.layout_base_in 	trans_lic_type(inFileLic L, Cmvtranslation R) := transform
		SELF.STD_PROF_CD := StringLib.stringtouppercase(TRIM(R.DM_VALUE1));
																
		self := L;
	END;

	ds_map_lic_trans := JOIN(inFileLic, Cmvtranslation,
							TRIM(LEFT.raw_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
							AND RIGHT.fld_name='LIC_TYPE' 
							AND RIGHT.dm_name1 = 'PROFCODE',
							trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	remove_logical 					:= sequential(fileservices.startsuperfiletransaction(),
																				fileservices.RemoveSuperfile(mari_dest+src_cd,mari_dest+pVersion+'::'+src_cd),
																				fileservices.finishsuperfiletransaction()
																				);

	// Adding to Superfile
	d_final := OUTPUT(ds_map_lic_trans, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);


add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans (NAME_ORG_ORIG != ''));


	move_to_used := Prof_License_Mari.func_move_file.MyMoveFile(code, 'apr', 'using', 'used');

	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(oCmvtranslation, move_to_using, oFile, remove_logical, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;