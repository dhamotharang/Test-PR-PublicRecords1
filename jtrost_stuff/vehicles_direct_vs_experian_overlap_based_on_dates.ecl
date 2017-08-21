overlapping_states := ['FL','ID','KY','MN','MO','MS','MT','ND','NE','NM','NV','OH','TX','WI','WY'];
//Left out MN, MO, and MS due to potential data issues w/ registration_effective_date
//Lett out ID, ND, NM because they doesn't have registration (or title) dates
//Left out KY because only first_registration_date is populated (registration_effective_date is all blanks) - similar issue to MN, MO, and MS
//Left out MT because registration_effective_date is all blank - can use title_issue_date (in another graph)
//overlapping_states := ['FL','NE','NV','OH','TX','WI','WY'];

//direct1   := dataset('~thor_data400::persist::vehreg_vehicles_joined',vehlic.Layout_Vehicles,flat)(orig_state in overlapping_states);
direct1 := vehlic.File_Vehicles;

validvin(string17 vin) := length(trim(vin, all)) = 17 and vin[1..10] <> '0000000000';
						   
min_date :='19500101';
max_date :='20060808';

slimrec := record
 direct1.orig_state;
 direct1.ORIG_VIN;
 //direct1.REGISTRATION_EFFECTIVE_DATE;
 string8  date;
 string10 date_type;
 direct1.vp_series;
end;

slimrec t_slim_checkdate(vehlic.Layout_Vehicles l) := transform

 string8 v_date := if(l.orig_state in ['KY','MN','MO','MS'],l.FIRST_REGISTRATION_DATE,
                   if(l.orig_state in ['ID','ND','NM'],l.REGISTRATION_EXPIRATION_DATE,
                   if(l.orig_state in ['FL','NE','NV','OH','TX','WI','WY'],l.REGISTRATION_EFFECTIVE_DATE,
				   if(l.orig_state in ['MT'],l.TITLE_ISSUE_DATE,
				   ''))));
 //self.REGISTRATION_EFFECTIVE_DATE := if(l.REGISTRATION_EFFECTIVE_DATE < min_date
 //                                    or l.REGISTRATION_EFFECTIVE_DATE > max_date,
 //									 '',l.REGISTRATION_EFFECTIVE_DATE);
 self.date := if(v_date between min_date and max_date,v_date,'');
 self.date_type := if(l.orig_state in ['KY','MN','MO','MS'],'FIR_REG_DT',
                   if(l.orig_state in ['ID','ND','NM'],'REG_EXP_DT',
                   if(l.orig_state in ['FL','NE','NV','OH','TX','WI','WY'],'REG_EFF_DT',
				   if(l.orig_state in ['MT'],'TIT_ISS_DT',
				   ''))));
 self := l;
end;

direct2 := project(direct1,t_slim_checkdate(left));
count(direct2);
direct3 := direct2(validvin(ORIG_VIN),vp_series<>'',date<>'');
count(direct3);

rollup_rec := record
 slimrec;
 string6  min_date_yyyymm;
 string6  max_date_yyyymm;
 integer2 count_;
end;

rollup_rec t_setdefaults(slimrec l) := transform
 self                 := l;
 self.min_date_yyyymm := '';
 self.max_date_yyyymm := '';
 self.count_          := 1;
end;

direct4      := project(direct3,t_setdefaults(left));
direct4_dist := distribute(direct4,hash(ORIG_VIN));
direct4_sort := sort(direct4_dist,ORIG_VIN,date,local);

rollup_rec t_rollup_on_vin(rollup_rec l, rollup_rec r) := transform
 self.count_          := l.count_+1;
 self.min_date_yyyymm := if(l.date<r.date,l.date,r.date);
 self.max_date_yyyymm := if(l.date>r.date,l.date,r.date);
 self := l;
end;

direct5 := rollup(direct4_sort,trim(left.ORIG_VIN)=trim(right.ORIG_VIN),t_rollup_on_vin(left,right));
//output(choosen(p2,1000));

vins_with_more_than_1_reg_date := direct5(count_>1);
//count(vins_with_more_than_1_reg_date);
output(enth(vins_with_more_than_1_reg_date,1,10000,1));

min_date_rec := record
 vins_with_more_than_1_reg_date.orig_state;
 vins_with_more_than_1_reg_date.date_type;
 vins_with_more_than_1_reg_date.min_date_yyyymm;
 count_ := count(group);
end;

max_date_rec := record
 vins_with_more_than_1_reg_date.orig_state;
 vins_with_more_than_1_reg_date.date_type;
 vins_with_more_than_1_reg_date.max_date_yyyymm;
 count_ := count(group);
end;

min_date_stats := sort(table(vins_with_more_than_1_reg_date,min_date_rec,orig_state,date_type,min_date_yyyymm),orig_state,min_date_yyyymm)(count_>=100);
max_date_stats := sort(table(vins_with_more_than_1_reg_date,max_date_rec,orig_state,date_type,max_date_yyyymm),orig_state,-max_date_yyyymm)(count_>=100);

output(min_date_stats(orig_state='FL'),NAMED('FL_Min_Dates'),all);
output(max_date_stats(orig_state='FL'),NAMED('FL_Max_Dates'),all);

output(min_date_stats(orig_state='NE'),NAMED('NE_Min_Dates'),all);
output(max_date_stats(orig_state='NE'),NAMED('NE_Max_Dates'),all);

output(min_date_stats(orig_state='NV'),NAMED('NV_Min_Dates'),all);
output(max_date_stats(orig_state='NV'),NAMED('NV_Max_Dates'),all);

output(min_date_stats(orig_state='OH'),NAMED('OH_Min_Dates'),all);
output(max_date_stats(orig_state='OH'),NAMED('OH_Max_Dates'),all);

output(min_date_stats(orig_state='TX'),NAMED('TX_Min_Dates'),all);
output(max_date_stats(orig_state='TX'),NAMED('TX_Max_Dates'),all);

output(min_date_stats(orig_state='WI'),NAMED('WI_Min_Dates'),all);
output(max_date_stats(orig_state='WI'),NAMED('WI_Max_Dates'),all);

output(min_date_stats(orig_state='WY'),NAMED('WY_Min_Dates'),all);
output(max_date_stats(orig_state='WY'),NAMED('WY_Max_Dates'),all);