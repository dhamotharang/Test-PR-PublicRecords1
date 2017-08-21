import Address, Ut, lib_stringlib, _Control,_Validate, fbnv2;

export ExperianUpdates := module

	export	trimUpper(string s) := function
			return trim(stringlib.stringtoUppercase(s),LEFT, RIGHT);
	end;
	
	export	reformatDate(string inDate) := function
			string tmpDate 			:=  regexreplace('/',inDate,'')[1..8];
			string CCYYMMDDDate	:=	trim((tmpDate[5..8] + tmpDate[1..2] + tmpDate[3..4]),left,right);
			string newDate			:=	if (length(trim(CCYYMMDDDate,left,right))!=8,'',trim(CCYYMMDDDate,left,right));
			return newDate; 
		end; 

	export fFiling(dataset(fbnv2.Layout_fbn_experian.fbn_direct_raw) pRawFileInput, string pversion) := function
		
		FBN_CP_Extract.Layouts.Out.Filing	  trfFilingTmp(fbnv2.Layout_fbn_experian.fbn_direct_raw l, FBN_CP_Extract.Layouts.Tables.Location r)	:=	transform	
				self.IMPORT_DATE			:=	pVersion[5..6] + pVersion[7..8] + pVersion[1..4];
				self.CPS_SIG_FLNG 		:=	lib_StringLib.StringLib.Data2String(hashmd5('496' + l.Filing_state + l.filing_number + l.location_code + l.filing_date));
				self.CPS_VENDR_CD 		:=	'496';
				self.CPS_FILE_ST 			:=	l.Filing_state;
				self.CPS_CNTY_NM 			:=	StringLib.StringToUpperCase(r.County_name);
				self.FILING_NUM 			:=	StringLib.StringToUpperCase(l.filing_number);
				self.FILING_DTE 			:=	l.filing_date;
				tmp_file_dte					:=	reformatDate(l.filing_date);
				tmp_ins_dte						:=	reformatDate(l.insert_date);
				self.CLN_FILE_DTE 		:=	if (	_validate.date.fIsValid(tmp_file_dte) and
																				_validate.date.fIsValid(tmp_file_dte,_validate.date.rules.DateInPast) and
																				tmp_file_dte <= tmp_ins_dte,
																					tmp_file_dte,
																					''
																			);
				self.INSERT_DTE 			:=	l.insert_date;
				self.CLN_INS_DTE 			:=	tmp_ins_dte;
				self.JOB_NUM 					:=	l.job_number;
				self.LOCATION_CD 			:=	if (	StringLib.StringToUpperCase(l.location_code)='NO COURT DATA',
																				'0',
																				l.location_code
																			);
				self.CRT_FILE_ST 			:=	r.State_Code;
				self.CRT_NAME 				:=	if (	StringLib.StringToUpperCase(l.location_code)='NO COURT DATA',
																				'NO COURT DATA',
																				StringLib.StringToUpperCase(r.Court_Name)
																			);
				self.CRT_ADDR 				:=	StringLib.StringToUpperCase(r.Court_address);
				self.CRT_CITY 				:=	StringLib.StringToUpperCase(r.Court_City);
				self.CRT_TYPE 				:=	StringLib.StringToUpperCase(r.Court_type);
				self.CRT_ZIP 					:=	r.Court_zip;
				self.LF								:=	'\r\n';
				self									:=	[];
		end;
		
		FBN_CP_Extract.Layouts.Out.Filing	  trfFiling(FBN_CP_Extract.Layouts.Out.Filing l, FBN_CP_Extract.Layouts.Tables.Court r)	:=	transform	
				self.CPS_CRT_TYPE 		:=	StringLib.StringToUpperCase(r.cps_fld_cd);
				self.CPS_CTYP_DSC 		:=	StringLib.StringToUpperCase(r.cd_fld_desc);
				self									:=	l;
				self									:=	[];
		end;

		dFilingtmp	:=	join(	pRawFileInput,
													FBN_CP_Extract.files(pversion).Tables.Location,
													trim(left.location_code,left,right) = trim(right.location_code,left,right),
													trfFilingTmp(left,right),
													left outer,
													lookup
													);
													
		dFiling			:=	join(	dFilingtmp,
													FBN_CP_Extract.files().Tables.Court,
													trim(left.CRT_TYPE,left,right) = trim(right.VEND_FLD_CD,left,right),
													trfFiling(left,right),
													left outer,
													lookup
													);													
   
		return dFiling;
	end;
	
	export fName(dataset(fbnv2.Layout_fbn_experian.fbn_direct_raw) pRawFileInput, string pversion) := function
		
		addresslayout := record
			fbnv2.Layout_fbn_experian.fbn_direct_raw; 
			string100			address1;
			string50			address2;
		end;
		
		addresslayout tProjectAddress(fbnv2.Layout_fbn_experian.fbn_direct_raw l) := transform
			self.address1	:= StringLib.StringToUpperCase(l.address);
			self.address2	:= trim(StringLib.StringToUpperCase(l.city)) + ', '   + trim(StringLib.StringToUpperCase(l.state)) + ' ' + trim(l.Zip_Code);  
			self					:= l;
		end;
      
		dAddressPrep   := project(pRawFileInput, tProjectAddress(left));
      
		address.mac_address_clean( 	dAddressPrep
																,address1
																,address2
																,true
																,dAddressStandardized
															);

		FBN_CP_Extract.Layouts.Out.Name	  trfNameTmp(dAddressStandardized l, FBN_CP_Extract.Layouts.Tables.Location r)	:=	transform	
				self.IMPORT_DATE			:=	pVersion[5..6] + pVersion[7..8] + pVersion[1..4];
				self.CPS_SIG_NAME     :=	lib_StringLib.StringLib.Data2String(hashmd5(l.Name_Code + l.Name + l.Name_Type + l.Federal_TaxID + l.telephone + l.Address + l.City + l.State + l.country + l.zip_code));
				self.CPS_SIG_FLNG 		:=	lib_StringLib.StringLib.Data2String(hashmd5('496' + l.Filing_state + l.filing_number + l.location_code + l.filing_date));
				self.CPS_VENDR_CD 		:=	'496';
				self.CPS_FILE_ST 			:=	l.Filing_state;
				self.FILING_NUM 			:=	StringLib.StringToUpperCase(l.filing_number);
				tmp_file_dte					:=	reformatDate(l.filing_date);
				tmp_ins_dte						:=	reformatDate(l.insert_date);
				self.CLN_FILE_DTE 		:=	if (	_validate.date.fIsValid(tmp_file_dte) and
																				_validate.date.fIsValid(tmp_file_dte,_validate.date.rules.DateInPast) and
																				tmp_file_dte <= tmp_ins_dte,
																					tmp_file_dte,
																					''
																			);
				self.LOCATION_CD 			:=	if (	StringLib.StringToUpperCase(l.location_code)='NO COURT DATA',
																				'0',
																				l.location_code
																			);				
				self.CPS_REC_TYPE			:=	if (l.Name_Code = '1', 
																				if (StringLib.StringToUpperCase(l.Name_Type) = 'B', 
																							'F',
																							'O'
																						),
																				if (l.name_code = '2',
																						'O',
																						''
																						)
																			);
				self.NAME_CD					:=	l.Name_Code;
				self.CPS_NAME_CD			:=	if (l.name_code = '1',
																				'B',
																				if (l.name_code ='2',
																							'I',
																							''
																						)
																			);
				self.CPS_NCOD_DSC			:=	if (l.name_code = '1',
																				'BUSINESS NAME',
																				if (l.name_code ='2',
																							'PERSONAL NAME',
																							''
																						)
																			);
				string NameTypeTmp		:= 	StringLib.StringToUpperCase(l.Name_Type); 															
				self.NAME_TYPE				:=	NameTypeTmp;
				self.CPS_NAM_TYPE			:=	NameTypeTmp;
				
				self.CPS_NTYP_DSC			:=	map(NameTypeTmp	=	'B'	=>	'BUSINESS',
																			NameTypeTmp	=	'O'	=>	'OWNER',
																			NameTypeTmp	=	'R'	=>	'AGENT/REGISTRANT',
																			NameTypeTmp	=	'A'	=>	'AGENT',
																			NameTypeTmp	=	'L'	=>	'ALIAS',
																			NameTypeTmp	=	'F'	=>	'OFFICER',
																			NameTypeTmp	=	'W'	=>	'OWNER/AGENT',
																			''
																			);
				self.CPS_NAME_FMT			:=	'L';
				self.NAME							:=	StringLib.StringToUpperCase(l.name[1..60]);
				self.NAME_EXT					:=	StringLib.StringToUpperCase(l.name[61..]);
				self.ADDR_1						:=	StringLib.StringToUpperCase(l.Address);
				self.ADDR_CITY				:=	StringLib.StringToUpperCase(l.City);
				self.ADDR_ST					:=	StringLib.StringToUpperCase(l.State);
				self.ADDR_ZIP					:=	l.Zip_Code;
				self.ADDR_CNTRY				:=	StringLib.StringToUpperCase(l.Country);
				
				Clean_address					:= 	Address.CleanAddressFieldsFips(l.clean).addressrecord;
				self.CLN_ADR_PRIM			:=	StringLib.StringToUpperCase(l.Address);
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
				self.TAX_ID						:=	l.Federal_TaxID;
				self.CLN_TAX_ID				:=	l.Federal_TaxID;
				tmp_phone							:=	if (	lib_stringlib.StringLib.StringFindReplace(l.Telephone, '0','') = '',
																					'',
																					l.Telephone
																			);
				self.PHONE						:=	tmp_phone;
				tmp_phone2						:=	if (	length(StringLib.StringFilterOut(trim(tmp_phone,left,right),'0123456789'))>0,
																					'',
																					tmp_phone
																			);
				self.CLN_PHN_AREA			:=	if (	length(trim(tmp_phone2,left,right)) <= 7,
																					'',
																					if (length(trim(tmp_phone2,left,right)) >= 10,
																								trim(tmp_phone2,left,right)[1..3],
																								''
																							)
																			);
				self.CLN_PHN					:=	if (	length(trim(tmp_phone2,left,right)) <= 7,
																					trim(tmp_phone2,left,right),
																					if (length(trim(tmp_phone2,left,right)) >= 10,
																								trim(tmp_phone2,left,right)[4..],
																								''
																							)
																			);
				self.LF								:='\r\n';
				self									:=	[];
		end;
		
		dName				:=	join(	dAddressStandardized,
													FBN_CP_Extract.files(pversion).Tables.Location,
													trim(left.location_code,left,right) = trim(right.location_code,left,right),
													trfNameTmp(left,right),
													left outer,
													lookup
													);	
   
		return dName;
	end;

	export fFilingAll(string pversion) := function
   
		dFiling			:= 	fFiling(FBN_CP_Extract.File_Experian_In(stringlib.stringtoUppercase(name)!='OWNER NAMES'),pversion);
		
		dFilingAll	:=	dedup(sort(distribute((dFiling + files().base.ExpFilingBase.qa),hash(filing_num)),record,local),record,local);
		
		return dFilingAll;
   
	end;
	
	export fNameAll(string pversion) := function
   
		dName				:= 	fName(FBN_CP_Extract.File_Experian_In(stringlib.stringtoUppercase(name)!='OWNER NAMES'),pversion);
		
		dNameAll		:=	dedup(sort(distribute((dName + files().base.ExpNamesBase.qa),hash(filing_num)),record,local),record,local);
		
		return dNameAll;
   
	end;
end;