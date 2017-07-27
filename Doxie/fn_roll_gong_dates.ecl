import gong;

export fn_roll_gong_dates(DATASET(layout_presentation) in_f) := FUNCTION

//get the phone dates for numbers already in the records
slim_addr_phone_rec := record
   in_f.prim_name;
   in_f.prim_range;
   in_f.st;
   in_f.zip;
   in_f.phone;
   in_f.phone_first_seen;
   in_f.phone_last_seen;
end;

f_slim_ap := project(in_f, transform(slim_addr_phone_rec,self := left));
											   														  
f_slim_ap_dep := dedup(sort(f_slim_ap(prim_name<>''),record),record);
				 
slim_addr_phone_rec get_phone_dates(f_slim_ap_dep l, gong.Key_History_Address r) := transform
   self.phone_first_seen := (integer)r.dt_first_seen[1..6];
   self.phone_last_seen := (integer)r.dt_last_seen[1..6];
   self := l;
end;

f_slim_ap_with_dates := join(f_slim_ap_dep, gong.Key_History_Address,
                              keyed(left.prim_name = right.prim_name) and 
						                  keyed(left.st = right.st) and 
						                  keyed(left.zip = right.z5) and 
						                  keyed(left.prim_range = right.prim_range) and 
						                  left.phone = right.phone10,
						                  get_phone_dates(left, right),limit(1000, skip));
									   
f_slim_ap_grp := group(sort(f_slim_ap_with_dates,prim_name,prim_range,st,zip,phone,-phone_first_seen),
                        prim_name,prim_range,st,zip,phone);

slim_addr_phone_rec roll_phone_dates(f_slim_ap_grp l, f_slim_ap_grp r) := transform
    self.phone_last_seen := if(l.phone_last_seen > r.phone_last_seen, l.phone_last_seen, r.phone_last_seen);
    self.phone_first_seen := if(l.phone_first_seen < r.phone_first_seen, l.phone_first_seen, r.phone_first_seen);
    self := l;
end;

return group(rollup(f_slim_ap_grp, true, roll_phone_dates(left, right)));

END;
