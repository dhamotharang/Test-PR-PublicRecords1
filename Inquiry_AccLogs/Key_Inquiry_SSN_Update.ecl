import doxie;

df := Inquiry_AccLogs.File_Inquiry_Base.Update(bus_intel.industry <> '' and (unsigned)person_q.ssn > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

export Key_Inquiry_SSN_Update := INDEX(df, {string9 ssn := person_q.SSN}, {df},
						'~thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::ssn_update');