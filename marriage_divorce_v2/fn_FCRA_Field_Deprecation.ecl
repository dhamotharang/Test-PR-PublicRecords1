// DF-21428 - defines fields that are used for FCRA field deprecation
IMPORT ut, strata;
EXPORT fn_FCRA_Field_Deprecation := MODULE

	export fields_to_clear_id_main  := 'divorce_docket_volume,divorce_filing_dt,filing_subtype,grounds_for_divorce,marriage_docket_volume,marriage_duration,' +
											'marriage_duration_cd,marriage_filing_dt,number_of_children,place_of_marriage,type_of_ceremony';

	export fields_to_clear_id_search  := 'age,birth_state,how_marriage_ended,last_marriage_end_dt,party_county,previous_marital_status,race,times_married,title';

END;