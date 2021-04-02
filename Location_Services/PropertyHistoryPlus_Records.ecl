IMPORT Autokey_batch, doxie, iesp, LN_PropertyV2, ut, STD;

lPropHistCollusion := Location_Services.Layouts;

current_date := STD.Date.Today();

EXPORT PropertyHistoryPlus_Records(DATASET(Autokey_batch.Layouts.rec_inBatchMaster)       dIn,
																		Location_Services.iParam.PropHistHRI                   inMod,
																		iesp.propertyhistoryplus.t_PropertyHistoryPlusReportBy reportBy,
																		boolean includeAssignmentsAndReleases=false) :=
FUNCTION
	keyAddrFID       := LN_PropertyV2.key_addr_fid();
  keyAssessmentFID := LN_PropertyV2.key_assessor_fid();
	keySearchFID     := LN_PropertyV2.key_search_fid();

	// Get fares id based on address or apn
	dFaresId := Location_Services.Functions.GetFaresId(dIn,inMod);

	// Get address from the search file
	lPropHistCollusion.PropCleanNameAddr tGetPartyInfo(dFaresId le,keySearchFID ri) :=
	TRANSFORM,SKIP(ri.prim_name = '' or ri.zip = '')
		SELF.hri_address := [];
		SELF             := ri;
		SELF             := le;
	END;

	dPartyInfo := JOIN( dFaresId,
											keySearchFID,
													KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id)
											and WILD(RIGHT.which_orig)
											and WILD(RIGHT.source_code_2)
											//and KEYED(RIGHT.source_code_1 IN (if(includeAssignmentsAndReleases, ['O','S','B'], ['O','S'])) ),
											and KEYED(RIGHT.source_code_1 IN (if(includeAssignmentsAndReleases, [LN_PropertyV2.Constants.SOURCE_CD_PARTY_TP.Owner, LN_PropertyV2.Constants.SOURCE_CD_PARTY_TP.Seller, LN_PropertyV2.Constants.SOURCE_CD_PARTY_TP.Borrower],
																																																			[LN_PropertyV2.Constants.SOURCE_CD_PARTY_TP.Owner, LN_PropertyV2.Constants.SOURCE_CD_PARTY_TP.Seller])) ),
											tGetPartyInfo(LEFT,RIGHT),
											LEFT OUTER,ATMOST(Location_Services.consts.MaxFaresIDs));

	// Keep only good fares id where in the address cleaned and parsed correctly
	dFaresIdGood := JOIN(dFaresId,dPartyInfo,
												LEFT.ln_fares_id = RIGHT.ln_fares_id,
												TRANSFORM(LEFT),
												LIMIT(0),KEEP(1));

	dPropAddress := DEDUP(SORT(dPartyInfo(source_code[2] = 'P'),prim_range,predir,prim_name,suffix,postdir,sec_range,zip),
												prim_range,predir,prim_name,suffix,postdir,sec_range,zip);

	propAddressCnt := COUNT(dPropAddress);
	// Check if it resolved to multiple or no properties
	IF(propAddressCnt > 1,FAIL(203,doxie.ErrorCodes(203)), IF(propAddressCnt = 0, FAIL(10,doxie.ErrorCodes(10))));

	// Add HRI's for property address
	dPropAddressHRI := Location_Services.Functions.GetAddressHRI(dPropAddress);

	// Assessment data
	dLatestAssessment := Location_Services.Functions.GetLatestAssessment(dFaresIdGood);

	// Deeds data with collusion attributes
	dDeedTransactions := Location_Services.Functions.GetDeeds(dFaresIdGood,dPartyInfo,inMod, includeAssignmentsAndReleases);

	// Current residents
	dCurrentResidents := Location_Services.Functions.GetCurrentResidents(dPropAddress,inMod);

	// Historical sales price
	//Using dPropAddress since dIn might not have zip populated if searched by APN or dIn might have conflicting APN and address entered
	dHistSalesPriceByZip5 := Location_Services.Functions.AvgSalesAmtByZip(dPropAddress);
	dHistSalesPriceByZip4 := Location_Services.Functions.AvgSalesAmtByZip(dPropAddress,TRUE);

	// Format to iesp
	iesp.propertyhistoryplus.t_PropertyHistoryPlusReportResponse tFormat2Iesp() :=
	TRANSFORM
		// Property address transform
		iesp.share.t_AddressEx tPropAddressHRI(lPropHistCollusion.PropCleanNameAddr pInput) :=
		TRANSFORM
			SELF.StreetNumber        := pInput.prim_range;
			SELF.StreetPreDirection  := pInput.predir;
			SELF.StreetName          := pInput.prim_name;
			SELF.StreetSuffix        := pInput.suffix;
			SELF.StreetPostDirection := pInput.postdir;
			SELF.UnitDesignation     := pInput.unit_desig;
			SELF.UnitNumber          := pInput.sec_range;
			SELF.StreetAddress1      := '';
			SELF.StreetAddress2      := '';
			SELF.City                := pInput.v_city_name;
			SELF.State               := pInput.st;
			SELF.Zip5                := pInput.zip;
			SELF.Zip4                := pInput.zip4;
			SELF.County              := '';
			SELF.PostalCode          := '';
			SELF.StateCityZip        := '';
			SELF.HighRiskIndicators  := CHOOSEN(PROJECT(pInput.hri_address,
																									TRANSFORM(iesp.share.t_RiskIndicator,
																														SELF.Riskcode := LEFT.hri,SELF.Description := LEFT.desc)),
																					iesp.Constants.PropertyHistoryPlusReport.MaxCountHRI);
		END;

		// Property data
		iesp.propertyhistoryplus.t_PlusPropertyRecord tPropertyData(lPropHistCollusion.Assessments pInput) :=
		TRANSFORM
			SELF.ParcelNumber           := pInput.apna_or_pin_number;
			SELF.AlternateParcelNumber  := pInput.fares_iris_apn;
			SELF.SubdivisionName        := pInput.legal_subdivision_name;
			SELF.LandUse                := pInput.land_use_desc;
			SELF.YearBuilt              :=(INTEGER) pInput.year_built;
			SELF.LandValue              := pInput.assessed_land_value;
			SELF.ImprovementValue       := pInput.assessed_improvement_value;
			SELF.TotalValue             := pInput.fares_calculated_total_value;
			SELF.AssessedValue          := pInput.assessed_total_value;
			SELF.TaxAmount              := pInput.tax_amount;
			SELF.MarketLandValue        := pInput.market_land_value;
			SELF.MarketImprovementValue := pInput.market_improvement_value;
			SELF.TotalMarketValue       := pInput.market_total_value;
			SELF.TaxYear                := (INTEGER)pInput.tax_year;
			SELF.LivingSize             := (INTEGER)pInput.living_square_footage;
			SELF.LandSize               := (INTEGER)pInput.land_square_footage;
			SELF.Stories                := (INTEGER)pInput.no_of_stories;
			SELF.Bedrooms               := (INTEGER)pInput.no_of_bedrooms;
			SELF.FullBaths              := (INTEGER)pInput.no_of_baths;
			SELF.Condition              := pInput.condition_desc;
			SELF.Fireplace              := ut.fnTrim2Upper(pInput.fireplace_indicator) = 'Y';
			SELF.Pool                   := ut.fnTrim2Upper(pInput.pool_indicator) = 'Y';
			SELF.AirConditioning        := pInput.air_conditioning_desc;
			SELF.Heating                := pInput.heating_desc;
			SELF.Fuel                   := pInput.fuel_type_desc;
			SELF.Sewer                  := pInput.sewer_desc;
			SELF.Water                  := pInput.water_desc;
			SELF.Electric               := pInput.electric_energy_desc;
			SELF.Frame                  := pInput.frame_desc;
			SELF.Roof                   := pInput.roof_cover_desc;
			SELF.LegalDescription       := pInput.legal_brief_description;
			SELF.Style                  := pInput.style_desc;
		END;

		// Transactions
		iesp.propertyhistoryplus.t_PropertyHistoryPlusTransaction tTransactions(lPropHistCollusion.Deeds pInput) :=
		TRANSFORM

			// Buyer/Seller transform
			iesp.propertyhistoryplus.t_PropertyHistoryPlusIndividual tBuyerSeller(lPropHistCollusion.NameWithCollusionAttrs pInput) :=
			TRANSFORM
				SELF.Name               := iesp.ECL2ESP.SetName(pInput.fname,pInput.mname,pInput.lname,pInput.name_suffix,'',pInput.full_name);
				SELF.UniqueId           := INTFORMAT(pInput.did,12,0);
				SELF.HighRiskIndicators := CHOOSEN(PROJECT(pInput.hri_individual,
																										TRANSFORM(iesp.share.t_RiskIndicator,
																															SELF.RiskCode := LEFT.hri,SELF.Description := LEFT.desc)),
																						iesp.Constants.PropertyHistoryPlusReport.MaxCountHRI);
			END;

			// Buyer seller relationship
			iesp.propertyhistoryplus.t_BuyerSellerRelationship tBuyerSellerRelation(lPropHistCollusion.BuyerSellerRelationship pInput) :=
			TRANSFORM
				SELF.BuyerUniqueId  := INTFORMAT(pInput.buyer_did,12,0);
				SELF.SellerUniqueId := INTFORMAT(pInput.seller_did,12,0);
				SELF.Relationship   := pInput.relationship;
			END;

			// Main transaction transform
			SELF.SourcePropertyRecordId        := pInput.ln_fares_id;
			SELF.VendorSourceFlag              := pInput.vendor;
			SELF.GroupId                       := pInput.group_id;
			SELF.IsDuplicate                   := pInput.rec_type != Location_Services.consts.RecordType.Display;
			SELF.Deed.LenderName               := pInput.lender_name;
			SELF.Deed.MortgageAmount           := pInput.first_td_loan_amount + pInput.second_td_loan_amount;
			SELF.Deed.DocumentType             := pInput.document_type_desc;
			SELF.Deed.RecordingDate            := iesp.ECL2ESP.toDatestring8(pInput.recording_date);
			//SELF.Deed.BorrowerName           := pInput.name1;
			SELF.Deed.MortgagePayOffDate       := iesp.ECL2ESP.toDatestring8(pInput.first_td_due_date);
			SELF.Deed.RecordType               := pInput.record_type;
			SELF.Deed.PropertyDocument.Book    := pInput.recorder_book_number;
			SELF.Deed.PropertyDocument.Page    := pInput.recorder_page_number;
			SELF.Deed.PropertyDocument.Number  := pInput.document_number;
			SELF.Sale.TitleCompanyName         := pInput.title_company_name;
			SELF.Sale.SaleDate                 := iesp.ECL2ESP.toDatestring8(pInput.contract_date);
			SELF.Sale.MonthsSinceSaleDate      := IF((INTEGER)pInput.contract_date > current_date or pInput.contract_date = '',
																								-1,
																								ut.DaysApart((string)current_date,pInput.contract_date) DIV 30);
			SELF.Sale.SalePrice                := pInput.sales_price;
			SELF.Sale.DaysBetweenSales         := pInput.days;
			SELF.Sale.PricePercentChange       := pInput.price_change_percent;
			SELF.Sale.Buyers                   := CHOOSEN(PROJECT(pInput.buyers,tBuyerSeller(LEFT)),
																										iesp.Constants.PropertyHistoryPlusReport.MaxCountIndividual);
			SELF.Sale.Sellers                  := CHOOSEN(PROJECT(pInput.sellers,tBuyerSeller(LEFT)),
																										iesp.Constants.PropertyHistoryPlusReport.MaxCountIndividual);
			SELF.Sale.BuyerSellerRelationships := CHOOSEN(PROJECT(pInput.buyer_seller_relationship,tBuyerSellerRelation(LEFT)),
																										iesp.Constants.PropertyHistoryPlusReport.MaxCountRelationships);
			SELF.HighRiskIndicators            := CHOOSEN(PROJECT(pInput.hri_transactions,
																														TRANSFORM(iesp.share.t_RiskIndicator,
																																			SELF.RiskCode := LEFT.hri,SELF.Description := LEFT.desc)),
																										iesp.Constants.PropertyHistoryPlusReport.MaxCountHRI);
		END;

		// Current residents
		iesp.propertyhistoryplus.t_PropertyHistoryPlusResident tResidents(dCurrentResidents pInput) :=
		TRANSFORM
			SELF.Name         := iesp.ECL2ESP.SetName(pInput.fname,pInput.mname,pInput.lname,pInput.name_suffix,'');
			SELF.SSN          := pInput.ssn;
			SELF.DateLastSeen := iesp.ECL2ESP.toDateYM(pInput.dt_last_seen);
			SELF.UniqueID     := INTFORMAT(pInput.did,12,0);
		END;

		// Historical sales price by zip or zip4
		iesp.propertyhistoryplus.t_PlusHistoricalValue tHistSalesPrice(RECORDOF(LN_Propertyv2.key_deed_zip_avg_sales_price) pInput) :=
		TRANSFORM
			SELF.Date            := ROW({pInput.year,pInput.month,0},iesp.share.t_Date);
			SELF.ZipAveragePrice := (STRING)ROUND(pInput.avg_sales_price);
		END;

		// Main iesp transform
		SELF._Header              := iesp.ECL2ESP.GetHeaderRow();
		SELF.InputEcho            := reportBy;
		SELF.Address              := PROJECT(dPropAddressHRI,tPropAddressHRI(LEFT))[1]; //will have only one property address since we fail the service if the input search resolves to multiple addresses
		SELF.PropertyRecord       := PROJECT(dLatestAssessment,tPropertyData(LEFT))[1];
		SELF.Transactions         := CHOOSEN(PROJECT(dDeedTransactions,tTransactions(LEFT)),
																					iesp.Constants.PropertyHistoryPlusReport.MaxCountTransactions);
		SELF.Residents            := CHOOSEN(PROJECT(dCurrentResidents,tResidents(LEFT)),
																					iesp.Constants.PropertyHistoryPlusReport.MaxCountResidents);
		SELF.Zip5HistoricalValues := CHOOSEN(PROJECT(dHistSalesPriceByZip5,tHistSalesPrice(LEFT)),
																					iesp.Constants.PropertyHistoryPlusReport.MaxCountHistoricalValues);
		SELF.Zip4HistoricalValues := CHOOSEN(PROJECT(dHistSalesPriceByZip4,tHistSalesPrice(LEFT)),
																					iesp.Constants.PropertyHistoryPlusReport.MaxCountHistoricalValues);
	END;

	// dFormat2Iesp := IF(EXISTS(dFaresId),DATASET([tFormat2Iesp()]));
	dFormat2Iesp := DATASET([tFormat2Iesp()]);

	#IF(Location_Services.Consts.Debug.Main)
		OUTPUT(dIn,NAMED('dIn_Records'));
		OUTPUT(dFaresId,NAMED('dSearchFaresId'));
		OUTPUT(dPartyInfo,NAMED('dPartyInfo'));
		OUTPUT(dFaresIdGood,NAMED('dFaresIdGood'));
		OUTPUT(dPropAddress,NAMED('dPropAddress'));
		OUTPUT(dPropAddressHRI,NAMED('dPropAddressHRI'));
		OUTPUT(dLatestAssessment,NAMED('dLatestAssessment'));
		OUTPUT(dDeedTransactions,NAMED('dTransactions'));
		OUTPUT(dCurrentResidents,NAMED('dCurrentResidents'));
		OUTPUT(dHistSalesPriceByZip,NAMED('dHistSalesPriceByZip'),all);
	#END

	RETURN dFormat2Iesp;
END;
