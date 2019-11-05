import doxie, MDR, STD, _control;
df_ := Inquiry_AccLogs.File_Inquiry_Base.history(bus_intel.industry <> '' and (unsigned)person_q.personal_phone > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

df  := MDR.macGetGlobalSid(df_,'InquiryTracking_Virtual','', 'ccpa.global_sid');

export Key_Inquiry_Phone := INDEX(df, {string10 phone10 := person_q.personal_phone}, {df},
						'~thor_data400::key::inquiry_table::phone_' + doxie.version_superkey);
