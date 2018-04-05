import doxie, data_services, ut;

INQL_base := project(INQL_v2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

df := DEDUP(TABLE(INQL_base(bus_intel.industry <> ''
          and search_info.transaction_id != ''
          and StringLib.StringToUpperCase(trim(search_info.function_description))	not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)']
          and StringLib.StringToUpperCase(trim(search_info.function_description)) in INQL_v2.shell_constants.chargeback_functions
          and Stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0
          and Stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0)
						,{search_info.transaction_id
						,person_q.appended_adl
					  ,search_info.datetime
						,bus_intel.industry
						,bus_intel.vertical
						,bus_intel.sub_market
						,search_info.function_description
		        ,search_info.product_code
						,bus_intel.use
						,search_info.Sequence_Number} 
			      ,search_info.transaction_id
						,person_q.appended_adl
					  ,search_info.datetime
						,bus_intel.industry
						,bus_intel.vertical
						,bus_intel.sub_market
						,search_info.function_description
		        ,search_info.product_code
						,bus_intel.use
						,search_info.Sequence_Number),ALL);

InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::transaction_id_update';

//string50 to match deltabase definition since most others are just strings
export Key_Inquiry_Transaction_ID_Update := INDEX(df, {string50 transaction_id := transaction_id}, {df}, InDx_FN);							
	