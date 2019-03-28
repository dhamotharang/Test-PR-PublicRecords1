IMPORT _control, Gong, Mdr, PhonesPlus_v2, Ut;

	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	//DF-24394: Add dt_first_reported/dt_last_reported to the L6 records for consistency (historical LIDB format)

EXPORT Map_L6_OCN_Serv_Line_Append(string version) := FUNCTION
	
	//Append OCNs to New Phones / Phones w/ Changed DIDs, Using the Lerg6
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 1: Determine New Phones / Phones with Changed DIDs//////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////	
	dsL6							:= PhonesInfo.Key_Phones_Lerg6;					//Lerg6
	dsNewPhone				:= PhonesInfo.File_Lerg.Lerg6NewPhone;	//New Phones/Phones with Changed DIDs or Phone Refresh

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 2: Run New Phone Records Through Lerg6 by Phone[1..7]///////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	srtL6							:= sort(distribute(dsL6, hash(npa+nxx+block_id)), npa, nxx, block_id, local);	
	srtNewPhone				:= sort(distribute(dsNewPhone, hash(phone[1..7])), phone[1..7], local);

	//Reformatting to PMT Layout
	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appTr(srtNewPhone l, srtL6 r):= transform
		self.dt_first_reported					:= 0;
		self.dt_last_reported						:= 0;
		self.phonetype									:= '';
		self.reply_code									:= '';
		self.local_routing_number				:= '';
		self.account_owner							:= r.ocn;
		self.carrier_name								:= '';
		self.carrier_category						:= '';
		self.local_area_transport_area	:= '';
		self.point_code									:= ''; 
		self.country_code								:= '';
		self.dial_type									:= '';
		self.routing_code								:= '';
		self.porting_dt									:= 0;
		self.porting_time								:= '';
		self.country_abbr								:= '';	
		self.vendor_first_reported_dt 	:= 0;
		self.vendor_first_reported_time := '';	
		self.vendor_last_reported_dt 		:= 0;
		self.vendor_last_reported_time	:= '';
		self.port_start_dt							:= 0;
		self.port_start_time						:= '';
		self.port_end_dt								:= 0;
		self.port_end_time							:= '';
		self.remove_port_dt							:= 0;
		self.is_ported									:= false;
		self.serv												:= '';
		self.line												:= '';
		self.spid												:= '';
		self.operator_fullname					:= '';
		self.number_in_service					:= '';
		self.high_risk_indicator				:= '';
		self.prepaid										:= '';
		self.phone_swap									:= '';
		self.swap_start_dt							:= 0;
		self.swap_start_time						:= '';
		self.swap_end_dt								:= 0;
		self.swap_end_time							:= '';
		self.deact_code									:= '';
		self.deact_start_dt							:= 0;
		self.deact_start_time						:= '';
		self.deact_end_dt								:= 0;
		self.deact_end_time							:= '';
		self.react_start_dt							:= 0;
		self.react_start_time						:= '';
		self.react_end_dt								:= 0;
		self.react_end_time							:= '';
		self.is_deact										:= '';
		self.is_react										:= '';
		self.call_forward_dt						:= 0;
		self.caller_id									:= '';
		self.global_sid									:= 0;		//CCPA Requirement
		self.record_sid									:= 0;		//CCPA Requirement
		self.source											:= if(r.ocn<>'', mdr.sourceTools.src_phones_lerg6, '');
		self														:= l;
	end;

	appendFile 				:= join(srtNewPhone, srtL6,
														left.phone[1..7] = right.npa + right.nxx + right.block_id,
														appTr(left, right), left outer, local);

	ddAppendFile 			:= dedup(sort(distribute(appendFile, hash(phone)), record, local), record, local);

	//Append Ocn from Lerg6 - No Match
	matchLerg6Rec			:= ddAppendFile(account_owner<>'');
	noMatchLerg6Rec		:= ddAppendFile(account_owner='');

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 3: Run Remaining New Phone Records Through Lerg6 w/ Block_ID = A by Phone[1..6]/////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	srtBlock					:= sort(distribute(dsL6(block_id='A'), hash(npa+nxx)), npa+nxx, local);
	srtNoLerg6Match		:= sort(distribute(noMatchLerg6Rec, hash(phone[1..6])), phone[1..6], local);

	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appTr2(srtNoLerg6Match l, srtBlock r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name 							:= '';
		self.serv												:= '';
		self.line												:= '';
		self.source											:= if(r.ocn<>'', mdr.sourceTools.src_phones_lerg6, '');
		self														:= l;
	end;

	appendFile2 			:= join(srtNoLerg6Match, srtBlock,
														left.phone[1..6] = right.npa + right.nxx,
														appTr2(left, right), left outer, local);

	ddAppendFile2 		:= dedup(sort(distribute(appendFile2, hash(phone)), record, local), record, local);

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 4: Concat OCN Append Results////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	concatApp					:= matchLerg6Rec + ddAppendFile2;
	concatAppend 			:= dedup(sort(distribute(concatApp, hash(account_owner)), account_owner, local), record, local);

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 5: Join Lerg6 Sourced Records to Carrier Reference//////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	ds_lerg6Append 		:= concatAppend(source=mdr.sourceTools.src_phones_lerg6 and account_owner<>'');
	ds_remain					:= concatAppend(source<>mdr.sourceTools.src_phones_lerg6);

	srt_lerg6Append 	:= sort(distribute(ds_lerg6Append, hash(account_owner)), account_owner, local);

		//Carrier Reference File
		cr							:= PhonesInfo.File_Source_Reference.Main;

		cr formTr(cr l):= transform
			self.ocn 											:= PhonesInfo._Functions.fn_standardName(l.ocn); //Clean-up Field
			self 													:= l;
		end;

		fixCr						:= project(cr, formTr(left));

	//Pull Lerg Records First (Latest Records)
	srt_carrierRef		:= sort(distribute(fixCr(data_type<>'' and contact_function='' and override_file<>'Y'), hash(ocn)), ocn, -dt_last_reported, local);

	//Append Carrier Reference Info
	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appCrTr(srt_lerg6Append l, srt_carrierRef r):= transform
		self.dt_first_reported 					:= (integer)version;
		self.dt_last_reported 					:= (integer)version;
		self.vendor_first_reported_dt 	:= (integer)version;
		self.vendor_last_reported_dt 		:= (integer)version;
		self.carrier_name 							:= r.carrier_name;
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= r.operator_full_name;
		self														:= l;
	end;

	appendCrFile 			:= join(srt_lerg6Append, srt_carrierRef,
														left.account_owner[1..4] = right.ocn[1..4],
														appCrTr(left, right), left outer, local, keep(1));

	ddAppendCrFile 		:= dedup(sort(distribute(appendCrFile, hash(phone)), record, local), record, local);

	//Pull Remaining Carrier Ref Records
	carrRefApp				:= ddAppendCrFile(account_owner<>'' and serv<>'' and line<>'');

	remainRec					:= sort(distribute(ddAppendCrFile(account_owner<>'' and serv='' and line=''), hash(account_owner)), account_owner, local);
	srt_carrierRef2		:= sort(distribute(fixCr(data_type=''), hash(ocn)), ocn, carrier_name, serv, line, -dt_last_reported, local);

	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appCrTr2(remainRec l, srt_carrierRef2 r):= transform
		self.dt_first_reported 					:= (integer)version;
		self.dt_last_reported 					:= (integer)version;
		self.vendor_first_reported_dt 	:= (integer)version;
		self.vendor_last_reported_dt 		:= (integer)version;
		self.carrier_name 							:= r.carrier_name;
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= r.operator_full_name;
		self														:= l;
	end;

	appendCrFile2 		:= join(remainRec, srt_carrierRef2,
													left.account_owner[1..4] = right.ocn[1..4],
													appCrTr2(left, right), left outer, local, keep(1));

	ddAppendCrFile2		:= dedup(sort(distribute(appendCrFile2, hash(phone)), record, local), record, local);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 6: Concat All Results///////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	currL6OcnApp 			:= carrRefApp 								+ ddAppendCrFile2 							+ ds_remain;
									   //first pass:ocn+serv+line		+ second pass:ocn+serv+line 		+ no lerg6 match
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 7: Rollup New + Existing Records////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	prevL6OcnApp			:= PhonesInfo.File_Lerg.Lerg6UpdPhone; //Previous L6 Results
	concatCurrPrevL6	:= currL6OcnApp + prevL6OcnApp;				 //Concat: Current + Previous L6 Results
	
	srtConcatCurrPrev	:= sort(distribute(concatCurrPrevL6, hash(phone)), phone, reference_id, account_owner, PhonesInfo._Functions.fn_standardName(carrier_name), spid, serv, line, -vendor_last_reported_dt, local);

	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep rollDt(srtConcatCurrPrev l, srtConcatCurrPrev r) := transform
			
		minDate1	:= ut.min2((integer) l.dt_first_reported, (integer) r.dt_first_reported);
		maxDate1	:= max((integer)l.dt_last_reported, (integer)r.dt_last_reported);
		
		minDate2	:= ut.min2((integer) l.vendor_first_reported_dt, (integer) r.vendor_first_reported_dt);
		maxDate2	:= max((integer)l.vendor_last_reported_dt, (integer)r.vendor_last_reported_dt);
			
		self.dt_first_reported					:= minDate1;	
		self.vendor_first_reported_dt		:= minDate2;
		self.dt_last_reported						:= maxDate1;
		self.vendor_last_reported_dt 		:= maxDate2;
		self 														:= l;
	end;

	applyDates				:= rollup(srtConcatCurrPrev, 
															left.phone = right.phone and
															left.reference_id = right.reference_id and
															left.account_owner = right.account_owner and
															PhonesInfo._Functions.fn_standardName(left.carrier_name)=PhonesInfo._Functions.fn_standardName(right.carrier_name) and
															left.spid = right.spid and
															left.serv = right.serv and
															left.line = right.line,
															rollDt(left, right), local);	
	
	RETURN applyDates;
	
END;	
