Import Data_Services, VehicleV2, doxie, data_services;

EXPORT Key_Make := index(VehicleV2.Files.base.make, {makecode, i}, 
							data_services.data_location.prefix('Vehicle') + 'thor_data400::key::wc_vehicle::make_'+doxie.Version_SuperKey);
