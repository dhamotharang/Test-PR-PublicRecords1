//Run on 400-way

import header;

r_death_patch := RECORD
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string5 orig_clean_title;
  string20 orig_clean_fname;
  string20 orig_clean_mname;
  string20 orig_clean_lname;
  string5 orig_clean_name_suffix;
  string5 preferred_title;
  string20 preferred_fname;
  string20 preferred_mname;
  string20 preferred_lname;
  string5 preferred_suffix;
  string20 curr_header_fname;
  string20 curr_header_mname;
  string20 curr_header_lname;
  string5 curr_header_name_suffix;
 END;
 
ds_death      := dataset('~thor_dell400_2::out::death_master_plus_replacements',r_death_patch,flat);
ds_death_dist := distribute(ds_death,hash(fname,mname,lname,name_suffix,orig_clean_fname,orig_clean_mname,orig_clean_lname,orig_clean_name_suffix));

ds_death_master_plus      := dataset('~thor_data400::Base::Death_Master_Plus',header.layout_death_master_plus,flat);
ds_death_master_plus_dist := distribute(ds_death_master_plus,hash(fname,mname,lname,name_suffix,clean_fname,clean_mname,clean_lname,clean_name_suffix));

output(count(ds_death_master_plus),named('death_master_plus_coming_in'));

header.layout_death_master_plus t_fix_names(ds_death_master_plus_dist l, ds_death_dist r) := transform
 
 boolean has_right_rec  := r.preferred_fname<>'';
 
 self.clean_title       := if(has_right_rec,r.preferred_title,l.clean_title);
 self.clean_fname       := if(has_right_rec,r.preferred_fname,l.clean_fname);
 self.clean_mname       := if(has_right_rec,r.preferred_mname,l.clean_mname);
 self.clean_lname       := if(has_right_rec,r.preferred_lname,l.clean_lname);
 self.clean_name_suffix := if(has_right_rec,r.preferred_suffix,l.clean_name_suffix);
 
 self                   := l;
end;
 
p_fix_names := join(ds_death_master_plus_dist,ds_death_dist,
                    (left.fname             = right.fname                  and
					 left.mname             = right.mname                  and
					 left.lname             = right.lname                  and
					 left.name_suffix       = right.name_suffix            and
					 left.clean_fname       = right.orig_clean_fname       and
					 left.clean_mname       = right.orig_clean_mname       and
					 left.clean_lname       = right.orig_clean_lname       and
					 left.clean_name_suffix = right.orig_clean_name_suffix
					),
					t_fix_names(left,right),
					left outer,local
				   );

output(count(p_fix_names),named('death_master_plus_coming_out'));

output(p_fix_names,,'~thor_data400::in::death_master_plus_20070227b_reclean',overwrite);


r_stat_before := record
  has_filedate          := count(group,ds_death_master_plus.filedate<>'');
  has_rec_type          := count(group,ds_death_master_plus.rec_type<>'');
  has_rec_type_orig     := count(group,ds_death_master_plus.rec_type_orig<>'');
  has_ssn               := count(group,ds_death_master_plus.ssn<>'');
  has_lname             := count(group,ds_death_master_plus.lname<>'');
  has_name_suffix       := count(group,ds_death_master_plus.name_suffix<>'');
  has_fname             := count(group,ds_death_master_plus.fname<>'');
  has_mname             := count(group,ds_death_master_plus.mname<>'');
  has_VorP_code         := count(group,ds_death_master_plus.VorP_code<>'');
  has_dod8              := count(group,ds_death_master_plus.dod8<>'');
  has_dob8              := count(group,ds_death_master_plus.dob8<>'');
  has_st_country_code   := count(group,ds_death_master_plus.st_country_code<>'');
  has_zip_lastres       := count(group,ds_death_master_plus.zip_lastres<>'');
  has_zip_lastpayment   := count(group,ds_death_master_plus.zip_lastpayment<>'');
  has_state             := count(group,ds_death_master_plus.state<>'');
  has_fipscounty        := count(group,ds_death_master_plus.fipscounty<>'');
  has_clean_title       := count(group,ds_death_master_plus.clean_title<>'');
  has_clean_fname       := count(group,ds_death_master_plus.clean_fname<>'');
  has_clean_mname       := count(group,ds_death_master_plus.clean_mname<>'');
  has_clean_lname       := count(group,ds_death_master_plus.clean_lname<>'');
  has_clean_name_suffix := count(group,ds_death_master_plus.clean_name_suffix<>'');
  has_clean_name_score  := count(group,ds_death_master_plus.clean_name_score<>'');
  has_state_death_id    := count(group,ds_death_master_plus.state_death_id<>'');
  has_state_death_flag  := count(group,ds_death_master_plus.state_death_flag<>'');
end;

t_stat_before := table(ds_death_master_plus,r_stat_before);
output(t_stat_before,named('death_master_plus_stats_before_name_patch'));

r_stat_after := record
  has_filedate          := count(group,p_fix_names.filedate<>'');
  has_rec_type          := count(group,p_fix_names.rec_type<>'');
  has_rec_type_orig     := count(group,p_fix_names.rec_type_orig<>'');
  has_ssn               := count(group,p_fix_names.ssn<>'');
  has_lname             := count(group,p_fix_names.lname<>'');
  has_name_suffix       := count(group,p_fix_names.name_suffix<>'');
  has_fname             := count(group,p_fix_names.fname<>'');
  has_mname             := count(group,p_fix_names.mname<>'');
  has_VorP_code         := count(group,p_fix_names.VorP_code<>'');
  has_dod8              := count(group,p_fix_names.dod8<>'');
  has_dob8              := count(group,p_fix_names.dob8<>'');
  has_st_country_code   := count(group,p_fix_names.st_country_code<>'');
  has_zip_lastres       := count(group,p_fix_names.zip_lastres<>'');
  has_zip_lastpayment   := count(group,p_fix_names.zip_lastpayment<>'');
  has_state             := count(group,p_fix_names.state<>'');
  has_fipscounty        := count(group,p_fix_names.fipscounty<>'');
  has_clean_title       := count(group,p_fix_names.clean_title<>'');
  has_clean_fname       := count(group,p_fix_names.clean_fname<>'');
  has_clean_mname       := count(group,p_fix_names.clean_mname<>'');
  has_clean_lname       := count(group,p_fix_names.clean_lname<>'');
  has_clean_name_suffix := count(group,p_fix_names.clean_name_suffix<>'');
  has_clean_name_score  := count(group,p_fix_names.clean_name_score<>'');
  has_state_death_id    := count(group,p_fix_names.state_death_id<>'');
  has_state_death_flag  := count(group,p_fix_names.state_death_flag<>'');
end;

t_stat_after := table(p_fix_names,r_stat_after);
output(t_stat_after,named('death_master_plus_stats_after_name_patch'));