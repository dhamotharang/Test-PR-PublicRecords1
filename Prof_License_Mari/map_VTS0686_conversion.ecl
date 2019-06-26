/* Converting Vermont Dept of Banking Insurance Securities Professional License File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

import ut
		 ,Prof_License_Mari
		 ,lib_stringlib
		 ,Lib_FileServices
		 ;


// export  map_VTS0686_conversion(string process_dte) := function
	
	
  // string8  fSlashedMDYtoCYMD(string pDateIn) 
						// := intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
								// +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
								// +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 

src_cd	:= 'S0686';
string8 process_dte:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

inFile	:= Prof_License_Mari.file_VTS0686;

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0686');
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD ='S0686');
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp	:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR ='S0686'); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;

Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
exclude_type := ['CC','DA','MT','MVSFC','RISFC'];

//Filtering out BAD RECORDS
GoodNameRec	 	:= inFile(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(COMP_NAME)));
GoodFilterRec	:= GoodNameRec(NOT REGEXFIND(Prof_License_Mari.filters.BadLicenseFilter, StringLib.StringToUpperCase(LIC_NUMR)));


		
//VT Licensing to common MARIBASE layout
Prof_License_Mari.layouts_reference.MARIBASE	xformToCommon(Prof_License_Mari.layout_VTS0686 pInput) 
	:= 
	 TRANSFORM
		self.PRIMARY_KEY	    := 0;  
		self.CREATE_DTE				:= PROCESS_DTE;
		self.LAST_UPD_DTE	    := PROCESS_DTE; 
		self.STAMP_DTE		    := PROCESS_DTE;
		self.STD_PROF_CD			:= '';
		self.STD_PROF_DESC    := '';
		self.STD_SOURCE_UPD		:= src_cd;
		self.STD_SOURCE_DESC  := '';
		self.TYPE_CD					:= 'GR';
		
		TrimNAME_ORG := ut.CleanSpacesAndUpper(pInput.COMP_NAME);
		StdNAME_ORG	 := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_ORG);
		CleanNAME_ORG	:= MAP(StringLib.stringfind(StdNAME_ORG,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right))
												OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									    
								   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right))
												OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));
	
		self.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		self.NAME_ORG		    	:= StringLib.StringCleanSpaces(CleanNAME_ORG);
		self.NAME_ORG_SUFX	  := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
	  
		TrimNAME_DBA	:= ut.CleanSpacesAndUpper(pInput.TRADE_NAME);
		StdNAME_DBA		:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TrimNAME_DBA);
		CleanNAME_DBA	:= MAP( StringLib.stringfind(StdNAME_DBA,'.COM',1) > 0 => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		self.NAME_DBA_PREFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA); 
		self.NAME_DBA					:= CleanNAME_DBA;
		self.NAME_DBA_SUFX	  := Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA); 
		self.DBA_FLAG		    	:= If(self.NAME_DBA != '',1,0);
		self.NAME_OFFICE	   	:= '';
		self.OFFICE_PARSE	    := '';	
		
		ParsedName	:= IF(pInput.CODE1 = 'ML',Prof_License_Mari.mod_clean_name_addr.cleanLFMName(StdNAME_ORG),'');
		self.NAME_FIRST		    := TRIM(ParsedName[6..25],left,right); 
		self.NAME_MID					:= TRIM(ParsedName[26..45],left,right);  							
		self.NAME_LAST		    := TRIM(ParsedName[46..65],left,right); 
		self.NAME_SUFX				:= TRIM(ParsedName[66..70],left,right); 
		// self.NAME_NICK				:= '';
											
	// License Information
		self.LICENSE_NBR	    := pInput.LIC_NUMR;
		self.LICENSE_STATE	  := 'VT';
		self.RAW_LICENSE_TYPE	:= ut.CleanSpacesAndUpper(pInput.CODE1);
		self.STD_LICENSE_TYPE := CASE(ut.CleanSpacesAndUpper(pInput.LIC),
																	// 'CHECK CASHER '  => 'CC',
																	// 'DEBT ADJUSTER'  => 'DA',
																	// 'MONEY TRANSMITTER' => 'MT',
																	'MOTOR VEHICLE SALES FINANCE COMPANY (MVL)'  => 'MVSFC',
																	'MOTOR VEHICLE SALES FINANCE COMPANY'  => 'MVSFC',
																	'RETAIL INSTALLMENT SALES FINANCE COMPANY (RSL)'  => 'RISFC',
																	'RETAIL INSTALLMENT SALES FINANCE COMPANY'  => 'RISFC',
																	// 'LICENSED LENDER' => 'LL',
																	'LICENSED LENDER - RESTRICTED' => 'LLR',
																	'REVERCE MORTGAGE COUNSELOR' => 'RMC',
																	'MORTGAGE LOAN ORIGINATOR' => 'MLO',
																	// 'MORTGAGE BROKER (MBL)'	=> 'MB',
																	// 'MORTGAGE BROKER'	 => 'MB',
																				pInput.CODE1);
		self.STD_LICENSE_DESC		:= '';
		self.RAW_LICENSE_STATUS := '';
		self.STD_LICENSE_STATUS := 'A';
		self.STD_STATUS_DESC		:= 'ACTIVE';
		   		   
	//Reformatting date to YYYYMMDD
		self.CURR_ISSUE_DTE		:= '17530101';
		self.ORIG_ISSUE_DTE		:= IF(pInput.ISSUANCE_DATE1 != '', Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.ISSUANCE_DATE1),'17530101');
		self.EXPIRE_DTE				:= process_dte[1..4] + '1231';
		
	// Populating MARI Name Fields
		self.NAME_ORG_ORIG	  := TrimNAME_ORG;
		self.NAME_DBA_ORIG	  := TrimNAME_DBA; 
		self.NAME_MARI_ORG	  := StdNAME_ORG;
		self.NAME_MARI_DBA	  := StdNAME_DBA;

	//Prepping Address field 
		TrimAddress1 := ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimAddress2 := ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		
		self.ADDR_BUS_IND			:= IF(TRIM(TrimAddress1 + pInput.CITY + pInput.ZIP) != '','B','');
		self.ADDR_ADDR1_1		:= MAP(	StringLib.stringfind(TrimAddress1,',',2)> 0 and REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),',TrimAddress1) =>
																		REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.),[ ]([\\# 0-9A-Za-z \\#]+[ ]*.)',TrimAddress1,1),
																StringLib.stringfind(TrimAddress1,',',1)> 0 and REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*',TrimAddress1) =>
																		REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*([\\# 0-9A-Za-z \\#\\/]+[ ]*.)',TrimAddress1,1),
																StringLib.stringfind(TrimAddress1,',',1)> 0 and StringLib.stringfind(TrimAddress1,'-',1)> 0=> TrimAddress1,						
																StringLib.stringfind(TrimAddress1,',',1)> 0 and not StringLib.stringfind(TrimAddress1,'(',1)> 0=>						
																		REGEXFIND('^([\\#]?[0-9A-Za-z \\.\\#\\&\\/\\-\\(]+[ ]*.),[ ]*([\\# 0-9A-Za-z \\#\\/\\.\\-]+[ ]*.)',TrimAddress1,1),
										  																					TrimAddress1); 
											   
		self.ADDR_ADDR2_1		:= MAP( StringLib.stringfind(TrimAddress1,',',2)> 0 and REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),',TrimAddress1) =>
																		REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.),[ ]([\\# 0-9A-Za-z \\#]+[ ]*.)',TrimAddress1,2),
																StringLib.stringfind(TrimAddress1,',',1)> 0 and REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*',TrimAddress1) =>
																		REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)',TrimAddress1,2),
																// StringLib.stringfind(TrimAddress1,',',1)> 0 and StringLib.stringfind(TrimAddress1,'-',1)> 0=> '',						  
																StringLib.stringfind(TrimAddress1,',',1)> 0 and not StringLib.stringfind(TrimAddress1,'(',1)> 0 =>						
																		REGEXFIND('^([\\#]?[0-9A-Za-z \\.\\#\\&\\/\\-\\(]+[ ]*.),[ ]*([\\#]?[0-9A-Za-z \\.\\#\\&\\/\\-\\(]+[ ]*.)',TrimAddress1,2),
																				TrimAddress2);
		
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(TrimAddress1,',',2)> 0 and REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),',TrimAddress1) =>
																	REGEXFIND('^([R][Ff]?[Dd]?[Rr]?[\\#]?[0-9]+),[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.),[ ]([\\# 0-9A-Za-z \\#]+[ ]*.)',TrimAddress1,3),  
															 StringLib.stringfind(TrimAddress1,',',2)> 0 and not StringLib.stringfind(TrimAddress1,'(',1)> 0=>						
																	REGEXFIND('^([\\#]?[0-9A-Za-z \\.\\#\\(\\-]+[ ]*.),[ ]*([\\# 0-9A-Za-z \\#\\.\\(\\-]+[ ]*.),[ ]([\\# 0-9A-Za-z \\#\\.\\(]+[ ]*.)',TrimAddress1,3),
															 NOT StringLib.stringfind(TrimAddress1,',',1)> 0 and self.ADDR_ADDR2_1 = TrimAddress2 => '', 
																				TrimAddress2);
																											   
		
		
		TrimCity	:=  ut.CleanSpacesAndUpper(pInput.CITY);
		self.ADDR_CITY_1		:= TrimCity;
		self.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.STATE);
		ParsedZIP           := IF(LENGTH(pInput.ZIP) = 4, '0' + pInput.ZIP,
															IF(REGEXFIND('[0-9]{5}(-[0-9]{4})?',pInput.ZIP),pInput.ZIP,
																	pInput.ZIP)
																	);
		self.ADDR_ZIP5_1		:= IF(self.ADDR_STATE_1 = 'CN',ParsedZIP,ParsedZIP[1..5]);
		self.ADDR_ZIP4_1		:= ParsedZIP[7..10];
		self.PHN_PHONE_1 		:= ut.CleanPhone(pInput.PHONE);
		self.PHN_MARI_1			:= self.PHN_PHONE_1;
		self.OOC_IND_1			:= 0;    
		self.OOC_IND_2			:= 0;
		
	//Expected codes [CO,BR,IN], Set during business/individual filter
		self.AFFIL_TYPE_CD		:= MAP(self.TYPE_CD = 'MD' => 'IN',
									               self.TYPE_CD = 'GR' => 'CO','');
			
	// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		self.CMC_SLPK         	:= hash32(trim(self.license_nbr,left,right) 
																			+trim(self.std_license_type,left,right)
																			+trim(self.std_source_upd,left,right)
																			+trim(self.NAME_ORG,left,right)
																			+ut.CleanSpacesAndUpper(pInput.ADDRESS1)
																			+ut.CleanSpacesAndUpper(pInput.CITY)
																			+ut.CleanSpacesAndUpper(pInput.ZIP));
																								   
																							  
		self.PCMC_SLPK		:= 0;
		self.PROVNOTE_1		:= '';
		self.PROVNOTE_2		:= '';									 
		self.PROVNOTE_3 	:= '';
			
		SELF := [];	
		   
END;
inFileLic	:= project(GoodFilterRec,xformToCommon(left));

// Populate STD_LICENSE_TYPE field via translation on RAW_LICENSE_STATUS field
// Prof_License_Mari.layouts_reference.MARIBASE 	trans_lic_status(inFileLic L, cmvTransLkp R) := transform
	// self.STD_LICENSE_STATUS := R.DM_VALUE1;
	// self := L;
// end;

// ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
							// TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
	    					// AND right.fld_name='LIC_STATUS',
							// trans_lic_status(left,right),left outer,lookup);


// Populate STD_PROF_CD field via translation on license type field
Prof_License_Mari.layouts_reference.MARIBASE 	trans_lic_type(inFileLic L, cmvTransLkp R) := transform
	self.STD_PROF_CD := IF(L.STD_LICENSE_TYPE in exclude_type,'',R.DM_VALUE1);
	self := L;
end;

ds_map_lic_trans := JOIN(inFileLic, cmvTransLkp,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		

// Populate prof code description
Prof_License_Mari.layouts_reference.MARIBASE  trans_prof_desc(ds_map_lic_trans L, LicProfLkp R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := JOIN(ds_map_lic_trans, LicProfLkp,
						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
																		

// Populate License Status Description field
Prof_License_Mari.layouts_reference.MARIBASE trans_status_desc(ds_map_prof_desc L, LicStatusLkp R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

ds_map_status_desc := jOIN(ds_map_prof_desc, LicStatusLkp,
							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);
																		
																		
//Populate License Type Description field
Prof_License_Mari.layouts_reference.MARIBASE trans_type_desc(ds_map_status_desc L, LicTypeLkp R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
  self := L;
end;

ds_map_type_desc := JOIN(ds_map_status_desc, LicTypeLkp,
						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
						trans_type_desc(left,right),left outer,lookup);
						
						
//Populate Source Description field
Prof_License_Mari.layouts_reference.MARIBASE trans_source_desc(ds_map_type_desc L, LicSrcLkp R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
  self := L;
end;

ds_map_source_desc := join(ds_map_type_desc, LicSrcLkp,
						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
						trans_source_desc(left,right),left outer,lookup);


//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
// company_only_lookup := ds_map_source_desc(affil_type_cd= 'CO');

// Prof_License_Mari.layouts_reference.MARIBASE 	assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
	// self.pcmc_slpk := R.cmc_slpk;
	// self.provnote_1 := StringLib.StringFilterOut(L.NAME_MARI_ORG,' ');
	// self := L;
// end;
// ds_map_affil := join(ds_map_source_desc, company_only_lookup,
										// StringLib.StringFilterOut(left.NAME_MARI_ORG,' ') = StringLib.StringFilterOut(right.NAME_MARI_ORG,' ')
										// and left.affil_type_cd != 'CO',
										// assign_pcmcslpk(left,right),left outer);	

// Prof_License_Mari.layouts_reference.MARIBASE  xTransPROVNOTE(ds_map_affil L) := transform
	// self.PROVNOTE_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => TRIM(L.provnote_1,left,right)+ '|' + Comments,
												 // L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => Comments,
						  												       // L.PROVNOTE_1);

	// self := L;
// end;

// OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts_reference.MARIBASE xTransToBase(ds_map_source_desc L) := transform
	self.ADDR_ADDR1_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.ADDR_ADDR1_1);
	self.ADDR_ADDR2_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.ADDR_ADDR2_1);
	self.ADDR_ADDR3_1		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.ADDR_ADDR3_1);
	self := L;
end;

ds_map_base := project(ds_map_source_desc, xTransToBase(left));


// Adding to Superfile
d_final := output(ds_map_base, ,'~thor_data400::in::prolic::mari::'+process_dte+'::'+src_cd,__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::prolic::mari::'+src_cd,'~thor_data400::in::prolic::mari::'+process_dte+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);


// return sequential(d_final,add_super); 
sequential(d_final, add_super);

export map_VTS0686_conversion := 'todo';
// END;




// output(ds_map_base);
// output(ds_map_base(STD_LICENSE_TYPE = 'MLO'));
// output(ds_map_base(name_dba_orig != ''));
// output(choosen(ds_map_base(StringLib.stringfind(PROVNOTE_1,',',1) > 0),500));
// output(choosen(ds_map_base(PROVNOTE_2 != ''),500));
// output(ds_map_base(ADDR_STATE_1 = 'CN'));
