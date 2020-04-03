IMPORT _control, MDR, DeltabaseGateway, dx_PhonesInfo, Lib_date, Std, Ut;

//DF-24397: Create Dx-Prefixed Keys
//DF-26977: Remove LIDB Carrier Info Append Process (LIDB is historical)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Map Phone Base Files to Phone Type Layout - Append Serv/Line/Carrier Names from Carrier Reference Table///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	dsICPort					:= PhonesInfo.File_iConectiv.Main(transaction_code<>'PD');																																										//Source = PK; iConectiv Ported Phone Base File
	srcLidb						:= PhonesInfo.File_LIDB.Response_Processed_CR_Append_PType;																																													//Historical LIDB File w/ Carrier Reference Info Appended			
	srcLidbDelt				:= DeltabaseGateway.File_Deltabase_Gateway.Historic_LIDB_Results_CR_Append_PType;																																		//Historical LIDB Gateway File w/ Carrier Reference Info Appended						
	dsL6Phones				:= project(PhonesInfo.File_Lerg.Lerg6UpdPhone(account_owner<>'' and serv<>'' and line<>''), dx_PhonesInfo.Layouts.Phones_Type_Main);	
	dsCarrRef					:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);																																																			//Carrier Reference Base File

	//////////////////////////////////////////////	
	//iConectiv Ported Phone File - Join by SPID//
	//////////////////////////////////////////////
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	sortiCon					:= sort(distribute(dsICPort, hash(spid)), spid, local);
	sortSPID					:= sort(distribute(dsCarrRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
	
	tempLayout := record
		dx_PhonesInfo.Layouts.Phones_Type_Main;
		string temp_vfreported;
		string temp_vlreported;
	end;	
	
	tempLayout addiConSL(sortiCon l, sortSPID r):= transform
		self.temp_vfreported						:= ((string)l.vendor_first_reported_dt) + l.vendor_first_reported_time;
		self.temp_vlreported						:= ((string)l.vendor_last_reported_dt) + l.vendor_last_reported_time;
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
		
	tempLayout addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
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
	
	tempLayout addiRemTr(srtAddiCRem l, srtRefRem r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 														:= l;
	end;			
	
	addiCRem 					:= join(srtAddiCRem, srtRefRem,
														left.spid = right.spid,
														addiRemTr(left, right), left outer, local, keep(1));
	
	//Concat Appended OCN/Carrier Name Results
	ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);

	//Rollup Same Port Phone Type Records
	srtDdiConAddFields:= sort(distribute(ddiConAddFields, hash(phone)), phone, carrier_name, account_owner, serv, line, high_risk_indicator, prepaid, -vendor_last_reported_dt, local);

	tempLayout rollupiConDate(srtDdiConAddFields l, srtDdiConAddFields r) := transform
			
		minDate		:= lib_date.earliestdate((integer)l.temp_vfreported, (integer)r.temp_vfreported);
		maxDate		:= lib_date.latestdate((integer)l.temp_vlreported, (integer)r.temp_vlreported);
		
		self.temp_vfreported						:= (string)minDate;
		self.temp_vlreported						:= (string)maxDate;
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self 														:= l;
	end;

	rollupiConDates	:= rollup(srtDdiConAddFields, 
																	left.phone = right.phone and
																	left.carrier_name = right.carrier_name and
																	left.account_owner = right.account_owner and
																	left.serv = right.serv and
																	left.line = right.line and
																	left.high_risk_indicator = right.high_risk_indicator and
																	left.prepaid = right.prepaid,
																	rollupiConDate(left, right), local);
	
	//Fix Vendor First/Last Reported Date/Time
	dx_PhonesInfo.Layouts.Phones_Type_Main dtTr(rollupiConDates l):= transform
		self.vendor_first_reported_dt		:= (integer)(l.temp_vfreported[1..8]);
		self.vendor_first_reported_time := l.temp_vfreported[9..];
		self.vendor_last_reported_dt 		:= (integer)(l.temp_vlreported[1..8]);
		self.vendor_last_reported_time	:= l.temp_vlreported[9..];
		self														:= l;
	end;
	
	applyiConDates 				:= project(rollupiConDates, dtTr(left));
																	
	/////////////////////////////////////////////////////////	
	//LIDB File - Join by Account Owner & Carrier Name///////
	/////////////////////////////////////////////////////////

	//Concat LIDB Records
	concatLIDB				:= srcLidb + srcLidbDelt;
	
	dx_PhonesInfo.Layouts.Phones_Type_Main fixLIDB(concatLIDB l):= transform
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self														:= l;
	end;
	
	reformatLIDB			:= project(concatLIDB, fixLIDB(left));	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Concat All Records//////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	allFiles					:= applyiConDates + reformatLIDB + dsL6Phones;	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Append Global_SID///////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////	
	
	//Add Global_SID 
  addGlobalSID      := MDR.macGetGlobalSID(allFiles,'PhonesMetadata_Virtual','','global_sid'); //CCPA-799
		
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Append Record_SID///////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////	
	
	//Add Record_SID to All Records
	dx_PhonesInfo.Layouts.Phones_Type_Main trID(addGlobalSID l):= transform
		self.record_sid := hash64(l.phone + l.source + l.account_owner + l.carrier_name + l.vendor_first_reported_dt + l.vendor_first_reported_time + l.spid + l.operator_fullname + l.serv + l.line + l.high_risk_indicator + l.prepaid + l.reference_id) + (integer)l.phone;	
		//self.serv				:= if(l.serv='', '3', l.serv); //DF-27012
		//self.line				:= if(l.line='', '3', l.line); //DF-27012	
		self 						:= l;
	end;
	
	idAll							:= project(addGlobalSID, trID(left));

EXPORT Map_Phones_Type_Main := idAll;