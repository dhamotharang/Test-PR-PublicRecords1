IMPORT doxie, bipv2, ut, Data_Services, autokeyb2, PRTE2_Marriage_Divorce, marriage_divorce_v2;

EXPORT Keys := MODULE

	EXPORT key_mar_div_did (boolean isFCRA = FALSE) := FUNCTION
		search_slim_did	:= TABLE(PRTE2_Marriage_Divorce.Files.Search((UNSIGNED6)did<>0), {did, record_id});
		search_ded_did	:= DEDUP(SORT(search_slim_did, did, record_id), did, record_id);
		
		RETURN INDEX(search_ded_did,{did},{record_id},
								if(IsFCRA, 
											PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_Marriage_Divorce.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::did');
	END;
	
	//Filing_nbr key
	r_slim_srch := RECORD
		unsigned6 record_id;
		string2   st;
	END;
	
	p_slim_srch := DEDUP(PROJECT(PRTE2_Marriage_Divorce.Files.Search(st <> ''),TRANSFORM(r_slim_srch, SELF := LEFT)),RECORD);
	
	r0 := RECORD
		PRTE2_Marriage_Divorce.Layouts.Main_Base;
		p_slim_srch.st;
	END;
	
	r0 t_get_per_st(PRTE2_Marriage_Divorce.Files.Base le, p_slim_srch ri) := TRANSFORM
		SELF := le;
		SELF := ri;
	END;

	j1 := join(PRTE2_Marriage_Divorce.Files.Base, p_slim_srch,
						left.record_id=right.record_id,
						t_get_per_st(left,right));
						
	r1 := RECORD
		UNSIGNED6 record_id;
		STRING1   filing_type;
		STRING15  filing_subtype;
		STRING2   state_origin;
		STRING25  filing_number;
		STRING35  county;
	END;

	r1 t_norm(j1 le, integer c) := TRANSFORM
		SELF.state_origin  := choose(c,le.state_origin,le.st);
		SELF.filing_number := choose(c,le.marriage_filing_number,le.divorce_filing_number);
		SELF.county        := choose(c,le.marriage_county,le.divorce_county);
		SELF               := le;
	END;

	p_norm := NORMALIZE(j1,IF(trim(left.divorce_filing_number) <> '',2,1),t_norm(left,counter))(filing_number<>'');

	r1 t_unformat(r1 le) := TRANSFORM
		SELF.filing_number := stringlib.stringfilter(stringlib.stringtouppercase(le.filing_number),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		SELF               := le;
	END;

	p_unformat := dedup(sort(project(p_norm,t_unformat(left)),record),record)(trim(filing_number) <> '');
	
	EXPORT key_mar_div_filing_nbr := INDEX(p_unformat,
																				{filing_number,filing_type,filing_subtype,state_origin,county},{record_id},
																				PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::filing_nbr');
	
	//DF-21803:FCRA Consumer Data Fields Depreciation
	EXPORT 	key_mar_div_id_main(boolean IsFCRA = false) := FUNCTION
	slim_mar_div := PROJECT(PRTE2_Marriage_Divorce.Files.Base, TRANSFORM(marriage_divorce_v2.layout_mar_div_base_slim,SELF := LEFT));
	ded_mar_div := DEDUP(SORT(slim_mar_div, record_id),ALL); 
	
	ut.MAC_CLEAR_FIELDS(ded_mar_div, ded_mar_div_cleared, constants.key_main_id);
 ds_main_id_new := if(isFCRA, ded_mar_div_cleared, ded_mar_div);
	
	RETURN INDEX(ds_main_id_new, {record_id},{ds_main_id_new},
														IF(IsFCRA, 
																	PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'fcra::',
																	PRTE2_Marriage_Divorce.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::id_main');
	END;
	
	//DF-21803:FCRA Consumer Data Fields Depreciation
	EXPORT key_mar_div_id_search(boolean IsFCRA = false) := FUNCTION
	 ut.MAC_CLEAR_FIELDS(PRTE2_Marriage_Divorce.Files.Search, search_cleared, constants.key_search_id);
 ds_Search_id_new := if(isFCRA, search_cleared, PRTE2_Marriage_Divorce.Files.Search);
	
	RETURN INDEX(ds_Search_id_new, {record_id,which_party}, {ds_Search_id_new},
													IF(IsFCRA, 
																PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'fcra::',
																PRTE2_Marriage_Divorce.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::id_search');
	END;
	
END;
		
