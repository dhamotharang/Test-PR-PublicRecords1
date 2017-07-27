import autokeyb,autokeyb2,doxie,doxie_raw,business_header,doxie_cbrs,corp2,roxieKeyBuild,AutoKeyI,AutoStandardI;

export autokey_ids := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
	end;
	export val(params in_mod,boolean workhard = false, boolean nofail =false, boolean NoDeepDives = false, 
	boolean isCorp2_1_find =false,boolean isCorp2_1_Cont_find=false) := 
	FUNCTION
		
		it := AutoStandardI.InterfaceTranslator;
		
		temp_company_name_value := it.company_name_value.val(in_mod);
		temp_fein_value := it.fein_value.val(in_mod);
		temp_phone_value := it.phone_value.val(in_mod);
		
		boolean OnlyCompanySearch := temp_company_name_value <> '';
		boolean PersonOnly := temp_fein_value =0 and temp_company_name_value='' and temp_phone_value='';

		outrec := corp2_services.Layout_Search_IDs;

		//****** SEARCH THE AUTOKEYS
		t := '~thor_data400::key::corp2::qa::autokey::';
		ds := dataset([],corp2_services.assorted_layouts.layout_common);
		typestr :='BC';
		skipset := map(isCorp2_1_Find=>['C'],
									 isCorp2_1_Cont_Find=>['B'],
									 OnlyCompanySearch=>['C'],
									 PersonOnly => ['B'],
									 []);
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := t;
			export string typestr := ^.typestr;
			export set of string1 get_skip_set := ^.skipset;
			export boolean workHard := ^.workHard;
			export boolean noFail := ^.noFail;
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;


		//output(persononly,named('skipset'));	
					
		//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
		Corp2_services.mac_get_payload_ids(ids,t,ds,outpl,person_did,bdid, typestr,, newdids, newbdids)


		//***** DIDs  
		newbydid := corp2_services.corp2_raw. get_corpkeys_from_dids(newdids);

		//***** BDIDs
		newbybdid := corp2_services.corp2_raw.get_corpkeys_from_bdids(newbdids);

		//***** FOR DEEP DIVES
		DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));

		//****** IDS DIRECTLY FROM THE PAYLOAD KEY
		byak := project(outpl, outrec);

		boolean includeDeepDive := not NoDeepDives;

		dups := byak +  
					if(includeDeepDive, deepDives);

		return dedup(sort(dups, corp_key, if(isDeepDive,1,0)), corp_key);

	END;

end;




