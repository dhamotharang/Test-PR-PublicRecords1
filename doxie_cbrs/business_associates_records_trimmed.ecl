IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT business_associates_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids, doxie.IDataAccess mod_access) := 
MODULE

  bus_assoc := doxie_cbrs.business_associates_records(bdids, mod_access)(Include_BusinessAssociates_val);

  SHARED slim_bus_assoc := PROJECT(bus_assoc, doxie_cbrs.layout_business_associates.slim_rec);

  EXPORT records := CHOOSEN(slim_bus_assoc,Max_BusinessAssociates_val);
  EXPORT records_count := COUNT(slim_bus_assoc);

END;
