export MAC_Check_Expire(infile, exp_date_field, outfile) := macro

rec := record
	infile.orig_state;
	integer init_load := 100 * (integer)min(group, (integer)infile.dt_first_seen);
end;

dt := table(infile(dt_first_Seen > 190000), rec, orig_state, few);

// output(dt);
typeof(infile) checkexp(infile l, dt r) := transform
  self.dt_first_seen := if((integer)l.exp_date_field > 19000000 and (integer)l.exp_date_field < r.init_load,
						   0, l.dt_first_seen);
  self.dt_last_seen := if((integer)l.exp_date_field > 19000000 and (integer)l.exp_date_field < r.init_load,
						   0, l.dt_last_seen);
  self.dt_vendor_first_reported := if((integer)l.exp_date_field > 19000000 and (integer)l.exp_date_field < r.init_load,
								   0, l.dt_vendor_first_reported);
  self.dt_vendor_last_reported := if((integer)l.exp_date_field > 19000000 and (integer)l.exp_date_field < r.init_load,
								   0, l.dt_vendor_last_reported);
  self := l;
end;

outfile := join(infile, dt, left.orig_state = right.orig_state, checkexp(left, right), left outer, lookup);

endmacro;