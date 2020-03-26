import header,ut;

export fn_dedup (dataset(Header.Layout_header) ifile) := function

dtuasSource_dist := distribute(ifile,hash(vendor_id));

Header.Layout_header t_rollup(Header.Layout_header le, Header.Layout_header ri) := transform
 self.rec_type                 := min(le.rec_type,ri.rec_type);
 self.title                    := min(le.title,ri.title);
 self.rid                      := min(le.rid,ri.rid);
 self.rawaid                   := min(le.rawaid,ri.rawaid);
 self.cbsa                     := max(le.cbsa,ri.cbsa);
 self.dob                      := max(le.dob,ri.dob);
 self.phone                    := max(le.phone,ri.phone);
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := Max(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := Max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self                          := le;
end;

	header.Layout_PairMatch tra(Header.Layout_header ll, Header.Layout_header r) := transform
	  self.old_rid := r.rid;
	  self.new_rid := ll.rid;
	  self.pflag := 21;
	  end;

	//****** Join the infile to itself
	j := join(dtuasSource_dist,dtuasSource_dist
							,   left.vendor_id   = right.vendor_id
							and left.rid         < right.rid
							and left.fname       = right.fname
							and left.mname       = right.mname
							and left.lname       = right.lname
							and left.name_suffix = right.name_suffix
							and left.ssn         = right.ssn
							and left.prim_range  = right.prim_range
							and left.predir      = right.predir
							and left.prim_name   = right.prim_name
							and left.suffix      = right.suffix
							and left.postdir     = right.postdir
							and left.unit_desig  = right.unit_desig
							and left.sec_range   = right.sec_range
							and left.city_name   = right.city_name
							and left.st          = right.st
							and left.zip         = right.zip
							and left.zip4        = right.zip4
							and left.county      = right.county
					,tra(left,right)
					,local);
					
	sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

	rolled_rids := dedup(sj,old_rid,local);

	ut.MAC_Patch_Id(dtuasSource_dist, rid, rolled_rids, old_rid, new_rid, old_and_new);

	dinfile := distribute(old_and_new,hash(rid));

	BR_s := sort(dinfile, rid,local);

	Tu_to_header := rollup(BR_s,left.rid=right.rid,t_rollup(left,right),local);

	return Tu_to_header;
end;