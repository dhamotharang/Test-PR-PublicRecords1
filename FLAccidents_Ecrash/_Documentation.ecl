// 1. Date format for source date fields: YYYY-MM-DD
// 2. Date format for source datetime fields: YYYY-MM-DD HH:MM:SS
// 3. source_start_date is not null field with current or past date populated
// 4. We receive Current view from MBS view which mean agency with future source_start_date are not included
// 5. We receive Current view from MBS view which mean agency with past source_end_date/source_termination_date are not included
// 6. No restrictions on source_termination_date anything which is sent from UI ends up in extract (Only if its a preset or furture date)
// 7. There is no senario were source_term date is populated source_end is not populated (usually its the same date)
// 8. source_end_date can be null which means active agency
// 9. Give default date for source_end_date 12/31/9999 if the value is null (orig_column, end_column) If term is populated then pop end date with same date 
// 10. Give default date for source_start_date 1/1/2000 if the value is null (orig_column)
