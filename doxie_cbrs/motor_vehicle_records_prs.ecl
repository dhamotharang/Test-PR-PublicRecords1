IMPORT doxie, doxie_cbrs, doxie_raw, suppress;

doxie_cbrs.mac_Selection_Declare()

EXPORT motor_vehicle_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                                 doxie.IDataAccess mod_access
                                ) := FUNCTION

//***** Get our target address
br := doxie_cbrs.best_records_prs_target(bdids,mod_access)(Include_MotorVehicles_val AND doxie_cbrs.stored_ShowPersonalData_value);

doxie_raw.Layout_VehRawBatchInput.out_layout tra(br l) := transform
	self.input.seq := 1;
	self.input.zip := (string5)l.zip;
	self.input.v_city_name := l.city;
	self.input.st := l.state;
	self.input.dppa_purpose := dppa_purpose;
	self.input.glb_purpose := glb_purpose;
	self.input := l;
	self.input := [];
end;

brt := dedup(project(br, tra(left)), all);

//***** See if any vehicles at that address
r := ungroup(doxie_raw.Veh_Raw_batch(group(sorted(brt, seq), seq))(VEHICLE_NUMBERxBG1<>''));


suppress.MAC_Mask(r, outf_c, own_1_ssn, OWN_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_c, outf_d, own_2_ssn, OWN_2_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_d, outf_e, reg_1_ssn, REG_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_e, out_mskd, reg_2_ssn, REG_2_DRIVER_LICENSE_NUMBER, true, true);

return project(out_mskd, Doxie.Layout_VehicleSearch);
END;