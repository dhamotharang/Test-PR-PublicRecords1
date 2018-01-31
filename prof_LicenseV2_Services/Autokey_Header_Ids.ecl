import AutokeyB2,doxie,Prof_LicenseV2, business_header, 
       doxie_cbrs,Ingenix_NatlProf,ut,AutoKeyI,AutoStandardI,AutoHeaderI;

export Autokey_Header_ids := MODULE

export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface, AutoStandardI.InterfaceTranslator.nodeepdive.params)
		export boolean workHard := true;
		export boolean noFail := false;
	end;		 			
	
shared local_get_dids := PROJECT (doxie.Get_Dids(true,true), doxie.layout_references);
	
export val_prolic(params in_params) := function

		tmp_comp_name_value :=  AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_params,
																 AutoStandardI.InterfaceTranslator.comp_name_value.params)); 
		tmp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_params,
																 AutoStandardI.InterfaceTranslator.lname_value.params)); 
		tmp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_params,
																 AutoStandardI.InterfaceTranslator.phone_value.params)); 
		tmp_addr_value :=	 AutoStandardI.InterfaceTranslator.addr_value.val(project(in_params,
																 AutoStandardI.InterfaceTranslator.addr_value.params)); 
											
		 boolean is_CompSearchL := tmp_comp_name_value <> '' or tmp_phone_value <> '' or Business_Header.stored_bdid_value > 0;
		 boolean is_ContSearchL := tmp_lname_value <> '' or tmp_phone_value <> '' or tmp_addr_value <> '';	

		 outrec_prolic := Prof_LicenseV2_Services.layout_search_IDs_Prolic;
		 

		//****** SEARCH THE AUTOKEYS
		 t1 := Prof_LicenseV2.Constants.autokey_qa_name;
		 
		 ds_prolic := dataset([],Prof_LicenseV2.Layouts_ProfLic.Layout_Autokeys);
		 
		 typestr := 'BC';

		tempmod_prolic := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := t1;
			export string typestr := ^.typestr;
			export set of string1 get_skip_set := prof_licensev2.constants.skip_set;
			export boolean workHard := in_params.workHard;
			export boolean noFail := in_params.noFail;
			export boolean useAllLookups := true;
		end;
		 ids_Prolic := AutoKeyI.AutoKeyStandardFetch(tempmod_prolic).ids;


		//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
		Prof_LicenseV2_Services.mac_get_payload_ids(ids_prolic,t1,ds_prolic,outpl_prolic,did,bdid,prolic_seq_id, typestr,, newdids_prolic, newbdids_prolic)


		//***** DIDs
		 //dids := if(is_ContSearchL,doxie.Get_Dids(true,true),dataset([],doxie.layout_references));
		 dids := if(is_ContSearchL,local_get_dids,dataset([],doxie.layout_references));
		 //local_get_dids

		 newbydid_prolic := prof_LicenseV2_Services.Prof_Lic_Raw.get_Prolic_seq_id_from_dids(dedup(newdids_prolic
																																															//+newdids_sanc+newdids_prov
																																															+dids,all));

		//***** BDIDs
		tempbhmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
			export boolean score_results := false;
			export boolean noFail := true;
		end;
		 bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));

		 newbybdid := prof_LicenseV2_Services.Prof_Lic_Raw.get_Prolic_seq_id_from_bdids(dedup(newbdids_prolic+bdids,all));

		//***** FOR DEEP DIVES
		 DeepDives_prolic    := project(newbydid_prolic + newbybdid, transform(outrec_prolic, self.isDeepDive := true, self := left));
		 
		//****** IDS DIRECTLY FROM THE PAYLOAD KEY
		 byak_prolic := project(outpl_prolic(Prolic_seq_id<>0), outrec_prolic);
		 
		 dups_prolic := byak_prolic +
					if(NOT in_params.nodeepdive, deepDives_prolic);
						// include deep dive set to true by internal function not global module.
					
		 prolic_ids := dedup(sort(dups_prolic, Prolic_seq_id, if(isDeepDive,1,0)), Prolic_seq_id);

		return prolic_ids;
end;

/////////////////////////////////////////////////

export val_sanc(params in_params) := function


tmp_comp_name_value :=  AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.comp_name_value.params)); 
tmp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.lname_value.params)); 
tmp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.phone_value.params)); 
tmp_addr_value :=	 AutoStandardI.InterfaceTranslator.addr_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.addr_value.params)); 

 boolean is_CompSearchL  := tmp_comp_name_value <> '' or tmp_phone_value <> '' or Business_Header.stored_bdid_value > 0;
 boolean is_ContSearchL  := tmp_lname_value <> '' or tmp_phone_value <> '' or tmp_addr_value <> '';	

 outrec_sanc := Prof_LicenseV2_Services.layout_search_IDs_Sanc;

//****** SEARCH THE AUTOKEYS

 t2 := Ingenix_NatlProf.Constants.Autokey_qa_name_sanc;
 ds_sanc := dataset([],Prof_LicenseV2_Services.Assorted_Layouts.Layout_Autokeys_Sanc);

 typestr := 'BC';

tempmod_sanc := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t2;
	export string typestr := ^.typestr;
	export set of string1 get_skip_set := Ingenix_NatlProf.Constants.autokey_skip_set_sanc;

	
		export boolean workHard := in_params.workHard;
	export boolean noFail := in_params.noFail;
	
	export boolean useAllLookups := true;
end;
 ids_sanc := AutoKeyI.AutoKeyStandardFetch(tempmod_sanc).ids;

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS

Prof_LicenseV2_Services.mac_get_payload_ids(ids_sanc,t2,ds_sanc,outpl_sanc,did,zero,sanc_id, typestr,, newdids_sanc,newbdids_sanc)

//***** DIDs
 dids := if(is_ContSearchL,local_get_dids,dataset([],doxie.layout_references));

 newbydid_sanc := prof_LicenseV2_Services.Prof_Lic_Raw.get_Sanc_ids_from_dids(dedup(newdids_sanc + dids,all));

//***** BDIDs
tempbhmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
	export boolean score_results := false;
	export boolean noFail := true;
end;
 bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));

 //newbybdid := prof_LicenseV2_Services.Prof_Lic_Raw.get_Prolic_seq_id_from_bdids(dedup(newbdids_prolic+bdids,all));

//***** FOR DEEP DIVES

 DeepDives_sanc   := project(newbydid_sanc, transform(outrec_sanc, self.isDeepDive := true, self := left));
 

//****** IDS DIRECTLY FROM THE PAYLOAD KEY
 
 byak_sanc := project(outpl_sanc(sanc_id<>''), transform(outrec_sanc, self.sanc_id := (unsigned6) left.sanc_id));

 dups_sanc := byak_sanc +
			if(NOT in_params.nodeepdive,deepDives_sanc);
			// include deep dive set to true by internal function not global module.
			
 sanc_ids := dedup(sort(dups_sanc,sanc_id,if(isDeepDive,1,0)),sanc_id);

return sanc_ids;

end;

/////////////////////////////////////////////////

export val_prov(params in_params) := function


tmp_comp_name_value :=  AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.comp_name_value.params)); 
tmp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.lname_value.params)); 
tmp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.phone_value.params)); 
tmp_addr_value :=	 AutoStandardI.InterfaceTranslator.addr_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.addr_value.params));
										 									
boolean is_CompSearchL  := tmp_comp_name_value <> '' or tmp_phone_value <> '' or Business_Header.stored_bdid_value > 0;
boolean is_ContSearchL  := tmp_lname_value <> '' or tmp_phone_value <> '' or tmp_addr_value <> '';	

 outrec_prov := Prof_LicenseV2_Services.layout_search_IDs_Prov;

//****** SEARCH THE AUTOKEYS

 t3 := Ingenix_NatlProf.Constants.Autokey_qa_name_Prov;

 ds_prov := dataset([],Prof_LicenseV2_Services.Assorted_Layouts.Layout_Autokeys_Prov);

 typestr := 'BC';

tempmod_prov := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t3;
	export string typestr := ^.typestr;
	export set of string1 get_skip_set := Ingenix_NatlProf.Constants.autokey_skip_set_prov;
	
  export boolean workHard := in_params.workHard;
	export boolean noFail := in_params.noFail;
	
	export boolean useAllLookups := true;
end;
 ids_prov := AutoKeyI.AutoKeyStandardFetch(tempmod_prov).ids;

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS

Prof_LicenseV2_Services.mac_get_payload_ids(ids_prov,t3,ds_prov,outpl_prov,did,zero,Providerid, typestr,, newdids_prov,newbdids_prov)

//***** DIDs
 dids := if(is_ContSearchL,local_get_dids,dataset([],doxie.layout_references));

 newbydid_prov := prof_LicenseV2_Services.Prof_Lic_Raw.get_Prov_ids_from_dids(dedup(newdids_prov + dids,all));

//***** BDIDs
tempbhmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
	export boolean score_results := false;
	export boolean noFail := true;
end;
 bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));

 //newbybdid := prof_LicenseV2_Services.Prof_Lic_Raw.get_Prolic_seq_id_from_bdids(dedup(newbdids_prolic+bdids,all));

//***** FOR DEEP DIVES
 
 DeepDives_prov    := project(newbydid_prov, transform(outrec_prov, self.isDeepDive := true, self := left));

//****** IDS DIRECTLY FROM THE PAYLOAD KEY
 
 byak_prov := project(outpl_prov(providerid<>''), transform(outrec_prov, self.providerid := (unsigned6) left.providerid) );

 dups_prov := byak_prov +
		if(NOT in_params.nodeepdive, DeepDives_prov); // include deep dive set to true by internal function not global module.

 prov_ids := dedup(sort(dups_prov,providerId,if(isDeepDive,1,0)),providerId);

return prov_ids;

END;
end; // module;