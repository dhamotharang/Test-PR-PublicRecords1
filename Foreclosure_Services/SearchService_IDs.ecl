import doxie,doxie_cbrs,doxie_raw, Foreclosure_services, TopBusiness_Services;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params, TopBusiness_Services.iParam.BIDParams)
		export string70 foreclosure_id := '';
		export string45 parcel_num := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod, boolean isNodSearch=false) := function
		// autokeys
		by_auto	:= Foreclosure_services.AutoKey_IDs.val(in_mod,isNodSearch);
		
		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 transform(doxie.layout_references, 									   								
										 self.did := left.did,	
										  self := left));
		by_deep_dids := if(not in_mod.noDeepDive,Foreclosure_services.Raw.byDIDs(deep_dids,isNodSearch));
		
		// deep BDIDs
		 deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(doxie_cbrs.layout_references,							 
									 self.bdid := left.bdid,
									 self := left)); 
		by_deep_bdids := if(not in_mod.noDeepDive,Foreclosure_services.Raw.byBDIDs(deep_bdids,isNodSearch));
		
		foreclosure_id := dataset([{in_mod.foreclosure_id,0,0, false}],Layouts.FIDNumberPlus);
		
		by_ForeclosureId := if(in_mod.foreclosure_id != '',Foreclosure_services.Raw.byforeclosureid(foreclosure_id,isNodSearch,true));
		
		apn_in := dataset([{in_mod.parcel_num}],Layouts.Layout_apn);
		by_apn := if(in_mod.parcel_num != '',Foreclosure_services.Raw.byApn(apn_in, isNodSearch, true));
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,Foreclosure_services.Raw.byDIDs(dids,isNodSearch));

		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,Foreclosure_services.Raw.byBDIDs(bdids,isNodSearch));
		
		// lookup by business ids
		in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(in_mod);
		by_bids := Foreclosure_services.Raw.byBIDs(in_bids,in_mod.BusinessIDFetchLevel);

		// combine...
	
		ids := map(
			in_mod.foreclosure_id <> '' => by_ForeclosureId,
			(unsigned)in_mod.DID <> 0 => by_did,
			(unsigned)in_mod.BDID <> 0 => by_bdid,
	 		 exists(by_bids) => by_bids,
			 in_mod.parcel_num <> '' => by_apn,
			 by_auto + 
			  project(by_deep_dids + by_deep_bdids,
						  transform(Foreclosure_services.Layouts.FIDNumberPlus,
						     self.isDeepDive := true,
							   self := left)));
								
  	
		ids_d	:= dedup(sort(ids, fid,did,bdid,isDeepDive), fid,did,bdid);
		
		//for debugging purpose
		
		// output(dids,named('SSIDs_dids'));
		// output(deep_dids,named('SSIDs_deep_dids'));
		// output(bdids,named('SSIDs_bdids'));
		// output(ids,named('SSIDs_ids'));
		// output(ids_d,named('SSIDs_ids_d'));
		return ids_d;
		
	end;
end;