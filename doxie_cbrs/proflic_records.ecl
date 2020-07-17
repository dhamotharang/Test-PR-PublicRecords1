import doxie, doxie_cbrs, Prof_LicenseV2, suppress, ut;
doxie_cbrs.mac_Selection_Declare()

export proflic_records(dataset(doxie_cbrs.layout_references) bdids,
                       doxie.IDataAccess mod_access) := FUNCTION

subadd := doxie_Cbrs.best_address_target(bdids,mod_access)(Include_ProfessionalLicenses_val);
kap := Prof_LicenseV2.Key_Addr_Proflic;

kap keepk(kap r) := transform
	self := r;
end;

sn := join(subadd, kap,
					 LEFT.prim_name<>'' AND
					 keyed(left.prim_name = right.prim_name) and
					 keyed(left.prim_range = right.prim_range) and
					 keyed(left.zip = right.zip) and
					 ut.NNEQ(left.sec_range, right.sec_range),
					 keepk(right));

sn_suppressed := Suppress.MAC_SuppressSource(sn, mod_access);
Doxie.compliance.logSoldToSources(sn_suppressed, mod_access);

doxie_Cbrs.mac_mask_ssn(sn_suppressed, msk1, best_ssn)

srtd := sort(msk1, prolic_key, prim_range, prim_name, zip);

srtd rollem(srtd l, srtd r) := transform
	self.date_first_seen := if((integer)l.date_first_seen > 0 and l.date_first_seen < r.date_first_seen, l.date_first_seen, r.date_first_seen);
	self.date_last_seen := if(l.date_last_seen > r.date_last_seen, l.date_last_seen, r.date_last_seen);
	self := l;
end;

rlld := rollup(srtd,
							 left.prolic_key = right.prolic_key and
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.zip = right.zip,
							 rollem(left, right));


return sort(rlld, lname, fname, mname);
END;