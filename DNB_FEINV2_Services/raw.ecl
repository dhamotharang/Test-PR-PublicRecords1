import doxie,doxie_cbrs;

doxie.MAC_Header_Field_Declare();

export raw :=
	module
		shared empty_bdids := dataset([],doxie_cbrs.layout_references);
		shared empty_tmsids := dataset([],dnb_feinv2_services.layout_tmsid_ext);
		//----------------
		// The search view
		//----------------
		export search_view(
			) :=
				function
					penalt_threshold := 10 : stored('PenaltThreshold');
					// temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid(in_parms);
					temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid(empty_bdids,empty_tmsids,0);
					temp_sorted := sort(
						temp_results(penalt <= penalt_threshold),
						if(isdeepdive,1,0),penalt,tmsid);
					doxie.mac_marshall_results(temp_sorted,temp_marshalled);
					return temp_marshalled;
				end;
		//----------------
		// The source view
		//----------------
		export source_view(
			dataset(doxie_cbrs.layout_references) in_bdids = empty_bdids,
			dataset(dnb_feinv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			boolean in_skip_autokey = false
			) :=
				function
					// temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid(in_parms);
					temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid(in_bdids,in_tmsids,in_limit,in_skip_autokey);
					return temp_results;
				end;
		//----------------
		// The source view for Boolean
		//----------------
		export boolean_source_view(
			dataset(dnb_feinv2_services.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0
			) :=
				function
					// temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid(in_parms);
					temp_results := dnb_feinv2_services.fn_get_dnb_fein_tmsid_boolean(in_tmsids,in_limit);
					return temp_results;
				end;
	end;
	