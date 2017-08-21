//the dataset below is built in metadata.experian_vehicles_latency
r1 := RECORD
  string8  append_process_date;
  string2  append_state_origin;
  string22 vin;
  string8  reg_renew_dt;
  string8  title_trans_dt;
 END;

ds := dataset('~thor400_84::persist::experian_dupd',r1,flat)(reg_renew_dt<>'');

r2 := record
 ds.append_state_origin;
 ds.vin;
 string6 reg_ym;
end;

r2 t1(ds le) := transform
 self.reg_ym := le.reg_renew_dt[1..6];
 self := le;
end;

p1      := project   (ds,t1(left));
p1_dist := distribute(p1,hash(append_state_origin,vin,reg_ym));
p1_sort := sort      (p1_dist,append_state_origin,vin,reg_ym,local);
p1_dupd := dedup     (p1_sort,append_state_origin,vin,reg_ym,local);

p1_filt := p1(reg_ym[1..4] in ['2005','2006','2007','2008']);

r3 := record
 p1_filt.append_state_origin;
 p1_filt.reg_ym;
 count_ := count(group);
end;

ta1 := table(p1_filt,r3,append_state_origin,reg_ym,few);

f1 := sort(ta1(reg_ym[1..4]='2008'),append_state_origin,-reg_ym);
f2 := sort(ta1(reg_ym[1..4]='2007'),append_state_origin,-reg_ym);
f3 := sort(ta1(reg_ym[1..4]='2006'),append_state_origin,-reg_ym);
f4 := sort(ta1(reg_ym[1..4]='2005'),append_state_origin,-reg_ym);

f1_out := output(f1,all,named('two008'));
f2_out := output(f2,all,named('two007'));
f3_out := output(f3,all,named('two006'));
f4_out := output(f4,all,named('two005'));

export experian_vehicles_comparing_years := parallel(f1_out,f2_out,f3_out,f4_out);