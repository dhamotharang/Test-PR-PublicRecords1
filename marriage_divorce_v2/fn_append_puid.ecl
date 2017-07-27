import ut;

export fn_append_puid(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0) t_append_puid(recordof(int0) le) := transform
 self.persistent_record_id := HASH64(ut.fnTrim2Upper(le.filing_type)
																		+ ut.fnTrim2Upper(le.filing_subtype)
																		+ ut.fnTrim2Upper(le.state_origin)
																		+ ut.fnTrim2Upper(le.party1_name)
																		+ ut.fnTrim2Upper(le.party1_alias)
																		+ ut.fnTrim2Upper(le.party1_dob)
																		+ ut.fnTrim2Upper(le.party1_birth_state)
																		+ ut.fnTrim2Upper(le.party1_age)
																		+ ut.fnTrim2Upper(le.party1_race)
																		+ ut.fnTrim2Upper(le.party1_addr1)
																		+ ut.fnTrim2Upper(le.party1_csz)
																		+ ut.fnTrim2Upper(le.party1_county)
																		+ ut.fnTrim2Upper(le.party1_previous_marital_status)
																		+ ut.fnTrim2Upper(le.party1_how_marriage_ended)
																		+ ut.fnTrim2Upper(le.party1_times_married)
																		+ ut.fnTrim2Upper(le.party1_last_marriage_end_dt)
																		+ ut.fnTrim2Upper(le.party2_name)
																		+ ut.fnTrim2Upper(le.party2_alias)
																		+ ut.fnTrim2Upper(le.party2_dob)
																		+ ut.fnTrim2Upper(le.party2_birth_state)
																		+ ut.fnTrim2Upper(le.party2_age)
																		+ ut.fnTrim2Upper(le.party2_race)
																		+ ut.fnTrim2Upper(le.party2_addr1)
																		+ ut.fnTrim2Upper(le.party2_csz)
																		+ ut.fnTrim2Upper(le.party2_county)
																		+ ut.fnTrim2Upper(le.party2_previous_marital_status)
																		+ ut.fnTrim2Upper(le.party2_how_marriage_ended)
																		+ ut.fnTrim2Upper(le.party2_times_married)
																		+ ut.fnTrim2Upper(le.party2_last_marriage_end_dt)
																		+ ut.fnTrim2Upper(le.number_of_children)
																		+ ut.fnTrim2Upper(le.marriage_filing_dt)
																		+ ut.fnTrim2Upper(le.marriage_dt)
																		+ ut.fnTrim2Upper(le.marriage_city)
																		+ ut.fnTrim2Upper(le.marriage_county)
																		+ ut.fnTrim2Upper(le.place_of_marriage)
																		+ ut.fnTrim2Upper(le.type_of_ceremony)
																		+ ut.fnTrim2Upper(le.marriage_filing_number)
																		+ ut.fnTrim2Upper(le.marriage_docket_volume)
																		+ ut.fnTrim2Upper(le.divorce_filing_dt)
																		+ ut.fnTrim2Upper(le.divorce_dt)
																		+ ut.fnTrim2Upper(le.divorce_docket_volume)
																		+ ut.fnTrim2Upper(le.divorce_filing_number)
																		+ ut.fnTrim2Upper(le.divorce_city)
																		+ ut.fnTrim2Upper(le.divorce_county)
																		+ ut.fnTrim2Upper(le.grounds_for_divorce)
																		+ ut.fnTrim2Upper(le.marriage_duration_cd)
																		+ ut.fnTrim2Upper(le.marriage_duration));
									
										
 
 
 self := le;
 
end;

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

end;
