import header;
export MAC_append_hhid_and_relatives (file_in, phone_field, file_out) := macro


//Household ID file
#uniquename(hhid_f) 
#uniquename(hhid_d) 
#uniquename(hhid_s) 
#uniquename(hhid_dedp)
%hhid_f% 		:= header.File_HHID; 
%hhid_d% 		:= distribute(%hhid_f%, hash(did));
%hhid_s% 		:= sort(%hhid_d%, did, -last_current, local);
%hhid_dedp% 	:= dedup(%hhid_s%, did, local);

//Input file
#uniquename(file_in_d) 
#uniquename(file_in_s) 
#uniquename(file_in_dedp) 
%file_in_d% 	:= distribute(file_in (did > 0), hash(did));
%file_in_s% 	:= sort(%file_in_d%, did, phone_field, local);
%file_in_dedp% 	:= dedup(%file_in_s% , did, phone_field, local);

//Output layout
#uniquename(layout_appended) 
%layout_appended% := record
	unsigned6 did 		:= 0;
	unsigned6 hhid_cur  := 0;
	string10  phone  	:= '';
end;

//Get latest household id 
#uniquename(t_append_hhid_cur) 
%layout_appended% %t_append_hhid_cur%(%file_in_dedp% le, %hhid_dedp% ri) := transform
	self.did	  := le.did;
	self.hhid_cur := ri.hhid_indiv;
	self.phone	  := le.phone_field;
end;

#uniquename(hhid_cur) 
%hhid_cur% := join(%file_in_dedp%, %hhid_dedp%, 
					left.did = right.did, 
					%t_append_hhid_cur%(left, right), local);

//Add relatives
#uniquename(hhid_cur_d) 
#uniquename(hhid_cur_s)
%hhid_cur_d% := distribute(%hhid_cur%, hash(hhid_cur));
%hhid_cur_s% := sort(%hhid_cur_d%, hhid_cur, local);

#uniquename(hhid_d2) 
#uniquename(hhid_s2) 
%hhid_d2% 		:= distribute(%hhid_dedp%, hash(hhid_indiv));
%hhid_s2% 		:= sort(%hhid_d2%, hhid_indiv, local);

#uniquename(t_append_relatives) 
%layout_appended% %t_append_relatives% (%hhid_s2% le, %hhid_cur_s% ri) := transform
	self.hhid_cur := le.hhid_indiv;
	self.phone	  := ri.phone;
	self 		  := le;
end;

file_out := join(%hhid_s2%, %hhid_cur_s%, 
					left.hhid_indiv = right.hhid_cur, 
					%t_append_relatives%(left, right), local);
endmacro;