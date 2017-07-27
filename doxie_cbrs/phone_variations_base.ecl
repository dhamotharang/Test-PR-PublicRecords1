import doxie, business_header;

export phone_variations_base(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

thebest := sort(doxie_cbrs.fn_getBaseRecs(bdids,false)(Include_PhoneVariations_val and phone <> ''),phone);

shared deduped_thebest := dedup(thebest,phone_source_id);

doxie_cbrs.mac_Selection_Declare()
						
export records := table(choosen(deduped_thebest,Max_PhoneVariations_val),{phone,phone_source_id});
export records_count := count(deduped_thebest);

END;