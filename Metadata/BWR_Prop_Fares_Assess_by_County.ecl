//W20080118-134153 20080220-162428 20080904-121128 Prop Fares Assess by County
t4 := table(LN_PropertyV2.File_Assessment(vendor_source_flag in ['D','O']),{fips_code,recording_date,sale_date});
output(table(t4,{fips_code,min(group,recording_date),max(group,recording_date),count(group)},fips_code),all);
output(table(t4,{fips_code,min(group,sale_date),max(group,sale_date),count(group)},fips_code),all);
