IMPORT PRTE2_Common, PRTE2, PRTE_CSV, STD, PROPERTY;

EXPORT Files := MODULE
	EXPORT FILE_FORECLOSURE_CODES := Property.File_Foreclosure_Codes;
	EXPORT FI_TABLE								:= DATASET([], Layouts.key_geo); 
	EXPORT INCOMING_BOCA					:= DATASET(Constants.in_prefix_name + 'boca', Layouts.incoming_boca, CSV(HEADING(1),SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(40000)));	
	EXPORT FILE_BOCA_FILTER				:= INCOMING_BOCA(std.str.find(foreclosure_id, 'foreclosure_id',1) =0);
	EXPORT INCOMING_ALPHA					:= DATASET(Constants.in_prefix_name + 'alpha', Layouts.incoming_alpha, thor);
	EXPORT BASE										:= DATASET(Constants.base_prefix_name, Layouts.base, thor);		
	EXPORT NORMALIZED_BASE 				:= DATASET(Constants.base_prefix_name+ '_normalized', Layouts.normalized, thor);
	
	EXPORT FORECLOSURE_AUTOKEY 		:= dedup(project(NORMALIZED_BASE(trim(deed_category)='U',site_prim_name<>'',site_zip<>''), transform(layouts.Autokey_layout, self := left)), record,all);
	EXPORT NOD_AUTOKEY 				 		:= dedup(project(NORMALIZED_BASE(trim(deed_category)='N',site_prim_name<>'',site_zip<>''), transform(layouts.Autokey_layout, self := left)), record,all);
	EXPORT FORECLOSURE_HEADER    	:= PROJECT(BASE, {BASE} - [cust_name,bug_name, boca_alpha_ind, date_aging_ind, custest_data_type]);
END;

