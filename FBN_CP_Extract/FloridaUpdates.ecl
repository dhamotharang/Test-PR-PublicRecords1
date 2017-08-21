import Address, Ut, lib_stringlib, _Control,_Validate, fbnv2;

export FloridaUpdates := module

	export	trimUpper(string s) := function
			return trim(stringlib.stringtoUppercase(s),LEFT, RIGHT);
	end;
	
	export	reformatDate(string inDate) := function
			string tmpDate 			:=  regexreplace('/',inDate,'')[1..8];
			string CCYYMMDDDate	:=	trim((tmpDate[5..8] + tmpDate[1..2] + tmpDate[3..4]),left,right);
			string newDate			:=	if (length(trim(CCYYMMDDDate,left,right))!=8,'',trim(CCYYMMDDDate,left,right));
			return newDate; 
		end;
		
	export	reformatDate2(string inDate) := function
			string tmpDate 			:=  regexreplace('/',inDate,'')[1..8];
			string MMDDCCYYDate	:=	trim((tmpDate[5..6] + tmpDate[7..8] + tmpDate[1..4]),left,right);
			string newDate			:=	if (length(trim(MMDDCCYYDate,left,right))!=8,'',trim(MMDDCCYYDate,left,right));
			return newDate; 
		end;		

	export fFiling(dataset(FBNV2.Layout_File_FL_in.Cleaned.Filing) pRawFileInput, string pversion) := function
		
		FBN_CP_Extract.Layouts.Out.Filing	  trfFiling(FBNV2.Layout_File_FL_in.Cleaned.Filing l)	:=	transform	
				self.IMPORT_DATE			:=	pVersion[5..6] + pVersion[7..8] + pVersion[1..4];
				self.CPS_SIG_FLNG 		:=	lib_StringLib.StringLib.Data2String(hashmd5(	'498' + 'FL' + l.FIC_FIL_DOC_NUM + l.FIC_FIL_COUNTY + l.FIC_FIL_DATE +
																						l.FIC_FIL_PAGES + l.FIC_FIL_STATUS + l.FIC_FIL_CANCELLATION_DATE +
																						l.FIC_FIL_EXPIRATION_DATE + l.FIC_FIL_TOTAL_OWN_CUR_CTR + l.FIC_GREATER_THAN__OWNERS
																					));
				self.CPS_VENDR_CD 		:=	'498';
				self.CPS_FILE_ST 			:=	'FL';
				self.FILING_CNTY 			:=	l.FIC_FIL_COUNTY;
				self.CPS_CNTY_NM 			:=	l.FIC_FIL_COUNTY;
				self.FILING_NUM 			:=	l.FIC_FIL_DOC_NUM;
				tmp_file_dte					:=	reformatDate2(l.FIC_FIL_DATE);
				self.FILING_DTE 			:=	tmp_file_dte;
				self.CLN_FILE_DTE 		:=	if (	_validate.date.fIsValid(l.FIC_FIL_DATE) and
																				_validate.date.fIsValid(l.FIC_FIL_DATE,_validate.date.rules.DateInPast), 
																					l.FIC_FIL_DATE,
																					''
																			);
				self.EXPIRE_DTE				:=	reformatDate2(l.FIC_FIL_EXPIRATION_DATE);
				self.CLN_EXP_DTE			:=	l.FIC_FIL_EXPIRATION_DATE;
				self.CANCEL_DTE				:=	reformatDate2(l.FIC_FIL_CANCELLATION_DATE);
				self.CLN_CANC_DTE			:=	l.FIC_FIL_CANCELLATION_DATE;
				self.FILING_PAGES			:=	INTFORMAT((integer)l.FIC_FIL_PAGES,5,1);
				self.TOT_OWN_CTR			:=	INTFORMAT((integer)l.FIC_FIL_TOTAL_OWN_CUR_CTR,5,1);
				self.GTR_THAN_10			:=	l.FIC_GREATER_THAN__OWNERS;
				self.BUS_STATUS				:=	l.FIC_FIL_STATUS;
				self.CPS_BUS_STAT			:=	map (	l.FIC_FIL_STATUS = 'C' => 'CANCELLED',
																				l.FIC_FIL_STATUS = 'A' => 'ACTIVE',
																				l.FIC_FIL_STATUS = 'E' => 'EXPIRED',
																				''
																			);	
				self.LF								:=	'\r\n';
				self									:=	[];
		end;
											
		dFiling			:=	project(pRawFileInput, trfFiling(left));
   
		return dFiling;
	end;
	
	export fNameBus(dataset(FBNV2.Layout_File_FL_in.Cleaned.Filing) pRawFileInput, string pversion) := function

		addresslayout := record
			FBNV2.Layout_File_FL_in.Cleaned.Filing; 
			string100			address1;
			string50			address2;
		end;
		
		addresslayout tProjectAddress(FBNV2.Layout_File_FL_in.Cleaned.Filing l) := transform
			self.address1	:= trim(l.FIC_FIL_ADDR1) 	+ ' ' 	+ trim(l.FIC_FIL_ADDR2);
			self.address2	:= trim(l.FIC_FIL_CITY) 	+ ', '	+ trim(l.FIC_FIL_STATE) 	+ ' ' 	+ trim(l.FIC_FIL_ZIP5) + trim(l.FIC_FIL_ZIP4);  
			self					:= l;
		end;
      
		dAddressPrep   := project(pRawFileInput, tProjectAddress(left));
      
		address.mac_address_clean( 	dAddressPrep
																,address1
																,address2
																,true
																,dAddressStandardized
															);

		FBN_CP_Extract.Layouts.Out.Name	  trfNameBus(dAddressStandardized l)	:=	transform	
				self.IMPORT_DATE			:=	pVersion[5..6] + pVersion[7..8] + pVersion[1..4];
				self.CPS_SIG_NAME     :=	lib_StringLib.StringLib.Data2String(hashmd5(	l.FIC_FIL_NAME + l.FIC_FIL_ADDR1 + l.FIC_FIL_ADDR2 + l.FIC_FIL_CITY + 
																						l.FIC_FIL_STATE + l.FIC_FIL_ZIP5 + l.FIC_FIL_COUNTRY + l.FIC_FIL_FEI_NUM));
				self.CPS_SIG_FLNG 		:=	lib_StringLib.StringLib.Data2String(hashmd5(	'498' + 'FL' + l.FIC_FIL_DOC_NUM + l.FIC_FIL_COUNTY + l.FIC_FIL_DATE +
																						l.FIC_FIL_PAGES + l.FIC_FIL_STATUS + l.FIC_FIL_CANCELLATION_DATE +
																						l.FIC_FIL_EXPIRATION_DATE + l.FIC_FIL_TOTAL_OWN_CUR_CTR + l.FIC_GREATER_THAN__OWNERS
																					));
				self.CPS_VENDR_CD 		:=	'498';
				self.CPS_FILE_ST 			:=	'FL';
				self.FILING_NUM 			:=	l.FIC_FIL_DOC_NUM;
				tmp_file_dte					:=	reformatDate2(l.FIC_FIL_DATE);
				self.CLN_FILE_DTE 		:=	if (	_validate.date.fIsValid(l.FIC_FIL_DATE) and
																				_validate.date.fIsValid(l.FIC_FIL_DATE,_validate.date.rules.DateInPast), 
																					l.FIC_FIL_DATE,
																					''
																			);
				self.CPS_REC_TYPE			:=	'F';
				self.NAME_CD					:=	l.FIC_OWNER_NAME_FORMAT;
				self.CPS_NAME_CD			:=	if (l.FIC_OWNER_NAME_FORMAT = 'P',
																				'I ',
																				if (l.FIC_OWNER_NAME_FORMAT ='C',
																							'B',
																							''
																						)
																			);
				self.CPS_NCOD_DSC			:=	if (l.FIC_OWNER_NAME_FORMAT = 'P',
																				'INDIVIDUAL',
																				if (l.FIC_OWNER_NAME_FORMAT ='C',
																							'BUSINESS',
																							''
																						)
																			);
				self.CPS_NAM_TYPE			:=	'B';
				self.CPS_NTYP_DSC			:=	'BUSINESS';
				self.CPS_NAME_FMT			:=	'L';
				self.NAME							:=	l.FIC_FIL_NAME[1..60];
				self.NAME_EXT					:=	l.FIC_FIL_NAME[61..];
				self.ADDR_1						:=	l.FIC_FIL_ADDR1;
				self.ADDR_2						:=	l.FIC_FIL_ADDR2;
				self.ADDR_CITY				:=	l.FIC_FIL_CITY;
				self.ADDR_ST					:=	l.FIC_FIL_STATE;
				self.ADDR_ZIP					:=	if (trim(l.FIC_FIL_ZIP4) != '',
																				l.FIC_FIL_ZIP5 + '-' + l.FIC_FIL_ZIP4,
																				l.FIC_FIL_ZIP5
																			);
				self.ADDR_CNTRY				:=	l.FIC_FIL_COUNTRY;
				
				Clean_address					:= 	Address.CleanAddressFieldsFips(l.clean).addressrecord;
				self.CLN_ADR_PRIM			:=	l.FIC_FIL_ADDR1;
				self.CLN_ADR_NUM			:=	Clean_address.prim_range;
				self.CLN_ADR_PRE			:=	Clean_address.predir;
				self.CLN_ADR_STR			:=	Clean_address.prim_name;
				self.CLN_ADR_SUF			:=	Clean_address.addr_suffix;
				self.CLN_ADR_POS			:=	Clean_address.postdir;
				self.CLN_ADR_UTYP			:=	Clean_address.unit_desig;
				self.CLN_ADR_UNUM			:=	Clean_address.sec_range;
				self.CLN_ADR_CITY			:=	Clean_address.v_city_name;
				self.CLN_ADR_ST				:=	Clean_address.st;
				self.CLN_ADR_ZIP5			:=	Clean_address.zip;
				self.CLN_ADR_ZIP4			:=	Clean_address.zip4;
				self.CLN_ADR_STAT			:=	Clean_address.err_stat;
				self.TAX_ID						:=	l.FIC_FIL_FEI_NUM;
				self.CLN_TAX_ID				:=	l.FIC_FIL_FEI_NUM;
				self.LF								:=	'\r\n';
				self									:=	[];
		end;
		
		dNameBus				:=	project(dAddressStandardized, trfNameBus(left));
   
		return dNameBus;
	end;
	
	export fNameOwn(dataset(FBNV2.Layout_File_FL_in.Cleaned.Filing) pRawFileInput, string pversion) := function

		addresslayout := record
			FBNV2.Layout_File_FL_in.Cleaned.Filing; 
			string100			address1;
			string50			address2;
		end;
		
		addresslayout tProjectAddress(FBNV2.Layout_File_FL_in.Cleaned.Filing l) := transform
			self.address1	:= trim(l.FIC_OWNER_ADDR);
			self.address2	:= trim(l.FIC_OWNER_CITY) 	+ ', '	+ trim(l.FIC_OWNER_STATE) 	+ ' ' 	+ trim(l.FIC_OWNER_ZIP5);  
			self					:= l;
		end;
      
		dAddressPrep   := project(pRawFileInput, tProjectAddress(left));
      
		address.mac_address_clean( 	dAddressPrep
																,address1
																,address2
																,true
																,dAddressStandardized
															);

		FBN_CP_Extract.Layouts.Out.Name	  trfNameOwn(dAddressStandardized l)	:=	transform	
				self.IMPORT_DATE			:=	pVersion[5..6] + pVersion[7..8] + pVersion[1..4];
				self.CPS_SIG_NAME     :=	lib_StringLib.StringLib.Data2String(hashmd5(	l.FIC_OWNER_NAME + l.FIC_OWNER_NAME_FORMAT + l.FIC_OWNER_ADDR + l.FIC_OWNER_CITY + 
																						l.FIC_OWNER_STATE + l.FIC_OWNER_ZIP5 + l.FIC_OWNER_COUNTRY + l.FIC_OWNER_FEI_NUM + 
																						l.FIC_OWNER_CHARTER_NUM));
				self.CPS_SIG_FLNG 		:=	lib_StringLib.StringLib.Data2String(hashmd5(	'498' + 'FL' + l.FIC_FIL_DOC_NUM + l.FIC_FIL_COUNTY + l.FIC_FIL_DATE +
																						l.FIC_FIL_PAGES + l.FIC_FIL_STATUS + l.FIC_FIL_CANCELLATION_DATE +
																						l.FIC_FIL_EXPIRATION_DATE + l.FIC_FIL_TOTAL_OWN_CUR_CTR + l.FIC_GREATER_THAN__OWNERS
																					));
				self.CPS_VENDR_CD 		:=	'498';
				self.CPS_FILE_ST 			:=	'FL';
				self.FILING_NUM 			:=	l.FIC_FIL_DOC_NUM;
				tmp_file_dte					:=	reformatDate2(l.FIC_FIL_DATE);
				self.CLN_FILE_DTE 		:=	if (	_validate.date.fIsValid(l.FIC_FIL_DATE) and
																				_validate.date.fIsValid(l.FIC_FIL_DATE,_validate.date.rules.DateInPast), 
																					l.FIC_FIL_DATE,
																					''
																			);
				self.CPS_REC_TYPE			:=	'O';
				self.NAME_CD					:=	l.FIC_OWNER_NAME_FORMAT;
				self.CPS_NAME_CD			:=	if (l.FIC_OWNER_NAME_FORMAT = 'P',
																				'I ',
																				if (l.FIC_OWNER_NAME_FORMAT ='C',
																							'B',
																							''
																						)
																			);
				self.CPS_NCOD_DSC			:=	if (l.FIC_OWNER_NAME_FORMAT = 'P',
																				'INDIVIDUAL',
																				if (l.FIC_OWNER_NAME_FORMAT ='C',
																							'BUSINESS',
																							''
																						)
																			);
				self.CPS_NAM_TYPE			:=	'O';
				self.CPS_NTYP_DSC			:=	'OWNER';
				self.CPS_NAME_FMT			:=	'L';
				self.NAME							:=	l.FIC_OWNER_NAME;
				self.ADDR_1						:=	l.FIC_OWNER_ADDR;
				self.ADDR_CITY				:=	l.FIC_OWNER_CITY;
				self.ADDR_ST					:=	l.FIC_OWNER_STATE;
				self.ADDR_ZIP					:=	if (trim(l.FIC_OWNER_ZIP4) != '',
																				l.FIC_OWNER_ZIP5 + '-' + l.FIC_OWNER_ZIP4,
																				l.FIC_OWNER_ZIP5
																			);
				self.ADDR_CNTRY				:=	l.FIC_OWNER_COUNTRY;
				
				Clean_address					:= 	Address.CleanAddressFieldsFips(l.clean).addressrecord;
				self.CLN_ADR_PRIM			:=	l.FIC_OWNER_ADDR;
				self.CLN_ADR_NUM			:=	Clean_address.prim_range;
				self.CLN_ADR_PRE			:=	Clean_address.predir;
				self.CLN_ADR_STR			:=	Clean_address.prim_name;
				self.CLN_ADR_SUF			:=	Clean_address.addr_suffix;
				self.CLN_ADR_POS			:=	Clean_address.postdir;
				self.CLN_ADR_UTYP			:=	Clean_address.unit_desig;
				self.CLN_ADR_UNUM			:=	Clean_address.sec_range;
				self.CLN_ADR_CITY			:=	Clean_address.v_city_name;
				self.CLN_ADR_ST				:=	Clean_address.st;
				self.CLN_ADR_ZIP5			:=	Clean_address.zip;
				self.CLN_ADR_ZIP4			:=	Clean_address.zip4;
				self.CLN_ADR_STAT			:=	Clean_address.err_stat;
				self.CHARTER_NUM			:=	l.FIC_OWNER_CHARTER_NUM;
				self.TAX_ID						:=	l.FIC_OWNER_FEI_NUM;
				self.CLN_TAX_ID				:=	l.FIC_OWNER_FEI_NUM;
				self.LF								:=	'\r\n';
				self									:=	[];
		end;
		
		dNameOwn				:=	project(dAddressStandardized, trfNameOwn(left));
   
		return dNameOwn;
	end;
	
	export fFilingAll(string pversion) := function
   
		dFiling			:= 	fFiling(FBN_CP_Extract.File_Florida_Filing_In,pversion);
		
		dFilingAll	:=	dedup(sort(distribute((dFiling + files().base.FLFilingBase.qa),hash(filing_num)),record,local),record,local);
		
		return dFilingAll;
   
	end;
	
	export fNameAll(string pversion) := function
   
		dNameBus			:= 	fNameBus(FBN_CP_Extract.File_Florida_Filing_In,pversion);
		
		dNameOwn			:= 	fNameOwn(FBN_CP_Extract.File_Florida_Filing_In,pversion);
		
		dNameAll			:=	dedup(sort(distribute((dNameBus + dNameOwn + files().base.FLNamesBase.qa),hash(filing_num)),record,local),record,local);
		
		return dNameAll;
   
	end;
	
end;