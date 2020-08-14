IMPORT doxie, business_header, STD;
doxie_cbrs.mac_Selection_Declare()

base_recs := doxie_cbrs.getBaseRecs(prim_name <> '' OR prim_range <> '' OR zip <> '');

base_recs1 := base_recs(STD.STR.Find(prim_name, '* *', 1) < 1);

thebest := SORT(base_recs1,state,zip,prim_name,prim_range,sec_range);
            
EXPORT address_variation_base_records := CHOOSEN(thebest,Max_AddressVariations_val);
