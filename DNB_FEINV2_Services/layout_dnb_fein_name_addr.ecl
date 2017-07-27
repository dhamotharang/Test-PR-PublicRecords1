import dnb_feinv2;
export layout_dnb_fein_name_addr :=
	record
		dnb_feinv2.layout_DNB_fein_base_main.orig_company_name;
		dataset(dnb_feinv2_services.layout_dnb_fein_address) addresses{maxcount(5)};
	end;
	