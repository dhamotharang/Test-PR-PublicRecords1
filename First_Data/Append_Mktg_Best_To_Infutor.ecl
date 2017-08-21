
//I'm applying the mktg data so that I can use the mktg_lname when trying to find
//other individuals in a join to the HHID file (based on lname and addr_id)
//I thought this was necessary because of the name flipping (hence a bad lname)
//in the Infutor raw file.
first_data.layout_fatrec add_marketing_for_infutor_did(first_data.layout_fatrec l, first_data.Marketing_Header r) := transform
 
 boolean has_right_rec := r.did;
 
 //Added conditioning because not every DID is in the Marketing Header
 //This is necessary because dedup'ing is done on the Marketing name, not the orig Infutor clean name
 
 self.mktg_fname             := if(has_right_rec,r.fname,l.fname);
 self.mktg_mname             := if(has_right_rec,r.mname,l.mname);
 self.mktg_lname             := if(has_right_rec,r.lname,l.lname);
 self.mktg_name_suffix       := if(has_right_rec,r.name_suffix,l.name_suffix);
 self.mktg_dob               := r.dob;
 self.mktg_dod               := r.dod;
 self.mktg_total_records     := r.total_records;
 self.mktg_addr_dt_last_seen := r.addr_dt_last_seen;
 
 self.mktg_attempt           := '1';
 
 self                        := l;
end;

infutor_mktg := join(first_data.Get_HHID,first_data.Marketing_Header,
                     left.did=right.did,
				     add_marketing_for_infutor_did(left,right),
				     left outer, local
				    );

export Append_Mktg_Best_To_Infutor := distribute(infutor_mktg,hash(mktg_lname,addr_id));