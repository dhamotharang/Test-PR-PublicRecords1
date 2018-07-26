import ut;

export fn_append_puid(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0) t_append_puid(recordof(int0) le) := transform

 //DF-21262 - add comma between fields and remove ut.CleanSpacesAndUpper to each field to ensure the uniqueness of the persistent_record_id
 self.persistent_record_id := HASH64(le.filing_type + ',' 
																		+ le.filing_subtype + ',' 
																		+ le.state_origin + ',' 
																		+ le.party1_name + ',' 
																		+ le.party1_alias + ',' 
																		+ le.party1_dob + ',' 
																		+ le.party1_birth_state + ',' 
																		+ le.party1_age + ',' 
																		+ le.party1_race + ',' 
																		+ le.party1_addr1 + ',' 
																		+ le.party1_csz + ',' 
																		+ le.party1_county + ',' 
																		+ le.party1_previous_marital_status + ',' 
																		+ le.party1_how_marriage_ended + ',' 
																		+ le.party1_times_married + ',' 
																		+ le.party1_last_marriage_end_dt + ',' 
																		+ le.party2_name + ',' 
																		+ le.party2_alias + ',' 
																		+ le.party2_dob + ',' 
																		+ le.party2_birth_state + ',' 
																		+ le.party2_age + ',' 
																		+ le.party2_race + ',' 
																		+ le.party2_addr1 + ',' 
																		+ le.party2_csz + ',' 
																		+ le.party2_county + ',' 
																		+ le.party2_previous_marital_status + ',' 
																		+ le.party2_how_marriage_ended + ',' 
																		+ le.party2_times_married + ',' 
																		+ le.party2_last_marriage_end_dt + ',' 
																		+ le.number_of_children + ',' 
																		+ le.marriage_filing_dt + ',' 
																		+ le.marriage_dt + ',' 
																		+ le.marriage_city + ',' 
																		+ le.marriage_county + ',' 
																		+ le.place_of_marriage + ',' 
																		+ le.type_of_ceremony + ',' 
																		+ le.marriage_filing_number + ',' 
																		+ le.marriage_docket_volume + ',' 
																		+ le.divorce_filing_dt + ',' 
																		+ le.divorce_dt + ',' 
																		+ le.divorce_docket_volume + ',' 
																		+ le.divorce_filing_number + ',' 
																		+ le.divorce_city + ',' 
																		+ le.divorce_county + ',' 
																		+ le.grounds_for_divorce + ',' 
																		+ le.marriage_duration_cd + ',' 
																		+ le.marriage_duration 
																	);
																	
 self := le;
 
end;

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

end;
