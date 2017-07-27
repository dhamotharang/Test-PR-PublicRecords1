EXPORT Layout_Clean_Name_Enclarity := 
record
	string15 name_prefix	;//[1..15];
	string50 fname				;//[16..65];
	string50 mname				;//[66..115];
	string50 lname				;//[116..165];
	string15 name_prof		;//[166..180];
	string15 name_suffix	;//[181..195];
	string15 name_title		;//[196..210];
	string5  name_score		;//[211..215];
	string1  name_gender	;//[216];
	string50 name_prefered;//[217..266];
end;