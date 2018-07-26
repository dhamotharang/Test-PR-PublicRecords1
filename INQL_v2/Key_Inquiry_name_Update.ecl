import doxie,Data_Services,UT;

INQL_base := project(INQL_v2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

df := INQL_base(bus_intel.industry <> ''
        and trim(person_q.lname) <> '' and  trim(person_q.fname) <> ''
        and StringLib.StringToUpperCase(trim(Search_Info.Function_Description)) in INQL_v2.shell_constants.set_suspiciousfraud_function_names
        and Stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
end;

p := project(df, transform(slim, self := left));
InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::name_update';

export Key_Inquiry_name_update := INDEX(p, {person_q.fname,person_q.mname,person_q.lname}, {p}, InDx_FN);
					