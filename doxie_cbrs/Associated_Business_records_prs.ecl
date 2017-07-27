//start with the best records, which include supergroup
import business_header, doxie;
doxie_cbrs.MAC_Selection_Declare()

export Associated_Business_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

sgb := doxie_cbrs.best_records_prs(bdids)(Include_AssociatedBusinesses_val,
			 prim_range <> '' or prim_name <> '');


return sort(sgb(level > 0), level, company_name);
END;