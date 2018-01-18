﻿import doxie, data_services;

df := Inquiry_AccLogs.File_Inquiry_Base.history( (unsigned)person_q.personal_phone > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] );

export Key_Inquiry_Phone := INDEX(df, {string10 phone10 := person_q.personal_phone}, {df},
						data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::phone_' + doxie.version_superkey);

