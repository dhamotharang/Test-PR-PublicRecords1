import did_Add,ut;

export best_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION 

bes := doxie_cbrs.best_records_bdids(bdids);

outrec := doxie_cbrs.layout_best_records_prs;
ut.MAC_Slim_Back(bes, outrec, wla)

//indicators
wcur := doxie_cbrs.mark_ABCurrent(wla, bdids);
doxie_cbrs.mac_hasBBB(wcur, wbbb, bdids)

return wbbb;
END;