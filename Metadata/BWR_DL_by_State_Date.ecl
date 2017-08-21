//DL by State Date by John J. Bulten 20070615
//W20070622-102252 Jason's business rules Results 1-2, 4-7 (minimal year/1960)
//W20070626-113545 Tony's business rules Results 1-3 (threshold/20)
//W20070626-123006 by State Source
//W20080317-080411 Results 1-2 (threshold/20), 6-7 (minimal year/1960); 124613 Result 3 (threshold/20)
//W20081016-165034 Results 1-7

sd1:=150101;
sd2:=200810;
d1:=15010101;
d2:=20081016;

dDev := dataset(DriversV2.Cluster + 'BASE::FLDL_DID' + DriversV2.Version_Production,DriversV2.Layout_DL,flat,unsorted);
//Per Faisal this is the current production version when the dev version is being edited.

rsDev1 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.dt_first_seen DIV 100;
  min(group,dDev.dt_first_seen);
  max(group,dDev.dt_first_seen);
  count(group);
end;

rsDev2 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.dt_vendor_first_reported DIV 100;
  min(group,dDev.dt_vendor_first_reported);
  max(group,dDev.dt_vendor_first_reported);
  count(group);
end;

rDev3 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.lic_issue_date DIV 10000;
  min(group,if(((integer4)dDev.lic_issue_date % 10000) between 101 and 1231,(integer4)dDev.lic_issue_date % 10000,1231));
  max(group,if(((integer4)dDev.lic_issue_date % 10000) between 101 and 1231,(integer4)dDev.lic_issue_date % 10000,101));
  min(group,dDev.lic_issue_date);
  max(group,dDev.lic_issue_date);
  count(group);
end;

output(sort(table(dDev((integer)dt_first_seen BETWEEN sd1 AND sd2),rsDev1,
                   orig_state,source_code,(integer4)dDev.dt_first_seen DIV 100,few),orig_state,source_code,Year1),all);
output(sort(table(dDev((integer)dt_vendor_first_reported BETWEEN sd1 AND sd2),rsDev2,
                   orig_state,source_code,(integer4)dDev.dt_vendor_first_reported DIV 100,few),orig_state,source_code,Year1),all);
output(sort(table(dDev((integer)lic_issue_date BETWEEN d1 AND d2),rDev3,
                   orig_state,source_code,(integer4)dDev.lic_issue_date DIV 10000,few),orig_state,source_code,Year1),all);

output(sort(table(dDev((integer)dt_first_seen>sd1),{orig_state,min(group,dDev.dt_first_seen),count(group)},orig_state,few),orig_state));
output(sort(table(dDev((integer)dt_vendor_first_reported>sd1),{orig_state,min(group,dDev.dt_vendor_first_reported),count(group)},orig_state,few),orig_state));
output(sort(table(dDev((integer)dt_first_seen<sd2),{orig_state,max(group,dDev.dt_first_seen),count(group)},orig_state,few),orig_state));
output(sort(table(dDev((integer)dt_vendor_first_reported<sd2),{orig_state,max(group,dDev.dt_vendor_first_reported),count(group)},orig_state,few),orig_state));