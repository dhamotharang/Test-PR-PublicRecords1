export proc_build_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);
	#uniquename(zDoPopulationStatsforNewData);
    #uniquename(File_Assessment);
	#uniquename(File_Deed);
	#uniquename(File_New_Assessment);
	#uniquename(File_New_Deed);

%File_Assessment% := project(LN_PropertyV2.File_Assessment, 
                    transform(LN_PropertyV2.layout_property_common_model_base,
					self.vendor_source_flag := map( left.vendor_source_flag = 'F' => 'F', 
                                left.vendor_source_flag = 'S' => 'F',
								left.vendor_source_flag = 'O' => 'L', 
				                left.vendor_source_flag = 'D' => 'L', ''),
								
					self := left));

%File_Deed% := project(LN_PropertyV2.File_Deed, 
                    transform(LN_PropertyV2.layout_deed_mortgage_common_model_base,
					self.vendor_source_flag := map( left.vendor_source_flag = 'F' => 'F', 
                                left.vendor_source_flag = 'S' => 'F',
								left.vendor_source_flag = 'O' => 'L', 
				                left.vendor_source_flag = 'D' => 'L', ''),
								
					self := left));  
					
%File_New_Assessment% := %File_Assessment%((unsigned4)max(%File_Assessment%, process_date) - (unsigned4)process_date < 7);
		
%File_New_Deed% := %File_Deed%((unsigned4)max(%File_Deed%, process_date) - (unsigned4)process_date < 7);
			
									   
	LN_PropertyV2.out_STRATA_population_stats(LN_PropertyV2.File_Assessment
	                                   ,LN_PropertyV2.File_Deed
									   ,LN_PropertyV2.File_addl_Fares_tax
									   ,LN_PropertyV2.File_addl_fares_deed
									   ,LN_PropertyV2.File_addl_legal
									   ,LN_PropertyV2.File_ln_deed_addlnames
									   ,LN_PropertyV2.File_Search_DID
									   ,filedate
									   ,zDoPopulationStats);								   
									   
								   
	LN_PropertyV2.out_STRATA_population_stats_new_data(%File_New_Assessment%
	                                   ,%File_New_Deed% 									  
									   ,filedate
									   ,zDoPopulationStatsforNewData);	
									   
	zDoStatsReference	:= sequential(zDoPopulationStats, zDoPopulationStatsforNewData);
  endmacro
 ;
 
 
 