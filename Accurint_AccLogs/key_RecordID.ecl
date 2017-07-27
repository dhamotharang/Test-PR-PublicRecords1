//OLD - NOT AUTOKEY

import data_services, doxie;

export key_recordid := index(Accurint_AccLogs.File_SearchAutokey,{record_id},{Accurint_AccLogs.File_SearchAutokey},
							Data_Services.Data_location.Prefix('Accurint_AccLogs') + 'thor_data400::key::acclogs::' + doxie.Version_SuperKey + '::recordid');