abd := doxie_cbrs.Associated_Business_bdids(true);  //keep all to find best info, limit before output

assoc_rec := doxie_cbrs.layout_Association_type;

prep_rec := record
	unsigned6 bdid;
	boolean isInOAA;
	doxie_cbrs.layout_relative_booleans;
	// dataset(assoc_rec) association_children;
end;

translate_type(abd d) := 
	dataset([	
		{if(d.corp_charter_number,'Corporate Charter Number','')},
		{if(d.business_registration,'Business Registration','')},
		{if(d.bankruptcy_filing,'Bankruptcy Filing','')},
		{if(d.edgar_cik,'Edgar Cik','')},
		{if(d.duns_number OR d.duns_tree,'DUNS Number','')},
		{if(d.abi_number OR d.abi_hierarchy,'American Business Identifier','')},
		{if(d.dca_company_number,'Directory of Corporate Affiliations Number','')},
		{if(d.dca_hierarchy,'Directory of Corporate Affiliations Hierarchy','')},
		{if(d.name,'Name','')},
		{if(d.name_address,'Name Address','')},
		{if(d.name_phone,'Name Phone','')},
		{if(d.gong_group,'Phone Listing Group','')},
		{if(d.ucc_filing,'UCC Filing','')},
		{if(d.fein_m,'FEIN','')},
		{if(d.phone_m,'Phone Number','')},
		{if(d.addr,'Address','')},
		{if(d.mail_addr,'Mailing Address','')},
		{if(d.rel_group,'Relative Group','')}
				], assoc_rec)(assoc_type <> '');

prep_rec tra(abd l) := transform
	// self.association_children := translate_type(l);
	self.isInOAA := doxie_cbrs.is_InOAA(l);
	self := l;
end;

slim := project(abd, tra(left));

export Associated_Business_records_types := slim;