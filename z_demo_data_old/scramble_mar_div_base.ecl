
import demo_data;
import marriage_divorce_v2;

file2 := demo_data_scrambler.scramble_mar_div_search;
file_in:= dataset('~thor::base::demo_data_file_mar_div_base_prodcopy',marriage_divorce_v2.layout_mar_div_base,flat);

marriage_divorce_v2.layout_mar_div_base to_keep_p1(file_in l,file2 r) := transform
self.party1_name := r.nameasis;
self.party1_addr1 := trim(r.prim_range)+' '+trim(r.prim_name);
self.party1_csz := trim(r.v_city_name) +' '+ trim(r.st);
self := l;
end;
file_scrambled_p1 := join(file_in,file2(which_party='P1'),left.record_id=right.record_id,to_keep_p1(left,right),left outer);


marriage_divorce_v2.layout_mar_div_base to_keep_p1a(file_in l,file2 r) := transform
self.party1_alias := r.nameasis;
self := l;
end;
file_scrambled_p1a := join(file_scrambled_p1,file2(which_party='P1A'),left.record_id=right.record_id,to_keep_p1a(left,right),left outer);

marriage_divorce_v2.layout_mar_div_base to_keep_p2(file_in l,file2 r) := transform
self.party2_name := r.nameasis;
self.party2_addr1 := trim(r.prim_range)+' '+trim(r.prim_name);
self.party2_csz := trim(r.v_city_name) +' '+ trim(r.st);
self := l;
end;
file_scrambled_p2 := join(file_scrambled_p1a,file2(which_party='P2'),left.record_id=right.record_id,to_keep_p2(left,right),left outer);

marriage_divorce_v2.layout_mar_div_base to_keep_p2a(file_in l,file2 r) := transform
self.party2_alias := r.nameasis;
self := l;
end;
file_scrambled_p2a := join(file_scrambled_p2,file2(which_party='P2A'),left.record_id=right.record_id,to_keep_p2a(left,right),left outer);


marriage_divorce_v2.layout_mar_div_base to_do_rest(file_in l) := transform
self.party1_dob := demo_data_scrambler.fn_scramblePII('DOB',l.party1_dob);
self.party2_dob := demo_data_scrambler.fn_scramblePII('DOB',l.party2_dob);
self.marriage_dt := demo_data_scrambler.fn_scramblePII('DOB',l.marriage_dt);
self.divorce_filing_dt := demo_data_scrambler.fn_scramblePII('DOB',l.divorce_filing_dt);
self.marriage_filing_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.marriage_filing_number,'1','2'),'4','5');
self.divorce_filing_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.divorce_filing_number,'1','2'),'4','5');

self := l;
end;
file_final := project(file_scrambled_p2a,to_do_rest(left));

export scramble_mar_div_base := dedup(sort(file_final,record),all);

