// A "flat" version of doxie.IDataAccess for use in the libraries.
// -- doesn't have any functions (currently it isn't allowed, but see HPCC-24823);
// -- doesn't have defaults for string fields (a workaround for HPCC-24820)

IMPORT suppress;
IMPORT $;

EXPORT IDataAccessFlat := INTERFACE
  EXPORT unsigned1 unrestricted := 0;
  EXPORT unsigned1 glb := 0;
  EXPORT unsigned1 dppa := 0;
  EXPORT string DataPermissionMask;    //no default
  EXPORT string DataRestrictionMask;    //no default
  EXPORT boolean ln_branded := FALSE;
  EXPORT boolean probation_override := FALSE;
  EXPORT string5 industry_class := 'UTILI';
  EXPORT string32 application_type := '';
  EXPORT boolean no_scrub := FALSE;
  EXPORT unsigned3 date_threshold := 0;
  EXPORT boolean suppress_dmv := TRUE;
  EXPORT unsigned1 reseller_type := 0;
  EXPORT unsigned1 intended_use := 0;
  EXPORT boolean log_record_source := TRUE;
  EXPORT unsigned1 lexid_source_optout := 1;
  EXPORT boolean show_minors := FALSE;
  EXPORT string ssn_mask;    //no default
  EXPORT unsigned1 dl_mask := 1;
  EXPORT unsigned1 dob_mask := suppress.constants.dateMask.ALL;
  EXPORT string transaction_id;    //no default
  EXPORT unsigned6 global_company_id := 0;
END;
