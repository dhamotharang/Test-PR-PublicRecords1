import doxie;

vehicles_rolled := file_bocashell_vehicles;

export Key_BocaShell_Vehicles := index (vehicles_rolled, {did}, {vehicles_rolled},
                                             '~thor_data400::key::vehicleV2::bocashell_did_' + doxie.Version_SuperKey);