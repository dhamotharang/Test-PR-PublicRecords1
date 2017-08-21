bh := business_header.File_Business_Header;

bh_fein := bh(fein != 0);

layout_bh_table :=
record
	bh_fein.source;
	integer4 cnt := count(group);
end;

bh_fein_table := table(bh_fein, layout_bh_table, source);

layout_source_description := record
		bh_fein_table.source;
		string50 description;
		bh_fein_table.cnt;
end;

layout_source_description tgetdescrip(bh_fein_table l) := transform
	self.description := business_header.TranslateSource(l.source);
	self	 := l;
end;

bh_descrip := project(bh_fein_table, tgetdescrip(left));

output(bh_descrip, all);