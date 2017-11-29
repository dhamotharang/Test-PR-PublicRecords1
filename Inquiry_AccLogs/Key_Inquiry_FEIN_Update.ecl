﻿import doxie, data_services;

df :=Inquiry_AccLogs.File_Inquiry_BaseSourced.updates(bus_intel.industry <> '' and bus_q.appended_ein <>'' and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

export Key_Inquiry_FEIN_Update := INDEX(df, {string15 appended_ein := bus_q.appended_ein}, {df},
						Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey +'::fein_update'  );
