IMPORT doxie, doxie_cbrs;
EXPORT business_associates_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids, doxie.IDataAccess mod_access) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

bus_assoc := doxie_cbrs.business_associates_records(bdids, mod_access)(Include_BusinessAssociates_val);

ba_rec := RECORD
  UNSIGNED6 bdid := 0; // Seisint Business Identifier
  QSTRING120 company_name;
  QSTRING10 prim_range;
  STRING2 predir;
  QSTRING28 prim_name;
  QSTRING4 addr_suffix;
  STRING2 postdir;
  QSTRING5 unit_desig;
  QSTRING8 sec_range;
  QSTRING25 city;
  STRING2 state;
  STRING5 zip := '';
  STRING4 zip4 := '';
END;

ba_rec trans_rec(bus_assoc L) := TRANSFORM
  SELF := L;
END;

SHARED slim_bus_assoc := PROJECT(bus_assoc,trans_rec(LEFT));

doxie_cbrs.mac_Selection_Declare()
EXPORT records := CHOOSEN(slim_bus_assoc,Max_BusinessAssociates_val);
EXPORT records_count := COUNT(slim_bus_assoc);

END;
