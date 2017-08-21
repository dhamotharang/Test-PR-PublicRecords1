import ut;

export fn_append_puid(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0) t_append_puid(recordof(int0) le) := transform
 self.persistent_record_id := HASH64(ut.CleanSpacesAndUpper(le.filing_type)
																		+ ut.CleanSpacesAndUpper(le.filing_subtype)
																		+ ut.CleanSpacesAndUpper(le.state_origin)
																		+ ut.CleanSpacesAndUpper(le.party1_name)
																		+ ut.CleanSpacesAndUpper(le.party1_alias)
																		+ ut.CleanSpacesAndUpper(le.party1_dob)
																		+ ut.CleanSpacesAndUpper(le.party1_birth_state)
																		+ ut.CleanSpacesAndUpper(le.party1_age)
																		+ ut.CleanSpacesAndUpper(le.party1_race)
																		+ ut.CleanSpacesAndUpper(le.party1_addr1)
																		+ ut.CleanSpacesAndUpper(le.party1_csz)
																		+ ut.CleanSpacesAndUpper(le.party1_county)
																		+ ut.CleanSpacesAndUpper(le.party1_previous_marital_status)
																		+ ut.CleanSpacesAndUpper(le.party1_how_marriage_ended)
																		+ ut.CleanSpacesAndUpper(le.party1_times_married)
																		+ ut.CleanSpacesAndUpper(le.party1_last_marriage_end_dt)
																		+ ut.CleanSpacesAndUpper(le.party2_name)
																		+ ut.CleanSpacesAndUpper(le.party2_alias)
																		+ ut.CleanSpacesAndUpper(le.party2_dob)
																		+ ut.CleanSpacesAndUpper(le.party2_birth_state)
																		+ ut.CleanSpacesAndUpper(le.party2_age)
																		+ ut.CleanSpacesAndUpper(le.party2_race)
																		+ ut.CleanSpacesAndUpper(le.party2_addr1)
																		+ ut.CleanSpacesAndUpper(le.party2_csz)
																		+ ut.CleanSpacesAndUpper(le.party2_county)
																		+ ut.CleanSpacesAndUpper(le.party2_previous_marital_status)
																		+ ut.CleanSpacesAndUpper(le.party2_how_marriage_ended)
																		+ ut.CleanSpacesAndUpper(le.party2_times_married)
																		+ ut.CleanSpacesAndUpper(le.party2_last_marriage_end_dt)
																		+ ut.CleanSpacesAndUpper(le.number_of_children)
																		+ ut.CleanSpacesAndUpper(le.marriage_filing_dt)
																		+ ut.CleanSpacesAndUpper(le.marriage_dt)
																		+ ut.CleanSpacesAndUpper(le.marriage_city)
																		+ ut.CleanSpacesAndUpper(le.marriage_county)
																		+ ut.CleanSpacesAndUpper(le.place_of_marriage)
																		+ ut.CleanSpacesAndUpper(le.type_of_ceremony)
																		+ ut.CleanSpacesAndUpper(le.marriage_filing_number)
																		+ ut.CleanSpacesAndUpper(le.marriage_docket_volume)
																		+ ut.CleanSpacesAndUpper(le.divorce_filing_dt)
																		+ ut.CleanSpacesAndUpper(le.divorce_dt)
																		+ ut.CleanSpacesAndUpper(le.divorce_docket_volume)
																		+ ut.CleanSpacesAndUpper(le.divorce_filing_number)
																		+ ut.CleanSpacesAndUpper(le.divorce_city)
																		+ ut.CleanSpacesAndUpper(le.divorce_county)
																		+ ut.CleanSpacesAndUpper(le.grounds_for_divorce)
																		+ ut.CleanSpacesAndUpper(le.marriage_duration_cd)
																		+ ut.CleanSpacesAndUpper(le.marriage_duration));
									
										
 
 
 self := le;
 
end;

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

end;
