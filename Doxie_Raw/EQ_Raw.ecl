import ut,doxie, header, Header_Quick;
export Eq_raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);
		
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

ds_eq := Doxie_Raw.ViewSourceRid(rids_eq_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['EQ'],,,,,,,appType);


header.Layout_Eq_src_dates getEQ(header.Layout_Eq_src_dates L) := transform
	self := L;
end;

out_file := normalize(ds_eq,left.eq_child,getEQ(right));

return if(~ut.glb_ok(glb_purpose),dataset([],header.Layout_EQ_src_dates),out_file);

END;