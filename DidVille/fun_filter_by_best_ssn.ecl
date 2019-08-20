import doxie, header, didville, ut, mdr, dx_header;

export fun_filter_by_best_ssn(grouped dataset(header.layout_header) hdr_data,
                              dataset(didville.layout_bestInfo_batchin) in_data,
							  doxie.IDataAccess mod_access,
						unsigned1 scr_thr_val) := function
				
header.layout_header refine_hdr(hdr_data l) := transform
	self := l;
end;				
				
w_in_ssn := join(hdr_data, in_data((unsigned)ssn<>0),
                 left.rid = (unsigned6)right.acctno and 
			  (header.ssn_value(left.ssn, right.ssn)>0 or 
			  (unsigned)left.ssn = 0), refine_hdr(left));				

//slimable, penalt to get most possible 'SSN'
with_penalt_rec := record
	unsigned6 rid,
     unsigned1 penalt,			   
	qstring9 ssn,
	string1 valid_ssn,
	qstring20 fname;
	qstring20 mname;
     qstring20 lname;
	unsigned3 dt_last_seen;
	string1 tnt;
	integer4 dob;
end;

with_penalt_rec get_penalt(hdr_data l, in_data r) := transform
	self.penalt := didville.fun_in_hd_penalty(r.name_first, l.fname,
	                                          r.name_middle, l.mname,
									  r.name_last, l.lname,
									  '','',
									  '','',
									  r.predir, l.predir,
									  r.prim_range, l.prim_range,
									  r.prim_name, l.prim_name,
									  r.suffix, l.suffix,
									  r.postdir, l.postdir,
									  r.sec_range, l.sec_range,
									  r.p_city_name, l.city_name,
									  r.st, l.st,
									  r.z5, l.zip,
									  '','',10) + if(~ut.nneq(r.sec_range, l.sec_range),1,0);
	self.dt_last_seen := if(l.dt_last_seen<>0,l.dt_last_seen, l.dt_first_seen);								  									  
     self := l;									  
end;
			   
w_penalt := join(hdr_data, in_data((unsigned)ssn=0),
                 left.rid = (unsigned6)right.acctno,
			           get_penalt(left, right), limit(ut.limits.HEADER_PER_DID, skip));			   
		
w_penalt_srt := sort(w_penalt, rid, if(ssn<>'',1,2), penalt, map(valid_ssn='G'=>1,valid_ssn=''=>2,3),
                               if(dob<>0,1,2), -dt_last_seen, doxie.tnt_score(tnt), -ssn);

w_penalt_dep := dedup(w_penalt_srt, rid);

//use the found SSN + NAME to re-fetch header records				    
ssn_to_rt := project(w_penalt_dep, 
                     transform({didville.layout_bestInfo_batchin},
				           self.acctno := (qstring20)left.rid, 
				           self.name_first := left.fname,
						 self.name_middle := left.mname,
				           self.name_last := left.lname,
				           self.ssn := left.ssn,
				           self := []));				    

did_to_rt_raw := didville.Did_From_SSN_Batch(ssn_to_rt,true,scr_thr_val,false);

did_to_rt := join(did_to_rt_raw, hdr_data,
                  (unsigned6)left.acctno = right.rid and  
                  left.did = right.did, 
		        transform({did_to_rt_raw}, self := left), left only);

header.layout_header get_hdr_rt(did_to_rt l, dx_header.layout_key_header r) := transform
	self.rid := (unsigned6)l.acctno,
	self.did := l.did,
	self := r,
end;

hdr_rt_data := join(did_to_rt, dx_header.key_header(), 
                     keyed(left.did = right.s_did) and
										 ~Doxie.compliance.isHeaderSourceRestricted(right.src, mod_access.DataRestrictionMask),
     	           get_hdr_rt(left, right), LIMIT(500,SKIP));
		
hdr_w_rt := group(hdr_data) + hdr_rt_data;

wo_in_ssn := join(hdr_w_rt, w_penalt_dep,
                  left.rid = right.rid and
			   (left.ssn= right.ssn  or
			   (unsigned)right.ssn = 0), refine_hdr(left));	
	
return group(w_in_ssn + wo_in_ssn, rid);

end;