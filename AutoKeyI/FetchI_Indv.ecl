import doxie,autokey,ut;
export FetchI_Indv := module
	tempd := dataset([],autokey.layout_fetch);
	autokey.mac_Limits_nofail(tempd,tempds,false);
	export functions := interface
		export FetchI_Indv_Address() := tempds;
		export FetchI_Indv_Name() := tempds;
		export FetchI_Indv_Phone() := tempds;
		export FetchI_Indv_SSN() := tempds;
		export FetchI_Indv_StCityName() := tempds;
		export FetchI_Indv_StName() := tempds;
		export FetchI_Indv_Zip() := tempds;
		export FetchI_Indv_ZipPRLname() := tempds;
	end;
	export old := module
		export params := interface
			export set of string1 get_skip_set := [];
		end;
		export do(functions in_functions,params in_mod) := module
			//***** BOOLEANS TO DIRECT THE ACTION
			shared boolean skip_all := 'C' in in_mod.get_skip_set;
			shared boolean skip_ssn := 'S' in in_mod.get_skip_set;
			shared boolean skip_phn := 'P' in in_mod.get_skip_set;
			shared boolean skip_zip := 'Z' in in_mod.get_skip_set;
			shared boolean add_zpl := '-' in in_mod.get_skip_set;

			//***** RETURN LAYOUT
			export layout := autokey.layout_fetch;

			//***** LIL FUNCTIONS
			shared afailure(dataset(layout) l) := l[1].error_code;
			shared results(dataset(layout) l) := l(error_code = 0);
			 
			//***** FETCHES
			shared ssn := 
				project(
					if(not skip_all and not skip_ssn,
						 in_functions.FetchI_Indv_SSN()), layout);
				
			shared phone :=	
				project(
					if(not skip_all and not skip_phn,
						 in_functions.FetchI_Indv_Phone()), layout);
					 
			shared Address :=
				project(
					if(not skip_all,	 
						 in_functions.FetchI_Indv_Address()), layout);
					 
			shared zip :=
				project(
					if(not skip_all and not skip_zip,	 		 
						in_functions.FetchI_Indv_Zip()), layout);

			shared name :=
				project(
					if(not skip_all,	 
						in_functions.FetchI_Indv_Name()), layout);
				
			shared StFLName :=
				project(
					if(not skip_all,	 
						in_functions.FetchI_Indv_StName()), layout);
				
			shared StCityFLName :=
				project(
					if(not skip_all,	 
						in_functions.FetchI_Indv_StCityName()), layout);

			shared zipPRLname :=
				project(
					if(not skip_all and add_zpl,        
						in_functions.FetchI_Indv_ZipPRLName()), layout);


			shared all_ds := ssn + phone + address + zip + name + StFLName + StCityFLName + zipPRLname;

			//***** EXPORT THESE FOR CONTROL OVER FAILURE AT THE LEVEL ABOVE
			export the_failure := afailure(all_ds);
			export had_failure := the_failure > 0;
			export all_results := results(all_ds);
			export has_results := exists(all_results);
			export did_fail 	 := had_failure and not has_results;
				

			export result := dedup(all_results,did,all);
		end;
	end;
	export new := module
		export params := interface
			export set of string1 get_skip_set := [];
		end;
		export do(functions in_functions,params in_mod) := function
			tempmod := module(old.params)
				export set of string1 get_skip_set := in_mod.get_skip_set;
			end;
			return old.do(in_functions,tempmod);
		end;
	end;
end;
