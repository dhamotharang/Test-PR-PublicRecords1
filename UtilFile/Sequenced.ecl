import ut, header, business_header, std;
util := util_as_source;

// add 4 months to a yyyymm date, correctly adjusting year
unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);

unsigned3 todaydate := (unsigned3)((integer)Std.Date.Today() div 100);

// will be used to adjust date last seens -- if d_first_seen+4 < today, use dfs+4, else today
// not defining a condition to handle an incoming value of 0 would return a value of 4
unsigned3 lesser(unsigned3 dt2) := if(dt2=0,
                                    0,
                                   if (add4(dt2) < todaydate, 
								    add4(dt2),
								   todaydate));

header.Layout_New_Records into(util L) := transform

    boolean future_dt := l.date_first_seen>(STRING8)Std.Date.Today();
	
	self.did := 0;
	self.rid := 0;
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.rec_type := '1';
	self.vendor_id := L.id;
	self.dob := 0;
	self.ssn := if(l.ssn in ut.set_badssn,'',l.ssn);
	self.phone := if(l.src='UW', l.work_phone, l.phone);
	self.suffix := L.addr_suffix;
	self.city_name := L.v_city_name;
	self.dt_first_seen := if(future_dt,0,(integer)l.date_first_seen div 100);
    self.dt_last_seen := lesser(self.dt_first_seen);
    self.dt_vendor_last_reported := self.dt_first_seen;
    self.dt_vendor_first_reported := self.dt_first_seen;
    self.dt_nonglb_last_seen := lesser(self.dt_first_seen);
	self.county := L.county[3..5];
    self.tnt := 'Y';
	self.cbsa := if(l.msa='','',l.msa+'0');
	self.RawAID := l.Append_RawAID;
	self := L;
end;

util_seq := project(util,into(left));

export Sequenced := util_seq;