
infutor_unique        := dedup(first_data.Choose_SSN1_or_SSN2,fname,mname[1],lname,name_suffix,prim_range,prim_name,sec_range,zip,all);

//infutor_unique_did    := distribute(infutor_unique(did<>0),hash(did,prim_range,prim_name,sec_range,zip));
infutor_unique_did0   := infutor_unique(did<>0);
infutor_unique_no_did := infutor_unique(did=0);

did_ct_rec := record
 infutor_unique_did0.did;
 did_ct := count(group);
end;

t_did_ct := table(infutor_unique_did0,did_ct_rec,did);

first_data.Layout_FatRec t_get_did_ct_within_file(infutor_unique_did0 l, t_did_ct r) := transform
 self.did_ct := r.did_ct;
 self        := l;
end;

get_did_ct_within_file := join(infutor_unique_did0,t_did_ct,
                               left.did=right.did,
							   t_get_did_ct_within_file(left,right)
							  );

infutor_unique_did := distribute(get_did_ct_within_file,hash(did,prim_range,prim_name,sec_range,zip));

first_data.layout_fatrec determine_current_or_historical_address(first_data.layout_fatrec l, first_data.Find_Current_Address r) := transform
 
 boolean has_right_rec := r.did;
 
 self.current_addr_ind  := if(has_right_rec,r.current_ind,      l.current_addr_ind);
 self.hdr_dt_first_seen := if(has_right_rec,r.min_dt_first_seen,l.hdr_dt_first_seen);
 self.hdr_dt_last_seen  := if(has_right_rec,r.max_dt_last_seen, l.hdr_dt_last_seen);
 self                   := l;
end;

infutor_current_or_historical_determination := join(infutor_unique_did,first_data.Find_Current_Address,
                                                     (    left.did       =right.did   
													  and left.prim_range=right.prim_range
													  and left.prim_name =right.prim_name
													  and left.sec_range =right.sec_range
													  and left.zip       =right.zip
													  //and left.predir    =right.predir
													  //and left.postdir   =right.postdir
													 ),
													 determine_current_or_historical_address(left,right),
													 left outer, keep(1), local
												   );

//output(infutor_current_or_historical_determination(current_addr_ind='H' and did_ct>1),,'out::fds::historical_addresses',__compressed__,overwrite);

//We want to keep only the Current or Undetermined addresses
//export Join_to_Address_Indicators := (infutor_current_or_historical_determination(current_addr_ind='C' or trim(current_addr_ind)='' or did_ct=1))+infutor_unique_no_did;
export Join_to_Address_Indicators := (infutor_current_or_historical_determination(~(current_addr_ind='H' and did_ct>1)))+infutor_unique_no_did;