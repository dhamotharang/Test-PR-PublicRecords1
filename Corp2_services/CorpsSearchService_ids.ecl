import ut,doxie,doxie_cbrs,AutoStandardI,AutoHeaderI;

export CorpsSearchService_ids := module

	export inner_params := interface(
		corp2_services.autokey_ids.params,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base
	)
		export string32 CharterNumber;
		export string30 CorpKey;
		export boolean NoDeepDive;
	end;

	export inner_id_search(
		inner_params in_mod
	) := function
		
		it := AutoStandardI.InterfaceTranslator;
		
		temp_company_name_value := it.company_name_value.val(in_mod);
		temp_phone_value := it.phone_value.val(in_mod);
		temp_fein_value := it.fein_value.val(in_mod);
		temp_bdid_value := it.bdid_value.val(in_mod);
		temp_lname_value := it.lname_value.val(in_mod);
		temp_did_value := it.did_value.val(in_mod);
		
		boolean is_CompSearchL := temp_company_name_value <> '' or temp_phone_value <> '' or temp_fein_value > 0 or temp_bdid_value > 0;
		boolean is_ContSearchL := temp_lname_value <> '';								 

		//********* Autokeys
		outrec := corp2_services.layout_search_IDs;
		
		// Get all possible variations of the company Name, true to indicate I want the original string in the result
		CompNameSet := ut.StringSetSubstitute.replaceAllComb(it.company_name_value.val(in_mod),true);
		CompNameRecs := DATASET([CompNameSet],{string200 comp_name;});

		outAutorec := RECORD
			DATASET(corp2_services.Layout_Search_IDs) corpKeys;
		END;
		
		// Transform that will populate store the returned corpKeys for each version of the 
		// company name.
		outAutorec searchAutoKeys({string200 comp_name;} l, INTEGER cnt) := TRANSFORM
			in_modA := module(PROJECT(in_mod,inner_params,opt))
				export companyname := l.comp_name;
			end;
			SELF.corpKeys := IF(cnt > 1, corp2_services.autokey_ids.val(in_modA,false,false,in_modA.NoDeepDive),
																	 corp2_services.autokey_ids.val(in_modA,false,false,in_modA.NoDeepDive));
		END;
		
		srchRes := PROJECT(CompNameRecs,searchAutoKeys(LEFT,COUNTER));				

		// Returned results are in a denormalized format (nested children), normalize tham into indiv recs.
		byakEquiv := NORMALIZE(srchRes,LEFT.corpKeys,TRANSFORM(corp2_services.Layout_Search_IDs,SELF := RIGHT));
		byakNonEquiv := corp2_services.autokey_ids.val(in_mod, false, false,in_mod.NoDeepDive);
		
		// If acompany name is supplied, use the equivalent autokey lookup.
		byak := IF(temp_company_name_value != '',byakEquiv,byakNonEquiv); 
		
		//********* on deepdive retrieving header DIDS
		temp_did_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
			export forceLocal := true;
			export noFail := true;
		end;
		dids := if(~in_mod.NoDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod));

		bydid :=corp2_services.corp2_raw.get_corpkeys_from_dids(dids);

		//********* on deepdive retrieving header BDIDS
		tempbhmod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
			export boolean nofail := true;
		end;
		bdids := if(is_CompSearchL and ~in_mod.NoDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod));

		bybdid := corp2_services.corp2_raw.get_corpkeys_from_bdids(project(bdids,doxie_cbrs.layout_references));
		
		noleading(string charter) := regexfind('([^0].*)$',charter,0);

		//*********StCharter
		uchn := stringlib.stringtouppercase(in_mod.CharterNumber);
		uchn_noleading := noleading(uchn);
		charter_and_state :=dedup(dataset([{uchn,in_mod.State},{uchn_noleading,in_mod.State}],corp2_services.layout_charter_state),all);
		byStCharter :=if(uchn <>'',corp2_services.corp2_raw.get_corpkeys_from_charter_and_state(charter_and_state));

		//*********Corp_key
		uck :=stringlib.stringtouppercase(in_mod.CorpKey);
		byCorp_key := if(uck <> '', dataset([{uck}],corp2_services.layout_corpkey));

		//********* input DID
		in_did  := dataset([{temp_did_value}],doxie.layout_references);
		by_did := corp2_services.corp2_raw.get_corpkeys_from_dids(in_did);

		//********* input BDID
		in_bdid := dataset([{temp_bdid_value}],doxie_cbrs.layout_references);
		by_bdid := corp2_services.corp2_raw.get_corpkeys_from_bdids(in_bdid);

		//***********BDIDS and DIDS together
		by_bdid_and_did :=bydid+bybdid;
		corp_keys := byak +
								project(byCorp_key +byStCharter,transform(outrec,self.isDeepDive:=FALSE,self :=left))+
								project(by_bdid_and_did,transform(outrec,self.isDeepDive :=TRUE,self :=left))
								+PROJECT(by_did,transform(outrec,self.isDeepDive :=TRUE,self :=left))
								+PROJECT(by_bdid,transform(outrec,self.isDeepDive :=TRUE,self :=left));

		return dedup(sort(corp_keys,corp_key,if(isDeepDive, 1, 0)), corp_key);
	end;
	
	gm := AutoStandardI.GlobalModule();

	temp_mod_one := module(project(gm,inner_params,opt))
		export string32 CharterNumber := '' : stored('CharterNumber');
		export string30 CorpKey := '' : stored('CorpKey');
		export boolean workHard := true;
	end;
	temp_mod_two := module(project(temp_mod_one,inner_params,opt))
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

	party_one_results := inner_id_search(temp_mod_one);
	party_two_results := inner_id_search(temp_mod_two);

	two_party_search_results := join(
		party_one_results,
		party_two_results,
		left.corp_key = right.corp_key,
		transform(left),
			keep(1),
			limit(0));

	selected_results := if(gm.TwoPartySearch,
		two_party_search_results,
		party_one_results);
	
	EXPORT result_ids := dedup(sort(selected_results,corp_key,if(isDeepDive, 1, 0)), corp_key);

end;


