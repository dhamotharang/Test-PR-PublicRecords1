/* Converting Virginia Dept. of Profess./Occupational Regulation / Multiple Professions //
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

import ut, Prof_License_Mari, lib_stringlib, Lib_FileServices,Address;


export  map_VAS0849_conversion(string pVersion) := function
#workunit('name','Prof License MARI- VAS0849 ' + pVersion);
  
code 		:= 'VAS0849';  
src_cd	:= code[3..7];
src_st	:= code[1..2];	//License state


active_file := Prof_License_Mari.files_VAS0849.active;
inactive_file := Prof_License_Mari.files_VAS0849.inactive;

// Populating License Status for individuals/business
rRawPlusStatus_layout	:=
RECORD
	Prof_License_Mari.layout_VAS0849.src;
  string status;
END;

rRawPlusStatus_Layout		StatusActivePop(Prof_License_Mari.layout_VAS0849.src pInput) 
	:= 
	 TRANSFORM
		self.STATUS	    := 'ACTIVE';  
		SELF := pInput;	
		   
END;
inFileActive	:= project(active_file,StatusActivePop(left));
OActive := output(inFileActive);

rRawPlusStatus_Layout		StatusInactivePop(Prof_License_Mari.layout_VAS0849.src pInput) 
	:= 
	 TRANSFORM
		self.STATUS	    := 'INACTIVE';  
		SELF := pInput;	
		   
END;
inFileInactive	:= project(inactive_file,StatusInactivePop(left));
OInactive := output(inFileInactive);
inFileComb := inFileActive + inFileInactive;
oComb := output(inFileComb);

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD =src_cd);
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD =src_cd);
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR =src_cd); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
OCmvLkp := output(cmvTransLkp);

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
addr_list := '(#|P O |APT |APT[.] |BLDG |C/O |PO |POB |STE |SUITE|SU |APARTMENT |BOX |UNIT |PMB |ROOM |RT |HWY | FLOOR|PENTHOUSE |POST OFFICE|GENERAL |ESTATES)';
addr_bus_name := ['REMAX R E ONE','TRNTY PROP SERV','CB RICHARD ELLIS','BRAMBLETON CORP CTR','LONG AND FOSTER'];


//Filtering out BAD RECORDS
GoodNameRec	 	:= inFileComb(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(INDIV_NAME)));
GoodFilterRec	:= GoodNameRec(NOT REGEXFIND('UNEMPLOYED', StringLib.StringToUpperCase(INDIV_NAME))
																OR NOT REGEXFIND('UNEMPLOYED', StringLib.StringToUpperCase(BUS_NAME)));

		
//VA Licensing to common MARIBASE layout
Prof_License_Mari.layouts.base	xformToCommon(rRawPlusStatus_Layout pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    := 0;  
		self.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		self.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		self.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		self.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		self.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		self.PROCESS_DATE			:= thorlib.wuid()[2..9];
		self.LAST_UPD_DTE			:= pInput.ln_filedate;
		self.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
		self.TYPE_CD					:= IF(pInput.INDIV_NAME != '' and pInput.BUS_NAME = '','MD',
																IF(pInput.INDIV_NAME = '' and pInput.BUS_NAME != '','GR',
																	 IF(pInput.INDIV_NAME != '' and pInput.BUS_NAME != '','GR','')));			
		
		TrimNAME_INDV := ut.fnTrim2Upper(pInput.INDIV_NAME);
		TrimNAME_ORG := ut.fnTrim2Upper(pInput.BUS_NAME);
		
		CleanName	:= Address.NameCleaner.CleanPerson73(TrimNAME_INDV);
		CleanName2 := if(CleanName != '',CleanName, address.CleanPersonFML73(TrimNAME_INDV));
	  fname := CleanName2[6..25];
		mname := CleanName2[26..45];
		lname := CleanName2[46..65];
		sufx_name :=   CleanName2[66..70];  
		ConcatNAME_FULL := 	if(CleanName2 != '',StringLib.StringCleanSpaces(lname +' '+	fname),TrimNAME_INDV);
		
		prepNAME_ORG	:= IF(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'], TrimNAME_ORG + pInput.ADDRESS1,
														TrimNAME_ORG);
		StdNAME_ORG	 := IF(prepNAME_ORG != '',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_ORG),'');
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
												OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
												OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));

		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= IF(self.TYPE_CD = 'GR',StringLib.StringCleanSpaces(CleanNAME_ORG),
																IF(sufx_name in ['GENER','PRESI'], TrimNAME_INDV,
																		ConcatNAME_FULL));
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	  
		self.NAME_DBA_PREFX	  := ''; 
		self.NAME_DBA					:= '';
		self.NAME_DBA_SUFX	  := ''; 
		self.DBA_FLAG		    	:= 0;
		
		self.NAME_FIRST		    := IF(sufx_name in ['GENER','PRESI'],TrimNAME_INDV,fname); 
		self.NAME_MID					:= mname;  							
		self.NAME_LAST		    := lname; 
		self.NAME_SUFX				:= IF(sufx_name in ['GENER','PRESI'],'',sufx_name); 
		self.NAME_NICK				:= '';
											
	// License Information
		self.LICENSE_NBR	    := StringLib.StringFilterOut(ut.fnTrim2Upper(pInput.BOARD + pInput.OCCUPATION + pInput.CERTIFICATE),' ');
		self.LICENSE_STATE	  := 'VA';

		LicenseType := IF(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],
													StringLib.StringFilterOut(ut.fnTrim2Upper(pInput.BOARD + pInput.OCCUPATION + pInput.LIC_SPEC1),' '),
															StringLib.StringFilterOut(ut.fnTrim2Upper(pInput.BOARD + pInput.OCCUPATION + pInput.LIC_TYPE),' ')
															);
													
		self.RAW_LICENSE_TYPE	:= LicenseType;
		self.STD_LICENSE_TYPE := self.RAW_LICENSE_TYPE;
		self.STD_LICENSE_DESC		:= '';
		self.RAW_LICENSE_STATUS := pInput.STATUS;
		self.STD_LICENSE_STATUS := '';
		self.STD_STATUS_DESC		:= '';
		   		   
	//Reformatting date to YYYYMMDD
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= If(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'], Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.LIC_TYPE),
																IF(pInput.CERTIF_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CERTIF_DATE),'17530101'));
		self.EXPIRE_DTE				:= If(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.CERTIF_DATE),
																IF(pInput.EXP_DATE != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.EXP_DATE),'17530101'));
		
	//Prepping Address field, Stripping out Business Names 
		TrimAddress1 := ut.fnTrim2Upper(pInput.ADDRESS1);
		TrimAddress2 := ut.fnTrim2Upper(pInput.ADDRESS2);	
		TrimAddress3 := ut.fnTrim2Upper(pInput.POBOX);
		
		PrepAddress1 := MAP(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'] => TrimAddress2,
												REGEXFIND('^([0-9]{1,}\\s{0,2}$)',TrimAddress1) => 
												StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
												StringLib.stringfind(trim(TrimAddress2),' ',1) = 0 => StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
												TrimAddress2[1..4] = 'AND' =>  StringLib.StringCleanSpaces(TrimAddress1 +' '+ TrimAddress2),
																											TrimAddress1);
		
		PrepAddress2 := MAP(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'] => '',
												REGEXFIND('^([0-9]{1,}\\s{0,2})$',TrimAddress1) => '',
												StringLib.stringfind(trim(TrimAddress2),' ',1) = 0 => '',
												REGEXFIND('(SU |SUIET |SUIITE|SUIRE|SUTIE |SUIE )',TrimAddress2)=>
																		REGEXREPLACE('(SU |SUIET |SUIITE|SUIRE|SUTIE |SUIE )',TrimAddress2,'SUITE '),
												REGEXFIND('C/O',TrimAddress2) => '',
												TrimAddress2[1..4] = 'AND' => '',
															TrimAddress2);

		//Use address cleaner to clean address
		  CoPattern	:= '(^.* LLC|^.* LLC\\.$| CUSHMAN & WAKEFIELD\\, INC$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
										'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^DHI MORTGAGE |' +
										'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^C/O .*$|^C/0 .*$|^ATTN: .*$|^ATTN.*$|^.* LENDING|' +
										' TOP PRO REALTY$|^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION$|^.* MORTGAGE$|' +
										'^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT' +
										')';

										
		  RemovePattern	  := '(^.* LLC|^.* LLC\\.$| CUSHMAN & WAKEFIELD, INC$|^.* INC$|^.* INC\\.$|^.* INC\\.? |^.* COMPANY$|^.* CORP$|^.* \\.COM$|^.*APPRAISAL$|^.*APPRAISALS$|' +
													'^.* APPR\\.$|^.* APPRAISAL SERVICE$|^.* APPRAISAL GROUP$|^.* APPRAISAL CO$|^.* FINANCIAL$|^DHI MORTGAGE |' +
													'^.* APPRAISAL SV[C|S]$|^.* SERVICE[S]?$|^.* & ASSOCIATES$|^.* ADVISORS$|^CO .*$|^C/0 .*$|^ATTN.*$|^.* LENDING|' +
													' TOP PRO REALTY$|^.* REALTY$|^.* REAL ESTATE$|^.* REAL ESTATE CO$|^.* MANAGEMENT$|^.* MGMT$|^.* COMPANIES|^.* CORPORATION|' +
													'^.* LOANS$|^.* PROPERTIES$|^.* PARTNERS RESIDENTIAL$|LEGAL DEPARTMENT|' +
													'LINE 1|LINE 2|LEGAL DEPT\\.|SALES OFFICE|BUSINESS OFFICE|^.* MORTGAGE$' +
													')';
												
		office_ind := '^(SUITE [0-9][^\\-]+)[\\-][\\s]?([A-Z\\s\\&]+)$';
		office_ind_2 := '^(9TH FLOOR [\\-]?)[\\s]?([A-Z\\s\\&\\,]+)$';
		tmpNameContact1				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(PrepAddress1, CoPattern);
		clnAddress1						:= if(regexfind(office_ind, trim(PrepAddress1)), regexfind(office_ind, trim(PrepAddress1),1),
																if(regexfind(office_ind_2, trim(PrepAddress1)), regexfind(office_ind_2, trim(PrepAddress1),1),
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(PrepAddress1, RemovePattern)));
																
		tmpNameContact2				:= Prof_License_Mari.mod_clean_name_addr.extractNameFromAddr(PrepAddress2, CoPattern);
		clnAddress2						:= if(regexfind(office_ind, trim(PrepAddress2)), regexfind(office_ind, trim(PrepAddress2),1),
																if(regexfind(office_ind_2, trim(PrepAddress2)), regexfind(office_ind_2, trim(PrepAddress2),1),
																	Prof_License_Mari.mod_clean_name_addr.removeNameFromAddr(PrepAddress2, RemovePattern)));
		
		temp_preaddr1 				:= StringLib.StringCleanSpaces(clnAddress1); 
		temp_preaddr2 				:= StringLib.StringCleanSpaces(clnAddress2); 
														
		
		prepContract := map(regexfind(office_ind, trim(tmpNameContact1)) => regexfind(office_ind, trim(tmpNameContact1),2),
												regexfind(office_ind_2, trim(tmpNameContact1)) => regexfind(office_ind_2, trim(tmpNameContact1),2),
												tmpNameContact1[1..4] in ['C/0 ','C O '] => tmpNameContact1[5..],
		                    tmpNameContact1 <> '' => tmpNameContact1,
												tmpNameContact2[1..6] = 'ATTN: ' => tmpNameContact2[7..],
												regexfind(office_ind, trim(tmpNameContact2)) => regexfind(office_ind, trim(tmpNameContact2),2),												
												regexfind(office_ind_2, trim(tmpNameContact2)) => regexfind(office_ind_2, trim(tmpNameContact2),2),
												  tmpNameContact2);
												
		
		self.NAME_OFFICE := prepContract;
		self.OFFICE_PARSE	    := IF(self.NAME_OFFICE = '','',
																IF(self.NAME_OFFICE != ''  and NOT Prof_License_Mari.func_is_company(self.NAME_OFFICE),'MD','GR'));	

	// Populating MARI Name Fields
		self.NAME_FORMAT			:= 'F';
		self.NAME_ORG_ORIG	  := IF(self.TYPE_CD = 'MD',StringLib.StringCleanSpaces(TrimNAME_INDV),TrimNAME_ORG);
		self.NAME_DBA_ORIG	  := ''; 
		self.NAME_MARI_ORG	  := IF(TrimNAME_ORG != '',StdNAME_ORG,self.NAME_OFFICE);
		self.NAME_MARI_DBA	  := '';
		
		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + TrimAddress2+ TrimAddress3+ pInput.CITY + pInput.ZIP5) != '','B','');
		self.ADDR_ADDR1_1			:= IF(temp_preaddr1 <> '', temp_preaddr1,temp_preaddr2);
		self.ADDR_ADDR2_1			:= IF(temp_preaddr1 = '', '',temp_preaddr2);
		self.ADDR_ADDR3_1			:= TrimAddress3;
		self.ADDR_ADDR4_1			:= '';
	
		TrimCity	:=  ut.fnTrim2Upper(pInput.CITY);
		self.ADDR_CITY_1		:= TrimCity;
		self.ADDR_STATE_1		:= ut.fnTrim2Upper(pInput.STATE);
		self.ADDR_ZIP5_1		:= pInput.ZIP5;
		self.ADDR_ZIP4_1		:= pInput.ZIPCODE_EXT;
		self.ADDR_CNTY_1		:= ut.fnTrim2Upper(pInput.PROVINCE);
		self.ADDR_CNTRY_1		:= ut.fnTrim2Upper(pinput.COUNTRY);
		self.PHN_PHONE_1 		:= '';
		self.PHN_MARI_1			:= '';
		self.OOC_IND_1			:= 0;    
		self.OOC_IND_2			:= 0;
		
		self.ADDR_ADDR1_2   := '';
		self.ADDR_ADDR2_2   := '';
		
		self.EMAIL					:= ut.fnTrim2Upper(pInput.EMAIL);
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD		:= MAP(self.TYPE_CD = 'MD' => 'IN',
																 self.TYPE_CD = 'GR' and self.STD_LICENSE_TYPE = '0226B' => 'BR',
									               self.TYPE_CD = 'GR' and self.STD_LICENSE_TYPE != '0226B'=> 'CO','');
			
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK         	:= hash32(trim(self.license_nbr,left,right) + ',' 
																			+trim(self.std_license_type,left,right)
 																			+trim(self.std_source_upd,left,right) + ', '
																			+trim(self.NAME_ORG,left,right)+ ','
																			+TrimAddress1 + ','
																			+TrimAddress2 + ','
																			+TrimAddress3+ ','
																			+TrimCity +','
																			+(pInput.ZIP5));
																								   
																							  
		self.PCMC_SLPK		:= 0;
		self.ADDL_LICENSE_SPEC := IF(trim(pInput.LIC_SPEC1) in ['BRKR','SALP','BRNH','ENTY','FIRM','SOLE'],'',ut.fnTrim2Upper(pInput.LIC_SPEC1));
		SELF := [];	
		   
END;
inFileLic	:= project(GoodFilterRec,xformToCommon(left));


// Populate STD_LICENSE_TYPE field via translation on RAW_LICENSE_STATUS field
Prof_License_Mari.layouts.base 	trans_lic_status(inFileLic L, cmvTransLkp R) := transform
	self.STD_LICENSE_STATUS := R.DM_VALUE1;
	self := L;
end;

ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
	    					AND right.fld_name='LIC_STATUS',
							trans_lic_status(left,right),left outer,lookup);


// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts.base 	trans_lic_type(ds_map_stat_trans  L, cmvTransLkp R) := transform
	self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		

//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_lic_trans(RAW_LICENSE_TYPE = '0226F');

Prof_License_Mari.layouts.base 	assign_pcmcslpk(ds_map_lic_trans L, company_only_lookup R) := transform
	self.pcmc_slpk := R.cmc_slpk;
	self := L;
end;
ds_map_affil := join(ds_map_lic_trans, company_only_lookup,
										StringLib.StringFilterOut(left.NAME_ORG,' ') = StringLib.StringFilterOut(right.NAME_ORG,' ')
										and left.RAW_LICENSE_TYPE ='0226B',
										assign_pcmcslpk(left,right),left outer);	

Prof_License_Mari.layouts.base  xTransPROVNOTE(ds_map_affil L) := transform
	self.PROVNOTE_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => TRIM(L.provnote_1,left,right)+ '|' + Comments,
												 L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => Comments,
						  												       L.PROVNOTE_1);

	self := L;
end;

OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

// Adding to Superfile
d_final := output(OutRecs, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__compressed__,overwrite);

//BUG 180478
add_super := Prof_License_Mari.fAddNewUpdate(OutRecs(NAME_ORG_ORIG != ''));
// add_super := sequential(fileservices.startsuperfiletransaction(),
													// fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
													// fileservices.finishsuperfiletransaction()
													// );
move_to_used := parallel(Prof_License_Mari.func_move_file.MyMoveFile(code, 'active_license', 'using', 'used'),
												 Prof_License_Mari.func_move_file.MyMoveFile(code, 'inactive_license', 'using', 'used')
													);


notify_missing_codes := Prof_License_Mari.fNotifyError.MissingStdCodes(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);
notify_invalid_address := Prof_License_Mari.fNotifyError.NameInAddressFields(code,src_cd,pVersion,
	                            Prof_License_Mari.Email_Notification_Lists.BaseFileConversion);


RETURN SEQUENTIAL(OActive, OInactive, oComb, OCmvLkp, d_final, add_super, move_to_used, notify_missing_codes, notify_invalid_address);


end;

