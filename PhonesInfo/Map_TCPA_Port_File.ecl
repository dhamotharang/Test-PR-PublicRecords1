import ut, PhonesPlus_v2, PhonesInfo;

EXPORT Map_TCPA_Port_File(string versionDate):= function 

	//Reformat Daily Files
	neustar_in1 := distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireline_to_Wireless(regexfind(versionDate, filename, 0)<>'' and phone<>''));//LC
	neustar_in2	:= distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireless_to_Wireline(regexfind(versionDate, filename, 0)<>'' and phone<>''));//CL
	//base_f			:= PhonesInfo.File_TCPA.Historical_Main; //Use For Initial Build
	base_f			:= PhonesInfo.File_TCPA.Main_Current;//Use Previous Main

	PhonesInfo.Layout_TCPA.Main t_reformat_history(neustar_in1 l, string file_type) := transform
		filedate := if(regexfind('neustar_', l.filename, 0)<>'', l.filename[stringlib.stringfind(l.filename, 'neustar_',1)+8..stringlib.stringfind(l.filename, 'neustar_',1)+15], '');
			
		self.phone 										:= l.phone;
		self.phoneType 								:= file_type;
		self.vendor_first_reported_dt	:= (unsigned)filedate;
		self.vendor_last_reported_dt	:= (unsigned)filedate;
		self.port_start_dt						:= (unsigned)filedate;
		self.port_end_dt							:= 0;
		self.is_ported 								:= true;
	end;
	
	update_lc 	:= project(neustar_in1, t_reformat_history(left,'LC'));
	update_cl 	:= project(neustar_in2, t_reformat_history(left,'CL'));
	update_all	:= update_lc + update_cl;
	
	PhonesInfo.Layout_TCPA.Main t_apply_update(update_all le, base_f ri) := transform
		self.vendor_first_reported_dt := ut.min2(le.vendor_first_reported_dt, ri.vendor_first_reported_dt);
		self.vendor_last_reported_dt 	:= ut.max2(le.vendor_last_reported_dt, ri.vendor_last_reported_dt);	
		self.port_start_dt						:= ut.min2(le.vendor_first_reported_dt, ri.vendor_first_reported_dt);	
		self 													:= le;
	end;

	apply_update1 := join(distribute(update_all, hash(phone)),
												distribute(base_f(is_ported), hash(phone)),
												left.phone = right.phone and 
												left.phoneType = right.phoneType,
												t_apply_update(left, right),
												left outer,
												local);

	PhonesInfo.Layout_TCPA.Main t_apply_remove(base_f le, update_all ri) := transform
		self.is_ported  			:= false;
		self.port_end_dt			:= (unsigned)versionDate;
		self 									:= le;
	end;

	apply_removed := join(distribute(base_f(is_ported), hash(phone)),
												distribute(update_all, hash(phone)),
												left.phone = right.phone and 
												left.phoneType = right.phoneType,
												t_apply_remove(left, right),
												left only,
												local);

	new_base 			:= apply_update1 + apply_removed + base_f(~is_ported);
	applyDates		:= new_base;
	
	return applyDates(phone not in ['','0']);
	
end;