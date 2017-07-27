import dnb_feinv2;
export layout_dnb_fein_rollup :=
	record
		dnb_feinv2.layout_DNB_fein_base_main.tmsid;
		boolean isDeepDive;
		unsigned2 penalt;
		dataset(dnb_feinv2_services.layout_dnb_fein_name_addr) name_addrs{maxcount(10)};
		dnb_feinv2.layout_DNB_fein_base_main.fein;
	end;
	