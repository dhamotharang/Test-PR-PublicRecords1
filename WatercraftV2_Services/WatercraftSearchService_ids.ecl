import AutoStandardI,AutoHeaderI, doxie, doxie_cbrs;

it 						:= AutoStandardI.InterfaceTranslator;
outrec 				:= watercraftV2_services.Layouts.search_watercraftkey;
global_mod(boolean isFCRA = false):= AutoStandardI.GlobalModule(isFCRA);

inner_params2  := interface(Interfaces.ak_params,
	it.company_name_value.params,
	it.phone_value.params,
	it.fein_value.params
	)
end;

inner_party_search (inner_params2 in_mod, boolean isFCRA = false) := function
		temp_company_name_value := it.company_name_value.val(in_mod);
		temp_phone_value := it.phone_value.val(in_mod);
		temp_fein_value := it.fein_value.val(in_mod);
		
		boolean is_CompSearchL := temp_company_name_value <> '' or temp_phone_value <> '' or temp_fein_value > 0;
		
		//********* Autokeys
		byak := WatercraftV2_services.autokey_ids.val(in_mod,false, false);
		
		//********* DIDS
		dids := if(isFCRA or in_mod.NoDeepDive, 
				dataset([{in_mod.DID}],doxie.layout_references),
				PROJECT (doxie.Get_Dids(true, true), doxie.layout_references));

		bydid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_dids(dids, isFCRA);

		//********* BDIDS
		tempbhmod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
			export boolean nofail := true;
		end;
		bdids := if(is_CompSearchL and ~in_mod.NoDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),dataset([{in_mod.BDID}], doxie_cbrs.layout_references));

		bybdid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_bdids(project(bdids,doxie_cbrs.layout_references));

		//***********BDIDS and DIDS together
		by_bdid_and_did :=bydid+bybdid;
		watercraft_keys := 
			dedup( byak + project(by_bdid_and_did,transform(outrec,self.isDeepDive := ~in_mod.NoDeepDive and ~isFCRA,self :=left)),
						 all);
		
		final_watercraft_keys := if(isFCRA, bydid, watercraft_keys);												
																										
	return final_watercraft_keys;

END;

inner_watercraftid_search(WatercraftV2_Services.Interfaces.search_params in_mod) := function

		//*********hullnum
		hullnum :=dataset([{in_mod.hull_num}],WatercraftV2_services.Layouts.search_hullnum);
		byhullnum :=if(in_mod.hull_num <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_hullnum(hullnum));

		//*********Official Number
		offnum := dataset([{in_mod.off_num}],watercraftV2_services.Layouts.search_offnum);
		byoffnum := if(in_mod.off_num <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_offnum(offnum)); //as of August 2012, offnum key is blank

		//*********vesselname
		vslname :=dataset([{in_mod.vesl_nam}],WatercraftV2_services.layouts.search_vesselname);
		byvslname :=if(in_mod.vesl_nam <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_vesselname(vslname));

		//*********Watercraft_key
		byWatercraft_key := if(in_mod.wk <> '', dataset([{in_mod.wk,in_mod.seqk,in_mod.st}],outrec));
				
		//*********Select Search
		final_watercraft_keys := MAP(in_mod.wk <> '' => byWatercraft_key,
															in_mod.hull_num <> '' => byhullnum,
															in_mod.vesl_nam <> '' => byvslname,
															byoffnum);
													 																
	return final_watercraft_keys;
end;

export WatercraftSearchService_ids(WatercraftV2_Services.Interfaces.Search_params in_params, 
																	 boolean isFCRA = false) := FUNCTION
																	
		boolean isIdSearch := in_params.wk <> '' or in_params.hull_num <> '' or in_params.vesl_nam <> '';
		id_search := inner_watercraftid_search(in_params);

		gm := global_mod(isFCRA);
		temp_mod1 := module(project(in_params, inner_params2, opt)) end;
		temp_mod2 := module(project(gm,inner_params2,opt))
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
		
		party_one_results := inner_party_search(temp_mod1, isFCRA);
		party_two_results := inner_party_search(temp_mod2);
		
		two_party_search_results := join(party_one_results, party_two_results,
																		(left.watercraft_key = right.watercraft_key and
																		left.sequence_key = right.sequence_key),
																		transform(left),
																		keep(1),
																		limit(0));

		selected_party_results := if(gm.TwoPartySearch,
																 two_party_search_results,
																 party_one_results);
		
		selected_results := if(isIdSearch, id_search, selected_party_results);
		
		final_results := if(isFCRA, party_one_results, selected_results);
		
		return final_results;

END;