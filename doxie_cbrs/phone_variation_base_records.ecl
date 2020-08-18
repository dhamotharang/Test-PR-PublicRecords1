IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

thebest := SORT(doxie_cbrs.getBaseRecs(phone <> ''),phone);
            
EXPORT phone_variation_base_records := CHOOSEN(thebest,Max_PhoneVariations_val);
