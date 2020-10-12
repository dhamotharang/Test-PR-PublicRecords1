IMPORT BIPV2;
IMPORT BIPV2_Best;
IMPORT STD;

EXPORT In_Locid(
  DATASET(BIPV2_Best.Layouts.Base) ds_best = BIPV2_Best.Files().base.built
) := FUNCTION

  // Stage 1) Normalize address data with locid and proxid info
  layout_normalized := RECORD
    BIPV2_Best.Layouts.linkids;
    BIPV2_Best.Layouts.company_address_case_layout;
  END;

  ds_normalized := NORMALIZE(ds_best(proxid > 0), LEFT.company_address(company_locid > 0), TRANSFORM(layout_normalized,
    SELF := RIGHT;
    SELF := LEFT;
  ));
    
  // Stage 3) Dedup records according to the desired relationship.
  #EXPORTXML(xml_layout, BIPV2_Best.Layouts.linkids);
  #UNIQUENAME(str_fields)
  #SET(str_fields, '')
  #FOR(xml_layout)
    #FOR(Field)
      #APPEND(str_fields, ', ' + %'@label'%)
    #END
  #END

  ds_distributed  := DISTRIBUTE(ds_normalized, HASH(company_locid #EXPAND(%'str_fields'%)));
  ds_sorted       := SORT(ds_distributed, company_locid #EXPAND(%'str_fields'%), LOCAL);
  ds_grouped      := GROUP(ds_sorted, company_locid #EXPAND(%'str_fields'%), LOCAL);

  layout_return := RECORD
    TYPEOF(layout_normalized.company_locid) locid;
    BIPV2_Best.Layouts.linkids;
    TYPEOF(layout_normalized.address_dt_first_seen) dt_first_seen;
    TYPEOF(layout_normalized.address_dt_last_seen) dt_last_seen;
  END;

  RETURN ROLLUP(ds_grouped, GROUP, TRANSFORM(layout_return,
    // Assign date range from valid dates
    SELF.dt_first_seen := MIN(ROWS(LEFT)(STD.Date.IsValidDate(address_dt_first_seen)), address_dt_first_seen);
    SELF.dt_last_seen  := MAX(ROWS(LEFT)(STD.Date.IsValidDate(address_dt_last_seen)), address_dt_last_seen);
    SELF.locid := LEFT.company_locid;
    SELF := LEFT;
  ));

END;