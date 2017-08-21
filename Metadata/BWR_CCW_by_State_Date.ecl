// CCW by State Date W20080124-122301

output(table(eMerges.file_ccw_base(source_state='VA'),{process_date,count(group)},process_date),all);
output(table(eMerges.file_ccw_base(source_state='VA'),{date_first_seen,count(group)},date_first_seen),all);
output(table(eMerges.file_ccw_base(source_state='VA'),{date_last_seen,count(group)},date_last_seen),all);
output(table(eMerges.file_ccw_base(source_state='VA'),{file_acquired_date,count(group)},file_acquired_date),all);
output(table(eMerges.file_ccw_base(source_state='VA'),{dob,count(group)},dob),all);