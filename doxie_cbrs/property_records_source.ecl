IMPORT doxie_cbrs, ln_propertyv2_services;

doxie_cbrs.mac_Selection_Declare()
EXPORT property_records_source(DATASET(doxie_cbrs.layout_references) bdids) := MODULE
  EXPORT assessments :=
    IF(PropertyVersion IN [0,2],SORT( NOFOLD(LN_PropertyV2_Services.Source_records(, bdids, Max_Properties_val, TRUE))(fid_type='A'), -sortby_date, RECORD));
  EXPORT deeds :=
    IF(PropertyVersion IN [0,2],SORT( NOFOLD(LN_PropertyV2_Services.Source_records(, bdids, Max_Properties_val, TRUE))(fid_type='D'), -sortby_date, RECORD));
END;
