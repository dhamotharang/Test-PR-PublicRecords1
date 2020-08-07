EXPORT mac_hasBBB(infile, outfile, bdids) := MACRO

BBBs := DEDUP(table(doxie_cbrs.BBB_records(bdids)(bdid >0), {bdid}), ALL);

infile bbbtra(infile l, BBBs r) := TRANSFORM
  SELF.hasBBB := r.bdid > 0;
  SELF := l;
END;

midfile := JOIN(infile, BBBs, LEFT.bdid = RIGHT.bdid, bbbtra(LEFT, RIGHT), LEFT OUTER, lookup);

BNMs := DEDUP(table(doxie_cbrs.BBB_NM_records(bdids)(bdid >0), {bdid}), ALL);

infile bnmtra(midfile l, BNMs r) := TRANSFORM
  SELF.hasBBB_NM := r.bdid > 0;
  SELF := l;
END;

outfile := JOIN(midfile, BNMs, 
  LEFT.bdid = RIGHT.bdid, 
  bnmtra(LEFT, RIGHT), 
  LEFT OUTER, lookup);


ENDMACRO;
