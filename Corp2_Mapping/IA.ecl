import Corp2, _validate, Address, lib_stringlib, _control, versioncontrol;

export IA := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export crpAdd := record,maxlength(2000) 
			string 	corp_file_no;
			string 	address_type;
			string 	name;
			string 	address_1;
			string 	address_2;
			string 	city;
			string	state;
			string 	zip;
			string 	country;
			string 	lf;
		end;

		export crpAgt := record,maxlength(2000) 
			string 	corp_file_no;
			string 	AgtName;
			string 	AgtAddress_1;
			string 	AgtAddress_2;
			string 	AgtCity;
			string	AgtState;
			string 	AgtZip;
			string 	AgtNo;
			string 	AgtSeq;
			string 	AgtId;
			string 	lf;
		end;

		export crpDes := record,maxlength(2000) 
			string	corp_file_no;
			string 	ap_type;
			string 	desc;
			string 	lf;
		end;

		export crpFil := record,maxlength(2000) 
			string 	corp_file_no;
			string 	chapter_no;
			string 	delin_flag;
			string 	farm_flag;
			string 	farm_delin_flag;
			string 	dead_code;
			string 	dead_date;
			string 	state_of_incorp;
			string	status_code;
			string 	date_incorp;
			string 	date_expired;
			string 	no_acres;
			string 	lf;
		end;

		export crpHis := record,maxlength(2000) 
			string 	corp_file_no;
			string 	type_filing;
			string 	date_filed;
			string 	time_filed;
			string 	date_filing_eff;
			string 	time_fiing_eff;
			string 	his_date_expired;
			string 	total_pages;
			string 	book_no;
			string 	page_no;
			string 	cert_no;
			string 	remarks_flag;
			string 	merger_file_no;
			string 	merger_status;
			string 	merger_name;
			string 	merger_state;
			string 	lf;
		end;

		export crpNam := record,maxlength(2000) 
			string 	corp_file_no;
			string 	name_type;
			string 	curr_name;
			string 	name_mod_flag;
			string 	name_frm;
			string	name_status_code;
			string 	name_cert_no;
			string 	sequence_no;
			string 	old_sequence_no;
			string 	lf;
		end;

		export crpOff := record,maxlength(2000) 
			string 	corp_file_no;
			string 	name;
			string 	address_1;
			string 	address_2;
			string 	city;
			string 	state;
			string 	zip;
			string 	country;
			string 	officer_type;
			string 	dir_flag;
			string 	shholder_flag;
			string 	lf;
		end;

		export crpPrt := record,maxlength(2000) 
			string 	corp_file_no;
			string 	partners;
			string 	lf;
		end;
		
		export crpRem := record,maxlength(2000) 
			string 	corp_file_no;
			string 	remarks;
			string	RemCertNo;
		end;

		export crpStk := record,maxlength(2000) 
			string 	corp_file_no;
			string 	stock_type;
			string 	stock_class;
			string 	stock_series;
			string 	number_shares;
			string 	lf;
		end;
		
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	    
		// vendor file definition
		export VendorCrpAdd(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::crpAdd::ia',	
																	layouts_Raw_Input.CrpAdd,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													  
													   
		export VendorCrpAgt(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpAgt::IA',	
																	layouts_Raw_Input.CrpAgt,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													 
													   
		export VendorCrpDes(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpDes::IA',	
																	layouts_Raw_Input.CrpDes,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
												
													   
		export VendorCrpFil(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::crpFil::ia',	
																	layouts_Raw_Input.CrpFil,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   
													   													   
		export VendorCrpHis(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpHis::IA',	
																	layouts_Raw_Input.CrpHis,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   													   
		export VendorCrpNam(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpNam::IA',	
																	layouts_Raw_Input.CrpNam,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   													   
		export VendorCrpOff(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpOff::IA',	
																	layouts_Raw_Input.CrpOff,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   													   
		export VendorCrpPrt(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpPrt::IA',	
																	layouts_Raw_Input.CrpPrt,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   	
		export VendorCrpRem(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpRem::IA',	
																	layouts_Raw_Input.CrpRem,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   
		export VendorCrpStk(string filedate) := distribute(dataset('~thor_data400::in::corp2::'+filedate+'::CrpStk::IA',	
																	layouts_Raw_Input.CrpStk,
																	CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(corp_file_no));
													   													   
									 
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		crpFilLookups := record,maxlength(2000) 
			string 	corp_file_no;
			string 	chapter_no;
			string 	delin_flag;
			string 	farm_flag;
			string 	farm_delin_flag;
			string 	dead_code;
			string 	dead_date;
			string 	state_of_incorp;
			string	status_code;
			string 	date_incorp;
			string 	date_expired;
			string 	no_acres;
			string	chapterDesc;
			string	forgnStateDesc;
			string	forgnCountryDesc;
		end;
		
		crpHisLookups := record,maxlength(2000) 
			string 	corp_file_no;
			string 	type_filing;
			string 	date_filed;
			string 	time_filed;
			string 	date_filing_eff;
			string 	time_fiing_eff;
			string 	his_date_expired;
			string 	total_pages;
			string 	book_no;
			string 	page_no;
			string 	cert_no;
			string 	remarks_flag;
			string 	merger_file_no;
			string 	merger_status;
			string 	merger_name;
			string 	merger_state;
			string 	pageNoDesc;
			string	filingTypeDesc;
			string	forgnFilingStateDesc;
			string	forgnFilingCountryDesc;
		end;
		
		crpOffLookups := record,maxlength(2000) 
			string 	corp_file_no;
			string 	name;
			string 	address_1;
			string 	address_2;
			string 	city;
			string 	state;
			string 	zip;
			string 	country;
			string 	officer_type;
			string 	dir_flag;
			string 	shholder_flag;
			string 	officerTypeDesc;
		end;
		
		FilAgt := record,maxlength(2000)
			// crpFilLookups
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			string 	delin_flag		:= '';
			string 	farm_flag		:= '';
			string 	farm_delin_flag	:= '';
			string 	dead_code		:= '';
			string 	dead_date		:= '';
			string 	state_of_incorp	:= '';
			string	status_code		:= '';
			string 	date_incorp		:= '';
			string 	date_expired	:= '';
			string 	no_acres		:= '';
			string	chapterDesc		:= '';
			string	forgnStateDesc	:= '';
			string	forgnCountryDesc:= '';
			// crpAgt
			string 	AgtName			:= '';
			string 	AgtAddress_1	:= '';
			string 	AgtAddress_2	:= '';
			string 	AgtCity			:= '';
			string	AgtState		:= '';
			string 	AgtZip			:= '';
			string 	AgtNo			:= '';
			string 	AgtSeq			:= '';
			string 	AgtId			:= '';
		end;
		
		FilAgtAdd := record,maxlength(2000)
			// crpFilLookups
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			string 	delin_flag		:= '';
			string 	farm_flag		:= '';
			string 	farm_delin_flag	:= '';
			string 	dead_code		:= '';
			string 	dead_date		:= '';
			string 	state_of_incorp	:= '';
			string	status_code		:= '';
			string 	date_incorp		:= '';
			string 	date_expired	:= '';
			string 	no_acres		:= '';
			string	chapterDesc		:= '';
			string	forgnStateDesc	:= '';
			string	forgnCountryDesc:= '';
			// crpAgt
			string 	AgtName			:= '';
			string 	AgtAddress_1	:= '';
			string 	AgtAddress_2	:= '';
			string 	AgtCity			:= '';
			string	AgtState		:= '';
			string 	AgtZip			:= '';
			string 	AgtNo			:= '';
			string 	AgtSeq			:= '';
			string 	AgtId			:= '';
			//crpAdd
			string 	address_type	:= '';
			string 	name			:= '';
			string 	address_1		:= '';
			string 	address_2		:= '';
			string 	city			:= '';
			string	state			:= '';
			string 	zip				:= '';
			string 	country			:= '';
		end;
		
		FilAgtAddDes := record,maxlength(2000)
			// crpFilLookups
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			string 	delin_flag		:= '';
			string 	farm_flag		:= '';
			string 	farm_delin_flag	:= '';
			string 	dead_code		:= '';
			string 	dead_date		:= '';
			string 	state_of_incorp	:= '';
			string	status_code		:= '';
			string 	date_incorp		:= '';
			string 	date_expired	:= '';
			string 	no_acres		:= '';
			string	chapterDesc		:= '';
			string	forgnStateDesc	:= '';
			string	forgnCountryDesc:= '';
			// crpAgt
			string 	AgtName			:= '';
			string 	AgtAddress_1	:= '';
			string 	AgtAddress_2	:= '';
			string 	AgtCity			:= '';
			string	AgtState		:= '';
			string 	AgtZip			:= '';
			string 	AgtNo			:= '';
			string 	AgtSeq			:= '';
			string 	AgtId			:= '';
			//crpAdd
			string 	address_type	:= '';
			string 	name			:= '';
			string 	address_1		:= '';
			string 	address_2		:= '';
			string 	city			:= '';
			string	state			:= '';
			string 	zip				:= '';
			string 	country			:= '';
			// crpDes
			string 	ap_type			:= '';
			string 	desc			:= '';	
		end;

		FilAgtAddDesNam := record,maxlength(2000)
			// crpFilLookups
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			string 	delin_flag		:= '';
			string 	farm_flag		:= '';
			string 	farm_delin_flag	:= '';
			string 	dead_code		:= '';
			string 	dead_date		:= '';
			string 	state_of_incorp	:= '';
			string	status_code		:= '';
			string 	date_incorp		:= '';
			string 	date_expired	:= '';
			string 	no_acres		:= '';
			string	chapterDesc		:= '';
			string	forgnStateDesc	:= '';
			string	forgnCountryDesc:= '';
			// crpAgt
			string 	AgtName			:= '';
			string 	AgtAddress_1	:= '';
			string 	AgtAddress_2	:= '';
			string 	AgtCity			:= '';
			string	AgtState		:= '';
			string 	AgtZip			:= '';
			string 	AgtNo			:= '';
			string 	AgtSeq			:= '';
			string 	AgtId			:= '';
			//crpAdd
			string 	address_type	:= '';
			string 	name			:= '';
			string 	address_1		:= '';
			string 	address_2		:= '';
			string 	city			:= '';
			string	state			:= '';
			string 	zip				:= '';
			string 	country			:= '';
			// crpDes
			string 	ap_type			:= '';
			string 	desc			:= '';	
			// crpNam
			string 	name_type		:= '';
			string 	curr_name		:= '';
			string 	name_mod_flag	:= '';
			string 	name_frm		:= '';
			string	name_status_code := '';
			string 	name_cert_no	:= '';
			string 	sequence_no		:= '';
			string 	old_sequence_no	:= '';
		end;

		
		AllEventFiles := record,maxlength(2000)
			// crpFil
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			// crpHisLookups
			string 	type_filing		:= '';
			string 	date_filed		:= '';
			string 	time_filed		:= '';
			string 	date_filing_eff	:= '';
			string 	time_fiing_eff	:= '';
			string 	his_date_expired := '';
			string 	total_pages		:= '';
			string 	book_no			:= '';
			string 	page_no			:= '';
			string 	cert_no			:= '';
			string 	remarks_flag	:= '';
			string 	merger_file_no	:= '';
			string 	merger_status	:= '';
			string 	merger_name		:= '';
			string 	merger_state	:= '';
			string 	pageNoDesc		:= '';
			string	filingTypeDesc	:= '';
			string	forgnFilingStateDesc := '';
			string	forgnFilingCountryDesc := '';
			// crpRem
			string 	remarks			:= '';
			string	RemCertNo		:= '';
		end;	
		
		crpOffLookupsNam := record,maxlength(1000)
			string 	corp_file_no;
			string 	name;
			string 	address_1;
			string 	address_2;
			string 	city;
			string 	state;
			string 	zip;
			string 	country;
			string 	officer_type;
			string 	dir_flag;
			string 	shholder_flag;
			string 	officerTypeDesc;
			string 	curr_name;
		end;		
		
		//--------------------  Chapter code explosion ------------------
		
		ChapterCodeLayout := record
			string6		ChapterCode;
			string50	ChapterDesc;
			string1 	lf;
		end;
		
		ChapterTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::ChapterCodes_Table::ia', ChapterCodeLayout, flat);
		
		crpFilLookups findChapterCode(layouts_raw_input.crpFil input, ChapterCodeLayout r ) := transform
			self.chapterDesc      := r.ChapterDesc;
			self         		  := input;
			self                  := [];
		end; // end transform
	
		PopChapter := join(	Files_Raw_Input.VendorCrpFil(fileDate), ChapterTable,
							trim(left.chapter_no,left,right) = right.ChapterCode,
							findChapterCode(left,right),
							left outer, lookup
						   );
							
		//----------------------------------------------------------------
		
		//--------------------  State code explosion ---------------------
		
		StateCodeLayout := record
			string2		StateCode;
			string30	StateDesc;
			string2 	blank;
		end;
		
		StateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::StateCodes_Table::ia', StateCodeLayout, flat);
		
		crpFilLookups findStateCode(crpFilLookups input, StateCodeLayout r ) := transform
			self.forgnStateDesc   := r.StateDesc;
			self         		  := input;
		end;
	
		PopforgnStateDesc := join(	PopChapter, StateTable,
									trim(left.state_of_incorp,left,right) = right.StateCode,
									findStateCode(left,right),
									left outer, lookup
								  );
							
		//----------------------------------------------------------------
		
		//--------------------  Country code explosion -------------------
		
		CountryCodeLayout := record
			string2		CountryCode;
			string44	CountryDesc;
			string118 	blank;
		end;
		
		CountryTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::CountryCodes_Table::ia', CountryCodeLayout, flat);
		
		crpFilLookups findCountryCode(crpFilLookups input, CountryCodeLayout r ) := transform
			self.forgnCountryDesc   := r.CountryDesc;
			self         		  	:= input;
		end;
	
		PopforgnCountryDesc := join(PopforgnStateDesc, CountryTable,
									trim(left.state_of_incorp,left,right) = right.CountryCode,
									findCountryCode(left,right),
									left outer, lookup
								  );
							
		//----------------------------------------------------------------
		
		//--------------------  Page Number explosion --------------------
		
		PageNoLayout := record
			string3		PageCode;
			string60	PageDesc;
			string1 	lf;
		end;
		
		PageNoTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::PageNo_Table::ia', PageNoLayout, flat);
		
		crpHisLookups findPageNo(layouts_raw_input.crpHis input, PageNoLayout r ) := transform
			self.pageNoDesc   		:= r.PageDesc;
			self         		  	:= input;
			self                 	:= [];
		end;
	
		PopPageNo := join(	Files_Raw_Input.VendorCrpHis(fileDate), PageNoTable,
							trim(left.page_no,left,right) = right.PageCode,
							findPageNo(left,right),
							left outer, lookup
						  );
							
		//----------------------------------------------------------------
		
		//--------------------  Filing State code explosion ---------------------
		
	
		crpHisLookups findFilingStateCode(crpHisLookups input, StateCodeLayout r ) := transform
			self.forgnFilingStateDesc   := r.StateDesc;
			self         		  		:= input;
			self                  		:= [];
		end;
	
		PopforgnFilingStateDesc := join(	PopPageNo, StateTable,
											trim(left.merger_state,left,right) = right.StateCode,
											findFilingStateCode(left,right),
											left outer, lookup
										);
							
		//----------------------------------------------------------------
		
		//--------------------  Filing Country code explosion -------------------
		
		
		crpHisLookups findFilingCountryCode(crpHisLookups input, CountryCodeLayout r ) := transform
			self.forgnFilingCountryDesc := r.CountryDesc;
			self         		  		:= input;
			self                 		:= [];
		end;
	
		PopforgnFilingCountryDesc := join(	PopforgnFilingStateDesc, CountryTable,
											trim(left.merger_state,left,right) = right.CountryCode,
											findFilingCountryCode(left,right),
											left outer, lookup
										 );
							
		//----------------------------------------------------------------
		
		//--------------------  Filing Type explosion --------------------
		
		FilingTypeLayout := record
			string4		FilingTypCode;
			string83	FilingTypDesc;
			string1 	lf;
		end;
		
		FilingTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::FilingType_Table::ia', FilingTypeLayout, flat);
		
		crpHisLookups findFilingType(crpHisLookups input, FilingTypeLayout r ) := transform
			self.FilingTypeDesc   	:= r.FilingTypDesc;
			self         		  	:= input;
			self                 	:= [];
		end;
	
		PopFilingType := join(	PopforgnFilingCountryDesc, FilingTypeTable,
								trim(left.type_filing,left,right) = right.FilingTypCode,
								findFilingType(left,right),
								left outer, lookup
							  );
							
		//----------------------------------------------------------------
		
		//--------------------  Officer Type explosion --------------------
		
		OfficerTypeLayout := record
			string2		OfficerTypCode;
			string25	OfficerTypDesc;
			string1 	lf;
		end;
		
		OfficerTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::OfficerType_Table::ia', OfficerTypeLayout, flat);
		
		crpOffLookups findOfficerType(layouts_raw_input.crpOff input, OfficerTypeLayout r ) := transform
			self.OfficerTypeDesc   	:= r.OfficerTypDesc;
			self         		  	:= input;
			self                 	:= [];
		end;
	
		PopOfficerType := join(	Files_Raw_Input.VendorCrpOff(fileDate), OfficerTypeTable,
								trim(left.officer_type,left,right) = right.OfficerTypCode,
								findOfficerType(left,right),
								left outer, lookup
							  );
							
		//----------------------------------------------------------------
				
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		
		corp2_mapping.Layout_CorpPreClean corpMasterTransform(FilAgtAddDesNam input) := transform,skip(trimUpper(input.name_type) <> 'L')

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);
			self.corp_vendor					:= '19';
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_file_no);
			self.corp_src_type					:= 'SOS';	
			chapter								:= if (trim(input.chapterDesc,left,right) <> '',
															'CHAPTER NO: ' + trim(input.chapterDesc,left,right),
															''
													   );
													   
			delinquent							:= if (trimUpper(input.delin_flag) = 'Y',
															'DELINQUENT BIENNIAL REPORT',
															''
													   );
													   
			farm								:= if (trimUpper(input.farm_flag) = 'Y',
															'OWNS AGRICULTURAL LAND',
															''
													   );
													   
			farmDelinquent						:= if (trimUpper(input.farm_delin_flag) = 'Y',
															'DELINQUENT AGRICULTURAL REPORT',
															''
													   );
													   
			concatFields						:= trim(	trim(chapter,left,right) + ';' + 
															trim(delinquent,left,right) + ';' +
															trim(farm,left,right) + ';' + 
															trim(farmDelinquent,left,right) 
														  );
			
			tempExp								:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							:= regexreplace('^[;]*',tempExp,'',NOCASE);
			
			self.corp_addl_info                 := regexreplace('[;]+',tempExp2,';',NOCASE);	 
			
			            													   
			self.corp_legal_name				:= trimUpper(input.curr_name); 														
			self.corp_ln_name_type_cd			:= trimUpper(input.name_type);
			self.corp_ln_name_type_desc			:= map( trimUpper(input.name_type) = 'AI' 	=> 'AUTHORIZED INDISTINGUISHABLE',
														trimUpper(input.name_type) = 'DF' 	=> 'DOMESTIC FICTITIOUS',
														trimUpper(input.name_type) = 'F' 	=> 'FORMER',
														trimUpper(input.name_type) = 'FA' 	=> 'FORMER ASSUMED',
														trimUpper(input.name_type) = 'FF' 	=> 'FOREIGN FICTITIOUS',
														trimUpper(input.name_type) = 'FN' 	=> 'FICTITIOUS NAME',
														trimUpper(input.name_type) = 'I' 	=> 'IDENTIFYING',
														trimUpper(input.name_type) = 'L' 	=> 'LEGAL',
														trimUpper(input.name_type) = 'LF' 	=> 'LEGAL (FOREIGN USING FICTITIOUS)',
														trimUpper(input.name_type) = 'R' 	=> 'RESERVED',
														trimUpper(input.name_type) = 'RG' 	=> 'REGISTERED',
														trimUpper(input.name_type) = 'RN' 	=> 'RESERVED - NON PROFIT',
														trimUpper(input.name_type) = 'RP' 	=> 'RESERVED PROFIT',
														trimUpper(input.name_type) = 'RU' 	=> 'REGISTERED',
														trimUpper(input.name_type) = 'T' 	=> 'TEMPORARY',
														''
													  );
			
			cleanStatus							:= trimUpper(input.status_code);
			deadCode							:= trimUpper(input.dead_code);
			
			self.corp_status_cd					:= cleanStatus;
													   
			StatusDesc							:= map(	cleanStatus = 'A' => 'ACTIVE',
														cleanStatus = 'D' => 'DEAD/INACTIVE',
														''
													   );
													   
			InactiveDesc						:= map(	deadCode = 'A' => 'NO REGISTERED AGENT ON FILE',
														deadCode = 'C' => 'CONSOLIDATION',
														deadCode = 'D' => 'DISSOLUTION',
														deadCode = 'E' => 'EXPIRED',
														deadCode = 'M' => 'MERGED',
														deadCode = 'N' => 'ACTIVE',
														deadCode = 'O' => 'OTHER',
														deadCode = 'R' => 'ANNUAL/BIENNIAL REPORT NOT FILED',
														deadCode = 'V' => 'REVOKED',
														''
													   );
													   
			self.corp_status_desc				:= if (StatusDesc <> '',
															if (InactiveDesc <> '' and trim(StatusDesc,left,right)<>'ACTIVE',
																	trimUpper(StatusDesc) + '; ' + InactiveDesc,
																	trimUpper(StatusDesc)
																),
															''
														);
																									
			SELF.corp_status_date				:= if(	trim(input.dead_date,left,right) <> '' and 
														_validate.date.fIsValid(input.dead_date[7..10] + input.dead_date[1..2] + input.dead_date[4..5]), 
														input.dead_date[7..10] + input.dead_date[1..2] + input.dead_date[4..5],
														''
												     );
													 
			self.corp_term_exist_cd				:= if (trim(input.date_expired,left,right) = '12-31-9999',
															'P',
															if (trim(input.date_expired,left,right) <> '',
																	'D',
																	''
																)
													   );
													   
			self.corp_term_exist_desc			:= if (trim(input.date_expired,left,right) = '12-31-9999',
															'PERPETUAL',
															''
													   );
													   
			self.corp_term_exist_exp			:= if (	trim(input.date_expired,left,right) <> '12-31-9999' and 
														trim(input.date_expired,left,right) <> '',
															input.date_expired[7..10] +
															input.date_expired[1..2] +
															input.date_expired[4..5],
															''
													   );													   
													   
			self.corp_inc_state					:= if(trimUpper(input.state_of_incorp) = 'IA' ,
			                                          'IA',
													  ''
												   );
												   
			self.corp_forgn_state_cd            := if(trimUpper(input.state_of_incorp) <> 'IA' ,
			                                          trimUpper(input.state_of_incorp),
													  ''
												   );
												   
			self.corp_forgn_state_desc          := if(trimUpper(input.state_of_incorp) <> 'IA' ,
														if (trimUpper(input.forgnStateDesc) <> '',
																input.forgnStateDesc,
																input.forgnCountryDesc
															),
														''
												      );
													  
			APType								:= map (trimUpper(input.ap_type) = 'I' => 'INDIVIDUAL',
														trimUpper(input.ap_type) = 'C' => 'CORPORATION',
														trimUpper(input.ap_type) = 'P' => 'PARTNERSHIP',
														trimUpper(input.ap_type) = 'O' => 'OTHER',
														''
													   );
			
			status								:= map (trimUpper(input.name_status_code) = 'A' => 'ACTIVE',
														trimUpper(input.name_status_code) = 'D' => 'DEAD/INACTIVE',
														''
													   );
													   
			cert								:= if (trimUpper(input.name_cert_no) <> '',
															'CERTIFICATE NUMBER: ' + trimUpper(input.name_cert_no),
															''
													   );
													   
			concatCommentFields					:= trim(apType,left,right) + ';' + 
												   trimUpper(input.desc) + ';' +
												   trim(status,left,right) + ';' + 
												   trim(cert,left,right); 
																	
			commentExp							:= regexreplace('[;]*$',concatCommentFields,'',NOCASE);
			commentExp2							:= regexreplace('^[;]*',commentExp,'',NOCASE);
			
			self.corp_name_comment  		 	:= regexreplace('[;]+',commentExp2,';',NOCASE);	
													  
			self.corp_address1_line1 			:= trimUpper(input.name);
			self.corp_address1_line2			:= trimUpper(input.address_1);
			self.corp_address1_line3			:= trimUpper(input.address_2);
			self.corp_address1_line4			:= trimUpper(input.city);
			
			stateCode							:= if (trimUpper(input.state) <> '' and trimUpper(input.State) <> 'XX',
														trimUpper(input.state),
														''
													  );
													  
								
			self.corp_address1_line5			:= if(trim(input.zip,left,right) <> '',
														stateCode + ' ' + trim(input.zip,left,right),
														stateCode
													  );
													  
			self.corp_address1_line6			:= trimUpper(input.country);
			
			addrCode							:= map (trimUpper(input.address_type) = 'H' => 'B',
														trimUpper(input.address_type) = 'M' => 'M',
														''
													    );
													  
		    self.corp_address1_type_cd			:= if(	trim(input.name,left,right) <> '' or 
														trim(input.address_1,left,right) <> '' or 
														trim(input.address_2,left,right) <> '' or
														trim(input.city,left,right) <> '' or 
														trim(input.state,left,right) <>'' or 
														trim(input.zip,left,right) <> '',
															addrCode,
															''
													  );

													  
		    // self.corp_address1_type_desc		:= if(	trim(input.name,left,right) <> '' or 
														// trim(input.address_1,left,right) <> '' or 
														// trim(input.address_2,left,right) <> '' or
														// trim(input.city,left,right) <> '' or 
														// trim(input.state,left,right) <>'' or 
														// trim(input.zip,left,right) <> '',
														// if (addrCode = 'B',
																// 'BUSINESS',
																// if (addrCode = 'M',
																	// 'MAILING',
																	// ''
																	// )
															// )
														// ''
													  // );
													  
			self.corp_ra_name					:= if (	trimUpper(input.AgtName) <> '',
														trimUpper(input.AgtName),
														''
													   );

													  
			self.corp_ra_address_line1 			:= trimUpper(input.AgtAddress_1);
														
													   
			self.corp_ra_address_line2			:= trimUpper(input.AgtAddress_2);
														
			self.corp_ra_address_line3			:= trimUpper(input.AgtCity);
														
			self.corp_ra_address_line4			:= if (trimUpper(input.AgtState) <> '' and trimUpper(input.AgtState) <> 'XX',
														trimUpper(input.AgtState),
														''
													  );
													  
														
			self.corp_ra_address_line5			:= trim(input.AgtZip,left,right);
										
			self.corp_inc_date                  := if(	trimUpper(input.date_incorp) = 'IA'  and 
														trim(input.date_incorp,left,right) <> '' and 
														_validate.date.fIsValid(input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5]) and 
														_validate.date.fIsValid(input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5],_validate.date.rules.DateInPast),
														input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5],
														''
												     );
													
			self.corp_forgn_date 				:= if(	trimUpper(input.date_incorp) <>'IA' and 
														trim(input.date_incorp,left,right) <> '' and 
														_validate.date.fIsValid(input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5]) and 
														_validate.date.fIsValid(input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5],_validate.date.rules.DateInPast),
														input.date_incorp[7..10] + input.date_incorp[1..2] + input.date_incorp[4..5],
														''
												      );
										   			
			self := [];
						
		end; 
		
		corp2_mapping.Layout_CorpPreClean corpMergerTransform(crpHisLookups input) := transform,skip(trimUpper(input.merger_status) <> 'D')

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);
			self.corp_vendor					:= '19';
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_file_no);
			self.corp_src_type					:= 'SOS';
			
			self.corp_legal_name				:= trimUpper(input.merger_name);
			self.corp_ln_name_type_desc			:= 'NON-SURVIVOR';
			self.corp_status_cd					:= 'D';
			self.corp_status_desc				:= 'DEAD/INACTIVE';
			self.corp_inc_state					:= if(trimUpper(input.merger_state) = 'IA' ,
			                                          'IA',
													  ''
												   );
												   
			self.corp_forgn_state_cd            := if(trimUpper(input.merger_state) <> 'IA' ,
			                                          trimUpper(input.merger_state),
													  ''
												   );
												   
			self.corp_forgn_state_desc          := if(trimUpper(input.merger_state) <> 'IA' ,
														if (trimUpper(input.forgnFilingStateDesc) <> '',
																input.forgnFilingStateDesc,
																input.forgnFilingCountryDesc
															),
														''
												      );
													  
			self.corp_addl_info					:= if (trimUpper(input.merger_file_no) <> '',
															'NON-SURVIVOR CHARTER NUMBER: ' + (string)((integer)input.merger_file_no),
															''
													   );
			
			self								:= [];
		end;
		
		corp2_mapping.Layout_CorpPreClean corpOtherTransform(FilAgtAddDesNam input) := transform,skip(trimUpper(input.name_type) = 'L')

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);
			self.corp_vendor					:= '19';
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_file_no);
			self.corp_src_type					:= 'SOS';	
			            													   
			self.corp_legal_name				:= trimUpper(input.curr_name); 														
			self.corp_ln_name_type_cd			:= trimUpper(input.name_type);
			self.corp_ln_name_type_desc			:= map( trimUpper(input.name_type) = 'AI' 	=> 'AUTHORIZED INDISTINGUISHABLE',
														trimUpper(input.name_type) = 'DF' 	=> 'DOMESTIC FICTITIOUS',
														trimUpper(input.name_type) = 'F' 	=> 'FORMER',
														trimUpper(input.name_type) = 'FA' 	=> 'FORMER ASSUMED',
														trimUpper(input.name_type) = 'FF' 	=> 'FOREIGN FICTITIOUS',
														trimUpper(input.name_type) = 'FN' 	=> 'FICTITIOUS NAME',
														trimUpper(input.name_type) = 'I' 	=> 'IDENTIFYING',
														trimUpper(input.name_type) = 'L' 	=> 'LEGAL',
														trimUpper(input.name_type) = 'LF' 	=> 'LEGAL (FOREIGN USING FICTITIOUS)',
														trimUpper(input.name_type) = 'R' 	=> 'RESERVED',
														trimUpper(input.name_type) = 'RG' 	=> 'REGISTERED',
														trimUpper(input.name_type) = 'RN' 	=> 'RESERVED - NON PROFIT',
														trimUpper(input.name_type) = 'RP' 	=> 'RESERVED PROFIT',
														trimUpper(input.name_type) = 'RU' 	=> 'REGISTERED',
														trimUpper(input.name_type) = 'T' 	=> 'TEMPORARY',
														''
													  );
													  
			APType								:= map (trimUpper(input.ap_type) = 'I' => 'INDIVIDUAL',
														trimUpper(input.ap_type) = 'C' => 'CORPORATION',
														trimUpper(input.ap_type) = 'P' => 'PARTNERSHIP',
														trimUpper(input.ap_type) = 'O' => 'OTHER',
														''
													   );
			
			status								:= map (trimUpper(input.name_status_code) = 'A' => 'ACTIVE',
														trimUpper(input.name_status_code) = 'D' => 'DEAD/INACTIVE',
														''
													   );
													   
			cert								:= if (trimUpper(input.name_cert_no) <> '',
															'CERTIFICATE NUMBER: ' + trimUpper(input.name_cert_no),
															''
													   );
													   
			concatCommentFields					:= trim(apType,left,right) + ';' + 
												   trimUpper(input.desc) + ';' +
												   trim(status,left,right) + ';' + 
												   trim(cert,left,right); 
																	
			commentExp							:= regexreplace('[;]*$',concatCommentFields,'',NOCASE);
			commentExp2							:= regexreplace('^[;]*',commentExp,'',NOCASE);
			
			self.corp_name_comment  		 	:= regexreplace('[;]+',commentExp2,';',NOCASE);	
	  
			
			self := [];
						
		end; 
		
	
				
		corp2_mapping.Layout_ContPreClean contTransform(crpOffLookupsNam input) := transform

			self.dt_first_seen					:=fileDate;
			self.dt_last_seen					:=fileDate;

			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);
			self.corp_vendor					:= '19';
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_file_no);
			
			self.corp_legal_name				:= trimUpper(input.curr_name);
	
			self.cont_title1_desc				:= trimUpper(input.officerTypeDesc);
									  
			self.cont_name						:= trimUpper(input.name);
			
			self.cont_address_line1 			:= trimUpper(input.address_1),

			self.cont_address_line2				:= trimUpper(input.Address_2);
														
			self.cont_address_line3				:= trimUpper(input.City);
														
			self.cont_address_line4				:= if (trimUpper(input.State) <> '' and trimUpper(input.State) <> 'XX',
															trimUpper(input.State),
															''
													   );
													  
			self.cont_address_line5				:= trim(input.Zip,left,right);
			
			self.cont_address_line6				:= trimUpper(input.country);
														
																										  
		    self.cont_address_type_cd			:= if(	trim(input.address_1,left,right) <> '' or 
														trim(input.address_2,left,right) <> '' or 
														trim(input.city,left,right) <> '' or
														trim(input.state,left,right) <>'' or 
														trim(input.zip,left,right) <> '' or 
														trim(input.country,left,right) <> '',
														'T',
														''
													  );
													  
		    self.cont_address_type_desc			:= if(	trim(input.address_1,left,right) <> '' or 
														trim(input.address_2,left,right) <> '' or 
														trim(input.city,left,right) <> '' or
														trim(input.state,left,right) <>'' or 
														trim(input.zip,left,right) <> '' or 
														trim(input.country,left,right) <> '',
														'CONTACT',
														''
													  );
													  
			self.cont_addl_info					:= if(trimUpper(input.shholder_flag) = 'Y',
														'SHAREHOLDER',
														''
													  );
													  
			self := [];	
			
		end;
		
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform(layouts_raw_input.crpStk input):=transform

			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);		
			self.corp_vendor					:= '19';		
		
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr			:= trimUpper(input.corp_file_no);
		
	
			self.stock_type						:= map(	trimUpper(input.stock_type) = 'C' 		=> 'COMMON',
														trimUpper(input.stock_type) = 'P' 		=> 'PREFERRED',
														trimUpper(input.stock_type) = 'N' 		=> 'VOTING',
														trimUpper(input.stock_type) = 'NV'		=> 'NON-VOTING',
														trimUpper(input.stock_type) = 'CUM' 	=> 'CUMULATIVE',
														trimUpper(input.stock_type) = 'ORG' 	=> 'ORGANIZATION',
														trimUpper(input.stock_type) = 'CONV' 	=> 'CONVERTIBLE',
														trimUpper(input.stock_type)
													  );											
													
			self.stock_class					:= trimUpper(input.stock_class);
			
	
			self.stock_authorized_nbr			:= trim(input.number_shares,left,right);
			
			self.stock_addl_info				:= trimUpper(input.stock_series);

			self								:=[];

		end;

		Corp2.Layout_Corporate_Direct_AR_In ARTransform(crpHisLookups  input):=transform,skip(	trimUpper(input.type_filing) <> 'ANNR' and
																								trimUpper(input.type_filing) <> 'BIEN' and
																								trimUpper(input.type_filing) <> 'PMT')

			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);		
			self.corp_vendor					:= '19';		
		
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr			:= trimUpper(input.corp_file_no);

			arFilingDate						:= if ( trim( 	input.date_filed,left,right) <> '',
																input.date_filed[7..10] +
																input.date_filed[1..2] +
																input.date_filed[4..5],'');

		
			self.ar_filed_dt					:= if ( arFilingDate <> '' and
														_validate.date.fIsValid(arFilingDate) and
														_validate.date.fIsValid(arFilingDate,_validate.date.rules.DateInPast),arFilingDate,'');  


			self.ar_comment						:= map( trimUpper(input.type_filing) = 'ANNR' => 'ANNUAL REPORT FILED',
														trimUpper(input.type_filing) = 'BIEN' => 'BIENNIAL REPORT FILED',
														trimUpper(input.type_filing) = 'PMT'  => 'PAYMENT FOR BIENNIAL REPORT',
														''
													   );

		
			self								:=[];

		end;		
	
		Corp2.Layout_Corporate_Direct_Event_In EventTransform(AllEventFiles  input):=transform,skip(trimUpper(input.type_filing) = 'ANNR' or
																									trimUpper(input.type_filing) = 'BIEN' or
																									trimUpper(input.type_filing) = 'PMT')
																								
																								
			self.corp_key						:= '19-' + trimUpper(input.corp_file_no);	
			self.corp_vendor					:= '19';		
		
			self.corp_state_origin				:= 'IA';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr			:= trimUpper(input.corp_file_no);
			
			self.event_filing_cd				:= trimUpper(input.type_filing);
			
			self.event_filing_desc				:= trimUpper(input.filingtypedesc);
			
			eventFilingDate						:= if ( trim( 	input.date_filed,left,right) <> '',
																input.date_filed[7..10] +
																input.date_filed[1..2] +
																input.date_filed[4..5],'');

		
			self.event_filing_date				:= if ( eventFilingDate <> '' and
														_validate.date.fIsValid(eventFilingDate) and
														_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),eventFilingDate,'');  
														
			self.event_date_type_cd				:= 'FIL';
			
			self.event_date_type_desc			:= 'FILING';
			
			bookPage							:= if (trimUpper(input.chapter_no) <> '5480TM',
														if (trimUpper(input.book_no) <> '',
																if(trimUpper(input.page_no)<>'',
																	'BOOK NO: ' + trimUpper(input.book_no) + '/PAGE NO: ' + trimUpper(input.page_no),
																	'BOOK NO: ' + trimUpper(input.book_no)
																  ),
																if(trimUpper(input.page_no)<>'',
																	'PAGE NO: ' + trimUpper(input.page_no),
																	''
																   )
														
															),
														 ''
													   );
													   
			expireDate							:=  if ( trim( 	input.his_date_expired,left,right) <> '',
																input.his_date_expired[7..10] +
																input.his_date_expired[1..2] +
																input.his_date_expired[4..5],'');
													   
			expired 							:= 	if ( expireDate <> '' and
														_validate.date.fIsValid(expireDate) and
														_validate.date.fIsValid(expireDate,_validate.date.rules.DateInPast),
															'EXPIRATION DATE: ' + expireDate,
															''
														);  
														
			concatEventFields					:= trim(expired,left,right) + ';' + 
												   trim(bookPage) + ';' +
												   trimUpper(input.remarks); 
																	
			eventExp							:= regexreplace('[;]*$',concatEventFields,'',NOCASE);
			eventExp2							:= regexreplace('^[;]*',eventExp,'',NOCASE);
			
			self.event_desc			 			:= regexreplace('[;]+',eventExp2,';',NOCASE);	
		
			self								:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +
																				trim(input.corp_address1_line2,left,right) + ' ' +
																				trim(input.corp_address1_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_address1_line4,left,right) + ', ' +
																				trim(input.corp_address1_line5,left,right),
																				left,right
																				)
																		   );			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right),
																				left,right
																				)
																		   );	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			      	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  			:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      		:= clean_ra_address[167..170];
			self.corp_ra_geo_blk				:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
			
			string182 reClean_address			:= if (clean_address[179..182] = 'E420',
														Address.CleanAddress182(trim(trim(input.corp_address1_line2,left,right) + ' ' + 
																					 trim(input.corp_address1_line3,left,right),
																					 left,right
																					 ),																					 
																				trim(trim(input.corp_address1_line4,left,right) + ', ' +
																					 trim(input.corp_address1_line5,left,right),
																					 left,right
																					 )
																				),
														''
													   );
														
			self.corp_addr1_prim_range    		:= if (clean_address[179..182] = 'E420',
															reClean_address[1..10],
															clean_address[1..10]
													   );
			self.corp_addr1_predir 	      		:= if (clean_address[179..182] = 'E420',
															reClean_address[11..12],
															clean_address[11..12]
													   );
			self.corp_addr1_prim_name 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[13..40],
															clean_address[13..40]
													   );
			self.corp_addr1_addr_suffix   		:= if (clean_address[179..182] = 'E420',
															reClean_address[41..44],
															clean_address[41..44]
													   );
			self.corp_addr1_postdir 	    	:= if (clean_address[179..182] = 'E420',
															reClean_address[45..46],
															clean_address[45..46]
													   );
			self.corp_addr1_unit_desig 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[47..56],
															clean_address[47..56]
													   );
			self.corp_addr1_sec_range 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[57..64],
															clean_address[57..64]
													   );
			self.corp_addr1_p_city_name	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[65..89],
															clean_address[65..89]
													   );
			self.corp_addr1_v_city_name	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[90..114], 
															clean_address[90..114]
													   );
			self.corp_addr1_state 			    := if (clean_address[179..182] = 'E420',
															reClean_address[115..116], 
															clean_address[115..116]
													   );
			self.corp_addr1_zip5 		      	:= if (clean_address[179..182] = 'E420',
															reClean_address[117..121], 
															clean_address[117..121]
													   );
			self.corp_addr1_zip4 		      	:= if (clean_address[179..182] = 'E420',
															reClean_address[122..125], 
															clean_address[122..125]
													   );
			self.corp_addr1_cart 		      	:= if (clean_address[179..182] = 'E420',
															reClean_address[126..129], 
															clean_address[126..129]
													   );
			self.corp_addr1_cr_sort_sz 	 		:= if (clean_address[179..182] = 'E420',
															reClean_address[130], 
															clean_address[130]
													   );
			self.corp_addr1_lot 		    	:= if (clean_address[179..182] = 'E420',
															reClean_address[131..134], 
															clean_address[131..134]
													   );
			self.corp_addr1_lot_order 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[135], 
															clean_address[135]
													   );
			self.corp_addr1_dpbc 		    	:= if (clean_address[179..182] = 'E420',
															reClean_address[136..137], 
															clean_address[136..137]
													   );
			self.corp_addr1_chk_digit 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[138], 
															clean_address[138]
													   );
			self.corp_addr1_rec_type			:= if (clean_address[179..182] = 'E420',
															reClean_address[139..140],
															clean_address[139..140]
													   );
			self.corp_addr1_ace_fips_st	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[141..142],
															clean_address[141..142]
													   );
			self.corp_addr1_county 	  			:= if (clean_address[179..182] = 'E420',
															reClean_address[143..145],
															clean_address[143..145]
															
													  );
			self.corp_addr1_geo_lat 	    	:= if (clean_address[179..182] = 'E420',
															reClean_address[146..155],
															clean_address[146..155]
													  );
			self.corp_addr1_geo_long 	    	:= if (clean_address[179..182] = 'E420',
															reClean_address[156..166],
															clean_address[156..166]
													  );
			self.corp_addr1_msa 		    	:= if (clean_address[179..182] = 'E420',
															reClean_address[167..170],
															clean_address[167..170]
													  );
			self.corp_addr1_geo_blk				:= if (clean_address[179..182] = 'E420',
															reClean_address[171..177],
															clean_address[171..177]
													  );
			self.corp_addr1_geo_match 	  		:= if (clean_address[179..182] = 'E420',
															reClean_address[178],
															clean_address[178]
													  );
			self.corp_addr1_err_stat 	    	:= if (clean_address[179..182] = 'E420',
															reClean_address[179..182],
															clean_address[179..182]
													  );

			self								:= input;
			self 								:= [];
		end;						
		
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 					:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +
																				trim(input.cont_address_line2,left,right),
																				left,right),
														                   trim(trim(input.cont_address_line3,left,right) + ', ' +
																				trim(input.cont_address_line4,left,right) + ' ' +
																				trim(input.cont_address_line5,left,right),
																				left,right
																				)
																		   );	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 			:= clean_address[90..114];
			self.cont_state 			      	:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     		:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	 	 			:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk					:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];

			self								:= input;
			self 								:= [];
		end;
		
		//-------------------- File Merging Logic --------------------------------------
		

	
		FilAgt MergeFilAgt(crpFilLookups l, Layouts_Raw_Input.crpAgt r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinFilAgt	:= join(PopForgnCountryDesc, Files_Raw_Input.VendorCrpAgt(fileDate),
							trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
							MergeFilAgt(left,right),
							left outer, local
							);
							
						
		FilAgtAdd MergeFilAgtAdd(FilAgt l, Layouts_Raw_Input.crpAdd r ) := transform
			self 	:= l;
			self	:= r;
		end; 
		
		joinFilAgtAdd	:= join(joinFilAgt, Files_Raw_Input.VendorCrpAdd(fileDate),
								trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
								MergeFilAgtAdd(left,right),
								left outer,local
								);
								
		
							
		FilAgtAddDes MergeFilAgtAddDes(FilAgtAdd l, Layouts_Raw_Input.crpDes r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinFilAgtAddDes := join(joinFilAgtAdd, Files_Raw_Input.VendorCrpDes(fileDate),
								 trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
								 MergeFilAgtAddDes(left,right),
								 left outer,local
								 );	
								 
								 
		FilAgtAddDesNam MergeFilAgtAddDesNam(FilAgtAddDes l, Layouts_Raw_Input.crpNam r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinFilAgtAddDesNam := join(joinFilAgtAddDes, Files_Raw_Input.VendorCrpNam(fileDate),
									trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
									MergeFilAgtAddDesNam(left,right),
									left outer,local
									);
									
								 
		AllEventFiles MergeHisRem(crpHisLookups l, Layouts_Raw_Input.crpRem r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinHisRem := join( PopFilingType, Files_Raw_Input.VendorCrpRem(fileDate),
							trim(left.cert_no,left,right) = trim(right.RemCertNo,left,right),
							MergeHisRem(left,right),
							left outer, local
						   );	
										
								 
		AllEventFiles MergeFilHisRem(Layouts_Raw_Input.crpFil l, AllEventFiles r ) := transform
			self	:= l;
			self	:= r;
		end; 
		
		joinFilHisRem := join(	Files_raw_input.VendorCrpFil(filedate), joinHisRem,
								trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
								MergeFilHisRem(left,right),
								left outer, local
							  );
						
		CorpMaster		:= project(joinFilAgtAddDesNam, corpMasterTransform(left));
		
		CorpOther		:= project(joinFilAgtAddDesNam, corpOtherTransform(left));
		
		CorpMerger		:= project(PopFilingType, corpMergerTransform(left));
		
		AllCorps		:= distribute(corpMaster + corpMerger +corpOther, hash32(corp_key));

		AllCorpsSrted 	:= sort(AllCorps,corp_key,LOCAL);
		
		crpOffLookupsNam joinOffNamFiles(crpOffLookups l, Layouts_Raw_Input.crpNam r ) := transform

			self 	:= l;
			self	:= r;
			self	:= [];
		end; 
		
		joinedOfficer2Name := dedup(join(PopOfficerType, Files_raw_input.VendorCrpNam(filedate),
									trim(left.corp_file_no,left,right) = trim(right.corp_file_no,left,right),
									joinOffNamFiles(left,right),
									left outer,local
								   ),record,local);
			
		conts 			:= project(joinedOfficer2Name, contTransform(left));
			
		cleanCorp 		:= project(AllCorpsSrted, CleanCorpAddrName(left));			  
		cleanCont 		:= project(conts, CleanContAddrName(left));
		mapStock		:= project(Files_Raw_Input.VendorCrpStk(fileDate), stockTransform(left));
		mapEvent		:= project(joinFilHisRem, EventTransform(left));
		mapAR			:= project(PopFilingType, ARTransform(left));
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ia'	,cleanCorp,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ia'	,cleanCont,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ia'	,MapStock	,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ia'	,MapEvent	,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ia'		,MapAR		,ar_out		,,,pOverwrite);
																																																																														
		mapIACorpFiling := parallel(
			 corp_out	
			,cont_out	
			,stock_out
			,event_out
			,ar_out
		);
		
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ia',filedate,pOverwrite := pOverwrite))
			,mapIACorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ia')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ia')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_ia')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ia')															  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_ia')
			)							
		);
		
		return result;
	end;					 
	
end;