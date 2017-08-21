import prte_csv;

export Prep_FAA := module
  
	shared ds_faa_aircraft_reg						:= project(prte_csv.faa_files().input_faa_aircraft_reg.using
																					,transform(prte_csv.faa_input_layouts.input.fixed.layout_faa_aircraft_reg
																					,self.aircraft_id := (unsigned6)left.aircraft_id;
																					 self.persistent_record_id := (unsigned6)left.persistent_record_id;
																					 self.__internal_fpos__ 	 := (unsigned6)left.__internal_fpos__;
																					 self.did 								 := (unsigned6)left.did;
																					 self.bd 									 := (unsigned6)left.bd;
																					 self 										 := left;
																					 self 										 := [];));

	export prte_faa_aircraft_reg_prepped	:= project(ds_faa_aircraft_reg,transform(prte_bip.layouts_faa.layout_faa_aircraft_reg_as_business_linking,self := left;self := [];))
																				:  persist(PRTE_BIP.persistnames('faa_aircraft_reg').prepped);												
																				
	export All := sequential(output(prte_faa_aircraft_reg_prepped));

end;