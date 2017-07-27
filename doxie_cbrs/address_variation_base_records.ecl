import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

base_recs := doxie_cbrs.getBaseRecs(prim_name <> '' or prim_range <> '' or zip <> '');

base_recs1 := base_recs(Stringlib.Stringfind(prim_name, '* *', 1) < 1);

thebest := sort(base_recs1,state,zip,prim_name,prim_range,sec_range);
						
export address_variation_base_records := choosen(thebest,Max_AddressVariations_val);
