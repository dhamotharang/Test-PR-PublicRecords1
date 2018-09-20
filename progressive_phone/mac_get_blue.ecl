
export mac_get_blue(f_get_blue_in, 
                    f_get_blue_out, 
                    check_same_apt_lname='false', 
				check_same_apt_diff_lname='false',
				header_phone_use='false',
				modAccess) := macro
import doxie,header, header_quick, progressive_phone,utilfile, ut, mdr, STD;

#uniquename(header_key)
%header_key% := doxie.Key_Header;

#uniquename(quick_header_key)
%quick_header_key% := header_quick.key_DID;

#uniquename(daily_utility_key)
%daily_utility_key% := utilfile.Key_Util_Daily_Did;

#uniquename(by_header)
progressive_phone.layout_header_seq %by_header%(f_get_blue_in l, %header_key% r) := transform	
	self.seq := l.seq;
	self := r;
end;

#uniquename(header_recs_raw)
#uniquename(header_recs_cleaned)
#uniquename(header_recs)
%header_recs_raw% := join(f_get_blue_in, %header_key%,
                      keyed(left.did = right.s_did) and
											~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, modAccess.DataRestrictionMask),
				              %by_header%(left, right), limit(ut.limits.HEADER_PER_DID,skip))(~mdr.Source_is_on_Probation(src));
Header.MAC_GlbClean_Header(%header_recs_raw%, %header_recs_cleaned%, , , mod_access);
%header_recs% := project(%header_recs_cleaned%, progressive_phone.layout_header_seq);

#uniquename(by_quick_header)
progressive_phone.layout_header_seq %by_quick_header%(f_get_blue_in l, %quick_header_key% r) := transform	
	self.seq := l.seq;
	self := r;
end;

#uniquename(quick_header_recs)
%quick_header_recs% := join(f_get_blue_in, %quick_header_key%,
                            keyed(left.did = right.did), 
			       	   %by_quick_header%(left, right), limit(ut.limits.HEADER_PER_DID,skip));

#uniquename(add4)
unsigned3 %add4%(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);
#uniquename(todaydate)
unsigned3 %todaydate% := (unsigned3)(Std.Date.Today() div 100);
#uniquename(lesser)
unsigned3 %lesser%(unsigned3 dt2) := if (%add4%(dt2) < %todaydate%, %add4%(dt2), %todaydate%);

#uniquename(by_daily_utility)
progressive_phone.layout_header_seq %by_daily_utility%(f_get_blue_in l, %daily_utility_key% r) := transform	
	self.seq := l.seq;
	self.did := l.did,
	self.rec_type := '1';
	// bug 61233 this is where we need to add source code for type=z "non-utility" data.
	SELF.src := IF (trim(r.util_type) ='Z','ZU','DU');
	self.vendor_id := r.id;
	self.suffix := r.addr_suffix;
	self.city_name := r.p_city_name;
	self.dt_first_seen :=  (integer)r.date_first_seen div 100;
	self.dt_last_seen := if((integer)r.date_first_seen div 100=0,0,
	   					%lesser%((integer)r.date_first_seen div 100));
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_nonglb_last_seen := self.dt_last_seen;
	self.county := r.county[3..5];
	self.tnt := 'Y';
	self.dob := (unsigned)r.dob;	
	self := r;
	self := [];
end;

#uniquename(daily_utility_recs)
%daily_utility_recs% := join(f_get_blue_in, %daily_utility_key%,
                            keyed(left.did = right.s_did), 
			       	   %by_daily_utility%(left, right), limit(ut.limits.HEADER_PER_DID,skip));

#uniquename(five_years_ago)
%five_years_ago% := (unsigned) Std.Date.Today() DIV 100 - 500;

#uniquename(f_get_blue_raw)
%f_get_blue_raw% := (%header_recs% + %quick_header_recs% + %daily_utility_recs%)
                    (dt_last_seen>%five_years_ago%, prim_name[1..6]<>'PO BOX', prim_name[1..3]<>'DOD');
//need to patch dt_first_seen, dt_last_seen
#uniquename(layout_addr_dt_seen)
%layout_addr_dt_seen% := record
	unsigned4   seq;
	unsigned6   did;
	qstring10   prim_range;	
     qstring28   prim_name;
	qstring8    sec_range;
     qstring5    zip;
	unsigned3   dt_first_seen;
	unsigned3   dt_last_seen;
end;

#uniquename(f_dt_seen_slim)
%f_dt_seen_slim% := project(%f_get_blue_raw%, %layout_addr_dt_seen%);

#uniquename(f_dt_seen_grp)
%f_dt_seen_grp% := group(sort(%f_dt_seen_slim%, seq, did, prim_range, prim_name, sec_range, zip),
                         seq, did, prim_range, prim_name, sec_range, zip);

			
#uniquename(roll_dt_seen)			
%f_dt_seen_grp% %roll_dt_seen%(%f_dt_seen_grp% l, %f_dt_seen_grp% r) := transform
	self.dt_first_seen := map(l.dt_first_seen=0 => r.dt_first_seen,
	                          r.dt_first_seen=0 => l.dt_first_seen,
						 l.dt_first_seen < r.dt_first_seen => l.dt_first_seen,
						 r.dt_first_seen);
	self.dt_last_seen := if(l.dt_last_seen < r.dt_last_seen,
	                        r.dt_last_seen, l.dt_last_seen);
	self := l;					
end;

#uniquename(f_dt_seen_roll)
%f_dt_seen_roll% := rollup(%f_dt_seen_grp%,true,%roll_dt_seen%(left,right));
 
#uniquename(get_better_date)				    
progressive_phone.layout_header_seq %get_better_date%(%f_get_blue_raw% l, %f_dt_seen_roll% r) := transform
	self.dt_first_seen := r.dt_first_seen;
	self.dt_last_seen := if(r.dt_last_seen>r.dt_first_seen,r.dt_last_seen,r.dt_first_seen);
	self := l;
end;				    

#uniquename(f_get_blue_w_date_raw)
%f_get_blue_w_date_raw% := join(%f_get_blue_raw%, %f_dt_seen_roll%,
                            left.seq = right.seq and
					   left.did = right.did and
					   left.prim_range = right.prim_range and
					   left.prim_name = right.prim_name and
					   left.sec_range = right.sec_range and
					   left.zip = right.zip, %get_better_date%(left, right), left outer, keep(1),limit(0));

#uniquename(f_get_blue_w_date)
%f_get_blue_w_date% := dedup(sort(%f_get_blue_w_date_raw%, seq, did, dt_first_seen, dt_last_seen, 
                                  fname,lname, prim_name, zip, prim_range, sec_range, -mname, -phone), 
					    seq, did, dt_first_seen, dt_last_seen, fname, lname, prim_name, zip, 
					         prim_range, sec_range);

#uniquename(f_get_same_apt_lname);
progressive_phone.mac_get_same_apt_lname(%f_get_blue_w_date%, %f_get_same_apt_lname%, false, ModAccess.DataRestrictionMask);

#uniquename(f_get_same_apt_diff_lname);
progressive_phone.mac_get_same_apt_lname(%f_get_blue_w_date%, %f_get_same_apt_diff_lname%, true, ModAccess.DataRestrictionMask);

//make every last name availalbe - up to 5					   
//need to patch dt_first_seen, dt_last_seen
#uniquename(layout_addr_dt_seen)
%layout_addr_dt_seen% := record
	unsigned4   seq;
	unsigned6   did;
	qstring20   lname;
end;					   
	 	 
#uniquename(f_more_lname_raw)		 
%f_more_lname_raw% := dedup(sort(project(%f_get_blue_raw%(lname<>''), %layout_addr_dt_seen%), record), record);	

				    
#uniquename(f_more_lname)
%f_more_lname% := TopN(group(sort(%f_more_lname_raw%, seq, did), seq, did), 5, seq, did);		

#uniquename(get_more_lname)
progressive_phone.layout_header_seq %get_more_lname%(%f_get_blue_w_date% l, %f_more_lname% r) := transform
	self.lname := r.lname;
	self := l;
end;

#uniquename(f_get_blue_out_ready)
%f_get_blue_out_ready% := join(%f_get_blue_w_date%, %f_more_lname%,
                               left.seq = right.seq and
	  			           left.did = right.did,
				           %get_more_lname%(left, right), left outer) +
			           if(check_same_apt_lname, %f_get_same_apt_lname%) +
			           if(check_same_apt_diff_lname, %f_get_same_apt_diff_lname%);
					 
f_get_blue_out :=  dedup(sort(if(header_phone_use, 
                                 %f_get_blue_w_date_raw%(phone<>''),
                                 %f_get_blue_out_ready%), record), record);

endmacro;