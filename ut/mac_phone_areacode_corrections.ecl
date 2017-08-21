export mac_phone_areacode_corrections(in_file, out_file, phone_field) := macro

import risk_indicators,header,header_quick,cellphone,ut,gong,phonesplus;

//retrieve the data with valid area code from input file
Toll_Free_Area_Codes := ['800','811','822','833','844','855','866','877','888','899'];
boolean valid_areacode(string p) := length(trim(p,left,right)) = 10 and (unsigned)p> 0 and p[1..3] != '000'
                                    and p[1..3] not in Toll_Free_Area_Codes;

#uniquename(in_file_has_valid_phone)
#uniquename(skip_these)
%in_file_has_valid_phone% := in_file(valid_areacode(phone_field));
%skip_these% := in_file(~valid_areacode(phone_field));

//slim input file
infile_slim := table(%in_file_has_valid_phone%, {string8 phone_date := '',
string10 phone_before := %in_file_has_valid_phone%.phone_field, 
string10 prim_range := '', string5 zip5 := '', string10 phone_after := '',
string1 current_rec_flag := '', unsigned1 change_areacode_flag := 0});

//rollup on the file to apply for areacode changes
pre_candidates_dist := distribute(infile_slim, hash(phone_before));
pre_candidates_dedup := dedup(sort(pre_candidates_dist, phone_before,local), phone_before, local);

//add landline phone type and get invalid phone as candidates for area code changes
yellowpages.NPA_PhoneType(pre_candidates_dedup, phone_before, phonetype, candidates_landline);

#uniquename(candidates)
%candidates% := candidates_landline(phonetype = 'INVALID-NPA/NXX/TB');

//join with gong history file by 10 digits
//gong history file 
#uniquename(gong_hist)
%gong_hist% := Gong.File_History(valid_areacode(phone10));

%candidates% t10digits(%candidates% le, %gong_hist% ri) := transform 
self.phone_date   := ri.filedate[..8];
self.prim_range   := ri.prim_range;
self.zip5         := ri.z5;
self.current_rec_flag := ri.current_record_flag;
self              := le;
end;

candidates_for_gong := join(distribute(%candidates%, hash(phone_before)),
                            distribute(%gong_hist%,hash(phone10)),
                            left.phone_before = right.phone10,t10digits(left, right), local);

candidates_for_gong_dedup := dedup(sort(candidates_for_gong, phone_before,-phone_date,-current_rec_flag, -zip5, -prim_range, local),phone_before, local);

//determine possible phone changes from gong history

#uniquename(candidates_for_gong_dist)
%candidates_for_gong_dist% := distribute(candidates_for_gong_dedup, hash(phone_before[4..10]));

#uniquename(gong_hist_dist)
#uniquename(gong_hist_sort)
%gong_hist_dist% := distribute(%gong_hist%,hash(phone10[4..10]));

%candidates_for_gong_dist% t_find_possible_changes(%candidates_for_gong_dist% le, %gong_hist_dist% ri) 
:= transform

self.phone_after :=  ri.phone10;
self.prim_range  :=  ri.prim_range;
self.zip5        :=  ri.z5;
self.phone_date  :=  ri.filedate[..8];
self.current_rec_flag := ri.current_record_flag;
self.change_areacode_flag := if(le.phone_before <> ri.phone10,1,0); 
self             :=  le;
end;
		
possible_changes_from_gong := join(%candidates_for_gong_dist%, %gong_hist_dist%,
						 left.phone_before[4..10] = right.phone10[4..10] and
						 left.zip5 = right.z5 and right.z5 <> '' and
						 left.prim_range = right.prim_range and
						 (unsigned4)left.phone_date <= (unsigned4)right.filedate[..8],
					     t_find_possible_changes(left, right), local);	

#uniquename(possible_changes_from_gong_dedup)
%possible_changes_from_gong_dedup% := dedup(sort(distribute(possible_changes_from_gong, hash(phone_before)),
phone_before, -phone_date, -current_rec_flag, -Change_areacode_flag, phone_after,local), phone_before, local);

//join phone with area code changes back to input file
#uniquename(t_correct_areacode)
%in_file_has_valid_phone% %t_correct_areacode%(%in_file_has_valid_phone% le, %possible_changes_from_gong_dedup% ri) := transform

self.phone_field := if(le.phone_field = ri.phone_before,ri.phone_after,le.phone_field);
self := le;
end;

correct_areacode := join(distribute(%in_file_has_valid_phone%, hash((string10)phone_field)),
                          %possible_changes_from_gong_dedup%,
						  left.phone_field = (string10) right.phone_before,%t_correct_areacode%(left, right),left outer,local);
						   
//combine the data with correct areacode and the data with invalid areacode from input file
out_file := correct_areacode + %skip_these%;
endmacro;
								
