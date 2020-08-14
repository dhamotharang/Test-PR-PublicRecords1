doxie_cbrs.mac_Selection_Declare()

EXPORT header_records_raw(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

artificial_limit := 200; // segmentation faults IF this gets too big?

recs := SORT(doxie_cbrs.fn_getBaseRecs(bdids,FALSE),company_name,state,zip,prim_name,prim_range,sec_range,phone,fein);

nap_glob := MAP(Include_Finder OR Include_NameVariations_val =>recs
        ,Include_AddressVariations_val => recs(prim_name <> '' OR prim_range <> '' OR zip <> '')
        ,Include_PhoneVariations_val => recs(phone <> '')
        ,Include_CompanyIDNumbers_val => recs(fein <> '')
        ,recs);
        
RETURN CHOOSEN(DEDUP(nap_glob,company_name,state,zip,prim_name,prim_range,sec_range,phone,fein),artificial_limit);
END;
