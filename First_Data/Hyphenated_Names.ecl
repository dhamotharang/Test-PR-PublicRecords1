
d_hyphenated_names := first_data.Dwelling_Units(stringlib.stringfind(last_name,'-',1)!=0);

first_data.Layout_FDS hyphenated_names_logic(first_data.Layout_FDS l, first_data.Layout_FDS r) := transform
 
 boolean has_member_1 := if(l.member_1<>'' or l.member_1_middle_init<>'' or l.member_1_adl<>'' or l.member_1_gender<>'' or l.member_1_dob<>'',true,false);
 boolean has_member_2 := if(l.member_2<>'' or l.member_2_middle_init<>'' or l.member_2_adl<>'' or l.member_2_gender<>'' or l.member_2_dob<>'',true,false);
 boolean has_member_3 := if(l.member_3<>'' or l.member_3_middle_init<>'' or l.member_3_adl<>'' or l.member_3_gender<>'' or l.member_3_dob<>'',true,false);
 boolean has_member_4 := if(l.member_4<>'' or l.member_4_middle_init<>'' or l.member_4_adl<>'' or l.member_4_gender<>'' or l.member_4_dob<>'',true,false);
 boolean has_member_5 := if(l.member_5<>'' or l.member_5_middle_init<>'' or l.member_5_adl<>'' or l.member_5_gender<>'' or l.member_5_dob<>'',true,false);

 integer max_member := if(has_member_5,5,
                       if(has_member_4,4,
					   if(has_member_3,3,
					   if(has_member_2,2,
					   if(has_member_1,1,
					   0)))));

 boolean has_right_rec := if(r.first_name<>'',true,false);
 
 self.member_1             := if(max_member=0 and has_right_rec,r.first_name, l.member_1);
 self.member_1_middle_init := if(max_member=0 and has_right_rec,r.middle_init,l.member_1_middle_init);
 self.member_1_gender      := if(max_member=0 and has_right_rec,r.gender,     l.member_1_gender);
 self.member_1_dob         := if(max_member=0 and has_right_rec,r.dob,        l.member_1_dob);
 self.member_1_adl         := if(max_member=0 and has_right_rec,r.adl,        l.member_1_adl);

 self.member_2             := if(max_member=1 and has_right_rec,r.first_name, l.member_2);
 self.member_2_middle_init := if(max_member=1 and has_right_rec,r.middle_init,l.member_2_middle_init);
 self.member_2_gender      := if(max_member=1 and has_right_rec,r.gender,     l.member_2_gender);
 self.member_2_dob         := if(max_member=1 and has_right_rec,r.dob,        l.member_2_dob);
 self.member_2_adl         := if(max_member=1 and has_right_rec,r.adl,        l.member_2_adl);

 self.member_3             := if(max_member=2 and has_right_rec,r.first_name, l.member_3);
 self.member_3_middle_init := if(max_member=2 and has_right_rec,r.middle_init,l.member_3_middle_init);
 self.member_3_gender      := if(max_member=2 and has_right_rec,r.gender,     l.member_3_gender);
 self.member_3_dob         := if(max_member=2 and has_right_rec,r.dob,        l.member_3_dob);
 self.member_3_adl         := if(max_member=2 and has_right_rec,r.adl,        l.member_3_adl);

 self.member_4             := if(max_member=3 and has_right_rec,r.first_name, l.member_4);
 self.member_4_middle_init := if(max_member=3 and has_right_rec,r.middle_init,l.member_4_middle_init);
 self.member_4_gender      := if(max_member=3 and has_right_rec,r.gender,     l.member_4_gender);
 self.member_4_dob         := if(max_member=3 and has_right_rec,r.dob,        l.member_4_dob);
 self.member_4_adl         := if(max_member=3 and has_right_rec,r.adl,        l.member_4_adl);

 self.member_5             := if(max_member=4 and has_right_rec,r.first_name, l.member_5);
 self.member_5_middle_init := if(max_member=4 and has_right_rec,r.middle_init,l.member_5_middle_init);
 self.member_5_gender      := if(max_member=4 and has_right_rec,r.gender,     l.member_5_gender);
 self.member_5_dob         := if(max_member=4 and has_right_rec,r.dob,        l.member_5_dob);
 self.member_5_adl         := if(max_member=4 and has_right_rec,r.adl,        l.member_5_adl);
 
 self                      := l;
 
end;

//Get Names to the left of the Hyphen
left_of_hyphen := join(first_data.Dwelling_Units,d_hyphenated_names,
                       (left.last_name =right.last_name[1..stringlib.stringfind(right.last_name,'-',1)-1] and
				        left.house_nbr =right.house_nbr  and
					    left.predir    =right.predir     and
					    left.str_suffix=right.str_suffix and
					    left.postdir   =right.postdir    and
					    left.str_name  =right.str_name   and
					    left.zip       =right.zip        and
					    left.unit_nbr  =right.unit_nbr
					   ),
					   hyphenated_names_logic(left,right),
					   left outer,keep(1)
				      );

//Get Names to the right of the Hyphen
right_of_hyphen := join(left_of_hyphen,d_hyphenated_names,
                        (left.last_name =trim(right.last_name[stringlib.stringfind(right.last_name,'-',1)+1..20],left,right) and
					     left.house_nbr =right.house_nbr  and
					     left.predir    =right.predir     and
					     left.str_suffix=right.str_suffix and
					     left.postdir   =right.postdir    and
					     left.str_name  =right.str_name   and
					     left.zip       =right.zip        and
					     left.unit_nbr  =right.unit_nbr
					    ),
					    hyphenated_names_logic(left,right),
					    left outer,keep(1)
				       );

export Hyphenated_Names := right_of_hyphen : persist('~thor_dell400_2::persist::first_data_hyphen');