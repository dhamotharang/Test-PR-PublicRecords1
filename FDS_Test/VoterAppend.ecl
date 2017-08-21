import VotersV2,address,ut,versioncontrol;

Layout_Search := FDS_Test.Layouts.Input.CleanAssetLicRec;
Layout_Voter  := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

export VoterAppend(
	 string					        pversion	 
	,dataset(Layout_Search) pSearchCriteria	= Files.Input.ClnAssetLic		
	,dataset(Layout_Voter)	pVoterBase			= VotersV2.File_Voters_Base
	,boolean								pOverwrite			= false
	,boolean								pCsvout					= true
	,string									pSeparator			= '|'	

) :=
function

	//*** Input PubRec file.
	SearchCriteria := pSearchCriteria;

	//*** Voter base files
	Voter_base := pVoterBase(addr_type <> 'M');
	
	slim_voter_layout := record
		Layout_Voter.date_last_seen;
		Layout_Voter.file_acquired_date;
		Layout_Voter.process_date;
		Layout_Voter.fname;
		Layout_Voter.lname;
		Layout_Voter.mname;
		Layout_Voter.gender;
		Layout_Voter.DOB;
		Layout_Voter.race_exp;
		Layout_Voter.occupation;
		Layout_Voter.prim_range;
		Layout_Voter.predir;
		Layout_Voter.prim_name;
		Layout_Voter.addr_suffix;
		Layout_Voter.postdir;
		Layout_Voter.unit_desig;
		Layout_Voter.sec_range;
		Layout_Voter.p_city_name;
		Layout_Voter.v_city_name;
		Layout_Voter.st;
		Layout_Voter.zip;
		Layout_Voter.mail_prim_range;
		Layout_Voter.mail_predir;
		Layout_Voter.mail_prim_name;
		Layout_Voter.mail_addr_suffix;
		Layout_Voter.mail_postdir;
		Layout_Voter.mail_unit_desig;
		Layout_Voter.mail_sec_range;
		Layout_Voter.mail_p_city_name;
		Layout_Voter.mail_v_city_name;
		Layout_Voter.mail_st;
		Layout_Voter.mail_ace_zip;
		Layout_Voter.source_state;
		Layout_Voter.regDate;
		Layout_Voter.politicalparty_exp;
		Layout_Voter.active_status_exp;
		Layout_Voter.phone;		
		Layout_Voter.work_phone;
		Layout_Voter.LastDateVote;
		Layout_Voter.ssn;
		Layout_Voter.did;
	end;
	
	slim_voter_layout	trfVoterBase(Voter_base l) := transform
		self := l;
	end;
	
	slim_voter_base := project(Voter_base, trfVoterBase(left));
	
	//***************************************************************************************
	//*** Searches 
	//***************************************************************************************
	//*** FDS matched layout
	layout_FDS_matched := record
		string 	rec_id 	:= '';
		slim_voter_layout;
	end;

	//**************************************************************************************
	//*** Full SSN Search
	//**************************************************************************************
	SearchCriteria_SSN := SearchCriteria((integer)SSN <> 0 and
																			 trim(name) = '' and
																			 trim(address) = '' and
																			 trim(city) = '' and 
																			 trim(state) = ''
																			);
																			
	Voter_SSN_recs := slim_voter_base(trim(ssn) <> '');
	
	layout_FDS_matched getSSNMatchedVoter(Voter_SSN_recs l, SearchCriteria_SSN r) := transform
		self.rec_Id := r.Record_ID;
		self 				:= l;
	end;

	Voter_ssn_matched_recs := join(Voter_SSN_recs, SearchCriteria_SSN, 
															trim(left.ssn) = trim(right.ssn,left,right), 
															getSSNMatchedVoter(left,right),
															lookup);
	
	Voter_ssn_only_matches := sort(Voter_ssn_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Full SSN & Name Search
	//**************************************************************************************
	SearchCriteria_SSNName := SearchCriteria(length(trim(SSN,left,right)) = 9 and
																					 trim(name,left,right) <> '' 
																					);
																			
	layout_FDS_matched getSSNNameMatchedVoter(Voter_SSN_recs l, SearchCriteria_SSNName r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	Voter_ssn_name_matched_recs := join(Voter_SSN_recs, SearchCriteria_SSNName, 
																	 trim(left.ssn)   = trim(right.ssn,left,right) and
																	 (trim(left.fname) = trim(right.fname,left,right) or
																	  trim(left.fname) = trim(right.lname,left,right) or
																	  trim(left.fname) = trim(right.mname,left,right)) and
																	 (trim(left.lname) = trim(right.lname,left,right) or
																	  trim(left.lname) = trim(right.fname,left,right) or
																	  trim(left.lname) = trim(right.mname,left,right))/* and
																	 trim(left.mname) = trim(right.mname,left,right)*/,
																	 getSSNNameMatchedVoter(left,right),
																	 lookup);

	Voter_ssn_name_matches := sort(Voter_ssn_name_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Partial SSN & name Search
	//**************************************************************************************
	SearchCriteria_pSSNName := SearchCriteria(length(trim(SSN,left,right)) = 4 and
																					 trim(name,left,right) <> ''
																					);
																			
	layout_FDS_matched getPSSNNameMatchedVoter(Voter_SSN_recs l, SearchCriteria_pSSNName r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	Voter_pssn_name_matched_recs := join(Voter_SSN_recs, SearchCriteria_pSSNName, 
																	 trim(left.ssn)[6..9]  = trim(right.ssn,left,right) and
																	 (trim(left.fname) = trim(right.fname,left,right) or
																	  trim(left.fname) = trim(right.lname,left,right) or
																	  trim(left.fname) = trim(right.mname,left,right)) and
																	 (trim(left.lname) = trim(right.lname,left,right) or
																	  trim(left.lname) = trim(right.fname,left,right) or
																	  trim(left.lname) = trim(right.mname,left,right))
																	 /*and
																	 trim(left.mname) = trim(right.mname,left,right)*/,
																	 getPSSNNameMatchedVoter(left,right),
																	 lookup);

	Voter_pssn_name_matches := sort(Voter_pssn_name_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Name and address Search
	//**************************************************************************************
	//*** 1st using the DIDed records.
	SearchCriteria_did      := SearchCriteria(did <> 0 and
																						name <> '' and
																						trim(address,left,right) <> '' and
																						trim(city,left,right) <> ''
																					 );
	SearchCriteria_nameAddr := SearchCriteria(trim(Name,left,right) <> '' and 
																						trim(Address,left,right) <> '' and 
																						trim(City,left,right) <> '' and
																						trim(state,left,right) <> '' and
																						did = 0
																					 );

	layout_FDS_matched getDIDMatchedVoter(slim_Voter_base l, SearchCriteria_did r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_did_matched_recs := join(slim_Voter_base, SearchCriteria_did,
															 (unsigned6)left.did = right.did,
															 getDIDMatchedVoter(left,right),
															 lookup);

	//*** 2nd seach on records that didn't get the DID's
	layout_FDS_matched getNameAddrMatchedVoter(slim_Voter_base l, SearchCriteria_nameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_NameAddr_matched_recs := join(slim_Voter_base, SearchCriteria_nameAddr,
																	 trim(left.fname) = trim(right.fname) and
																	 trim(left.lname) = trim(right.lname) and
																	 //trim(left.mname) = trim(right.mname) and
																	 trim(left.prim_range)  = trim(right.prim_range) and
																	 //left.predir      = right.predir and
																	 trim(left.prim_name)   = trim(right.prim_name) and
																	 //trim(left.suffix) = trim(right.addr_suffix) and																	 
																	 //left.sec_range   = right.sec_range and
																	 trim(left.p_city_name) = trim(right.p_city_name) and
																	 trim(left.st)          = trim(right.st) and
																	 trim(left.zip)        = trim(right.zip),
																	 getNameAddrMatchedVoter(left,right),
																	 lookup);
	
	//*** 3nd seach on name and mailing address records 
	layout_FDS_matched getNameMAddrMatchedVoter(slim_Voter_base l, SearchCriteria_nameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_NameMAddr_matched_recs := join(slim_Voter_base, SearchCriteria_nameAddr,
																	 trim(left.fname) = trim(right.fname) and
																	 trim(left.lname) = trim(right.lname) and
																	 //trim(left.mname) = trim(right.mname) and
																	 trim(left.mail_prim_name)   = trim(right.prim_name) and
																	 //left.predir      = right.predir and
																	 //trim(left.mail_addr_suffix) = trim(right.addr_suffix) and
																	 trim(left.mail_prim_range)  = trim(right.prim_range) and
																	 //left.sec_range   = right.sec_range and
																	 trim(left.mail_p_city_name) = trim(right.p_city_name) and
																	 trim(left.mail_st)          = trim(right.st) and
																	 trim(left.mail_ace_zip)     = trim(right.zip),
																	 getNameMAddrMatchedVoter(left,right),
																	 lookup);
	
	Voter_NameAddr_matches := sort(Voter_did_matched_recs 
															+ Voter_NameAddr_matched_recs 
															+ Voter_NameMAddr_matched_recs
															, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Name and state Search
	//**************************************************************************************
	SearchCriteria_NameSt := SearchCriteria(trim(Name,left,right) <> '' and 
																					trim(state,left,right) <> '' and 
																					trim(City,left,right) = '' and
																					trim(zip_Code,left,right) = ''
																				 );

	layout_FDS_matched getNameStMatchedVoter(slim_Voter_base l, SearchCriteria_NameSt r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_NameSt_matched_recs := join(slim_Voter_base, SearchCriteria_NameSt,
																	trim(left.fname) = trim(right.fname) and
																	trim(left.lname) = trim(right.lname) and
																	//trim(left.mname) = trim(right.mname) and
																	(trim(left.st) 	 = trim(right.state) or
																	 trim(left.mail_st) = trim(right.state)),		//*** using raw state fields																	 
																	getNameStMatchedVoter(left,right),
																	lookup);

	Voter_NameSt_matches := sort(Voter_NameSt_matched_recs, rec_id, -date_last_seen, -file_acquired_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Name and zip Search
	//**************************************************************************************
	SearchCriteria_NameZip := SearchCriteria(trim(Name,left,right) <> '' and 
																					 trim(zip_code,left,right)  <> '' and 
																					 did = 0 and
																					 trim(state,left,right) = '' and
																					 trim(City,left,right) = ''
																				  );
	
	SearchCriteria_NameZipDid := SearchCriteria(trim(Name,left,right) <> '' and 
																						  trim(zip_code,left,right)  <> '' and
																						  did <> 0 and 
																						  trim(state,left,right) = '' and
																						  trim(City,left,right) = ''
																						 );

	layout_FDS_matched getNameZipMatchedVoter(slim_Voter_base l, SearchCriteria_NameZip r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_NameZip_matched_recs := join(slim_Voter_base, SearchCriteria_NameZip,
																 trim(left.fname) = trim(right.fname) and
																 trim(left.lname) = trim(right.lname) and
																 //trim(left.mname) = trim(right.mname) and
																 (trim(left.zip) 	 	= trim(right.zip_code) or
																  trim(left.mail_ace_zip) = trim(right.zip_code)),	//*** using raw state fields											 
																 getNameZipMatchedVoter(left,right),
																 lookup);

	layout_FDS_matched getNameZipDIDMatchedVoter(slim_Voter_base l, SearchCriteria_NameZipDid r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_NameZipDid_matched_recs := join(slim_Voter_base, SearchCriteria_NameZipDid,
																	(unsigned6)left.did = right.did,	//*** using raw state fields											 
																	getNameZipDIDMatchedVoter(left,right),
																	lookup);
	
	Voter_NameZip_matches := sort(Voter_NameZip_matched_recs 
														 + Voter_NameZipDid_matched_recs, rec_id, -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Address Only Search
	//**************************************************************************************
	SearchCriteria_Addr_Only      := SearchCriteria(trim(Name) = '' and
																									trim(Business_Name) = '' and
																									trim(address,left,right) <> '' and
																									trim(city,left,right) <> '' and 
																									trim(state,left,right) <> '' and
																									trim(zip_code) <> ''
																								 );
	
	layout_FDS_matched getAddrOnlyMatchedVoter(slim_Voter_base l, SearchCriteria_Addr_Only r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;


	Voter_AddrOnly_matched_recs := join(slim_Voter_base, SearchCriteria_Addr_Only,
																	 trim(left.prim_range)  = trim(right.prim_range) and
																	 //left.predir      = right.predir and
																	 trim(left.prim_name)   = trim(right.prim_name) and
																	 //trim(left.suffix) = trim(right.addr_suffix) and																	 
																	 //trim(left.sec_range)   = trim(right.sec_range) and
																	 trim(left.p_city_name) = trim(right.p_city_name) and
																	 trim(left.st)          = trim(right.st) and
																	 trim(left.zip)        = trim(right.zip),
																	 getAddrOnlyMatchedVoter(left,right),
																	 lookup);
	
	//*** 2nd seach on mailing address records 
	layout_FDS_matched getMAddrOnlyMatchedVoter(slim_Voter_base l, SearchCriteria_Addr_Only r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	Voter_MAddrOnly_matched_recs := join(slim_Voter_base, SearchCriteria_Addr_Only,
																	 trim(left.mail_prim_name)   = trim(right.prim_name) and
																	 //left.predir      = right.predir and
																	 //trim(left.mail_addr_suffix) = trim(right.addr_suffix) and
																	 trim(left.mail_prim_range)  = trim(right.prim_range) and
																	 //trim(left.sec_range)   		 = trim(right.sec_range) and
																	 trim(left.mail_p_city_name) = trim(right.p_city_name) and
																	 trim(left.mail_st)          = trim(right.st) and
																	 trim(left.mail_ace_zip)     = trim(right.zip),
																	 getMAddrOnlyMatchedVoter(left,right),
																	 lookup);
	
	Voter_AddrOnly_matches := sort(Voter_AddrOnly_matched_recs 
																+ Voter_MAddrOnly_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Phone Search
	//**************************************************************************************
	SearchCriteria_Phone := SearchCriteria(trim(Phone_Number,left,right) <> '');

	Voter_Phone_recs := slim_Voter_base(trim(Phone) <> '');

	layout_FDS_matched getPhoneMatchedVoter(Voter_Phone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	Voter_Phone_matched_recs := join(Voter_Phone_recs, SearchCriteria_Phone,
																 trim(left.phone) = trim(right.Phone_Number,left,right),
																 getPhoneMatchedVoter(left,right),
																 lookup);

	//** matching on work phone
	Voter_WPhone_recs := slim_Voter_base(trim(work_Phone) <> '');

	layout_FDS_matched getWPhoneMatchedVoter(Voter_WPhone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	Voter_WPhone_matched_recs := join(Voter_WPhone_recs, SearchCriteria_Phone,
																 trim(left.work_phone) = trim(right.Phone_number,left,right),
																 getWPhoneMatchedVoter(left,right),
															   lookup);

	//** matching on other phone
	/* There are no records with the other phone numbers.
	Voter_OPhone_recs := slim_Voter_base(trim(other_Phone) <> '');

	layout_FDS_matched getOPhoneMatchedVoter(Voter_OPhone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	Voter_OPhone_matched_recs := join(Voter_OPhone_recs, SearchCriteria_Phone,
																 trim(left.other_phone) = trim(right.Phone_number,left,right),
																 getOPhoneMatchedVoter(left,right),
															   lookup);
	*/
	//Voter_Phone_matches := dedup(sort(Voter_Phone_matched_recs + Voter_WPhone_matched_recs, rec_id, -date_last_seen, -file_acquired_date),rec_id, keep(5));
	Voter_Phone_matches := sort(Voter_Phone_matched_recs +
													 Voter_WPhone_matched_recs , rec_id, -date_last_seen, -file_acquired_date);
	//**************************************************************************************

	
	Voter_all_matches :=		Voter_ssn_only_matches
													+	Voter_ssn_name_matches
													+ Voter_pssn_name_matches
													+	Voter_NameAddr_matches
													+	Voter_NameSt_matches
													+	Voter_NameZip_matches
													+	Voter_AddrOnly_matches
													+	Voter_Phone_matches
													: persist('~thor_data400::persist::FDS_Test::Voter_Append::All_matches');
	
	ded_Voter_all_matches := dedup(sort(Voter_all_matches, rec_id, 
										 fname, lname, mname, prim_range, prim_name, st, zip, ssn, dob, source_state,  
										 -date_last_seen, -process_date, -regDate, -LastDateVote, politicalparty_exp, active_status_exp),
									rec_id, fname, lname, mname, prim_range, prim_name, st, zip, ssn, dob, source_state, 
									regDate, LastDateVote, politicalparty_exp, active_status_exp);
	
	Voter_all_matches_srt := sort(ded_Voter_all_matches, rec_id, -date_last_seen, -process_date,
								  fname, lname, mname, prim_range, prim_name, st, zip, ssn, dob, source_state,  
								  -regDate, -LastDateVote, politicalparty_exp, active_status_exp);
	//***************************************************************************************
	//*** Mapping to FDS dictonary
	//***************************************************************************************
	inputSearchfile := FDS_Test.Files.input.AssetLic;
	
	Layout_FDS_Append_temp  := record
		Layouts.Response.Voter_Append_temp;
	end;

	Layout_FDS_Append_out  := Layouts.Response.Voter_Append;

	Layout_FDS_Append_temp mapVoterToFDS(inputSearchfile l, Voter_all_matches_srt r) := transform
			self.rec_id 								:= trim(r.rec_id);
			self.First_Name 						:= trim(r.fname);
			self.Middle_Name 						:= trim(r.mname);
			self.Last_Name 							:= trim(r.lname);
			//**** Residence address fields
			self.Street_Addr	 					:= trim(Address.Addr1FromComponents(
																					r.prim_range
																					,r.predir
																					,r.prim_name
																					,r.addr_suffix
																					,r.postdir
																					,'',''
																					),left,right);
			self.Secondary_Addr 				:= trim(Address.Addr1FromComponents(
																					r.unit_desig
																					,r.sec_range
																					,''
																					,''
																					,''
																					,''
																					,''
																					),left,right);
			self.res_city 							:= trim(r.p_city_name);
			self.st 										:= trim(r.St);
			self.zip			 							:= trim(r.Zip);
			self.State_of_Registration	:= trim(r.source_state);
			self.registration_date 			:= if(r.regDate != '', intformat(ut.Date_MMDDYYYY_i2(r.regDate),8,1),'');
			self.political_party				:= trim(r.politicalparty_exp);
			self.last_vote_date	 				:= if(r.LastDateVote != '', intformat(ut.Date_MMDDYYYY_i2(r.LastDateVote),8,1),'');
			self.Active_Status					:= trim(r.active_status_exp);
			//self.dt_last_seen						:= l.date_last_seen;
			self.SSN_out								:= trim(r.ssn);
			self.Gender 								:= map (trim(r.gender) = 'F' => 'FEMALE',
																					trim(r.gender) = 'M' => 'MALE',
																					''
																				 );
			self.DOB	 									:= if(r.dob != '',intformat(ut.Date_MMDDYYYY_i2(r.dob),8,1),'');
			self.race										:= trim(r.race_exp);
			self.Occupation							:= trim(r.Occupation);
			//**** Mailing address fields
			self.mail_Street_Addr	 			:= trim(Address.Addr1FromComponents(
																					r.mail_prim_range
																					,r.mail_predir
																					,r.mail_prim_name
																					,r.mail_addr_suffix
																					,r.mail_postdir
																					,'',''
																					),left,right);
			self.mail_Secondary_Addr 		:= trim(Address.Addr1FromComponents(
																					r.mail_unit_desig
																					,r.mail_sec_range
																					,''
																					,''
																					,''
																					,''
																					,''
																					),left,right);
			self.mail_city 							:= trim(r.mail_p_city_name);
			self.mail_st 								:= trim(r.mail_St);
			self.mail_zip			 					:= trim(r.mail_ace_Zip);
			
			self 												:= l;
	end;

	Mapped_FDS_Voter_Append	:= join(inputSearchfile, Voter_all_matches_srt,
																left.record_id = right.rec_id,
																mapVoterToFDS(left,right),
																left outer
															 ): persist('~thor_data400::persist::fds_test::Voter_Append::Mapped_To_FDS');
	
	FDS_Voter_Append_Out := dedup(sort(project(Mapped_FDS_Voter_Append,transform(Layout_FDS_Append_out, self := left)),
										(integer)record_id),record_id, keep(5));
	
	//********************************************************************************************
	//*** Matched field fill stats 
	//********************************************************************************************	
	layout_stat := 
	record
    integer countGroup := count(group);
		//Record_ID_CountNonBlank     					:= sum(group,if(Mapped_FDS_UCC_Append.Rec_ID	<> '',100,0));
		First_Name_CountNonBlank					:= ave(group,if(Mapped_FDS_Voter_Append.First_name	<> '',100,0));
		Middle_Name_CountNonBlank					:= ave(group,if(Mapped_FDS_Voter_Append.Middle_name	<> '',100,0));
		Last_Name_CountNonBlank						:= ave(group,if(Mapped_FDS_Voter_Append.Last_name	<> '',100,0));
		Street_Address_CountNonBlank			:= ave(group,if(Mapped_FDS_Voter_Append.Street_Addr	<> '',100,0));
		Secondary_Address_CountNonBlank		:= ave(group,if(Mapped_FDS_Voter_Append.Secondary_Addr	<> '',100,0));
		city_CountNonBlank								:= ave(group,if(Mapped_FDS_Voter_Append.res_city	<> '',100,0));
		state_CountNonBlank								:= ave(group,if(Mapped_FDS_Voter_Append.st	<> '',100,0));
		zip_CountNonBlank									:= ave(group,if(Mapped_FDS_Voter_Append.zip	<> '',100,0));
		ssn_CountNonBlank									:= ave(group,if(Mapped_FDS_Voter_Append.ssn_out	<> '',100,0));
		gender_CountNonBlank							:= ave(group,if(Mapped_FDS_Voter_Append.gender	<> '',100,0));
		dob_CountNonBlank									:= ave(group,if(Mapped_FDS_Voter_Append.dob	<> '',100,0));
		race_CountNonBlank								:= ave(group,if(Mapped_FDS_Voter_Append.race	<> '',100,0));
		Occupation_CountNonBlank					:= ave(group,if(Mapped_FDS_Voter_Append.Occupation	<> '',100,0));
		State_of_Registration_CountNonBlank	:= ave(group,if(Mapped_FDS_Voter_Append.State_of_Registration	<> '',100,0));
		registration_date_CountNonBlank		:= ave(group,if(Mapped_FDS_Voter_Append.registration_date	<> '',100,0));
		political_party_CountNonBlank			:= ave(group,if(Mapped_FDS_Voter_Append.political_party	<> '',100,0));
		last_vote_date_CountNonBlank			:= ave(group,if(Mapped_FDS_Voter_Append.last_vote_date	<> '',100,0));
		Active_Status_CountNonBlank				:= ave(group,if(Mapped_FDS_Voter_Append.Active_Status	<> '',100,0));
		
		Mail_Street_Addr_CountNonBlank		:= ave(group,if(Mapped_FDS_Voter_Append.Mail_Street_Addr	<> '',100,0));
		Mail_Secondary_Addr_CountNonBlank	:= ave(group,if(Mapped_FDS_Voter_Append.Mail_Secondary_Addr	<> '',100,0));
		Mail_city_CountNonBlank						:= ave(group,if(Mapped_FDS_Voter_Append.Mail_city	<> '',100,0));
		Mail_state_CountNonBlank					:= ave(group,if(Mapped_FDS_Voter_Append.Mail_st	<> '',100,0));
		Mail_zip_CountNonBlank						:= ave(group,if(Mapped_FDS_Voter_Append.Mail_zip	<> '',100,0));
		
	end;
	
	dVoter_Matches_fill_stats := table(Mapped_FDS_Voter_Append(trim(rec_id) <> ''), layout_stat, few);
	
	//********************************************************************************************
	//*** -- Match rate stats by search criteria
	//********************************************************************************************
	//*** Full SSN Only match
	ded_FDS_Voter_Append 							:= dedup(Mapped_FDS_Voter_Append,record_id,all);
	
	countSearchCriteriaWithSSNOnly	:= count(SearchCriteria_SSN);
	countSSNOnly_nomatch						:= count(ded_FDS_Voter_Append(length(trim(SSN)) = 9 and
																														 trim(name) = '' and
																														 trim(address) = '' and
																														 trim(city) = '' and 
																														 trim(state) = '' and trim(rec_id) = ''));
	
	SSNOnlyMatchrate := if((countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) / (real8)countSearchCriteriaWithSSNOnly * 100.0,0);
	
	//*** Full SSN and Name match
	countSearchCriteriaWithSSNName 	:= count(SearchCriteria_SSNName);
	countSSNName_nomatch						:= count(ded_FDS_Voter_Append(length(trim(SSN,left,right)) = 9 and
																														 trim(name,left,right) <> '' and 
																														 trim(rec_id) = ''));

	SSNNameMatchrate := if((countSearchCriteriaWithSSNName - countSSNName_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNName - countSSNName_nomatch) / (real8)countSearchCriteriaWithSSNName * 100.0,0);
	
	//*** Partial SSN and Name match
	countSearchCriteriaWithPSSNName := count(SearchCriteria_pSSNName);
	countPSSNName_nomatch						:= count(ded_FDS_Voter_Append(length(trim(SSN,left,right)) = 4 and
																														 trim(name,left,right) <> '' and 
																														 trim(rec_id) = ''));

	PSSNNameMatchrate := if((countSearchCriteriaWithPSSNName - countPSSNName_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithPSSNName - countPSSNName_nomatch) / (real8)countSearchCriteriaWithPSSNName * 100.0,0);
	
	//*** Name and Address match 
	countSearchCriteriaWithNameAddr	:= count(SearchCriteria_did + SearchCriteria_nameAddr);
	countNameAddr_nomatch						:= count(ded_FDS_Voter_Append(trim(name) <> '' and
																														 trim(address) <> '' and
																														 trim(city) <> '' and
																														 trim(state) <> '' and
																														 rec_id = ''));

	NameAddrMatchrate := if((countSearchCriteriaWithNameAddr - countNameAddr_nomatch) <> 0, 
													(real8)(countSearchCriteriaWithNameAddr - countNameAddr_nomatch) / (real8)countSearchCriteriaWithNameAddr * 100.0,0);

	//*** Name and state match 
	countSearchCriteriaWithNameSt	:= count(SearchCriteria_NameSt);
	countNameSt_nomatch						:= count(ded_FDS_Voter_Append(trim(name) <> '' and
																													 trim(state) <> '' and
																													 trim(address) = '' and
																													 trim(city) = '' and
																													 rec_id = ''));

	NameStMatchrate := if((countSearchCriteriaWithNameSt - countNameSt_nomatch) <> 0, 
												(real8)(countSearchCriteriaWithNameSt - countNameSt_nomatch) / (real8)countSearchCriteriaWithNameSt * 100.0,0);

	
	//*** Name and Zip match 
	countSearchCriteriaWithNameZip	:= count(SearchCriteria_NameZip + SearchCriteria_NameZipDid);
	countNameZip_nomatch						:= count(ded_FDS_Voter_Append(trim(Name,left,right) <> '' and 
																														 trim(zip_code,left,right)  <> '' and 
																														 trim(state,left,right) = '' and
																														 trim(City,left,right) = '' and
																														 rec_id = ''));

	NameZipMatchrate := if((countSearchCriteriaWithNameZip - countNameZip_nomatch) <> 0, 
												(real8)(countSearchCriteriaWithNameZip - countNameZip_nomatch) / (real8)countSearchCriteriaWithNameZip * 100.0,0);


	//*** Address Only match 
	countSearchCriteriaWithAddrOnly	:= count(SearchCriteria_Addr_Only);
	countAddrOnly_nomatch						:= count(ded_FDS_Voter_Append(trim(Name) = '' and
																														 trim(business_name) = '' and
																														 trim(address,left,right) <> '' and
																														 trim(city,left,right) <> '' and 
																														 trim(state,left,right) <> '' and
																														 trim(zip_code) <> '' and
																														 rec_id = ''));

	AddrOnlyMatchrate := if((countSearchCriteriaWithAddrOnly - countAddrOnly_nomatch) <> 0, 
													(real8)(countSearchCriteriaWithAddrOnly - countAddrOnly_nomatch) / (real8)countSearchCriteriaWithAddrOnly * 100.0,0);


	
	//*** Phone match 
	countSearchCriteriaWithPhone	:= count(SearchCriteria_Phone	);
	countPhone_nomatch						:= count(ded_FDS_Voter_Append(trim(Phone_number) <> '' and rec_id = ''));
	
	PhoneMatchrate := if((countSearchCriteriaWithPhone - countPhone_nomatch) <> 0,
											 (real8)(countSearchCriteriaWithPhone - countPhone_nomatch) / (real8)countSearchCriteriaWithPhone * 100.0,0);

	//**************************************************************************************
	
	return sequential(
							output('FDS Voter Append Results Follow'		,named('_'														))
						 //,output(sort(Voter_NameZipDid_matched_recs,(integer)rec_id),named('ZipDid_matches'))
						 ,output(sort(Voter_all_matches,(integer)rec_id),named('All_Voter_matches'),all)
						 ,output(sort(Voter_all_matches_srt,(integer)rec_id),named('ded_All_Voter_matches_srt'),all)						 
						 ,output(FDS_Voter_Append_Out,,'~thor_data400::out::FDS_Test::Voter::Append',csv(separator(pSeparator)),overwrite)
						 ,output(dVoter_Matches_fill_stats						,named('Appended_fields_fill_Rates'		))
						 //*** Full SSN only match stats
						 ,output(countSearchCriteriaWithSSNOnly		,named('FDS_Search_File_With_SSN_Only'	))
						 ,output(countSSNOnly_nomatch							,named('SSNOnly_Not_Match'	))		
						 ,output(SSNOnlyMatchrate									,named('SSN_Only_Match_rate'		))
						 //*** Full SSN, name match stats
						 ,output(countSearchCriteriaWithSSNName		,named('FDS_Search_File_With_SSN_Name'	))
						 ,output(countSSNName_nomatch							,named('SSN_Name_Not_Match'	))		
						 ,output(SSNNameMatchrate									,named('SSN_Name_Match_rate'		))
						 //*** Partial SSN, name match stats
						 ,output(countSearchCriteriaWithPSSNName	,named('FDS_Search_File_With_PartialSSN_Name'	))
						 ,output(countPSSNName_nomatch						,named('PartialSSN_Name_Not_Match'	))		
						 ,output(PSSNNameMatchrate								,named('PartialSSN_Name_Match_rate'		))
						 //*** Name & Address match stats
						 ,output(countSearchCriteriaWithNameAddr	,named('FDS_Search_File_With_Name_Addr'	))
						 ,output(countNameAddr_nomatch						,named('Name_Addr_Not_Match'	))				
						 ,output(NameAddrMatchrate								,named('Name_Addr_Match_rate'	))
						 //*** Name & state match stats
						 ,output(countSearchCriteriaWithNameSt		,named('FDS_Search_File_With_Name_State'	))
						 ,output(countNameSt_nomatch							,named('Name_State_Not_Match'	))				
						 ,output(NameStMatchrate									,named('Name_St_Match_rate'		))
						 //*** Name & zip match stats
						 ,output(countSearchCriteriaWithNameZip		,named('FDS_Search_File_With_Name_Zip'	))
						 ,output(countNameZip_nomatch							,named('Name_Zip_Not_Match'	))				
						 ,output(NameZipMatchrate									,named('Name_Zip_Match_rate'))
						 //*** Address Only match stats
						 ,output(countSearchCriteriaWithAddrOnly	,named('FDS_Search_File_With_AddrOnly'	))
						 ,output(countAddrOnly_nomatch						,named('AddrOnly_Not_Match'	))				
						 ,output(AddrOnlyMatchrate								,named('AddrOnly_Match_rate'))
						 //*** Phone match stats
						 ,output(countSearchCriteriaWithPhone			,named('FDS_Search_File_With_Phone'	))
						 ,output(countPhone_nomatch								,named('Phone_Not_Match'	))					
						 ,output(PhoneMatchrate										,named('Phone_Match_rate'		))						 
				 );	
end;