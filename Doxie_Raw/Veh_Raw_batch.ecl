import doxie_raw, doxie, ut, VehicleV2, Vehiclev2_services, autokey, autokeyb2;

outrec := doxie_Raw.Layout_VehRawBatchInput.out_layout;

export outrec Veh_Raw_batch(grouped dataset(outrec) inputs,
														boolean DoFail = false, boolean IsCRS = false,
														boolean ExcludeLessors = false, boolean include_non_regulated_data = false) := 
FUNCTION

isCNSMR := ut.IndustryClass.is_Knowx;

dk0 := doxie_Raw.Layout_VehRawBatchInput.input_w_keys;

dk := record
dk0;
unsigned6 id;
end;


dk xt(dk l, string30 vehicle_key,string15 iteration_key,string15 sequence_key,unsigned6 id,string2 state_origin) := 
TRANSFORM
	self.vehicle_key := if(vehicle_key <> '' and ut.NNEQ(state_origin, l.input.st_code_value), vehicle_key, l.vehicle_key);
	self.iteration_key := if(iteration_key <> '' and ut.NNEQ(state_origin, l.input.st_code_value), iteration_key, l.iteration_key);
	self.sequence_key := if(sequence_key <> '' and ut.NNEQ(state_origin, l.input.st_code_value), sequence_key, l.sequence_key);
	self.id := if(id <> 0, id,l.id);
	SELF := l;
END;

vlimit := 2000;

F0 := project(inputs, transform(dk, self := left,self := []));

t := VehicleV2.Constant.str_autokeyname;

veh_addr_key := autokey.key_address(t);
veh_name_key := autokeyb2.key_name(t);
veh_stname_key :=autokeyb2.key_stname(t);
payload_key := VehicleV2.key_AutokeyPayload;

//***** Round up the seq_nos for later join
F1 := 
	if(DoFail,
			join(F0,VehicleV2.key_vehicle_did,
					 left.input.did > 0 and 
					 left.vehicle_key = '' and
					 keyed(left.input.did=right.append_did),
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,''), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),	
			join(F0,VehicleV2.key_vehicle_did,
					 left.input.did > 0 and 
					 left.vehicle_key = '' and
					 keyed(left.input.did=right.append_did),
					 xt(left,right.vehicle_key,right.iteration_key,right.sequence_key,0,''), atmost(vlimit), left outer));
					 
F2 := 
	if(DoFail,
			join(F1, VehicleV2.Key_vehicle_VIN, 
					 left.input.vin_value <> '' and 
					 left.vehicle_key = '' and
					 keyed(left.input.vin_value=right.vin),
					 xt(left, right.vehicle_key,right.iteration_key,'',0,''), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),
			join(F1, VehicleV2.Key_vehicle_VIN, 
					 left.input.vin_value <> '' and 
					 left.vehicle_key = '' and
					 keyed(left.input.vin_value=right.vin),
					 xt(left, right.vehicle_key,right.iteration_key,'',0,''), atmost(vlimit), left outer));
					 
F3 := 
	if(DoFail,
			join(F2, VehicleV2.Key_Vehicle_Lic_plate, 
				   left.input.tag_value <> '' and
					 left.vehicle_key ='' and
					 keyed(left.input.tag_value = right.License_Plate) and
					 keyed(left.input.st_code_value = '' or left.input.st_code_value = right.state_origin),
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,''), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),
			join(F2, VehicleV2.Key_Vehicle_Lic_plate, 
				   left.input.tag_value <> '' and
					 left.vehicle_key ='' and
					 keyed(left.input.tag_value = right.License_Plate) and
					 keyed(left.input.st_code_value = '' or left.input.st_code_value = right.state_origin),
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,''), atmost(vlimit), left outer));

					 
F4 := 
	if(DoFail,
			join(F3, VehicleV2.Key_Vehicle_Party_Key, 
					 left.input.veh_num_value <> '' and
					 left.vehicle_key = '' and
					 keyed(left.input.veh_num_value = right.vehicle_key[1..length(trim(left.input.veh_num_value))]),// and
					 //left.input.st_code_value = right.state_origin,
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,right.state_origin), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),
			join(F3, VehicleV2.Key_Vehicle_Party_Key, 
					 left.input.veh_num_value <> '' and
					 left.vehicle_key = '' and
					 keyed(left.input.veh_num_value = right.vehicle_key[1..length(trim(left.input.veh_num_value))]),// and
					 //left.input.st_code_value = right.state_origin,
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,right.state_origin), atmost(vlimit), left outer));
					 
F5 := 
	if(DoFail,
			join(F4,VehicleV2.Key_Vehicle_BDID,
					 left.input.bdid > 0 and
					 left.vehicle_key ='' and
					 keyed(left.input.bdid=right.Append_bdid),
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,''), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),
			join(F4,VehicleV2.Key_Vehicle_BDID,
					 left.input.bdid > 0 and
					 left.vehicle_key ='' and
					 keyed(left.input.bdid=right.Append_bdid),
					 xt(left, right.vehicle_key,right.iteration_key,right.sequence_key,0,''), atmost(vlimit), left outer));


F6 := 
	if(DoFail,
			join(F5,veh_addr_key,
					 left.input.prim_name <> '' and left.input.prim_range <> '' and
					 ((left.input.st <> '' and left.input.v_city_name <> '') or left.input.zip <> '') and
					 left.vehicle_key = '' and	
					 keyed(left.input.prim_name = right.prim_name) and
					 keyed(left.input.prim_range = right.prim_range) and
					 keyed(left.input.st = '' or left.input.st = right.st) and
					 keyed(left.input.v_city_name = '' or right.city_code in doxie.Make_CityCodes(left.input.v_city_name).rox) and
					 keyed(left.input.zip = '' or left.input.zip = right.zip) and
					 keyed(left.input.sec_range = '' or left.input.sec_range = right.sec_range),
					 xt(left, '','','',right.did,''), limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),
			join(F5,veh_addr_key,
					 left.input.prim_name <> '' and left.input.prim_range <> '' and
					 ((left.input.st <> '' and left.input.v_city_name <> '') or left.input.zip <> '') and
					 left.vehicle_key = '' and	
					 keyed(left.input.prim_name = right.prim_name) and
					 keyed(left.input.prim_range = right.prim_range) and
					 keyed(left.input.st = '' or left.input.st = right.st) and
					 keyed(left.input.v_city_name = '' or right.city_code in doxie.Make_CityCodes(left.input.v_city_name).rox) and
					 keyed(left.input.zip = '' or left.input.zip = right.zip) and
					 keyed(left.input.sec_range = '' or left.input.sec_range = right.sec_range),
					 xt(left, '','','',right.did,''), atmost(vlimit), left outer));


F7 := if(DoFail,
			join(F6,veh_name_key,
				left.vehicle_key = '' and
				left.input.cname_indic <> '' and
				keyed(AutokeyB2.is_CNameIndicMatch(right.cname_indic, left.input.cname_indic)),// and
				//ut.CS100S.current(right.cname_indic, right.cname_sec, left.input.cname_indic, left.input.cname_sec) < 50,
				xt(left,'','','',right.bdid,''),
				limit(vlimit, FAIL(203,doxie.errorcodes(203))),
				left outer),
			join(F6,veh_name_key,
				left.vehicle_key = '' and
				left.input.cname_indic <> '' and
				keyed(AutokeyB2.is_CNameIndicMatch(right.cname_indic, left.input.cname_indic)),// and
				//ut.CS100S.current(right.cname_indic, right.cname_sec, left.input.cname_indic, left.input.cname_sec) < 50,
				xt(left,'','','',right.bdid,''),
				atmost(vlimit), left outer));

F8 := if(DoFail,
				join(F7,veh_stname_key,
					left.vehicle_key = '' and
					left.input.st_code_value <> '' and
					left.input.cname_indic <> '' and
					keyed(right.st=left.input.st_code_value) and keyed(AutokeyB2.is_CNameIndicMatch(right.cname_indic, left.input.cname_indic)),// and
					//ut.CS100S.current(right.cname_indic, right.cname_sec, left.input.cname_indic, left.input.cname_sec) < 50,
					xt(left,'','','',right.bdid,''),
					limit(vlimit, FAIL(203,doxie.errorcodes(203))), left outer),				
				join(F7,veh_stname_key,
					left.vehicle_key = '' and
					left.input.st_code_value <> '' and
					left.input.cname_indic <> '' and
					keyed(right.st=left.input.st_code_value) and keyed(AutokeyB2.is_CNameIndicMatch(right.cname_indic, left.input.cname_indic)),// and
					//ut.CS100S.current(right.cname_indic, right.cname_sec, left.input.cname_indic, left.input.cname_sec) < 50,
					xt(left,'','','',right.bdid,''),	
					atmost(vlimit), left outer));

F9 := join(F8,payload_key,
					left.id <> 0 and
					keyed(left.id = right.fakeid),
					xt(left,right.vehicle_key,right.iteration_key,right.sequence_key,0,''),keep(1),left outer);

F10 := join(F9, vehiclev2.Key_Vehicle_Party_Key,left.sequence_key='' and
				keyed(left.vehicle_key=right.vehicle_key) and keyed(left.iteration_key=right.iteration_key),
				xt(left,'','',right.sequence_key,0,''),keep(Vehiclev2_services.Constant.VEHICLE_PER_KEY),left outer);


F11_veh_info := dedup(project(group( sort(F10(vehicle_key<>''),vehicle_key,iteration_key,sequence_key),
	vehicle_key,iteration_key,sequence_key), dk0), all);

F11_veh_info_supressed := dedup(project(group( sort(F0(vehicle_key<>''),vehicle_key,iteration_key,sequence_key),
	vehicle_key,iteration_key,sequence_key), dk0), all);
	
F11 := if(isCNSMR, F11_veh_info_supressed, F11_veh_info);

//***** Use the seq_nos to get the veh info
FT := PROJECT(Vehiclev2_services.Fn_Find(F11,TRUE,excludelessors,,,include_non_regulated_data).v1_ret,outrec);


s := sort(FT, history_name,history, record);
d := dedup(s, whole record);
// output(inputs);
// output(F2);			 
// output(FT);
return d;

END;
