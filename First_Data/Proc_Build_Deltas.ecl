import ut;
 
ds_new := distribute(dataset('~thor_data400::base::fds',first_data.Layout_FDS,flat),hash(hhid));
ds_old := distribute(dataset('~thor_data400::base::fds_father',first_data.Layout_FDS,flat),hash(hhid));

norm_rec := record
 string43	hhid;
 string20	last_name;
 string12	adl;
 string10	phone;
 string20	fname;
 string1    mname;
 string5    suffix;
 string1	gender;
 string8	dob;
 string1	age_cd;
 string10	house_nbr;
 string2	predir;
 string4	str_suffix;
 string2	postdir;
 string28	str_name;
 string9	zip;
 string8	unit_nbr;
 string2	dwelling_unit_size;
 string1	rent_own_score_;
 string1	income_code;
end;

norm_rec t_norm(first_data.Layout_FDS le, integer c) := transform
 self.adl    := choose(c,le.adl,le.member_1_adl,le.member_2_adl,le.member_3_adl,le.member_4_adl,le.member_5_adl);
 self.fname  := choose(c,le.first_name,le.member_1,le.member_2,le.member_3,le.member_4,le.member_5);
 self.mname  := choose(c,le.middle_init,le.member_1_middle_init,le.member_2_middle_init,le.member_3_middle_init,le.member_4_middle_init,le.member_5_middle_init);
 self.suffix := choose(c,le.name_suffix,le.member_1_name_suffix,le.member_1_name_suffix,le.member_1_name_suffix,le.member_1_name_suffix,le.member_5_name_suffix);
 self.dob    := choose(c,le.dob,le.member_1_dob,le.member_2_dob,le.member_3_dob,le.member_4_dob,le.member_5_dob);
 self.gender := choose(c,le.gender,le.member_1_gender,le.member_2_gender,le.member_3_gender,le.member_4_gender,le.member_5_gender);
 self        := le;
end;

norm_new := normalize(ds_new,6,t_norm(left,counter))(fname<>'');
norm_old := normalize(ds_old,6,t_norm(left,counter))(fname<>'');

r1 := record
 string43 hhid;
 //string20 last_name;
end;

r1 t1(first_data.Layout_FDS le) := transform
 self := le;
end;

//p1_a := dedup(project(norm_new,t1(left)),all);
//p1_b := dedup(project(norm_old,t1(left)),all);
p1_a := dedup(distribute(project(ds_new,t1(left)),hash(hhid)),all,local);
p1_b := dedup(distribute(project(ds_old,t1(left)),hash(hhid)),all,local);

r1 t_add_or_delete(r1 le, r1 ri) := transform
 self := le;
end;

j1_a := join(p1_a,p1_b,
             left.hhid=right.hhid,
			 t_add_or_delete(left,right),
			 left only, local
			);

j1_b := join(p1_b,p1_a,
             left.hhid=right.hhid,
			 t_add_or_delete(left,right),
			 left only, local
			);
			
first_data.Layout_FDS t_add(ds_new le, j1_a ri) := transform
 self.record_ind := 'A';
 self            := le;
end;

first_data.Layout_FDS t_delete(ds_old le, j1_b ri) := transform
 self.record_ind := 'D';
 self            := le;
end;

j_add := join(ds_new,j1_a,
              left.hhid=right.hhid,
			  t_add(left,right), local
			 );
			
j_del := join(ds_old,j1_b,
              left.hhid=right.hhid,
			  t_delete(left,right), local
			 );

output(count(j_add),named('these_are_adds'));
output(count(j_del),named('these_are_deletes'));

r1 t_in_both(p1_a le, p1_b ri) := transform
 self := le;
end;

j_in_both := join(p1_a,p1_b,
				  left.hhid=right.hhid,
				  t_in_both(left,right), local
				 );

norm_rec t_get_orig(norm_rec le, r1 ri) := transform
 self := le;
end;

j_get_orig_new := join(norm_new,j_in_both,
                       left.hhid=right.hhid,
			           t_get_orig(left,right), local
			          );

j_get_orig_old := join(norm_old,j_in_both,
                       left.hhid=right.hhid,
			           t_get_orig(left,right), local
			          );

norm_rec t_get_new_where_hhid_lname_is_in_both(norm_rec le, norm_rec ri) := transform
 self := le;
end;
			  
hhid_lname_in_new := join(j_get_orig_new,j_get_orig_old,
                            (left.hhid               = right.hhid               and
				             left.last_name          = right.last_name          and
					         left.adl                = right.adl                and
				             left.phone              = right.phone              and
				             left.fname              = right.fname              and
				             left.mname              = right.mname              and
				             left.suffix             = right.suffix             and
                             //left.title_cd           = right.title_cd           and
				             left.gender             = right.gender             and
				             left.dob                = right.dob                and
				             left.age_cd             = right.age_cd             and
				             left.house_nbr          = right.house_nbr          and
				             left.predir             = right.predir             and
				             left.str_suffix         = right.str_suffix         and
				             left.postdir            = right.postdir            and
				             left.str_name           = right.str_name           and
				             left.zip                = right.zip                and
				             left.unit_nbr           = right.unit_nbr           and
				             //left.dwelling_unit_size = right.dwelling_unit_size and
                             left.rent_own_score_    = right.rent_own_score_    and
				             left.income_code        = right.income_code				    
				  ),
				  t_get_new_where_hhid_lname_is_in_both(left,right),
				  left only, local
				 ) : persist('fds_change_new_only');
				 
hhid_lname_in_old := join(j_get_orig_old,j_get_orig_new,
                            (left.hhid               = right.hhid               and
				             left.last_name          = right.last_name          and
					         left.adl                = right.adl                and
				             left.phone              = right.phone              and
				             left.fname              = right.fname              and
				             left.mname              = right.mname              and
				             left.suffix             = right.suffix             and
                             //left.title_cd           = right.title_cd           and
				             left.gender             = right.gender             and
				             left.dob                = right.dob                and
				             left.age_cd             = right.age_cd             and
				             left.house_nbr          = right.house_nbr          and
				             left.predir             = right.predir             and
				             left.str_suffix         = right.str_suffix         and
				             left.postdir            = right.postdir            and
				             left.str_name           = right.str_name           and
				             left.zip                = right.zip                and
				             left.unit_nbr           = right.unit_nbr           and
				             //left.dwelling_unit_size = right.dwelling_unit_size and
                             left.rent_own_score_    = right.rent_own_score_    
				             //left.income_code        = right.income_code				    
				  ),
				  t_get_new_where_hhid_lname_is_in_both(left,right),
				  left only, local
				 ) : persist('fds_change_old_only');

hhid_lname_in_new_sort := sort(hhid_lname_in_new,hhid,last_name,fname);
hhid_lname_in_old_sort := sort(hhid_lname_in_old,hhid,last_name,fname);
	
concat := hhid_lname_in_new + hhid_lname_in_old;

r1 t_get_changed_hhid_lnames(norm_rec le) := transform
 self := le;
end;

p_get_changed_hhid_lnames := dedup(project(concat,t_get_changed_hhid_lnames(left)),all,local);

first_data.Layout_FDS t_get_changed(first_data.Layout_FDS le, r1 ri) := transform
 self.record_ind := 'C';
 self            := le;
end;

j_chg := join(ds_new,p_get_changed_hhid_lnames,
              left.hhid=right.hhid,
			  t_get_changed(left,right), local
			 );

output(count(j_chg),named('these_are_changes'));
output(choosen(hhid_lname_in_new_sort,500),named('change_in_new_only_sample'));
output(choosen(hhid_lname_in_old_sort,500),named('change_in_old_only_sample'));
output(choosen(enth(j_chg,1,100,1),100),named('change_output_sample'));

build_delta := j_add+j_del+j_chg;

s1 := record
 build_delta.record_ind;
 count_ := count(group);
end;

table1 := sort(table(build_delta,s1,record_ind),record_ind);
output(table1,named('delta_counts'));

ut.mac_sf_buildprocess(build_delta,'~thor_data400::base::fds_delta',build_fds_delta,3);

export Proc_Build_Deltas := build_fds_delta;