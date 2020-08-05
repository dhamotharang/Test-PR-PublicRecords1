import doxie_cbrs, Business_Header_SS, ut, drivers, AutoStandardI, doxie;

export getBaseRecs
	(dataset(doxie_cbrs.layout_references) precs
	) := 
FUNCTION
mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
bhl := Business_Header.Layout_Business_Header_Base;
bhk := Business_Header_SS.Key_BH_BDID_pl;

bhl tGetBaseRecs(bhk r) := TRANSFORM
	SELF := r;
	self.match_company_name := '';
	self.match_branch_unit := '';
END;

base_recs := JOIN(precs, bhk,
				LEFT.bdid = RIGHT.bdid and
				(not right.dppa or (mod_access.isValidDPPA() AND mod_access.isValidDPPAState(right.vendor_st, , RIGHT.source))) AND
        doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.source) AND
        doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
				tGetBaseRecs(RIGHT),
				limit(10000, skip));
				
return base_recs;

END;
