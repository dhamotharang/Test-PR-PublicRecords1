IMPORT prte2;

EXPORT fSpray_InputFiles := function

	RETURN PARALLEL(
										prte2.SprayFiles.Spray_Raw_Data('GovKeys__FDIC__base__', 'fdic', 'govdata'),
										prte2.SprayFiles.Spray_Raw_Data('GovKeys__IRS__NonProfit__', 'irs', 'govdata'),
										prte2.SprayFiles.Spray_Raw_Data('GovKeys__SalesTax__CA__base__', 'salestax_ca', 'govdata'),
										prte2.SprayFiles.Spray_Raw_Data('GovKeys__SalesTax__IA__base__', 'salestax_ia', 'govdata'),
										prte2.SprayFiles.Spray_Raw_Data('GovKeys__SEC__Broker__base__', 'sec_broker', 'govdata')
									);

END;