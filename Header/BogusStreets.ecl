export BogusStreets(string in_value) := function

exception_set := ['CCC','RRRT'];

boolean in_value_all_consonants := trim(stringlib.stringfilter(in_value,'BCDFGHJKLMNPQRSTVWXZ'))=trim(in_value);
integer prim_name_length        := length(trim(in_value));

boolean ret_value := 
in_value in
[
'ANYWHERE',
'NOT GIVEN',
'NOT GVN',
'NONE',
'NONE GIVEN',
'NONE LISTED',
'UNKNOWN',
'MAIL RETURN',
'MISSING',
'NEED NEW ADDRESS',
'N/AVAIL',
'GEN DEL',
'GENERAL DELIVERY',
'TO BE DETERMINED',
'TBD',
'THANK YOU',
'NO THANK YOU',
'NO ADDRESS'
] or
(
    prim_name_length > 2 
and in_value_all_consonants=true
and in_value[1]=in_value[2] and in_value[2]=in_value[3]
and in_value not in exception_set
);

return ret_value;

end;