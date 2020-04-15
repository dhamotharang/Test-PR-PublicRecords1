import $.REPORT_shifts_over_time as r; 


output(r.count_per_dt_first_seen, named('count_per_dt_first_seen'));

output(r.count_per_dt_seen_last, named('count_per_dt_seen_last'));

output(r.count_per_dt_vendor_first, named('count_per_dt_vendor_first'));

output(r.count_per_dt_vendor_last, named('count_per_dt_vendor_last'));

output(r.all_seen_counts, named('all_seen_counts'));

output(r.all_vendor_reported_counts, named('all_vendor_reported_counts'));
