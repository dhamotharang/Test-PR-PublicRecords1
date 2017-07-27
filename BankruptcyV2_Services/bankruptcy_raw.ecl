import doxie,BIPV2,doxie_cbrs,Alerts,AutoStandardI;

export bankruptcy_raw(boolean isFCRA = false) :=
	module
    shared UNSIGNED8 maxResults_val := AutoStandardI.InterfaceTranslator.maxResults_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.maxResults_val.params));
		shared UNSIGNED2 penalt_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		shared string32  applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));

		shared empty_dids := dataset([],doxie.layout_references);
		shared empty_bdids := dataset([],doxie_cbrs.layout_references);
		shared empty_tmsids := dataset([],bankruptcyv2_services.layout_tmsid_ext);
		shared empty_bids := dataset([],BIPV2.IDlayouts.l_xlink_ids);
		//----------------
		// The search view
		//----------------
		export search_view(
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = '',
			string2 in_filing_jurisdiction = '',
      boolean in_includeCriminalIndicators = false,
			boolean in_Include_AttorneyTrustee = false,
      dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids = empty_bids,
      string1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID
			) :=
				function
					temp_results := bankruptcyv2_services.fn_rollup(empty_dids,empty_bdids,empty_tmsids,in_bids,bid_fetch_level,0,in_ssn_mask,true,,in_party_type,in_filing_jurisdiction,isFCRA,,in_includeCriminalIndicators,in_Include_AttorneyTrustee);

					temp_sorted := sort(
						temp_results(penalt <= penalt_threshold),
						if(isdeepdive,1,0),penalt,-date_filed,case_number,
						if(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), record);
					
					Alerts.mac_ProcessAlerts(temp_sorted,BankruptcyV2_services.alert,temp_final);

					RETURN temp_final;
				end;
		//----------------
		// The report view
		//----------------
		export report_view(
			dataset(doxie.layout_references) in_dids = empty_dids,
			dataset(doxie_cbrs.layout_references) in_bdids = empty_bdids,
			dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = '',
      boolean in_includeCriminalIndicators = false
			) :=
				function
					temp_results := bankruptcyv2_services.fn_rollup(in_dids,in_bdids,in_tmsids,empty_bids,,in_limit,in_ssn_mask,false,,in_party_type,,,,in_includeCriminalIndicators);
					return temp_results;
				end;
		//----------------
		// The source view
		//----------------
		export source_view(
			dataset(doxie.layout_references) in_dids = empty_dids,
			dataset(doxie_cbrs.layout_references) in_bdids = empty_bdids,
			dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			boolean in_all_bks_for_all_debtors = false,
			string1 in_party_type = '',
      boolean in_includeCriminalIndicators = false,
      boolean skip_ids_search = false
			) :=
				function
					temp_results := bankruptcyv2_services.fn_rollup(in_dids,in_bdids,in_tmsids,empty_bids,,in_limit,in_ssn_mask,false,in_all_bks_for_all_debtors,in_party_type,,,,in_includeCriminalIndicators, ,skip_ids_search);
					return temp_results;
				end;
		//----------------
		// The source view for Boolean
		//----------------
		export boolean_source_view(
			dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = ''
			) :=
				function
					temp_results := bankruptcyv2_services.fn_boolean_rollup(in_tmsids,in_limit,in_ssn_mask,false,in_party_type,isFCRA,applicationType);
					return temp_results;
				end;
	end;
	
	
