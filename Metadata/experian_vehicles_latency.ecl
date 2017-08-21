import vehiclev2,ut,header;

ds00 := vehiclev2.file_experian_in;

r0 := record
 string8  append_process_date;
 string2  append_state_origin;
 string22 vin;
 string8  reg_renew_dt;
 string8  title_trans_dt;
end;

r0 t0(ds00 le) := transform
 self := le;
end;

ds0     := project(ds00,t0(left));
ds_dist := distribute(ds0,hash(append_STATE_ORIGIN,VIN,REG_RENEW_DT,TITLE_TRANS_DT));
//earliest process_date for the entire record appears first
ds_sort := sort (ds_dist,append_STATE_ORIGIN,VIN,REG_RENEW_DT,TITLE_TRANS_DT,append_process_date,local);
ds      := dedup(ds_sort,append_STATE_ORIGIN,VIN,REG_RENEW_DT,TITLE_TRANS_DT,local) : persist('persist::experian_dupd');

fl_recs := distribute(ds(append_state_origin='FL'),hash(vin,append_process_date,reg_renew_dt)) : persist('persist::experian_fl_samples');

r0 t1(ds le) := transform
 self.reg_renew_dt   := le.reg_renew_dt;
 self.title_trans_dt := le.title_trans_dt;
 self                := le;
end;

p0 := project(ds,t1(left));

r_norm := record
 p0.append_state_origin;
 p0.append_process_date;
 p0.vin;
 string6 date_ym;
 string3 date_type;
 string8 orig_date;
end;

r_norm t_norm(p0 le, integer c) := transform
 self.date_ym   := choose(c,le.reg_renew_dt[1..6],le.title_trans_dt[1..6]);
 self.date_type := choose(c,'REG','TTL');
 self.orig_date := choose(c,le.reg_renew_dt,le.title_trans_dt);
 self           := le;
end;

p1_0 := normalize(p0,2,t_norm(left,counter))(date_ym<>'');

r4 := record
 p1_0.append_state_origin;
 p1_0.date_ym;
 p1_0.date_type;
 count_ := count(group);
end;

ta0      := table(p1_0,r4,append_state_origin,date_ym,date_type,few);
ta0_filt := ta0(count_>25);

r_norm t4(p1_0 le, ta0_filt ri) := transform
 self := le;
end;

p1 := join(p1_0,ta0_filt,left.append_state_origin=right.append_state_origin and left.date_ym=right.date_ym and left.date_type=right.date_type,t4(left,right),lookup);

r2 := record
 p1;
 integer diff_;
 string20 bucket;
 integer sort_order;
end;

r2 t2(p1 le) := transform

 integer v_pd := (integer)(string)le.append_process_date[1..6];
 integer v_rn := (integer)(string)le.date_ym;
 
 integer v_pd_nbr_of_months    := header.ConvertYYYYMMToNumberOfMonths(v_pd);
 integer v_trans_nbr_of_months := header.ConvertYYYYMMToNumberOfMonths(v_rn);
 
 integer v_diff := v_pd_nbr_of_months-v_trans_nbr_of_months;
 string  v_diff2 := (string)v_diff;
 
 self.diff_  := v_diff;
 self.bucket := if(v_diff=0, v_diff2,
                if(v_diff=1, v_diff2+' MOS',
				if(v_diff=2, v_diff2+' MOS',
				if(v_diff=3, v_diff2+' MOS',
				if(v_diff=4, v_diff2+' MOS',
				if(v_diff=5, v_diff2+' MOS',
				if(v_diff=6, v_diff2+' MOS',
				if(v_diff=7, v_diff2+' MOS',
				if(v_diff=8, v_diff2+' MOS',
				if(v_diff=9, v_diff2+' MOS',
				if(v_diff=10,v_diff2+' MOS',
				if(v_diff=11,v_diff2+' MOS',
				if(v_diff=12,v_diff2+' MOS',
				if(v_diff between 13 and 24,'1 - 2 YRS',
				if(v_diff between 25 and 60,'2 - 5 YRS',
				if(v_diff>61,'OVER 5 YRS',
				'-'))))))))))))))));

 self.sort_order := if(v_diff=0, 1,
                    if(v_diff=1, 2,
				    if(v_diff=2, 3,
				    if(v_diff=3, 4,
				    if(v_diff=4, 5,
				    if(v_diff=5, 6,
				    if(v_diff=6, 7,
				    if(v_diff=7, 8,
				    if(v_diff=8, 9,
				    if(v_diff=9, 10,
				    if(v_diff=10,11,
				    if(v_diff=11,12,
				    if(v_diff=12,13,
				    if(v_diff between 13 and 24,14,
				    if(v_diff between 25 and 60,15,
				    if(v_diff>61,16,
				    17))))))))))))))));
							
 self                     := le;
end;

p2 := project(p1,t2(left));

r3 := record
 p2.append_state_origin;
 p2.date_type;

 p2.bucket;
 p2.sort_order;
 count_ := count(group);
end;

ta1 := sort(table(p2(append_process_date>'20080301' and diff_>0 and sort_order between 1 and 16),r3,append_state_origin,date_type,bucket,sort_order,few),append_state_origin,date_type,sort_order);

f_fl_gaps := distribute(p2(append_process_date>'20080101' and append_state_origin='FL' and date_type='REG' and diff_=9),hash(vin,append_process_date,orig_date)) : persist('persist::experian_fl_gaps');

recordof(p2) t3(fl_recs le, f_fl_gaps ri) := transform 
 self := ri;
end;

j1 := dedup(join(fl_recs,f_fl_gaps,left.vin=right.vin and left.append_process_date=right.append_process_date and left.reg_renew_dt=right.orig_date,t3(left,right),local),record,all);

export experian_vehicles_latency := sequential(
                                     output(ta1,all,named('experian_vehicles_latency')),
									 output(j1,named('fl_samples'))
									 );