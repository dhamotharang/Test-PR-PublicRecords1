//start with the best records, which include supergroup
IMPORT business_header, doxie, doxie_cbrs;
doxie_cbrs.MAC_Selection_Declare()

EXPORT Associated_Business_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                                       doxie.IDataAccess mod_access
                                      ) := FUNCTION

sgb := doxie_cbrs.best_records_prs(bdids,mod_access)(Include_AssociatedBusinesses_val,
			 prim_range <> '' or prim_name <> '');


RETURN SORT(sgb(level > 0), level, company_name);
END;