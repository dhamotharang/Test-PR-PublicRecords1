
export mac_get_type_h(f_h_did, f_h_acctno, f_h_out, modAccess) := macro

import gong, doxie, address, progressive_phone, ut, STD;

#uniquename(gong_addr_key)
%gong_addr_key% := gong.key_Address_current;

#uniquename(subj_best_rec)
%subj_best_rec% := record
	unsigned4 seq;
	doxie.layout_best;
end;

#uniquename(get_subj_best)

%subj_best_rec% %get_subj_best%(f_h_did l, doxie.layout_best r) := transform
	self.seq := l.seq;
	self.did := l.did;
	self := r;
	self := [];
end;

#uniquename(outfile)
doxie.mac_best_records(f_with_did(did<>0),
											 did,
											 %outfile%,
											 dppa_ok,
											 glb_ok, 
											 ,
											 modAccess.DataRestrictionMask);

#uniquename(f_subj_best)
%f_subj_best% := join(f_with_did(did<>0), %outfile%,
												left.did = right.did,
											%get_subj_best%(left, right), left outer, keep(1));

#uniquename(get_nbr_best_init)
doxie.layout_nbr_targets  %get_nbr_best_init%(%f_subj_best% l) := transform
	self.seqTarget := l.seq;
	self.dt_last_seen := l.addr_dt_last_seen;
	self := l;
	self := [];
end;		
		
#uniquename(f_best_nbr_init)
%f_best_nbr_init% := project(%f_subj_best%, %get_nbr_best_init%(left))(prim_name<>'');

#uniquename(get_nbr_in_init)
doxie.layout_nbr_targets  %get_nbr_in_init%(f_h_acctno l) := transform
	self.seqTarget := l.seq;
	self.suffix := l.addr_suffix;
	self.zip := l.z5;
	self := l;
	self := [];
end;		
		
#uniquename(f_in_nbr_init)
%f_in_nbr_init% := project(f_h_acctno, %get_nbr_in_init%(left))(prim_name<>'');

#uniquename(get_in_only)
doxie.layout_nbr_targets %get_in_only%(%f_in_nbr_init% l) := transform
		self := l;
end;

#uniquename(f_both_nbr_init)
%f_both_nbr_init% := join(%f_in_nbr_init%, %f_best_nbr_init%,
                          left.seqTarget = right.seqTarget,
						           		%get_in_only%(left), left only) 
					           + %f_best_nbr_init%;
										 
#uniquename(f_nbrs_raw)
%f_nbrs_raw% := doxie.nbr_records(%f_both_nbr_init%,
						                    	'C',
							                    Max_Neighborhoods,
							                    10,
							                    Neighbors_Per_NA,
							                    Neighbor_Recency,
							                    modAccess.industry_class,
																	modAccess.glb,
							                    modAccess.dppa,
							                    modAccess.probation_override,
							                    modAccess.no_scrub,
							                    glb_ok,
							                    dppa_ok,
							                    modAccess.ssn_mask, false, false,,false);  
																	// treat as subject because the header rows are only being used to look up phone rows and it will not be returned otherwise
																	
#uniquename(nbr_with_rank_rec)																	
%nbr_with_rank_rec% := record
	doxie.layout_nbr_records;
	unsigned nbr_rank;
end;

#uniquename(get_nbr_rank)
%nbr_with_rank_rec% %get_nbr_rank%(%f_nbrs_raw% l, unsigned cnt) := transform
	self.nbr_rank := cnt;
	self := l;
end;

#uniquename(f_nbrs_w_rank)
%f_nbrs_w_rank% := project(%f_nbrs_raw%, %get_nbr_rank%(left, counter));

#uniquename(f_nbrs_ready)
%f_nbrs_ready% := group(sort(%f_nbrs_w_rank%, seqTarget, nbr_rank),seqTarget);

#uniquename(f_nbrs)
%f_nbrs% := TopN(%f_nbrs_ready%, 100, nbr_rank);

#uniquename(by_addr_lname)
progressive_phone.layout_progressive_batch_out_with_did %by_addr_lname%(%f_nbrs% l, 
                                                               %gong_addr_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seqtarget);
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := l.name_suffix; 
	self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '8';
     self.subj_date_first := (string8)l.dt_first_seen;
     self.subj_date_last := (string8)l.dt_last_seen;
		 self.subj_phone_date_last := '';
     // note that generally phone can have more than one type:
     self.phpl_phones_plus_type := map(r.listing_type & Gong.Constants.PTYPE.RESIDENTIAL = Gong.Constants.PTYPE.RESIDENTIAL => 'R',
                                       r.listing_type & Gong.Constants.PTYPE.BUSINESS    = Gong.Constants.PTYPE.BUSINESS => 'B',
                                       r.listing_type & Gong.Constants.PTYPE.GOVERNMENT  = Gong.Constants.PTYPE.GOVERNMENT => 'G',
                                       '');
	self.did := l.did;
	self.sort_order_internal := l.nbr_rank;
	string182 addr := r.prim_range+' '+r.predir+' '+r.prim_name+' '+r.suffix+' '+r.sec_range;
	cln := address.CleanAddressFieldsFips(address.CleanAddress182(addr,r.z5));
	self.prim_range := cln.prim_range;
	self.predir := cln.predir;
	self.prim_name := cln.prim_name;
	self.addr_suffix := cln.addr_suffix;
	self.postdir := cln.postdir;
	self.unit_desig := cln.unit_desig;
	self.sec_range := cln.sec_range;
	self.p_city_name := cln.p_city_name;
	self.v_city_name := cln.v_city_name;
	self.st := cln.st;
	self.zip5 := cln.zip;
	self.sub_rule_number := 81;
	self := [];											   
end;

#uniquename(f_h_nbr_out_ready)
%f_h_nbr_out_ready% := join(%f_nbrs%, %gong_addr_key%,
                            keyed(left.prim_name = right.prim_name) and
	                          keyed(left.st = right.st) and
	                          keyed(left.zip = right.z5) and
		                        keyed(left.prim_range = right.prim_range) and
		                        (left.lname = right.lname or
				                    (length(trim(left.lname))>6 and length(trim(right.lname))>6 and 
					                   STD.Str.EditDistance(left.lname, right.lname)<2) or
					                  (length(trim(left.lname))>4 and 
					                   left.lname=right.listed_name[1..length(trim(left.lname))]) or 
					                  (STD.Str.Find(right.lname,'-'+trim(left.lname),1) > 0 or 
					                   STD.Str.Find(right.lname,trim(left.lname)+'-',1) > 0) or  
			                       left.fname = right.fname and 
				                    (STD.Str.EditDistance(left.lname, right.lname)<2 or
				                     length(trim(left.lname))>5 and 
				                     STD.Str.EditDistance(left.lname, right.lname)<3)) and
				                    (left.sec_range = '' or left.sec_range = right.sec_range or
				                     NID.mod_PFirstTools.PFLeqPFR(left.fname, right.fname) or 
					                   length(trim(right.fname))=1 and left.fname[1]=right.fname),					          
		                         %by_addr_lname%(left, right),limit(ut.limits.PHONE_PER_PERSON, skip));														 

#uniquename(f_h_nbr_out_dep)
%f_h_nbr_out_dep% := dedup(sort(%f_h_nbr_out_ready%, acctno, subj_phone10, -subj_date_last, -subj_date_first), 
                       acctno, subj_phone10);

progressive_phone.mac_get_back_acctno(%f_h_nbr_out_dep%, f_h_acctno, f_h_out)

endmacro; 