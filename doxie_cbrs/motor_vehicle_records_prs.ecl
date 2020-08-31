IMPORT doxie, doxie_cbrs, doxie_raw, suppress;

doxie_cbrs.mac_Selection_Declare()

EXPORT motor_vehicle_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                                 doxie.IDataAccess mod_access
                                ) := FUNCTION

//***** Get our target address
br := doxie_cbrs.best_records_prs_target(bdids,mod_access)(Include_MotorVehicles_val AND doxie_cbrs.stored_ShowPersonalData_value);

doxie_raw.Layout_VehRawBatchInput.out_layout tra(br l) := TRANSFORM
  SELF.input.seq := 1;
  SELF.input.zip := (STRING5)l.zip;
  SELF.input.v_city_name := l.city;
  SELF.input.st := l.state;
  SELF.input.dppa_purpose := dppa_purpose;
  SELF.input.glb_purpose := glb_purpose;
  SELF.input := l;
  SELF.input := [];
END;

brt := DEDUP(PROJECT(br, tra(LEFT)), ALL);

//***** See if any vehicles at that address
r := UNGROUP(doxie_raw.Veh_Raw_batch(GROUP(sorted(brt, seq), seq))(VEHICLE_NUMBERxBG1<>''));


suppress.MAC_Mask(r, outf_c, own_1_ssn, OWN_1_DRIVER_LICENSE_NUMBER, TRUE, TRUE);
suppress.MAC_Mask(outf_c, outf_d, own_2_ssn, OWN_2_DRIVER_LICENSE_NUMBER, TRUE, TRUE);
suppress.MAC_Mask(outf_d, outf_e, reg_1_ssn, REG_1_DRIVER_LICENSE_NUMBER, TRUE, TRUE);
suppress.MAC_Mask(outf_e, out_mskd, reg_2_ssn, REG_2_DRIVER_LICENSE_NUMBER, TRUE, TRUE);

RETURN PROJECT(out_mskd, Doxie.Layout_VehicleSearch);
END;
