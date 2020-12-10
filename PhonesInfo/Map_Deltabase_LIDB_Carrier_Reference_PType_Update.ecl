IMPORT DeltabaseGateway, dx_PhonesInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Map Phone Base Files to Phone Type Layout - Append Serv/Line/Carrier Names from Carrier Reference Table///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////																																										
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//LIDB Deltabase Gateway File - Join by Ocn & Carrier_Name////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
		
	//Prep LIDB Deltabase File
	compNameRespLayout := record
		DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base;
		string name;
	end;

	dsLIDBDelt								:= project(DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_LIDB_Base, 	//Source = PB; Deltabase Gateway File (LIDB) - Pull Only Good Records																								
																				transform({compNameRespLayout},
																										self.name	:= PhonesInfo._Functions.fn_standardName(left.carrier_name);
																										self			:= left));	
																										
	srtLIDBDelt 							:= sort(distribute(dsLIDBDelt, hash(carrier_ocn, name)), carrier_ocn, name, local);		
	
	//Prep Carrier Reference File
	dsCarrRef									:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);	
	srtCarrRef								:= sort(distribute(dsCarrRef, hash(ocn, name)), ocn, name, local);

	//Join the Returned LIDB Response File with the Source File to Populate Service and Line Types
	dx_PhonesInfo.Layouts.Phones_Type_Main appDeltaSL(srtLIDBDelt l, srtCarrRef r):= transform
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

	joinLidbDeltFields				:= join(srtLIDBDelt, srtCarrRef, 
																		left.carrier_ocn = right.ocn and
																		left.name = right.name,
																		appDeltaSL(left, right), left outer, local);
	
	srcLidbDelt								:= dedup(sort(distribute(joinLidbDeltFields, hash(carrier_name)), record, local), record, local);	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//LIDB Deltabase Gateway File - Join by Ocn //////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	incompRec2				:= srcLidbDelt(serv='');
	compRec2					:= srcLidbDelt(serv<>'');
	
	srtLIDBDelt2							:= sort(distribute(incompRec2, hash(account_owner)), account_owner, serv, line, local);
	srtCarrRef2 							:= sort(distribute(dsCarrRef, hash(ocn)), ocn, serv, line, local);		
	
	dx_PhonesInfo.Layouts.Phones_Type_Main appDeltaSL2(srtLIDBDelt2 l, srtCarrRef2 r):= transform
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
	
	joinLidbDeltFields2				:= join(srtLIDBDelt2, srtCarrRef2, 
																		left.account_owner = right.ocn,
																		appDeltaSL2(left, right), left outer, local);
	
	srcLidbDelt2							:= dedup(sort(distribute(joinLidbDeltFields2, hash(account_owner, serv)), record, local), record, local);	
	
	concatLidbDelta						:= compRec2 + srcLidbDelt2;	
		
EXPORT Map_Deltabase_LIDB_Carrier_Reference_PType_Update := concatLidbDelta;