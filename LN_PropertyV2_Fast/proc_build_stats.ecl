export proc_build_stats(filedate,zDoStatsReference,isFast):= macro
  import LN_PropertyV2;
	#uniquename(zDoPopulationStats);
	#uniquename(zDoPopulationStatsforNewData);
  #uniquename(File_Assessment);
	#uniquename(File_Deed);
	#uniquename(File_New_Assessment);
	#uniquename(File_New_Deed);
	
	#uniquename(File_Delta_Assessment);
	#uniquename(File_Delta_Deed);
	#uniquename(File_Delta_Search_DID);
	#uniquename(File_Delta_Addl_Fares_Deed);
	#uniquename(File_Delta_Addl_Fares_Tax);
	#uniquename(File_Delta_AddlNames);
	#uniquename(File_Delta_Addl_Legal);
	#uniquename(File_Delta_Addl_Name_Info);

	#uniquename(File_Full_Assessment);
	#uniquename(File_Full_Deed);
	#uniquename(File_Full_Search_DID);
	#uniquename(File_Full_Addl_Fares_Deed );
	#uniquename(File_Full_Addl_Fares_Tax);
	#uniquename(File_Full_AddlNames);
	#uniquename(File_Full_Addl_Legal);
	#uniquename(File_Full_Addl_Name_Info);
	
	#uniquename(whichAssess);												 
	#uniquename(whichDeed);
	#uniquename(whichParty);
	#uniquename(whichAddlTax);
	#uniquename(whichAddlDd);
	#uniquename(whichAddlLgl);
	#uniquename(whichAddlNms);
	#uniquename(whichAddlNmInf);
	
	//Delta Update - Logical Files
	File_Delta_Assessment 			:= dataset('~thor_data400::base::property_fast::assessment_'+filedate, LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs, flat);
	File_Delta_Deed							:= dataset('~thor_data400::base::property_fast::deed_mortgage_'+filedate, LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs, flat);
	File_Delta_Search_DID 			:= dataset('~thor_data400::base::property_fast::search_'+filedate, LN_PropertyV2.Layout_Did_Out, flat);
	File_Delta_Addl_Fares_Deed 	:= dataset('~thor_data400::base::property_fast::addl_frs_deed_mortgage_'+filedate, LN_PropertyV2.layout_addl_fares_deed, flat);
	File_Delta_Addl_Fares_Tax		:= dataset('~thor_data400::base::property_fast::addl_frs_assessment_'+filedate, LN_PropertyV2.layout_addl_fares_tax, flat);
	File_Delta_AddlNames				:= dataset('~thor_data400::base::property_fast::addl::ln_names_'+filedate, LN_PropertyV2.layout_addl_names, flat);
	File_Delta_Addl_Legal				:= dataset('~thor_data400::base::property_fast::addl::legal_'+filedate, LN_PropertyV2.layout_addl_legal, flat);
	File_Delta_Addl_Name_Info		:= dataset('~thor_data400::base::property_fast::addl::name_info_'+filedate, LN_PropertyV2.layout_addl_name_info, flat);
	
	//Full Update - Logical Files
	File_Full_Assessment 				:= dataset('~thor_data400::base::ln_propertyv2::assesor_'+filedate, LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs, flat);
	File_Full_Deed							:= dataset('~thor_data400::base::ln_propertyv2::deed_'+filedate, LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat);
	File_Full_Search_DID 				:= dataset('~thor_data400::base::ln_propertyv2::search_'+filedate, LN_PropertyV2.Layout_Did_Out, flat);
	File_Full_Addl_Fares_Deed 	:= dataset('~thor_data400::base::ln_propertyv2::addl::fares_deed_'+filedate, LN_PropertyV2.layout_addl_fares_deed, flat);
	File_Full_Addl_Fares_Tax		:= dataset('~thor_data400::base::ln_propertyv2::addl::fares_tax_'+filedate, LN_PropertyV2.layout_addl_fares_tax, flat);
	File_Full_AddlNames					:= dataset('~thor_data400::base::ln_propertyv2::addl::ln_names_'+filedate, LN_PropertyV2.layout_addl_names, flat);
	File_Full_Addl_Legal				:= dataset('~thor_data400::base::ln_propertyv2::addl::legal_'+filedate, LN_PropertyV2.layout_addl_legal, flat);
	File_Full_Addl_Name_Info		:= dataset('~thor_data400::base::ln_propertyv2::addl::name_info_'+filedate, LN_PropertyV2.layout_addl_name_info, flat);
	
	/*Super Files
	whichAssess 	:= if(isFast, LN_PropertyV2_Fast.Files.base.assessment, project(LN_PropertyV2.File_Assessment, LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs));	
	whichDeed 		:= if(isFast, LN_PropertyV2_Fast.Files.base.deed_mortg, project(LN_PropertyV2.File_Deed, LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs));
	whichParty 		:= if(isFast, LN_PropertyV2_Fast.Files.base.search_prp, LN_PropertyV2.File_Search_DID);
	whichAddlDd		:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_frs_d, LN_PropertyV2.File_addl_fares_deed);
	whichAddlTax	:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_frs_a, LN_PropertyV2.File_addl_Fares_tax);
	whichAddlNms	:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_names, LN_PropertyV2.File_ln_deed_addlnames);
	whichAddlLgl	:= if(isFast, LN_PropertyV2_Fast.Files.base.addl_legal, LN_PropertyV2.File_addl_legal);
	*/	
	
	whichAssess									:= if(isFast, File_Delta_Assessment, File_Full_Assessment);
	whichDeed										:= if(isFast, File_Delta_Deed, File_Full_Deed);
	whichParty									:= if(isFast, File_Delta_Search_DID, File_Full_Search_DID);
	whichAddlDd									:= if(isFast, File_Delta_Addl_Fares_Deed, File_Full_Addl_Fares_Deed);
	whichAddlTax								:= if(isFast, File_Delta_Addl_Fares_Tax, File_Full_Addl_Fares_Tax);
	whichAddlNms								:= if(isFast, File_Delta_AddlNames, File_Full_AddlNames);
	whichAddlLgl								:= if(isFast, File_Delta_Addl_Legal, File_Full_Addl_Legal);
	whichAddlNmInf							:= if(isFast, File_Delta_Addl_Name_Info, File_Full_Addl_Name_Info);
	
%File_Assessment% 		:= project(whichAssess, 
														transform(LN_PropertyV2.layout_property_common_model_base,
																		self.vendor_source_flag := map( left.vendor_source_flag = 'F' => 'F', 
																																		left.vendor_source_flag = 'S' => 'F',
																																		left.vendor_source_flag = 'O' => 'L', 
																																		left.vendor_source_flag = 'D' => 'L', ''),
																		self := left));

%File_Deed% 					:= project(whichDeed, 
														transform(LN_PropertyV2.layout_deed_mortgage_common_model_base,
																		self.vendor_source_flag := map( left.vendor_source_flag = 'F' => 'F', 
																																		left.vendor_source_flag = 'S' => 'F',
																																		left.vendor_source_flag = 'O' => 'L', 
																																		left.vendor_source_flag = 'D' => 'L', ''),
																		self := left));  
					
%File_New_Assessment% := %File_Assessment%((unsigned4)max(%File_Assessment%, process_date) - (unsigned4)process_date < 7);
		
%File_New_Deed% 			:= %File_Deed%((unsigned4)max(%File_Deed%, process_date) - (unsigned4)process_date < 7);	
									   
	LN_PropertyV2_Fast.out_STRATA_population_stats(whichAssess
																								 ,whichDeed
																								 ,whichAddlTax
																								 ,whichAddlDd
																								 ,whichAddlLgl
																								 ,whichAddlNms
																								 ,whichParty
																								 //,whichAddlNmInf //May be needed for future use for new BK data
																								 ,filedate
																								 ,zDoPopulationStats
																								 ,isFast);								   
									   		   
	LN_PropertyV2_Fast.out_STRATA_population_stats_new_data(%File_New_Assessment%
																								 ,%File_New_Deed% 									  
																								 ,filedate
																								 ,zDoPopulationStatsforNewData
																								 ,isFast);	
									   
	zDoStatsReference		:= sequential(zDoPopulationStats, zDoPopulationStatsforNewData);

endmacro;
 