IMPORT DeltabaseGateway;

//////////////////////////////////////////////////////////////////////////////////////////	
//Map LIDB Deltabase to Common Layout/////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////
		
	//Prep Returned LIDB Response File
	compNameRespLayout := record
		DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base;
		unsigned8 dt_first_reported;
		unsigned8	dt_last_reported;
		string    name;
		string 	  src;
	end;

	lidbDelt									:= project(DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_LIDB_Base, 	//Deltabase Gateway File
																				transform({compNameRespLayout},
																										self.dt_first_reported	:= (integer)left.date_file_loaded;	
																										self.dt_last_reported		:= (integer)left.date_file_loaded;
																										self.name								:= PhonesInfo._Functions.fn_standardName(left.carrier_name);
																										self.src 								:= PhonesInfo._Functions.fn_keyCarrier(left.carrier_name);
																										self										:= left));	

	srtLidbDelt 							:= sort(distribute(lidbDelt, hash(name)), name, carrier_ocn, local);		
	
	//Prep Carrier Reference 
	dsCRef										:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE); 	
	srtCRef										:= sort(distribute(dsCRef, hash(name)), name, ocn, local);

	//Join the Returned LIDB Response File with the Source File to Populate Service and Line Types
	
	//Join by Name and Ocn
	PhonesInfo.Layout_Common.temp_PortedMetadata_Main appDeltaSL(srtLidbDelt l, srtCRef r):= transform
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

	joinLidbDeltFields				:= join(srtLidbDelt, srtCRef,
																		left.name = right.name and
																		left.carrier_ocn = right.ocn,
																		appDeltaSL(left, right), left outer, local, keep(1));
	
	ddLidbDelt								:= dedup(sort(distribute(joinLidbDeltFields, hash(carrier_name)), record, local), record, local);	

	//Join by OCN for Remaining Unmatched Records
	incompRec		:= ddLidbDelt(serv='');
	compRec			:= ddLidbDelt(serv<>'');
	
	srtLidbDelt2							:= sort(distribute(incompRec, hash(account_owner)), account_owner, serv, line, local);		
	srtCRef2									:= sort(distribute(dsCRef, hash(ocn)), ocn, serv, line, local);

	PhonesInfo.Layout_Common.temp_PortedMetadata_Main appDeltaSL2(srtLidbDelt2 l, srtCRef2 r):= transform
		self.serv												:= r.serv;
		self.line												:= r.line;
		self.spid												:= r.spid;
		self.operator_fullname					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;
		self 														:= l;
	end;

	joinLidbDeltFields2				:= join(srtLidbDelt2, srtCRef2,
																		left.account_owner = right.ocn,
																		appDeltaSL2(left, right), left outer, local, keep(1));
	
	srcLidbDelt2							:= dedup(sort(distribute(joinLidbDeltFields2, hash(account_owner, serv)), record, local), record, local);	
	
	concatLidbDelt						:= compRec + srcLidbDelt2;
	
//EXPORT Map_Deltabase_LIDB_Carrier_Reference_PMT_Update := srcLidbDelt;
EXPORT Map_Deltabase_LIDB_Carrier_Reference_PMT_Update := concatLidbDelt;