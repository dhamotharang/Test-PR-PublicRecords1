EXPORT layout_api := MODULE
    
		EXPORT rec := RECORD
			STRING left_source;
			STRING left_id;
			STRING left_orig_name;
			STRING left_name;
			STRING left_rec_type;
			STRING left_country;
			STRING left_bic;
			STRING right_source;
			STRING right_id;
			STRING right_orig_name;
			STRING right_name;
			STRING right_rec_type;
			STRING right_country;
			STRING right_bic;
			STRING name_score;
			STRING name_missing_score;
			STRING bic_score;
			STRING bic_type_score;
			STRING country_score;
			STRING country_type_score;
			STRING full_match_tokens;
			STRING FUZZY_MATCH_TOKENS;
			STRING MISSING_TOKENS;
			STRING NEGATIVE_SCORE;
			STRING MATCH_PERCENT;
			STRING total_score;
			STRING unique_link_id;
	END;
 
 END;