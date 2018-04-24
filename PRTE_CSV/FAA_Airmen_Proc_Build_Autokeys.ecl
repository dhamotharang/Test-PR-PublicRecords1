import AutoKeyB2, FAA, Tools; 
 
export FAA_Airmen_Proc_Build_Autokeys(dataset(PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_airmen) ds_Airmen
																		  ,string pversion
																		 ) := function
		
		CreateAutoKeySuper := tools.mod_Utilities.createsupers(prte_csv.FAA_Keyfilenames().dAll_filenames);

		ds_Airmen_Autokeys_Prep			 := project(ds_Airmen,transform(prte_csv.faa_input_layouts.autokey.airmen.layout_faa_airmen,
																																self.did_out6			:= (unsigned6)left.did_out;
																																self.airmen_id 		:= (unsigned6)left.airmen_id;
																																self 							:= left;
																																)
																						);			
		//produce autokeys for faa
		export str_autokeyname 	:= _Dataset().prte_thor_cluster_files+'key::faa::airmen::autokey::';
		export ak_keyname				:= _Dataset().prte_thor_cluster_files+'key::faa::airmen::autokey::';
		export ak_logical				:= _Dataset().prte_thor_cluster_files+'key::faa::airmen::'+pversion+'::autokey::';
		export ak_dataset        := ds_Airmen_Autokeys_Prep;
		export ak_skipSet				:= ['P','Q','F','B'];  // B is for no business autokeys to be built
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
								did_out6,
								blank,
								zero,
								zero,
								blank,blank,blank,blank,blank,blank,
								zero,
								ak_keyname,
								ak_logical,
								bld_auto_keys,false,
								ak_skipSet,true,ak_typeStr,
								true,,,zero); 

		AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipSet) ; 

		retval := sequential(CreateAutoKeySuper, bld_auto_keys, mymove);

		return retval; 				
				
end: DEPRECATED('Use PRTE2_FAA.proc_build_keys.');
