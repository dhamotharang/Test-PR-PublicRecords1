import doxie,Inquiry_AccLogs, Data_Services;

INQL_base := INQL_v2.File_Inquiry_BaseSourced.updates;

df := INQL_base(bus_intel.industry <> ''
        and person_q.Appended_ADL > 0
        and StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
        and Stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0
        and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

Base := INQL_v2.FN_Append_SBA_DID(df);
InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::did_update';

export Key_Inquiry_DID_Update := INDEX(Base, {unsigned6 s_did := person_q.appended_ADL}, {Base}, InDx_FN);


