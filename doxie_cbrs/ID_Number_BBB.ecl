export ID_Number_BBB(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

br := dedup(doxie_cbrs.BBB_records_prs(bdids),bdid,bbb_id,all);

rec := record
	br.bdid;
	dataset(doxie_cbrs.layout_ID_BBB_children) BBB_children;
end;

rec prep(br l) := transform
	self.BBB_children := dataset([{l.bbb_id}], doxie_cbrs.layout_ID_BBB_children);
	self := l;
end;

brs := sort(project(br, prep(left)), bdid);

rec rollem(brs l, brs r) := transform
	self.BBB_children := l.BBB_children + r.BBB_children;//if(r.bdid > 0, r.BBB_children, []);
	self := l;
end;

return rollup(brs, left.bdid = right.bdid, rollem(left, right));
END;