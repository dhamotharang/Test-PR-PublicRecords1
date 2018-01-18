import doxie, data_services;

df := Inquiry_AccLogs.File_Inquiry_Base.Update( (unsigned)person_q.zip > 0 and trim(person_q.prim_name)<>'' and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] );

export Key_Inquiry_Address_Update := INDEX(df, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
						data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::address_update');