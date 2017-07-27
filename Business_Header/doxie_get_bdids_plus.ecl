IMPORT ut, doxie, header, business_header, business_header_ss, mdr, AutoStandardI, AutoHeaderI;

export doxie_get_bdids_plus(boolean forceLocal = true
                           ,boolean nofail = false
													 ,boolean use_exec_search = true
													 ,boolean score_results=TRUE
													 ,unsigned6 bdid_limit = 2500
													 ,boolean match_ssn_as_fein=false
													 ,boolean phone_mandatory_match=true
													 ,boolean fein_mandatory_match=true
													 ,unsigned1 fuzziness_dial=3) := FUNCTION
	
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
		export boolean forceLocal := ^.forceLocal;
		export boolean nofail := ^.nofail;
		export boolean score_results := ^.score_results;
		export unsigned6 bdid_limit := ^.bdid_limit;
		export boolean match_ssn_as_fein := ^.match_ssn_as_fein;
		export boolean phone_mandatory_match := ^.phone_mandatory_match;
		export boolean fein_mandatory_match := ^.fein_mandatory_match;
		export unsigned1 fuzziness_dial := min(^.fuzziness_dial,if(AutoStandardI.InterfaceTranslator.exact_only.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.exact_only.params)),1,3));
	end;
	
	return AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do_plus(tempmod);

END;
