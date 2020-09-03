IMPORT doxie_raw, doxie, business_header;

Business_Header.doxie_MAC_Field_Declare()
mod_access := doxie.compliance.GetGlobalDataAccessModule();
doxie.MAC_Selection_Declare()

EXPORT motor_vehicle_records_dayton(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

raw := Doxie_Raw.Veh_Raw(doxie_raw.ds_EmptyDIDs, mod_access,
                         vin_value,
                         tag_value,
                         '',
                         '',
                         '',
                         company_name_value,
                         PROJECT(bdids, doxie.Layout_ref_bdid));

RETURN IF(VehicleVersion IN [0,1],raw);
END;
