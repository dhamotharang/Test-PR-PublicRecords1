import VehicleV2_Services, vehiclev2, AutoKeyI;

export AutoKeyIds(IParam.searchParams in_mod) := function
		outrec := Layout_Vehicle_Key;

		//****** SEARCH THE AUTOKEYS
		t := VehicleV2.Constant.str_autokeyname;
		ds := dataset([],Layouts.layout_common);
		typestr :=VehicleV2.Constant.autokey_typeStr;
		
			
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := t;
			export string typestr := ^.typestr;
			export set of string1 get_skip_set := VehicleV2.Constant.autokey_skip_set;
			export boolean useAllLookups := true;
		end;
	
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		
		//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
		VehicleV2_Services.mac_get_payload_ids(ids,t,ds,outpl,append_did,append_bdid, typestr,, newdids, newbdids, olddids, oldbdids)
		
		
		reportMod := MODULE(PROJECT(in_mod, IParam.reportParams,opt)) END;
	
		//** search by did for deepdives
		newbydid := VehicleV2_Services.Raw.get_vehicle_keys_from_dids(reportMod, newdids);

		//** search by bdid for deepdives
		newbybdid := VehicleV2_Services.Raw.get_vehicle_keys_from_bdids(reportMod, newbdids);

		//***** FOR DEEP DIVES
		DeepDives    := project(newbydid + newbybdid, transform(outrec, self.is_deep_dive := true, self := left));


		//****** IDS DIRECTLY FROM THE PAYLOAD KEY
		byak := project(outpl, outrec);

		boolean includeDeepDive := in_mod.isdeepDive;

		rets := byak +  
				if(includeDeepDive, deepDives);
		return(rets);
	END;
  