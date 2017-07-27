import TopBusiness;

export Layouts := module

	export Source := record
		TopBusiness.Layout_Linking.Linked.bid;
		TopBusiness.Layout_Linking.Linked.source;
		TopBusiness.Layout_Linking.Linked.source_docid;
		TopBusiness.Layout_Linking.Linked.source_party;
	end;

	export Address := record
		TopBusiness.Layout_Linking.Linked.bid;
		TopBusiness.Layout_Linking.Linked.company_name;
		TopBusiness.Layout_Linking.Linked.zip;
		TopBusiness.Layout_Linking.Linked.prim_name;
		TopBusiness.Layout_Linking.Linked.prim_range;
		TopBusiness.Layout_Linking.Linked.fein;
		TopBusiness.Layout_Linking.Linked.phone;
	end;

	export FEIN := record
		TopBusiness.Layout_Linking.Linked.bid;
		TopBusiness.Layout_Linking.Linked.company_name;
		TopBusiness.Layout_Linking.Linked.fein;
		TopBusiness.Layout_Linking.Linked.phone;
	end;

	export Phone := record
		TopBusiness.Layout_Linking.Linked.bid;
		TopBusiness.Layout_Linking.Linked.company_name;
		TopBusiness.Layout_Linking.Linked.phone;
	end;

end;
