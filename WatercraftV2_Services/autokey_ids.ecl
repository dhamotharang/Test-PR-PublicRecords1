import autokeyb2, AutoKeyI, doxie, doxie_cbrs;

export Autokey_ids := module

		export val(interfaces.ak_params in_mod, 
							 boolean workhard = false, 
							 boolean nofail =false) := FUNCTION


		outrec := WatercraftV2_services.Layouts.search_watercraftkey;

		//****** SEARCH THE AUTOKEYS
		t := WatercraftV2_Services.Constants(Version.key).ak_keyname;
		ds := dataset([],WatercraftV2_services.Layouts.ak_payload_rec);
		typestr :=Constants(Version.key).ak_typeStr;
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := t;
			export string typestr := ^.typestr;
			export boolean workHard := ^.workhard;
			export boolean noFail := ^.nofail;
			export boolean useAllLookups := true;
			export set of string1 get_skip_set := [];
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

		//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
		WatercraftV2_services.mac_get_payload_ids(ids,t,ds,outpl,ldid,lbdid, typestr,, newdids, newbdids, olddids, oldbdids)

		//** search by did for deepdives
		newbydid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_dids(newdids);

		//** search by bdid for deepdives
		newbybdid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_bdids(newbdids);

		//***** FOR DEEP DIVES
		DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));


		//****** IDS DIRECTLY FROM THE PAYLOAD KEY
		byak := project(outpl, outrec);

		boolean includeDeepDive := not in_mod.NoDeepDive;

		dups := byak + if(includeDeepDive, deepDives);
				
		rets:= dedup(sort(dups, watercraft_key, state_origin, sequence_key,if(isDeepDive,1,0)), 
								watercraft_key,state_origin,sequence_key);

		return(rets);
		end;
END;