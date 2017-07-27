import doxie,doxie_cbrs,doxie_raw, DEA_services;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string9 dea_registration_number := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod) := function
		// autokeys
		by_auto	:= DEA_services.AutoKey_IDs.val(in_mod);
		
		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 transform(doxie.layout_references, 									   								
										 self.did := left.did,	
										  self := left));
		by_deep_dids := if(not in_mod.noDeepDive,DEA_services.Raw.byDIDs(deep_dids));
		
		// deep BDIDs
		 deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(doxie_cbrs.layout_references,							 
									 self.bdid := left.bdid,
									 self := left)); 
		// output(deep_bdids,named('SSI_deep_bdid'));	
		by_deep_bdids := if(not in_mod.noDeepDive,DEA_services.Raw.byBDIDs(deep_bdids));
		
		dea_registration_number := dataset([{in_mod.dea_registration_number,0,0, false}],Layouts.DEANumberPlus);
		
		by_registration_number := if(in_mod.dea_registration_number != '',DEA_Services.Raw.byregistrationNumber(dea_registration_number));
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,DEA_services.Raw.byDIDs(dids));

		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,DEA_services.Raw.byBDIDs(bdids));
		

		// combine...
	
		ids := map(
			in_mod.dea_registration_number <> '' => by_registration_number,
			(unsigned)in_mod.DID <> 0 => by_did,
			(unsigned)in_mod.BDID <> 0 => by_bdid,
			 by_auto + 
			  project(by_deep_dids + by_deep_bdids,
						  transform(DEA_services.Layouts.DEANumberPlus,
						     self.isDeepDive := true,
							   self := left)));
								
  	
		ids_d	:= dedup(sort(ids, dea_registration_number,did,bdid,isDeepDive), dea_registration_number,did,bdid);
		
		//for debugging purpose
		
		// output(dids,named('SSIDs_dids'));
		// output(bdids,named('SSIDs_bdids'));
		// output(ids,named('SSIDs_ids'));
		// output(ids_d,named('SSIDs_ids_d'));
		return ids_d;
		
	end;
end;