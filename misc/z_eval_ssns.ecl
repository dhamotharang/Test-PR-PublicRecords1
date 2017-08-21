import misc;

raw := misc.file_my_output2_rxvh;

filter_expression := '-';
raw_filtered_has := raw(regexfind(filter_expression, payload));

filter_expression_not := '^-';
raw_filtered:= raw_filtered_has(not regexfind(filter_expression_not,payload));
//output(choosen(raw_filtered,1000));
//output(count(raw_filtered));

layout_my_output2_to_use := record
string payload;
unsigned4 group_size;
string9 ssn_lower;
string9 ssn_upper;
string9 ssn;
end;
layout_my_output2_to_use raw_to_use(raw_filtered L) := transform
self.ssn_lower := (L.payload[1..5]+L.payload[10..13]);
self.ssn_upper := (L.payload[1..5]+L.payload[15..18]);
self.ssn := '';
self.group_size := (integer) stringlib.stringfilter(L.payload[20..30],'0123456789');
self := L;
end;
my_output2_to_use_project := project(raw_filtered, raw_to_use(left));


layout_my_output2_to_use get_all_ssns(my_output2_to_use_project L, unsigned4 C) := transform
self.ssn := (string9) intformat((((integer) L.ssn_lower)+C-1),9,1);
self := L;
end;
my_output2_to_use := normalize(my_output2_to_use_project, left.group_size, get_all_ssns(left,counter));


my_output2_dist := distribute(my_output2_to_use, hash(ssn[1..5]));
my_output2_sort := sort(my_output2_dist,ssn,LOCAL);
my_output2_final := dedup(my_output2_sort,ssn,LOCAL);

//output(my_output2_final);
//output(misc.extract_ssns);

layout_joined_eval :=  record
string9 extract_ssn;
layout_my_output2_to_use;
end;

layout_joined_eval join_extract_to_use(misc.extract_ssns L, my_output2_final R) := transform
self.extract_ssn := L.ssn;
self := R;
end;

my_joined_extract_to_use := join(misc.extract_ssns, my_output2_final,  (LEFT.ssn=RIGHT.ssn), join_extract_to_use(LEFT,RIGHT),LOCAL, FULL OUTER);

//output(my_joined_extract_to_use);

EXPORT eval_ssns := my_joined_extract_to_use : PERSIST('TEMP::eval_ssns');