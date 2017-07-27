import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

thebest := sort(doxie_cbrs.getBaseRecs(phone <> ''),phone);
						
export phone_variation_base_records := choosen(thebest,Max_PhoneVariations_val);
