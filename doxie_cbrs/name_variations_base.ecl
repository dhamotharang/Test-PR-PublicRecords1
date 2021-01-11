IMPORT doxie_cbrs, doxie;
doxie_cbrs.mac_Selection_Declare()

EXPORT name_variations_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  thebest := SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(Include_NameVariations_val), 
      company_clean,-LENGTH(TRIM(company_name, LEFT, RIGHT)), company_name);

  SHARED deduped_thebest := DEDUP(thebest, name_source_id);

  EXPORT records := PROJECT(
    CHOOSEN(SORT(deduped_thebest, company_name), Max_NameVariations_val),
    doxie_cbrs.layouts.name_variation_record);
    
  EXPORT records_count := COUNT(deduped_thebest);

END;
            
