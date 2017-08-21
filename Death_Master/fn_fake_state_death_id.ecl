export fn_fake_state_death_id(string9 v_ssn, string20 v_lname, string8 v_dod) := function
 
 string16 v_fake_id := IF(v_lname[1]<>'',
													v_ssn+v_lname[1]+v_dod[3..8],
													v_ssn+v_dod[2..8]);
 
 return v_fake_id;

end;