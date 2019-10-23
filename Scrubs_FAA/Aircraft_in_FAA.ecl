import faa,data_services;
EXPORT Aircraft_in_FAA := dataset(data_services.foreign_prod + 'thor_data400::base::faa_aircraft_reg',faa.layout_aircraft_registration_out,thor);