
import paw;
 

layout_pilot_prettied_slim := record
string12 did;
string	ID;
string8 date_last_seen;
string1 current_flag;
string10 record_type;
string1 letter_code;
string6 med_exp_date;
string1 Crim := '';
string1 SOR := '';
string  Name;   
string Address;
string City_ST_Zip;
string offenses := '';
string8 cer_date_first_seen;
string8 cer_date_last_seen;
string1 cer_current_flag;
string1 cer_letter;
string7 cer_unique_id;
string2 cer_rec_type;
string1 cer_type;
string20	cer_type_mapped;
string1 cer_level;
string45	cer_level_mapped;
string8 cer_exp_date;
string99 ratings;
end;

strong_keepers := dataset('~thor::temp::pilot_derogatories_detail_strong_keepers',layout_pilot_prettied_slim,flat);
pilotsx := strong_keepers(trim(cer_current_flag)='A' and trim(cer_type)='P' and trim(cer_level) in ['A','C']);

pawx := paw.file_base;

my_pilots:= sort(distribute(pilotsx,hash((integer) did)), (integer) did,local);

my_paw := sort(distribute(pawx(did<>0),hash((integer) did)),(integer) did,local);

layout_joined_with_paw := record
string	ID;
string8 date_last_seen;
// string1 current_flag;
string10 record_type;
// string1 letter_code;
// string6 med_exp_date;
string1 Crim := '';
string1 SOR := '';
string  Name;   
string Address;
string City_ST_Zip;
string offenses := '';
// string8 cer_date_first_seen;
// string8 cer_date_last_seen;
// string1 cer_current_flag;
// string1 cer_letter;
// string7 cer_unique_id;
// string2 cer_rec_type;
// string1 cer_type;
string20	cer_type_mapped;
// string1 cer_level;
string45	cer_level_mapped;
string8 cer_exp_date;
// string99 ratings;
			UNSIGNED6 contact_id;
			STRING3   score;
			STRING120 company_name;
			STRING10  company_prim_range;
			STRING2   company_predir;
			STRING28  company_prim_name;
			STRING4   company_addr_suffix;
			STRING2   company_postdir;
			STRING5   company_unit_desig;
			STRING8   company_sec_range;
			STRING25  company_city;
			STRING2   company_state;
			STRING5   company_zip;
			STRING4   company_zip4;
			STRING35  company_title;
			STRING35  company_department;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   addr_suffix;
			STRING2   postdir;
			STRING5   unit_desig;
			STRING8   sec_range;
			STRING25  city;
			STRING2   state;
			STRING5   zip;
			STRING8   dt_first_seen;
			STRING8   dt_last_seen;
			STRING1   paw_record_type;
			STRING1   GLB;
			STRING2   source;
end;
layout_joined_with_paw to_join(my_pilots l, my_paw r) := transform
self.paw_record_type := r.record_type;
self := r;
self := l;
end;
res := join(my_pilots,my_paw, (integer) left.did= (integer) right.did,to_join(left,right),local, left outer);

res_dedup:= dedup(sort(distribute(res,hash(ID)),record,local),all,local);
output(choosen(res_dedup,10000));
