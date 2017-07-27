import ut;

//really shouldnt need to have the MIN at all but at the time there were 1m records creating the need for it
export unsigned3 get_first_seen(unsigned8 dt_first_seen,unsigned8 dt_last_seen,unsigned8 dt_vendor_first_reported,unsigned8 dt_vendor_last_reported) := 
	ut.min2(dt_first_seen,dt_last_seen);