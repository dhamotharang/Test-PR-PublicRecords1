import UCCV2, ut, did_add, watchdog, business_header, Business_Header_SS, VersionControl;

layUccMain  := UccV2.Layout_UCC_Common.Layout_ucc_new;
layUccParty := UccV2.Layout_UCC_Common.Layout_Party;

export UccAppend(
	 string																pversion
	,dataset(Layouts.Input.CleanPubRec	)	pSearchCriteria	= Files.Input.CleanPubRec
	,dataset(layUccMain									)	pUccMain  			= Uccv2.File_UCC_Main_Base
	,dataset(layUccParty								)	pUccParty 			= Uccv2.File_UCC_Party_Base
	,boolean															pOverwrite			= false
	,boolean															pCsvout					= true
	,string																pSeparator			= '|'	

) :=
function

	//SearchCriteria := FDS_Test.fnPublic_Record_Clean;
	//SearchCriteria := dataset(ut.foreign_prod + 'thor400_92::persist::fds::pub_rec::did_bdid_ssn_fein_jmf',CleanLayout,flat);
	//SearchCriteria := FDS_Test.Files.Input.CleanPubRec;
	//*** Input PubRec file.
	SearchCriteria := pSearchCriteria;

	//*** UCC base files
	Ucc_main_base  := distribute(pUccMain,hash(tmsid,rmsid));
	Ucc_party_base := pUccParty;

	Layout_Party_ext := record
		recordof(Ucc_party_base);
		string9 app_ssn		:= '';
		string9 app_fein	:= '';
	end;

	Ucc_party_base_ssn := project(Ucc_party_base, transform(Layout_Party_ext, self := left));

	//*** append ssn's to UCC party records 
	did_add.MAC_Add_SSN_By_DID(Ucc_party_base_ssn, did, app_ssn, Ucc_party_SSN_out)

	//*** append fein's to UCC party records 
	Business_Header_SS.MAC_Add_FEIN_By_BDID(Ucc_party_SSN_out, bdid, app_fein, Ucc_party_fein_out)

	Ucc_party_base_ext := distribute(Ucc_party_fein_out,hash(tmsid,rmsid));

	Ucc_main_base_ded  := dedup(sort(Ucc_main_base, tmsid, rmsid, orig_filing_date, filing_date,local),tmsid,rmsid,local);

	Ucc_Party_base_ded := dedup(sort(Ucc_party_base_ext, tmsid, rmsid, fname, mname, lname, company_name, prim_range, prim_name, p_city_name, st, zip5, party_type, process_date,local),
															tmsid, rmsid, fname, mname, lname, company_name, prim_range, prim_name, p_city_name, st, zip5, party_type,local);


	slim_main_layout := record
		UCCV2.Layout_UCC_Common.Layout_ucc.tmsid;
		UCCV2.Layout_UCC_Common.Layout_ucc.rmsid;
		UCCV2.Layout_UCC_Common.Layout_ucc.process_date;
		UCCV2.Layout_UCC_Common.Layout_ucc.Filing_Jurisdiction;
		UCCV2.Layout_UCC_Common.Layout_ucc.orig_filing_number;
		UCCV2.Layout_UCC_Common.Layout_ucc.orig_filing_type;
		UCCV2.Layout_UCC_Common.Layout_ucc.orig_filing_date;
		UCCV2.Layout_UCC_Common.Layout_ucc.filing_number;
		UCCV2.Layout_UCC_Common.Layout_ucc.filing_type;
		UCCV2.Layout_UCC_Common.Layout_ucc.filing_date;
		UCCV2.Layout_UCC_Common.Layout_ucc.filing_status;
		UCCV2.Layout_UCC_Common.Layout_ucc.Status_type;
		UCCV2.Layout_UCC_Common.Layout_ucc.State;
		UCCV2.Layout_UCC_Common.Layout_ucc.expiration_date;
		UCCV2.Layout_UCC_Common.Layout_ucc.collateral_desc;	
	end;

	slim_party_layout := record
		UCCV2.Layout_UCC_Common.Layout_Party.tmsid;
		UCCV2.Layout_UCC_Common.Layout_Party.rmsid;
		UCCV2.Layout_UCC_Common.Layout_Party.process_date;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_name;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_lname;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_fname;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_mname;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_suffix;
		UCCV2.Layout_UCC_Common.Layout_Party.duns_number;
		UCCV2.Layout_UCC_Common.Layout_Party.hq_duns_number;
		UCCV2.Layout_UCC_Common.Layout_Party.ssn;
		UCCV2.Layout_UCC_Common.Layout_Party.fein;
		UCCV2.Layout_UCC_Common.Layout_Party.Incorp_state;
		UCCV2.Layout_UCC_Common.Layout_Party.corp_number;
		UCCV2.Layout_UCC_Common.Layout_Party.corp_type;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_address1;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_address2;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_city;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_state;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_zip5;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_zip4;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_country;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_province;
		UCCV2.Layout_UCC_Common.Layout_Party.Orig_postal_code;
		UCCV2.Layout_UCC_Common.Layout_Party.foreign_indc;
		UCCV2.Layout_UCC_Common.Layout_Party.Party_type;
		UCCV2.Layout_UCC_Common.Layout_Party.title;
		UCCV2.Layout_UCC_Common.Layout_Party.fname;
		UCCV2.Layout_UCC_Common.Layout_Party.mname;
		UCCV2.Layout_UCC_Common.Layout_Party.lname;
		UCCV2.Layout_UCC_Common.Layout_Party.name_suffix;
		UCCV2.Layout_UCC_Common.Layout_Party.name_score;			
		UCCV2.Layout_UCC_Common.Layout_Party.company_name;
		UCCV2.Layout_UCC_Common.Layout_Party.prim_range;
		UCCV2.Layout_UCC_Common.Layout_Party.predir;
		UCCV2.Layout_UCC_Common.Layout_Party.prim_name;
		UCCV2.Layout_UCC_Common.Layout_Party.suffix;
		UCCV2.Layout_UCC_Common.Layout_Party.postdir;
		UCCV2.Layout_UCC_Common.Layout_Party.unit_desig;
		UCCV2.Layout_UCC_Common.Layout_Party.sec_range;
		UCCV2.Layout_UCC_Common.Layout_Party.p_city_name;
		UCCV2.Layout_UCC_Common.Layout_Party.v_city_name;
		UCCV2.Layout_UCC_Common.Layout_Party.st;
		UCCV2.Layout_UCC_Common.Layout_Party.zip5;
		UCCV2.Layout_UCC_Common.Layout_Party.did;
		UCCV2.Layout_UCC_Common.Layout_Party.bdid;
		string9 app_ssn		:= '';
		string9 app_fein	:= '';
	end;

	slim_ucc_layout := record
			slim_main_layout;
			slim_party_layout and not [tmsid, rmsid, process_date];
	end;


	slim_ucc_layout joinMainAndPartyRecs(Ucc_main_base_ded l, Ucc_Party_base_ded r) := transform
			self := l;
			self := r;
	end;

	ucc_recs := join(Ucc_main_base_ded, Ucc_Party_base_ded,
									 left.tmsid = right.tmsid and
									 left.rmsid = right.rmsid,
									 joinMainAndPartyRecs(left,right),local);

	//** getting the bank name & addresses
	Layout_UCC := record
		slim_ucc_layout;
		string120 c_orig_name;
		string25  c_orig_lname;
		string25  c_orig_fname;
		string35  c_orig_mname;
		string10  c_orig_suffix;
		string60  c_Orig_address1;
		string60  c_Orig_address2;
		string30  c_Orig_city;
		string2   c_Orig_state;
		string5   c_Orig_zip5;
		string4   c_Orig_zip4;
		string30  c_Orig_country;
		string30  c_Orig_province;
		string9   c_Orig_postal_code;
		string5   c_title;
		string20  c_fname;
		string20  c_mname;
		string20  c_lname;
		string5   c_name_suffix;
		string3   c_name_score;			
		string60  c_company_name;
		string10  c_prim_range;
		string2   c_predir;
		string28  c_prim_name;
		string4   c_suffix;
		string2   c_postdir;
		string10  c_unit_desig;
		string8   c_sec_range;
		string25  c_p_city_name;
		string25  c_v_city_name;
		string2   c_st;
		string5   c_zip5;
	end;

	d_ucc_recs := distribute(ucc_recs(party_type = 'D'),hash(tmsid,rmsid));
	c_ucc_recs := distribute(ucc_recs(party_type in ['C','S','A']),hash(tmsid,rmsid));

	layout_UCC JoinDebtorCreditor(d_ucc_recs l, c_ucc_recs r):= transform
		self.c_orig_name        := r.orig_name;
		self.c_orig_lname       := r.orig_lname;
		self.c_orig_fname       := r.orig_fname;
		self.c_orig_mname       := r.orig_mname;
		self.c_orig_suffix      := r.orig_suffix;
		self.c_Orig_address1    := r.Orig_address1;
		self.c_Orig_address2    := r.Orig_address2;
		self.c_Orig_city        := r.Orig_city;
		self.c_Orig_state       := r.Orig_state;
		self.c_Orig_zip5        := r.Orig_zip5;
		self.c_Orig_zip4        := r.Orig_zip4;
		self.c_Orig_country     := r.Orig_country;
		self.c_Orig_province    := r.Orig_province;
		self.c_Orig_postal_code := r.Orig_postal_code;
		self.c_title            := r.title;
		self.c_fname            := r.fname;
		self.c_mname            := r.mname;
		self.c_lname            := r.lname;
		self.c_name_suffix      := r.name_suffix;
		self.c_name_score       := r.name_score;			
		self.c_company_name     := r.company_name;
		self.c_prim_range       := r.prim_range;
		self.c_predir           := r.predir;
		self.c_prim_name        := r.prim_name;
		self.c_suffix           := r.suffix;
		self.c_postdir          := r.postdir;
		self.c_unit_desig       := r.unit_desig;
		self.c_sec_range        := r.sec_range;
		self.c_p_city_name      := r.p_city_name;
		self.c_v_city_name      := r.v_city_name;
		self.c_st               := r.st;
		self.c_zip5             := r.zip5;
		self                    := l;
	end;

	Ucc_Recs_for_Append := join(d_ucc_recs, c_ucc_recs, 
															left.tmsid = right.tmsid and
															left.rmsid = right.rmsid,
															JoinDebtorCreditor(left,right),local) : persist('~thor_data400::persist::FDS_Test::UCCAppend::UCC_recs');

	//***************************************************************************************
	//*** Searches 
	//***************************************************************************************
	//*** FDS matched layout
	layout_FDS_matched := record
		string 		rec_id 	:= '';
		unsigned2 d_count := 0;
		unsigned2 c_count := 0;
		unsigned2 f_count := 0;
		Layout_UCC;
	end;

	//**************************************************************************************
	//*** SSN Search
	SearchCriteria_SSN := SearchCriteria((integer)SSN <> 0 and
																			 trim(name) = '' and
																			 trim(address) = '' and
																			 trim(city) = '' and 
																			 trim(state) = ''
																			);
																			
	UCC_SSN_recs := Ucc_Recs_for_Append(trim(ssn) <> '');

	layout_FDS_matched getSSNMatchedUccs(UCC_SSN_recs l, SearchCriteria_SSN r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	ucc_ssn_matched_recs := join(UCC_SSN_recs, SearchCriteria_SSN, 
															 trim(left.ssn) = trim(right.ssn,left,right), 
															 getSSNMatchedUccs(left,right),
															 lookup);
															 
	//** Matched on the appended ssn's
	UCC_app_SSN_recs := Ucc_Recs_for_Append(trim(ssn) = '', trim(app_ssn) <> '');

	layout_FDS_matched getSSNMatchedUccs2(UCC_app_SSN_recs l, SearchCriteria_SSN r) := transform
		self.rec_Id := r.Record_ID;
		self 				:= l;
	end;

	ucc_app_ssn_matched_recs := join(UCC_app_SSN_recs, SearchCriteria_SSN, 
																	trim(left.app_ssn) = trim(right.ssn,left,right), 
																	getSSNMatchedUccs2(left,right),
																	lookup);


	//ucc_ssn_matches := dedup(sort(ucc_ssn_matched_recs + ucc_app_ssn_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_ssn_matches := sort(ucc_ssn_matched_recs + ucc_app_ssn_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** SSN & name Search
	SearchCriteria_SSNName := SearchCriteria(trim(SSN,left,right) <> '' and
																					 trim(name,left,right) <> '' and
																					 trim(address,left,right) = '' and
																					 trim(city,left,right) = '' and 
																					 trim(state,left,right) = ''
																					);
																			
	layout_FDS_matched getSSNNameMatchedUccs(UCC_SSN_recs l, SearchCriteria_SSNName r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	ucc_ssn_name_matched_recs := join(UCC_SSN_recs, SearchCriteria_SSNName, 
																		trim(left.ssn)   = trim(right.ssn,left,right) and
																		trim(left.fname) = trim(right.fname,left,right) and
																		trim(left.lname) = trim(right.lname,left,right) and
																		trim(left.mname) = trim(right.mname,left,right),
																		getSSNNameMatchedUccs(left,right),
																		lookup);

	//ucc_ssn_name_matches := dedup(sort(ucc_ssn_name_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_ssn_name_matches := sort(ucc_ssn_name_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Tax_Id Search
	SearchCriteria_TaxID := SearchCriteria(trim(Tax_ID_Number,left,right) <> '');

	UCC_FEIN_recs := Ucc_Recs_for_Append(trim(fein) <> '');

	layout_FDS_matched getTaxIDMatchedUccs(UCC_FEIN_recs l, SearchCriteria_TaxID r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	ucc_TaxID_matched_recs := join(UCC_FEIN_recs, SearchCriteria_TaxID,
																 trim(left.fein) = trim(right.tax_id_number,left,right),
																 getTaxIDMatchedUccs(left,right),
																 lookup);

	//** matching on appended fein's
	UCC_App_FEIN_recs := Ucc_Recs_for_Append(trim(fein) = '', trim(app_fein) <> '');

	layout_FDS_matched getTaxIDMatchedUccs2(UCC_FEIN_recs l, SearchCriteria_TaxID r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	ucc_AppTaxID_matched_recs := join(UCC_FEIN_recs, SearchCriteria_TaxID,
																 trim(left.app_fein) = trim(right.tax_id_number,left,right),
																 getTaxIDMatchedUccs2(left,right),
																 lookup);

	//ucc_TaxID_matches := dedup(sort(ucc_TaxID_matched_recs + ucc_AppTaxID_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_TaxID_matches := sort(ucc_TaxID_matched_recs + ucc_AppTaxID_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Case_number or document number Search
	SearchCriteria_CaseNum := SearchCriteria(trim(Case_Number,left,right) <> '');

	layout_FDS_cnum := record
		 string1 match_score := '';
		 layout_FDS_matched;
	end;

	layout_FDS_cnum getCaseNumMatchedUccs1(Ucc_Recs_for_Append l, SearchCriteria_CaseNum r) := transform
			self.match_score	:= '1';
			self.rec_id				:= r.Record_Id;
			self							:= l;
	end;

	ucc_origCaseNum_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_CaseNum,
																			 trim(left.orig_filing_number)  = trim(right.case_number,left,right) and
																			 trim(left.Filing_Jurisdiction) = trim(right.case_state,left,right),
																			 getCaseNumMatchedUccs1(left,right),
																			 lookup);

	layout_FDS_cnum getCaseNumMatchedUccs2(Ucc_Recs_for_Append l, SearchCriteria_CaseNum r) := transform
			self.match_score	:= '2';
			self.rec_id				:= r.Record_Id;
			self							:= l;
	end;

	ucc_CaseNum_matched_recs := join(Ucc_Recs_for_Append(trim(filing_number) <> ''), SearchCriteria_CaseNum,
																	trim(left.filing_number) 			= trim(right.case_number,left,right) and
																	trim(left.Filing_Jurisdiction) = trim(right.case_state,left,right),
																	getCaseNumMatchedUccs2(left,right),
																	lookup);

	/*
	ucc_CaseNum_matches := project(dedup(sort(ucc_origCaseNum_matched_recs + ucc_CaseNum_matched_recs, rec_id, tmsid, -process_date, match_score),
																 rec_id, tmsid,keep(5))
																 ,transform(layout_FDS_matched, self := left)
																);
	*/
	ucc_CaseNum_matches := project(sort(ucc_origCaseNum_matched_recs + ucc_CaseNum_matched_recs, rec_id, tmsid, orig_filing_date, filing_date, match_score)
																 ,transform(layout_FDS_matched, self := left)
																);

	//**************************************************************************************

	//**************************************************************************************
	//*** Name and address Search
	//*** 1st using the DIDed records.
	SearchCriteria_did      := SearchCriteria(did <> 0 and name <> '');
	SearchCriteria_nameAddr := SearchCriteria(trim(Name,left,right) <> '' and 
																						trim(Address,left,right) <> '' and 
																						//trim(Secondary_Address) <> '' and
																						trim(City,left,right) <> '' and
																						trim(state,left,right) <> '' //and
																						//trim(zip_code,left,right) <> ''
																					 );

	layout_FDS_matched getDIDMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_did r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_did_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_did,
															 left.did = right.did,
															 getDIDMatchedUccs(left,right),
															 lookup);

	//*** 2nd seach on records that didn't get the DID's
	layout_FDS_matched getNameAddrMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_nameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_NameAddr_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_nameAddr,
																		trim(left.fname) = trim(right.fname) and
																		trim(left.lname) = trim(right.lname) and
																		trim(left.mname) = trim(right.mname) and
																		trim(left.prim_name)   = trim(right.prim_name) and
																		//left.predir      = right.predir and
																		//left.addr_suffix = right.addr_suffix and
																		trim(left.prim_range)  = trim(right.prim_range) and
																		//left.sec_range   = right.sec_range and
																		trim(left.p_city_name) = trim(right.p_city_name) and
																		trim(left.st)          = trim(right.st) and
																		trim(left.zip5)        = trim(right.zip),
																		getNameAddrMatchedUccs(left,right),
																		lookup);

	//ucc_NameAddr_matches := dedup(sort(ucc_did_matched_recs + ucc_NameAddr_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_NameAddr_matches := sort(ucc_did_matched_recs + ucc_NameAddr_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Name and state Search
	SearchCriteria_NameSt := SearchCriteria(trim(Name,left,right) <> '' and 
																					trim(state,left,right) <> '' and 
																					trim(City,left,right) = '' and
																					trim(zip_Code,left,right) = ''
																				 );

	layout_FDS_matched getNameStMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_NameSt r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_NameSt_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_NameSt,
																	trim(left.fname) = trim(right.fname) and
																	trim(left.lname) = trim(right.lname) and
																	trim(left.mname) = trim(right.mname) and
																	trim(left.state) = trim(right.state),														 
																	getNameStMatchedUccs(left,right),
																	lookup);

	//ucc_NameSt_matches := dedup(sort(ucc_NameSt_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_NameSt_matches := sort(ucc_NameSt_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Company name and address Search
	//*** 1st using the BDIDed records.
	SearchCriteria_bdid      := SearchCriteria(bdid <> 0);
	SearchCriteria_bnameAddr := SearchCriteria(trim(Business_Name,left,right) <> '' and 
																						 trim(Address,left,right) <> '' and 
																						 //trim(Secondary_Address) <> '' and
																						 trim(City,left,right) <> '' and
																						 trim(state,left,right) <> ''// and
																						 //trim(zip_code,left,right) <> ''
																						);

	layout_FDS_matched getBDIDMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_bdid r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_bdid_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_bdid,
															 left.bdid = right.bdid,
															 getBDIDMatchedUccs(left,right),
															 lookup);

	//*** 2nd seach on records that didn't get the BDID's
	layout_FDS_matched getBNameAddrMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_bnameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_BNameAddr_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_bnameAddr,
																		 ut.CleanCompany(left.c_company_name) = ut.CleanCompany(trim(right.business_name,left,right)) and
																		 trim(left.prim_name)   = trim(right.prim_name) and
																		 //left.predir      = right.predir and
																		 //left.addr_suffix = right.addr_suffix and
																		 trim(left.prim_range)  = trim(right.prim_range) and
																		 //left.sec_range   = right.sec_range and
																		 trim(left.p_city_name) = trim(right.p_city_name) and
																		 trim(left.st)          = trim(right.st) and
																		 trim(left.zip5)        = trim(right.zip),
																		 getBNameAddrMatchedUccs(left,right),
																		 lookup);

	//ucc_CNameAddr_matches := dedup(sort(ucc_bdid_matched_recs + ucc_BNameAddr_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_CNameAddr_matches := sort(ucc_bdid_matched_recs + ucc_BNameAddr_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Business Name and state Search
	SearchCriteria_BNameSt := SearchCriteria(trim(Business_Name,left,right) <> '' and 
																					 trim(state,left,right) <> '' and 
																					 trim(City,left,right) = '' //and
																					 //trim(zip_Code,left,right) = ''
																					);

	layout_FDS_matched getBNameStMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_BNameSt r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_BNameSt_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_BNameSt,
																	ut.CleanCompany(left.c_company_name) = ut.CleanCompany(trim(right.business_name,left,right)) and
																	trim(left.state) 					= trim(right.state),
																	getBNameStMatchedUccs(left,right),
																	lookup);

	//ucc_BNameSt_matches := dedup(sort(ucc_BNameSt_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_BNameSt_matches := sort(ucc_BNameSt_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Partial SSN, name/address Search
	SearchCriteria_NamePSSN := SearchCriteria(trim(Name,left,right) <> '' and 
																						trim(ssn,left,right) <> '' and 
																						trim(Address,left,right) = '' and
																						trim(City,left,right) = '' and
																						trim(state,left,right) = '' //and
																						//trim(zip_code,left,right) = ''
																					 );

	layout_FDS_matched getNamePSSNMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_NamePSSN r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_NamePSSN_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_NamePSSN,
																		left.fname = right.fname and
																		left.lname = right.lname and
																		left.mname = right.mname and
																		left.ssn[1..5] = trim(right.ssn,left,right),
																		getNamePSSNMatchedUccs(left,right),
																		lookup);

	ucc_NamePSSN_matches := dedup(sort(ucc_NamePSSN_matched_recs, rec_id, tmsid, orig_filing_date, filing_date),rec_id, tmsid, keep(5));

	//*** 2nd seach on partial ssn and address
	SearchCriteria_PSSNAddr := SearchCriteria(trim(ssn,left,right) <> '' and 
																						trim(Address,left,right) <> '' and
																						trim(City,left,right) <> '' and
																						trim(state,left,right) <> '' and
																						//trim(zip_code,left,right) <> '' and
																						trim(Name,left,right) = ''
																					 );
	layout_FDS_matched getPSSNAddrMatchedUccs(Ucc_Recs_for_Append l, SearchCriteria_PSSNAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	ucc_PSSNAddr_matched_recs := join(Ucc_Recs_for_Append, SearchCriteria_PSSNAddr,
																		left.ssn[1..5] = trim(right.ssn,left,right) and
																		left.prim_name   = right.prim_name and
																		 //left.predir      = right.predir and
																		 //left.addr_suffix = right.addr_suffix and
																		 left.prim_range  = right.prim_range and
																		 //left.sec_range   = right.sec_range and
																		 left.p_city_name = right.p_city_name and
																		 left.st          = right.st and
																		 left.zip5        = right.zip,
																		 getPSSNAddrMatchedUccs(left,right),
																		 lookup);

	//ucc_PSSNAddr_matches := dedup(sort(ucc_PSSNAddr_matched_recs, rec_id, tmsid, -process_date),rec_id, tmsid, keep(5));
	ucc_PSSNAddr_matches := sort(ucc_PSSNAddr_matched_recs, rec_id, tmsid, orig_filing_date, filing_date);
	//**************************************************************************************

	All_Ucc_matches := 	ucc_ssn_matches +
											ucc_ssn_name_matches +
											ucc_TaxID_matches +
											ucc_CaseNum_matches +
											ucc_NameAddr_matches +
											ucc_NameSt_matches +
											ucc_CNameAddr_matches +
											ucc_BNameSt_matches //+
											//ucc_NamePSSN_matches +
											//ucc_PSSNAddr_matches  
											: persist('~thor_data400::persist::FDS_Test::UCCAppend::UCC_All_matches');

	//***************************************************************************************
	//*** Adding stats to the output file.
	//***************************************************************************************
	//Get the creditor and debtor counts 
	tempLayout1 := record
		ucc_recs.tmsid;
		ucc_recs.rmsid;
		integer d_count := sum(group,if(ucc_recs.party_type='D',1,0));
		integer c_count := sum(group,if(ucc_recs.party_type in ['C','S','A'],1,0));
	end;

	t1 := table(ucc_recs,tempLayout1,tmsid,rmsid) 
							: persist('~thor_data400::persist::fds_test::UCCAppend::dc_counts');                         
	
	//Get the filing counts 
	tempLayout2 := record
		Ucc_Recs_for_Append.tmsid;
		integer f_count := count(group);
	end;

	t2 := table(dedup(sort(Ucc_Recs_for_Append,tmsid,rmsid),tmsid,rmsid),tempLayout2,tmsid)
							: persist('~thor_data400::persist::fds_test::UccAppend::filing_counts');

	
	// ********************* Below - add counts to structure
	dis_all_ucc_matches := distribute(All_Ucc_matches, hash(tmsid, rmsid));
	dis_t1 := distribute(t1, hash(tmsid, rmsid));
	dis_t2 := distribute(t2, hash(tmsid));

	recordof(All_Ucc_matches) add_dc_counts(dis_all_ucc_matches l,  dis_t1 r) := transform
		 self.d_count  := r.d_count;
		 self.c_count  := r.c_count;
		 self 				 := l;
	end;

	Ucc_matches_with_dc_stats := join(dis_all_ucc_matches, dis_t1, 
																	left.tmsid = right.tmsid and
																	left.rmsid = right.rmsid,
																	add_dc_counts(left,right), left outer, local)
																	: persist('~thor_data400::persist::fds_test::UccAppend::added_dc_counts');

	dis_Ucc_matches_with_dc_stats := distribute(Ucc_matches_with_dc_stats, hash(tmsid));

	recordof(All_Ucc_matches) add_f_counts(dis_Ucc_matches_with_dc_stats l, dis_t2 r) := transform
		 self.f_count := r.f_count;
		 self 				:= l;
	end;

	UCC_Append_Recs_With_Stats := join(dis_Ucc_matches_with_dc_stats, dis_t2, 
																		left.tmsid = right.tmsid,                                                                        
																		add_f_counts(left,right), left outer, local) : persist('~thor_data400::persist::fds_test::UccAppend::added_f_counts');                                                                

	Ucc_Append_best_matches := dedup(sort(UCC_Append_Recs_With_Stats, rec_id, orig_filing_date, filing_date),rec_id,keep(5));
	// ********************* Above - add counts to structure										
	//***************************************************************************************
	//*** Mapping to FDS dictonary
	//***************************************************************************************
	inputSearchfile := FDS_Test.Files.input.PubRec;

	Layout_FDS_Append_temp := Layouts.UCC.FDS_Append_temp_layout;
	Layout_FDS_Append_out  := Layouts.UCC.FDS_Append_Layout;

	Layout_FDS_Append_temp mapUCCtoFDS(inputSearchfile l, Ucc_Append_best_matches r) := transform
			self.rec_id 								:= trim(r.rec_id);
			self.d_fName 								:= trim(r.fname);
			self.d_mName 								:= trim(r.mname);
			self.d_lName 								:= trim(r.lname);
			self.d_companyName 					:= trim(r.company_name);
			self.d_street1 							:= trim(r.Orig_address1);
			self.d_street2 							:= trim(r.Orig_address2);
			self.d_city 								:= trim(r.Orig_city);
			self.d_state 								:= trim(r.Orig_State);
			self.d_zip 									:= trim(r.Orig_Zip5);
			self.c_fName 								:= trim(r.c_fname);
			self.c_mName 								:= trim(r.c_mname);
			self.c_lName 								:= trim(r.c_lname);
			self.c_companyName 					:= trim(r.c_company_name);
			self.c_street1 							:= trim(r.c_Orig_address1);
			self.c_street2 							:= trim(r.c_Orig_address2);
			self.c_city 								:= trim(r.c_Orig_city);
			self.c_state 								:= trim(r.c_Orig_state);
			self.c_zip 									:= trim(r.c_Orig_zip5);
			self.filing_date 						:= if(length(trim(r.filing_date)) = 8, r.filing_date[5..8] + r.filing_date[1..4],'');
			self.filing_type 						:= trim(r.filing_type);
			self.filing_state						:= trim(r.Filing_Jurisdiction);
			self.filing_count 					:= if(r.f_count > 0, (string)r.f_count,'');
			self.filing_number 					:= trim(r.filing_number);
			self.original_filing_number := trim(r.orig_filing_number);
			self.original_filing_date 	:= if(length(trim(r.orig_filing_date)) = 8, r.orig_filing_date[5..8] + r.orig_filing_date[1..4],'');
			self.document_count 				:= '';
			self.debtor_count 					:= if(r.d_count > 0, (string)r.d_count,'');
			self.secured_count 					:= if(r.c_count > 0, (string)r.c_count,'');
			self.collateral_desc 				:= trim(r.collateral_desc,left,right);
			//self.Status 								:= trim(r.Status_type);
			self.Expiration_Date 				:= if(length(trim(r.expiration_date)) = 8, r.expiration_date[5..8] + r.expiration_date[1..4],'');
			self.orig_filing_type 			:= trim(r.orig_filing_type);
			self 												:= l;
	end;

	Mapped_FDS_UCC_Append	:= join(inputSearchfile, Ucc_Append_best_matches,
															left.record_id = right.rec_id,
															mapUCCtoFDS(left,right),
															left outer
														 ): persist('~thor_data400::persist::fds_test::UccAppend::Mapped_FDS_UCC_Append');

	//FDS_UCC_Append_Out := sort(Mapped_FDS_UCC_Append,(integer)record_id);//ucc_ssn_matched_recs + ucc_ssn_name_matched_recs;
	
	FDS_UCC_Append_Out := sort(project(Mapped_FDS_UCC_Append,transform(Layout_FDS_Append_out, self := left)),(integer)record_id);
	
	//VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Ucc_Append.new	,FDS_UCC_Append_Out_srt	,BuildUccAppendFile,,pCsvout,pOverwrite,pSeparator);
	
	//********************************************************************************************
	//*** Matched field fill stats 
	//********************************************************************************************	
	layout_stat := 
	record
    integer countGroup := count(group);
		//Record_ID_CountNonBlank     					:= sum(group,if(Mapped_FDS_UCC_Append.Rec_ID	<> '',100,0));
		d_fName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.d_fname	<> '',100,0));
		d_mName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.d_mname	<> '',100,0));
		d_lName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.d_lname	<> '',100,0));
		d_companyName_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.d_companyName	<> '',100,0));
		d_street1_CountNonBlank								:= ave(group,if(Mapped_FDS_UCC_Append.d_street1	<> '',100,0));
		d_street2_CountNonBlank								:= ave(group,if(Mapped_FDS_UCC_Append.d_street2	<> '',100,0));
		d_city_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.d_city	<> '',100,0));
		d_state_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.d_state	<> '',100,0));
		d_zip_CountNonBlank										:= ave(group,if(Mapped_FDS_UCC_Append.d_zip	<> '',100,0));
		c_fName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.c_fName	<> '',100,0));
		c_mName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.c_mName	<> '',100,0));
		c_lName_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.c_lName	<> '',100,0));
		c_companyName_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.c_companyName	<> '',100,0));
		c_street1_CountNonBlank								:= ave(group,if(Mapped_FDS_UCC_Append.c_street1	<> '',100,0));
		c_street2_CountNonBlank								:= ave(group,if(Mapped_FDS_UCC_Append.c_street2	<> '',100,0));
		c_city_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.c_city	<> '',100,0));
		c_state_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.c_state	<> '',100,0));
		c_zip_CountNonBlank										:= ave(group,if(Mapped_FDS_UCC_Append.c_zip	<> '',100,0));
		filing_date_CountNonBlank							:= ave(group,if(Mapped_FDS_UCC_Append.filing_date	<> '',100,0));
		filing_type_CountNonBlank							:= ave(group,if(Mapped_FDS_UCC_Append.filing_type	<> '',100,0));
		filing_state_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.filing_state	<> '',100,0));
		filing_count_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.filing_count	<> '',100,0));
		filing_number_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.filing_number	<> '',100,0));
		original_filing_number_CountNonBlank	:= ave(group,if(Mapped_FDS_UCC_Append.original_filing_number	<> '',100,0));
		original_filing_date_CountNonBlank		:= ave(group,if(Mapped_FDS_UCC_Append.original_filing_date	<> '',100,0));
		document_count_CountNonBlank					:= ave(group,if(Mapped_FDS_UCC_Append.document_count	<> '',100,0));
		debtor_count_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.debtor_count	<> '',100,0));
		secured_count_CountNonBlank						:= ave(group,if(Mapped_FDS_UCC_Append.secured_count	<> '',100,0));
		collateral_desc_CountNonBlank					:= ave(group,if(Mapped_FDS_UCC_Append.collateral_desc	<> '',100,0));
		//Status_CountNonBlank									:= ave(group,if(Mapped_FDS_UCC_Append.Status	<> '',100,0));
		Expiration_Date_CountNonBlank					:= ave(group,if(Mapped_FDS_UCC_Append.Expiration_Date	<> '',100,0));
		Orig_filing_type_CountNonBlank				:= ave(group,if(Mapped_FDS_UCC_Append.Orig_filing_type	<> '',100,0));	                                                                       
	end;
	
	dUccMatches_fill_stats := table(Mapped_FDS_UCC_Append(trim(rec_id) <> ''), layout_stat, few);
	
	//********************************************************************************************
	//*** -- Match rate stats by search criteria
	//********************************************************************************************
	//*** SSN Only match
	ded_FDS_UCC_Append 							:= dedup(Mapped_FDS_UCC_Append,record_id,all);
	
	countSearchCriteriaWithSSNOnly	:= count(SearchCriteria_SSN);
	countSSNOnly_nomatch						:= count(ded_FDS_UCC_Append((integer)ssn <> 0 and rec_id = ''));
	
	SSNOnlyMatchrate := if((countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) / (real8)countSearchCriteriaWithSSNOnly * 100.0,0);
	
	//*** SSN Only match
	countSearchCriteriaWithSSNName 	:= count(SearchCriteria_SSNName);
	countSSNName_nomatch						:= count(ded_FDS_UCC_Append(ssn <> '' and Name <> '' and rec_id = ''));

	SSNNameMatchrate := if((countSearchCriteriaWithSSNName - countSSNName_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNName - countSSNName_nomatch) / (real8)countSearchCriteriaWithSSNName * 100.0,0);
	
	//*** Name and Address match 
	countSearchCriteriaWithNameAddr	:= count(SearchCriteria_nameAddr);
	countNameAddr_nomatch						:= count(ded_FDS_UCC_Append(trim(name) <> '' and
																															trim(address) <> '' and
																															trim(city) <> '' and
																															trim(state) <> '' and
																															rec_id = ''));

	NameAddrMatchrate := if((countSearchCriteriaWithNameAddr - countNameAddr_nomatch) <> 0, 
													(real8)(countSearchCriteriaWithNameAddr - countNameAddr_nomatch) / (real8)countSearchCriteriaWithNameAddr * 100.0,0);

	//*** Name and state match 
	countSearchCriteriaWithNameSt	:= count(SearchCriteria_NameSt);
	countNameSt_nomatch						:= count(ded_FDS_UCC_Append(trim(name) <> '' and
																														trim(state) <> '' and
																														trim(address) = '' and
																														trim(city) = '' and
																														rec_id = ''));

	NameStMatchrate := if((countSearchCriteriaWithNameSt - countNameSt_nomatch) <> 0, 
												(real8)(countSearchCriteriaWithNameSt - countNameSt_nomatch) / (real8)countSearchCriteriaWithNameSt * 100.0,0);

	
	//*** Business Name and Address match 
	countSearchCriteriaWithBNameAddr	:= count(SearchCriteria_bnameAddr);
	countBNameAddr_nomatch						:= count(ded_FDS_UCC_Append(trim(Business_name) <> '' and
																																trim(address) <> '' and
																																trim(city) <> '' and
																																trim(state) <> '' and
																																rec_id = ''));

	BNameAddrMatchrate := if((countSearchCriteriaWithBNameAddr - countBNameAddr_nomatch) <> 0, 
													 (real8)(countSearchCriteriaWithBNameAddr - countBNameAddr_nomatch) / (real8)countSearchCriteriaWithBNameAddr * 100.0,0);


	//*** Business Name and state match 
	countSearchCriteriaWithBNameSt	:= count(SearchCriteria_BNameSt);
	countBNameSt_nomatch						:= count(ded_FDS_UCC_Append(trim(Business_Name,left,right) <> '' and 
																															trim(state,left,right) <> '' and 
																															trim(address,left,right) = '' and
																															trim(City,left,right) = '' and
																															rec_id = ''));

	BNameStMatchrate := if((countSearchCriteriaWithBNameSt - countBNameSt_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithBNameSt - countBNameSt_nomatch) / (real8)countSearchCriteriaWithBNameSt * 100.0,0);

	
	//*** Tax Id match 
	countSearchCriteriaWithTaxId	:= count(SearchCriteria_TaxID	);
	countTaxId_nomatch						:= count(ded_FDS_UCC_Append(trim(Tax_ID_Number) <> '' and rec_id = ''));
	
	TaxIdMatchrate := if((countSearchCriteriaWithTaxId - countTaxId_nomatch) <> 0,
											 (real8)(countSearchCriteriaWithTaxId - countTaxId_nomatch) / (real8)countSearchCriteriaWithTaxId * 100.0,0);

	
	//*** Case number match 
	countSearchCriteriaWithCaseNum	:= count(SearchCriteria_CaseNum	);
	countCaseNum_nomatch						:= count(ded_FDS_UCC_Append(trim(case_number) <> '' and 
																															//trim(case_state) <> '' and
																															rec_id = ''));
	
	CaseNumMatchrate := if((countSearchCriteriaWithCaseNum - countCaseNum_nomatch) <> 0,
												 (real8)(countSearchCriteriaWithCaseNum - countCaseNum_nomatch) / (real8)countSearchCriteriaWithCaseNum * 100.0,0);

	
	return 	sequential(
		 output('FDS UCC Append Results Follow'		,named('_'														))
		,output(FDS_UCC_Append_Out,,'~thor_data400::out::FDS_Test::UCC::Append',csv(separator(pSeparator)),overwrite)
		,output(dUccMatches_fill_stats						,named('Appended_fields_fill_Rates'		))
		//*** SSN only match stats
		,output(countSearchCriteriaWithSSNOnly		,named('FDS_Search_File_With_SSN_Only'	))
		,output(countSSNOnly_nomatch							,named('SSNOnly_Not_Match'	))		
		,output(SSNOnlyMatchrate									,named('SSN_Only_Match_rate'		))
		//*** SSN, name match stats
		,output(countSearchCriteriaWithSSNName		,named('FDS_Search_File_With_SSN_Name'	))
		,output(countSSNName_nomatch							,named('SSN_Name_Not_Match'	))		
		,output(SSNNameMatchrate									,named('SSN_Name_Match_rate'		))
		//*** Name & Address match stats
		,output(countSearchCriteriaWithNameAddr		,named('FDS_Search_File_With_Name_Addr'	))
		,output(countNameAddr_nomatch							,named('Name_Addr_Not_Match'	))				
		,output(NameAddrMatchrate									,named('Name_Addr_Match_rate'		))
		//*** Name & state match stats
		,output(countSearchCriteriaWithNameSt			,named('FDS_Search_File_With_Name_State'	))
		,output(countNameSt_nomatch								,named('Name_State_Not_Match'	))				
		,output(NameStMatchrate										,named('Name_St_Match_rate'		))
		//*** Business Name & Address match stats
		,output(countSearchCriteriaWithBNameAddr	,named('FDS_Search_File_With_BusName_Addr'	))
		,output(countBNameAddr_nomatch						,named('BusName_Addr_Not_Match'	))				
		,output(BNameAddrMatchrate								,named('BusinessName_Addr_Match_rate'		))
		//*** Business Name & state match stats
		,output(countSearchCriteriaWithBNameSt		,named('FDS_Search_File_With_BusName_State'	))
		,output(countBNameSt_nomatch							,named('BusName_State_Not_Match'	))			
		,output(BNameStMatchrate									,named('BusinessName_State_Match_rate'		))
		//*** Business Name & state match stats
		,output(countSearchCriteriaWithTaxId			,named('FDS_Search_File_With_Tax_Id'	))
		,output(countTaxId_nomatch								,named('Tax_Id_Not_Match'	))					
		,output(TaxIdMatchrate										,named('Tax_Id_Match_rate'		))
		//*** Business Name & state match stats
		,output(countSearchCriteriaWithCaseNum		,named('FDS_Search_File_With_Case_Number'	))
		,output(countCaseNum_nomatch							,named('Case_Number_Not_Match'	))					
		,output(CaseNumMatchrate									,named('Case_Number_Match_rate'		))
		//,output(choosen(t1,500)										,named('sample_creditor_debtor_counts' ))
		//,output(choosen(t2,500)										,named('sample_filing_counts' ))
		//,output(Ucc_matches_with_dc_stats,named('sample_ucc_matches_with_stats' ));
		//,BuildUccAppendFile
	);	
	
end;