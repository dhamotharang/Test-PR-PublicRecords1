import ut;

primary_names     := first_data.Rank_People(counter_=1);
household_members := first_data.Rank_People(counter_>1);

mem1 := household_members(counter_=2);
mem2 := household_members(counter_=3);
mem3 := household_members(counter_=4);
mem4 := household_members(counter_=5);
mem5 := household_members(counter_=6);

fds_group_id := record
 string71 group_id;
 string2  st;
 first_data.Layout_FDS;
end;

fds_group_id t_j1(primary_names l, mem1 r) := transform

 integer v_census_income    := (integer)l.census_income;
 string  v_census_income_trans := map(trim(l.census_income)=''                  => 'U'
                                     ,v_census_income between      1 and  9999  => 'A'
									 ,v_census_income between  10000 and  19999 => 'B'
									 ,v_census_income between  20000 and  29999 => 'C'
									 ,v_census_income between  30000 and  39999 => 'D'
									 ,v_census_income between  40000 and  49999 => 'E'
									 ,v_census_income between  50000 and  59999 => 'F'
									 ,v_census_income between  60000 and  69999 => 'G'
									 ,v_census_income between  70000 and  79999 => 'H'
									 ,v_census_income between  80000 and  89999 => 'I'
									 ,v_census_income between  90000 and  99999 => 'J'
									 ,v_census_income between 100000 and 149999 => 'K'
									 ,v_census_income >=                 150000 => 'L'
									 ,'U'
									 );
 
 integer v_census_age       := (integer)l.census_age;
 string  v_census_age_trans := map(trim(l.census_age)=''          => 'U'
                                  ,v_census_age between 00 and 24 => 'A'
                                  ,v_census_age between 25 and 29 => 'B'
								  ,v_census_age between 30 and 34 => 'C'
								  ,v_census_age between 35 and 39 => 'D'
								  ,v_census_age between 40 and 44 => 'E'
								  ,v_census_age between 45 and 49 => 'F'
								  ,v_census_age between 50 and 54 => 'G'
								  ,v_census_age between 55 and 59 => 'H'
								  ,v_census_age between 60 and 64 => 'I'
								  //Original First Data code had 65+ translating to J... that shouldn't appear
								  ,v_census_age between 65 and 69 => 'K'
								  ,v_census_age between 70 and 74 => 'L'
								  ,v_census_age >=             75 => 'M',
								  'U'
								  );
								  
 string10 v_phone  := if(length(trim((string)(integer)l.phone))=7 or length(trim((string)(integer)l.phone))=10,l.phone,'');
 string20 v_fname  := if(l.mktg_fname<>'',l.mktg_fname,l.fname);
 string1  v_gender := if(l.orig_gender in ['F','M'],l.orig_gender,
                      if(DataLib.gender(v_fname) in ['F','M'],DataLib.gender(v_fname),
					  'U'));
 
 boolean has_right_rec := if((r.fname<>'' or r.mktg_fname<>'') and l.did<>r.did,true,false);
 
 /*
 string2 v_hdr_lor := intformat((l.hdr_dt_last_seen div 100)-(l.hdr_dt_first_seen div 100),2,1);
 string2 v_inf_lor := intformat((integer)ut.GetDate[1..4]-(integer)l.effective_dt[1..4],2,1);
 
 string2 v_lor     := if(v_hdr_lor between '01' and '99',v_hdr_lor,
                      if(v_inf_lor between '01' and '99',v_inf_lor,
					  '01'
					  ));
 */
 
 string6 v_hdr_lor := if(l.hdr_dt_first_seen<>0   and l.hdr_dt_first_seen between 190000   and (integer)ut.GetDate[1..6],(string6)l.hdr_dt_first_seen,'');
 string6 v_inf_lor := if(trim(l.effective_dt)<>'' and l.effective_dt      between '190000' and ut.GetDate[1..6],l.effective_dt,'');
 
 string6 v_lor := if(trim(v_hdr_lor)<>'',v_hdr_lor,
                  if(trim(v_inf_lor)<>'',v_inf_lor,
				  '999999'));
 
 //Added for the purpose of producing counts per state
 self.st                 := l.st;
 
 self.record_ind         := '';
 
 self.adl                := if(l.did<>0,intformat(l.did,12,1),'');
 self.phone              := v_phone;
 self.last_name          := l.preferred_lname;
 self.first_name         := v_fname;
 self.middle_init        := if(l.mktg_mname<>'',l.mktg_mname[1],l.mname[1]);
 self.name_suffix        := if(l.mktg_name_suffix<>'',l.mktg_name_suffix,l.name_suffix);
 self.title_cd           := if(v_gender='M','1',if(v_gender='F','9','0'));
 self.gender             := v_gender;
 self.dob                := if(l.mktg_dob<>0,(string8)l.mktg_dob,l.orig_dob_dd_appended);
 self.age_cd             := v_census_age_trans;
 self.house_nbr          := l.prim_range;
 self.predir             := l.predir;
 self.str_suffix         := l.addr_suffix;
 self.postdir            := l.postdir;
 self.str_name           := l.prim_name;
 self.zip                := l.zip+l.zip4;
 self.unit_type          := l.unit_desig;
 self.unit_nbr           := l.sec_range;
 self.lor                := v_lor;						
 self.dwelling_unit_size := '01';
 self.rent_own_score_    := '5';
 self.income_code        := v_census_income_trans;
 self.sesi_score         := '';
 self.hhid               := if(l.hhid<>0,(string)l.hhid,'');
  
 self.member_1             := if(has_right_rec,
                               if(r.mktg_fname<>'',r.mktg_fname,r.fname)
							  ,'');
 self.member_1_middle_init := if(has_right_rec,
                               if(r.mktg_mname<>'',r.mktg_mname[1],
							   if(r.mname<>'',r.mname[1],
							  '')),'');
 self.member_1_name_suffix := if(has_right_rec,
                               if(r.mktg_name_suffix<>'',r.mktg_name_suffix,
							   if(r.name_suffix<>'',r.name_suffix,
							  '')),'');							  
 self.member_1_gender      := if(has_right_rec,
                               if(r.orig_gender in ['F','M'],r.orig_gender,
                               if(DataLib.gender(self.member_1) in ['F','M'],DataLib.gender(self.member_1),
							    'U')),
							  '');
 self.member_1_dob         := if(has_right_rec,
                               if(r.mktg_dob<>0,(string8)r.mktg_dob,
                               if(r.orig_dob_dd_appended<>'',r.orig_dob_dd_appended,
							  '')),'');
 self.member_1_adl         := if(has_right_rec,if(r.did<>0,intformat(r.did,12,1),''),'');
 
 self.group_id             := l.group_id;
end;

j1 := join(primary_names,mem1,left.group_id=right.group_id,t_j1(left,right),left outer);

fds_group_id t_j2(j1 l, mem2 r) := transform
 
 boolean has_right_rec := if((r.fname<>'' or r.mktg_fname<>'') and (unsigned6)l.adl<>r.did,true,false);
 
 self.member_2             := if(has_right_rec,
                               if(r.mktg_fname<>'',r.mktg_fname,r.fname)
							  ,'');
 self.member_2_middle_init := if(has_right_rec,
                               if(r.mktg_mname<>'',r.mktg_mname[1],
							   if(r.mname<>'',r.mname[1],
							  '')),'');
 self.member_2_name_suffix := if(has_right_rec,
                               if(r.mktg_name_suffix<>'',r.mktg_name_suffix,
							   if(r.name_suffix<>'',r.name_suffix,
							  '')),'');							  
 self.member_2_gender      := if(has_right_rec,
                               if(r.orig_gender in ['F','M'],r.orig_gender,
                               if(DataLib.gender(self.member_2) in ['F','M'],DataLib.gender(self.member_2),
							    'U')),
							  '');
 self.member_2_dob         := if(has_right_rec,
                               if(r.mktg_dob<>0,(string8)r.mktg_dob,
                               if(r.orig_dob_dd_appended<>'',r.orig_dob_dd_appended,
							  '')),'');
 self.member_2_adl         := if(has_right_rec,if(r.did<>0,intformat(r.did,12,1),''),'');
 self                      := l;
end;

j2 := join(j1,mem2,left.group_id=right.group_id,t_j2(left,right),left outer);
 
fds_group_id t_j3(j2 l, mem3 r) := transform
 
 boolean has_right_rec := if((r.fname<>'' or r.mktg_fname<>'') and (unsigned6)l.adl<>r.did,true,false);
 
 self.member_3             := if(has_right_rec,
                               if(r.mktg_fname<>'',r.mktg_fname,r.fname)
							  ,'');
 self.member_3_middle_init := if(has_right_rec,
                               if(r.mktg_mname<>'',r.mktg_mname[1],
							   if(r.mname<>'',r.mname[1],
							  '')),'');
 self.member_3_name_suffix := if(has_right_rec,
                               if(r.mktg_name_suffix<>'',r.mktg_name_suffix,
							   if(r.name_suffix<>'',r.name_suffix,
							  '')),'');							  
 self.member_3_gender      := if(has_right_rec,
                               if(r.orig_gender in ['F','M'],r.orig_gender,
                               if(DataLib.gender(self.member_3) in ['F','M'],DataLib.gender(self.member_3),
							    'U')),
							  '');
 self.member_3_dob         := if(has_right_rec,
                               if(r.mktg_dob<>0,(string8)r.mktg_dob,
                               if(r.orig_dob_dd_appended<>'',r.orig_dob_dd_appended,
							  '')),'');
 self.member_3_adl         := if(has_right_rec,if(r.did<>0,intformat(r.did,12,1),''),'');
 self                      := l;
end;

j3 := join(j2,mem3,left.group_id=right.group_id,t_j3(left,right),left outer);

fds_group_id t_j4(j3 l, mem4 r) := transform
 
 boolean has_right_rec := if((r.fname<>'' or r.mktg_fname<>'') and (unsigned6)l.adl<>r.did,true,false);
 
 self.member_4             := if(has_right_rec,
                               if(r.mktg_fname<>'',r.mktg_fname,r.fname)
							  ,'');
 self.member_4_middle_init := if(has_right_rec,
                               if(r.mktg_mname<>'',r.mktg_mname[1],
							   if(r.mname<>'',r.mname[1],
							  '')),'');
 self.member_4_name_suffix := if(has_right_rec,
                               if(r.mktg_name_suffix<>'',r.mktg_name_suffix,
							   if(r.name_suffix<>'',r.name_suffix,
							  '')),'');							  
 self.member_4_gender      := if(has_right_rec,
                               if(r.orig_gender in ['F','M'],r.orig_gender,
                               if(DataLib.gender(self.member_4) in ['F','M'],DataLib.gender(self.member_4),
							    'U')),
							  '');
 self.member_4_dob         := if(has_right_rec,
                               if(r.mktg_dob<>0,(string8)r.mktg_dob,
                               if(r.orig_dob_dd_appended<>'',r.orig_dob_dd_appended,
							  '')),'');
 self.member_4_adl         := if(has_right_rec,if(r.did<>0,intformat(r.did,12,1),''),'');
 self                      := l;
end;

j4 := join(j3,mem4,left.group_id=right.group_id,t_j4(left,right),left outer);

fds_group_id t_j5(j4 l, mem5 r) := transform
 
 boolean has_right_rec := if((r.fname<>'' or r.mktg_fname<>'') and (unsigned6)l.adl<>r.did,true,false);
 
 self.member_5             := if(has_right_rec,
                               if(r.mktg_fname<>'',r.mktg_fname,r.fname)
							  ,'');
 self.member_5_middle_init := if(has_right_rec,
                               if(r.mktg_mname<>'',r.mktg_mname[1],
							   if(r.mname<>'',r.mname[1],
							  '')),'');
 self.member_5_name_suffix := if(has_right_rec,
                               if(r.mktg_name_suffix<>'',r.mktg_name_suffix,
							   if(r.name_suffix<>'',r.name_suffix,
							  '')),'');							  
 self.member_5_gender      := if(has_right_rec,
                               if(r.orig_gender in ['F','M'],r.orig_gender,
                               if(DataLib.gender(self.member_5) in ['F','M'],DataLib.gender(self.member_5),
							    'U')),
							  '');
 self.member_5_dob         := if(has_right_rec,
                               if(r.mktg_dob<>0,(string8)r.mktg_dob,
                               if(r.orig_dob_dd_appended<>'',r.orig_dob_dd_appended,
							  '')),'');
 self.member_5_adl         := if(has_right_rec,if(r.did<>0,intformat(r.did,12,1),''),'');
 self                      := l;
end;

j5 := join(j4,mem5,left.group_id=right.group_id,t_j5(left,right),left outer);// : persist('~thor_dell400_2::persist::fds_map_to_common');

r_state_stat := record
 j5.st;
 count_ := count(group);
end;

t_counts_per_state := sort(table(j5,r_state_stat,st,few),st);
output(t_counts_per_state,,'out::fds::counts_per_state',overwrite);

first_data.Layout_FDS drop_the_groupid(j5 l) := transform
 self := l;
end;

export Map_To_Common := project(j5,drop_the_groupid(left));
