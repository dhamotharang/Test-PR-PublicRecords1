import AutoHeaderI, AutoStandardI, Business_Header_SS, ut, UPS_Services;


export FetchI_Hdr_Biz_Words := MODULE
	shared AIT := AutoStandardI.InterfaceTranslator;
	shared debug := false;

	export params := AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full;

  export records(params args) := FUNCTION

		word_header_index := Business_Header_SS.Key_BH_Header_Words;
		bdid_city_zip_fein_phone_index := Business_Header_SS.Key_BH_BDID_City_Zip_Fein_Phone;

		inCity := AIT.city_value.val(project(args, AIT.city_value.params));
		inState := AIT.state_value.val(project(args, AIT.state_value.params));
		inZip := AIT.zip_val.val(project(args, AIT.zip_val.params));

		inStateSet := MAP(inState <> '' => [ inState ], 
											inCity <> '' => UPS_Services.fn_BestStates(inCity),
											[]);

		inZipSet := IF(inCity <> '' AND inState <> '', ut.ZipsWithinCity(inState, inCity), []) + [ (INTEGER) inZip ];

		inPhone := AIT.phone_value.val(project(args, AIT.phone_value.params));
		inFEIN := AIT.fein_val.val(project(args, AIT.fein_val.params));

		STRING inCompanyNameFilt := TRIM(AIT.company_name_val_filt.val(project(args, AIT.company_name_val_filt.params)));
		STRING inCompanyNameFilt2 := TRIM(AIT.company_name_val_filt2.val(project(args, AIT.company_name_val_filt2.params)));
		// dataset(business_header_ss.Layout_BDID_InBatch) temp_precs := AIT.precs.val(project(args,AIT.precs.params));
		name_matchable := inCompanyNameFilt <> '';

		lenFilt := LENGTH(inCompanyNameFilt);
		lenFilt2 := LENGTH(inCompanyNameFilt2);

		word_hits := word_header_index(name_matchable,
																	 keyed(inCompanyNameFilt = word[1..lenFilt] OR
																				 (inCompanyNameFilt2 <> '' AND inCompanyNameFilt2 = word[1..lenFilt2])) AND
																	 (inState = '' OR state in inStateSet));

		words_filtered := JOIN(	word_hits, bdid_city_zip_fein_phone_index, 
														LEFT.bdid = RIGHT.bdid AND
															((inCity <> '' AND RIGHT.city = inCity) OR
															 (inZip <> '' AND RIGHT.zip IN inZipSet) OR
															 (inPhone <> '' AND (STRING) RIGHT.phone = inPhone)),
														TRANSFORM(RECORDOF(word_header_index), SELF := LEFT),
														LIMIT (ut.limits.DEFAULT, SKIP));

		filterable := inCity <> '' OR inZip <> '' OR inPhone <> '';
		res_full := IF(filterable, words_filtered, word_hits);

		res_partial_name := PROJECT(res_full, { word_header_index });

		#if (debug)
		output(inCompanyNameFilt, named('NameFilt'));
		output(lenFilt, named('lenFilt'));
		output(inCompanyNameFilt2, named('NameFilt2'));
		output(lenFilt2, named('lenFilt2'));
		output(filterable, named('filterable'));
		output(word_hits, named('word_hits'));
		output(words_filtered, named('words_filtered'));
		output(inCity ,named('city'));
		output(inState , named('state'));
		output(inZip , named('zip'));
		output(inStateSet , named('stateset'));
		output(inZipSet, named('zipset')); 
		#end
		
		return DEDUP(SORT(res_partial_name, RECORD), RECORD);
	END;
END;