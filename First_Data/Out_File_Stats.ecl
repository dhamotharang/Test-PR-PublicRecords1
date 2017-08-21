

dOutFile := first_data.File_FDS;

output(count(dOutFile),named('records'));

output(count(dedup(dOutFile,last_name,house_nbr,str_name,unit_nbr,zip,all)),named('name_address_combinations'));

output(count(dOutFile(phone!='')),named('phones'));

hhid_true    := doutfile(hhid[1]='1');
hhid_derived := doutfile(hhid[1]='2');

hhid_true_unique    := dedup(hhid_true,hhid,all);
hhid_derived_unique := dedup(hhid_derived,hhid,all);

output(count(hhid_true),named('true_hhids'));
output(count(hhid_true_unique),named('true_hhids_unique'));
output(count(hhid_derived),named('derived_hhids'));
output(count(hhid_derived_unique),named('derived_hhids_unique'));

adl_norm_rec := record
 string12 adl;
end;

adl_norm_rec t_norm_adl(dOutFile l, integer c) := transform
 self.adl := choose(c,l.adl,l.member_1_adl,l.member_2_adl,l.member_3_adl,l.member_4_adl,l.member_5_adl);
end;

n_norm_adl      := normalize(dOutFile,6,t_norm_adl(left,counter))(adl<>'');
n_norm_adl_dupd := dedup(n_norm_adl,all);
output(count(n_norm_adl),     named('adls'));
output(count(n_norm_adl_dupd),named('unique_adls'));

norm_rec := record
 string40 name;
end;

norm_rec tNorm(dOutFile l, integer c) := transform
 self.name  := choose(c,if(l.first_name<>'',stringlib.stringcleanspaces(l.first_name+l.last_name),''),
                        if(l.member_1<>'',stringlib.stringcleanspaces(l.member_1+l.last_name),''),
						if(l.member_2<>'',stringlib.stringcleanspaces(l.member_2+l.last_name),''),
						if(l.member_3<>'',stringlib.stringcleanspaces(l.member_3+l.last_name),''),
						if(l.member_4<>'',stringlib.stringcleanspaces(l.member_4+l.last_name),''),
						if(l.member_5<>'',stringlib.stringcleanspaces(l.member_5+l.last_name),'')
						);
end;

dNorm := normalize(dOutFile,6,tNorm(left,counter))(name<>'');
output(count(dNorm),named('individuals_incl_those_that_didnt_adl'));

r_income := record
 dOutFile.income_code;
 count_ := count(group);
end;

r_age := record
 dOutFile.age_cd;
 count_ := count(group);
end;

r_gender := record
 dOutFile.gender;
 count_ := count(group);
end;

r_title := record
 dOutFile.title_cd;
 count_ := count(group);
end;

r_lor := record
 dOutFile.lor;
 count_ := count(group);
end;

r_dwelling_unit_size := record
 dOutFile.dwelling_unit_size;
 count_ := count(group);
end;

r_rent_own_score := record
 dOutFile.rent_own_score_;
 count_ := count(group);
end;

stats_income   := sort(table(dOutFile,r_income,income_code,                     few),income_code);
stats_age      := sort(table(dOutFile,r_age,   age_cd,                          few),age_cd);
stats_gender   := sort(table(dOutFile,r_gender,gender,                          few),gender);
stats_title    := sort(table(dOutFile,r_title, title_cd,                        few),title_cd);
stats_lor      := sort(table(dOutFile,r_lor, lor,                               few),lor);
stats_dwelling := sort(table(dOutFile,r_dwelling_unit_size, dwelling_unit_size, few),dwelling_unit_size);
stats_rent_own := sort(table(dOutFile,r_rent_own_score, rent_own_score_,        few),rent_own_score_);

output(stats_age,      named('age_stats'),all);
output(stats_income,   named('income_stats'),all);
output(stats_gender,   named('gender_stats_primary_only'),all);
output(stats_title,    named('title_stats'),all);
output(stats_lor,      named('lor_stats'),all);
output(stats_dwelling, named('dwelling_units_stats'),all);
output(stats_rent_own, named('rent_own_stats'),all);