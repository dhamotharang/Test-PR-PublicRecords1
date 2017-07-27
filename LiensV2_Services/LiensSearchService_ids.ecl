import doxie_cbrs,doxie,liensv2_services,AutoStandardI,AutoHeaderI,TopBusiness_Services;



it := AutoStandardI.InterfaceTranslator;

inner_params2  := interface(LiensV2_Services.IParam.search_params,
														it.company_name_value.params,
														it.phone_value.params,
														it.fein_value.params)
end;


outrec 				:= LiensV2_Services.layout_search_IDs;

inner_id_search (inner_params2 in_mod, boolean isMoxie = false,string1 in_party_type, boolean isFCRA=false, boolean returnByDidOnly = false) := function
		temp_company_name_value := it.company_name_value.val(in_mod);
		temp_phone_value := it.phone_value.val(in_mod);
		temp_fein_value := it.fein_value.val(in_mod);
		
		temp_incDeepDive := not in_mod.noDeepDive;
		temp_did_value := in_mod.did; 
		temp_bdid_value := in_mod.bdid;
		temp_lname_value := in_mod.lname;
		temp_liencasenumber_value := in_mod.liencasenumber;
		temp_state_value := in_mod.state;
		temp_FilingNumber_value := in_mod.FilingNumber;
		temp_IRSSerialNumber_value := in_mod.IRSSerialNumber;

		boolean is_CompSearchL := temp_company_name_value <> '' or temp_phone_value <> '' or temp_fein_value > 0 or temp_bdid_value <> '';
		boolean is_ContSearchL := temp_lname_value <> '';								 
		boolean ShouldMatchBoth := is_CompSearchL and is_ContSearchL;
    
		//***** AUTOKEY PIECE
		temp_auto_mod := module(project(in_mod,LiensV2_Services.IParam.ak_params,opt))end;
		byak := liensv2_services.Autokey_ids(false,false,isMoxie,temp_incDeepDive,isFCRA,temp_auto_mod);

		//***** deepdive  header DIDs
		temp_did_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
			export forceLocal := true;
			export noFail := true;
		end;
		dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod);	
		bydid := liensv2_services.liens_raw.get_rmsids_from_dids(dids,,,in_party_type); //used when isFCRA is false only

		//***** deepdive header BDIDs
		temp_bdid_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
			export boolean nofail := true;
		end;
		bdids  := if(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));
		bybdid := liensv2_services.liens_raw.get_rmsids_from_bdids(project(bdids,doxie_cbrs.layout_references),,,in_party_type); //used when isFCRA is false only

		//********* input DID
		in_did  := dataset([{temp_did_value}],doxie.layout_references);
		by_did := liensv2_services.liens_raw.get_tmsids_from_dids(in_did,,IsFCRA);

		//********* input BDID
		in_bdid := dataset([{temp_bdid_value}],doxie_cbrs.layout_references);
		by_bdid := liensv2_services.liens_raw.get_tmsids_from_bdids(in_bdid,,,isFCRA);
    
		//********* input business ids
		in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(in_mod);
		by_bids := liensv2_services.liens_raw.get_tmsids_from_bids(in_bids,in_mod.BusinessIDFetchLevel);

		//***** CASENUMBER ST
		dscnst := dataset([{temp_liencasenumber_value,temp_state_value}],LiensV2_Services.layout_casenumber_st);

		bycnst := if(temp_liencasenumber_value <> '',
					 liensv2_services.liens_raw.get_rmsids_from_casenumber_st(dscnst, isFCRA));		 
					 
		//***** FILING NUMBER
		dsfn := dataset([{temp_FilingNumber_value,temp_state_value}], liensv2_services.layout_filing_number);
		byfn := if(temp_FilingNumber_value <> '', 
						liensv2_services.liens_raw.get_rmsids_from_Filing_Number(dsfn, isFCRA));

		//***** IRS SERIAL NUMBER
		dssn := dataset([{temp_IRSSerialNumber_value}], LiensV2_Services.layout_IRS_Serial_Number);
		dssncn := dataset([{temp_IRSSerialNumber_value}], LiensV2_Services.layout_CertificateNumber);

		bysn := if(temp_IRSSerialNumber_value <> '', 
		liensv2_services.liens_raw.get_rmsids_from_IRS_Serial_Number(dssn, isFCRA) +
		liensv2_services.liens_raw.get_rmsids_from_CertificateNumber(dssncn, isFCRA));

		//***** CERTIFICATE NUMBER
		dscn := dataset([{in_mod.CertificateNumber}], LiensV2_Services.layout_CertificateNumber);
		dscnsn := dataset([{in_mod.CertificateNumber}], LiensV2_Services.layout_IRS_Serial_Number);
		bycn := if(in_mod.CertificateNumber <> '',
						liensv2_services.liens_raw.get_rmsids_from_CertificateNumber(dscn, isFCRA) +
		liensv2_services.liens_raw.get_rmsids_from_IRS_Serial_Number(dscnsn, isFCRA));
		
		//***** RMSID
		dsrmsid := dataset([{'',in_mod.rmsid}], liensv2_services.layout_rmsid);

		byrmsid := if(in_mod.rmsid <> '', 
						liensv2_services.liens_raw.get_tmsids_from_rmsids(dsrmsid, isFCRA));

		//***** GATHER TMSIDS
		bytmsid := if(in_mod.tmsid <> '', 
						dataset([{in_mod.tmsid,''}],liensv2_services.layout_rmsid));

		//***** 'AND' THE DID AND BDID RESULTS WHEN APPROPRIATE
		did_bdid_anded := if(ShouldMatchBoth,
							 join(bydid, bybdid, left.tmsid = right.tmsid),
							 bydid + bybdid);

		//***** ALLOW USER TO IGNORE THESE DEEP DIVE RESULTS AND GET ONLY THE MORE OBVIOUS MATCHES
		did_bdid := if(temp_incDeepDive, did_bdid_anded);

		//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS

		// bug 30137 -- if a unique ID is provided as input, use it only (i.e., exclude the autokey and deepDive results)
		// use the following order of preference in the event multiple unique IDs are provided
		msids := map(
			returnByDidOnly => project(by_did,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
			in_mod.tmsid <> '' => project(bytmsid,transform(outrec,self.isDeepDive := FALSE, self := left)),
			in_mod.rmsid <> '' => project(byrmsid,transform(outrec,self.isDeepDive := FALSE, self := left)),
			temp_liencasenumber_value <> '' => project(bycnst,transform(outrec,self.isDeepDive := FALSE, self := left)),
			temp_FilingNumber_value <> '' => project(byfn,transform(outrec,self.isDeepDive := FALSE, self := left)),
			temp_IRSSerialNumber_value <> '' => project(bysn,transform(outrec,self.isDeepDive := FALSE, self := left)),
			in_mod.CertificateNumber <> '' => project(bycn,transform(outrec,self.isDeepDive :=FALSE, self := left)),
			temp_did_value <>'' => project(by_did,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
			temp_bdid_value <>'' => project(by_bdid,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
      ~isFCRA and exists(in_bids) => project(by_bids,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
			byak + if (not isFCRA, project(did_bdid, transform(outrec, self.isDeepDive := TRUE, self := left))));
   
	 // returns 2 records if same records is found via deepDive and non-DeeepDive methods.
    recs :=  dedup(sort(msids, tmsid, rmsid, isDeepDive), tmsid, rmsid, isDeepDive);
		        
		return(recs);
		
end;


export LiensSearchService_ids(LiensV2_Services.IParam.search_params in_params,
															boolean isMoxie = false,
															boolean isFCRA=false) := FUNCTION
		boolean isCollections :=  in_params.applicationType IN AutoStandardI.Constants.COLLECTION_TYPES;
		boolean returnByDidOnly := (in_params.subject_only or isCollections) and isFCRA;
		temp_mod_one := module(project(in_params,inner_params2,opt))end;
		
		gm := autostandardi.globalmodule(isfCRA);
		temp_mod_two := module(project(gm,inner_params2,opt))
			export nofail := true;
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
			export CertificateNumber := in_params.CertificateNumber;
		end;

		party_one_results := inner_id_search(temp_mod_one,isMoxie,in_params.partyType,isFCRA, returnByDidOnly);
		party_two_results := inner_id_search(temp_mod_two,isMoxie,in_params.partyType,isFCRA);

		two_party_search_results := join(party_one_results,
																		party_two_results,
																		left.tmsid = right.tmsid,
																		transform(left),
																		keep(1),
																		limit(0));

		selected_results := if(gm.TwoPartySearch and ~returnByDidOnly,
													 two_party_search_results,
													 party_one_results);

		return selected_results;

END;