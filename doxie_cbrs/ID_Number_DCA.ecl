export ID_Number_DCA(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

dr := dedup(doxie_cbrs.DCA_records_raw(bdids),bdid,root,sub,all);

rec := record
	dr.bdid;
	dataset(doxie_cbrs.layout_ID_DCA_children) DCA_children;
end;

rec prep(dr l) := transform
	self.DCA_children := dataset([{l.root, l.sub}], doxie_cbrs.layout_ID_DCA_children);
	self := l;
end;

drs := sort(project(dr, prep(left)), bdid);

rec rollem(drs l, drs r) := transform
	self.DCA_children := l.DCA_children + r.DCA_children;
	self := l;
end;

return rollup(drs, left.bdid = right.bdid, rollem(left, right));
END;