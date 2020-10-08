IMPORT doxie, doxie_cbrs, Prof_LicenseV2, suppress, ut;
doxie_cbrs.mac_Selection_Declare()

EXPORT proflic_records(DATASET(doxie_cbrs.layout_references) bdids,
                       doxie.IDataAccess mod_access) := FUNCTION

subadd := doxie_Cbrs.best_address_target(bdids,mod_access)(Include_ProfessionalLicenses_val);
kap := Prof_LicenseV2.Key_Addr_Proflic;

kap keepk(kap r) := TRANSFORM
  SELF := r;
END;

sn := JOIN(subadd, kap,
           LEFT.prim_name<>'' AND
           KEYED(LEFT.prim_name = RIGHT.prim_name) AND
           KEYED(LEFT.prim_range = RIGHT.prim_range) AND
           KEYED(LEFT.zip = RIGHT.zip) AND
           ut.NNEQ(LEFT.sec_range, RIGHT.sec_range),
           keepk(RIGHT));

sn_suppressed := Suppress.MAC_SuppressSource(sn, mod_access);
Doxie.compliance.logSoldToSources(sn_suppressed, mod_access);

doxie_Cbrs.mac_mask_ssn(sn_suppressed, msk1, best_ssn)

srtd := SORT(msk1, prolic_key, prim_range, prim_name, zip);

srtd rollem(srtd l, srtd r) := TRANSFORM
  SELF.date_first_seen := IF((INTEGER)l.date_first_seen > 0 AND l.date_first_seen < r.date_first_seen, l.date_first_seen, r.date_first_seen);
  SELF.date_last_seen := IF(l.date_last_seen > r.date_last_seen, l.date_last_seen, r.date_last_seen);
  SELF := l;
END;

rlld := ROLLUP(srtd,
               LEFT.prolic_key = RIGHT.prolic_key AND
               LEFT.prim_range = RIGHT.prim_range AND
               LEFT.prim_name = RIGHT.prim_name AND
               LEFT.zip = RIGHT.zip,
               rollem(LEFT, RIGHT));


RETURN SORT(rlld, lname, fname, mname);
END;
