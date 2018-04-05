import AutoKeyB2, AutoKeyI, AutoHeaderI, AutoStandardI, FBNv2, FBNv2_services;

export Autokey_Header_ids := module
	export params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
	end;
	export val(params in_mod,
		boolean workHard = true,boolean noFail = false,boolean includeDeepDive=true) := FUNCTION
		
		it := AutoStandardI.InterfaceTranslator;
		
		temp_company_name_value := it.company_name_value.val(in_mod);
		temp_phone_value := it.phone_value.val(in_mod);
		temp_bdid_value := it.bdid_value.val(in_mod);
		temp_lname_value := it.lname_value.val(in_mod);
		temp_addr_value := it.addr_value.val(in_mod);
		
		boolean is_CompSearchL := temp_company_name_value <> '' or temp_phone_value <> '' or temp_bdid_value > 0;
		boolean is_ContSearchL := temp_lname_value <> '' or temp_phone_value <> '' or temp_addr_value <> '';	

		outrec := FBNV2_Services.layout_search_IDs;

		//****** SEARCH THE AUTOKEYS
		t := FBNV2.Constant('').ak_QAname;
		ds := fbnv2.file_SearchAutokey(dataset([],FBNV2.Layout_Common.Business),dataset([],FBNV2.Layout_Common.Contact));
		typestr := 'BC';
		tempmod := module(project(in_mod,autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := t;
			export string typestr := ^.typestr;
			export set of string1 get_skip_set := ['S','F'];
			export boolean workHard := ^.workHard;
			export boolean noFail := ^.noFail;
			export boolean useAllLookups := true;
		end;
		ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

		//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
		AutokeyB2.mac_get_payload_ids(ids,t,ds,outpl,did,bdid, typestr,, newdids, newbdids, olddids, oldbdids)

		//***** DIDs
		temp_did_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
			export forceLocal := true;
			export noFail := true;
		end;
		dids := if(is_ContSearchL,
			PROJECT(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod), doxie.layout_references));
			
		newbydid := FBNv2_services.FBN_raw.get_rmsids_from_dids(dedup(newdids+dids,all));

		//***** BDIDs
		tempbhmod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
			export boolean score_results := false;
			export boolean nofail := true;
		end;
		bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));

		newbybdid := FBNv2_services.FBN_raw.get_rmsids_from_bdids(dedup(newbdids+bdids,all));

		//***** FOR DEEP DIVES
		DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));


		//****** IDS DIRECTLY FROM THE PAYLOAD KEY
		byak := project(outpl(tmsid<>''), outrec);

		dups := byak + 
					if(includeDeepDive, deepDives);

		return dedup(sort(dups, tmsid, rmsid, if(isDeepDive,1,0)), tmsid, rmsid);

	END;

end;