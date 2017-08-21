import lib_date;

EXPORT Map_LIDB_Reference_Main(string version) := function

	//Prep LIDB Response File
	compNameRespLayout := record
		PhonesInfo.Layout_common.lidbRespRecvd;
		unsigned8 dt_first_reported;
		unsigned8	dt_last_reported;
		string 	  tempName;
	end;

	compNameRespLayout fixN(PhonesInfo.Layout_common.lidbRespRecvd l):= transform		
		self.dt_first_reported	:= (integer)version;	
		self.dt_last_reported		:= (integer)version;	
		self.tempName 					:= PhonesInfo._Functions.fn_standardName(l.carrier_name);
		self 										:= l;
	end;
	
	fixCurrCarrier 						:= project(PhonesInfo.File_LIDB.Response_Received, fixN(left));
	reformPrev								:= project(PhonesInfo.File_LIDB.Response_Processed, 
																				transform({compNameRespLayout},
																										self.tempName := PhonesInfo._Functions.fn_standardName(left.carrier_name);
																										self:=left));
		
	//Concat the Latest LIDB Response File to the Previous 
	concatCurrFiles						:= fixCurrCarrier + reformPrev;
	srt_carrier 							:= sort(distribute(concatCurrFiles, hash(tempName)), tempName, account_owner, local);
	
	//Prep Carrier Source File w/ Service & Line Types
	compNameLayout := record
		PhonesInfo.Layout_common.sourceRefBase;
		string tempName;
	end;
			
	compNameLayout fixCN(PhonesInfo.File_Source_Reference.Main l):= transform		
		self.tempName 					:= PhonesInfo._Functions.fn_standardName(l.name);
		self 										:= l;
	end;
	
	fixName 									:= project(PhonesInfo.File_Source_Reference.Main(is_current=TRUE), fixCN(left));
	srt_name									:= sort(distribute(fixName, hash(tempName)), tempName, ocn, local);

///////////////////////////////////////////////////////////////////////////////
//MAY NEED TO UPDATE PhonesInfo.Layout_common.lidbRespProcess WITH NEW FIELDS//
///////////////////////////////////////////////////////////////////////////////
	
	//Join the LIDB Response File and the Carrier Reference File to Populate Service and Line Types
	PhonesInfo.Layout_common.lidbRespProcess appF(srt_carrier l, srt_name r):= transform
		self.serv								:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname	:= r.operator_full_name;
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;
		self 										:= l;
	end;
	
	joinFields 								:= join(srt_carrier, srt_name,
																		left.tempName = right.tempName and
																		left.account_owner = right.ocn,
																		appF(left, right), left outer, nosort, local);
	
	dedupFields								:= dedup(sort(distribute(joinFields, hash(carrier_name)), record, local), record, local);
	
	//BUG 203495. Add account owner to the sort criteria because it is in the rollup criteria list.
	srt_concatFiles						:= sort(distribute(dedupFields, hash(phone)), phone, reference_id, PhonesInfo._Functions.fn_standardName(carrier_name), account_owner,serv, line, -dt_last_reported, local);

	PhonesInfo.Layout_common.lidbRespProcess rollupDate(srt_concatFiles l, srt_concatFiles r) := transform
			
		minDate		:= lib_date.earliestdate((integer) l.dt_first_reported, (integer) r.dt_first_reported);
		maxDate		:= lib_date.latestdate((integer)l.dt_last_reported, (integer)r.dt_last_reported);
			
		self.dt_first_reported					:= minDate;
		self.dt_last_reported 					:= maxDate;
		self 														:= l;
	end;

	applyDates								:= rollup(srt_concatFiles, 
																			left.phone = right.phone and
																			left.reference_id = right.reference_id and
																			PhonesInfo._Functions.fn_standardName(left.carrier_name)=PhonesInfo._Functions.fn_standardName(right.carrier_name) and
																			left.account_owner = right.account_owner and
																			left.serv = right.serv and
																			left.line = right.line,
																			rollupDate(left, right), local);	
		
	allFiles									:= applyDates;	
	
	return allFiles;	
	
end;