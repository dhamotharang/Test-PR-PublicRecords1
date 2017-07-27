
IMPORT Alerts, AutoStandardI, STD, ut;

noleadingchars(STRING charter) := FUNCTION
	RETURN REGEXFIND('([^0].*)$',charter,0);
END;

standardize_company_name(STRING cn) := 
	FUNCTION
		RETURN STD.Str.Filter(STD.Str.ToUpperCase(cn),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	END;
	
input_company_name_is_found_in_corp_legal_name(STRING temp_cn_val_1, STRING temp_cn_val_2, STRING corp_legal_name) :=
	FUNCTION
		
		inp_cn1_is_found_in_corp_legal_name := 
			TRIM(temp_cn_val_1) != '' AND	STD.Str.Find(standardize_company_name(corp_legal_name), standardize_company_name(temp_cn_val_1), 1 ) > 0;
			
		inp_cn2_is_found_in_corp_legal_name := 
			TRIM(temp_cn_val_2) != '' AND	STD.Str.Find(standardize_company_name(corp_legal_name), standardize_company_name(temp_cn_val_2), 1 ) > 0;

		RETURN IF( inp_cn1_is_found_in_corp_legal_name OR inp_cn2_is_found_in_corp_legal_name, 0, 1 );
	END;

strip_punctuation(STRING cn) := 
	FUNCTION
		STRING punct := ';-!?.,:\"\'()';
		RETURN STD.Str.FilterOut(cn,punct);
		END;

similar_input_company_name_with_corp_legal_name(STRING company_name_1, STRING company_name_2, STRING corp_legal_name, BOOLEAN two_party_search) :=
	FUNCTION
		UNSIGNED1 like_percentage := IF(two_party_search,
													-MAX(
															ut.StringSimilar3Gram(strip_punctuation(company_name_1), strip_punctuation(corp_legal_name)),
															ut.StringSimilar3Gram(strip_punctuation(company_name_2), strip_punctuation(corp_legal_name))
															),
															ut.StringSimilar3Gram(strip_punctuation(company_name_1), strip_punctuation(corp_legal_name)));
		RETURN like_percentage;			
END;
	
EXPORT CorpSearch(BOOLEAN isCorpSearchService = FALSE) := FUNCTION

	STRING32 chn            := ''    : STORED('CharterNumber');
	STRING30 ck             := ''    : STORED('CorpKey');
	STRING2  st             := ''    : STORED('state');
	BOOLEAN  TwoPartySearch := FALSE : STORED('TwoPartySearch');

	it := AutoStandardI.InterfaceTranslator;
	gm := AutoStandardI.GlobalModule();
	
	searchParams := Corp2_services.IParams.getServiceParams();

	UNSIGNED2 input_pt         := it.penalt_threshold_value.val(PROJECT(gm, it.penalt_threshold_value.params));
	BOOLEAN Simplified_Contact := searchParams.SimplifiedContactReturn;
	BOOLEAN search_RAs         := searchParams.SearchRegisteredAgents;

	ids        := corp2_services.CorpsSearchService_ids.result_ids;
	corp_keys  := PROJECT(ids, corp2_services.layout_corpkey);
	pre_corp_r := corp2_services.corp2_raw.search_view.by_corpkey(corp_keys, '', isCorpSearchService);

	corp_r     := pre_corp_r(corp_key = STD.Str.ToUpperCase(ck) or ck = '',
											 noleadingchars(corp_sos_charter_nbr) = noleadingchars(STD.Str.ToUpperCase(chn)) or chn = '');

	temp_rollup_final := record
		layout_corp2_search_rollup_final - [penalt,contact_penalt];
		unsigned2 penalt_1;
		unsigned2 contact_penalt_1;
		unsigned2 penalt_2;
		unsigned2 contact_penalt_2;
	end;
	
	// Just 'transfer' deep-dive value? Uncertain....
	rdd := JOIN(corp_r, ids, 
	            LEFT.corp_key = RIGHT.corp_key,
	            TRANSFORM(temp_rollup_final, 
	                      SELF.isDeepDive := RIGHT.isDeepDive, 
	                      SELF            := LEFT),
	            LEFT OUTER);

	// If personal information is included in the form, be certain to preserve matching records whose Contacts
	// or Registered Agents have an acceptable penalty value. Take into account the flags SimplifiedContactReturn
	// and SearchRegisteredAgents. Else, filter for only those records whose penalt value is less than than the
	// input penalty value. Then, sort by deep dive, penalt, contact_penalt, etc., etc.
	
	temp_mod_one := module(project(gm,AutoStandardI.LIBIN.PenaltyI.base,opt))
	end;
	temp_mod_two := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI.base,opt))
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
	end;
	
	temp_ssn_value_1 := it.ssn_value.val(temp_mod_one);
	temp_fname_value_1 := it.fname_value.val(temp_mod_one);
	temp_mname_value_1 := it.mname_value.val(temp_mod_one);
	temp_lname_value_1 := it.lname_value.val(temp_mod_one);
	temp_company_name_val_1 := it.company_name_val.val(temp_mod_one);
	temp_ssn_value_2 := it.ssn_value.val(temp_mod_two);
	temp_fname_value_2 := it.fname_value.val(temp_mod_two);
	temp_mname_value_2 := it.mname_value.val(temp_mod_two);
	temp_lname_value_2 := it.lname_value.val(temp_mod_two);
	temp_company_name_val_2 := it.company_name_val.val(temp_mod_two);
	
	rdd_filtered_on_penalty := IF( temp_ssn_value_1 != '' OR temp_fname_value_1 != '' OR temp_lname_value_1 != '' OR temp_mname_value_1 != '' OR
																 ( TwoPartySearch AND
																	 ( temp_ssn_value_2 != '' OR temp_fname_value_2 != '' OR temp_lname_value_2 != '' OR temp_mname_value_2 != '' )
																 ), /* then */
	                               MAP( search_RAs        => rdd( (IF(TwoPartySearch,MAX(contact_penalt_1,contact_penalt_2),contact_penalt_1) <= MIN(input_pt, 5)) OR 
																                                 (EXISTS(corp_hist(ra_is_likely_match))) ), 
	                                    Simplified_Contact => rdd( (IF(TwoPartySearch,MAX(contact_penalt_1,contact_penalt_2),contact_penalt_1) <= MIN(input_pt, 5)) ),
	                                    /* default...... */   rdd( (IF(TwoPartySearch,MAX(contact_penalt_1,contact_penalt_2),contact_penalt_1) <= input_pt) )
	                                   ),
	                               /* else no personal information */
											           MAP( search_RAs        => rdd( (IF(TwoPartySearch,MAX(penalt_1,penalt_2),penalt_1) <= MIN(input_pt, 5)) OR 
																                                 (EXISTS(corp_hist(ra_is_likely_match))) ), 
	                                    /* default...... */   rdd(IF(TwoPartySearch,MAX(penalt_1,penalt_2),penalt_1) <= MIN(input_pt, 5))
																		 )
																);
	
	projrdd := PROJECT(rdd_filtered_on_penalty,TRANSFORM(layout_corp2_search_rollup_final,
		SELF.penalt := IF(TwoPartySearch,MIN(left.penalt_1,left.penalt_2),left.penalt_1),
		SELF.contact_penalt := IF(TwoPartySearch,MIN(left.contact_penalt_1,left.contact_penalt_2),left.contact_penalt_1),
		SELF := left));
		
	rsrt := 
		SORT(projrdd, 
			isDeepDive, 
			input_company_name_is_found_in_corp_legal_name(temp_company_name_val_1, temp_company_name_val_2, corp_hist[1].corp_legal_name),
			penalt,          
			contact_penalt,
			-similar_input_company_name_with_corp_legal_name(temp_company_name_val_1,temp_company_name_val_2,corp_hist[1].corp_legal_name,TwoPartySearch),
			RECORD);

	MaxResults_val := it.MaxResults_val.val(project(gm,it.MaxResults_val.params));
	Alerts.mac_ProcessAlerts(rsrt, Corp2_services.alert, temp_final);
	
	RETURN temp_final;

END;