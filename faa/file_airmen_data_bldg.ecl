import ut, header_services, faa, mdr, data_services;

ds := dataset(data_services.data_location.prefix()+'thor_data400::base::faa_airmen_building',faa.layout_airmen_data_out,flat);

export file_airmen_data_bldg := faa.Prep_Build.applyAirmenDataInj(ds);