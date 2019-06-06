//************************************************************************************************************* */	
//  The purpose of this development is take KY Real Estate License raw file and convert them to a common
//  professional license (MARIFLAT_out) layout to be used for MARI and PL_BASE development.
//************************************************************************************************************* */	
#workunit('name','map_KYS0831_conversion'); 
import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

EXPORT map_KYS0831_conversion(STRING pVersion) := FUNCTION

	code 								:= 'KYS0831';
	src_cd							:= code[3..7];
	src_st							:= code[1..2];	//License state
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	//Move to using
	move_to_using				:=Prof_License_Mari.func_move_file.MyMoveFile(code, 'rel','sprayed','using');
	
		//Reference Files for lookup joins
	cmvTransLkp					:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
	oCMV								:= OUTPUT(cmvTransLkp);
	
	//KY input file
	ds_KY_RealEstate 		:= Prof_License_Mari.file_KYS0831;
	oRE									:= OUTPUT(ds_KY_RealEstate);
						
	
//Pattern for DBA
	DBA_Ind 						:= '(^DBA | DBA | DBA|D/B/A|A/K/A|^AKA| AKA )';
	C_O_Ind 						:= '(C/O |ATTN:|ATTN|ATTENTION:|ATT:)';


//Invalid Office Names
	InvalidName	:= ['ESCROW FILE','HOLD FILE','NOT AFFILIATED WITH ANY BROKER'];

//Remove bad records before processing
	ValidKYFile	:= ds_KY_RealEstate(TRIM(Licensee_Last_Name,LEFT,RIGHT) <> ' ' AND NOT REGEXFIND('(^.* TEST$|Licensee Last Name)',TRIM(Licensee_Last_Name,LEFT,RIGHT)));


//KY Real Estate layout to Common
Prof_License_Mari.layout_base_in	transformToCommon(layout_KYS0831.Common pInput) := TRANSFORM
	SELF.PRIMARY_KEY								:= 0;											//Generate sequence number (not yet initiated)
	SELF.CREATE_DTE									:= thorlib.wuid()[2..9];	//yyyymmdd
	SELF.LAST_UPD_DTE								:= pVersion;							//it was set to process_date before
	SELF.STAMP_DTE      						:= pVersion;
	SELF.DATE_FIRST_SEEN						:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN							:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := pVersion;
	SELF.DATE_VENDOR_LAST_REPORTED	:= pVersion;
	SELF.PROCESS_DATE								:= thorlib.wuid()[2..9];
	
	self.TYPE_CD							:= 'MD';

	
	//Standardize Fields
	//Check the length of org name to fix a typo in vendor provided file
	TrimNAME_FIRST				:= 	ut.CleanSpacesAndUpper(pInput.Licensee_First_Name);
	TrimNAME_LAST					:=	ut.CleanSpacesAndUpper(pInput.Licensee_Last_Name);
	TrimNAME_MID					:= 	ut.CleanSpacesAndUpper(pInput.Licensee_Middle_Init);
	TrimNAME_OFFICE				:=  ut.CleanSpacesAndUpper(pInput.Firm_Name);
	
	TrimBRKR_FIRST				:= 	ut.CleanSpacesAndUpper(pInput.Broker_First_Name);
	TrimBRKR_LAST					:=	ut.CleanSpacesAndUpper(pInput.Broker_Last_Name);
	

//Branch Address
  // EscrowRec := if(TrimNAME_OFFICE = 'LICENSEE IN ESCROW','Y','');
	TrimBrchAddress1			:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_Address1);
	TrimBrchAddress2			:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_Address2);
	TrimBrchCity 					:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_City);
  TrimBrchState					:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_State);
	BrchZip								:= pInput.Firm_Branch_Zip;
	BrchZip4							:= pInput.Firm_Branch_Zip4;
	TrimBrchCnty					:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_County_Desc);
	TrimBrchCntry					:= ut.CleanSpacesAndUpper(pInput.Firm_Branch_Cntry);

//Home Address	
	TrimHomeAddress1			:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_Address1);
	TrimHomeAddress2			:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_Address2);
	TrimHomeCity 					:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_City);
	TrimHomeState					:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_State);
	HomeZip								:= pInput.Licensee_Home_Zip;
	HomeZip4							:= pInput.Licensee_Home_Zip4;
	TrimHomeCnty					:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_County_Desc);
	TrimHomeCntry					:= ut.CleanSpacesAndUpper(pInput.Licensee_Home_Cntry);
 
 //Consolidate Address Fields for Escrow Records
  EscrowRec := if(TrimNAME_OFFICE = 'LICENSEE IN ESCROW','Y',
									if(pInput.ln_filetype = 'ESC', 'Y',''));
  tempBusAdddress1 := if(EscrowRec = '',TrimBrchAddress1, TrimHomeAddress1);  
	tempBusAdddress2 := if(EscrowRec = '',TrimBrchAddress2, TrimHomeAddress2);  
	tempBusCity 		 := if(EscrowRec = '',TrimBrchCity, TrimHomeCity);  
	tempBusState		 := if(EscrowRec = '',TrimBrchState,TrimHomeState);
	tempBusZip			 := if(EscrowRec = '',BrchZip,HomeZip);
	tempBusZip4			 := if(EscrowRec = '',BrchZip4,HomeZip4);
	tempBusCnty			 := if(EscrowRec = '',TrimBrchCnty,
													if(EscrowRec != '' and TrimHomeCnty = '', TrimBrchCnty, TrimHomeCnty));
	tempBusCntry		 := if(EscrowRec = '',TrimBrchCntry,TrimHomeCntry);

	//License Info	
	SELF.STD_SOURCE_UPD				:= src_cd;
	self.RAW_LICENSE_TYPE			:= pInput.Licensee_Type;
	self.STD_LICENSE_TYPE			:= if(self.RAW_LICENSE_TYPE = 'P', 'PB',self.RAW_LICENSE_TYPE);

	self.LICENSE_NBR					:= pInput.Licensee_License_Number;
	self.LICENSE_STATE	 			:= src_st;
	self.RAW_LICENSE_STATUS		:= if(EscrowRec != '','ESCROW','');
	self.STD_LICENSE_STATUS 	:= if(self.RAW_LICENSE_STATUS != '','','A');
	
	//Reformatting date to YYYYMMDD
	self.CURR_ISSUE_DTE				:= '17530101';
	self.ORIG_ISSUE_DTE				:= '17530101';
	self.EXPIRE_DTE						:= '17530101';


//Strip nickname
	Nickpattern := '^(.*)\'(.*)\'(.*)$';
  tmpNick_first		:= Prof_License_Mari.fGetNickname(TrimNAME_FIRST, 'nick');
	tmpNick_last		:= Prof_License_Mari.fGetNickname(TrimNAME_LAST, 'nick');
	
	rmvNick_first		:= if(regexfind(Nickpattern, TrimNAME_FIRST), regexfind(Nickpattern,TrimNAME_FIRST,1), 
													Prof_License_Mari.fGetNickname(TrimNAME_FIRST, 'strip_nick'));
	rmvNick_last		:= Prof_License_Mari.fGetNickname(TrimNAME_LAST, 'strip_nick');
	
	//Parse name
	self.NAME_FIRST		:= rmvNick_first;
	self.NAME_MID			:= StringLib.StringToUpperCase(pInput.Licensee_Middle_Init);
	self.NAME_LAST		:= rmvNick_last;
	self.NAME_SUFX		:= '';
	self.NAME_NICK		:= if(tmpNick_first != '',tmpNick_first, 
													if(regexfind(Nickpattern, TrimNAME_FIRST), regexfind(Nickpattern, TrimNAME_FIRST,2),
														tmpNick_last));

	
	tmpNAME_ORG			:= StringLib.StringCleanSpaces(rmvNick_last+' '+rmvNick_first);
	self.NAME_ORG		:= tmpNAME_ORG;
	
	prepNAME_OFFICE 			:= MAP(EscrowRec != '' => '',
															 StringLib.Stringfind(TrimNAME_OFFICE,'D/B/A ',1) > 0 => StringLib.StringFindReplace(TrimNAME_OFFICE,'D/B/A ',' DBA '),
															 TrimNAME_OFFICE[1..4] = 'C/O ' => StringLib.StringFindReplace(TrimNAME_OFFICE,'C/O ',''),
																 TrimNAME_OFFICE);
	getNAME_DBA						:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																 prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepNAME_OFFICE),
																																						'');
																																						
	StdNAME_DBA 					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA);
	CleanNAME_DBA					:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
															
																	REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
																		OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
																												Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
	self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
	self.NAME_DBA					:=  StringLib.StringFindReplace(CleanNAME_DBA,'/',' ');
	self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
	self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
					
		
	//Prepping OFFICE NAMES												
	rmvOfficeDBA 					:= MAP(REGEXFIND(DBA_Ind,prepNAME_OFFICE) => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																prepNAME_OFFICE[1..4] = 'DBA ' => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																REGEXFIND(C_O_Ind,prepNAME_OFFICE)=> Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepNAME_OFFICE),
																																		prepNAME_OFFICE);
																					
	StdNAME_OFFICE				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvOfficeDBA);														
	CleanNAME_OFFICE 			:= IF(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_OFFICE), Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
																IF(REGEXFIND('(%)',StdNAME_OFFICE),StdNAME_OFFICE,
																			Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE))); 
		
	self.NAME_OFFICE	    :=	if(length(trim(CleanNAME_OFFICE)) = 1, '',CleanNAME_OFFICE);
	self.OFFICE_PARSE			:= IF(self.NAME_OFFICE != '' and Prof_License_Mari.func_is_company(self.NAME_OFFICE),'GR',
																	IF(self.NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD',
																							''));
	

	fmtNAME_ORG					:= 	StringLib.StringCleanSpaces(TrimNAME_LAST+ ', '+TrimNAME_FIRST+' '+TrimNAME_MID);
	self.NAME_FORMAT			:= IF(self.TYPE_CD = 'MD','L','F');
	self.NAME_ORG_ORIG		:= fmtNAME_ORG;
	self.NAME_DBA_ORIG		:= '';
	self.NAME_MARI_ORG		:= self.NAME_OFFICE;
	self.NAME_MARI_DBA		:= StdNAME_DBA;													

RemovePattern	  := '(^INC D/B/A.*$|^.* LLC$|^.* LLC\\.$|^.* INC$|^.* INC\\.$|^.* COMPANY$|^.* CORP$|^.*APPRAISAL$|^.*APPRAISALS$| CUTTS$)';

//Split address2 from address1
	self.ADDR_BUS_IND			:= IF(EscrowRec = '' and TRIM(TrimBrchAddress1 + TrimBrchCity+ pInput.Firm_Branch_Zip) != '','B','H');
	clnABusddress1 := IF(REGEXFIND('^C/O',tempBusAdddress1), REGEXFIND('^C/O ([A-Z\\s]+)\\s([0-9A-Z\\s]+)', tempBusAdddress1,2),
														Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(tempBusAdddress1, RemovePattern));
	
	self.ADDR_ADDR1_1			:= clnABusddress1;
	self.ADDR_ADDR2_1			:= tempBusAdddress2;
	self.ADDR_CITY_1		  := tempBusCity;
	self.ADDR_STATE_1			:= tempBusState;
	self.ADDR_ZIP5_1		  := tempBusZip;
	self.ADDR_ZIP4_1		  := tempBusZip4;
	self.ADDR_CNTY_1			:= StringLib.StringToUpperCase(REGEXREPLACE('COUNTY',tempBusCnty,''));
	self.ADDR_CNTRY_1			:= tempBusCntry;
	
	self.ADDR_MAIL_IND		:= IF(EscrowRec = '' and TRIM(TrimHomeAddress1 + TrimHomeCity+ pInput.Licensee_Home_City) != '','H','');
	clnAHomesddress1 := IF(REGEXFIND('^C/O',TrimHomeAddress1), REGEXFIND('^C/O ([A-Z\\s]+)\\s([0-9A-Z\\s]+)', TrimHomeAddress1,2),
														Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(TrimHomeAddress1, RemovePattern));
	self.ADDR_ADDR1_2			:= IF(EscrowRec = '',clnAHomesddress1,'');
	self.ADDR_ADDR2_2			:= IF(EscrowRec = '',TrimHomeAddress2,'');	
	self.ADDR_CITY_2		  := IF(EscrowRec = '',TrimHomeCity,'');
	self.ADDR_STATE_2			:= IF(EscrowRec = '',TrimHomeState,'');
	self.ADDR_ZIP5_2		  := IF(EscrowRec = '',HomeZip,'');
	self.ADDR_ZIP4_2		  := IF(EscrowRec = '',HomeZip4,'');
	filter_HomeCnty  := if(TrimHomeCnty = '** INVALID COUNTY **','',TrimHomeCnty);
	self.ADDR_CNTY_2			:= IF(EscrowRec = '', REGEXREPLACE('COUNTY',filter_HomeCnty,''),'');
	self.ADDR_CNTRY_2			:= IF(EscrowRec = '',TrimHomeCntry,'');

//Remove Nickname from Broker's Names	
  //Nickname Pattern
	
	tmpNickContact_first		:= Prof_License_Mari.fGetNickname(TrimBRKR_FIRST, 'nick');
	tmpNickContact_last			:= Prof_License_Mari.fGetNickname(TrimBRKR_LAST, 'nick');
	
	rmvNickContact_first		:= Prof_License_Mari.fGetNickname(TrimBRKR_FIRST, 'strip_nick');
	rmvNickContact_last			:= Prof_License_Mari.fGetNickname(TrimBRKR_LAST, 'strip_nick');
	
	SELF.NAME_CONTACT_FIRST := if(regexfind(Nickpattern, rmvNickContact_first), regexfind(Nickpattern, rmvNickContact_first,1),rmvNickContact_first);
	SELF.NAME_CONTACT_MID 	:= StringLib.StringToUpperCase(pInput.Broker_Middle_Name);
	SELF.NAME_CONTACT_LAST 	:= rmvNickContact_last;
	SELF.NAME_CONTACT_NICK	:= regexfind(Nickpattern, rmvNickContact_first,2);
																	
	SELF.NAME_CONTACT_TTL		:= if(SELF.NAME_CONTACT_LAST != '', 'PR BRKR','');
	
	SELF.MLTRECKEY				:= 0;
	
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
	SELF.CMC_SLPK       	:= hash64(trim(self.license_nbr,left,right) 
																		+trim(self.std_license_type,left,right)
																		+trim(self.std_source_upd,left,right)
																		+trim(self.NAME_ORG,left,right)
																		+tempBusAdddress1
																		+tempBusCity
																		+tempBusZip);																	
																										 
		self.PCMC_SLPK				:= 0;
		self.PROVNOTE_2				:= '';
		// SELF.PROVNOTE_3				:= IF(EscrowRec = '','{LICENSE STATUS ASSIGNED}','');
		SELF.PROVNOTE_3				:= '{LICENSE STATUS ASSIGNED}';
		SELF := [];	
				 
	END;
	
	inFileLic	:= project(ValidKYFile,transformToCommon(left));

	
	// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
	Prof_License_Mari.layout_base_in trans_lic_status(inFileLic L, cmvTransLkp R) := transform
		self.STD_LICENSE_STATUS := IF(L.STD_LICENSE_STATUS = '', R.DM_VALUE1, L.STD_LICENSE_STATUS);
		self := L;
	end;

	ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
														TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
														AND right.fld_name='LIC_STATUS',
														trans_lic_status(left,right),left outer,lookup);


	// Populate STD_PROF_CD field via translation on license type field
 	Prof_License_Mari.layout_base_in trans_lic_type(ds_map_stat_trans L, cmvTransLkp R) := transform
   		self.STD_PROF_CD := R.DM_VALUE1;
   		self := L;
   	end;
   
  ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
													TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
													AND right.fld_name='LIC_TYPE' 
													AND right.dm_name1 = 'PROFCODE',
													trans_lic_type(left,right),left outer,lookup);
   																		

	d_final 			:= output(ds_map_lic_trans, ,mari_dest+pVersion +'::'+src_cd,__compressed__,overwrite);			
			
//BUG 180478
	add_super := Prof_License_Mari.fAddNewUpdate(ds_map_lic_trans(NAME_ORG_ORIG != ''));
	// add_super 		:= sequential(fileservices.startsuperfiletransaction(),
																		// fileservices.addsuperfile(mari_dest+src_cd, mari_dest+pVersion+'::'+src_cd),
																		// fileservices.finishsuperfiletransaction()
																			// );
	move_to_used 	:= Prof_License_Mari.func_move_file.MyMoveFile(code, 'rel','using','used');	
	                       

	//Add notify_missing_codes to email the user if there is missing codes
	notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
	
	RETURN SEQUENTIAL(move_to_using, oCMV, oRE, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);

END;