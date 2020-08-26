IMPORT doxie, business_header;

EXPORT phone_variations_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

thebest := SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(Include_PhoneVariations_val AND phone <> ''),phone);

SHARED deduped_thebest := DEDUP(thebest,phone_source_id);

doxie_cbrs.mac_Selection_Declare()
            
EXPORT records := TABLE(CHOOSEN(deduped_thebest,Max_PhoneVariations_val),{phone,phone_source_id});
EXPORT records_count := COUNT(deduped_thebest);

END;
