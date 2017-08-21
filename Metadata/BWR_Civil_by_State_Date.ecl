// Civil by State Date by John J. Bulten W20070709-124422-130901, W20070814-174552, W20070911-160144

dDev := civil_court.File_In_Case_Activity/*(state_origin='CA')*/;

output(sort(table(dDev,{event_date,state_origin,count(group)},event_date,state_origin),state_origin,event_date),all);
output(table(dDev,{event_date,source_file/*[1..2]*/,count(group)},event_date,source_file/*[1..2]*/),all);

dDev2 := civil_court.File_In_Matter/*(state_origin='CA')*/;

output(sort(table(dDev2,{filing_date,state_origin,count(group)},filing_date,state_origin),state_origin,filing_date),all);
output(table(dDev2,{filing_date,source_file/*[1..2]*/,count(group)},filing_date,source_file/*[1..2]*/),all);
output(sort(table(dDev2,{disposition_date,state_origin,count(group)},disposition_date,state_origin),state_origin,disposition_date),all);
output(table(dDev2,{disposition_date,source_file/*[1..2]*/,count(group)},disposition_date,source_file/*[1..2]*/),all);