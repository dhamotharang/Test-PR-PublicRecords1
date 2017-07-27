import doxie, business_header;
export name_variations_base(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

thebest := sort(doxie_cbrs.fn_getBaseRecs(bdids,false)(Include_NameVariations_val),company_clean,-length(trim(company_name,left,right)),company_name);

shared deduped_thebest := dedup(thebest,name_source_id);

doxie_cbrs.mac_Selection_Declare()

export records := table(choosen(sort(deduped_thebest,company_name),Max_NameVariations_val),{company_name,name_source_id});
export records_count := count(deduped_thebest);

END;
						