//W20070820-135707 Crim by Date by jjb

output(table(crim_common.File_In_Court_Offender/*(state_origin='OK')*/,
  {vendor,case_filing_dt,count(group)},
  vendor,case_filing_dt),all);
output(table(crim_common.File_In_Court_Offenses/*(state_origin='OK')*/,
  {vendor,sent_date,count(group)},
  vendor,sent_date),all);