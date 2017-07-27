import dnb_feinv2;
export layout_dnb_fein_address :=
	record
		dnb_feinv2.layout_DNB_fein_base_main.orig_address1;
		dnb_feinv2.layout_DNB_fein_base_main.orig_address2;
		dnb_feinv2.layout_DNB_fein_base_main.orig_city;
		dnb_feinv2.layout_DNB_fein_base_main.orig_state;
		dnb_feinv2.layout_DNB_fein_base_main.orig_zip5;
		dnb_feinv2.layout_DNB_fein_base_main.orig_zip4;
		dnb_feinv2.layout_DNB_fein_base_main.orig_county;
	end;
	