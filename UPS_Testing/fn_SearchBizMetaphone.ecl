import ut, autoheaderi, AutoStandardI, doxie_cbrs, Business_Header, ups_services;

export fn_SearchBizMetaphone() := 
MODULE

//****** INTERFACE
export params := 
INTERFACE(
		autoheaderi.LIBIN.FetchI_Hdr_Biz.full,
		AutoStandardI.InterfaceTranslator.dppa_ok.params
	)
	// export boolean use_company_name_metaphone := false;
END;

//****** CONSTANTS
message_code 		:= 999;//temp
message_prefix 	:= 'UPS_Testing.fn_SearchBizMetaphone ';

export records(params in_mod) :=
FUNCTION

	//****** DECLARE SOME INPUT VARIABLES
	shared string120 temp_company_name_metaphone := AutoStandardI.InterfaceTranslator.company_name_metaphone.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_metaphone.params));
	shared string temp_state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
	shared set of integer4 temp_bh_zip_value := AutoStandardI.InterfaceTranslator.bh_zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.bh_zip_value.params));
	// shared boolean temp_use_company_name_metaphone := AutoStandardI.InterfaceTranslator.use_company_name_metaphone.val(project(in_mod,AutoStandardI.InterfaceTranslator.use_company_name_metaphone.params));


	//****** DECIDE WHETHER WE HAVE THE NECESSARY INPUTS
	company_name_matchable 	:= temp_company_name_metaphone <> '';
	state_matchable 				:= temp_state_value <> '';
	zip_matchable						:= 	not( 
																temp_bh_zip_value = [] or 
																(count(temp_bh_zip_value) = 1 and 0 in temp_bh_zip_value)
															);
	matchable 							:= //temp_use_company_name_metaphone and 
														 company_name_matchable and 
														 state_matchable and 
														 zip_matchable;

	message_boolean_convert(boolean b) := if(b, 'true', 'false');
	matchability_messages := 
	parallel(
		ut.outputMessage(message_code, message_prefix + 'matchable := ' + message_boolean_convert(matchable)),
		// ut.outputMessage(message_code, message_prefix + 'temp_use_company_name_metaphone := ' + message_boolean_convert(temp_use_company_name_metaphone)),
		ut.outputMessage(message_code, message_prefix + 'company_name_matchable := ' + message_boolean_convert(company_name_matchable)),
		ut.outputMessage(message_code, message_prefix + 'state_matchable := ' + message_boolean_convert(state_matchable)),
		ut.outputMessage(message_code, message_prefix + 'zip_matchable := ' + message_boolean_convert(zip_matchable))
	);

	//****** INDEX READ
	indx_read := 
	limit(
		UPS_Testing.Key_BH_Header_Words2(
			matchable,
			keyed(temp_company_name_metaphone = metaphone[1..LENGTH(TRIM(temp_company_name_metaphone))]),
			keyed(temp_state_value = state),
			keyed(zip in (set of string6)temp_bh_zip_value)
		),
		ut.limits.FETCH_KEYED, 
		keyed, 
		skip
	);
	matchability_messages;
	ut.outputMessage(message_code, message_prefix + 'records returned := ' + count(indx_read));
	return indx_read;

END;

//****** OPTION TO RETURN BEST RECORDS
export records_count(params in_mod) := 
FUNCTION
	return count(records(in_mod));
END;
		
//****** OPTION TO RETURN BEST RECORDS
export records_wbest(params in_mod) := 
FUNCTION
	dppa_ok 			:= AutoStandardI.InterfaceTranslator.dppa_ok.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_ok.params));
	dppa_purpose 	:= AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_purpose.params));
	bdids := records(in_mod);
	doxie_cbrs.mac_best_records(bdids, wbest)
	return wbest;
END;

//****** TEST SCORING
export records_wscore(params in_mod) := 
FUNCTION
	shared string120 temp_company_name_value := AutoStandardI.InterfaceTranslator.company_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_value.params));	
	wbest := records_wbest(in_mod);
	return
	project(
		wbest,
		transform(
			{integer2 edit_distance_name, wbest},
			self.edit_distance_name := ups_services.mod_Score.NormalizedEditDistance(left.company_name, temp_company_name_value),
			self := left
		)
	);
			
END;

export records_wscore_sorted(params in_mod) := 
FUNCTION
	return sort(records_wscore(in_mod), edit_distance_name);
END;

END;