//Last known applicable WUID is W20060814-094257
overlapping_states := ['FL','ID','KY','MN','MO','MS','MT','ND','NE','NM','NV','OH','TX','WI','WY'];
//Left out MN, MO, and MS due to potential data issues w/ registration_effective_date
//Lett out ID, ND, NM because they doesn't have registration (or title) dates
//Left out KY because only first_registration_date is populated (registration_effective_date is all blanks) - similar issue to MN, MO, and MS
//Left out MT because registration_effective_date is all blank - can use title_issue_date (in another graph)
//overlapping_states := ['FL','NE','NV','OH','TX','WI','WY'];

//direct1 := vehlic.File_Vehicles;
//direct1 := vehlic.File_Experian_Updating_Full;
d0         :=         dataset('~thor_data400::in::vehreg_experian_updating',vehlic.Layout_Experian_Updating_Full,flat);
d1         :=         dataset('~thor_data400::in::vehreg_experian_updating_01',vehlic.Layout_Experian_Updating_Full,flat);
d2         :=         dataset('~thor_data400::in::vehreg_experian_updating_02',vehlic.Layout_Experian_Updating_Full,flat);
d3         :=         dataset('~thor_data400::in::vehreg_experian_updating_03',vehlic.Layout_Experian_Updating_Full,flat);
d4         :=         dataset('~thor_data400::in::vehreg_experian_updating_04',vehlic.Layout_Experian_Updating_Full,flat);
d5         :=         dataset('~thor_data400::in::vehreg_experian_updating_05',vehlic.Layout_Experian_Updating_Full,flat);
d6         :=         dataset('~thor_data400::in::vehreg_experian_updating_06',vehlic.Layout_Experian_Updating_Full,flat);
d7         :=         dataset('~thor_data400::in::vehreg_experian_updating_07',vehlic.Layout_Experian_Updating_Full,flat);
d8         :=         dataset('~thor_data400::in::vehreg_experian_updating_08',vehlic.Layout_Experian_Updating_Full,flat);
 
direct1 := d1+d2+d3+d4+d5+d6+d7+d8+d0;

validvin(string17 vin) := length(trim(vin, all)) = 17 and vin[1..10] <> '0000000000';
						   
min_date :='19500101';
max_date :='20060808';

slimrec := record
 direct1.append_state_origin;
 direct1.VIN;
 //direct1.REGISTRATION_EFFECTIVE_DATE;
 string8  date;
 string10 date_type;
 //direct1.vp_series;
 string1 vp_series;
end;

slimrec t_slim_checkdate(vehlic.Layout_Experian_Updating_Full l) := transform

 string8 v_date := if(l.append_state_origin in ['KY','MN','MO','MS'],l.ORG_REG_DT,
                   if(l.append_state_origin in ['ID','ND','NM'],l.REG_EXP_DT,
                   if(l.append_state_origin in ['FL','NE','NV','OH','TX','WI','WY'],l.REG_RENEW_DT,
				   if(l.append_state_origin in ['MT'],l.TITLE_TRANS_DT,
				   ''))));

 self.date := if(v_date between min_date and max_date,v_date,'');
 self.date_type := if(l.append_state_origin in ['KY','MN','MO','MS'],'FIR_REG_DT',
                   if(l.append_state_origin in ['ID','ND','NM'],'REG_EXP_DT',
                   if(l.append_state_origin in ['FL','NE','NV','OH','TX','WI','WY'],'REG_EFF_DT',
				   if(l.append_state_origin in ['MT'],'TIT_ISS_DT',
				   ''))));
 self := l;
 self.vp_series := 'x';
end;

direct2 := dedup(project(direct1,t_slim_checkdate(left)),all);
count(direct2);
direct3 := direct2(validvin(VIN),vp_series<>'',date<>'');
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
direct4_dist := distribute(direct4,hash(VIN));
direct4_sort := sort(direct4_dist,VIN,date,local);

rollup_rec t_rollup_on_vin(rollup_rec l, rollup_rec r) := transform
 self.count_          := l.count_+1;
 self.min_date_yyyymm := if(l.date<r.date,l.date,r.date);
 self.max_date_yyyymm := if(l.date>r.date,l.date,r.date);
 self := l;
end;

direct5 := rollup(direct4_sort,trim(left.VIN)=trim(right.VIN),t_rollup_on_vin(left,right));
//output(choosen(p2,1000));

vins_with_more_than_1_reg_date := direct5(count_>1);
//count(vins_with_more_than_1_reg_date);
output(enth(vins_with_more_than_1_reg_date,1,10000,1));

min_date_rec := record
 vins_with_more_than_1_reg_date.append_state_origin;
 vins_with_more_than_1_reg_date.date_type;
 vins_with_more_than_1_reg_date.min_date_yyyymm;
 count_ := count(group);
end;

max_date_rec := record
 vins_with_more_than_1_reg_date.append_state_origin;
 vins_with_more_than_1_reg_date.date_type;
 vins_with_more_than_1_reg_date.max_date_yyyymm;
 count_ := count(group);
end;

min_date_stats := sort(table(vins_with_more_than_1_reg_date,min_date_rec,append_state_origin,date_type,min_date_yyyymm),append_state_origin,min_date_yyyymm)(count_>=100);
max_date_stats := sort(table(vins_with_more_than_1_reg_date,max_date_rec,append_state_origin,date_type,max_date_yyyymm),append_state_origin,-max_date_yyyymm)(count_>=100);

output(min_date_stats(append_state_origin='FL'),NAMED('FL_Min_Dates'),all);
output(max_date_stats(append_state_origin='FL'),NAMED('FL_Max_Dates'),all);

output(min_date_stats(append_state_origin='ID'),NAMED('ID_Min_Dates'),all);
output(max_date_stats(append_state_origin='ID'),NAMED('ID_Max_Dates'),all);

output(min_date_stats(append_state_origin='KY'),NAMED('KY_Min_Dates'),all);
output(max_date_stats(append_state_origin='KY'),NAMED('KY_Max_Dates'),all);

output(min_date_stats(append_state_origin='MN'),NAMED('MN_Min_Dates'),all);
output(max_date_stats(append_state_origin='MN'),NAMED('MN_Max_Dates'),all);

output(min_date_stats(append_state_origin='MO'),NAMED('MO_Min_Dates'),all);
output(max_date_stats(append_state_origin='MO'),NAMED('MO_Max_Dates'),all);

output(min_date_stats(append_state_origin='MS'),NAMED('MS_Min_Dates'),all);
output(max_date_stats(append_state_origin='MS'),NAMED('MS_Max_Dates'),all);

output(min_date_stats(append_state_origin='MT'),NAMED('MT_Min_Dates'),all);
output(max_date_stats(append_state_origin='MT'),NAMED('MT_Max_Dates'),all);

output(min_date_stats(append_state_origin='ND'),NAMED('ND_Min_Dates'),all);
output(max_date_stats(append_state_origin='ND'),NAMED('ND_Max_Dates'),all);

output(min_date_stats(append_state_origin='NE'),NAMED('NE_Min_Dates'),all);
output(max_date_stats(append_state_origin='NE'),NAMED('NE_Max_Dates'),all);

output(min_date_stats(append_state_origin='NM'),NAMED('NM_Min_Dates'),all);
output(max_date_stats(append_state_origin='NM'),NAMED('NM_Max_Dates'),all);

output(min_date_stats(append_state_origin='NV'),NAMED('NV_Min_Dates'),all);
output(max_date_stats(append_state_origin='NV'),NAMED('NV_Max_Dates'),all);

output(min_date_stats(append_state_origin='OH'),NAMED('OH_Min_Dates'),all);
output(max_date_stats(append_state_origin='OH'),NAMED('OH_Max_Dates'),all);

output(min_date_stats(append_state_origin='TX'),NAMED('TX_Min_Dates'),all);
output(max_date_stats(append_state_origin='TX'),NAMED('TX_Max_Dates'),all);

output(min_date_stats(append_state_origin='WI'),NAMED('WI_Min_Dates'),all);
output(max_date_stats(append_state_origin='WI'),NAMED('WI_Max_Dates'),all);

output(min_date_stats(append_state_origin='WY'),NAMED('WY_Min_Dates'),all);
output(max_date_stats(append_state_origin='WY'),NAMED('WY_Max_Dates'),all);