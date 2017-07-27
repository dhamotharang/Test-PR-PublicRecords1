import doxie_cbrs, Business_Header_SS, ut, drivers, AutoStandardI;

export getBaseRecs
	(dataset(doxie_cbrs.layout_references) precs,
	 unsigned3 dateVal = 0,
   unsigned1 dppa_purpose = 0,
	 unsigned1 glb_purpose = 0
	) := 
FUNCTION

bhl := Business_Header.Layout_Business_Header_Base;
bhk := Business_Header_SS.Key_BH_BDID_pl;

bhl tGetBaseRecs(bhk r) := TRANSFORM
	SELF := r;
	self.match_company_name := '';
	self.match_branch_unit := '';
END;

base_recs := JOIN(precs, bhk,
				LEFT.bdid = RIGHT.bdid and
				(not right.dppa or (ut.dppa_ok(dppa_purpose) AND drivers.state_dppa_ok(right.vendor_st,dppa_purpose,,RIGHT.source))) AND
        ut.PermissionTools.glb.SrcOk(glb_purpose,right.source),
				tGetBaseRecs(RIGHT),
				limit(10000, skip));
				
return base_recs;

END;