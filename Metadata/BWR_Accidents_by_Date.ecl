// Accidents by Date by John J. Bulten 20070622 W20080212-105803

d1 := 15010101;
d2 := 20080212;

dDev  := FLAccidents.BaseFile_FLCrash_Did;

rDev  := record
  /*dDev.st;*/
  integer4 Year1:=(integer4)dDev.accident_date DIV 10000;
  min(group,dDev.accident_date);
  max(group,dDev.accident_date);
  count(group);
end;

output(sort(table(dDev((integer)accident_date BETWEEN d1 AND d2),rDev,
                   /*st,*/(integer4)dDev.accident_date DIV 10000,few),/*st,*/Year1),all);

output(count(FLAccidents.BaseFile_FLCrash_Did((integer)accident_date between d1 and d2)));