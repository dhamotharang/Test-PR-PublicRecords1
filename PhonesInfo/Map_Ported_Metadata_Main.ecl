import DeltabaseGateway, MDR, PhonesPlus_V2, Ut;	
	
//DF-24394: Filtering for complete L6 records (account_owner/serv/line types populated)
//DF-26977: Remove TCPA & LIDB Carrier Info Append Process (TCPA was completely removed; LIDB is historical)
	
	portFile 					:= PhonesInfo.File_Phones.Ported_Current; 																																																						//Port File
	discFile					:= PhonesInfo.File_Deact.Main_Current2;																																																								//Deact File
	discGHFile				:= PhonesInfo.File_Deact_GH.Main_Current;																																																							//Deact Gong History File
	l6UpdPhone				:= project(PhonesInfo.File_Lerg.Lerg6UpdPhone(account_owner<>'' and serv<>'' and line<>''), PhonesInfo.Layout_Common.portedMetadata_Main);						//Lerg6 Updated Phones	
	srcRef						:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE); 																																														//Source Reference Table
	
	srcLidb						:= PhonesInfo.File_LIDB.Response_Processed_CR_Append;																																																	//Historical LIDB File w/ Carrier Reference Info Appended			
	srcLidbDelt				:= DeltabaseGateway.File_Deltabase_Gateway.Historic_LIDB_Results_CR_Append;																																						//Historical LIDB Gateway File w/ Carrier Reference Info Appended																																												
	
//////////////////////////////////////////////////////////////////////////////////////////
//Map Ported Base to Common Layout - Append Serv/Line/Carrier Names from Reference Table//
//////////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////	
	//iConectiv File - Join by SPID//
	/////////////////////////////////
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	sortSPID					:= sort(distribute(srcRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
	sortiCon					:= sort(distribute(portFile(source='PK'), hash(spid)), spid, local);
	
	PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
		self.serv 							:= r.serv;
		self.line								:= r.line;	
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;				
		self.is_ported					:= if(l.port_end_dt not in [0], false, l.is_ported);
		self 										:= l;
	end;
		
	addiConON 				:= join(sortiCon, sortSPID,
														left.spid = right.spid,
														addiConSL(left, right), left outer, local, keep(1));
	
	//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
	//There are a few instances where there are multiple ocns for a spid
	srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
	srtRefOFN_match		:= sort(distribute(srcRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
		
	PhonesInfo.Layout_Common.portedMetadata_Main addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
		self.account_owner			:= r.ocn;
		self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 										:= l;
	end;
	
	addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
														left.spid = right.spid and
														PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
														addiCOFNTr(left, right), left outer, local, keep(1));
	
	//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
	srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
	srtRefRem					:= sort(distribute(srcRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
	
	PhonesInfo.Layout_Common.portedMetadata_Main addiRemTr(srtAddiCRem l, srtRefRem r):= transform
		self.account_owner			:= r.ocn;
		self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 										:= l;
	end;	
	
	addiCRem 					:= join(srtAddiCRem, srtRefRem,
														left.spid = right.spid,
														addiRemTr(left, right), left outer, local, keep(1));
	
	//Concat Appended OCN/Carrier Name Results
	ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);
	
	cmnPort 					:= ddiConAddFields;

//////////////////////////////////////////////////////////////////////////////////////////	
//Map Disconnect Base to Common Layout////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Common.portedMetadata_Main trDisc(discFile l):= transform
		self.source 						:= 'PX';
		self.swap_start_dt			:= (unsigned)((string)l.swap_start_dt)[1..8];
		self.swap_start_time		:= ((string)l.swap_start_dt)[9..14];
		self.swap_end_dt				:= (integer)((string)l.swap_end_dt)[1..8];
		self.swap_end_time			:= ((string)l.swap_end_dt)[9..14];
		self.deact_start_dt			:= (integer)((string)l.deact_start_dt)[1..8];
		self.deact_start_time		:= ((string)l.deact_start_dt)[9..14];
		self.deact_end_dt				:= (integer)((string)l.deact_end_dt)[1..8];
		self.deact_end_time			:= ((string)l.deact_end_dt)[9..14];
		self.react_start_dt			:= (integer)((string)l.react_start_dt)[1..8];
		self.react_start_time		:= ((string)l.react_start_dt)[9..14];
		self.react_end_dt				:= (integer)((string)l.react_end_dt)[1..8];
		self.react_end_time			:= ((string)l.react_end_dt)[9..14];
		self 										:= l;
	end;
	
	dsDisc 						:= project(discFile, trDisc(left));	
	
	//Append Carrier Info to Deact Files from LIDB - Join by Phone & Carrier_Name
	sortDisc 					:= sort(distribute(dsDisc, hash(phone)), phone, -vendor_last_reported_dt, carrier_name, local);
	sortLidb					:= sort(distribute(srcLidb+srcLidbDelt, hash(phone)), phone, -vendor_last_reported_dt, src, local);//DF-22076
	
	PhonesInfo.Layout_Common.portedMetadata_Main addDiscSL(sortDisc l, sortLidb r):= transform
		self.serv 							:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_fullname);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;	
		self 										:= l;
	end;

	addLidbDiscFields := join(sortDisc, sortLidb,
														trim(left.phone, left, right) = trim(right.phone, left, right) and 
														trim(left.carrier_name, left, right) = trim(right.src, left, right),
														addDiscSL(left, right), left outer, local, keep(1));
														
	cmnDisc 					:= dedup(sort(distribute(addLidbDiscFields, hash(phone)), record, local), record, local);

//////////////////////////////////////////////////////////////////////////////////////////
//Map Disconnect Gong History Base to Common Layout///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Common.portedMetadata_Main trdiscGH(discGHFile l):= transform
		self.source 						:= 'PG';
		self 										:= l;
	end;
	
	dsdiscGH 					:= project(discGHFile, trdiscGH(left));	
	
	//Append Carrier Info to Gong History Deact Files from LIDB - Join by Phone 
	sortdiscGH 				:= sort(distribute(dsdiscGH, hash(phone)), phone, -vendor_last_reported_dt, local);
	
	PhonesInfo.Layout_Common.portedMetadata_Main adddiscGHSL(sortdiscGH l, sortLidb r):= transform
		self.serv 							:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_fullname);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;	
		self 										:= l;
	end;

	addLidbdiscGHFields:= join(sortdiscGH, sortLidb,
														 trim(left.phone, left, right) = trim(right.phone, left, right),
														 adddiscGHSL(left, right), left outer, local, keep(1));
														
	cmndiscGH 				:= dedup(sort(distribute(addLidbdiscGHFields, hash(phone)), record, local), record, local);

//////////////////////////////////////////////////////////////////////////////////////////
//Map LIDB, LIDB Deltabase Gateway, & Lerg6 Updated Base Files to Common Layout///////////
//////////////////////////////////////////////////////////////////////////////////////////
	
	cmnLidb						:= project(srcLidb, 		PhonesInfo.Layout_Common.portedMetadata_Main);
	cmnLidbDelt				:= project(srcLidbDelt, PhonesInfo.Layout_Common.portedMetadata_Main);
	cmnL6UpdPh				:= project(l6UpdPhone, 	PhonesInfo.Layout_Common.portedMetadata_Main);
	
//////////////////////////////////////////////////////////////////////////////////////////
//Concat Reformatted Files////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
	concatC 					:= cmnPort + cmnLidb + cmnDisc + cmndiscGH + cmnLidbDelt + cmnL6UpdPh;
	
	//Set Blank Serv/Line Types to "UNKNOWN"
	concatC addSL(concatC l):= transform
		self.serv								:= if(l.serv='', '3', l.serv);
		self.line								:= if(l.line='', '3', l.line);
		self 										:= l;
	end;
	
	concatComm				:= project(concatC, addSL(left));

EXPORT Map_Ported_Metadata_Main := dedup(sort(concatComm(phone<>''), record, local), record, local);