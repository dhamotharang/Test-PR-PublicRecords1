import ut, doxie_files;
doxie_cbrs.mac_Selection_Declare()

//get some vehicle sequence numbers
subadd := doxie_Cbrs.best_address;
kav := doxie_cbrs.key_addr_vehseqno;

kav keepk(kav l) := transform
	self := l;
end;

sn := join(subadd, kav,
					 Include_MotorVehicles_val and
					 left.prim_name = right.prim_name and
					 left.prim_range = right.prim_range and
					 left.zip = right.zip5 and
					 ut.NNEQ(left.sec_range, right.sec_range),
					 keepk(right));
	
//fetch the recs by that
kv := doxie_files.Key_Vehicles;

ExtendedLayout :=
RECORD
	doxie_files.Layout_Vehicles;
	string30 history_name := '';
	string30 major_color_name := '';
	string30 minor_color_name := '';
	string30 orig_state_name := '';
	string30 body_code_name := '';
	string30 fuel_type_name := '';
	string30 hull_material_type_name := '';
	string30 license_plate_code_name := '';
	string30 odometer_status_name := '';
	string30 title_status_code_name := '';
	string30 vehicle_type_name := '';
	string30 vehicle_use_name := '';
	string30 vessel_propulsion_type_name := '';
	string30 vessel_type_name := '';
	string30	lh_1_county_name := '';
	string30	lh_2_county_name := '';
	string30	lh_3_county_name := '';
END;


outrec := ExtendedLayout; //recordof(kv);
outrec keepr(kv r) := transform
	self := r;
end;

export motor_vehicle_records := 
	join(sn, kv, left.seq_no = right.sseq_no and right.history_name = 'CURRENT', keepr(right));