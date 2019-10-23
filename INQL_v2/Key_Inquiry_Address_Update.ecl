import doxie, Data_Services;

INQL_base := project(INQL_v2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

df := INQL_base(bus_intel.industry <> ''
        and ((unsigned)person_q.zip > 0 or (unsigned)person_q.zip5 > 0)
        and trim(person_q.prim_name)<>''
        and StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
        and stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::address_update';

export Key_Inquiry_Address_Update
  := INDEX(df, {string5 zip := map((unsigned)person_q.zip > 0 => person_q.zip, person_q.zip5),person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df}, InDx_FN);