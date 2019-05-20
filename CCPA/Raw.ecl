import $, doxie, one_click_data, batchservices, suppress, Prof_LicenseV2;

// Fake source IDs:
// 1 -- prof license;
// 2 -- one click

export Raw := module

  export getProfLic(dataset($.Layouts.l_input) dids, doxie.IDataAccess mod_access) := function

    ds_prolic_data := JOIN(dids, Prof_LicenseV2.Key_Proflic_Did(),
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM($.Layouts.l_out_rec,
          SELF.did := LEFT.did,
          SELF.global_sid := IF (RIGHT.did != 0, 1, RIGHT.global_sid), // fabricate source IDs
          SELF.record_sid := RIGHT.record_sid,
          SELF.payload := RIGHT.license_type;
          SELF := LEFT),
        LEFT OUTER, KEEP(10), LIMIT(0));

    ds_prolic_suppressed := suppress.MAC_SuppressSource (ds_prolic_data, mod_access);

    doxie.compliance.logSoldToSources(ds_prolic_suppressed, mod_access);
    return ds_prolic_suppressed;
  end;

  export getOneClick(dataset($.Layouts.l_input) dids, doxie.IDataAccess mod_access) := function

    ds := JOIN(dids, one_click_data.keys().did.qa,
      KEYED(LEFT.did = RIGHT.did),
      TRANSFORM($.Layouts.l_out_rec,
        SELF.did := LEFT.did,
        SELF.global_sid := IF (RIGHT.did != 0, 2, RIGHT.global_sid), // fabricate source IDs
        SELF.record_sid := RIGHT.record_sid,
        SELF.payload := RIGHT.rawfields.firstname + RIGHT.rawfields.lastname;
        SELF := LEFT),
        LEFT OUTER, KEEP(10), LIMIT(0));

    ds_oneclick_suppressed := Suppress.MAC_SuppressSource(ds, mod_access);
    doxie.compliance.logSoldToSources(ds_oneclick_suppressed, mod_access);
    return ds_oneclick_suppressed;

  end;

end;
