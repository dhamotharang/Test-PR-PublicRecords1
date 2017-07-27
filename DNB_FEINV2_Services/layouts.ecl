import dnb_feinv2;
export layouts :=
	module
		export layout_flat :=
			record
				dnb_feinv2.layout_DNB_fein_base_main.tmsid;
				boolean isDeepDive;
				unsigned2 penalt;
				dnb_feinv2.layout_DNB_fein_base_main.orig_company_name;
				dnb_feinv2.layout_DNB_fein_base_main.date_last_seen;
				dnb_feinv2.layout_DNB_fein_base_main.orig_address1;
				dnb_feinv2.layout_DNB_fein_base_main.orig_address2;
				dnb_feinv2.layout_DNB_fein_base_main.orig_city;
				dnb_feinv2.layout_DNB_fein_base_main.orig_state;
				dnb_feinv2.layout_DNB_fein_base_main.orig_zip5;
				dnb_feinv2.layout_DNB_fein_base_main.orig_zip4;
				dnb_feinv2.layout_DNB_fein_base_main.orig_county;
				dnb_feinv2.layout_DNB_fein_base_main.fein;
				dnb_feinv2.layout_DNB_fein_base_main.company_name;
				dnb_feinv2.layout_DNB_fein_base_main.trade_style;
				dnb_feinv2.layout_DNB_fein_base_main.sic_code;
				dnb_feinv2.layout_DNB_fein_base_main.Telephone_Number;
				dnb_feinv2.layout_DNB_fein_base_main.Top_Contact_Name;
				dnb_feinv2.layout_DNB_fein_base_main.Top_Contact_Title;
			end;
		export layout_address :=
			record
				layout_flat.orig_address1;
				layout_flat.orig_address2;
				layout_flat.orig_city;
				layout_flat.orig_state;
				layout_flat.orig_zip5;
				layout_flat.orig_zip4;
				layout_flat.orig_county;
			end;
		export layout_rollup_address :=
			record
				layout_flat.tmsid;
				layout_flat.isDeepDive;
				layout_flat.penalt;
				layout_flat.orig_company_name;
				layout_flat.date_last_seen;
				layout_flat.fein;
				dataset(layout_address) addresses{maxcount(dnb_feinv2_services.constants.ADDRESSES_PER_PARTY)};
				layout_flat.company_name;
				layout_flat.trade_style;
				layout_flat.sic_code;
				layout_flat.Telephone_Number;
				layout_flat.Top_Contact_Name;
				layout_flat.Top_Contact_Title;
			end;
		export layout_party :=
			record
				layout_flat.orig_company_name;
				dataset(layout_address) addresses{maxcount(dnb_feinv2_services.constants.ADDRESSES_PER_PARTY)};
				layout_flat.company_name;
				layout_flat.trade_style;
				layout_flat.sic_code;
				layout_flat.Telephone_Number;
				layout_flat.Top_Contact_Name;
				layout_flat.Top_Contact_Title;
			end;
		export layout_rollup :=
			record
				layout_flat.tmsid;
				layout_flat.isDeepDive;
				layout_flat.penalt;
				dataset(layout_party) parties{maxcount(dnb_feinv2_services.constants.PARTIES_PER_TMSID)};
				layout_flat.fein;
			end;
	end;
	