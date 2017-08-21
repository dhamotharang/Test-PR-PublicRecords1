export FileSearchAutoKey := function

	base := courtlink.irs_dummy_litigous_debtors + courtlink.files().base.qa;
	
	filteredBase := base(litigantlabel = 'PLAINTIFF');
	
	CourtLink.Layouts.keybuild	trfkeybuild(base l)	:=	transform
		self	:=	l;		
	end;
		
	akds := project(filteredBase, trfkeybuild(left));
	
	return akds;
	
end;	