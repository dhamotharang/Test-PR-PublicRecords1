import utilfile, header, STD;

export Fun_Get_UtilDaily_By_SSN(dataset(layout_bestInfo_batchin) in_f,
                                unsigned1 score_threshold_value) := function
	
util_fdids := utilfile.UtilDid_From_SSN_Batch(in_f,true,score_threshold_value);

unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);
unsigned3 todaydate := (unsigned3)(STD.Date.Today () div 100);
unsigned3 lesser(unsigned3 dt2) := if (add4(dt2) < todaydate, add4(dt2),todaydate);

header.layout_header get_util_by_fdid(util_fdids l, utilfile.Key_Util_Daily_FDID r) := transform 
	self.rid := (unsigned6)l.acctno;
	self.did := (unsigned6)r.did;
	self.rec_type := '1';
	self.src := 'DU';
	self.vendor_id := r.id;
	self.suffix := r.addr_suffix;
	self.city_name := r.v_city_name;
	self.dt_first_seen :=  (integer)r.date_first_seen div 100;
	self.dt_last_seen := if((integer)r.date_first_seen div 100=0,0,
	                        lesser((integer)r.date_first_seen div 100));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := self.dt_last_seen;
     self.dt_nonglb_last_seen := self.dt_last_seen;
	self.county := r.county[3..5];
	self.tnt := 'Y';
	self.dob := (unsigned)r.dob;
	SELF := r;
	self := [];
end;
		  
util_recs := join(util_fdids, utilfile.Key_Util_Daily_FDID, 
                  keyed(left.did = right.fdid),
	  		   get_util_by_fdid(left, right), LIMIT(500,SKIP));
				  
return util_recs;				  
	
end;