

first_data.Layout_FDS t_derive_blank_hhids(first_data.Layout_FDS le) := transform
 
 
 unsigned6 v_hash_addr := hash64(le.house_nbr
                                +le.predir
								+le.str_suffix
								+le.postdir
								+le.str_name
								+le.zip
								+le.unit_type
								+le.unit_nbr
								);

 boolean v_true_hhid := trim(le.hhid)<>'';
 
 string43 v_1 := if(v_true_hhid,      '1|'+stringlib.stringrepad(trim(le.last_name,all),20)+'|'+intformat(v_hash_addr,20,1),'');
 string43 v_2 := if(v_true_hhid=false,'2|'+stringlib.stringrepad(trim(le.last_name,all),20)+'|'+intformat(v_hash_addr,20,1),'');

 self.hhid := if(v_1<>'',v_1,v_2);
 self      := le;
 
end;

export Derived_HHIDs := project(first_data.Rent_Own_Score,t_derive_blank_hhids(left));