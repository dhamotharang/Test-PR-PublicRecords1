import doxie, sexOffender;

export Search_IDs := MODULE
		
	export val(SexOffender_Services.IParam.ids_params in_mod,
						 boolean isFCRA = false) := function
	
		// Search using autokeys
		by_auto	:= SexOffender_Services.AutoKey_IDs.val(in_mod);

		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
										transform(SexOffender_Services.Layouts.search_did,
										          self.isDeepDive := true, 
										          self := left));
				
		by_deep_dids := if(not in_mod.noDeepDive,SexOffender_Services.Raw.byDIDs(deep_dids));
    
		// Lookup by DID
		did_ds := dataset([{(unsigned6)in_mod.did,false}],SexOffender_Services.Layouts.search_did);
		by_did := if((unsigned6)in_mod.did > 0,SexOffender_Services.Raw.byDIDs(did_ds, isFCRA));
		
		// Search using zip
		fake_zip_dids := doxie.sexoffender_fetch_by_zip();	
		fDid_key := sexoffender.Key_SexOffender_fdid;	
		by_zip := JOIN(fake_zip_dids, fDid_key,
				           keyed(left.did=right.did), 
                   transform(SexOffender_Services.layouts.search, 
									 self := right), KEEP (1));
													
    // Determine which set of seisint primary keys to be returned:
		// 1) either the ones associated with a did if one was entered,  OR 
		// 2) check for zip only search, OR
		// 3) the ones retrieved by autokeys plus any from deep diving
		
		temp_spks1 := map((unsigned6)in_mod.did  <> 0  => by_did,
												in_mod.zip_only_search  => by_zip,
														by_auto + by_deep_dids);
		temp_spks := if(isFCRA, by_did, temp_spks1);
	  //sort and dedup on the seisint_primary_key
		spks_deduped := dedup(sort(temp_spks, seisint_primary_key, isDeepDive), 
		                      seisint_primary_key);
													
	  //Uncomment lines below as needed to assist in debugging
    //output(in_mod.nodeepdive,named('si_nodeepdive'));
    //output(by_auto,named('si_by_auto'));
		//output(deep_dids,named('si_deep_dids'));
  	//output(by_deep_dids,named('si_by_deep_dids'));
		//output(by_did,named('si_by_did'));
		//output(temp_spks,named('si_temp_spks'));
		//output(spks_deduped,named('si_spks_deduped'));

		return spks_deduped;
	end;
	
end;