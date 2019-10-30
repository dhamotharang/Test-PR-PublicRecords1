import doxie, inquiry_acclogs, data_services, MDR, STD, _control;

df := Inquiry_AccLogs.File_Inquiry_BaseSourced.history(bus_intel.industry <> '' and person_q.Appended_ADL > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

Base_ := Inquiry_AccLogs.FN_Append_SBA_DID(df);
Base  := MDR.macGetGlobalSid(Base_,'InquiryTracking_Virtual','', 'ccpa.global_sid'); 

export Key_Inquiry_DID := INDEX(Base, {unsigned6 s_did := person_q.appended_ADL}, {Base},
																data_services.foreign_prod + 'thor_data400::key::inquiry_table::did_' + doxie.Version_SuperKey);
																

