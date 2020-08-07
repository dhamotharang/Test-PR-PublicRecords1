IMPORT ut;

EXPORT BBB_records_prs(DATASET(doxie_cbrs.layout_references) bdids = DATASET([], doxie_cbrs.layout_references))
  := FUNCTION

b3 := doxie_cbrs.BBB_records(bdids);

rec := doxie_cbrs.layout_BBB;

ut.MAC_Slim_Back(b3, rec, b3slim)

RETURN make_BBBprs(b3slim);
END;
