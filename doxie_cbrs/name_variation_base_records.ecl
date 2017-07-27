import doxie, business_header;
doxie_cbrs.mac_Selection_Declare();

thebest := sort(doxie_cbrs.getBaseRecs,company_name);
						
export name_variation_base_records := choosen(thebest,Max_NameVariations_val);

