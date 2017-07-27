export FileSearchAutoKey := function

	base := courtlink.files().base.qa;
	
	CourtLink.Layouts.keybuild	trfkeybuild(base l)	:=	transform
		self	:=	l;		
	end;
		
	akds := project(base,trfkeybuild(left));
	
	return akds;
	
end;	