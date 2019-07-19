import address, autokey, AutokeyB, AutokeyB2, 
			Autokey_Batch, AutoKeyI, AutoStandardI, 
			debt_settlement, doxie, ut, NID;

export PAC_Indicator_BatchService_Records (
	DATASET(BatchServices.PAC_Indicator_BatchService_Layouts.rec_batch_input) indata) := function

	indata_clean := BatchServices.PAC_Indicator_BatchService_Functions.clean_batch(indata);

	ak_keyname := '~thor_data400::key::Debt_Settlement::qa::autokey::';
	ak_dataset := dataset([], Debt_Settlement.Layouts.Keybuild);
 
	batch_layout  := Autokey_batch.Layouts.rec_inBatchMaster;
	joined_layout := BatchServices.PAC_Indicator_BatchService_Layouts.joined_layout; 
	out_layout    := BatchServices.PAC_Indicator_BatchService_Layouts.out_layout;
	////////////////////////////////////////////////////////////////////////////////////
	/* USING AUTOKEY_BATCH.GET_FIDS*/
	///////////////////////////////////////////////////////////////////////////////////
	ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export skip_set        := ['C', 'F'];//skip all indiv fetch and FEIN;	
	END;

	ds_fids := Autokey_batch.get_fids(indata_clean, ak_keyname, ak_config_data);

	/////////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////////
	/* USING MAC_GET_PAYLOAD TO JOIN TO PAYLOAD*/
	///////////////////////////////////////////////////////////////////////////////
	AutokeyB2.mac_get_payload(ds_fids, ak_keyname, ak_dataset, auto_recs, bdid, bdid, 'BC');
	
	autok_recs := project(sort(auto_recs, acctno, bdid, 
															-dt_vendor_last_reported, -dt_vendor_first_reported, 
															if(matchcode = 'AcQ', 1, 2)), joined_layout);
	
	/////////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////////
	/* OTUPUT CORRECT FIELDS FOR FINAL RESULTS*/
	///////////////////////////////////////////////////////////////////////////////
	
	joined_layout rollup_trans(joined_layout L, joined_layout R) := transform	
			self.dt_vendor_first_reported	:= if(L.dt_vendor_first_reported 	<>0, L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			self.dt_vendor_last_reported	:= if(L.dt_vendor_last_reported 	<>0, L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			
			self.rawfields.avdanumber			:= if(L.rawfields.avdanumber <> '', L.rawfields.avdanumber, R.rawfields.avdanumber);
			self.rawfields.attorneyname		:= if(L.rawfields.attorneyname <> '', L.rawfields.attorneyname, R.rawfields.attorneyname);
			self.rawfields.address2				:= if(L.rawfields.address2 <> '', L.rawfields.address2, R.rawfields.address2);
			
			self.clean_address.v_city_name:= if(L.clean_address.v_city_name <> '', L.clean_address.v_city_name, R.clean_address.v_city_name);
		
			self.clean_phones.phone				:= if(L.clean_phones.phone <> '', L.clean_phones.phone, R.clean_phones.phone);
			
			self 													:= L;
	end;
	rec_roll := rollup(autok_recs, left.acctno = right.acctno
																			and (left.bdid = right.bdid),
																			rollup_trans(left, right));
	
	//Calculate penalties to sort records and keep best for final results
	pen_rec_layout := record
		unsigned2 penalty_;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		out_layout;
	end;
	
	pen_rec_layout outlay(joined_layout L, 
													batch_layout R) := transform
		isAddressMatch := R.prim_name <> ''
										and L.clean_address.prim_range = R.prim_range
										and L.clean_address.predir = R.predir
										and L.clean_address.postdir = R.postdir
										and L.clean_address.prim_name = R.prim_name
										and if(R.sec_range <> '', L.clean_address.sec_range = R.sec_range, true)
										and ((L.clean_address.p_city_name = R.p_city_name
														and L.clean_address.st = R.st)
													or L.clean_address.zip = R.z5);
		isPhoneMatch := (L.rawfields.phone = R.homephone 
										or L.clean_phones.phone = R.homephone)
										AND R.homephone <> '';
		isCompleteMatch := isPhoneMatch and isAddressMatch;
		isMatch					:= isPhoneMatch or isAddressMatch;	
		
		self.penalty_ := if(isMatch, BatchServices.PAC_Indicator_BatchService_Functions.penalt_func_calculate(R, L), 0);
		self.dt_vendor_last_reported  := L.dt_vendor_last_reported;
		self.dt_vendor_first_reported := L.dt_vendor_first_reported;
		self.acctno := R.acctno;
		self.PAC_Indicator_Flag := if(isMatch, 'Y', 'N');
		self.PAC_Match_Code     := if(isMatch, if(isCompleteMatch, 'PA',
																																		if(isPhoneMatch, 'P',
																																		'A')),
																								'');
		
		self.PAC_Contact_Phone := if(isMatch, L.rawfields.phone, '');
		self.PAC_Contact_Name := if(isMatch, 
																if(L.rawfields.businessname <> '', 
																					L.rawfields.businessname,
																					L.rawfields.attorneyname),
																'');
	end;
	
	res_recs := join(rec_roll,
									indata_clean, 
									left.acctno = right.acctno, 
									outlay(left, right), 
									RIGHT OUTER, limit(1000, skip));
	
	
	results := dedup(project(sort(res_recs, acctno, penalty_, 
																-dt_vendor_last_reported, -dt_vendor_first_reported,
																if(PAC_Match_Code = 'PA', 1, 2))
																,out_layout)
																, acctno, LEFT); 
	
	// DEBUG															
	// output(indata_clean, named('indata_clean'));
	// output(ds_fids, named('Autokey_batch_get_fids'));	
	// output(autok_recs, named('autok_recs')); 
	// output(rec_roll, named('rec_roll'));
	// output(res_recs, named('res_recs'));
	
	return results;
	/////////////////////////////////////////////////////////////////////////////////
	
end;