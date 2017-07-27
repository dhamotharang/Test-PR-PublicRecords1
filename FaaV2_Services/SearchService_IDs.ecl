import doxie, doxie_cbrs, doxie_raw, FaaV2_services;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string8 n_number := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod,boolean isFCRA = false) := function
		// autokeys
		by_auto	:= FaaV2_services.AutoKey_IDs.val(in_mod);
		
		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 transform(doxie.layout_references, 									   								
										 self.did := left.did,										
										  self := left));
		by_deep_dids := if(not in_mod.noDeepDive,faav2_services.Raw.byDIDs(deep_dids));
		
		// deep BDIDs
		 deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(doxie_cbrs.layout_references,							 
									 self.bdid := left.bdid,
									 self := left)); 
			
		by_deep_bdids := if(not in_mod.noDeepDive,faav2_services.Raw.byBDIDs(deep_bdids));
		
		// lookup by aircraftNumber id (n_number field)
	  aircraft_number := dataset([transform (FaaV2_services.Layouts.aircraftNumberPlus, 
                                           SELF.n_number := in_mod.n_number, SELF := [])]);

		
		by_aircraft_number := if(in_mod.n_number != '',faav2_services.Raw.byAircraftNumber(aircraft_number));
		//
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,faav2_services.Raw.byDIDs(dids,isFCRA));

		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,faav2_services.Raw.byBDIDs(bdids));
		
		// combine...
	
		ids_1 := map(
			in_mod.n_number <> '' => by_aircraft_number,
			(unsigned)in_mod.DID <> 0 => by_did,  
			(unsigned)in_mod.BDID <> 0 => by_bdid,
			by_auto + 
			  project(by_deep_dids + by_deep_bdids,
						  transform(FaaV2_services.Layouts.aircraftNumberPlus,
						     self.isDeepDive := true,
							   self := left)));
								
 		// n_number = aircraftNumber = registrationNumber
		// ...and shifting deep-dive-only to the end
		ids := if(isFCRA,by_did,ids_1);  // added to remove autokeys for deployment to roxie
		ids_d	:= dedup(sort(ids, aircraft_id, isDeepDive), aircraft_id);
    // aircraft numbers are returned here.
		return ids_d;
	end;
end;