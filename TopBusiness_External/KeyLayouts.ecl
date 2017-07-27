export KeyLayouts := module

	export Source := record
		Layouts.Source.source;
		Layouts.Source.source_docid;
		Layouts.Source.source_party;
		Layouts.Source.bid;
	end;

	export Address := record
		Layouts.Address.zip;
		Layouts.Address.prim_name;
		Layouts.Address.prim_range;
		Layouts.Address.fein;
		Layouts.Address.phone;
		Layouts.Address.company_name;
		Layouts.Address.bid;
	end;

	export FEIN := record
		Layouts.FEIN.fein;
		Layouts.FEIN.phone;
		Layouts.FEIN.company_name;
		Layouts.FEIN.bid;
	end;

	export Phone := record
		Layouts.Phone.phone;
		Layouts.Phone.company_name;
		Layouts.Phone.bid;
	end;

end;
