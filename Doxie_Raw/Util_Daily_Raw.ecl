import doxie,utilfile,census_data,suppress,ut;

export Util_Daily_Raw(    
						dataset(Doxie.layout_references_hh) dids,
						doxie.IDataAccess mod_access,
						boolean ApplyBpsFilter = false
) :=
FUNCTION
//values used in suppress.MAC_Mask:
ssn_mask_value := mod_access.ssn_mask;
dl_mask_value := mod_access.dl_mask>0;

key_did := utilfile.Key_Util_Daily_Did;

doxie_Raw.Layout_Utility_Raw get_ut(dids le, key_did ri) :=
TRANSFORM
	SELF.includedByHHID := le.includedByHHID;
	SELF := ri;
	SELF.county_name := '';
END;

j := JOIN(dids,key_did,keyed(left.did<>0 AND LEFT.did=RIGHT.s_did) and
														 (not ApplyBpsFilter or 
														  doxie.bpssearch_filter.rec_OK(
																right.ssn, right.lname,right.fname,right.mname,
																right.prim_range,right.prim_name,right.addr_suffix,
																right.sec_range,right.v_city_name,right.zip,right.phone,'',(integer4)right.dob)), 
														 get_ut(LEFT,RIGHT),ATMOST(500));

doxie.MAC_PruneOldSSNs(j, j2, ssn, did);
suppress.MAC_Mask(j2, j2_masked, ssn, drivers_license, true, true);

census_data.MAC_Fips2County_Keyed(j2_masked,st,county[3..5],county_name,f2);

glb_ok := mod_access.isValidGLB ();//Doxie.Compliance.glb_ok(glb_purpose);

return IF(~mod_access.isUtility() and glb_ok,SORT(f2,RECORD));
END;