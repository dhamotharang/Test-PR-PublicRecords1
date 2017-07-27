import doxie,autokey,autokeyb2,ut;
export FetchI_Biz := module
	tempd := dataset([],autokeyb2.layout_fetch);
	autokey.mac_Limits_nofail(tempd,tempds,false);
	export functions := interface
		export FetchI_Biz_Address() := tempds;
		export FetchI_Biz_FEIN() := tempds;
		export FetchI_Biz_Name() := tempds;
		export FetchI_Biz_NameWords() := tempds;
		export FetchI_Biz_Phone() := tempds;
		export FetchI_Biz_StCityName() := tempds;
		export FetchI_Biz_StName() := tempds;
		export FetchI_Biz_Zip() := tempds;
	end;
	export old := module
		export params := interface
			export set of string1 get_skip_set := [];
			export boolean isBareAddr;
		end;
		export do(functions in_functions,params in_mod) := module
			//***** BOOLEANS TO DIRECT THE ACTION
			shared boolean skip_all  := 'B' in in_mod.get_skip_set;
			shared boolean skip_fein := 'F' in in_mod.get_skip_set;
			shared boolean skip_phn  := 'Q' in in_mod.get_skip_set;
			shared boolean skip_zip  := 'Z' in in_mod.get_skip_set;
			shared boolean skip_addr := in_mod.isBareAddr;

			//***** RETURN LAYOUT
			export layout := autokeyb2.layout_fetch;

			//***** LIL FUNCTIONS
			shared afailure(dataset(layout) l) := l(error_code > 0)[1].error_code;
			shared results(dataset(layout) l) := l(error_code = 0);
			 
			//***** FETCHES 
			shared fein := 
				project(
					if(not skip_all and not skip_fein,
						 in_functions.FetchI_Biz_FEIN()), layout);
				
			shared phone :=	
				project(
					if(not skip_all and not skip_phn,
						 in_functions.FetchI_Biz_Phone()), layout);
					 
			shared Address :=
				project(
					if(not skip_all and not skip_addr,	 
						 in_functions.FetchI_Biz_Address()), layout);
					 
			shared zip :=
				project(
					if(not skip_all and not skip_addr and not skip_zip,	 		 
						in_functions.FetchI_Biz_Zip()), layout);

			shared name :=
				project(
					if(not skip_all,
						in_functions.FetchI_Biz_Name()), layout);
				
			shared StName :=
				project(
					if(not skip_all and not skip_addr,
						in_functions.FetchI_Biz_StName()), layout);
				
			shared StCityFLName :=
				project(
					if(not skip_all and not skip_addr,	 
						in_functions.FetchI_Biz_StCityName()), layout);

			shared NameWords :=
				project(
					if(not skip_all,
						in_functions.FetchI_Biz_NameWords()), layout);

			//***** EXPORT THESE FOR CONTROL OVER FAILURE AT THE LEVEL ABOVE

			// NameWords fetch should never contribute to an error
			shared base_ds := fein + phone + address + zip + name + StName + StCityFLName;
			shared all_ds := base_ds + NameWords;
			export the_failure := afailure(base_ds);
			export had_failure := the_failure > 0;
			export all_results := results(all_ds);
			export has_results := exists(all_results);
			export did_fail 	 := had_failure and not has_results;
				
			export result := dedup(all_results,bdid, all)(bdid > 0);
		end;
	end;
	export new := module
		export params := interface
			export set of string1 get_skip_set := [];
			export boolean isBareAddr;
		end;
		export do(functions in_functions,params in_mod) := function
			tempmod := module(old.params)
				export set of string1 get_skip_set := in_mod.get_skip_set;
				export boolean isBareAddr := in_mod.isBareAddr;
			end;
			return old.do(in_functions,tempmod);
		end;
	end;
end;
