import doxie;

INQL_base := project(INQL_v2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

df := INQL_base(bus_intel.industry <> ''
        and (unsigned)person_q.ssn > 0
        and StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
        and Stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

InDx_FN := '~thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::ssn_update';

export Key_Inquiry_SSN_Update := INDEX(df, {string9 ssn := person_q.SSN}, {df}, InDx_FN);