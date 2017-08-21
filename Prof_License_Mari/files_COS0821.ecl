//Raw Real Estate Brokers and Appraisers License from COS0821/*2015-10-28T17:25:46Z (Xia Sheng)
//Bug 185570

//Raw Real Estate Brokers and Appraisers License from COS0821
IMPORT ut,_control,Prof_License_Mari,Lib_FileServices;

EXPORT files_COS0821 := MODULE
#workunit('name','File COS0821');
	SHARED code 								:= 'COS0821';
	SHARED working_dir					:= 'using';
	SHARED file_sub 	       		:= 'subdivision';
	SHARED file_inactive_brkr 	:= 'inactvie_brokers';
	SHARED file_inactive_app    := 'inactive_appraisers';
	SHARED file_AMC_company			:= 'AMC_company';
	SHARED file_active_ass_brkr := 'active_ass_brokers';
	SHARED file_active_company 	:= 'active_company';
	SHARED file_active_prop     := 'active_proprietors';
	SHARED file_active_res_brkr	:= 'active_res_brokers';
	SHARED file_active_app			:= 'active_appraisers';
		
	EXPORT sub 			          		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_sub, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));
																					
	EXPORT inactive_brkr 	    		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_inactive_brkr, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));
																					
	EXPORT inactive_app 	      	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_inactive_app, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));

	EXPORT AMC_company						:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_AMC_company, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));

	EXPORT active_ass_brkr 				:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_active_ass_brkr, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));
																					
	EXPORT active_company 		  	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_active_company, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));
																					
	EXPORT active_prop 	        	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_active_prop, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));

	EXPORT active_res_brkr			  := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_active_res_brkr, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));
																					
	EXPORT active_app							:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_active_app, 
																					Prof_License_Mari.layout_COS0821.Broker_Common,
																					CSV(heading(1),SEPARATOR(','),QUOTE('"')));																				
																					
END;
