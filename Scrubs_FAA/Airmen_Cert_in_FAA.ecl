import faa,data_services;
EXPORT Airmen_Cert_in_FAA := dataset(data_services.foreign_prod + 'thor_data400::base::faa_airmen_certs',faa.layout_airmen_certificate_out,thor);