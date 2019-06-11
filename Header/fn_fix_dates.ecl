import ut;

/*
get them in the proper format
apply filter to really old or future values
set to the other date if original value was set to 0
set to 0 if the date precedes the min DOB -> header.fn_compare_dates_to_dob
*/

export fn_fix_dates(dataset(recordof(header.layout_header)) in_hdr, boolean pFastHeader=false,string versionBuild) := function

today_in_ym := (unsigned3)if(pFastHeader,Header.Sourcedata_month.v_eq_as_of_date[1..6],versionBuild[1..6]);

unsigned3 proper_ym(unsigned3 date) := 
	map
	(date=0           => 0,
	 date<1000        => 0, 
	 date<10000       => date * 100,
	 date<100000      => (date div 10) * 100,
	 date % 100 > 12  => (date div 100) * 100,
	 date);

unsigned3 fix_dates(unsigned3 date) := 
	map
	(date>today_in_ym => today_in_ym,
	 date<190000      => 0,
	 date);
	 
recordof(in_hdr) t1(in_hdr le) := transform
 self.dt_first_seen            := proper_ym(le.dt_first_seen);
 self.dt_last_seen             := proper_ym(le.dt_last_seen);
 self.dt_vendor_first_reported := proper_ym(le.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := proper_ym(le.dt_vendor_last_reported);
 self.dt_nonglb_last_seen      := proper_ym(le.dt_nonglb_last_seen);
 self                          := le;
end;

p1 := project(in_hdr,t1(left));

recordof(in_hdr) t2(p1 le) := transform
 self.dt_first_seen            := fix_dates(le.dt_first_seen);
 self.dt_last_seen             := fix_dates(le.dt_last_seen);
 self.dt_vendor_first_reported := fix_dates(le.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := fix_dates(le.dt_vendor_last_reported);
 self.dt_nonglb_last_seen      := fix_dates(le.dt_nonglb_last_seen);
 self                          := le;
end;

p2 := project(p1,t2(left));

recordof(in_hdr) t3(p2 le) := transform
 self.dt_first_seen            := if(le.dt_first_seen            <>0,le.dt_first_seen,           le.dt_last_seen);
 self.dt_last_seen             := if(le.dt_last_seen             <>0,le.dt_last_seen,            le.dt_first_seen);
 self.dt_vendor_first_reported := if(le.dt_vendor_first_reported <>0,le.dt_vendor_first_reported,le.dt_vendor_last_reported);
 self.dt_vendor_last_reported  := if(le.dt_vendor_last_reported  <>0,le.dt_vendor_last_reported, le.dt_vendor_first_reported);
 self                          := le;
end;

p3 := project(p2,t3(left));

p4 := header.fn_compare_dates_to_dob(p3);

recordof(in_hdr) t4(p4 l) := transform

 self.dt_first_seen            := if(l.dt_last_seen > l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
 self.dt_last_seen             := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
 self.dt_vendor_first_reported := if(l.dt_vendor_last_reported > l.dt_vendor_first_reported,l.dt_vendor_first_reported,l.dt_vendor_last_reported);
 self.dt_vendor_last_reported  := if(l.dt_vendor_last_reported < l.dt_vendor_first_reported,l.dt_vendor_first_reported,l.dt_vendor_last_reported);

 self                          := l;
end;

p5 := project(p4,t4(left));

return p5;

end;