//another function that seems limited to CT Marriages
//there are instances in the XML data where the party1/party2_csz fields just have the city
//however the direct records have both city AND state
//this could remove as many as 408k CT Marriage duplicates
//consider loosening should other states/sources have similar enhancement opportunity

export fn_city_vs_citystate(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

    ct_marriages := int0(  state_origin='CT' and filing_type='3');
not_ct_marriages := int0(~(state_origin='CT' and filing_type='3'));

ct_just_city  := ct_marriages(  stringlib.stringfind(party1_csz,',',1)=0 and length(trim(party1_csz))>2);
ct_city_state := ct_marriages(~(stringlib.stringfind(party1_csz,',',1)=0 and length(trim(party1_csz))>2));

recordof(int0) t_derive_city_state(recordof(int0) le, recordof(int0) ri) := transform

 string v_party1_city_state := ri.party1_csz;
 string v_party2_city_state := ri.party2_csz;

 //self.party1_csz := if(le.party1_csz<>'',if(regexfind(trim(le.party1_csz),v_party1_city_state),v_party1_city_state,le.party1_csz),'');
 //self.party2_csz := if(le.party2_csz<>'',if(regexfind(trim(le.party2_csz),v_party2_city_state),v_party2_city_state,le.party2_csz),'');
 self.party1_csz := if(le.party1_csz<>'',if(stringlib.stringfind(v_party1_city_state,trim(le.party1_csz,left,right),1)!=0,v_party1_city_state,v_party1_city_state),'');
 self.party2_csz := if(le.party2_csz<>'',if(stringlib.stringfind(v_party2_city_state,trim(le.party2_csz,left,right),1)!=0,v_party2_city_state,v_party2_city_state),'');
 self            := le;
 
end;

j1 := join(ct_just_city,ct_city_state,
           left.state_origin           = right.state_origin           and
           left.filing_type            = right.filing_type            and
		   left.party1_name            = right.party1_name            and 
		   left.party2_name            = right.party2_name            and
		   left.marriage_filing_dt     = right.marriage_filing_dt     and
		   left.marriage_dt            = right.marriage_dt            and
		   left.divorce_filing_dt      = right.divorce_filing_dt      and
		   left.divorce_dt             = right.divorce_dt             and
		   left.marriage_filing_number = right.marriage_filing_number and
		   left.divorce_filing_number  = right.divorce_filing_number,
		   t_derive_city_state(left,right),
		   left outer
		   );

concat := j1+ct_city_state+not_ct_marriages;

return concat;

end;