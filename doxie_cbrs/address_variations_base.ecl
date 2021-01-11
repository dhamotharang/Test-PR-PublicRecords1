IMPORT doxie_cbrs, doxie, business_header, STD;


EXPORT address_variations_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  doxie_cbrs.mac_Selection_Declare();

  base_recs := doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(Include_AddressVariations_val AND (prim_name <> '' OR prim_range <> '' OR zip <> '' OR (state <> '' AND city <> '')));

  base_recs1 := base_recs(STD.STR.Find(prim_name, '* *', 1) < 1);

  rolled_addresses := ROLLUP(
    SORT(base_recs1,addr_source_id,-county_name,-msaDesc,-dt_last_seen,-dt_first_seen,RECORD),
    LEFT.addr_source_id = RIGHT.addr_source_id,
    TRANSFORM(RECORDOF(base_recs1),
      SELF.dt_last_seen := IF(LEFT.dt_last_seen > RIGHT.dt_last_seen,LEFT.dt_last_seen,RIGHT.dt_last_seen),
      SELF.dt_first_seen := IF(LEFT.dt_first_seen != 0 AND LEFT.dt_first_seen < RIGHT.dt_first_seen,LEFT.dt_first_seen,RIGHT.dt_first_seen),
      SELF := LEFT));

  /* Mod for bug 108845 in which a customer search on a company name and state (SWISS POST INTERNATIONAL and NJ),
    The customer had a "hit" on the search, but there wasn't any address with the state of NJ in the results.
    The reason being is that they matched on a D&B address, but since Risk can only display city and state info
    from D&B the record is dropped from the report. This change will keep any address with only a city/state if
    there isn't already an address with street parts with that city/state . */
  PrimAddrRecs := rolled_addresses(prim_name != '' OR prim_range != '' OR zip != '');

  // Keep and address that doesn't match on city/state with address that have street parts
  KeepStateOnly := JOIN (PrimAddrRecs,rolled_addresses,
    LEFT.state = RIGHT.state AND
    LEFT.city = RIGHT.city,
    TRANSFORM(RIGHT),
    RIGHT ONLY);

  SHARED final_addresses := (PrimAddrRecs + KeepStateOnly);

  doxie_cbrs.mac_Selection_Declare();
            
  EXPORT records := PROJECT(
    CHOOSEN(final_addresses,Max_AddressVariations_val),
    doxie_cbrs.layouts.addr_variation_record);

  EXPORT records_count := COUNT(final_addresses);

END;
            
