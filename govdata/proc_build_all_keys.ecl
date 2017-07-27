import ut, versioncontrol,fbnv2;

export proc_build_all_keys(

	string pversion

) :=
module
	
	shared lkeys := keynames(pversion);
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Build keys
	//////////////////////////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalKeyWithName( key_ca_sales_tax_bdid					   ,lkeys.CASalesTaxBdid.New						,BuildKey1 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_ca_sales_tax_linkids.key	   ,lkeys.CASalesTaxLinkids.New					,BuildKey1A	);	
	VersionControl.macBuildNewLogicalKeyWithName( Key_IA_SalesTax_BDID					   ,lkeys.IASalesTaxBdid.New						,BuildKey2 	);
	VersionControl.macBuildNewLogicalKeyWithName( Key_IA_SalesTax_LinkIDs.key      ,lkeys.IASalesTaxLinkids.New					,BuildKey2A );
	VersionControl.macBuildNewLogicalKeyWithName( key_fdic_bdid									   ,lkeys.FDICBdid.New									,BuildKey3 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_fdic_LinkIDs.key					   ,lkeys.FDICLinkIDs.New								,BuildKey3A );
	VersionControl.macBuildNewLogicalKeyWithName( Key_FL_FBN_BDID								   ,lkeys.FL_FBNBdid.New								,BuildKey4 	);
	VersionControl.macBuildNewLogicalKeyWithName( Key_FL_FBN_LinkIDs.key					 ,lkeys.FL_FBNLinkIDs.New							,BuildKey4A );
	VersionControl.macBuildNewLogicalKeyWithName( key_FL_NonProfit_BDID					   ,lkeys.FL_NonprofitBdid.New					,BuildKey5 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_FL_NonProfit_LinkIDs.key	   ,lkeys.FL_NonprofitLinkIDs.New				,BuildKey5A );
	VersionControl.macBuildNewLogicalKeyWithName( key_gov_phones_bdid						   ,lkeys.EmployeeDirsBdid.New					,BuildKey6 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_gov_phones_linkIDs.key			 ,lkeys.EmployeeDirsLinkIDs.New				,BuildKey6A );
	VersionControl.macBuildNewLogicalKeyWithName( Key_IRS_NonProfit_BDID					 ,lkeys.IRS_NonprofitBdid.New					,BuildKey7 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_IRS_NonProfit_linkIDs.key	   ,lkeys.IRS_NonprofitLinkIDs.New			,BuildKey7A );
	VersionControl.macBuildNewLogicalKeyWithName( key_ms_workers_comp_BDID				 ,lkeys.Ms_workers_CompBdid.New				,BuildKey8 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_ms_workers_comp_linkids.key  ,lkeys.Ms_workers_CompLinkIDs.New		,BuildKey8A );
	VersionControl.macBuildNewLogicalKeyWithName( key_or_workers_comp_bdid				 ,lkeys.Or_workers_CompBdid.New				,BuildKey9 	);
	VersionControl.macBuildNewLogicalKeyWithName( key_or_workers_comp_linkids.key	 ,lkeys.Or_workers_CompLinkIDs.New		,BuildKey9A );
  VersionControl.macBuildNewLogicalKeyWithName( key_sec_broker_dealer_BDID			 ,lkeys.Sec_broker_dealerBdid.New			,BuildKey10	);	
	VersionControl.macBuildNewLogicalKeyWithName( key_sec_broker_dealer_linkids.key,lkeys.Sec_broker_dealerlinkids.New	,BuildKey10A	);	
	
  	shared BuildAllKeys := parallel( BuildKey1 
																		,BuildKey1A 
																		,BuildKey2 
																		,BuildKey2A
																		,BuildKey3 
																		,BuildKey3A
																		,BuildKey4 
																		,BuildKey4A
																		,BuildKey5 
																		,BuildKey5A
																		,BuildKey6 
																		,BuildKey6A
																		,BuildKey7 
																		,BuildKey7A
																		,BuildKey8
																		,BuildKey8A
																		,BuildKey9 
																		,BuildKey9A
																		,BuildKey10
																		,BuildKey10A
														      );

	dall_keynames := lkeys.dAll_filenames;
	
	export all 		:=sequential(if(not VersionControl.DoAllFilesExist.fNamesBuilds(dall_keynames)
																,BuildAllKeys)
														 ,promote(pversion).new2built
												     );

	end;