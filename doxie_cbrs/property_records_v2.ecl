IMPORT LN_PropertyV2_Services;
doxie_cbrs.mac_Selection_Declare()
EXPORT property_records_v2(DATASET(doxie_cbrs.layout_references) bdids) := MODULE
  SHARED unlim := IF(PropertyVersion IN [0,2],LN_PropertyV2_Services.Embed_records(TRUE,,bdids,Max_Properties_val,,isPeopleWise)(Include_PropertiesV2_val));
  
  EXPORT recs_trimmed := topn(unlim, Max_Properties_val, -sortby_date);
  EXPORT all_recs := unlim;
END;
