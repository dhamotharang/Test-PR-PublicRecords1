import DeltabaseGateway, MDR, PhonesPlus_V2, Ut;	
	
	portFile 		:= PhonesInfo.File_Phones.Ported_Current;
	lidbFile		:= PhonesInfo.File_LIDB.Response_Processed;
	discFile		:= PhonesInfo.File_Deact.Main_Current;
	lidbDelt		:= DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base(source in ['ATT_DQ_IRS'] and stringlib.stringfind(device_mgmt_status, 'BAD', 1)=0);

//////////////////////////////////////////////////////////////////////////////////////////
//Map Ported Base to Common Layout - Append Serv/Line/Carrier Names from Reference Table//
//////////////////////////////////////////////////////////////////////////////////////////
	sortSPID		:= sort(distribute(PhonesInfo.File_Source_Reference.Main(is_current=TRUE), hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
	sortiCon		:= sort(distribute(portFile(source='PK'), hash(spid)), spid, local);
	
	//iConectiv File - Join by SPID
	PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
		self.serv 							:= r.serv;
		self.line								:= r.line;	
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;				
		self.is_ported					:= if(l.port_end_dt not in [0], false, l.is_ported);
		self 										:= l;
	end;
		
	addiConFields 						:= join(sortiCon, sortSPID,
																		left.spid = right.spid,
																		addiConSL(left, right), left outer, local, keep(1));

	ddiConAddFields 					:= dedup(sort(distribute(addiConFields, hash(phone)), record, local), record, local);
	
	//TCPA File - Join by Phone
	sortTCPAPh		:= sort(distribute(portFile(source='PJ' and vendor_first_reported_dt<=20150308), hash(phone)), phone, local);
	sortiConPh 		:= sort(distribute(ddiConAddFields, hash(phone)), phone, porting_dt, local);//pull the earliest, since these records are historical

	PhonesInfo.Layout_Common.portedMetadata_Main addTCPASL(sortTCPAPh l, ddiConAddFields r):= transform
		self.serv 							:= r.serv;
		self.line								:= r.line;
		self.spid								:= r.spid;
		self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_fullname);
		self.high_risk_indicator:= r.high_risk_indicator;
		self.prepaid						:= r.prepaid;	
		self 										:= l;
	end;

	addTCPAFields := join(sortTCPAPh, ddiConAddFields,
												trim(left.phone, left, right) = trim(right.phone, left, right),	
												addTCPASL(left, right), left outer, local, keep(1));

	ddTCPAFields 	:= dedup(sort(distribute(addTCPAFields, hash(phone)), record, local), record, local);	
	
	cmnPort := ddiConAddFields + ddTCPAFields;

//////////////////////////////////////////////////////////////////////////////////////////	
//Map LIDB Base to Common Layout//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////	
	srcApp := record
		PhonesInfo.Layout_Common.portedMetadata_Main;
		string src := '';
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
	
	srcLidb	:= project(lidbFile, trLidb(left));																//Append Translated Carrier Name
	cmnLidb := project(srcLidb, PhonesInfo.Layout_Common.portedMetadata_Main);//Common Layout

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
	
	dsDisc 			:= project(discFile, trDisc(left));	
	
	//Append Carrier Info to Deact Files from LIDB - Join by Phone & Carrier_Name
	sortDisc 		:= sort(distribute(dsDisc, hash(phone)), phone, local);
	sortLidb		:= sort(distribute(srcLidb, hash(phone)), phone, -vendor_last_reported_dt, local);
	
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
														
	cmnDisc 		:= dedup(sort(distribute(addLidbDiscFields, hash(phone)), record, local), record, local);
	
//////////////////////////////////////////////////////////////////////////////////////////	
//Map LIDB Deltabase to Common Layout/////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////
		
	//Prep Returned LIDB Response File
	compNameRespLayout := record
		lidbDelt;
		unsigned8 dt_first_reported;
		unsigned8	dt_last_reported;
		string 	  tempName;
	end;

	compNameRespLayout fixN(lidbDelt l):= transform		
		self.dt_first_reported	:= (integer)l.date_file_loaded;	
		self.dt_last_reported		:= (integer)l.date_file_loaded;
		self.tempName 					:= PhonesInfo._Functions.fn_standardName(l.carrier_name);
		self 										:= l;
	end;
	
	fixCarrier 								:= project(lidbDelt, fixN(left));
	sort_carrier 							:= sort(distribute(fixCarrier, hash(tempName)), tempName, carrier_ocn, local);		
	
	//Prep Carrier Reference File w/ Service & Line Types
	compNameLayout := record
		PhonesInfo.Layout_common.sourceRefBase;
		string tempName;
	end;
			
	compNameLayout fixCN(PhonesInfo.Layout_common.sourceRefBase l):= transform		
		self.tempName 					:= PhonesInfo._Functions.fn_standardName(l.name);
		self 										:= l;
	end;
	
	fixName 									:= project(PhonesInfo.File_Source_Reference.Main(is_current=TRUE), fixCN(left));
	sort_name									:= sort(distribute(fixName, hash(tempName)), tempName, ocn, local);

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

	joinLidbDeltFields 				:= join(sort_carrier, sort_name,
																		left.tempName = right.tempName and
																		left.carrier_ocn = right.ocn,
																		appDeltaSL(left, right), left outer, local);
	
	cmnLidbDelt	:= dedup(sort(distribute(joinLidbDeltFields, hash(carrier_name)), record, local), record, local);
	
//////////////////////////////////////////////////////////////////////////////////////////
//Concat Reformatted Files////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
	concatComm 	:= cmnPort + cmnLidb + cmnDisc + cmnLidbDelt;

EXPORT Map_Ported_Metadata_Main := dedup(sort(concatComm(phone<>''), record, local), record, local);