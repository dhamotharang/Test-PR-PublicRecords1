IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare();

thebest := SORT(doxie_cbrs.getBaseRecs,company_name);
            
EXPORT name_variation_base_records := CHOOSEN(thebest,Max_NameVariations_val);

