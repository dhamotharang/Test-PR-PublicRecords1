
infutor_plus_additional_members := first_data.Append_Mktg_Best_To_Infutor+first_data.Get_Additional_Members;

already_marketed      := infutor_plus_additional_members(infutor_or_mktg_ind='1');
already_marketed_dupd := dedup     (already_marketed,          mktg_fname,mktg_mname[1],mktg_lname,prim_range,prim_name,sec_range,zip,all);
already_marketed_dist := distribute(already_marketed_dupd,hash(mktg_fname,mktg_mname[1],mktg_lname,prim_range,prim_name,sec_range,zip));

still_to_market       := distribute(infutor_plus_additional_members(did<>0,infutor_or_mktg_ind='2'),hash(did));

first_data.layout_fatrec add_marketing_for_additional_members(first_data.layout_fatrec l, first_data.Marketing_Header r) := transform
 
 self.mktg_fname             := r.fname;
 self.mktg_mname             := r.mname;
 self.mktg_lname             := r.lname;
 self.mktg_name_suffix       := r.name_suffix;
 self.mktg_dob               := r.dob;
 self.mktg_dod               := r.dod;
 self.mktg_total_records     := r.total_records;
 self.mktg_addr_dt_last_seen := r.addr_dt_last_seen;
 
 self.mktg_attempt           := '2';
 
 self                        := l;
end;

additional_members_marketed := join(still_to_market,first_data.Marketing_Header,
                                    left.did=right.did,
				                    add_marketing_for_additional_members(left,right),
									local
				                   );

additional_members_marketed_has_fname      := additional_members_marketed(mktg_fname<>'');
additional_members_marketed_has_fname_dupd := dedup     (additional_members_marketed_has_fname,          mktg_fname,mktg_mname[1],mktg_lname,prim_range,prim_name,sec_range,zip,all);
additional_members_marketed_has_fname_dist := distribute(additional_members_marketed_has_fname_dupd,hash(mktg_fname,mktg_mname[1],mktg_lname,prim_range,prim_name,sec_range,zip));

first_data.layout_fatrec find_the_true_additional_members(first_data.layout_fatrec l, first_data.layout_fatrec r) := transform
 self := r;
end;

true_additional_members := join(already_marketed_dist,additional_members_marketed_has_fname_dist,
                                ((left.mktg_fname=right.mktg_fname or left.fname=right.mktg_fname) and
				                  left.mktg_mname[1]=right.mktg_mname[1] and
				                  left.mktg_lname=right.mktg_lname and
				                  left.prim_range=right.prim_range and
				                  left.prim_name=right.prim_name and
				                  left.sec_range=right.sec_range and
				                  left.zip=right.zip
				                ),
				                find_the_true_additional_members(left,right),
				                right only, local
				               );

true_additional_members_dupd := dedup(true_additional_members,mktg_fname,mktg_mname[1],mktg_lname,mktg_name_suffix,prim_range,prim_name,sec_range,zip,all);
output(count(true_additional_members_dupd),named('people_found_only_in_mktg'));

people := already_marketed_dupd+true_additional_members_dupd;

export Append_Mktg_Best_To_Additional_Members := distribute(people,hash(did));