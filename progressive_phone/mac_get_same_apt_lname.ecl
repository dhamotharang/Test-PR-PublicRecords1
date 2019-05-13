//this macro retrieves people live at the same apartment and having the same last name
//as the input records

export mac_get_same_apt_lname(f_in, f_out, diff_lname='false', data_restriction_mask='') := macro

import ut, mdr, dx_header;

#uniquename(header_key)
#uniquename(header_addr_key)	
%header_key% := dx_header.key_header();
%header_addr_key% := dx_header.key_wild_address_EN();
	
#uniquename(f_in_w_apt)
%f_in_w_apt% := f_in(prim_name<>'', sec_range<>'', lname<>''); 	

#uniquename(f_in_w_apt_dep)
%f_in_w_apt_dep% := dedup(sort(%f_in_w_apt%(length(trim(lname))>1), 
                               seq, prim_name, prim_range, zip, sec_range, lname, -dt_last_seen, -dt_first_seen), 
                          seq, prim_name, prim_range, zip, sec_range, lname);

#uniquename(get_same_apt_lname)
progressive_phone.layout_header_seq  %get_same_apt_lname%(%f_in_w_apt_dep% l, %header_addr_key% r) := transform
	self.seq := l.seq;
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.dt_vendor_last_reported := l.dt_last_seen;
	self.prim_name := l.prim_name;
	self.city_name := l.city_name;
	self.st := l.st;
	self := r;
	self := [];
end;

#uniquename(f_out_same_apt_lname)
%f_out_same_apt_lname% := join(%f_in_w_apt_dep%, %header_addr_key%,
                               ut.StripOrdinal(left.prim_name) = right.prim_name and
						                   left.prim_range = right.prim_range and
						                   left.st = right.st and 
															 right.city_code in doxie.Make_CityCodes(left.city_name).rox and 
						                   left.zip = right.zip and
					                     left.sec_range = right.sec_range and 
						                   left.lname = right.lname and
						                   left.fname <> right.fname, 
						                   %get_same_apt_lname%(left, right), limit(10, skip));
						 						 
#uniquename(f_out_same_apt_diff_lname)
%f_out_same_apt_diff_lname% := join(%f_in_w_apt_dep%, %header_addr_key%,
                                    ut.StripOrdinal(left.prim_name) = right.prim_name and
						                        left.prim_range = right.prim_range and
																		left.st = right.st and 
															      right.city_code in doxie.Make_CityCodes(left.city_name).rox and 
						                        left.zip = right.zip and
					                          left.sec_range = right.sec_range and 
						                        left.lname <> right.lname,
						                        %get_same_apt_lname%(left, right), limit(100, skip));

#uniquename(f_out_same_apt)
%f_out_same_apt% := dedup(sort(%f_out_same_apt_lname% + 
                               if(diff_lname, %f_out_same_apt_diff_lname%), 
					      seq, did, lname, fname, mname, prim_name, prim_range, zip, sec_range, -dt_last_seen, -dt_first_seen), 
					 seq, did, lname, fname, mname, prim_name, prim_range, zip, sec_range);
	
#uniquename(get_dt_last_seen)	
progressive_phone.layout_header_seq  %get_dt_last_seen%(%f_out_same_apt% l, %header_key% r) := transform
	self.dt_first_seen := r.dt_first_seen;
	self.dt_last_seen := r.dt_last_seen;
	self := l;
end;	
	
#uniquename(f_last_seen_patched)	
%f_last_seen_patched% := join(%f_out_same_apt%, %header_key%,
                              keyed(left.did = right.s_did) and 
 					                    left.prim_name = right.prim_name and
					                    left.prim_range = right.prim_range and
					                    left.zip = right.zip and
					                    left.sec_range = right.sec_range and
															~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, data_restriction_mask) and
															~mdr.Source_is_on_Probation(right.src),
					                    %get_dt_last_seen%(left, right), left outer, limit(100, skip))(dt_last_seen<>0);
						
f_out := dedup(sort(%f_last_seen_patched%, seq, did, lname, fname, mname, prim_name, prim_range, zip, sec_range, -dt_last_seen, -dt_first_seen),
               seq, did, lname, fname, mname, prim_name, prim_range, zip, sec_range);						
	
endmacro;
