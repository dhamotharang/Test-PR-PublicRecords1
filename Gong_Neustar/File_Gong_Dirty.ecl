
d := distribute(File_Gong_Base);
Layout_Gong_Did trecs(d L) := transform
	self.phone10 := L.phoneno;
	self.listed_name := L.company_name;
	self := L;
end;

export File_Gong_Dirty := project(d,trecs(left));