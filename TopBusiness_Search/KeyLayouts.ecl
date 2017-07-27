import TopBusiness;

export KeyLayouts := module

	export Address := record
		TopBusiness.Layout_NAPs.Linked.state;
		TopBusiness.Layout_NAPs.Linked.zip;
		TopBusiness.Layout_NAPs.Linked.prim_name;
		boolean core;
		TopBusiness.Layout_NAPs.Linked.prim_range;
		TopBusiness.Layout_NAPs.Linked.sec_range;
		TopBusiness.Layout_NAPs.Linked.bid;
	end;
	
	export CompanyName := record
		string10  ph_phrase;
		string120 phrase;
		boolean core;
		TopBusiness.Layout_NAPs.Linked.state;
		TopBusiness.Layout_NAPs.Linked.zip;
		TopBusiness.Layout_NAPs.Linked.company_name;
		TopBusiness.Layout_NAPs.Linked.bid;
	end;
	
	export FEIN := record
		TopBusiness.Layout_FEINs.Linked.fein;
		boolean core;
		TopBusiness.Layout_FEINs.Linked.bid;
	end;
	
	export LLID9 := record
		TopBusiness.Layout_LLID.Linked.llid9;
		boolean core;
		TopBusiness.Layout_LLID.Linked.bid;
		TopBusiness.Layout_LLID.Linked.brid;
		TopBusiness.Layout_LLID.Linked.blid;
	end;
	
	export LLID12 := record
		TopBusiness.Layout_LLID.Linked.llid12;
		boolean core;
		TopBusiness.Layout_LLID.Linked.bid;
		TopBusiness.Layout_LLID.Linked.brid;
		TopBusiness.Layout_LLID.Linked.blid;
	end;
	
	export PhoneNumber := record
		TopBusiness.Layout_NAPs.Linked.phone;
		boolean core;
		TopBusiness.Layout_NAPs.Linked.bid;
	end;
	
	export URL := record
		TopBusiness.Layout_URLs.Linked.cleanurl;
		boolean core;
		TopBusiness.Layout_URLs.Linked.url;
		TopBusiness.Layout_URLs.Linked.bid;
	end;

end;
