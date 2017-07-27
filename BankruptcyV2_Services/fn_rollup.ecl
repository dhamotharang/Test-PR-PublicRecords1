import AutoStandardI,bankruptcyv3,codes,doxie,doxie_cbrs,bankruptcyv2_services,BIPV2,CriminalRecords_Services, ut, Suppress,bankruptcyv3_services;

it := input.it;
gm := input.gm;
inner_params := input.params;
inner_id_search(input.params in_mod, 
									dataset(doxie.layout_references) in_dids,
									dataset(doxie_cbrs.layout_references) in_bdids,
									dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
                  dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids,
                  string1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID,
									unsigned in_limit,
									string6 in_ssn_mask,
									boolean in_isSearch = false,
									boolean in_all_bks_for_all_debtors = false,
									string1 in_party_type = '',
									string2 in_filing_jurisdiction = '',
									boolean isFCRA = false,
                  boolean includeCriminalIndicators = false,
									boolean in_include_AttorneyTrustee = false) := function
	doxie.MAC_Header_Field_Declare(isFCRA)
	//Initial lookup
	in_tmsids1 := bankruptcy_ids(in_dids,in_bdids,in_tmsids0,in_bids,bid_fetch_level,in_limit,in_party_type,isFCRA,in_mod);
	
	temp_records_search0 :=
				join(
					in_tmsids1,
					bankruptcyv3.key_bankruptcyV3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip()),
						self := right,
						self := left),
					keep(1000));
			temp_debtor_dids := project(dedup(sort(temp_records_search0((unsigned)did != 0 and name_type[1] = 'D'),did),did),transform(doxie.layout_references,self.did := (unsigned)left.did));
			temp_debtor_bdids := project(dedup(sort(temp_records_search0((unsigned)bdid != 0 and name_type[1] = 'D'),bdid),bdid),transform(doxie_cbrs.layout_references,self.bdid := (unsigned)left.bdid));
			
			//Additional lookup
      empty_bids := dataset([],BIPV2.IDLayouts.l_xlink_ids);
			temp_addl_tmsids := bankruptcyv2_services.bankruptcy_ids(temp_debtor_dids,temp_debtor_bdids,in_tmsids0(false),empty_bids,,if(in_limit = 0,0,in_limit - count(in_tmsids1)),in_party_type, isFCRA,in_mod);
      
			in_tmsids := in_tmsids1 + if(in_all_bks_for_all_debtors and (in_limit = 0 or count(in_tmsids1) < in_limit),temp_addl_tmsids);						
														 
			temp_records_search1 :=
				join(
					temp_addl_tmsids,
					bankruptcyv3.key_bankruptcyV3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip()),
						self := right,
						self := left),
					keep(1000));
			temp_records_search := temp_records_search0 + if(in_all_bks_for_all_debtors and (in_limit = 0 or count(in_tmsids1) < in_limit),temp_records_search1);

      // Pull any debtor records that are in the pull file
			temp_records_searchD := if (isFCRA, temp_records_search(name_type[1]='D'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='D'),false,application_type_value));
			// Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
			in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
				LEFT.tmsid = RIGHT.tmsid,
				TRANSFORM(LEFT));
			
			// Pull any attorney records that are in the pull file
			temp_records_searchA := if (isFCRA, temp_records_search(name_type[1]='A'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='A'),true,application_type_value)); // TRUE here means to pull ONLY the attorney being suppressed, not ALL attorneys
			// Pull any other records that are in the pull file
			temp_records_searchOthers := if (isFCRA, temp_records_search(name_type[1] <> 'A' AND name_type[1] <> 'D'),
			        fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1] <>'D'),true,application_type_value)); // this may be the empty set all the time??
			// Add together all records NOT pulled (including debtors)
			temp_records := sort(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);
			
  
			// pull IDs using the party info, then join those IDs back against the input set of tmsids
			
			//Trustee information with Bkv2 used to be available in the search key; however, in the Bkv3 it is available in the main key.
			//Below we are making sure to assign Criminal Indicators and timezone if trustee information are requested
			//we are also doing the trustee suppression similar to Bkv3
			//In addition, some fields used to be available in Bkv2 main key but are now available in the Bkv2 search key so we are also adding these now.
			temp_rec_main := record
				recordof(bankruptcyV3.key_bankruptcyV3_main_full());
				string4	 timezone :='';
				boolean HasCriminalConviction := false;
        boolean IsSexualOffender := false;
				boolean isDeepDive;
				STRING12 UniqueId;
				boolean SuppressT;
			end;
			
			temp_rec_mainT := record
				recordof(bankruptcyv3.key_bankruptcyv3_main_full());
				boolean isDeepDive;  
				boolean SuppressT;				
			end;

			temp_records_main := // need to account for suppressing attorney names in here.
				join(
					in_tmsids_less_pulled_by_debtor,
					bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(temp_rec_mainT,
						self := right,
						self := left,
						self.suppressT := false),
					keep(1000));
			
			temp_records_mainT := if(isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIDs(temp_records_main,application_type_value));
			temp_records_main_final := project(temp_records_mainT, 
				transform(temp_rec_main, 
					self.UniqueId := left.did, 
					self := left));
			
			// filter by jurisdiction if provided
			temp_records_main_jur0 := IF(in_filing_jurisdiction <> '', 
																	temp_records_main_final(filing_jurisdiction = in_filing_jurisdiction),
																	temp_records_main_final);
			
			suppressT := in_isSearch and ~in_include_AttorneyTrustee;
			Suppress.MAC_Mask(temp_records_main_jur0, trustees_masked, app_SSN, null, true, false, maskVal:=in_ssn_mask);
			ut.getTimeZone(trustees_masked,trusteePhone,timezone,temp_records_main_jur_w_tzone);			
			CriminalRecords_Services.MAC_Indicators(temp_records_main_jur_w_tzone,temp_records_main_jur_w_crim_indic);
			temp_records_main_jur := if(suppressT, temp_records_main_jur0, if(includeCriminalIndicators, temp_records_main_jur_w_crim_indic, temp_records_main_jur_w_tzone));
			
			BankruptcyV2_Services.layouts.layout_party_slim to_trustee(temp_rec_main L) := transform
				self.names := project(L, transform(BankruptcyV2_Services.layouts.layout_name,
					self.orig_name := left.trusteeName,
					self.ssn			 := left.app_ssn, //there are no ssn field
					self := left,
					self := [])); //no app_tax_id and tax_id fields
				self.addresses := project(L, transform(BankruptcyV2_Services.layouts.layout_address,
					self.orig_addr1 := left.trusteeAddress,
					self.orig_city := left.trusteeCity,
					self.orig_st := left.trusteeState,
					self.orig_zip5 := left.trusteeZip,
					self.orig_zip4 := left.trusteeZip4,
					self := left,
					self := [])); //orig_addr2, orig_county 
				self.phones := project(L, transform(BankruptcyV2_Services.layouts.layout_phone,
					self.phone := left.trusteePhone,
					self.timezone := left.timezone,
					self.orig_fax := '')); //no fax field
				self.emails := project(L, transform(BankruptcyV2_Services.layouts.layout_email,
					self.orig_email := left.trusteeEmail));
				self 			:= L;
				self.ssn	:= L.app_ssn;
				self 			:= []; //no app_tax_id, tax_id and BDID and BIP fields
			end;
			
			temp_top_slim :=
				join(
					temp_records_main_jur,
					temp_records_search,
					left.tmsid = right.tmsid,
					transform(
						bankruptcyv2_services.layouts.layout_rollup,
						self.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(left.filer_type),
						self.trustees							:= if(~suppressT and ~left.suppressT, project(left, to_trustee(left)));
						//fields that were in BKv2 main but now are in BKv3 search
						self.orig_filing_type_ex 	:= codes.BANKRUPTCIES.FILING_TYPE(right.filing_type),
						self.orig_filing_type		 	:= right.filing_type,
						self.chapter						 	:= right.chapter,
						self.pro_se_ind					 	:= right.pro_se_ind,
						self.disposed_date			 	:= right.discharged,
						self.disposition					:= right.disposition,
						self.corp_flag						:= right.corp_flag,
						self.converted_date				:= right.converted_date,
						self := left,
						self := []),
					LIMIT(0), KEEP(1)); //might have more than one match, but we only need to keep one of them
			temp_top_dedup :=
				dedup(
					sort(
						temp_top_slim,
						tmsid,record),
					tmsid);
// penalty
			temp_pen_slim :=
				project(
					temp_records,
					transform(
						bankruptcyv2_services.layouts.layout_rollup,
						self.penalt := fn_penalty(left);
						self.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT),
						self.matched_party.address :=  IF(DisplayMatchedParty_value,LEFT),
						self := left,
						self := []));

			temp_pen_dedup :=
				dedup(
					sort(
						temp_pen_slim,
						tmsid,penalt,record),
					tmsid);
			temp_top_join :=
				join(
					temp_top_dedup,
					temp_pen_dedup,
					left.tmsid = right.tmsid,
					transform(
						recordof(temp_pen_dedup),
						self.penalt := right.penalt,
						dmp := not left.isdeepdive;
						self.matched_party.party_type := if(dmp, right.matched_party.party_type,''),
						self.matched_party.parsed_party := if(dmp, right.matched_party.parsed_party),
						self.matched_party.address := if(dmp, right.matched_party.address);
						self := left
						),
					left outer);
			temp_top_add_debtors := join(
				temp_top_join,
				bankruptcyv2_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask,includeCriminalIndicators),
				left.tmsid = right.tmsid,
				transform(
					recordof(temp_top_dedup),
					self.debtors 							:= right.parties,
					self 											:= left),
				left outer);
			temp_top_add_attorneys :=
				if(in_isSearch and ~in_include_AttorneyTrustee,
					temp_top_add_debtors,
					join(
						temp_top_add_debtors,
						bankruptcyv2_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask,includeCriminalIndicators),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.attorneys := project(right.parties, BankruptcyV2_Services.layouts.layout_party_slim);
							self := left),
						left outer));
						
			temp_records_main_full := project(temp_records_main_jur,
																				recordof(bankruptcyv3.key_bankruptcyV3_main_full()));
						
			temp_top_add_status :=
				if(in_isSearch,
					temp_top_add_attorneys,
					join(
						temp_top_add_attorneys,
						bankruptcyv2_services.fn_rollup_statuses(temp_records_main_full),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.status_history := right.statuses,
							self := left),
						left outer));
			temp_top_add_comments :=
				if(in_isSearch,
					temp_top_add_status,
					join(
						temp_top_add_status,
						bankruptcyv2_services.fn_rollup_comments(temp_records_main_full),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.comment_history := right.comments,
							self := left),
						left outer));
						
				// output(in_tmsids1, named('in_tmsids1_v2'));		
				// output(temp_records_search0, named('temp_records_search0_v2'));
				// output(temp_records_search, named('temp_records_searchv2'));
				// output(tmsids_pulled, named('tmsids_pulledv2'));
				// output(in_tmsids_pulled , named('in_tmsids_pulled'));
				// output(temp_records_main_jur, named('temp_records_main_jur_v2'));
				// output(temp_top_add_status, named('temp_top_add_status'));
        // output(temp_top_add_comments,named('temp_top_add_comments_v2'));
			 return sort(temp_top_add_comments,-orig_filing_date,-date_filed,record);
end;


export fn_rollup(
	dataset(doxie.layout_references) in_dids,
	dataset(doxie_cbrs.layout_references) in_bdids,
	dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
  dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids,
  string1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID,
	unsigned in_limit,
	string6 in_ssn_mask,
	boolean in_isSearch = false,
	boolean in_all_bks_for_all_debtors = false,
	string1 in_party_type = '',
	string2 in_filing_jurisdiction = '',
	boolean isFCRA = false,
	string32 ApplicationType = '',
	boolean includeCriminalIndicators = false,
	boolean in_include_AttorneyTrustee = false,
  boolean skip_ids_search = false
	) := function 
	
	temp_mod_one := module(project(gm,inner_params,opt))
    export skip_ids_search := ^.skip_ids_search;
  end;
	temp_mod_two := module(project(gm,inner_params,opt))
		//export nofail := true;
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
    export skip_ids_search := ^.skip_ids_search;
	end;
	
	party_one_results := inner_id_search(temp_mod_one, in_dids, in_bdids, in_tmsids0, in_bids, bid_fetch_level, in_limit, in_ssn_mask, in_isSearch, in_all_bks_for_all_debtors,in_party_type, in_filing_jurisdiction,isFCRA,includeCriminalIndicators,in_include_AttorneyTrustee);
	party_two_results := inner_id_search(temp_mod_two, in_dids, in_bdids, in_tmsids0, in_bids, bid_fetch_level, in_limit, in_ssn_mask, in_isSearch, in_all_bks_for_all_debtors,in_party_type, in_filing_jurisdiction,isFCRA,includeCriminalIndicators,in_include_AttorneyTrustee);	  
	//Debug
	//output(party_one_results,named('P1'));
	//output(party_two_results,named('P2'));
	two_party_search_results := join(party_one_results,
																		party_two_results,
																		left.tmsid= right.tmsid,
																		transform(left),
																		keep(1),
																		limit(0));

	selected_results := if(gm.TwoPartySearch,
	two_party_search_results,
	party_one_results);
	//output(selected_results,named('selected_results'));

return selected_results;
				
end;