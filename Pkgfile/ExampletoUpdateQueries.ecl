EXPORT ExampletoUpdateQueries := function
	ds := dataset([
								// {'Business_Risk_BIP.Business_Shell_Batch_Service_with_SBFE','1','true',''},
								// {'Business_Risk_BIP.Business_Shell_Service_with_SBFE','1','true',''},
								{'Business_Risk_BIP.ProdData_with_SBFE','1','true',''}
								// {'Business_Risk_BIP.ProdData','1','true',''}
								// {'Risk_Indicators.Boca_Shell_test1','1','true',''},
								// {'Risk_Indicators.Boca_Shell_test2','1','true',''},
								// {'Risk_Indicators.Boca_Shell_test3','1','true',''},
								// {'Risk_Indicators.Boca_Shell_test4','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_base1','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_base2','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_base3','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_base4','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_test1','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_test2','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_test3','1','true',''},
								// {'Risk_Indicators.Boca_Shell_FCRA_test4','1','true',''},
								// {'Risk_Indicators.InstantID_base1','1','true',''},
								// {'Risk_Indicators.InstantID_base2','1','true',''},
								// {'Risk_Indicators.InstantID_test1','1','true',''},
								// {'Risk_Indicators.InstantID_test2','1','true',''},
								// {'Risk_Indicators.BocaShell50_Batch_Service_base1','1','true',''},
								// {'Risk_Indicators.BocaShell50_Batch_Service_test1','1','true',''},
								// {'Business_Risk_BIP.Business_Shell_Service_base1','1','true',''},
								// {'Business_Risk_BIP.Business_Shell_Service_base2','1','true',''},
								// {'Business_Risk_BIP.Business_Shell_Service_test1','1','true',''},
								// {'Business_Risk_BIP.Business_Shell_Service_test2','1','true',''}
								//{'VehicleV2_Services.VehicleRegSearchService','1','true',''}
								],pkgfile.layouts.flat_layouts.queries);

return pkgfile.add.Queries(ds);
end;