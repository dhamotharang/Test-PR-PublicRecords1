EXPORT ID_Number_DCA(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

dr := DEDUP(doxie_cbrs.DCA_records_raw(bdids),bdid,root,sub,ALL);

rec := RECORD
  dr.bdid;
  DATASET(doxie_cbrs.layout_ID_DCA_children) DCA_children;
END;

rec prep(dr l) := TRANSFORM
  SELF.DCA_children := DATASET([{l.root, l.sub}], doxie_cbrs.layout_ID_DCA_children);
  SELF := l;
END;

drs := SORT(PROJECT(dr, prep(LEFT)), bdid);

rec rollem(drs l, drs r) := TRANSFORM
  SELF.DCA_children := l.DCA_children + r.DCA_children;
  SELF := l;
END;

RETURN ROLLUP(drs, LEFT.bdid = RIGHT.bdid, rollem(LEFT, RIGHT));
END;
