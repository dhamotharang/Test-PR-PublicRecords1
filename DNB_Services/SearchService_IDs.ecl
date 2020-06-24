import doxie_cbrs,doxie_raw,dnb_services, Doxie;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string15 duns_number := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod) := function
  
  mod_access := project(in_mod, Doxie.IDataAccess, opt);
		// autokeys
		by_auto	:= dnb_services.AutoKey_IDs.val(in_mod);
		
		// deep BDIDs
		 deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(doxie_cbrs.layout_references,							 
									 self.bdid := left.bdid,
									 self := left)); 
		// output(deep_bdids,named('SSI_deep_bdid'));	
		by_deep_bdids := if(not in_mod.noDeepDive,dnb_services.Raw.byBDIDs(deep_bdids, mod_access));
		
		duns_number := dataset([{in_mod.duns_number,0, false}],Layouts.dnbNumberPlus);
		
		by_duns_number := if(in_mod.duns_number != '',dnb_Services.Raw.bydunsnumber(duns_number, mod_access));
		
		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,dnb_services.Raw.byBDIDs(bdids, mod_access));
		

		// combine...
	
		ids := map(
			in_mod.duns_number <> '' => by_duns_number,
			(unsigned)in_mod.BDID <> 0 => by_bdid,
			 by_auto + 
			  project(by_deep_bdids,
						  transform(dnb_services.Layouts.dnbNumberPlus,
						     self.isDeepDive := true,
							   self := left)));
								
  	
		ids_d	:= dedup(sort(ids, isDeepDive,duns_number), duns_number);
		
		//for debugging purpose
		// output(deep_bdids,named('SSIDs_deep_bdids'));
		// output(by_deep_bdids,named('SSIDs_by_deep_bdids'));
		// output(by_auto,named('SSIDs_by_auto'));
		// output(ids,named('SSIDs_ids'));
		// output(ids_d,named('SSIDs_ids_d'));
		// output(bdids,named('SSIDs_bdids'));
		return ids_d;
		
	end;
end;