import std;
office_in := files.ds_office;
layout_raw := layout_office;
layout_expanded := record(layout_raw)
	string institution_id;
end;

layout_expanded expand_office(office_in l) := Transform
	self.institution_id := std.str.splitwords(l.summary.institution.href,'/')[3];
	
	
	self := l;
End;

EXPORT file_office_flat := Project(office_in, expand_office(left));