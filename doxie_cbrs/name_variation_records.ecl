import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

export name_variation_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

df := doxie_cbrs.best_rest(bdids)
	(Include_NameVariations_val and isNMV);

return sort(df,company_name);
END;
