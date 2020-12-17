IMPORT doxie_cbrs, doxie;

doxie_cbrs.mac_Selection_Declare()

EXPORT phone_variations_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  thebest := SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(Include_PhoneVariations_val AND phone <> ''),phone);
  SHARED deduped_thebest := DEDUP(thebest,phone_source_id);

  EXPORT records := PROJECT(
      CHOOSEN(deduped_thebest,Max_PhoneVariations_val), 
    doxie_cbrs.layouts.phone_variation_record);
    
  EXPORT records_count := COUNT(deduped_thebest);

END;
