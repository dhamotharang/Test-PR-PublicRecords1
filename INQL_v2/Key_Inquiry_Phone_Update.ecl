import doxie, Data_Services;

INQL_base := project(INQL_v2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

df := INQL_base(bus_intel.industry <> '' and (unsigned)person_q.personal_phone > 0
       and StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
       and Stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0
       and Stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::phone_update';

export Key_Inquiry_Phone_Update := INDEX(df, {string10 phone10 := person_q.personal_phone}, {df}, InDx_FN);