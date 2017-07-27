import ut;

export BBB_records_prs(dataset(doxie_cbrs.layout_references) bdids = dataset([], doxie_cbrs.layout_references)) 
	:= FUNCTION

b3 := doxie_cbrs.BBB_records(bdids);

rec := doxie_cbrs.layout_BBB;

ut.MAC_Slim_Back(b3, rec, b3slim)

return make_BBBprs(b3slim);
END;