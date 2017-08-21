import ln_propertyv2;

export New_records_sample(string filedate, boolean isFast=false):= function
	
	//Delta Update - Logical File
	File_Delta_Assessment 			:= dataset('~thor_data400::base::property_fast::assessment_'+filedate, LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs, flat);
	File_Delta_Deed							:= dataset('~thor_data400::base::property_fast::deed_mortgage_'+filedate, LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs, flat);
	File_Delta_Search_DID 			:= dataset('~thor_data400::base::property_fast::search_'+filedate, LN_PropertyV2.Layout_Did_Out, flat);
	File_Delta_Addl_Fares_Deed 	:= dataset('~thor_data400::base::property_fast::addl_frs_deed_mortgage_'+filedate, LN_PropertyV2.layout_addl_fares_deed, flat);
	File_Delta_Addl_Fares_Tax		:= dataset('~thor_data400::base::property_fast::addl_frs_assessment_'+filedate, LN_PropertyV2.layout_addl_fares_tax, flat);
	File_Delta_AddlNames				:= dataset('~thor_data400::base::property_fast::addl::ln_names_'+filedate, LN_PropertyV2.layout_addl_names, flat);
	File_Delta_Addl_Legal				:= dataset('~thor_data400::base::property_fast::addl::legal_'+filedate, LN_PropertyV2.layout_addl_legal, flat); 			
	
	//Full Update - Logical File
	File_Full_Assessment 				:= dataset('~thor_data400::base::ln_propertyv2::assesor_'+filedate,LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs , flat);
	File_Full_Deed							:= dataset('~thor_data400::base::ln_propertyv2::deed_'+filedate,LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs , flat);
	File_Full_Search_DID 				:= dataset('~thor_data400::base::ln_propertyv2::search_'+filedate, LN_PropertyV2.Layout_Did_Out, flat);
	File_Full_Addl_Fares_Deed 	:= dataset('~thor_data400::base::ln_propertyv2::addl::fares_deed_'+filedate, LN_PropertyV2.layout_addl_fares_deed, flat);
	File_Full_Addl_Fares_Tax		:= dataset('~thor_data400::base::ln_propertyv2::addl::fares_tax_'+filedate, LN_PropertyV2.layout_addl_fares_tax, flat);
	File_Full_AddlNames					:= dataset('~thor_data400::base::ln_propertyv2::addl::ln_names_'+filedate, LN_PropertyV2.layout_addl_names, flat);
	File_Full_Addl_Legal				:= dataset('~thor_data400::base::ln_propertyv2::addl::legal_'+filedate, LN_PropertyV2.layout_addl_legal, flat); 	
	
	File_Assessment							:= if(isFast, File_Delta_Assessment, File_Full_Assessment);
	File_Deed										:= if(isFast, File_Delta_Deed, File_Full_Deed);
	File_Search_DID							:= if(isFast, File_Delta_Search_DID, File_Full_Search_DID);
	File_Addl_Fares_Deed				:= if(isFast, File_Delta_Addl_Fares_Deed, File_Full_Addl_Fares_Deed);
	File_Addl_Fares_Tax					:= if(isFast, File_Delta_Addl_Fares_Tax, File_Full_Addl_Fares_Tax);
	File_AddlNames							:= if(isFast, File_Delta_AddlNames, File_Full_AddlNames);
	File_Addl_Legal							:= if(isFast, File_Delta_Addl_Legal, File_Full_Addl_Legal);
		
	/*Super Files
	File_Assessment 						:= if(isFast, LN_PropertyV2_Fast.Files.base.assessment, project(LN_PropertyV2.File_Assessment, LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs));	
	File_Deed 									:= if(isFast, LN_PropertyV2_Fast.Files.base.deed_mortg, project(LN_PropertyV2.File_Deed, LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs));
	File_Search_DID 						:= if(isFast, LN_PropertyV2_Fast.Files.base.search_prp, LN_PropertyV2.File_Search_DID);
	File_Addl_Fares_Deed				:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_frs_d, LN_PropertyV2.File_addl_fares_deed);
	File_Addl_Fares_Tax					:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_frs_a, LN_PropertyV2.File_addl_Fares_tax);
	File_AddlNames							:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_names, LN_PropertyV2.File_ln_deed_addlnames);
	File_Addl_Legal							:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_legal, LN_PropertyV2.File_addl_legal);
	*/	
	
	d01 := output(choosen(File_Assessment(max(File_Assessment,(unsigned4)process_date) -  (unsigned4)process_date < 2 and ln_fares_id[1..2] in ['OA','RA']), 1000),named('Assess_sample_QA'));
	d02 := output(choosen(File_Deed(max(File_Deed,(unsigned4)process_date) - (unsigned4)process_date < 2 and ln_fares_id[1..2] in ['OD','RD']), 1000),named('Deeds_sample_QA'));
	d03 := output(choosen(File_Search_DID(max(File_Search_DID,(unsigned4)process_date) -  (unsigned4)process_date < 2 and ln_fares_id[1] in ['O','R']), 1000),named('search_sample_QA'));

	d04:=  output(choosen(sort(File_Addl_Fares_Deed,-(integer)ln_fares_id[3..]), 1000),named('addl_fdeed_sample_QA'));
	d05:=  output(choosen(sort(File_Addl_Fares_Tax,-(integer)ln_fares_id[3..]), 1000),named('addl_ftax_sample_QA'));
	d06 := output(choosen(sort(File_AddlNames,-(integer)ln_fares_id[3..]), 1000),named('addl_names_sample_QA'));

	d07 := output(choosen(sort(File_Addl_Legal(ln_fares_id[1..2] = 'RA'),-(integer)ln_fares_id[3..]), 100),named('addl_flegal_sample_QA'));
	d08 := output(choosen(sort(File_Addl_Legal(ln_fares_id[1..2] != 'RA'),-(integer)ln_fares_id[3..]), 100),named('addl_legal_sample_QA'));
	 
	return parallel(d01, d02, d03, d04, d05, d06, d07,d08);

end;