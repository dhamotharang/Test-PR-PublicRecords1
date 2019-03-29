IMPORT dx_PhonesInfo, Mdr, PhonesInfo;

//DF-24397: Create Dx-Prefixed Keys

	//Use Neustar Ported Base File
	ds 			:= PhonesInfo.File_TCPA.Main_Current;
		
	//Receive Full File Replacement Records - Records Not Listed In the Latest File are Considered Deleted
	//Port Add Records
	ds_add 	:= ds(port_start_dt<>0);

	dx_PhonesInfo.Layouts.Phones_Transaction_Main fixPJA(ds_add l):= transform
		self.source											:= if(l.phonetype='LC', Mdr.SourceTools.Src_PhonesPorted_TCPA,	   //Port: PJ - Landline-to-Cellphone
																				if(l.phonetype='CL', Mdr.SourceTools.Src_PhonesPorted_TCPA_CL, //Port: PM - Cellphone-to-Landline
																				''));
		self.transaction_code 					:= PhonesInfo.TransactionCode.PortAdd;	//PA - Add
		self.transaction_dt 						:= l.port_start_dt;
		self.transaction_time						:= '';
		self.vendor_first_reported_dt		:= l.vendor_first_reported_dt;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= l.vendor_last_reported_dt;
		self.vendor_last_reported_time	:= '';
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.spid												:= '';
		self.carrier_name								:= '';
		self.phone_swap									:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	addRec 	:= project(ds_add, fixPJA(left));
	
	//Port Delete Records	
	ds_del 	:= ds(port_end_dt<>0);

	dx_PhonesInfo.Layouts.Phones_Transaction_Main fixPJD(ds_del l):= transform
		self.source											:= if(l.phonetype='LC', Mdr.SourceTools.Src_PhonesPorted_TCPA,	   //Port: PJ - Landline-to-Cellphone
																				if(l.phonetype='CL', Mdr.SourceTools.Src_PhonesPorted_TCPA_CL, //Port: PM - Cellphone-to-Landline
																				''));
		self.transaction_code 					:= PhonesInfo.TransactionCode.PortDelete;	//PD - Delete
		self.transaction_dt 						:= l.port_end_dt;
		self.transaction_time						:= '';
		self.vendor_first_reported_dt		:= l.port_end_dt;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= l.port_end_dt;
		self.vendor_last_reported_time	:= '';
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.spid												:= '';
		self.carrier_name								:= '';
		self.phone_swap									:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	delRec 	:= project(ds_del, fixPJD(left));
	
	//Concat/Dedup Neustar Port Records
	concatNeustarPort 		:= addRec + delRec;
	
	//Add Record_id
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(concatNeustarPort l) := transform
		self.record_sid									:= hash64(l.source + l.transaction_code + l.transaction_dt + l.vendor_first_reported_dt) + (integer)l.phone;
		self														:= l;
	end;
	
	addID		:= project(concatNeustarPort, trID(left));

	ddNPort	:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);

EXPORT Remap_TCPA_File 	:= ddNPort;