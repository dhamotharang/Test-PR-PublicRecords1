EXPORT ID_Number_BBB(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

br := DEDUP(doxie_cbrs.BBB_records_prs(bdids),bdid,bbb_id,ALL);

rec := RECORD
  br.bdid;
  DATASET(doxie_cbrs.layout_ID_BBB_children) BBB_children;
END;

rec prep(br l) := TRANSFORM
  SELF.BBB_children := DATASET([{l.bbb_id}], doxie_cbrs.layout_ID_BBB_children);
  SELF := l;
END;

brs := SORT(PROJECT(br, prep(LEFT)), bdid);

rec rollem(brs l, brs r) := TRANSFORM
  SELF.BBB_children := l.BBB_children + r.BBB_children;//IF(r.bdid > 0, r.BBB_children, []);
  SELF := l;
END;

RETURN ROLLUP(brs, LEFT.bdid = RIGHT.bdid, rollem(LEFT, RIGHT));
END;
