IMPORT dx_PhonesInfo, lib_date;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Map Phone Base Files to Phone Type Layout - Append Serv/Line/Carrier Names from Carrier Reference Table///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////																																										//Source = PK; iConectiv Ported Phone Base File
	
	dsLIDB 						:= PhonesInfo.File_LIDB.Response_Processed;																																																						//Source = PB; LIDB - AT&T Gateway Base File
	dsCarrRef					:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);																																																							//Carrier Reference Base File
														
	/////////////////////////////////////////////////////////	
	//LIDB File - Join by Account Owner & Carrier Name///////
	/////////////////////////////////////////////////////////
	
	//Append Name Field to LIDB File
	nameLayout := record
		dx_PhonesInfo.Layouts.Phones_Type_Main;
		string 		name;
	end;
	
	nameLayout nameTr(dsLIDB l):= transform
		self.source											:= 'PB';
		self.vendor_first_reported_dt		:= l.dt_first_reported;
		self.vendor_first_reported_time := '';
		self.vendor_last_reported_dt 		:= l.dt_last_reported;
		self.vendor_last_reported_time	:= '';
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self.name 											:= PhonesInfo._Functions.fn_standardName(l.carrier_name);
		self 														:= l;
	end;
	
	addLIDBName 			:= project(dsLIDB, nameTr(left));
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	sortLIDB					:= sort(distribute(addLIDBName, hash(account_owner, name)), account_owner, name, local);
	sortCRef					:= sort(distribute(dsCarrRef, hash(ocn, name)), ocn, name, local);
	
	//Join the LIDB Response File and the Carrier Reference File to Populate Service and Line Types
	nameLayout appF(sortLIDB l, sortCRef r):= transform
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= r.operator_full_name;
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;
		self 														:= l;
	end;
	
	joinFields 				:= join(sortLIDB, sortCRef,
														left.account_owner = right.ocn and 
														left.name = right.name,
														appF(left, right), left outer, nosort, local);
	
	dedupFields				:= dedup(sort(distribute(joinFields, hash(carrier_name)), record, local), record, local);
	
	////////////////////////////////////////////////////////////////	
	//LIDB File - Join by Account Owner for Remaining Records///////
	////////////////////////////////////////////////////////////////
	
	incompRec					:= dedupFields(serv='');
	compRec						:= dedupFields(serv<>'');
	
	sortLIDB2					:= sort(distribute(incompRec, hash(account_owner)), account_owner, serv, line, local);
	sortCRef2					:= sort(distribute(dsCarrRef, hash(ocn)), ocn, serv, line, local);
	
	joinFields2 			:= join(sortLIDB2, sortCRef2,
														left.account_owner = right.ocn,
														appF(left, right), left outer, nosort, local);
														
	dedupFields2			:= dedup(sort(distribute(joinFields2 , hash(carrier_name)), record, local), record, local);
	
	concatRec					:= compRec + dedupFields2;

	srt_concatFiles		:= sort(distribute(concatRec, hash(phone)), phone, reference_id, name, account_owner, serv, line, high_risk_indicator, prepaid, -vendor_last_reported_dt, local);

	nameLayout rollupDate(srt_concatFiles l, srt_concatFiles r) := transform
			
		minDate		:= lib_date.earliestdate((integer) l.vendor_first_reported_dt, (integer) r.vendor_first_reported_dt);
		maxDate		:= lib_date.latestdate((integer)l.vendor_last_reported_dt, (integer)r.vendor_last_reported_dt);
		
		self.vendor_first_reported_dt		:= minDate;
		self.vendor_last_reported_dt 		:= maxDate;
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self 														:= l;
	end;

	applyRollup				:= rollup(srt_concatFiles, 
															left.phone = right.phone and
															left.reference_id = right.reference_id and
															left.name = right.name and
															left.account_owner = right.account_owner and
															left.serv = right.serv and
															left.line = right.line and
															left.high_risk_indicator = right.high_risk_indicator and
															left.prepaid = right.prepaid,
															rollupDate(left, right), local);	
															
	applyDates				:= 	project(applyRollup, dx_PhonesInfo.Layouts.Phones_Type_Main);

EXPORT Map_LIDB_Carrier_Reference_PType_Update := applyDates;