// Do not allow pDs to extend header dates
EXPORT fn_set_dates_to_header_dates(pDs) :=functionmacro

pDs_has_did := pDs((unsigned)did > 0);
pDs_no_did := pDs((unsigned)did = 0);

pDs_dist := distribute(pDs_has_did, hash((unsigned)did)); // Header file is hashed on did, so let's match that.
hdr:=header.file_headers;
tbl:=table(hdr,{did,dt_first_seen,dt_last_seen,prim_range,prim_name,sec_range,city_name,st});
tbl_dist := distribute(tbl, hash(did));
rlh:=rollup(sort(tbl_dist,did,prim_range,prim_name,sec_range,city_name,st,local)
						,transform({tbl}
							,self.dt_first_seen:=ut.Min2(left.dt_first_seen,right.dt_first_seen)
							,self.dt_last_seen :=MAX(left.dt_last_seen ,right.dt_last_seen)
							,self:=left
						)
						,did,prim_range,prim_name,sec_range,city_name,st
						,local)
			;

return
			join(rlh,pDs_dist
					,   left.did        = (unsigned)right.did
					and left.prim_range = (qstring)right.prim_range
					and left.prim_name  = (qstring)right.prim_name
					and left.sec_range  = (qstring)right.sec_range
					and left.city_name  = (qstring)right.p_city_name
					and left.st         = (qstring)right.st
				,transform({pDs}
					,self.date_first_seen:=if(left.did=(unsigned)right.did,(string)left.dt_first_seen,right.date_first_seen)
					,self.date_last_seen :=if(left.did=(unsigned)right.did,(string)left.dt_last_seen ,right.date_last_seen)
					,self:=right
					)
				,right outer
				,local
			)
			+ pDs_no_did
			;

endmacro;