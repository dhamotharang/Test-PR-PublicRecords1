layout_ext_vehicle_vin := RECORD
  string17 vin;
  unsigned6 rcid;
  string4 model_year;
  string36 make_desc;
  string36 model_desc;
  string25 series_desc;
	string25 series_name;
  string25 body_style_desc;
 END;
EXPORT File_Ext_Vehicle_VIN := dataset('~salt_demo::sample_ext_vehicle_vin',layout_ext_vehicle_vin,THOR);
