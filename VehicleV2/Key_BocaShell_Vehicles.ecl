import doxie,data_services;

vehicles_rolled := file_bocashell_vehicles;

export Key_BocaShell_Vehicles := index (vehicles_rolled, {did}, {vehicles_rolled},
                                             data_services.data_location.prefix('Vehicle') + 'thor_data400::key::vehicleV2::bocashell_did_' + doxie.Version_SuperKey);