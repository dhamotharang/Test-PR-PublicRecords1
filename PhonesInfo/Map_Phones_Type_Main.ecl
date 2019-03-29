IMPORT DeltabaseGateway, dx_PhonesInfo, Lib_date, Ut;

//DF-24397: Create Dx-Prefixed Keys

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Map Phone Base Files to Phone Type Layout - Append Serv/Line/Carrier Names from Carrier Reference Table///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	dsICPort		:= PhonesInfo.File_iConectiv.Main;																																																										//Source = PK; iConectiv Ported Phone Base File
	dsLIDB 			:= PhonesInfo.File_LIDB.Response_Processed;																																																						//Source = PB; LIDB - AT&T Gateway Base File
	dsLIDBDelt	:= DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base(source in ['ATT_DQ_IRS'] and stringlib.stringfind(device_mgmt_status, 'BAD', 1)=0); 	//Source = PB; Deltabase Gateway File (LIDB) - Pull Only Good Records
	dsL6Phones	:= project(PhonesInfo.File_Lerg.Lerg6UpdPhone(account_owner<>'' and serv<>'' and line<>''), dx_PhonesInfo.Layouts.Phones_Type_Main);	
	dsCarrRef		:= PhonesInfo.File_Source_Reference.Main;																																																							//Carrier Reference Base File

	//////////////////////////////////////////////	
	//iConectiv Ported Phone File - Join by SPID//
	//////////////////////////////////////////////
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	sortiCon					:= sort(distribute(dsICPort, hash(spid)), spid, local);
	sortSPID					:= sort(distribute(dsCarrRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
	
	dx_PhonesInfo.Layouts.Phones_Type_Main addiConSL(sortiCon l, sortSPID r):= transform
		self.reference_id								:= '';
		self.reply_code									:= '';
		self.local_routing_number				:= '';
		self.account_owner							:= '';
		self.carrier_category						:= '';
		self.local_area_transport_area 	:= '';
		self.point_code									:= '';
		self.serv 											:= r.serv;
		self.line												:= r.line;	
		self.operator_fullname 					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;		
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self 														:= l;
	end;
		
	addiConON 				:= join(sortiCon, sortSPID,
														left.spid = right.spid,
														addiConSL(left, right), left outer, local, keep(1));
	
	//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
	//There are a few instances where there are multiple ocns for a spid
	srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
	srtRefOFN_match		:= sort(distribute(dsCarrRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
		
	dx_PhonesInfo.Layouts.Phones_Type_Main addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 														:= l;
	end;
	
	addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
														left.spid = right.spid and
														PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
														addiCOFNTr(left, right), left outer, local, keep(1));
	
	//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
	srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
	srtRefRem					:= sort(distribute(dsCarrRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
	
	dx_PhonesInfo.Layouts.Phones_Type_Main addiRemTr(srtAddiCRem l, srtRefRem r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 														:= l;
	end;			
	
	addiCRem 					:= join(srtAddiCRem, srtRefRem,
														left.spid = right.spid,
														addiRemTr(left, right), left outer, local, keep(1));
	
	//Concat Appended OCN/Carrier Name Results
	ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);
	
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
	
	addLIDBName := project(dsLIDB, nameTr(left));
	
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
	
	srt_concatFiles		:= sort(distribute(dedupFields, hash(phone)), phone, reference_id, name, account_owner, serv, line, -vendor_last_reported_dt, local);

	nameLayout rollupDate(srt_concatFiles l, srt_concatFiles r) := transform
			
		minDate		:= lib_date.earliestdate((integer) l.vendor_first_reported_dt, (integer) r.vendor_first_reported_dt);
		maxDate		:= lib_date.latestdate((integer)l.vendor_last_reported_dt, (integer)r.vendor_last_reported_dt);
		
		self.vendor_first_reported_dt		:= minDate;
		self.vendor_last_reported_dt 		:= maxDate;
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self 														:= l;
	end;

	applyDates				:= rollup(srt_concatFiles, 
															left.phone = right.phone and
															left.reference_id = right.reference_id and
															left.name = right.name and
															left.account_owner = right.account_owner and
															left.serv = right.serv and
															left.line = right.line,
															rollupDate(left, right), local);	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//LIDB Deltabase Gateway File - Join by Ocn & Carrier_Name////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
		
	//Prep Returned LIDB Response File
	compNameRespLayout := record
		dsLIDBDelt;
		string    name;
	end;

	compNameRespLayout fixN(dsLIDBDelt l):= transform		
		self.name												:= PhonesInfo._Functions.fn_standardName(l.carrier_name);
		self 														:= l;
	end;
	
	fixCarrier 								:= project(dsLIDBDelt, fixN(left));
	sort_carrier 							:= sort(distribute(fixCarrier, hash(carrier_ocn, name)), carrier_ocn, name, local);		
	
	//Prep Carrier Reference File w/ Service & Line Types
	sort_name									:= sort(distribute(dsCarrRef, hash(ocn, name)), ocn, name, local);

	//Join the Returned LIDB Response File with the Source File to Populate Service and Line Types
	dx_PhonesInfo.Layouts.Phones_Type_Main appDeltaSL(sort_carrier l, sort_name r):= transform
		dt_added := stringlib.stringfilter(l.date_added, '0123456789')[1..14];	
		self.reference_id								:= (string)(hash32(l.submitted_phonenumber));
		self.source											:= 'PB';
		self.phone											:= l.submitted_phonenumber;
		self.local_routing_number				:= l.lrn;
		self.account_owner							:= l.carrier_ocn;
		self.local_area_transport_area	:= l.lata;
		self.vendor_first_reported_dt		:= if(dt_added not in ['','0'], 
																					(integer)dt_added[1..8],
																					(integer)l.date_file_loaded);
		self.vendor_first_reported_time	:= dt_added[9..];
		self.vendor_last_reported_dt		:= if(dt_added not in ['','0'],
																					(integer)dt_added[1..8],
																					(integer)l.date_file_loaded);
		self.vendor_last_reported_time	:= dt_added[9..];
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self 														:= l;
	end;

	joinLidbDeltFields:= join(sort_carrier, sort_name,
														left.carrier_ocn = right.ocn and
														left.name = right.name,
														appDeltaSL(left, right), left outer, local);
	
	srcLidbDelt				:= dedup(sort(distribute(joinLidbDeltFields, hash(carrier_name)), record, local), record, local);	
	
	//Concat LIDB Records
	concatLIDB				:= project(applyDates, dx_PhonesInfo.Layouts.Phones_Type_Main) + srcLidbDelt;	

	//////////////////////////////////////////////////////////////////////////////////////////	
	//Concat All Records//////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
	allFiles					:= ddiConAddFields + concatLIDB 	+ dsL6Phones;	
	                   //Ported 				 + LIDB Records + L6 Phones
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Append Record_SID//////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////	
	
	//Add Record_SID to All Records
	dx_PhonesInfo.Layouts.Phones_Type_Main trID(allFiles l):= transform
		self.record_sid := hash64(l.phone + l.source + l.account_owner + l.carrier_name + l.vendor_first_reported_dt + l.vendor_first_reported_time + l.spid + l.operator_fullname + l.serv + l.line + l.high_risk_indicator + l.prepaid + l.reference_id) + (integer)l.phone;	
		self 						:= l;
	end;
	
	idAll						:= project(allFiles, trID(left));

EXPORT Map_Phones_Type_Main := idAll;