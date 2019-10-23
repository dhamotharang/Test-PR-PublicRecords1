import std;
financialStatement_in := files.ds_financialstatement;
layout_raw := layout_financialStatement;
layout_expanded := record(layout_raw)
	string owner_id := '';
end;

layout_expanded xform_owner(financialStatement_in l) := Transform
	self.owner_id := std.str.splitwords(l.owner_link_href, '/')[3];
	self.periodEnd := RegExReplace('-', l.periodEnd, '');
	self := l;
End;

w_owner_id := project(financialStatement_in, xform_owner(left));
EXPORT file_financialStatement_flat := w_owner_id;