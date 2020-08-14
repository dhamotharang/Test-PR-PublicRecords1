IMPORT doxie,doxie_cbrs,ut;

EXPORT best_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                        doxie.IDataAccess mod_access) := FUNCTION

bes := doxie_cbrs.best_records_bdids(bdids);

outrec := doxie_cbrs.layout_best_records_prs;
ut.MAC_Slim_Back(bes, outrec, wla)

//indicators
wcur := doxie_cbrs.mark_ABCurrent(wla, bdids,mod_access);
doxie_cbrs.mac_hasBBB(wcur, wbbb, bdids)

RETURN wbbb;
END;
