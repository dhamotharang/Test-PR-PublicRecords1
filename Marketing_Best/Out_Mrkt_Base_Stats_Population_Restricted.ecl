import ut, STRATA,versioncontrol;

export Out_Mrkt_Base_Stats_Population_Restricted(

	 string								pversion
	,dataset(Layout_Best) pMarketingBestRestricted	= Files().Best_Restricted.built
	,boolean							pOverwrite								= false
	,boolean							pShouldSendToStrata				= true

) :=
function 

rPopulationStats_Marketing_Best__File_Marketing_Best_Restricted
 :=
  record
	  string3  grouping                               := 'ALL';
    CountGroup                                      := count(group);
    bdid_CountNonZero                               := sum(group,if(pMarketingBestRestricted.bdid<>0,1,0));
    exactSales_CountNonBlank                        := sum(group,if(pMarketingBestRestricted.exactSales<>'',1,0));
    salesMin_CountNonBlank                          := sum(group,if(pMarketingBestRestricted.salesMin<>'',1,0));
    salesMax_CountNonBlank                          := sum(group,if(pMarketingBestRestricted.salesMax<>'',1,0));
    salesSource_CountNonBlank                       := sum(group,if(pMarketingBestRestricted.salesSource<>'',1,0));
    sic_CountNonBlank                               := sum(group,if(pMarketingBestRestricted.sic<>'',1,0));
    sicSource_CountNonBlank                         := sum(group,if(pMarketingBestRestricted.sicSource<>'',1,0));
    exactEmplCnt_CountNonBlank                      := sum(group,if(pMarketingBestRestricted.exactEmplCnt<>'',1,0));
    emplCntMin_CountNonBlank                        := sum(group,if(pMarketingBestRestricted.emplCntMin<>'',1,0));
    emplCntMax_CountNonBlank                        := sum(group,if(pMarketingBestRestricted.emplCntMax<>'',1,0));
    emplCntType_CountNonBlank                       := sum(group,if(pMarketingBestRestricted.emplCntType<>'',1,0));
    emplCntSource_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.emplCntSource<>'',1,0));
    taxLienAmount_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.taxLienAmount<>'',1,0));
    taxLienTMSID_CountNonBlank                      := sum(group,if(pMarketingBestRestricted.taxLienTMSID<>'',1,0));
    taxLienSource_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.taxLienSource<>'',1,0));
    orgType_CountNonBlank                           := sum(group,if(pMarketingBestRestricted.orgType<>'',1,0));
    orgTypeSource_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.orgTypeSource<>'',1,0));
    bankrupt_flag_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.bankrupt_flag<>'',1,0));
    home_based_flag_CountNonBlank                   := sum(group,if(pMarketingBestRestricted.home_based_flag<>'',1,0));
    BHBest_company_name_CountNonBlank               := sum(group,if(pMarketingBestRestricted.BHBest_company_name<>'',1,0));
    BHBest_prim_range_CountNonBlank                 := sum(group,if(pMarketingBestRestricted.BHBest_prim_range<>'',1,0));
    BHBest_predir_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.BHBest_predir<>'',1,0));
    BHBest_prim_name_CountNonBlank                  := sum(group,if(pMarketingBestRestricted.BHBest_prim_name<>'',1,0));
    BHBest_addr_suffix_CountNonBlank                := sum(group,if(pMarketingBestRestricted.BHBest_addr_suffix<>'',1,0));
    BHBest_postdir_CountNonBlank                    := sum(group,if(pMarketingBestRestricted.BHBest_postdir<>'',1,0));
    BHBest_unit_desig_CountNonBlank                 := sum(group,if(pMarketingBestRestricted.BHBest_unit_desig<>'',1,0));
    BHBest_sec_range_CountNonBlank                  := sum(group,if(pMarketingBestRestricted.BHBest_sec_range<>'',1,0));
    BHBest_city_CountNonBlank                       := sum(group,if(pMarketingBestRestricted.BHBest_city<>'',1,0));
    BHBest_state_CountNonBlank                      := sum(group,if(pMarketingBestRestricted.BHBest_state<>'',1,0));
    BHBest_zip_CountNonBlank                        := sum(group,if(pMarketingBestRestricted.BHBest_zip<>'',1,0));
    BHBest_zip4_CountNonBlank                       := sum(group,if(pMarketingBestRestricted.BHBest_zip4<>'',1,0));
    BHBest_phone_CountNonBlank                      := sum(group,if(pMarketingBestRestricted.BHBest_phone<>'',1,0));
    BHBest_fein_CountNonBlank                       := sum(group,if(pMarketingBestRestricted.BHBest_fein<>'',1,0));
    BHBest_source_CountNonBlank                     := sum(group,if(pMarketingBestRestricted.BHBest_source<>'',1,0));
    BHBest_DPPA_State_CountNonBlank                 := sum(group,if(pMarketingBestRestricted.BHBest_DPPA_State<>'',1,0));
  end;
    
dPopulationStats_Marketing_Best__File_Marketing_Best_Restricted := table(pMarketingBestRestricted,
																	rPopulationStats_Marketing_Best__File_Marketing_Best_Restricted,
																	few
									                             );
outputBestRestricted := sequential(

		output('Marketing Best Restricted Strata Stats')
	 ,output(dPopulationStats_Marketing_Best__File_Marketing_Best_Restricted	,all)

);

STRATA.createXMLStats(dPopulationStats_Marketing_Best__File_Marketing_Best_Restricted,
                      'Marketing_Best',
					  'restricted',
					  pversion,
					  '',
					  resultsOut
					  );

hasBestRestrictedStrataBeenRun := VersionControl.fHasStrataBeenRun('Marketing_Best', 'restricted', pversion);

result := map(
	 (not hasBestRestrictedStrataBeenRun or pOverwrite) and			pShouldSendToStrata => resultsOut
	,(not hasBestRestrictedStrataBeenRun or pOverwrite) and not	pShouldSendToStrata => outputBestRestricted
	,output('Marketing Best Restricted Strata Stats have been run for version ' + pversion)
	);
					 
return result;
					 

end;
