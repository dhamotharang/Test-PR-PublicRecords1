IMPORT ut, doxie_files;
doxie_cbrs.mac_Selection_Declare()

//get some vehicle sequence numbers
subadd := doxie_Cbrs.best_address;
kav := doxie_cbrs.key_addr_vehseqno;

kav keepk(kav l) := TRANSFORM
  SELF := l;
END;

sn := JOIN(subadd, kav,
           Include_MotorVehicles_val AND
           LEFT.prim_name = RIGHT.prim_name AND
           LEFT.prim_range = RIGHT.prim_range AND
           LEFT.zip = RIGHT.zip5 AND
           ut.NNEQ(LEFT.sec_range, RIGHT.sec_range),
           keepk(RIGHT));
  
//fetch the recs by that
kv := doxie_files.Key_Vehicles;

ExtendedLayout :=
RECORD
  doxie_files.Layout_Vehicles;
  STRING30 history_name := '';
  STRING30 major_color_name := '';
  STRING30 minor_color_name := '';
  STRING30 orig_state_name := '';
  STRING30 body_code_name := '';
  STRING30 fuel_type_name := '';
  STRING30 hull_material_type_name := '';
  STRING30 license_plate_code_name := '';
  STRING30 odometer_status_name := '';
  STRING30 title_status_code_name := '';
  STRING30 vehicle_type_name := '';
  STRING30 vehicle_use_name := '';
  STRING30 vessel_propulsion_type_name := '';
  STRING30 vessel_type_name := '';
  STRING30 lh_1_county_name := '';
  STRING30 lh_2_county_name := '';
  STRING30 lh_3_county_name := '';
END;


outrec := ExtendedLayout; //RECORDOF(kv);
outrec keepr(kv r) := TRANSFORM
  SELF := r;
END;

EXPORT motor_vehicle_records :=
  JOIN(sn, kv, 
  LEFT.seq_no = RIGHT.sseq_no AND RIGHT.history_name = 'CURRENT', 
  keepr(RIGHT));
