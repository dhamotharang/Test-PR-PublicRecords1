EXPORT fn_dt_last_seen_max(unsigned3	dt_vendor_last_reported, unsigned3	dt_last_seen) := MAX(GROUP,if(dt_last_seen = 0, dt_vendor_last_reported, dt_last_seen));
