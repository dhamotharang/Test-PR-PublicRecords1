//Vitals by County Date W20071227-153549

today:='20071227';

output(table(marriage_divorce_v2.file_mar_div_base,
  {state_origin,source_file,/*marriage_county,divorce_county,*/filing_type,
   min(group,if(marriage_dt='',today,marriage_dt)),max(group,marriage_dt),
   min(group,if(divorce_dt='',today,divorce_dt)),max(group,divorce_dt),count(group)},
   state_origin,source_file,/*marriage_county,divorce_county,*/filing_type),all);