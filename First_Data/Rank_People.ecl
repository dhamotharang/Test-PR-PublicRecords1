

living_people_plus_infutor_no_did      := first_data.Remove_Dead_People+first_data.Default_Those_That_Didnt_DID;

living_people_plus_infutor_no_did_sort := sort(living_people_plus_infutor_no_did,      mktg_fname,mktg_mname[1],mktg_lname,mktg_name_suffix,prim_range,prim_name,sec_range,zip,infutor_or_mktg_ind);
people_getting_sent_to_firstdata       := dedup(living_people_plus_infutor_no_did_sort,mktg_fname,mktg_mname[1],mktg_lname,mktg_name_suffix,prim_range,prim_name,sec_range,zip,all);

group_rec := record
 first_data.layout_fatrec;
 string71  group_id;
 unsigned3 counter_:=0;
 string20  preferred_lname;
end;

group_rec define_groupid(first_data.layout_fatrec l) := transform
 
 string20 v_lname_to_use  := if(l.mktg_lname<>'',l.mktg_lname,l.lname);
 string20 v_lname_to_use2 := stringlib.stringfindreplace(trim(v_lname_to_use),' ','-');

 self.group_id        := trim(stringlib.stringfilterout(stringlib.stringcleanspaces(v_lname_to_use2+l.prim_range+l.prim_name+l.sec_range+l.zip),' '));
 self.preferred_lname := v_lname_to_use2;
 self                 := l;
end;

people_groupid       := project   (people_getting_sent_to_firstdata,define_groupid(left));

people_groupid_dist  := distribute(people_groupid,hash(group_id));
people_groupid_sort  := sort      (people_groupid_dist,group_id,infutor_or_mktg_ind,-mktg_total_records,local);
people_groupid_grp   := group     (people_groupid_sort,group_id);
							 
group_rec add_counter(people_groupid_grp l, integer c) := transform
 self.counter_ := l.counter_+c;
 self          := l;
end;

people_with_counter  := project(people_groupid_grp,add_counter(left,counter));

people_ungrouped     := ungroup(people_with_counter);
people_before_split  := people_ungrouped(fname<>'' or mktg_fname<>'');

export Rank_People := people_before_split;