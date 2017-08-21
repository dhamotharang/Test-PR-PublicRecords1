
ds1 := faa.file_aircraft_registration_out;
ds2 := faa.file_airmen_data_out;
ds3 := faa.file_airmen_certificate_out;

r1 := record
 string30 file;
 string15 field;
 string6  date_yyyymm;
end;

r1 t1(ds1 le) := transform
 self.file        := 'AIRCRAFT_REGISTRATION';
 self.field       := 'CERT_ISSUE_DT';
 self.date_yyyymm := le.cert_issue_date[1..6];
end;

r1 t2(ds1 le) := transform
 self.file        := 'AIRCRAFT_REGISTRATION';
 self.field       := 'LAST_ACTION_DT';
 self.date_yyyymm := le.last_action_date[1..6];
end;

r1 t3(ds2 le) := transform
 self.file        := 'AIRMEN_DATA';
 self.field       := 'MED_DT';
 self.date_yyyymm := le.med_date[3..6]+le.med_date[1..2];
end;

r1 t4(ds2 le) := transform
 self.file        := 'AIRMEN_DATA';
 self.field       := 'MED_EXP_DT';
 self.date_yyyymm := le.med_exp_date[3..6]+le.med_exp_date[1..2];
end;

r1 t5(ds3 le) := transform
 self.file        := 'AIRMEN_CERTIFICATE';
 self.field       := 'CER_EXP_DT';
 self.date_yyyymm := le.cer_exp_date[5..8]+le.cer_exp_date[1..4];
end;

p1 := project(ds1,t1(left));
p2 := project(ds1,t2(left));
p3 := project(ds2,t3(left));
p4 := project(ds2,t4(left));
p5 := project(ds3,t5(left));

concat := (p1+p2+p3+p4+p5)(date_yyyymm<>'');

r2 := record
 concat.file;
 concat.field;
 concat.date_yyyymm;
 count_ := count(group);
end;

ta1 := sort(table(concat,r2,file,field,date_yyyymm)(count_>25),file,field,date_yyyymm);

export coverage := output(ta1,all,named('coverage'));