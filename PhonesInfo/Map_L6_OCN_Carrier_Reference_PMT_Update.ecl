IMPORT dx_PhonesInfo, ut;

///////////////////////////////////////////////////////////////////////
//Apply Carrier Reference Table Updates to Lerg6 OCN Appended Records//
///////////////////////////////////////////////////////////////////////
		
	//Prep Lerg6 Update File
	srt_lerg6App			:= project(PhonesInfo.File_Lerg.Lerg6UpdPhone,
																transform({PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep},
																										self.account_owner 	:= PhonesInfo._Functions.fn_standardName(left.account_owner);
																										self:=left));	
		
	srt_lerg6Append		:= sort(distribute(srt_lerg6App, hash(account_owner)), account_owner, local);
		
	//Carrier Reference File	
	cr								:= project(PhonesInfo.File_Source_Reference.Main(is_current=TRUE),
																transform({dx_PhonesInfo.Layouts.sourceRefBase},
																										self.ocn 	:= PhonesInfo._Functions.fn_standardName(left.ocn);
																										self:=left));	

	//Pull Lerg1 Records First (Latest Records)
	srt_carrierRef		:= sort(distribute(cr(data_type<>'' and contact_function='' and override_file<>'Y'), hash(ocn)), ocn, -dt_last_reported, local);

	//Append Carrier Reference Info
	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appCrTr(srt_lerg6Append l, srt_carrierRef r):= transform
		self.carrier_name 							:= r.carrier_name;
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= r.operator_full_name;
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;			
		self														:= l;
	end;

	appendCrFile 			:= join(srt_lerg6Append, srt_carrierRef,
														left.account_owner[1..4] = right.ocn[1..4],
														appCrTr(left, right), left outer, local, keep(1));

	ddAppendCrFile 		:= dedup(sort(distribute(appendCrFile, hash(phone)), record, local), record, local);

	//Pull Remaining Carrier Ref Records
	carrRefApp				:= ddAppendCrFile(account_owner<>'' and serv<>'' and line<>'');

	remainRec					:= sort(distribute(ddAppendCrFile(account_owner<>'' and serv='' and line=''), hash(account_owner)), account_owner, local);
	srt_carrierRef2		:= sort(distribute(cr(data_type=''), hash(ocn)), ocn, carrier_name, serv, line, -dt_last_reported, local);

	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep appCrTr2(remainRec l, srt_carrierRef2 r):= transform
		self.carrier_name 							:= r.carrier_name;
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= r.operator_full_name;
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;			
		self														:= l;
	end;

	appendCrFile2 		:= join(remainRec, srt_carrierRef2,
													left.account_owner[1..4] = right.ocn[1..4],
													appCrTr2(left, right), left outer, local, keep(1));

	ddAppendCrFile2		:= dedup(sort(distribute(appendCrFile2, hash(phone)), record, local), record, local);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 6: Concat All Results///////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	currL6OcnApp 			:= carrRefApp + ddAppendCrFile2;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Step 7: Rollup Records///////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	srtAllRec					:= sort(distribute(currL6OcnApp, hash(phone)), phone, reference_id, account_owner, PhonesInfo._Functions.fn_standardName(carrier_name), spid, serv, line, -vendor_last_reported_dt, local);

	PhonesInfo.Layout_Lerg.lerg6UpdHist_Prep rollDt(srtAllRec l, srtAllRec r) := transform
			
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

	applyDates				:= rollup(srtAllRec, 
															left.phone = right.phone and
															left.reference_id = right.reference_id and
															left.account_owner = right.account_owner and
															PhonesInfo._Functions.fn_standardName(left.carrier_name)=PhonesInfo._Functions.fn_standardName(right.carrier_name) and
															left.spid = right.spid and
															left.serv = right.serv and
															left.line = right.line,
															rollDt(left, right), local);	

EXPORT Map_L6_OCN_Carrier_Reference_PMT_Update := applyDates;