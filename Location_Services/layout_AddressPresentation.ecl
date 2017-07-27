IMPORT Risk_Indicators;

RidRec := RECORD
	unsigned6 rid;
END;

EXPORT layout_AddressPresentation := RECORD
  unsigned2   penalt;
  string10    prim_range;
  string2     predir;
  string28    prim_name;
  string4     suffix;
  string2     postdir;
  string10    unit_desig;
  string8     sec_range;
  string25    city_name;
  string2     st;
  string5     zip;
  string4     zip4;
  dataset(Risk_Indicators.Layout_Desc)	hri_address	{ maxcount(consts.max_hri_addr) }	:= dataset([], Risk_Indicators.Layout_Desc);
  dataset(RidRec)												rids				{ maxcount(consts.max_rids) }			:= dataset([], RidRec);
END;