import header,mdr,watchdog,ut;

export fn_NewMovers_dt(dataset(recordof(watchdog.Layout_Best)) in_file) := function

fil_header := header.file_headers_NonGLB(mdr.Source_is_Marketing_Eligible(src,vendor_id,st,county,dt_nonglb_last_seen,dt_first_seen)) ; 
fil_header_dist    := distribute(fil_header,hash(did,prim_range,prim_name,sec_range,zip)) ;

temp_rec := record 
  watchdog.Layout_Best ;
  string60	click_id ;
  string60	click_hhid ;
end; 

temp_rec reformat( in_file  l )  := transform 

  self.click_id := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,l.lname,'','','');
  self.click_hhid := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,'','','','');
  self := l ; 
end; 

in_file_id := project(in_file(trim(dod)='') ,reformat(left)); 	// Filter out dead persons 
in_file_dist := distribute(in_file_id(click_hhid <> ''),hash(did,prim_range,prim_name,sec_range,zip)); // Filter out empty address
	
r1 := record
 temp_rec ;
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned6 addr_id;
end;

r1 t1(in_file_dist le, fil_header_dist ri) := transform
 self.addr_id            := hash64(stringlib.stringcleanspaces(le.prim_range+le.prim_name+le.sec_range+le.zip));
 self.dt_first_seen      := ri.dt_first_seen ;
 self.dt_last_seen       := ri.dt_last_seen ;
 self                    := le;
end;
   
file_dt := join(in_file_dist,fil_header_dist,
                       left.did=right.did and 
		               left.prim_range= right.prim_range and
			           left.prim_name = right.prim_name  and
			           left.sec_range = right.sec_range  and
			           left.zip       = right.zip,
		                 t1(left,right),left outer,local);
  
file_dt_dist := sort(distribute(file_dt,hash(did,addr_id)) , did,addr_id,-dt_last_seen,dt_first_seen,local);

r1 t3(file_dt_dist le, file_dt_dist ri) := transform
 self.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen  := ut.max2(le.dt_last_seen,ri.dt_last_seen);
 self                    := le;
end;

file_roll_dt := rollup(file_dt_dist,
             left.did     = right.did      and
			 left.addr_id = right.addr_id,
			 t3(left,right),
			 local
			);

return file_roll_dt;

end;