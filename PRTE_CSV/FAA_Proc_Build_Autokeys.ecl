import AutoKeyB2, FAA, Tools; 
 
export FAA_Proc_Build_Autokeys( dataset(PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_aircraft_reg) ds_Aircraft_Reg
															 ,dataset(PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_airmen) ds_Airmen
															 ,string pversion
															) := function
		
		CreateAutoKeySuper := tools.mod_Utilities.createsupers(prte_csv.FAA_Keyfilenames().dAll_filenames);

		ds_Autokey_Aircraft_Reg_Prep := project(ds_Aircraft_Reg,transform(faa.layout_common_aircraft_airman_cert,
																																			self.source_type	:= 'AR';
																																			self.did_out			:= (unsigned8)left.did_out;
																																			self.bdid_out			:= (unsigned8)left.bdid_out;
																																			self.street1			:= left.street;
																																			self.suffix				:= left.addr_suffix;
																																			self.aircraft_id	:= 0;																																	
																																			self 							:= left;
																																			self 							:= [];)
																																			);

		ds_Autokey_Airmen_Prep 	 		 := project(ds_Airmen,transform(faa.layout_common_aircraft_airman_cert,
																																			self.source_type	:='AM';
																																			self.did_out			:= (unsigned8)left.did_out;
																																			self.aircraft_id	:= 0;																																	
																																			self 							:= left;
																																			self 							:= [];)																																	
																																		);
																																	
		ds_Autokeys_Prep 					 	 := ds_Autokey_Aircraft_Reg_Prep + ds_Autokey_Airmen_Prep;		

		//produce autokeys for faa
		export str_autokeyname 	:= _Dataset().prte_thor_cluster_files+'key::faa::autokey::';
		export ak_keyname				:= _Dataset().prte_thor_cluster_files+'key::faa::autokey::';
		export ak_logical				:= _Dataset().prte_thor_cluster_files+'key::faa::'+pversion+'::autokey::';
		export ak_dataset				:=  ds_Autokeys_Prep;
		export ak_skipSet				:= ['P','Q','F'];
		export ak_typeStr				:= 'BC';

		AutoKeyB2.MAC_Build (ak_dataset,fname,mname,lname,
								best_ssn,
								zero,
								zero,
								prim_name,
								prim_range,
								st,
								p_city_name,
								zip,
								sec_range,
								zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,
								did_out,
								compname,
								zero,
								zero,
								prim_name,prim_range,st,p_city_name,zip,sec_range,
								bdid_out,
								ak_keyname,
								ak_logical,
								bld_auto_keys,false,
								ak_skipSet,true,ak_typeStr,
								true,,,zero); 

		AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipSet) ; 

		retval := sequential(CreateAutoKeySuper, bld_auto_keys, mymove);

		return retval; 				
				
end: DEPRECATED('Use PRTE2_FAA.Proc_build_keys instead.');

