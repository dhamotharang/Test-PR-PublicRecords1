Import Data_Services, VehicleV2, VehLic,doxie, ut;

EXPORT Key_Make := index(VehicleV2.Files.base.make, {makecode, i}, 
							'~thor_data400::key::wc_vehicle::make_'+doxie.Version_SuperKey);
