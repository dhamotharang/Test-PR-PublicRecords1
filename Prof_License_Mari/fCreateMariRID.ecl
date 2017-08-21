import ut;

export fCreateMariRID(int0)
	:=
functionmacro

Layout_RID := record
recordof(int0);
unsigned6 tmp_mari_rid;
end;

f_int0 := sort(distribute(int0, hash(std_source_upd)), std_source_upd, local);

Layout_RID	 t_reformatRID(recordof(f_int0) le) := transform
tmp_fullname := trim(le.fname + ''+ le.lname);
self.tmp_mari_rid := if(le.std_source_upd = 'S0900', HASH32(le.std_source_upd + ','+ le.nmls_id + ',' + trim(le.license_state) +','+ trim(le.std_license_desc)),
												if(le.std_source_upd != 'S0900' and le.license_nbr <> '' and le.license_nbr <> 'NR', HASH32(le.std_source_upd + ','+ trim(le.license_nbr) + ','+ trim(le.license_state) +','+ trim(le.std_license_desc)),
													if(le.std_source_upd != 'S0900' and (trim(le.license_nbr) = '' OR trim(le.license_nbr) = 'NR'), HASH32(le.std_source_upd +','+ 
													                                                                                                trim(le.license_state) +','+ trim(le.std_license_desc) +','+
									 																																																					trim(le.NAME_ORG) +','+	
																																																														trim(le.BUS_PRIM_RANGE) +','+	
																																																														trim(le.BUS_PREDIR) +','+	
																																																														trim(le.BUS_PRIM_NAME) +','+
																																																														trim(le.BUS_ADDR_SUFFIX) +','+ 
																																																														trim(le.BUS_POSTDIR) +','+	
																																																														trim(le.BUS_SEC_RANGE) +','+ 
																																																														trim(le.BUS_STATE) +','+ trim(le.BUS_ZIP5)),
																																																					0)));
	SELF := le;
	
	end;
																																		
p_Mari_RID := project(f_int0,t_reformatRID(left));

return p_Mari_RID;

endmacro;																																		
	