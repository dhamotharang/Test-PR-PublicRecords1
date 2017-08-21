import ut, STRATA,versioncontrol;

export Out_Mrkt_Base_Stats_Population_All(

	 string								pversion
	,dataset(Layout_Best) pMarketingBestAll		= Files().Best_All.built
	,boolean							pOverwrite					= false
	,boolean							pShouldSendToStrata	= true

) :=
function

rPopulationStats_Marketing_Best__File_Marketing_Best_All
 :=
  record
    string3  grouping                               := 'ALL';
    CountGroup                                      := count(group);
    bdid_CountNonZero                               := sum(group,if(pMarketingBestAll.bdid<>0,1,0));
    exactSales_CountNonBlank                        := sum(group,if(pMarketingBestAll.exactSales<>'',1,0));
    salesMin_CountNonBlank                          := sum(group,if(pMarketingBestAll.salesMin<>'',1,0));
    salesMax_CountNonBlank                          := sum(group,if(pMarketingBestAll.salesMax<>'',1,0));
    salesSource_CountNonBlank                       := sum(group,if(pMarketingBestAll.salesSource<>'',1,0));
    sic_CountNonBlank                               := sum(group,if(pMarketingBestAll.sic<>'',1,0));
    sicSource_CountNonBlank                         := sum(group,if(pMarketingBestAll.sicSource<>'',1,0));
    exactEmplCnt_CountNonBlank                      := sum(group,if(pMarketingBestAll.exactEmplCnt<>'',1,0));
    emplCntMin_CountNonBlank                        := sum(group,if(pMarketingBestAll.emplCntMin<>'',1,0));
    emplCntMax_CountNonBlank                        := sum(group,if(pMarketingBestAll.emplCntMax<>'',1,0));
    emplCntType_CountNonBlank                       := sum(group,if(pMarketingBestAll.emplCntType<>'',1,0));
    emplCntSource_CountNonBlank                     := sum(group,if(pMarketingBestAll.emplCntSource<>'',1,0));
    taxLienAmount_CountNonBlank                     := sum(group,if(pMarketingBestAll.taxLienAmount<>'',1,0));
    taxLienTMSID_CountNonBlank                      := sum(group,if(pMarketingBestAll.taxLienTMSID<>'',1,0));
    taxLienSource_CountNonBlank                     := sum(group,if(pMarketingBestAll.taxLienSource<>'',1,0));
    orgType_CountNonBlank                           := sum(group,if(pMarketingBestAll.orgType<>'',1,0));
    orgTypeSource_CountNonBlank                     := sum(group,if(pMarketingBestAll.orgTypeSource<>'',1,0));
    bankrupt_flag_CountNonBlank                     := sum(group,if(pMarketingBestAll.bankrupt_flag<>'',1,0));
    home_based_flag_CountNonBlank                   := sum(group,if(pMarketingBestAll.home_based_flag<>'',1,0));
    BHBest_company_name_CountNonBlank               := sum(group,if(pMarketingBestAll.BHBest_company_name<>'',1,0));
    BHBest_prim_range_CountNonBlank                 := sum(group,if(pMarketingBestAll.BHBest_prim_range<>'',1,0));
    BHBest_predir_CountNonBlank                     := sum(group,if(pMarketingBestAll.BHBest_predir<>'',1,0));
    BHBest_prim_name_CountNonBlank                  := sum(group,if(pMarketingBestAll.BHBest_prim_name<>'',1,0));
    BHBest_addr_suffix_CountNonBlank                := sum(group,if(pMarketingBestAll.BHBest_addr_suffix<>'',1,0));
    BHBest_postdir_CountNonBlank                    := sum(group,if(pMarketingBestAll.BHBest_postdir<>'',1,0));
    BHBest_unit_desig_CountNonBlank                 := sum(group,if(pMarketingBestAll.BHBest_unit_desig<>'',1,0));
    BHBest_sec_range_CountNonBlank                  := sum(group,if(pMarketingBestAll.BHBest_sec_range<>'',1,0));
    BHBest_city_CountNonBlank                       := sum(group,if(pMarketingBestAll.BHBest_city<>'',1,0));
    BHBest_state_CountNonBlank                      := sum(group,if(pMarketingBestAll.BHBest_state<>'',1,0));
    BHBest_zip_CountNonBlank                        := sum(group,if(pMarketingBestAll.BHBest_zip<>'',1,0));
    BHBest_zip4_CountNonBlank                       := sum(group,if(pMarketingBestAll.BHBest_zip4<>'',1,0));
    BHBest_phone_CountNonBlank                      := sum(group,if(pMarketingBestAll.BHBest_phone<>'',1,0));
    BHBest_fein_CountNonBlank                       := sum(group,if(pMarketingBestAll.BHBest_fein<>'',1,0));
    BHBest_source_CountNonBlank                     := sum(group,if(pMarketingBestAll.BHBest_source<>'',1,0));
    BHBest_DPPA_State_CountNonBlank                 := sum(group,if(pMarketingBestAll.BHBest_DPPA_State<>'',1,0));
  end;
    
dPopulationStats_Marketing_Best__File_Marketing_Best_All := table(pMarketingBestAll,
																	rPopulationStats_Marketing_Best__File_Marketing_Best_All,
																	few
									                             );
outputBestAll := sequential(

		output('Marketing Best all Strata Stats')
	 ,output(dPopulationStats_Marketing_Best__File_Marketing_Best_All	,all)

);

STRATA.createXMLStats(dPopulationStats_Marketing_Best__File_Marketing_Best_All,
                      'Marketing_Best',
					  'all',
					  pversion,
					  '',
					  resultsOut
					  );

hasBestStrataBeenRun := VersionControl.fHasStrataBeenRun('Marketing_Best', 'all', pversion);

result := map(
	 (not hasBestStrataBeenRun or pOverwrite) and			pShouldSendToStrata => resultsOut
	,(not hasBestStrataBeenRun or pOverwrite) and not	pShouldSendToStrata => outputBestAll
	,output('Marketing Best All Strata Stats have been run for version ' + pversion)
	);
					 
return result;

end;
