doxie_cbrs.mac_Selection_Declare()

export header_records_raw(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION 

artificial_limit := 200; // segmentation faults if this gets too big?

recs := SORT(doxie_cbrs.fn_getBaseRecs(bdids,false),company_name,state,zip,prim_name,prim_range,sec_range,phone,fein);

nap_glob := MAP(Include_Finder or Include_NameVariations_val =>recs
				,Include_AddressVariations_val => recs(prim_name <> '' or prim_range <> '' or zip <> '')
				,Include_PhoneVariations_val => recs(phone <> '')
				,Include_CompanyIDNumbers_val => recs(fein <> '')
				,recs);
				
return choosen(dedup(nap_glob,company_name,state,zip,prim_name,prim_range,sec_range,phone,fein),artificial_limit);
END;
