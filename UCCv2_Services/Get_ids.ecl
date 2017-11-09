IMPORT AutoKeyB2, doxie, UCCv2, UCCv2_Services, AutoKeyI, AutoHeaderI, Data_Services;

export Get_ids := module
export params := interface(
AutoKeyI.AutoKeyStandardFetchBaseInterface,
AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
end;
export val(params in_mod,
boolean workHard = true, 
boolean noFail = false, boolean noDeepDive = false,
	 boolean is_CompSearchL = false,string1 in_party_type) := function
		outrec := UCCv2_Services.layout_search_ids;

		constants		:= UCCV2.Constants(UCCv2.Version.key);
		ak_keyname	:= Data_Services.Data_location.Prefix('UCC') + 'thor_data400::key::ucc::autokey::';// constants.ak_keyname;
		ak_typeStr	:= constants.ak_typeStr;
		ak_dataset	:= UCCV2.file_SearchAutokey;

		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := [];
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		// Autokey
		AutokeyB2.mac_get_payload_ids (ids, ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr, , newdids, newbdids, olddids, oldbdids)
		by_auto := project(outpl, outrec);
	// did
	temp_did_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
			export forceLocal := true;
	export noFail := true;
	end;
	dids_from_input := PROJECT(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod), doxie.Layout_references);

	// bdid
	temp_bdid_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
	export boolean nofail := true;
	end;
	bdids_from_input  := if(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));
	// NEW vs OLD: probably old is not required anymore, which would make the code much easier to read,
	// for now I keep this portion untouched.
	//***** DIDs  (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
	oldbydid := UCCv2_Services.UCCRaw.get_rmsids_from_dids(olddids,in_party_type);
	newbydid := UCCv2_Services.UCCRaw.get_rmsids_from_dids(dedup (newdids + dids_from_input, all),in_party_type);
	//***** BDIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
	oldbybdid := UCCv2_Services.UCCRaw.get_rmsids_from_bdids(oldbdids,,,in_party_type);
	newbybdid := UCCv2_Services.UCCRaw.get_rmsids_from_bdids(dedup (newbdids + bdids_from_input, all),,,in_party_type);
	//***** FOR DEEP DIVES
	DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));
	NotDeepDives := project(oldbydid + oldbybdid, transform(outrec, self.isDeepDive := false, self := left));
	dups := by_auto +
	NotDeepDives +
	if(not noDeepDive, deepDives);
	return dedup(sort(dups, tmsid, rmsid, if(isDeepDive,1,0)), tmsid, rmsid);
end;
end;
