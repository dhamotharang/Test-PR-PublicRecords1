IMPORT dx_PhonesInfo, lib_date;

////////////////////////////////////////////////////////////////////
//Apply Carrier Reference Table Updates to Historical LIDB Records//
////////////////////////////////////////////////////////////////////
  
	//Prep LIDB Response File
	compNameRespLayout := record
		PhonesInfo.Layout_Common.temp_portedMetadata_Main;
		string 	  tempName;
	end;
	
	concatCurrFiles						:= project(PhonesInfo.File_LIDB.Response_Processed_CR_Append, 
																				transform({compNameRespLayout},
																										self.tempName 			:= PhonesInfo._Functions.fn_standardName(left.carrier_name);
																										self.account_owner 	:= PhonesInfo._Functions.fn_standardName(left.account_owner);
																										self:=left));	
							
	srt_carrier 							:= sort(distribute(concatCurrFiles, hash(tempName)), tempName, account_owner, local);	
	
	//Prep Carrier Source File
	compNameLayout := record
		dx_PhonesInfo.Layouts.sourceRefBase;
		string tempName;
	end;
	
	cr												:= project(PhonesInfo.File_Source_Reference.Main(is_current=TRUE),
																				transform({compNameLayout},
																										self.tempName 			:= PhonesInfo._Functions.fn_standardName(left.name);
																										self.ocn 						:= PhonesInfo._Functions.fn_standardName(left.ocn);
																										self:=left));	
																																														
	srt_name									:= sort(distribute(cr, hash(tempName)), tempName, ocn, local);
	
	//Join the LIDB Response File and the Carrier Reference File to Populate Service and Line Types
	
	//Join by Carrier Name and OCN
	PhonesInfo.Layout_Common.temp_portedMetadata_Main appF(srt_carrier l, srt_name r):= transform
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
																		appF(left, right), left outer, nosort, local, keep(1));
	
	dedupFields								:= dedup(sort(distribute(joinFields, hash(carrier_name)), record, local), record, local);
	
	//Join by OCN for Remaining Unmatched Records
	compRec										:= dedupFields(serv<>'');
	incompRec									:= dedupFields(serv='');
	
	srtIncompRec							:= sort(distribute(incompRec, hash(account_owner)), account_owner, serv, line, local);
	srtCarrRef								:= sort(distribute(cr, hash(ocn)), ocn, serv, line, local);
	
	PhonesInfo.Layout_Common.temp_portedMetadata_Main appF2(srtIncompRec l, srtCarrRef r):= transform
		self.serv								:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname	:= r.operator_full_name;
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;
		self 										:= l;
	end;
	
	joinFields2 							:= join(srtIncompRec, srtCarrRef,
																		left.account_owner = right.ocn,
																		appF2(left, right), left outer, nosort, local, keep(1));
	
	dedupFields2							:= dedup(sort(distribute(joinFields2, hash(account_owner)), record, local), record, local);
	
	concatRecs								:= compRec + dedupFields2;
	srt_concatFiles						:= sort(distribute(concatRecs, hash(phone)), phone, reference_id, PhonesInfo._Functions.fn_standardName(carrier_name), account_owner,serv, line, -dt_last_reported, local);

	PhonesInfo.Layout_Common.temp_portedMetadata_Main rollupDate(srt_concatFiles l, srt_concatFiles r) := transform
			
		minDate		:= lib_date.earliestdate((integer) l.dt_first_reported, (integer) r.dt_first_reported);
		maxDate		:= lib_date.latestdate((integer)l.dt_last_reported, (integer)r.dt_last_reported);
			
		self.dt_first_reported	:= minDate;
		self.dt_last_reported 	:= maxDate;
		self 										:= l;
	end;

	applyDates								:= rollup(srt_concatFiles, 
																			left.phone = right.phone and
																			left.reference_id = right.reference_id and
																			PhonesInfo._Functions.fn_standardName(left.carrier_name)=PhonesInfo._Functions.fn_standardName(right.carrier_name) and
																			left.account_owner = right.account_owner and
																			left.serv = right.serv and
																			left.line = right.line,
																			rollupDate(left, right), local);	

EXPORT Map_LIDB_Carrier_Reference_PMT_Update := applyDates;