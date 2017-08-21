// FAA by Date 1a-1d 2a-2d by John J. Bulten 20070622 W20070626-120409, W20070627-103937 use st
// FAA by County 1e-1f W20070823-111407

d1 := 15010101;
d2 := 20070822;
md1 := 101;
md2 := 991231;

dDev1 := faa.file_aircraft_registration_out;
dDev2 := faa.file_airmen_data_out;

rDev1a := record
  dDev1.state;
  integer4 Year1:=(integer4)dDev1.date_first_seen DIV 10000;
  min(group,dDev1.date_first_seen);
  max(group,dDev1.date_first_seen);
  count(group);
end;

rDev1b := record
  dDev1.state;
  integer4 Year1:=(integer4)dDev1.last_action_date DIV 10000;
  min(group,dDev1.last_action_date);
  max(group,dDev1.last_action_date);
  count(group);
end;

rDev1c := record
  dDev1.st;
  integer4 Year1:=(integer4)dDev1.date_first_seen DIV 10000;
  min(group,dDev1.date_first_seen);
  max(group,dDev1.date_first_seen);
  count(group);
end;

rDev1d := record
  dDev1.st;
  integer4 Year1:=(integer4)dDev1.last_action_date DIV 10000;
  min(group,dDev1.last_action_date);
  max(group,dDev1.last_action_date);
  count(group);
end;

rDev1e := record
  dDev1.state;
  dDev1.orig_county;
  min(group,dDev1.last_action_date);
  max(group,dDev1.last_action_date);
  count(group);
end;

rDev1f := record
  dDev1.st;
  dDev1.county;
  min(group,dDev1.last_action_date);
  max(group,dDev1.last_action_date);
  count(group);
end;

rDev2a := record
  dDev2.state;
  integer4 Year1:=(integer4)dDev2.date_first_seen DIV 10000;
  min(group,dDev2.date_first_seen);
  max(group,dDev2.date_first_seen);
  count(group);
end;

rDev2b := record
  dDev2.state;
  integer4 Year1:=(integer4)dDev2.med_date % 100;
  min(group,dDev2.med_date);
  max(group,dDev2.med_date);
  count(group);
end;

rDev2c := record
  dDev2.st;
  integer4 Year1:=(integer4)dDev2.date_first_seen DIV 10000;
  min(group,dDev2.date_first_seen);
  max(group,dDev2.date_first_seen);
  count(group);
end;

rDev2d := record
  dDev2.st;
  integer4 Year1:=(integer4)dDev2.med_date % 100;
  min(group,dDev2.med_date);
  max(group,dDev2.med_date);
  count(group);
end;

output(sort(table(dDev1((integer)date_first_seen BETWEEN d1 AND d2),rDev1a,
                   state,(integer4)dDev1.date_first_seen DIV 10000,few),state,Year1),all);
output(sort(table(dDev1((integer)last_action_date BETWEEN d1 AND d2),rDev1b,
                   state,(integer4)dDev1.last_action_date DIV 10000,few),state,Year1),all);
output(sort(table(dDev1((integer)date_first_seen BETWEEN d1 AND d2),rDev1c,
                   st,(integer4)dDev1.date_first_seen DIV 10000,few),st,Year1),all);
output(sort(table(dDev1((integer)last_action_date BETWEEN d1 AND d2),rDev1d,
                   st,(integer4)dDev1.last_action_date DIV 10000,few),st,Year1),all);
output(sort(table(dDev1((integer)last_action_date BETWEEN d1 AND d2),rDev1e,
                   state,orig_county,few),state,orig_county),all);
output(sort(table(dDev1((integer)last_action_date BETWEEN d1 AND d2),rDev1f,
                   st,county,few),st,county),all);
output(sort(table(dDev2((integer)date_first_seen BETWEEN d1 AND d2),rDev2a,
                   state,(integer4)dDev2.date_first_seen DIV 10000,few),state,Year1),all);
output(sort(table(dDev2((integer)med_date BETWEEN md1 AND md2),rDev2b,
                   state,(integer4)dDev2.med_date % 100,few),state,Year1),all);
output(sort(table(dDev2((integer)date_first_seen BETWEEN d1 AND d2),rDev2c,
                   st,(integer4)dDev2.date_first_seen DIV 10000,few),st,Year1),all);
output(sort(table(dDev2((integer)med_date BETWEEN md1 aND md2),rDev2d,
                   st,(integer4)dDev2.med_date % 100,few),st,Year1),all);

output(count(faa.file_aircraft_registration_out((integer)date_first_seen between d1 and d2)));
output(count(faa.file_aircraft_registration_out((integer)last_action_date between d1 and d2)));
output(count(faa.file_airmen_data_out((integer)date_first_seen between d1 and d2)));