import business_header_ss, ut, header_slimsort,didville, business_header, did_add;

cp := bdid_regression.common_prep(rid % 10 = 0);

//format for doxie mac
business_header_ss.Layout_BDID_InBatch formac(bdid_regression.layout_common l) := transform
	self.seq := l.rid;
	self.company_name := l.name;
	self := l;
end;

common_formac := project(cp, formac(left));

// BDID THRU ROXIE
business_header.mac_BDID_Roxie
	(common_formac, common_bdids)
	
// back to desired layout
bdid_regression.Layout_Common goback(bdid_regression.layout_common l, common_bdids r) := transform
	self.bdid := r.bdid;
	self.bdid_score := r.score;
	self := l;
end;
	
wscores := join(cp, common_bdids, left.rid = right.seq, goback(left, right), lookup);	
	
export Common_BDID_Roxie := wscores;
