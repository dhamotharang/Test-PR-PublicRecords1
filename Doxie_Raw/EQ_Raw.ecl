import ut, doxie, Doxie_Raw, header, Header_Quick;

export Eq_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);
 		
//138824: get the rids from quick header too.
quickHeader_ := LIMIT(join(dids(did>0),Header_Quick.Key_DID,
                          (KEYED(left.did = right.did)) and 
	                        (right.src = 'QH' OR right.src = 'WH')and 
										       right.rec_type='1' and 
										       right.dt_last_seen > 0 ),
											ut.limits.DEFAULT,SKIP);
 
quickHeader := dedup(sort(quickHeader_, rid), rid);

rids_qh_wh 		:= project(quickHeader,Doxie.Layout_ref_rid);
rids_eq    		:= project(myHeader, Doxie.Layout_ref_rid);
rids_eq_dedup := dedup(sort((rids_eq ), rid), rid)  + rids_qh_wh ;

ds_eq := Doxie_Raw.ViewSourceRid(rids_eq_dedup, mod_access, ['EQ']);


header.Layout_Eq_src_dates getEQ(header.Layout_Eq_src_dates L) := transform
	self := L;
end;

out_file := normalize(ds_eq,left.eq_child,getEQ(right));

return if(~mod_access.isValidGLB(),dataset([],header.Layout_EQ_src_dates),out_file);

END;