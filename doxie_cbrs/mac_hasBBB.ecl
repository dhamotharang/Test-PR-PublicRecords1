export mac_hasBBB(infile, outfile, bdids) := macro

BBBs := dedup(table(doxie_cbrs.BBB_records(bdids)(bdid >0), {bdid}), all);

infile bbbtra(infile l, BBBs r) := transform
	self.hasBBB := r.bdid > 0;
	self := l;
end;

midfile := join(infile, BBBs, left.bdid = right.bdid, bbbtra(left, right), left outer, lookup);

BNMs := dedup(table(doxie_cbrs.BBB_NM_records(bdids)(bdid >0), {bdid}), all);

infile bnmtra(midfile l, BNMs r) := transform
	self.hasBBB_NM := r.bdid > 0;
	self := l;
end;

outfile := join(midfile, BNMs, left.bdid = right.bdid, bnmtra(left, right), left outer, lookup);


endmacro;