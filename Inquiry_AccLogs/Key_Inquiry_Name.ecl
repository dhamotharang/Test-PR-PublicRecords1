import doxie,Data_Services,UT, MDR, STD, _control;

df := Inquiry_AccLogs.File_Inquiry_Base.history(bus_intel.industry <> '' and  
						trim(person_q.lname) <> '' and  trim(person_q.fname) <> '' and 
						StringLib.StringToUpperCase(trim(Search_Info.Function_Description)) in Inquiry_AccLogs.shell_constants.set_suspiciousfraud_function_names and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	inquiry_acclogs.layout.ccpaLayout ccpa;
end;

p_ := project(df, transform(slim, self := left));
p  := MDR.macGetGlobalSid(p_,'InquiryTracking_Virtual','', 'ccpa.global_sid');

export Key_Inquiry_name := INDEX(p, {person_q.fname,person_q.mname,person_q.lname}, {p},
					Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::name_' + doxie.Version_SuperKey);