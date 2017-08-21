export fn_ln_xml_address_patch(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) in_file)
	:=
function

    xml_recs := in_file(stringlib.stringfind(source_file,'XML',1)!=0);
not_xml_recs := in_file(stringlib.stringfind(source_file,'XML',1) =0);

recordof(in_file) t_csz_county_fix(recordof(in_file) le) := transform
 
 integer p1_comma_1 := stringlib.stringfind(le.party1_addr1,',',1);
 integer p1_comma_2 := stringlib.stringfind(le.party1_addr1,',',2);
 
 integer p2_comma_1 := stringlib.stringfind(le.party2_addr1,',',1);
 integer p2_comma_2 := stringlib.stringfind(le.party2_addr1,',',2); 
 
 //party1
 string50 v_party1_parsed_city   := if(p1_comma_1<>0,le.party1_addr1[1..p1_comma_1-1],
                                    if(p1_comma_1 =0 and regexfind(' COUNTY',le.party1_addr1),'',
									//if(p1_comma_1 =0 and length(trim(marriage_divorce_v2.fn_return_st_abbr(le.party1_addr1)))=2,'',
									le.party1_addr1));
 string50 v_party1_parsed_county := if(p1_comma_1 =0 and regexfind(' COUNTY',le.party1_addr1),le.party1_addr1,
                                    //if(p1_comma_1 =0 and length(marriage_divorce_v2.fn_return_st_abbr(le.party1_addr1))=2,'',
                                    if(p1_comma_1<>0 and p1_comma_2=0,le.party1_addr1[p1_comma_1+1..50],
                                    if(p1_comma_1<>0 and p1_comma_2<>0,le.party1_addr1[p1_comma_1+1..p1_comma_2-1],
			                        '')));

 boolean v_is_party1_parsed_county_a_county := stringlib.stringfind(v_party1_parsed_county,' COUNTY',1)!=0;
					
 string50 v_party1_parsed_st  := //if(p1_comma_1 =0 and length(trim(marriage_divorce_v2.fn_return_st_abbr(le.party1_addr1)))=2,le.party1_addr1,
                                 if(p1_comma_2<>0,le.party1_addr1[p1_comma_2+1..50],'');
 string50 v_party1_parsed_st2 := if(v_party1_parsed_st<>'',trim(v_party1_parsed_st),if(v_is_party1_parsed_county_a_county=false,trim(v_party1_parsed_county),''));

 //party2 
 string50 v_party2_parsed_city   := if(p2_comma_1<>0,le.party2_addr1[1..p2_comma_1-1],
                                    if(p2_comma_1 =0 and regexfind(' COUNTY',le.party2_addr1),'',
									//if(p2_comma_1 =0 and length(trim(marriage_divorce_v2.fn_return_st_abbr(le.party2_addr1)))=2,'',
									le.party2_addr1));
 string50 v_party2_parsed_county := if(p2_comma_1 =0 and regexfind(' COUNTY',le.party2_addr1),le.party2_addr1,
                                    //if(p2_comma_1 =0 and length(marriage_divorce_v2.fn_return_st_abbr(le.party2_addr1))=2,'',
                                    if(p2_comma_1<>0 and p2_comma_2=0,le.party2_addr1[p2_comma_1+1..50],
			                        if(p2_comma_1<>0 and p2_comma_2<>0,le.party2_addr1[p2_comma_1+1..p2_comma_2-1],
			                        '')));

 boolean v_is_party2_parsed_county_a_county := stringlib.stringfind(v_party2_parsed_county,' COUNTY',1)!=0;
					
 string50 v_party2_parsed_st  := //if(p2_comma_1 =0 and length(trim(marriage_divorce_v2.fn_return_st_abbr(le.party2_addr1)))=2,le.party2_addr1,
                                 if(p2_comma_2<>0,le.party2_addr1[p2_comma_2+1..50],'');
 string50 v_party2_parsed_st2 := if(v_party2_parsed_st<>'',trim(v_party2_parsed_st),if(v_is_party2_parsed_county_a_county=false,trim(v_party2_parsed_county),
                                 ''));
 
 //some records have both the city and county in the same field
 //seems to only apply to CT XML marriages
 integer v_marriage_county_comma := stringlib.stringfind(le.marriage_county,',',1);
 
 string30 v_marriage_city   := if(v_marriage_county_comma<>0,le.marriage_county[1..v_marriage_county_comma-1],le.marriage_city);
 string35 v_marriage_county := if(v_marriage_county_comma<>0,le.marriage_county[v_marriage_county_comma+1..35],le.marriage_county); 
 
 self.party1_county := if(v_is_party1_parsed_county_a_county=true,trim(v_party1_parsed_county,left,right),'');
 self.party1_addr1  := '';
 //passing the "city" to the state_abbr function is a hack - the code above is not handling cases
 //where ONLY the state is being provided
 self.party1_csz    := marriage_divorce_v2.fn_csz_format(marriage_divorce_v2.fn_return_st_abbr(trim(v_party1_parsed_city,left,right)),marriage_divorce_v2.fn_return_st_abbr(trim(v_party1_parsed_st2,left,right)),'');

 self.party2_county := if(v_is_party2_parsed_county_a_county=true,trim(v_party2_parsed_county,left,right),'');
 self.party2_addr1  := '';
 self.party2_csz    := marriage_divorce_v2.fn_csz_format(marriage_divorce_v2.fn_return_st_abbr(trim(v_party2_parsed_city,left,right)),marriage_divorce_v2.fn_return_st_abbr(trim(v_party2_parsed_st2,left,right)),'');

 self.marriage_city   := trim(v_marriage_city,left,right);
 self.marriage_county := trim(v_marriage_county,left,right);
 
 self := le;

end;

csz_county_fix := project(xml_recs,t_csz_county_fix(left));

concat := csz_county_fix+not_xml_recs;

return concat;

end;