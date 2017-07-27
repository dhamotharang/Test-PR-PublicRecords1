import SexOffender, SexOffender_Services, doxie, fcra;

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

// NOTE: function is not "batch-safe": if multiple DIDs ever going to be passed as an input,
// then correction records from the FlagFile should be checked for each DID individually.
// Right now there's no need to account for that.

// NOTE: functionality implemented for stand-alone services applies certain restrictions,
// whereas FCRA data service is supposed to return all raw data.
// I'd like to re-use as much of the existing code as possible, blank application type
// should ensure that no records are filtered out in GetRawOffenders.
app_type := '';

// IMPORTANT: if raw functionality is modified in the future to include other restrictions,
// then fetching raw data should be implemented here explicitly.

EXPORT _SO_data (dataset (doxie.layout_references) dids, 
                          dataset (fcra.Layout_override_flag) flag_file
                          // integer nss = nss_const.doNothing
                          ) := MODULE

  dids_only := project (dids, SexOffender_Services.layouts.search_did);
  ids := SexOffender_Services.Raw.byDIDs (dids_only, isFCRA);

  raw_offenders := SexOffender_Services.Raw.GetRawOffenders (ids, app_type, isFCRA, flag_file);
  // slim down (resulting record structure is not exported)
  export so_main := project (raw_offenders, recordof(SexOffender.key_SexOffender_SPK(true)));

  spk_only := dedup (project (so_main, SexOffender_Services.Layouts.search), seisint_primary_key, all);
  export so_offenses := project(SexOffender_Services.Raw.GetRawOffenses (spk_only, isFCRA, flag_file), recordof(SexOffender.key_sexoffender_offenses(true)));

END;   


