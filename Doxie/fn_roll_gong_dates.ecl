import Doxie, dx_Gong, Suppress;

export fn_roll_gong_dates(DATASET(layout_presentation) in_f, doxie.IDataAccess mod_access) := FUNCTION

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

// Temporary layout to support opt_out key suppression.
slim_addr_phone_rec_optout := RECORD
  slim_addr_phone_rec;
  unsigned6 did;
  unsigned4 global_sid;
  unsigned8 record_sid;
END;

f_slim_ap := project(in_f, transform(slim_addr_phone_rec,self := left));

f_slim_ap_dep := dedup(sort(f_slim_ap(prim_name<>''),record),record);

key_history_address := dx_Gong.key_history_address();
slim_addr_phone_rec_optout get_phone_dates(f_slim_ap_dep l, key_history_address r) := transform
  self.phone_first_seen := (integer)r.dt_first_seen[1..6];
  self.phone_last_seen := (integer)r.dt_last_seen[1..6];
  self.global_sid := r.global_sid;
  self.record_sid := r.record_sid;
  self.did := r.did;
  self := l;
end;

_f_slim_ap_with_dates := join(f_slim_ap_dep, key_history_address,
  keyed(left.prim_name = right.prim_name) and
  keyed(left.st = right.st) and
  keyed(left.zip = right.z5) and
  keyed(left.prim_range = right.prim_range) and
  left.phone = right.phone10,
  get_phone_dates(left, right),limit(1000, skip));

f_slim_ap_with_dates_optout := Suppress.MAC_SuppressSource(_f_slim_ap_with_dates, mod_access);

f_slim_ap_with_dates := PROJECT(f_slim_ap_with_dates_optout, slim_addr_phone_rec);

f_slim_ap_grp := group(sort(f_slim_ap_with_dates, prim_name, prim_range, st,
  zip, phone, -phone_first_seen), prim_name,prim_range,st,zip,phone);

slim_addr_phone_rec roll_phone_dates(f_slim_ap_grp l, f_slim_ap_grp r) := transform
  self.phone_last_seen := if(l.phone_last_seen > r.phone_last_seen, l.phone_last_seen, r.phone_last_seen);
  self.phone_first_seen := if(l.phone_first_seen < r.phone_first_seen, l.phone_first_seen, r.phone_first_seen);
  self := l;
end;

return group(rollup(f_slim_ap_grp, true, roll_phone_dates(left, right)));

END;
