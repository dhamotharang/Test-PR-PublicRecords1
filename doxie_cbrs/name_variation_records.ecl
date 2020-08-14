IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

EXPORT name_variation_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

df := doxie_cbrs.best_rest(bdids)
  (Include_NameVariations_val AND isNMV);

RETURN SORT(df,company_name);
END;
