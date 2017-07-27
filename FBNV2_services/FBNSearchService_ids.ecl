import AutoStandardI, doxie, doxie_cbrs;

it := AutoStandardI.InterfaceTranslator;

outrec := FBNV2_Services.layout_search_IDs;

inner_params := interface(
	Autokey_Header_ids.params,
	it.bdid_dataset.params,
	it.filingnumber_value.params,
	it.tmsid_value.params,
	it.rmsid_value.params)
end;

inner_id_search(
	inner_params in_mod,
	boolean includeDeepDive = true,boolean is_search) := 
FUNCTION

	temp_filingnumber_value := it.filingnumber_value.val(in_mod);
	temp_bdid_value := it.bdid_value.val(in_mod);
	temp_did_value := it.did_value.val(in_mod);
	temp_tmsid_value := it.tmsid_value.val(in_mod);
	temp_rmsid_value := it.rmsid_value.val(in_mod);
	temp_bdid_dataset := it.bdid_dataset.val(in_mod);
	
	//***** AUTOKEY PEICE
	byak := if(is_search, FBNV2_services.Autokey_Header_ids.val(in_mod,false,false,includeDeepDive));
					 
	//***** FILING NUMBER
	dsfn := dataset([{temp_filingnumber_value}], FBNv2_services.layout_filingnumber);
	byfn := if(temp_filingnumber_value <> '', 
					FBNv2_services.FBN_raw.get_rmsids_from_FilingNumber(dsfn));

	//*****BDID 
	bybdid := if(temp_bdid_value <>0,FBNV2_services.FBN_raw.get_rmsids_from_bdids(project(temp_bdid_dataset,doxie_cbrs.layout_references)));		

	//*****DID
	dsdid := dataset([{temp_did_value}], doxie.layout_references);
	bydid := if(temp_did_value <>'',FBNV2_services.FBN_raw.get_rmsids_from_dids(dsdid));

	//***** GATHER TMSIDS
	bytmsid := if(temp_tmsid_value <> '' or temp_rmsid_value <> '', 
					dataset([{temp_tmsid_value,temp_rmsid_value}],FBNV2_services.layout_rmsid));

	//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
	msids := byak +
			 project(bytmsid + byfn + bydid + bybdid, 
			transform(outrec, self.isDeepDive := FALSE, self := left));

	return dedup(sort(msids, tmsid, rmsid, if(isDeepDive, 1, 0)), tmsid, rmsid);

end;

export FBNSearchService_ids(
	boolean includeDeepDive = true,boolean is_search) := function

	gm := AutoStandardI.GlobalModule();
	
	temp_mod_one := module(project(gm,inner_params,opt))
		// export nofail := true;
	end;
	temp_mod_two := module(project(gm,inner_params,opt))
		// export nofail := true;
		export firstname := gm.entity2_firstname;
		export middlename := gm.entity2_middlename;
		export lastname := gm.entity2_lastname;
		export unparsedfullname := gm.entity2_unparsedfullname;
		export allownicknames := gm.entity2_allownicknames;
		export phoneticmatch := gm.entity2_phoneticmatch;
		export companyname := gm.entity2_companyname;
		export addr := gm.entity2_addr;
		export city := gm.entity2_city;
		export state := gm.entity2_state;
		export zip := gm.entity2_zip;
		export zipradius := gm.entity2_zipradius;
		export phone := gm.entity2_phone;
		export fein := gm.entity2_fein;
		export bdid := gm.entity2_bdid;
		export did := gm.entity2_did;
		export ssn := gm.entity2_ssn;
	end;
	party_one_results := inner_id_search(temp_mod_one,includeDeepDive,is_search);
	party_two_results := inner_id_search(temp_mod_two,includeDeepDive,is_search);
	// output(party_one_results);
	// output(party_two_results);
	two_party_search_results := join(
		party_one_results,
		party_two_results,
		left.tmsid = right.tmsid,
		transform(left),
		keep(1),
		limit(0));
	
	return if(gm.TwoPartySearch,
		two_party_search_results,
		party_one_results);

END;