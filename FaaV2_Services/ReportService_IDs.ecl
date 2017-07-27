import doxie, doxie_cbrs, FaaV2_services;

export ReportService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string8 n_number := '';
		export boolean noDeepDive := false;
	end;
	export val(params in_mod,boolean isFCRA=false) := function
		
	  aircraft_number := dataset([transform (FaaV2_services.Layouts.aircraftNumberPlus, 
                                           SELF.n_number := in_mod.n_number, SELF := [])]);
		by_aircraft_number := if(in_mod.n_number != '',faav2_services.Raw.byAircraftNumber(aircraft_number));
		
		// lookup by DID
		//dids := dataset([{0,(unsigned)in_mod.DID,0,0,false}],FaaV2_services.layouts.aircraftNumberPlus);
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,faav2_services.Raw.byDIDs(dids,isFCRA));

		// lookup by BDID
		//bdids := dataset([{0,0,(unsigned)in_mod.BDID,0,false}],FaaV2_services.layouts.aircraftNumberPlus);
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,faav2_services.Raw.byBDIDs(bdids));
		
		// won't be doing deep dive for the report service 
			
		 ids_1 := map(
				in_mod.n_number <> '' => by_aircraft_number,
				(unsigned)in_mod.DID <> 0 => by_did,
				by_bdid);

		ids:= if(isFCRA,by_did,ids_1);
		ids_d	:= dedup(sort(ids, aircraft_id), aircraft_id);

    // aircraft numbers are returned here.
		return ids_d;
	end;
end;
