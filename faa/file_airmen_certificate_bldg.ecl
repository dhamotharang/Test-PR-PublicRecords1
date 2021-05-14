import ut, header_services, faa, data_services;
ds := dataset(data_services.data_location.prefix()+'thor_data400::base::faa_airmen_certs_Building',faa.layout_airmen_certificate_out,flat);
	
export file_airmen_certificate_bldg := faa.Prep_Build.applyAirmenCertificateInj(ds);