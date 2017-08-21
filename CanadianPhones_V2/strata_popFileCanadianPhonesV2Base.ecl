IMPORT strata, Statistics, ut;

EXPORT strata_popFileCanadianPhonesV2Base(string pversion) := FUNCTION

	ds := CanadianPhones_V2.file_CanadianWhitePagesBase;
	//DF-16788 Modified to remove warning messages
	shared Strata_Stats(dataset(CanadianPhones_V2.layoutCanadianWhitepagesBase)	pInput=ds) := MODULE
		Statistics.mac_Strata_Pops(pInput,dNoGrouping);
		Statistics.mac_Strata_Pops(pInput,dVendor, 'vendor');
		Statistics.mac_Strata_Pops(pInput,dListingType, 'listing_type');
		Statistics.mac_Strata_Pops(pInput,dProvince, 'province');
	END;
	dUpdate := Strata_Stats(ds);
	//no grouping
	strata.createXMLStats(dUpdate.dNoGrouping,'CanadianPhones_V2','data',pversion,'',resultsNoGrouping,'View','Population');

	//group on vendor
	strata.createXMLStats(dUpdate.dVendor,'CanadianPhones_V2','data',pversion,'',resultsVendor,'Vendor','Population');

	//group on listing type - R for residential, B for business
	strata.createXMLStats(dUpdate.dListingType,'CanadianPhones_V2','data',pversion,'',resultsListingType,'Listing_Type','Population');
	
	//group on province
	strata.createXMLStats(dUpdate.dProvince,'CanadianPhones_V2','data',pversion,'',resultsProvince,'Province','Population');

	return parallel(
								 resultsNoGrouping		
								,resultsVendor	
								,resultsListingType	
								,resultsProvince			
							);

END;
