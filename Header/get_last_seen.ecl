import ut;

//really shouldnt need to have the MAX at all but at the time there were 1m records creating the need for it
export unsigned3 get_last_seen(unsigned8 dt_first_seen,unsigned8 dt_last_seen,unsigned8 dt_vendor_first_reported,unsigned8 dt_vendor_last_reported) :=  
	max(dt_last_seen,dt_first_seen);
	   