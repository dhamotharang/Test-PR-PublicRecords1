export mod_parse_civil_addresses(
 //dataset(recordof(marriage_divorce_v2.File_Civil_Matter_Party_Mar_Div_In)) in_civ,
 string in_addr1,
 string in_addr2,
 string in_addr3,
 string in_addr4
) := module

//string  v_addr1 := stringlib.stringtouppercase(le.entity_1_address_1);
//string  v_addr2 := stringlib.stringtouppercase(le.entity_1_address_2);
//string  v_addr3 := stringlib.stringtouppercase(le.entity_1_address_3);
//string  v_addr4 := stringlib.stringtouppercase(le.entity_1_address_4);

shared string  v_addr1 := stringlib.stringtouppercase(in_addr1);
shared string  v_addr2 := stringlib.stringtouppercase(in_addr2);
shared string  v_addr3 := stringlib.stringtouppercase(in_addr3);
shared string  v_addr4 := stringlib.stringtouppercase(in_addr4);

shared boolean v_has1 := v_addr1<>'';
shared boolean v_has2 := v_addr2<>'';
shared boolean v_has3 := v_addr3<>'';
shared boolean v_has4 := v_addr4<>'';

shared boolean v_addr1_has_nbr := regexfind('[0-9]',v_addr1);
shared boolean v_addr2_has_nbr := regexfind('[0-9]',v_addr2);
shared boolean v_addr3_has_nbr := regexfind('[0-9]',v_addr3);
shared boolean v_addr4_has_nbr := regexfind('[0-9]',v_addr4);

shared boolean v_addr1_is_a_careof := v_has1=true and v_addr1_has_nbr=false;

//only 1
shared boolean v_opt1  := v_has1=true  and v_has2=false and v_has3=false and v_has4=false;
shared boolean v_opt2  := v_has1=false and v_has2=true  and v_has3=false and v_has4=false;
shared boolean v_opt3  := v_has1=false and v_has2=false and v_has3=true  and v_has4=false;
shared boolean v_opt4  := v_has1=false and v_has2=false and v_has3=false and v_has4=true;

//combinations of 2
shared boolean v_opt5  := v_has1=true  and v_has2=true  and v_has3=false and v_has4=false;
shared boolean v_opt6  := v_has1=true  and v_has2=false and v_has3=true  and v_has4=false;
shared boolean v_opt7  := v_has1=true  and v_has2=false and v_has3=false and v_has4=true;
shared boolean v_opt8  := v_has1=false and v_has2=true  and v_has3=true  and v_has4=false;
shared boolean v_opt9  := v_has1=false and v_has2=true  and v_has3=false and v_has4=true;
shared boolean v_opt10 := v_has1=false and v_has2=false and v_has3=true  and v_has4=true;

//combinations of 3
shared boolean v_opt11 := v_has1=true  and v_has2=true  and v_has3=true  and v_has4=false;
shared boolean v_opt12 := v_has1=true  and v_has2=true  and v_has3=false and v_has4=true;
//as of the writing of this code, there were no records meeting opt13
shared boolean v_opt13 := v_has1=false and v_has2=true  and v_has3=true  and v_has4=true;

//all
//as of the writing of this code, there were no records meeting opt14
shared boolean v_opt14 := v_has1=true  and v_has2=true  and v_has3=true  and v_has4=true;

shared string v_addr  := if(v_opt1 =true,'',
                  if(v_opt2 =true,'',
				  if(v_opt3 =true,'',
				  if(v_opt4 =true,'',
				  if(v_opt5 =true,v_addr1,
				  if(v_opt6 =true,v_addr1,
				  if(v_opt7 =true,v_addr1,
				  if(v_opt8 =true,if(v_addr2_has_nbr=true,v_addr2,''),
				  if(v_opt9 =true,v_addr2,
				  if(v_opt10=true,'',
				  if(v_opt11=true,if(v_addr2_has_nbr=false,v_addr1,v_addr1+v_addr2),
				  if(v_opt12=true,if(v_addr1_is_a_careof=true,'C/O '+v_addr1+', '+v_addr2,v_addr1+v_addr2),
				  if(v_opt13=true,v_addr2,
				  if(v_opt14=true,v_addr1+v_addr2,
				  ''))))))))))))));

shared string v_csz   := if(v_opt1 =true,v_addr1,
                  if(v_opt2 =true,v_addr2,
				  if(v_opt3 =true,v_addr3,
				  //if it's just a city/st with no comma between, insert a comma
				  if(v_opt4 =true,if(regexfind('[A-Z] [A-Z][A-Z]',v_addr4),
				                   v_addr4[1..length(trim(v_addr4))-3]+', '+v_addr4[length(trim(v_addr4))-1..length(trim(v_addr4))],
								  v_addr4),
				  if(v_opt5 =true,v_addr2,
				  if(v_opt6 =true,v_addr3,
				  if(v_opt7 =true,v_addr4,
				  if(v_opt8 =true,if(v_addr2_has_nbr=false,v_addr2+v_addr3,''),
				  if(v_opt9 =true,v_addr4,
				  if(v_opt10=true,v_addr3+v_addr4,
				  if(v_opt11=true,if(v_addr2_has_nbr=false,v_addr2+v_addr3,v_addr3),
				  if(v_opt12=true,v_addr4,
				  if(v_opt13=true,v_addr3+v_addr4,
				  if(v_opt14=true,v_addr3+v_addr4,
				  ''))))))))))))));
				  
export parsed_addr := stringlib.stringcleanspaces(v_addr);
export parsed_csz  := stringlib.stringcleanspaces(v_csz);

end;