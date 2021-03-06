import doxie,Data_Services,UT;

df := Inquiry_AccLogs.File_Inquiry_Base.Update(bus_intel.industry <> '' and 
						trim(person_q.IPaddr) <> '' and 
						//(unsigned)person_q.appended_adl <> 0 and 
						StringLib.StringToUpperCase(trim(Search_Info.Function_Description)) in Inquiry_AccLogs.shell_constants.set_suspiciousfraud_function_names and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
end;

p := project(df, transform(slim, 
	self.person_q.IPADDR := trim(left.person_q.IPaddr, left,right), 
	self := left));

export Key_Inquiry_IPaddr_update := INDEX(p, {string20 IPaddr := person_q.IPaddr}, {p},
				Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::IPAddr_update');
						
						
						