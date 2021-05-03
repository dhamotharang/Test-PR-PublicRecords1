// objective:
// 1)As a step prior to putting TUCS records into the as_header, externally ADL the file.
// We then only want to let those records which have an ADL+address match to what's currently in the header.
// (ensure that the external ADL doesn't get in
// -> preserve the did=0 in the as_header.)

// 2)Much of the TUCS data has the _seen dates already removed.  There are 4 dates in the as_header deemed
// suspicious.
// For the remaining records that do have dates, only keep the date if it falls within a range of dates on other
// sources having the same address.  We basically want to avoid TUCS setting the earliest or latest _seen dates
// for a person at an address.

import mdr, ut, header_slimsort, did_add, didville, _control,USPS_AIS,Transunion_PTrak;

export fn_TUCS_exclusuins(	dataset(recordof(Header.Layout_New_Records))	TUCS_file
							,dataset(recordof(header.Layout_Header))		hdr_file
						)	:= function

	Header.MAC_replace_alias_street(hdr_file, hdr_no_alias);
	hdr0:=distribute(hdr_no_alias,hash(did));
	hdr:=table(hdr0
					,{	did
						,prim_range
						,prim_name
						,sec_range
						,city_name
						,zip
						,min_dt_first_seen				:=min(group,dt_first_seen)
						,min_dt_vendor_first_reported	:=min(group,dt_vendor_first_reported)
						,max_dt_last_seen				:=max(group,dt_last_seen)
						,max_dt_vendor_last_reported	:=max(group,dt_vendor_last_reported)
					}	,did,prim_range,prim_name,sec_range,city_name,zip,local);

	Header.MAC_replace_alias_street(TUCS_file, TUCS_no_alias); 
	TUCS_recs0:=distribute(TUCS_no_alias,hash(did));

	Header.Layout_New_Records tr(TUCS_recs0 l,hdr r) := transform
		self.did						:=if(r.did=0,0,l.did);
		self.dt_first_seen				:=if(	l.dt_first_seen < r.min_dt_first_seen
											or	r.min_dt_first_seen=0, 0, l.dt_first_seen);
		self.dt_last_seen				:=if(l.dt_last_seen > r.max_dt_last_seen,0,l.dt_last_seen);
		self:=l;
	end;

	TUCS_recs1:=join(TUCS_recs0,hdr
						,	left.did=right.did
						and	left.prim_range=right.prim_range
						and	left.prim_name=right.prim_name
						and	ut.nneq(left.sec_range,right.sec_range)
						and	(left.city_name=right.city_name	or left.zip=right.zip)
						,tr(left,right)
						,left outer
						,local);

	TUCS_recs2:=sort(distribute(TUCS_recs1(did>0),hash(uid)),uid,local);

	Header.Layout_New_Records roll(TUCS_recs2 l, TUCS_recs2 r) := transform
	 self.dt_first_seen            := Max(l.dt_first_seen,r.dt_first_seen);
	 self.dt_last_seen             := ut.Min2(l.dt_last_seen,r.dt_last_seen);
	 self                          := l;
	end;

	TUCS_recs3 := rollup(TUCS_recs2,left.uid=right.uid,roll(left,right), local );

	TUCS_recs  := join(distribute(TUCS_file,hash(uid)),distribute(TUCS_recs3,hash(uid))
						,left.uid=right.uid
						,transform({Header.Layout_New_Records}
                                    ,self.dt_first_seen:= if(right.dt_last_seen=0 ,0,right.dt_first_seen);
									,self.dt_last_seen:=  if(right.dt_first_seen=0,0,right.dt_last_seen );

                                    ,self:=left)
						,local);
	return TUCS_recs;
end;