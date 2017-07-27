import ut;

export BBB_NM_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

r := doxie_cbrs.BBB_NM_records(bdids);

rec := doxie_cbrs.layout_BBB;

ut.MAC_Slim_Back(r, rec, b3slim)

return make_BBBprs(b3slim);
END;