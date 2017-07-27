import doxie,doxie_raw;

export Search_IDs := MODULE

	export params := interface(AutoKey_IDs.params)
		export string9 Accident_Number  := '';
		export string22 Vin_in          := '';	
	  export string15 DL_Nbr          := '';
	  export string8 Tag_Number       := '';
		export boolean noDeepDive       := false;
		export unsigned2 MAX_DEEP_DIDS  := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
		
	export val(params in_mod) := function
	
		// Search using autokeys
		by_auto	:= FLAccidents_Services.AutoKey_IDs.val(in_mod);

		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
										transform(FLAccidents_Services.Layouts.search_did,
										          self.isDeepDive := true, 
										          self := left));
				
		by_deep_dids := if(not in_mod.noDeepDive,FLAccidents_Services.Raw.byDIDs(deep_dids));
    
		// deep BDIDs
		deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(FLAccidents_Services.Layouts.search_bdid,
				           self.isDeepDive := true, 
									 self := left)); 
			
		by_deep_bdids := if(not in_mod.noDeepDive,FLAccidents_Services.Raw.byBDIDs(deep_bdids));

		// Lookup by Accident Number
    by_accnbr := dataset([{(string9)in_mod.Accident_Number,false}],FLAccidents_Services.Layouts.search);

		// Lookup by BDID
		bdid_ds := dataset([{(unsigned6)in_mod.bdid,false}],FLAccidents_Services.Layouts.search_bdid);
		by_bdid := if((unsigned6)in_mod.bdid > 0,FLAccidents_Services.Raw.byBDIDs(bdid_ds));
		
		// Lookup by DID
		did_ds := dataset([{(unsigned6)in_mod.did,false}],FLAccidents_Services.Layouts.search_did);
		by_did := if((unsigned6)in_mod.did > 0,FLAccidents_Services.Raw.byDIDs(did_ds));

		// Lookup by Driver License Number
    dlnbr_ds := dataset([{(string15)in_mod.DL_Nbr,false}],FLAccidents_Services.Layouts.search_dlnbr);
		by_dlnbr := if(in_mod.DL_Nbr <> '',FLAccidents_Services.Raw.byDLNbr(dlnbr_ds));
		
		// Lookup by Tag Number
    tagnbr_ds := dataset([{(string8)in_mod.Tag_Number,false}],FLAccidents_Services.Layouts.search_tagnbr);
		by_tagnbr := if(in_mod.Tag_Number <> '',FLAccidents_Services.Raw.byTagNbr(tagnbr_ds));

		// Lookup by VIN
    vin_ds := dataset([{(string22)in_mod.vin_in,false}],FLAccidents_Services.Layouts.search_vin);
		by_vin := if(in_mod.vin_in <> '',FLAccidents_Services.Raw.byVIN(vin_ds));
		
	
    blank_set := dataset([],FLAccidents_Services.Layouts.search);
		
	  //Combine results by accnbr, dlnbr, tagnbr & vin
    result_by_number := if(in_mod.Accident_Number <> '', by_accnbr, blank_set) + 
		                    if(in_mod.DL_Nbr          <> '', by_dlnbr, blank_set)  +
												if(in_mod.Tag_Number      <> '', by_tagnbr, blank_set) +
                        if(in_mod.vin_in          <> '', by_vin, blank_set);

    // Determine accident numbers to be returned                         
		temp_accnbrs := map(
			in_mod.Accident_Number <> '' or in_mod.DL_Nbr <> '' or 
			     in_mod.Tag_Number <> '' or in_mod.vin_in <> ''
						                       => result_by_number,
      (unsigned6)in_mod.bdid <> 0  => by_bdid,
			(unsigned6)in_mod.did  <> 0  => by_did,
			by_auto + by_deep_dids + by_deep_bdids
			);
	
		accnbrs_deduped := dedup(sort(temp_accnbrs, accident_nbr, isDeepDive), accident_nbr);
		
    //Uncomment lines below as needed to assist in debugging
    //output(in_mod.nodeepdive,named('si_nodeepdive'));
    //output(by_auto,named('si_by_auto'));
		//output(deep_dids,named('si_deep_dids'));
  	//output(by_deep_dids,named('si_by_deep_dids'));
		//output(deep_bdids,named('si_deep_bdids'));
		//output(by_deep_bdids,named('si_by_deep_bdids'));	
		//output(by_accnbr,named('si_by_accnbr'));
		//output(by_bdid,named('si_by_bdid'));
		//output(by_did,named('si_by_did'));
		//output(by_dlnbr,named('si_by_dlnbr'));
		//output(by_tagnbr,named('si_by_tagnbr'));
		//output(by_vin,named('si_by_vin'));
		//output(result_by_number,named('si_result_by_number'));	
		//output(temp_accnbrs,named('si_temp_accnbrs'));
		//output(accnbrs_deduped,named('si_accnbrs_deduped'));

		return accnbrs_deduped;
	end;
	
end;