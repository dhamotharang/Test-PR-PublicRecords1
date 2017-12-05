import doxie, Data_Services;

dfbefore :=Inquiry_AccLogs.File_Inquiry_BaseSourced.history(bus_intel.industry <> '' and bus_q.appended_ein <>'' and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

df:= dfbefore(~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
											search_info.function_description in [
											'ADDRBEST.BESTADDRESSBATCHSERVICE'
											,'BATCHSERVICES.AKABATCHSERVICE'
											,'BATCHSERVICES.DEATHBATCHSERVICE'
											,'BATCHSERVICES.EMAILBATCHSERVICE'
											,'BATCHSERVICES.PROPERTYBATCHSERVICE'
											,'DIDVILLE.DIDBATCHSERVICERAW'
											,'DIDVILLE.RANBESTINFOBATCHSERVICE'
											,'PROGRESSIVEPHONE.PROGRESSIVEPHONEWITHFEEDBACKBATCHSERVICE'])
					);

export Key_Inquiry_FEIN := INDEX(df, {string15 appended_ein := bus_q.appended_ein}, {df},
						Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::fein_' + doxie.version_superkey );

						