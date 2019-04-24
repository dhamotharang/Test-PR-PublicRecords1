IMPORT Doxie, Utilfile, ut, progressive_phone;

EXPORT UtilityConnect(UNSIGNED6 in_did,DATASET(doxie.Layout_Rollup.AddrRec) addrRecs, BOOLEAN isGLB_Ok = false) := FUNCTION

	IDs := SET(Utilfile.Key_DID(KEYED(s_did=in_did)),ID);

	progressive_phone.layout_addr_connect_date addConnectDate(doxie.Layout_Rollup.AddrRec L,UtilFile.Key_Address R) := TRANSFORM
		BOOLEAN hasID := (R.ID != '');
		SELF.connect_date := IF(hasID,(UNSIGNED4)R.connect_date,0);
		SELF.util_type := IF(hasID,UtilFile.Util_Type_Desc(R.util_type),'');
		self.address_feedback := [],
		self.did := in_did,
		SELF := L;
	END;
	
    utility_flag := Doxie.Compliance.isUtilityRestricted(ut.IndustryClass.Get());
// stlf RQ-12930 - GLB check added as a passed paramenter to the function above.
	RETURN JOIN(addrRecs,UtilFile.Key_Address,
		 (~utility_flag)
		 AND isGLB_Ok
		 AND LEFT.zip!='' AND LEFT.prim_name!='' AND	KEYED(LEFT.prim_name=RIGHT.prim_name) 
		 AND KEYED(LEFT.st=RIGHT.st) AND	KEYED(LEFT.zip=RIGHT.zip) 
		 AND KEYED(LEFT.prim_range=RIGHT.prim_range) AND KEYED(LEFT.sec_range=RIGHT.sec_range) 
		 AND RIGHT.addr_type='S'// addr type = 'S' means that this is the service address
		 AND RIGHT.ID IN IDs,
		 addConnectDate(LEFT,RIGHT),LEFT OUTER,ATMOST(200),KEEP(1));

END;
