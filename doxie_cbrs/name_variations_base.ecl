IMPORT doxie, business_header;
EXPORT name_variations_base(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  doxie_cbrs.mac_Selection_Declare()

  thebest := SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE)(Include_NameVariations_val), 
      company_clean,-LENGTH(TRIM(company_name, LEFT, RIGHT)), company_name);

  SHARED deduped_thebest := DEDUP(thebest, name_source_id);

  doxie_cbrs.mac_Selection_Declare()

  EXPORT records := TABLE(
    CHOOSEN(SORT(deduped_thebest, company_name), Max_NameVariations_val),
    {company_name,name_source_id});
    
  EXPORT records_count := COUNT(deduped_thebest);

END;
            
