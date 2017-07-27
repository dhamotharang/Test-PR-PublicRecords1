import header;
//evaluates 2 names and determines if one is a match to the other candidate, before or after the hyphen

export fn_match_on_hyphenated_name(string in_name1_0, string in_name2_0) := function

 string in_name1 := stringlib.stringtouppercase(in_name1_0);
 string in_name2 := stringlib.stringtouppercase(in_name2_0);
 
 integer which_is_hyphened := if(header.mod_hyphenated_lname(in_name1).is_hyphenated,1,
                              if(header.mod_hyphenated_lname(in_name2).is_hyphenated,2,
															0));
															
 string name_to_split := if(which_is_hyphened=1,in_name1,in_name2);

 string name_sub1 := if(which_is_hyphened=1,header.mod_hyphenated_lname(in_name1).lname1st,header.mod_hyphenated_lname(in_name2).lname1st);
 string name_sub2 := if(which_is_hyphened=1,header.mod_hyphenated_lname(in_name1).lname2nd,header.mod_hyphenated_lname(in_name2).lname2nd);
 
 boolean is_match_on_partial := if(which_is_hyphened=1 and (in_name2=name_sub1 or in_name2=name_sub2),true,
                                if(which_is_hyphened=2 and (in_name1=name_sub1 or in_name1=name_sub2),true,
																false));

 return is_match_on_partial;
end;