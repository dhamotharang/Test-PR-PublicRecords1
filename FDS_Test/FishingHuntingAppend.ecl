import Fds_test,eMerges,address,ut,versioncontrol;

Layout_hunt		:= emerges.layout_hunters_out;
Layout_search	:= FDS_Test.Layouts.Input.CleanAssetLicRec;

export FishingHuntingAppend(
	 string					        pversion	 
	,dataset(Layout_search) pSearchCriteria	= FDS_Test.files.Input.ClnAssetLic		
	,dataset(Layout_hunt)		pEmergesBase		= eMerges.file_hunters_out
	,boolean								pOverwrite			= false
	,boolean								pCsvout					= true
	,string									pSeparator			= '|'	

) :=
function
	//*** Input PubRec file.
	SearchCriteria := pSearchCriteria;

	//*** Fishing hunting base files
	emerges_fh_base := pEmergesBase;
	
	slim_FHunt_layout := record
		emerges.layout_hunters_out.date_last_seen;
		emerges.layout_hunters_out.file_acquired_date;
		emerges.layout_hunters_out.process_date;
		emerges.layout_hunters_out.fname;
		emerges.layout_hunters_out.lname;
		emerges.layout_hunters_out.mname;
		emerges.layout_hunters_out.prim_range;
		emerges.layout_hunters_out.predir;
		emerges.layout_hunters_out.prim_name;
		emerges.layout_hunters_out.suffix;
		emerges.layout_hunters_out.postdir;
		emerges.layout_hunters_out.unit_desig;
		emerges.layout_hunters_out.sec_range;
		emerges.layout_hunters_out.p_city_name;
		emerges.layout_hunters_out.city_name;
		emerges.layout_hunters_out.st;
		emerges.layout_hunters_out.zip;
		
		emerges.layout_hunters_out.mail_prim_range;
		emerges.layout_hunters_out.mail_predir;
		emerges.layout_hunters_out.mail_prim_name;
		emerges.layout_hunters_out.mail_addr_suffix;
		emerges.layout_hunters_out.mail_postdir;
		emerges.layout_hunters_out.mail_unit_desig;
		emerges.layout_hunters_out.mail_sec_range;
		emerges.layout_hunters_out.mail_p_city_name;
		emerges.layout_hunters_out.mail_v_city_name;
		emerges.layout_hunters_out.mail_st;
		emerges.layout_hunters_out.mail_ace_zip;
		
		emerges.layout_hunters_out.license_type_mapped;
		emerges.layout_hunters_out.source_state;
		emerges.layout_hunters_out.DateLicense;
		emerges.layout_hunters_out.HuntFishPerm;
		emerges.layout_hunters_out.best_ssn;
		emerges.layout_hunters_out.gender;
		emerges.layout_hunters_out.DOB;
		emerges.layout_hunters_out.homestate;
		emerges.layout_hunters_out.phone;		
		emerges.layout_hunters_out.work_phone;
		emerges.layout_hunters_out.other_phone;
		emerges.layout_hunters_out.did_out;
	end;
	
	slim_FHunt_layout	trfFHbase(emerges_fh_base l) := transform
		self := l;
	end;
	
	slim_emerges_FH_base := project(emerges_fh_base, trfFHbase(left));
	
	//***************************************************************************************
	//*** Searches 
	//***************************************************************************************
	//*** FDS matched layout
	layout_FDS_matched := record
		string 	rec_id 	:= '';
		slim_FHunt_layout;
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
																			
	FH_SSN_recs := slim_emerges_FH_base(trim(best_ssn) <> '');
	
	layout_FDS_matched getSSNMatchedFH(FH_SSN_recs l, SearchCriteria_SSN r) := transform
		self.rec_Id := r.Record_ID;
		self 				:= l;
	end;

	FH_ssn_matched_recs := join(FH_SSN_recs, SearchCriteria_SSN, 
															trim(left.best_ssn) = trim(right.ssn,left,right), 
															getSSNMatchedFH(left,right),
															lookup);
	
	FH_ssn_only_matches := sort(FH_ssn_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Full SSN & Name Search
	//**************************************************************************************
	SearchCriteria_SSNName := SearchCriteria(length(trim(SSN,left,right)) = 9 and
																					 trim(name,left,right) <> '' 
																					);
																			
	layout_FDS_matched getSSNNameMatchedFH(FH_SSN_recs l, SearchCriteria_SSNName r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	FH_ssn_name_matched_recs := join(FH_SSN_recs, SearchCriteria_SSNName, 
																	 trim(left.best_ssn)   = trim(right.ssn,left,right) and
																	 trim(left.fname) = trim(right.fname,left,right) and
																	 trim(left.lname) = trim(right.lname,left,right)/* and
																	 trim(left.mname) = trim(right.mname,left,right)*/,
																	 getSSNNameMatchedFH(left,right),
																	 lookup);

	FH_ssn_name_matches := sort(FH_ssn_name_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Partial SSN & name Search
	//**************************************************************************************
	SearchCriteria_pSSNName := SearchCriteria(length(trim(SSN,left,right)) = 4 and
																					 trim(name,left,right) <> ''
																					);
																			
	layout_FDS_matched getPSSNNameMatchedFH(FH_SSN_recs l, SearchCriteria_SSNName r) := transform
		self.rec_Id := r.Record_ID;
		self := l;
	end;

	FH_pssn_name_matched_recs := join(FH_SSN_recs, SearchCriteria_SSNName, 
																	 trim(left.best_ssn)[6..9]  = trim(right.ssn,left,right) and
																	 trim(left.fname) = trim(right.fname,left,right) and
																	 trim(left.lname) = trim(right.lname,left,right) /*and
																	 trim(left.mname) = trim(right.mname,left,right)*/,
																	 getPSSNNameMatchedFH(left,right),
																	 lookup);

	FH_pssn_name_matches := sort(FH_pssn_name_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	
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

	layout_FDS_matched getDIDMatchedFH(slim_emerges_FH_base l, SearchCriteria_did r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_did_matched_recs := join(slim_emerges_FH_base, SearchCriteria_did,
															 (unsigned6)left.did_out = right.did,
															 getDIDMatchedFH(left,right),
															 lookup);

	//*** 2nd seach on records that didn't get the DID's
	layout_FDS_matched getNameAddrMatchedFH(slim_emerges_FH_base l, SearchCriteria_nameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_NameAddr_matched_recs := join(slim_emerges_FH_base, SearchCriteria_nameAddr,
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
																	 getNameAddrMatchedFH(left,right),
																	 lookup);
	
	//*** 3nd seach on name and mailing address records 
	layout_FDS_matched getNameMAddrMatchedFH(slim_emerges_FH_base l, SearchCriteria_nameAddr r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_NameMAddr_matched_recs := join(slim_emerges_FH_base, SearchCriteria_nameAddr,
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
																	 getNameMAddrMatchedFH(left,right),
																	 lookup);
	
	FH_NameAddr_matches := sort(FH_did_matched_recs 
															+ FH_NameAddr_matched_recs 
															+ FH_NameMAddr_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************

	//**************************************************************************************
	//*** Name and state Search
	//**************************************************************************************
	SearchCriteria_NameSt := SearchCriteria(trim(Name,left,right) <> '' and 
																					trim(state,left,right) <> '' and 
																					trim(City,left,right) = '' and
																					trim(zip_Code,left,right) = ''
																				 );

	layout_FDS_matched getNameStMatchedFH(slim_emerges_FH_base l, SearchCriteria_NameSt r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_NameSt_matched_recs := join(slim_emerges_FH_base, SearchCriteria_NameSt,
																	trim(left.fname) = trim(right.fname) and
																	trim(left.lname) = trim(right.lname) and
																	//trim(left.mname) = trim(right.mname) and
																	(trim(left.st) 	 = trim(right.state) or
																	 trim(left.mail_st) = trim(right.state)), //*** using raw state fields																	 
																	getNameStMatchedFH(left,right),
																	lookup);

	FH_NameSt_matches := sort(FH_NameSt_matched_recs, rec_id, -date_last_seen, -file_acquired_date);
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

	layout_FDS_matched getNameZipMatchedFH(slim_emerges_FH_base l, SearchCriteria_NameZip r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_NameZip_matched_recs := join(slim_emerges_FH_base, SearchCriteria_NameZip,
																 trim(left.fname) = trim(right.fname) and
																 trim(left.lname) = trim(right.lname) and
																 //trim(left.mname) = trim(right.mname) and
																 (trim(left.zip) 	 	= trim(right.zip_code) or
																  trim(left.mail_ace_zip) = trim(right.zip_code)),	//*** using raw state fields											 
																 getNameZipMatchedFH(left,right),
																 lookup);

	layout_FDS_matched getNameZipDIDMatchedFH(slim_emerges_FH_base l, SearchCriteria_NameZipDid r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_NameZipDid_matched_recs := join(slim_emerges_FH_base, SearchCriteria_NameZipDid,
																	(unsigned6)left.did_out = right.did,	//*** using raw state fields											 
																	getNameZipDIDMatchedFH(left,right),
																	lookup);
	
	FH_NameZip_matches := sort(FH_NameZip_matched_recs 
														 + FH_NameZipDid_matched_recs, rec_id, -date_last_seen, -file_acquired_date);
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
	
	layout_FDS_matched getAddrOnlyMatchedFH(slim_emerges_FH_base l, SearchCriteria_Addr_Only r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;


	FH_AddrOnly_matched_recs := join(slim_emerges_FH_base, SearchCriteria_Addr_Only,
																	 trim(left.prim_range)  = trim(right.prim_range) and
																	 //left.predir      = right.predir and
																	 trim(left.prim_name)   = trim(right.prim_name) and
																	 //trim(left.suffix) = trim(right.addr_suffix) and																	 
																	 //trim(left.sec_range)   = trim(right.sec_range) and
																	 trim(left.p_city_name) = trim(right.p_city_name) and
																	 trim(left.st)          = trim(right.st) and
																	 trim(left.zip)        = trim(right.zip),
																	 getAddrOnlyMatchedFH(left,right),
																	 lookup);
	
	//*** 2nd seach on mailing address records 
	layout_FDS_matched getMAddrOnlyMatchedFH(slim_emerges_FH_base l, SearchCriteria_Addr_Only r) := transform
			self.rec_id				:= r.Record_Id;
			self							:= l;   
	end;

	FH_MAddrOnly_matched_recs := join(slim_emerges_FH_base, SearchCriteria_Addr_Only,
																	 trim(left.mail_prim_name)   = trim(right.prim_name) and
																	 //left.predir      = right.predir and
																	 //trim(left.mail_addr_suffix) = trim(right.addr_suffix) and
																	 trim(left.mail_prim_range)  = trim(right.prim_range) and
																	 //trim(left.sec_range)   		 = trim(right.sec_range) and
																	 trim(left.mail_p_city_name) = trim(right.p_city_name) and
																	 trim(left.mail_st)          = trim(right.st) and
																	 trim(left.mail_ace_zip)     = trim(right.zip),
																	 getMAddrOnlyMatchedFH(left,right),
																	 lookup);
	
	FH_AddrOnly_matches := sort(FH_AddrOnly_matched_recs 
															+ FH_MAddrOnly_matched_recs, rec_id,  -date_last_seen, -file_acquired_date);
	//**************************************************************************************
	
	//**************************************************************************************
	//*** Phone Search
	//**************************************************************************************
	SearchCriteria_Phone := SearchCriteria(trim(Phone_Number,left,right) <> '');

	FH_Phone_recs := slim_emerges_FH_base(trim(Phone) <> '');

	layout_FDS_matched getPhoneMatchedFH(FH_Phone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	FH_Phone_matched_recs := join(FH_Phone_recs, SearchCriteria_Phone,
																 trim(left.phone) = trim(right.Phone_Number,left,right),
																 getPhoneMatchedFH(left,right),
																 lookup);

	//** matching on work phone
	FH_WPhone_recs := slim_emerges_FH_base(trim(work_Phone) <> '');

	layout_FDS_matched getWPhoneMatchedFH(FH_WPhone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	FH_WPhone_matched_recs := join(FH_WPhone_recs, SearchCriteria_Phone,
																 trim(left.work_phone) = trim(right.Phone_number,left,right),
																 getWPhoneMatchedFH(left,right),
															   lookup);

	//** matching on other phone
	/* There are no records with the other phone numbers.
	FH_OPhone_recs := slim_emerges_FH_base(trim(other_Phone) <> '');

	layout_FDS_matched getOPhoneMatchedFH(FH_OPhone_recs l, SearchCriteria_Phone r) := transform
			self.rec_id := r.Record_Id;
			self 				:= l;
	end;

	FH_OPhone_matched_recs := join(FH_OPhone_recs, SearchCriteria_Phone,
																 trim(left.other_phone) = trim(right.Phone_number,left,right),
																 getOPhoneMatchedFH(left,right),
															   lookup);
	*/
	//FH_Phone_matches := dedup(sort(FH_Phone_matched_recs + FH_WPhone_matched_recs, rec_id, -date_last_seen, -file_acquired_date),rec_id, keep(5));
	FH_Phone_matches := sort(FH_Phone_matched_recs +
													 FH_WPhone_matched_recs , rec_id, -date_last_seen, -file_acquired_date);
	//**************************************************************************************

	
	fh_all_matches :=		FH_ssn_only_matches
										+	FH_ssn_name_matches
										+ FH_pssn_name_matches
										+	FH_NameAddr_matches
										+	FH_NameSt_matches
										+	FH_NameZip_matches
										+	FH_AddrOnly_matches
										+	FH_Phone_matches
										 : persist('~thor_data400::persist::FDS_Test::Hunting_Fishing_Append::All_matches');
	
	ded_fh_all_matches := dedup(sort(fh_all_matches, rec_id, -process_date, -file_acquired_date, -date_last_seen,
																	 fname, lname, mname, prim_range, prim_name, st, zip, best_ssn, dob, source_state,  
																	 license_type_mapped, DateLicense, HuntFishPerm),
															rec_id, fname, lname, mname, prim_range, prim_name, st, zip, best_ssn, dob, source_state, 
															license_type_mapped, DateLicense, HuntFishPerm,all);
	//***************************************************************************************
	//*** Mapping to FDS dictonary
	//***************************************************************************************
	inputSearchfile := FDS_Test.Files.input.AssetLic;
	
	Layout_FDS_Append_temp  := record
		Layouts.Response.Fishing_Hunting_Append_temp;
	end;

	Layout_FDS_Append_out  := Layouts.Response.Fishing_Hunting_Append;

	Layout_FDS_Append_temp mapFHtoFDS(inputSearchfile l, ded_fh_all_matches r) := transform
			self.rec_id 								:= trim(r.rec_id);
			self.First_Name 						:= trim(r.fname);
			self.Middle_Name 						:= trim(r.mname);
			self.Last_Name 							:= trim(r.lname);
			//**** Residence address fields
			self.Street_Addr	 					:= trim(Address.Addr1FromComponents(
																					r.prim_range
																					,r.predir
																					,r.prim_name
																					,r.suffix
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
			self.license_type 					:= stringlib.StringToUppercase(trim(r.license_type_mapped));
			self.Home_State							:= stringlib.StringToUppercase(trim(r.HomeState));
			self.license_state					:= trim(r.source_state);
			self.license_date 					:= if(r.DateLicense != '',intformat(ut.Date_MMDDYYYY_i2(r.DateLicense),8,1),'');
			self.license_number 				:= trim(r.HuntFishPerm);
			self.SSN_out								:= trim(r.best_ssn);
			self.Gender 								:= map (trim(r.gender) = 'F' => 'FEMALE',
																					trim(r.gender) = 'M' => 'MALE',
																					''
																				 );
			self.DOB	 									:= if(r.dob != '',intformat(ut.Date_MMDDYYYY_i2(r.dob),8,1),'');
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

	Mapped_FDS_FH_Append	:= join(inputSearchfile, ded_fh_all_matches,
																left.record_id = right.rec_id,
																mapFHtoFDS(left,right),
																left outer
															 ): persist('~thor_data400::persist::fds_test::Hunting_Fishing_Append::Mapped_To_FDS');
	/*														 
	Mapped_FDS_FH_Append_ded	:= dedup(sort(Mapped_FDS_FH_Append, record_id, first_name, last_name, middle_name, Street_Addr, Secondary_Addr, res_city, st, zip,
																		 ssn_out, dob, license_state, license_type, license_date, license_number, Home_State),
																		 record_id, first_name, last_name, middle_name, Street_Addr, Secondary_Addr, res_city, st, zip,
																		 ssn_out, dob, license_state, license_type, license_date, license_number,Home_State
																		 );
	*/
	FDS_FH_Append_Out := dedup(sort(project(Mapped_FDS_FH_Append,transform(Layout_FDS_Append_out, self := left)),(integer)record_id),record_id, keep(5));
	
	//********************************************************************************************
	//*** Matched field fill stats 
	//********************************************************************************************	
	layout_stat := 
	record
    integer countGroup := count(group);
		//Record_ID_CountNonBlank     					:= sum(group,if(Mapped_FDS_UCC_Append.Rec_ID	<> '',100,0));
		First_Name_CountNonBlank					:= ave(group,if(Mapped_FDS_FH_Append.First_name	<> '',100,0));
		Middle_Name_CountNonBlank					:= ave(group,if(Mapped_FDS_FH_Append.Middle_name	<> '',100,0));
		Last_Name_CountNonBlank						:= ave(group,if(Mapped_FDS_FH_Append.Last_name	<> '',100,0));
		Street_Address_CountNonBlank			:= ave(group,if(Mapped_FDS_FH_Append.Street_Addr	<> '',100,0));
		Secondary_Address_CountNonBlank		:= ave(group,if(Mapped_FDS_FH_Append.Secondary_Addr	<> '',100,0));
		city_CountNonBlank								:= ave(group,if(Mapped_FDS_FH_Append.res_city	<> '',100,0));
		state_CountNonBlank								:= ave(group,if(Mapped_FDS_FH_Append.st	<> '',100,0));
		zip_CountNonBlank									:= ave(group,if(Mapped_FDS_FH_Append.zip	<> '',100,0));
		license_type_CountNonBlank				:= ave(group,if(Mapped_FDS_FH_Append.license_type	<> '',100,0));
		Home_state_CountNonBlank					:= ave(group,if(Mapped_FDS_FH_Append.Home_state	<> '',100,0));
		license_state_CountNonBlank				:= ave(group,if(Mapped_FDS_FH_Append.license_state	<> '',100,0));
		license_date_CountNonBlank				:= ave(group,if(Mapped_FDS_FH_Append.license_date	<> '',100,0));
		license_number_CountNonBlank			:= ave(group,if(Mapped_FDS_FH_Append.license_number	<> '',100,0));
		ssn_CountNonBlank									:= ave(group,if(Mapped_FDS_FH_Append.ssn_out	<> '',100,0));
		gender_CountNonBlank							:= ave(group,if(Mapped_FDS_FH_Append.gender	<> '',100,0));
		dob_CountNonBlank									:= ave(group,if(Mapped_FDS_FH_Append.dob	<> '',100,0));
		Mail_Street_Addr_CountNonBlank		:= ave(group,if(Mapped_FDS_FH_Append.Mail_Street_Addr	<> '',100,0));
		Mail_Secondary_Addr_CountNonBlank	:= ave(group,if(Mapped_FDS_FH_Append.Mail_Secondary_Addr	<> '',100,0));
		Mail_city_CountNonBlank						:= ave(group,if(Mapped_FDS_FH_Append.Mail_city	<> '',100,0));
		Mail_state_CountNonBlank					:= ave(group,if(Mapped_FDS_FH_Append.Mail_st	<> '',100,0));
		Mail_zip_CountNonBlank						:= ave(group,if(Mapped_FDS_FH_Append.Mail_zip	<> '',100,0));
		
	end;
	
	dFH_Matches_fill_stats := table(Mapped_FDS_FH_Append(trim(rec_id) <> ''), layout_stat, few);
	
	//********************************************************************************************
	//*** -- Match rate stats by search criteria
	//********************************************************************************************
	//*** Full SSN Only match
	ded_FDS_FH_Append 							:= dedup(Mapped_FDS_FH_Append,record_id,all);
	
	countSearchCriteriaWithSSNOnly	:= count(SearchCriteria_SSN);
	countSSNOnly_nomatch						:= count(ded_FDS_FH_Append(length(trim(SSN)) = 9 and
																														 trim(name) = '' and
																														 trim(address) = '' and
																														 trim(city) = '' and 
																														 trim(state) = '' and trim(rec_id) = ''));
	
	SSNOnlyMatchrate := if((countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNOnly - countSSNOnly_nomatch) / (real8)countSearchCriteriaWithSSNOnly * 100.0,0);
	
	//*** Full SSN and Name match
	countSearchCriteriaWithSSNName 	:= count(SearchCriteria_SSNName);
	countSSNName_nomatch						:= count(ded_FDS_FH_Append(length(trim(SSN,left,right)) = 9 and
																														 trim(name,left,right) <> '' and 
																														 trim(rec_id) = ''));

	SSNNameMatchrate := if((countSearchCriteriaWithSSNName - countSSNName_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithSSNName - countSSNName_nomatch) / (real8)countSearchCriteriaWithSSNName * 100.0,0);
	
	//*** Partial SSN and Name match
	countSearchCriteriaWithPSSNName := count(SearchCriteria_pSSNName);
	countPSSNName_nomatch						:= count(ded_FDS_FH_Append(length(trim(SSN,left,right)) = 4 and
																														 trim(name,left,right) <> '' and 
																														 trim(rec_id) = ''));

	PSSNNameMatchrate := if((countSearchCriteriaWithPSSNName - countPSSNName_nomatch) <> 0, 
												 (real8)(countSearchCriteriaWithPSSNName - countPSSNName_nomatch) / (real8)countSearchCriteriaWithPSSNName * 100.0,0);
	
	//*** Name and Address match 
	countSearchCriteriaWithNameAddr	:= count(SearchCriteria_did + SearchCriteria_nameAddr);
	countNameAddr_nomatch						:= count(ded_FDS_FH_Append(trim(name) <> '' and
																														 trim(address) <> '' and
																														 trim(city) <> '' and
																														 trim(state) <> '' and
																														 rec_id = ''));

	NameAddrMatchrate := if((countSearchCriteriaWithNameAddr - countNameAddr_nomatch) <> 0, 
													(real8)(countSearchCriteriaWithNameAddr - countNameAddr_nomatch) / (real8)countSearchCriteriaWithNameAddr * 100.0,0);

	//*** Name and state match 
	countSearchCriteriaWithNameSt	:= count(SearchCriteria_NameSt);
	countNameSt_nomatch						:= count(ded_FDS_FH_Append(trim(name) <> '' and
																													 trim(state) <> '' and
																													 trim(address) = '' and
																													 trim(city) = '' and
																													 rec_id = ''));

	NameStMatchrate := if((countSearchCriteriaWithNameSt - countNameSt_nomatch) <> 0, 
												(real8)(countSearchCriteriaWithNameSt - countNameSt_nomatch) / (real8)countSearchCriteriaWithNameSt * 100.0,0);

	
	//*** Name and Zip match 
	countSearchCriteriaWithNameZip	:= count(SearchCriteria_NameZip + SearchCriteria_NameZipDid);
	countNameZip_nomatch						:= count(ded_FDS_FH_Append(trim(Name,left,right) <> '' and 
																														 trim(zip_code,left,right)  <> '' and 
																														 trim(state,left,right) = '' and
																														 trim(City,left,right) = '' and
																														 rec_id = ''));

	NameZipMatchrate := if((countSearchCriteriaWithNameZip - countNameZip_nomatch) <> 0, 
												(real8)(countSearchCriteriaWithNameZip - countNameZip_nomatch) / (real8)countSearchCriteriaWithNameZip * 100.0,0);


	//*** Address Only match 
	countSearchCriteriaWithAddrOnly	:= count(SearchCriteria_Addr_Only);
	countAddrOnly_nomatch						:= count(ded_FDS_FH_Append(trim(Name) = '' and
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
	countPhone_nomatch						:= count(ded_FDS_FH_Append(trim(Phone_number) <> '' and rec_id = ''));
	
	PhoneMatchrate := if((countSearchCriteriaWithPhone - countPhone_nomatch) <> 0,
											 (real8)(countSearchCriteriaWithPhone - countPhone_nomatch) / (real8)countSearchCriteriaWithPhone * 100.0,0);


	
	return sequential(
							output('FDS Hunting Fishing Append Results Follow'		,named('_'														))
						 //,output(sort(FH_NameZipDid_matched_recs,(integer)rec_id),named('ZipDid_matches'))
						 ,output(sort(fh_all_matches,(integer)rec_id),named('All_FH_matches'),all)
						 ,output(sort(ded_fh_all_matches,(integer)rec_id),named('ded_All_FH_matches'),all)						 
						 ,output(FDS_FH_Append_Out,,'~thor_data400::out::FDS_Test::Hunting_fishing::Append',csv(separator(pSeparator)),overwrite)
						 ,output(dFH_Matches_fill_stats						,named('Appended_fields_fill_Rates'		))
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
