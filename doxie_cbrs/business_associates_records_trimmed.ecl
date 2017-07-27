export business_associates_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

bus_assoc := doxie_cbrs.business_associates_records(bdids)(Include_BusinessAssociates_val);

ba_rec := RECORD
  unsigned6 bdid := 0;       // Seisint Business Identifier
  qstring120 company_name;
  qstring10 prim_range;
  string2   predir;
  qstring28 prim_name;
  qstring4  addr_suffix;
  string2   postdir;
  qstring5  unit_desig;
  qstring8  sec_range;
  qstring25 city;
  string2   state;
  string5   zip := '';
  string4   zip4 := '';
END;

ba_rec trans_rec(bus_assoc L) := TRANSFORM
	SELF := L;
END;

shared slim_bus_assoc := project(bus_assoc,trans_rec(LEFT));

doxie_cbrs.mac_Selection_Declare()
export records := choosen(slim_bus_assoc,Max_BusinessAssociates_val);
export records_count := count(slim_bus_assoc);

END;