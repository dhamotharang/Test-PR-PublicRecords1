import marriages_divorces,Address;

// after running stats we found that the address1 and address2 fields strictly have county and state information.
// thus we just test for the county/state. 
export fn_addrMappingFix_v1(DATASET(recordof(marriages_divorces.layout_marriage_divorces))ds) := function

recordof(ds) prjt(recordof(ds) l) := transform

 integer v_iscounty1   := stringlib.stringfind(l.party1_residence_address1,'COUNTY',1);
 integer v_iscounty2   := stringlib.stringfind(l.party2_residence_address1,'COUNTY',1);

 integer v_comma1      := stringlib.stringfind(l.party1_residence_address1,',',1);
 integer v_comma2      := stringlib.stringfind(l.party2_residence_address1,',',1);

 integer v_ends_in_ky1 := stringlib.stringfind(l.party1_residence_address1,', KENTUCKY',1);
 integer v_ends_in_ky2 := stringlib.stringfind(l.party2_residence_address1,', KENTUCKY',1);

 string v_state1       := marriage_divorce_v2.fn_return_st_abbr(l.party1_residence_address1);
 string v_state2       := marriage_divorce_v2.fn_return_st_abbr(l.party2_residence_address1);

 boolean v_is_it_a_state1 := length(trim(v_state1))=2;
 boolean v_is_it_a_state2 := length(trim(v_state2))=2;

 self.party1_residence_city     := if(v_ends_in_ky1<>0,l.party1_residence_address1[1..v_comma1-1],l.party1_residence_city);
 self.party1_residence_state    := if(v_isCounty1<>0,'',
                                   if(v_ends_in_ky1<>0,'KY',
							       if(v_is_it_a_state1,v_state1,
								   l.party1_residence_state)));
 self.party1_residence_county   := if(v_isCounty1<>0,l.party1_residence_address1,l.party1_residence_county);

 self.party2_residence_city     := if(v_ends_in_ky2<>0,l.party2_residence_address1[1..v_comma2-1],l.party2_residence_city);
 self.party2_residence_state    := if(v_isCounty2<>0,'',
                                   if(v_ends_in_ky2<>0,'KY',
								   if(v_is_it_a_state2,v_state2,
								   l.party2_residence_state)));											 
 self.party2_residence_county	:= if(v_isCounty2<>0,l.party2_residence_address1,l.party2_residence_county);
								   
 self.party1_residence_address1 := '';
 self.party2_residence_address1 := '';

 self                           := l;

end;

cln_ds := project(ds,prjt(left));

return cln_ds;

end;