import DeltabaseGateway, MDR, PhonesPlus_V2, Ut;	
	
	portFile 					:= PhonesInfo.File_Phones.Ported_Current; 																//Port File
	lidbFile					:= PhonesInfo.File_LIDB.Response_Processed;																//LIDB File
	discFile					:= PhonesInfo.File_Deact.Main_Current2;																		//Deact File
	discGHFile				:= PhonesInfo.File_Deact_GH.Main_Current;																	//Deact Gong History File
	lidbDelt					:= DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base(source in ['ATT_DQ_IRS'] and stringlib.stringfind(device_mgmt_status, 'BAD', 1)=0); //Deltabase Gateway File
	srcRef						:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE); 								//Source Reference Table
	
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
	
	/////////////////////////////	
	//TCPA File - Join by Phone//
	/////////////////////////////
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	sortTCPAPh				:= sort(distribute(portFile(source='PJ' and vendor_first_reported_dt<=20150308), hash(phone)), phone, local);
	sortiConPh 				:= sort(distribute(ddiConAddFields, hash(phone)), phone, porting_dt, local);//pull the earliest, since these records are historical

	PhonesInfo.Layout_Common.portedMetadata_Main addTCPASL(sortTCPAPh l, ddiConAddFields r):= transform
		self.account_owner			:= r.account_owner;
		self.carrier_name				:= r.carrier_name;
		self.serv 							:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_fullname);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;	
		self 										:= l;
	end;

	addTCPAON 				:= join(sortTCPAPh, ddiConAddFields,
														trim(left.phone, left, right) = trim(right.phone, left, right),	
														addTCPASL(left, right), left outer, local, keep(1));
	
	ddTCPAFields 			:= dedup(sort(distribute(addTCPAON, hash(phone)), record, local), record, local);	
	
	cmnPort 					:= ddiConAddFields + ddTCPAFields;

//////////////////////////////////////////////////////////////////////////////////////////	
//Map LIDB Base to Common Layout//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////	
	srcApp := record
		PhonesInfo.Layout_Common.portedMetadata_Main;
		string src 							:= '';
	end;
	
	srcApp trLidb(lidbFile l):= transform
		self.source 									:= 'PB';
		self.vendor_first_reported_dt	:= l.dt_first_reported;
		self.vendor_last_reported_dt	:= l.dt_last_reported;
		self.point_code								:= trim(l.point_code, left, right);
		self.operator_fullname				:= PhonesInfo._Functions.fn_CarrierName(l.operator_fullname);
		self.src											:= PhonesInfo._Functions.fn_keyCarrier(l.carrier_name);
		self 													:= l;
	end;
	
	srcLidb						:= project(lidbFile, trLidb(left));																//Append Translated Carrier Name
	cmnLidb 					:= project(srcLidb, PhonesInfo.Layout_Common.portedMetadata_Main);//Common Layout
	
//////////////////////////////////////////////////////////////////////////////////////////	
//Map LIDB Deltabase to Common Layout/////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////
		
	//Prep Returned LIDB Response File
	compNameRespLayout := record
		lidbDelt;
		unsigned8 dt_first_reported;
		unsigned8	dt_last_reported;
		string 	  src;
	end;

	compNameRespLayout fixN(lidbDelt l):= transform		
		self.dt_first_reported	:= (integer)l.date_file_loaded;	
		self.dt_last_reported		:= (integer)l.date_file_loaded;
		self.src 								:= PhonesInfo._Functions.fn_standardName(l.carrier_name);
		self 										:= l;
	end;
	
	fixCarrier 								:= project(lidbDelt, fixN(left));
	sort_carrier 							:= sort(distribute(fixCarrier, hash(src)), src, carrier_ocn, local);		
	
	//Prep Carrier Reference File w/ Service & Line Types
	compNameLayout := record
		PhonesInfo.Layout_common.sourceRefBase;
		string src;
	end;
			
	compNameLayout fixCN(PhonesInfo.Layout_common.sourceRefBase l):= transform		
		self.src 								:= PhonesInfo._Functions.fn_standardName(l.name);
		self 										:= l;
	end;
	
	fixName 					:= project(srcRef, fixCN(left));
	sort_name					:= sort(distribute(fixName, hash(src)), src, ocn, local);

	//Join the Returned LIDB Response File with the Source File to Populate Service and Line Types
	PhonesInfo.Layout_Common.portedMetadata_Main appDeltaSL(sort_carrier l, sort_name r):= transform
		dt_added := stringlib.stringfilter(l.date_added, '0123456789')[1..14];	
		self.reference_id								:= (string)(hash32(l.submitted_phonenumber));
		self.source											:= 'PB';
		self.phone											:= l.submitted_phonenumber;
		self.local_routing_number				:= l.lrn;
		self.account_owner							:= l.carrier_ocn;
		self.local_area_transport_area	:= l.lata;
		self.vendor_first_reported_dt		:= (integer)dt_added[1..8];
		self.vendor_first_reported_time	:= dt_added[9..];
		self.vendor_last_reported_dt		:= (integer)dt_added[1..8];
		self.vendor_last_reported_time	:= dt_added[9..];
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;
		self 														:= l;
	end;

	joinLidbDeltFields:= join(sort_carrier, sort_name,
														left.src = right.src and
														left.carrier_ocn = right.ocn,
														appDeltaSL(left, right), left outer, local);
	
	cmnLidbDelt				:= dedup(sort(distribute(joinLidbDeltFields, hash(carrier_name)), record, local), record, local);	
	srcLidbDelt				:= project(cmnLidbDelt, srcApp);

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
//Concat Reformatted Files////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
	concatC 					:= cmnPort + cmnLidb + cmnDisc + cmndiscGH + cmnLidbDelt;
	
	//Set Blank Serv/Line Types to "UNKNOWN"
	concatC addSL(concatC l):= transform
		self.serv								:= if(l.serv='', '3', l.serv);
		self.line								:= if(l.line='', '3', l.line);
		self 										:= l;
	end;
	
	concatComm				:= project(concatC, addSL(left));

EXPORT Map_Ported_Metadata_Main := dedup(sort(concatComm(phone<>''), record, local), record, local);