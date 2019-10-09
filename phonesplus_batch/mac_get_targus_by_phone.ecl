import doxie;

export mac_get_targus_by_phone(f_in, f_out, targus_cfg, use_tg_flag) := macro

#uniquename(targus_out_rec)			 			
%targus_out_rec% := record						
	unsigned6 seq;
	string20 acctno;
	dataset(doxie.layout_pp_raw_common) targus_out;						
end;	

#uniquename(gw_mod_access)
%gw_mod_access% := gateway.IParam.GetGatewayModAccess(1, 1); // <-- doing this to keep it backwards compatible, but is this ok?
			
#uniquename(get_targus_out_raw)			
%targus_out_rec% %get_targus_out_raw%(f_in l) := transform
   self.targus_out := doxie.MAC_Get_GLB_DPPA_Targus(true,
                                                    l.phoneno, '', '', '',
                                                    '', '', '', '',
				                            				        '', '', '', '', '',
								                                    '', '', %gw_mod_access%,
								                                    10, targus_cfg, '');
	 self := l;																									
end;			
			
#uniquename(f_out_raw)			
%f_out_raw% := project(f_in, %get_targus_out_raw%(left));

#uniquename(norm_targus_out)
phonesplus_batch.layout_phonesplus_reverse_common %norm_targus_out%(%f_out_raw% l, 
                                                                    doxie.layout_pp_raw_common r) := transform
	self := r;
	self := l;
end;

f_out := if(~use_tg_flag, dataset([], phonesplus_batch.layout_phonesplus_reverse_common),
            normalize(%f_out_raw%, left.targus_out, %norm_targus_out%(left, right)));
 
endmacro;