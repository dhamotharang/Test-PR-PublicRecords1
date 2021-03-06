import doxie, data_services;

df := Inquiry_AccLogs.File_Inquiry_Base.Update(bus_intel.industry <> '' and 
						trim(person_q.email_address) <> '' and 
						(unsigned)person_q.appended_adl <> 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'MODELS.ITABATCHSERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	df.fraudpoint_score;
end;

p := project(df, transform(slim, 
	self.person_q.email_address := stringlib.stringtouppercase(left.person_q.email_address), 
	self := left));

export Key_Inquiry_Email_Update := INDEX(p, {string50 email_address := person_q.email_address}, {p},
						data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::email_update');
						