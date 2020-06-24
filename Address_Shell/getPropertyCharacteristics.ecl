/* 
 * getPropertyCharacteristics: This function takes in the input and calls out to
 * PropertyCharacteristics_Services.ReportService() to acquire Property Characteristic
 * information.  It then formats the result in a flat layout with the best possible
 * information.
 */

IMPORT iesp, InsuranceContext_iesp, ut, Gateway;

EXPORT Address_Shell.layoutPropertyCharacteristics getPropertyCharacteristics (DATASET(Address_Shell.layoutInput) input, UNSIGNED1 propertyInformationAttributesVersion, UNSIGNED1 ercAttributesVersion,
           DATASET(Gateway.Layouts.Config) gateway_cfg) := FUNCTION
 
/* ************************************************************
	 *        Place the input into the working layout:          *
	 ************************************************************ */											
	Address_Shell.layoutPropertyCharacteristics intoWorking(Address_Shell.layoutInput le) := TRANSFORM
		SELF.Input.StreetNumber := le.StreetNumber;
		SELF.Input.StreetPreDirection := le.StreetPreDirection;
		SELF.Input.StreetName := le.StreetName;
		SELF.Input.StreetSuffix := le.StreetSuffix;
		SELF.Input.StreetPostDirection := le.StreetPostDirection;
		SELF.Input.UnitDesignation := le.UnitDesignation;
		SELF.Input.UnitNumber := le.UnitNumber;
		SELF.Input.StreetAddress1 := le.StreetAddress1;
		SELF.Input.StreetAddress2 := le.StreetAddress2;
		SELF.Input.City := le.City;
		SELF.Input.State := le.State;
		SELF.Input.Zip5 := le.Zip5;
		SELF.Input.Zip4 := le.Zip4;
		SELF.Input.County := le.County;
		SELF.Input.PostalCode := le.PostalCode;
		SELF.Input.StateCityZip := le.StateCityZip;
		SELF.Input.GeoLat := le.GeoLat;
		SELF.Input.GeoLong := le.GeoLong;
		SELF.Input.GeoLink := le.GeoLink;

		SELF.Input := le;
		SELF := [];
	END;
	justInput := PROJECT(input, intoWorking(LEFT));

/* ************************************************************
	 *      Call out to the ReportService Internal gateway:     *
	 ************************************************************ */
	reportServiceResult := Address_Shell.propertyCharacteristicsSoapCallFunction(input, propertyInformationAttributesVersion, ercAttributesVersion, gateway_cfg);
		
/* ************************************************************
	 *  Get best Property Characteristic Data for the Address:  *
	 ************************************************************ */
	report := PROJECT(reportServiceResult, TRANSFORM(iesp.property_info.t_PropertyInformationReport, SELF := LEFT.Report));
	
	propertyData := SORT(report.PropertyData, RiskAddress.streetnumber, RiskAddress.streetpredirection, RiskAddress.streetname, RiskAddress.streetsuffix, RiskAddress.streetpostdirection, 
																									RiskAddress.unitdesignation, RiskAddress.unitnumber, RiskAddress.streetaddress1, RiskAddress.streetaddress2, RiskAddress.city, 
																									RiskAddress.state, RiskAddress.zip5, RiskAddress.zip4, RiskAddress.county, RiskAddress.postalcode);
	
	// Below are what the various Confidence Factor values indicate
	FARES := 300; // Keep first
	Fidelity := 200; // Keep second
	Default := 900; // Keep third
	MLS := 100; // Last resort
	NoRecord := 0;
	keepLeft (leftConfidenceFactor, rightConfidenceFactor) := MAP((INTEGER)leftConfidenceFactor = FARES																																			=> TRUE, // If we have FARES data - keep it over all others
																																(INTEGER)leftConfidenceFactor = Fidelity AND (INTEGER)rightConfidenceFactor != FARES											=> TRUE, // If we have Fidelity but no FARES, keep the Fidelity
																																(INTEGER)leftConfidenceFactor = Default AND (INTEGER)rightConfidenceFactor NOT IN [FARES, Fidelity]				=> TRUE, // If we have Default data but no FARES/Fidelity, keep the Default
																																(INTEGER)leftConfidenceFactor = MLS AND (INTEGER)rightConfidenceFactor NOT IN [FARES, Fidelity, Default]	=> TRUE, // If we have MLS but nothing better to go with, keep MLS
																																(INTEGER)rightConfidenceFactor > NoRecord																																	=> FALSE, // Whatever we have on the right side is "better" than what's on the left side
																																																																																						 TRUE); // There was nothing on the right side, just keep the left side
		
	iesp.property_info.t_PropertyDataItem rollupPropertyData (iesp.property_info.t_PropertyDataItem le, iesp.property_info.t_PropertyDataItem ri) := TRANSFORM
		/*******************************************
		 *        Input Address Information        *
		 ******************************************* */
		/* There should be no change in the address data other than census tract */
		SELF.RiskAddress.CensusTract := IF(TRIM(le.RiskAddress.CensusTract) <> '', le.RiskAddress.CensusTract, ri.RiskAddress.CensusTract);
		SELF.RiskAddress := le.RiskAddress;
		
		/*******************************************
		 *     Property Attribute Information      *
		 ******************************************* */
		SELF.propertyattributes.LivingAreaSF := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.propertyattributes.livingareasf, ri.propertyattributes.livingareasf);
		SELF.propertyattributes.Stories := IF(keepLeft(le.confidencefactor1.numberofstories, ri.confidencefactor1.numberofstories), le.propertyattributes.stories, ri.propertyattributes.stories);
		SELF.propertyattributes.Bedrooms := IF(keepLeft(le.confidencefactor1.numberofbedrooms, ri.confidencefactor1.numberofbedrooms), le.propertyattributes.bedrooms, ri.propertyattributes.bedrooms);
		SELF.propertyattributes.Baths := IF(keepLeft(le.confidencefactor1.numberofbaths, ri.confidencefactor1.numberofbaths), le.propertyattributes.baths, ri.propertyattributes.baths);
		SELF.propertyattributes.Fireplaces := IF(keepLeft(le.confidencefactor1.numberoffireplaces, ri.confidencefactor1.numberoffireplaces), le.propertyattributes.fireplaces, ri.propertyattributes.fireplaces);
		SELF.propertyattributes.Pool := IF(keepLeft(le.confidencefactor1.poolindicator, ri.confidencefactor1.poolindicator), le.propertyattributes.pool, ri.propertyattributes.pool);
		SELF.propertyattributes.AC := IF(keepLeft(le.confidencefactor1.airconditioningtypecode, ri.confidencefactor1.airconditioningtypecode), le.propertyattributes.ac, ri.propertyattributes.ac);
		SELF.propertyattributes.YearBuilt := IF(keepLeft(le.confidencefactor1.yearbuilt, ri.confidencefactor1.yearbuilt), le.propertyattributes.yearbuilt, ri.propertyattributes.yearbuilt);
		// SELF.propertyattributes.Slope := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.propertyattributes.slope, ri.propertyattributes.slope);
		SELF.propertyattributes.QualityOfStruct := IF(keepLeft(le.confidencefactor1.qualityofstructurecode, ri.confidencefactor1.qualityofstructurecode), le.propertyattributes.qualityofstruct, ri.propertyattributes.qualityofstruct);
		// SELF.propertyattributes.ReplacementCostReportId := IF(keepLeft(le.confidencefactor1.replacementcostreportid, ri.confidencefactor1.replacementcostreportid), le.propertyattributes.replacementcostreportid, ri.propertyattributes.replacementcostreportid);
		// SELF.propertyattributes.PolicyCoverageValue := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.propertyattributes.livingareasf, ri.propertyattributes.livingareasf);
		SELF.propertyattributes.FireplaceIndicator := IF(keepLeft(le.confidencefactor1.fireplaceindicator, ri.confidencefactor1.fireplaceindicator), le.propertyattributes.fireplaceindicator, ri.propertyattributes.fireplaceindicator);
		SELF.propertyattributes.Units := IF(keepLeft(le.confidencefactor1.numberofunits, ri.confidencefactor1.numberofunits), le.propertyattributes.units, ri.propertyattributes.units);
		SELF.propertyattributes.Rooms := IF(keepLeft(le.confidencefactor1.numberofrooms, ri.confidencefactor1.numberofrooms), le.propertyattributes.rooms, ri.propertyattributes.rooms);
		SELF.propertyattributes.FullBaths := IF(keepLeft(le.confidencefactor1.numberoffullbaths, ri.confidencefactor1.numberoffullbaths), le.propertyattributes.fullbaths, ri.propertyattributes.fullbaths);
		SELF.propertyattributes.HalfBaths := IF(keepLeft(le.confidencefactor1.numberofhalfbaths, ri.confidencefactor1.numberofhalfbaths), le.propertyattributes.halfbaths, ri.propertyattributes.halfbaths);
		SELF.propertyattributes.BathFixtures := IF(keepLeft(le.confidencefactor1.numberofbathfixtures, ri.confidencefactor1.numberofbathfixtures), le.propertyattributes.bathfixtures, ri.propertyattributes.bathfixtures);
		SELF.propertyattributes.EffectiveYearBuilt := IF(keepLeft(le.confidencefactor1.effectiveyearbuilt, ri.confidencefactor1.effectiveyearbuilt), le.propertyattributes.effectiveyearbuilt, ri.propertyattributes.effectiveyearbuilt);
		// SELF.propertyattributes.ConditionOfStructure := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.propertyattributes.livingareasf, ri.propertyattributes.livingareasf);
		SELF.propertyattributes.BuildingAreaSF := IF(keepLeft(le.confidencefactor1.buildingsquarefootage, ri.confidencefactor1.buildingsquarefootage), le.propertyattributes.buildingareasf, ri.propertyattributes.buildingareasf);
		SELF.propertyattributes.GroundFloorAreaSF := IF(keepLeft(le.confidencefactor1.groundfloorsquarefootage, ri.confidencefactor1.groundfloorsquarefootage), le.propertyattributes.groundfloorareasf, ri.propertyattributes.groundfloorareasf);
		SELF.propertyattributes.BasementAreaSF := IF(keepLeft(le.confidencefactor1.basementsquarefootage, ri.confidencefactor1.basementsquarefootage), le.propertyattributes.basementareasf, ri.propertyattributes.basementareasf);
		SELF.propertyattributes.GarageAreaSF := IF(keepLeft(le.confidencefactor1.garagesquarefootage, ri.confidencefactor1.garagesquarefootage), le.propertyattributes.garageareasf, ri.propertyattributes.garageareasf);
		// SELF.propertyattributes.TypeOfResidence := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.propertyattributes.livingareasf, ri.propertyattributes.livingareasf);
		SELF.propertyattributes.FloodZonePanelNumber := IF(keepLeft(le.confidencefactor1.floodzonepanelnumber, ri.confidencefactor1.floodzonepanelnumber), le.propertyattributes.floodzonepanelnumber, ri.propertyattributes.floodzonepanelnumber);
		SELF.propertyattributes.StoriesType := IF(keepLeft(le.confidencefactor1.storiestype, ri.confidencefactor1.storiestype), le.propertyattributes.storiestype, ri.propertyattributes.storiestype);
		
		/*******************************************
		 *   Property Characteristic Information   *
		 ******************************************* */
		/* This can get a little tricky - I need to keep specific rows from the appropriate dataset, and then mash them back into a dataset */
		unknownTypes := ['UNK', 'UD0']; // Try to use the known type if possible
		
		leAC := le.propertycharacteristics (category = '001');
		riAC := ri.propertycharacteristics (category = '001');
		cat001 := IF(keepLeft(le.confidencefactor1.airconditioningtypecode, ri.confidencefactor1.airconditioningtypecode) AND EXISTS(leAC) AND leAC[1].material NOT IN unknownTypes, 
																	leAC, 
																	IF(EXISTS(riAC), riAC, leAC)); // If there is data at the right, use it - if not continue with the left side data
		
		leFloor := le.propertycharacteristics (category = '003');
		riFloor := ri.propertycharacteristics (category = '003');
		cat003 := IF(keepLeft(le.confidencefactor1.floortype, ri.confidencefactor1.floortype) AND EXISTS(leFloor) AND leFloor[1].material NOT IN unknownTypes, 
																	leFloor, 
																	IF(EXISTS(riFloor), riFloor, leFloor));
		
		leExteriorWall := le.propertycharacteristics (category = '005');
		riExteriorWall := ri.propertycharacteristics (category = '005');
		cat005 := IF(keepLeft(le.confidencefactor1.exteriorwalltype, ri.confidencefactor1.exteriorwalltype) AND EXISTS(leExteriorWall) AND leExteriorWall[1].material NOT IN unknownTypes, 
																	leExteriorWall, 
																	IF(EXISTS(riExteriorWall), riExteriorWall, leExteriorWall));
		
		leRoof := le.propertycharacteristics (category = '006');
		riRoof := ri.propertycharacteristics (category = '006');
		cat006 := IF(keepLeft(le.confidencefactor1.roofcovertype, ri.confidencefactor1.roofcovertype) AND EXISTS(leRoof) AND leRoof[1].material NOT IN unknownTypes, 
																	leRoof, 
																	IF(EXISTS(riRoof), riRoof, leRoof));
		
		leFoundation := le.propertycharacteristics (category = '007');
		riFoundation := ri.propertycharacteristics (category = '007');
		cat007 := IF(keepLeft(le.confidencefactor1.foundationtype, ri.confidencefactor1.foundationtype) AND EXISTS(leFoundation) AND leFoundation[1].material NOT IN unknownTypes, 
																	leFoundation, 
																	IF(EXISTS(riFoundation), riFoundation, leFoundation));
		
		leFireplace := le.propertycharacteristics (category = '008');
		riFireplace := ri.propertycharacteristics (category = '008');
		cat008 := IF(keepLeft(le.confidencefactor1.fireplacetype, ri.confidencefactor1.fireplacetype) AND EXISTS(leFireplace) AND leFireplace[1].material NOT IN unknownTypes, 
																	leFireplace, 
																	IF(EXISTS(riFireplace), riFireplace, leFireplace));
		
		leParking := le.propertycharacteristics (category = '012');
		riParking := ri.propertycharacteristics (category = '012');
		cat012 := IF(keepLeft(le.confidencefactor1.parkingtype, ri.confidencefactor1.parkingtype) AND EXISTS(leParking) AND leParking[1].material NOT IN unknownTypes, 
																	leParking, 
																	IF(EXISTS(riParking), riParking, leParking));
		
		leBasement := le.propertycharacteristics (category = '013');
		riBasement := ri.propertycharacteristics (category = '013');
		cat013 := IF(keepLeft(le.confidencefactor1.basementfinishtype, ri.confidencefactor1.basementfinishtype) AND EXISTS(leBasement) AND leBasement[1].material NOT IN unknownTypes, 
																	leBasement, 
																	IF(EXISTS(riBasement), riBasement, leBasement));
		
		leWater := le.propertycharacteristics (category = '016');
		riWater := ri.propertycharacteristics (category = '016');
		cat016 := IF(keepLeft(le.confidencefactor1.watertype, ri.confidencefactor1.watertype) AND EXISTS(leWater) AND leWater[1].material NOT IN unknownTypes, 
																	leWater, 
																	IF(EXISTS(riWater), riWater, leWater));
		
		leStyle := le.propertycharacteristics (category = '019');
		riStyle := ri.propertycharacteristics (category = '019');
		cat019 := IF(keepLeft(le.confidencefactor1.styletype, ri.confidencefactor1.styletype) AND EXISTS(leStyle) AND leStyle[1].material NOT IN unknownTypes, 
																	leStyle, 
																	IF(EXISTS(riStyle), riStyle, leStyle));
		
		leFuel := le.propertycharacteristics (category = '020');
		riFuel := ri.propertycharacteristics (category = '020');
		cat020 := IF(keepLeft(le.confidencefactor1.fueltype, ri.confidencefactor1.fueltype) AND EXISTS(leFuel) AND leFuel[1].material NOT IN unknownTypes, 
																	leFuel, 
																	IF(EXISTS(riFuel), riFuel, leFuel));
		
		leGarage := le.propertycharacteristics (category = '021');
		riGarage := ri.propertycharacteristics (category = '021');
		cat021 := IF(keepLeft(le.confidencefactor1.garagecarporttype, ri.confidencefactor1.garagecarporttype) AND EXISTS(leGarage) AND leGarage[1].material NOT IN unknownTypes, 
																	leGarage, 
																	IF(EXISTS(riGarage), riGarage, leGarage));
		
		leConstruction := le.propertycharacteristics (category = '022');
		riConstruction := ri.propertycharacteristics (category = '022');
		cat022 := IF(keepLeft(le.confidencefactor1.constructiontype, ri.confidencefactor1.constructiontype) AND EXISTS(leConstruction) AND leConstruction[1].material NOT IN unknownTypes, 
																	leConstruction, 
																	IF(EXISTS(riConstruction), riConstruction, leConstruction));
		
		/* There is no category 023 returned from the service. */
		leHeating := le.propertycharacteristics (category = '024');
		riHeating := ri.propertycharacteristics (category = '024');
		cat024 := IF(keepLeft(le.confidencefactor1.heatingtype, ri.confidencefactor1.heatingtype) AND EXISTS(leHeating) AND leHeating[1].material NOT IN unknownTypes, 
																	leHeating, 
																	IF(EXISTS(riHeating), riHeating, leHeating));
		
		leFrame := le.propertycharacteristics (category = '025');
		riFrame := ri.propertycharacteristics (category = '025');
		cat025 := IF(keepLeft(le.confidencefactor1.frametype, ri.confidencefactor1.frametype) AND EXISTS(leFrame) AND leFrame[1].material NOT IN unknownTypes, 
																	leFrame, 
																	IF(EXISTS(riFrame), riFrame, leFrame));
		
		leSewer := le.propertycharacteristics (category = '026');
		riSewer := ri.propertycharacteristics (category = '026');
		cat026 := IF(keepLeft(le.confidencefactor1.sewertype, ri.confidencefactor1.sewertype) AND EXISTS(leSewer) AND leSewer[1].material NOT IN unknownTypes, 
																	leSewer, 
																	IF(EXISTS(riSewer), riSewer, leSewer));
		
		lePool := le.propertycharacteristics (category = '027');
		riPool := ri.propertycharacteristics (category = '027');
		cat027 := IF(keepLeft(le.confidencefactor1.pooltype, ri.confidencefactor1.pooltype) AND EXISTS(lePool) AND lePool[1].material NOT IN unknownTypes, 
																	lePool, 
																	IF(EXISTS(riPool), riPool, lePool));
		
		propertyChars := cat001 + cat003 + cat005 + cat006 + cat007 + cat008 + cat012 + cat013 + cat016 + cat019 + cat020 + cat021 + cat022 + cat024 + cat025 + cat026 + cat027;
		SELF.propertycharacteristics := propertyChars;
		
		/*******************************************
		 *           Mortgage Information          *
		 ******************************************* */
		// For some reason Mortgages is another dataset - get what's needed and mash it together
		mortgagecompanyname := IF(keepLeft(le.confidencefactor2.mortgagecompanyname, ri.confidencefactor2.mortgagecompanyname), le.mortgages[1].mortgagecompanyname, ri.mortgages[1].mortgagecompanyname);
		mortgagetype := IF(keepLeft(le.confidencefactor2.mortgagecompanyname, ri.confidencefactor2.mortgagecompanyname), le.mortgages[1].mortgagetype, ri.mortgages[1].mortgagetype);
		mortgagetypedesc := IF(keepLeft(le.confidencefactor2.mortgagecompanyname, ri.confidencefactor2.mortgagecompanyname), le.mortgages[1].mortgagetypedesc, ri.mortgages[1].mortgagetypedesc);
		loanamount := IF(keepLeft(le.confidencefactor2.loanamount, ri.confidencefactor2.loanamount), le.mortgages[1].loanamount, ri.mortgages[1].loanamount);
		loantypecode := IF(keepLeft(le.confidencefactor2.loantypecode, ri.confidencefactor2.loantypecode), le.mortgages[1].loantypecode, ri.mortgages[1].loantypecode);
		loantype := IF(keepLeft(le.confidencefactor2.loantypecode, ri.confidencefactor2.loantypecode), le.mortgages[1].loantype, ri.mortgages[1].loantype);
		interestrate := IF(keepLeft(le.confidencefactor2.interestratetypecode, ri.confidencefactor2.interestratetypecode), le.mortgages[1].interestrate, ri.mortgages[1].interestrate);
		interestratetypecode := IF(keepLeft(le.confidencefactor2.interestratetypecode, ri.confidencefactor2.interestratetypecode), le.mortgages[1].interestratetypecode, ri.mortgages[1].interestratetypecode);
		
		SELF.mortgages := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.property_info.t_PropertyMortgageRecordReport,
																													SELF.mortgagecompanyname := mortgagecompanyname;
																													SELF.mortgagetype := mortgagetype;
																													SELF.mortgagetypedesc := mortgagetypedesc;
																													SELF.loanamount := loanamount;
																													SELF.loantypecode := loantypecode;
																													SELF.loantype := loantype;
																													SELF.interestrate := interestrate;
																													SELF.interestratetypecode := interestratetypecode;
																													SELF := le.mortgages[1];
																													SELF := []));

		/*******************************************
		 *       Property Sales Information        *
		 ******************************************* */
		SELF.propertysales.deedrecordingdate := IF(keepLeft(le.confidencefactor2.deedrecordingdate, ri.confidencefactor2.deedrecordingdate), le.propertysales.deedrecordingdate, ri.propertysales.deedrecordingdate);
		SELF.propertysales.salesdate := IF(keepLeft(le.confidencefactor2.salesdate, ri.confidencefactor2.salesdate), le.propertysales.salesdate, ri.propertysales.salesdate);
		SELF.propertysales.deeddocumentnumber := IF(keepLeft(le.confidencefactor2.deeddocumentnumber, ri.confidencefactor2.deeddocumentnumber), le.propertysales.deeddocumentnumber, ri.propertysales.deeddocumentnumber);
		SELF.propertysales.salesamount := IF(keepLeft(le.confidencefactor2.salesamount, ri.confidencefactor2.salesamount), le.propertysales.salesamount, ri.propertysales.salesamount);
		SELF.propertysales.salestypecode := IF(keepLeft(le.confidencefactor2.salestypecode, ri.confidencefactor2.salestypecode), le.propertysales.salestypecode, ri.propertysales.salestypecode);
		SELF.propertysales.salestype := IF(keepLeft(le.confidencefactor2.salestypecode, ri.confidencefactor2.salestypecode), le.propertysales.salestype, ri.propertysales.salestype);
		SELF.propertysales.salesfullpart := IF(keepLeft(le.confidencefactor2.salefullorpart, ri.confidencefactor2.salefullorpart), le.propertysales.salesfullpart, ri.propertysales.salesfullpart);

		/*******************************************
		 *        Property Tax Information         *
		 ******************************************* */
		SELF.propertytax.fipscode := IF(keepLeft(le.confidencefactor1.fipscode, ri.confidencefactor1.fipscode), le.propertytax.fipscode, ri.propertytax.fipscode);
		SELF.propertytax.landusecode := IF(keepLeft(le.confidencefactor1.landusecode, ri.confidencefactor1.landusecode), le.propertytax.landusecode, ri.propertytax.landusecode);
		SELF.propertytax.landuse := IF(keepLeft(le.confidencefactor1.landusecode, ri.confidencefactor1.landusecode), le.propertytax.landuse, ri.propertytax.landuse);
		SELF.propertytax.propertytypecode := IF(keepLeft(le.confidencefactor1.propertytypecode, ri.confidencefactor1.propertytypecode), le.propertytax.propertytypecode, ri.propertytax.propertytypecode);
		SELF.propertytax.propertytype := IF(keepLeft(le.confidencefactor1.propertytypecode, ri.confidencefactor1.propertytypecode), le.propertytax.propertytype, ri.propertytax.propertytype);
		SELF.propertytax.lotsize := IF(keepLeft(le.confidencefactor1.lotsize, ri.confidencefactor1.lotsize), le.propertytax.lotsize, ri.propertytax.lotsize);
		SELF.propertytax.lotfrontfootage := IF(keepLeft(le.confidencefactor1.lotfrontfootage, ri.confidencefactor1.lotfrontfootage), le.propertytax.lotfrontfootage, ri.propertytax.lotfrontfootage);
		SELF.propertytax.lotdepthfootage := IF(keepLeft(le.confidencefactor1.lotdepthfootage, ri.confidencefactor1.lotdepthfootage), le.propertytax.lotdepthfootage, ri.propertytax.lotdepthfootage);
		SELF.propertytax.acres := IF(keepLeft(le.confidencefactor1.acres, ri.confidencefactor1.acres), le.propertytax.acres, ri.propertytax.acres);
		SELF.propertytax.totalassessedvalue := IF(keepLeft(le.confidencefactor1.totalassessedvalue, ri.confidencefactor1.totalassessedvalue), le.propertytax.totalassessedvalue, ri.propertytax.totalassessedvalue);
		SELF.propertytax.totalcalculatedvalue := IF(keepLeft(le.confidencefactor1.totalcalculatedvalue, ri.confidencefactor1.totalcalculatedvalue), le.propertytax.totalcalculatedvalue, ri.propertytax.totalcalculatedvalue);
		SELF.propertytax.totalmarketvalue := IF(keepLeft(le.confidencefactor1.totalmarketvalue, ri.confidencefactor1.totalmarketvalue), le.propertytax.totalmarketvalue, ri.propertytax.totalmarketvalue);
		SELF.propertytax.totallandvalue := IF(keepLeft(le.confidencefactor1.totallandvalue, ri.confidencefactor1.totallandvalue), le.propertytax.totallandvalue, ri.propertytax.totallandvalue);
		SELF.propertytax.marketlandvalue := IF(keepLeft(le.confidencefactor1.marketlandvalue, ri.confidencefactor1.marketlandvalue), le.propertytax.marketlandvalue, ri.propertytax.marketlandvalue);
		SELF.propertytax.assessedlandvalue := IF(keepLeft(le.confidencefactor1.assessedlandvalue, ri.confidencefactor1.assessedlandvalue), le.propertytax.assessedlandvalue, ri.propertytax.assessedlandvalue);
		SELF.propertytax.improvementvalue := IF(keepLeft(le.confidencefactor1.improvementvalue, ri.confidencefactor1.improvementvalue), le.propertytax.improvementvalue, ri.propertytax.improvementvalue);
		SELF.propertytax.assessedyear := IF(keepLeft(le.confidencefactor1.assessedyear, ri.confidencefactor1.assessedyear), le.propertytax.assessedyear, ri.propertytax.assessedyear);
		SELF.propertytax.taxbillingyear := IF(keepLeft(le.confidencefactor1.taxbillingyear, ri.confidencefactor1.taxbillingyear), le.propertytax.taxbillingyear, ri.propertytax.taxbillingyear);
		SELF.propertytax.homesteadexemption := IF(keepLeft(le.confidencefactor1.homesteadexemptionindicator, ri.confidencefactor1.homesteadexemptionindicator), le.propertytax.homesteadexemption, ri.propertytax.homesteadexemption);
		SELF.propertytax.taxamount := IF(keepLeft(le.confidencefactor1.taxamount, ri.confidencefactor1.taxamount), le.propertytax.taxamount, ri.propertytax.taxamount);
		SELF.propertytax.percentimproved := IF(keepLeft(le.confidencefactor1.percentimproved, ri.confidencefactor1.percentimproved), le.propertytax.percentimproved, ri.propertytax.percentimproved);
		SELF.propertytax.assessmentdocumentnumber := IF(keepLeft(le.confidencefactor1.assessmentdocumentnumber, ri.confidencefactor1.assessmentdocumentnumber), le.propertytax.assessmentdocumentnumber, ri.propertytax.assessmentdocumentnumber);
		SELF.propertytax.assessmentrecordingdate := IF(keepLeft(le.confidencefactor1.assessmentrecordingdate, ri.confidencefactor1.assessmentrecordingdate), le.propertytax.assessmentrecordingdate, ri.propertytax.assessmentrecordingdate);
		SELF.propertytax.county := IF(keepLeft(le.confidencefactor1.county, ri.confidencefactor1.county), le.propertytax.county, ri.propertytax.county);
		SELF.propertytax.apnnumber := IF(keepLeft(le.confidencefactor1.apnnumber, ri.confidencefactor1.apnnumber), le.propertytax.apnnumber, ri.propertytax.apnnumber);
		SELF.propertytax.blocknumber := IF(keepLeft(le.confidencefactor1.blocknumber, ri.confidencefactor1.blocknumber), le.propertytax.blocknumber, ri.propertytax.blocknumber);
		SELF.propertytax.subdivisionname := IF(keepLeft(le.confidencefactor1.subdivisionname, ri.confidencefactor1.subdivisionname), le.propertytax.subdivisionname, ri.propertytax.subdivisionname);
		SELF.propertytax.townshipname := IF(keepLeft(le.confidencefactor1.townshipname, ri.confidencefactor1.townshipname), le.propertytax.townshipname, ri.propertytax.townshipname);
		SELF.propertytax.municipalityname := IF(keepLeft(le.confidencefactor1.municipalityname, ri.confidencefactor1.municipalityname), le.propertytax.municipalityname, ri.propertytax.municipalityname);
		SELF.propertytax.range := IF(keepLeft(le.confidencefactor1.range, ri.confidencefactor1.range), le.propertytax.range, ri.propertytax.range);
		SELF.propertytax.zoningdesc := IF(keepLeft(le.confidencefactor1.zoningdescription, ri.confidencefactor1.zoningdescription), le.propertytax.zoningdesc, ri.propertytax.zoningdesc);
		
		/*******************************************
		 *      Confidence Factor Information      *
		 ******************************************* */
		SELF.confidencefactor1.acres := IF(keepLeft(le.confidencefactor1.acres, ri.confidencefactor1.acres), le.confidencefactor1.acres, ri.confidencefactor1.acres);
		SELF.confidencefactor1.airconditioningtypecode := IF(keepLeft(le.confidencefactor1.airconditioningtypecode, ri.confidencefactor1.airconditioningtypecode), le.confidencefactor1.airconditioningtypecode, ri.confidencefactor1.airconditioningtypecode);
		SELF.confidencefactor1.apnnumber := IF(keepLeft(le.confidencefactor1.apnnumber, ri.confidencefactor1.apnnumber), le.confidencefactor1.apnnumber, ri.confidencefactor1.apnnumber);
		SELF.confidencefactor1.assessedlandvalue := IF(keepLeft(le.confidencefactor1.assessedlandvalue, ri.confidencefactor1.assessedlandvalue), le.confidencefactor1.assessedlandvalue, ri.confidencefactor1.assessedlandvalue);
		SELF.confidencefactor1.assessedyear := IF(keepLeft(le.confidencefactor1.assessedyear, ri.confidencefactor1.assessedyear), le.confidencefactor1.assessedyear, ri.confidencefactor1.assessedyear);
		SELF.confidencefactor1.assessmentdocumentnumber := IF(keepLeft(le.confidencefactor1.assessmentdocumentnumber, ri.confidencefactor1.assessmentdocumentnumber), le.confidencefactor1.assessmentdocumentnumber, ri.confidencefactor1.assessmentdocumentnumber);
		SELF.confidencefactor1.assessmentrecordingdate := IF(keepLeft(le.confidencefactor1.assessmentrecordingdate, ri.confidencefactor1.assessmentrecordingdate), le.confidencefactor1.assessmentrecordingdate, ri.confidencefactor1.assessmentrecordingdate);
		SELF.confidencefactor1.basementfinishtype := IF(keepLeft(le.confidencefactor1.basementfinishtype, ri.confidencefactor1.basementfinishtype), le.confidencefactor1.basementfinishtype, ri.confidencefactor1.basementfinishtype);
		SELF.confidencefactor1.basementsquarefootage := IF(keepLeft(le.confidencefactor1.basementsquarefootage, ri.confidencefactor1.basementsquarefootage), le.confidencefactor1.basementsquarefootage, ri.confidencefactor1.basementsquarefootage);
		SELF.confidencefactor1.blocknumber := IF(keepLeft(le.confidencefactor1.blocknumber, ri.confidencefactor1.blocknumber), le.confidencefactor1.blocknumber, ri.confidencefactor1.blocknumber);
		SELF.confidencefactor1.buildingsquarefootage := IF(keepLeft(le.confidencefactor1.buildingsquarefootage, ri.confidencefactor1.buildingsquarefootage), le.confidencefactor1.buildingsquarefootage, ri.confidencefactor1.buildingsquarefootage);
		SELF.confidencefactor1.censustract := IF(keepLeft(le.confidencefactor1.censustract, ri.confidencefactor1.censustract), le.confidencefactor1.censustract, ri.confidencefactor1.censustract);
		SELF.confidencefactor1.constructiontype := IF(keepLeft(le.confidencefactor1.constructiontype, ri.confidencefactor1.constructiontype), le.confidencefactor1.constructiontype, ri.confidencefactor1.constructiontype);
		SELF.confidencefactor1.county := IF(keepLeft(le.confidencefactor1.county, ri.confidencefactor1.county), le.confidencefactor1.county, ri.confidencefactor1.county);
		SELF.confidencefactor1.effectiveyearbuilt := IF(keepLeft(le.confidencefactor1.effectiveyearbuilt, ri.confidencefactor1.effectiveyearbuilt), le.confidencefactor1.effectiveyearbuilt, ri.confidencefactor1.effectiveyearbuilt);
		SELF.confidencefactor1.exteriorwalltype := IF(keepLeft(le.confidencefactor1.exteriorwalltype, ri.confidencefactor1.exteriorwalltype), le.confidencefactor1.exteriorwalltype, ri.confidencefactor1.exteriorwalltype);
		SELF.confidencefactor1.fipscode := IF(keepLeft(le.confidencefactor1.fipscode, ri.confidencefactor1.fipscode), le.confidencefactor1.fipscode, ri.confidencefactor1.fipscode);
		SELF.confidencefactor1.fireplaceindicator := IF(keepLeft(le.confidencefactor1.fireplaceindicator, ri.confidencefactor1.fireplaceindicator), le.confidencefactor1.fireplaceindicator, ri.confidencefactor1.fireplaceindicator);
		SELF.confidencefactor1.fireplacetype := IF(keepLeft(le.confidencefactor1.fireplacetype, ri.confidencefactor1.fireplacetype), le.confidencefactor1.fireplacetype, ri.confidencefactor1.fireplacetype);
		SELF.confidencefactor1.floodzonepanelnumber := IF(keepLeft(le.confidencefactor1.floodzonepanelnumber, ri.confidencefactor1.floodzonepanelnumber), le.confidencefactor1.floodzonepanelnumber, ri.confidencefactor1.floodzonepanelnumber);
		SELF.confidencefactor1.floortype := IF(keepLeft(le.confidencefactor1.floortype, ri.confidencefactor1.floortype), le.confidencefactor1.floortype, ri.confidencefactor1.floortype);
		SELF.confidencefactor1.foundationtype := IF(keepLeft(le.confidencefactor1.foundationtype, ri.confidencefactor1.foundationtype), le.confidencefactor1.foundationtype, ri.confidencefactor1.foundationtype);
		SELF.confidencefactor1.frametype := IF(keepLeft(le.confidencefactor1.frametype, ri.confidencefactor1.frametype), le.confidencefactor1.frametype, ri.confidencefactor1.frametype);
		SELF.confidencefactor1.fueltype := IF(keepLeft(le.confidencefactor1.fueltype, ri.confidencefactor1.fueltype), le.confidencefactor1.fueltype, ri.confidencefactor1.fueltype);
		SELF.confidencefactor1.garagecarporttype := IF(keepLeft(le.confidencefactor1.garagecarporttype, ri.confidencefactor1.garagecarporttype), le.confidencefactor1.garagecarporttype, ri.confidencefactor1.garagecarporttype);
		SELF.confidencefactor1.garagesquarefootage := IF(keepLeft(le.confidencefactor1.garagesquarefootage, ri.confidencefactor1.garagesquarefootage), le.confidencefactor1.garagesquarefootage, ri.confidencefactor1.garagesquarefootage);
		SELF.confidencefactor1.groundfloorsquarefootage := IF(keepLeft(le.confidencefactor1.groundfloorsquarefootage, ri.confidencefactor1.groundfloorsquarefootage), le.confidencefactor1.groundfloorsquarefootage, ri.confidencefactor1.groundfloorsquarefootage);
		SELF.confidencefactor1.heatingtype := IF(keepLeft(le.confidencefactor1.heatingtype, ri.confidencefactor1.heatingtype), le.confidencefactor1.heatingtype, ri.confidencefactor1.heatingtype);
		SELF.confidencefactor1.homesteadexemptionindicator := IF(keepLeft(le.confidencefactor1.homesteadexemptionindicator, ri.confidencefactor1.homesteadexemptionindicator), le.confidencefactor1.homesteadexemptionindicator, ri.confidencefactor1.homesteadexemptionindicator);
		SELF.confidencefactor1.improvementvalue := IF(keepLeft(le.confidencefactor1.improvementvalue, ri.confidencefactor1.improvementvalue), le.confidencefactor1.improvementvalue, ri.confidencefactor1.improvementvalue);
		SELF.confidencefactor1.landusecode := IF(keepLeft(le.confidencefactor1.landusecode, ri.confidencefactor1.landusecode), le.confidencefactor1.landusecode, ri.confidencefactor1.landusecode);
		SELF.confidencefactor1.latitude := IF(keepLeft(le.confidencefactor1.latitude, ri.confidencefactor1.latitude), le.confidencefactor1.latitude, ri.confidencefactor1.latitude);
		SELF.confidencefactor1.livingareasquarefootage := IF(keepLeft(le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage), le.confidencefactor1.livingareasquarefootage, ri.confidencefactor1.livingareasquarefootage);
		SELF.confidencefactor1.locationofinfluencecode := IF(keepLeft(le.confidencefactor1.locationofinfluencecode, ri.confidencefactor1.locationofinfluencecode), le.confidencefactor1.locationofinfluencecode, ri.confidencefactor1.locationofinfluencecode);
		SELF.confidencefactor1.longitude := IF(keepLeft(le.confidencefactor1.longitude, ri.confidencefactor1.longitude), le.confidencefactor1.longitude, ri.confidencefactor1.longitude);
		SELF.confidencefactor1.lotdepthfootage := IF(keepLeft(le.confidencefactor1.lotdepthfootage, ri.confidencefactor1.lotdepthfootage), le.confidencefactor1.lotdepthfootage, ri.confidencefactor1.lotdepthfootage);
		SELF.confidencefactor1.lotfrontfootage := IF(keepLeft(le.confidencefactor1.lotfrontfootage, ri.confidencefactor1.lotfrontfootage), le.confidencefactor1.lotfrontfootage, ri.confidencefactor1.lotfrontfootage);
		SELF.confidencefactor1.lotnumber := IF(keepLeft(le.confidencefactor1.lotnumber, ri.confidencefactor1.lotnumber), le.confidencefactor1.lotnumber, ri.confidencefactor1.lotnumber);
		SELF.confidencefactor1.lotsize := IF(keepLeft(le.confidencefactor1.lotsize, ri.confidencefactor1.lotsize), le.confidencefactor1.lotsize, ri.confidencefactor1.lotsize);
		SELF.confidencefactor1.marketlandvalue := IF(keepLeft(le.confidencefactor1.marketlandvalue, ri.confidencefactor1.marketlandvalue), le.confidencefactor1.marketlandvalue, ri.confidencefactor1.marketlandvalue);
		SELF.confidencefactor1.municipalityname := IF(keepLeft(le.confidencefactor1.municipalityname, ri.confidencefactor1.municipalityname), le.confidencefactor1.municipalityname, ri.confidencefactor1.municipalityname);
		SELF.confidencefactor1.numberofbathfixtures := IF(keepLeft(le.confidencefactor1.numberofbathfixtures, ri.confidencefactor1.numberofbathfixtures), le.confidencefactor1.numberofbathfixtures, ri.confidencefactor1.numberofbathfixtures);
		SELF.confidencefactor1.numberofbaths := IF(keepLeft(le.confidencefactor1.numberofbaths, ri.confidencefactor1.numberofbaths), le.confidencefactor1.numberofbaths, ri.confidencefactor1.numberofbaths);
		SELF.confidencefactor1.numberofbedrooms := IF(keepLeft(le.confidencefactor1.numberofbedrooms, ri.confidencefactor1.numberofbedrooms), le.confidencefactor1.numberofbedrooms, ri.confidencefactor1.numberofbedrooms);
		SELF.confidencefactor1.numberoffireplaces := IF(keepLeft(le.confidencefactor1.numberoffireplaces, ri.confidencefactor1.numberoffireplaces), le.confidencefactor1.numberoffireplaces, ri.confidencefactor1.numberoffireplaces);
		SELF.confidencefactor1.numberoffullbaths := IF(keepLeft(le.confidencefactor1.numberoffullbaths, ri.confidencefactor1.numberoffullbaths), le.confidencefactor1.numberoffullbaths, ri.confidencefactor1.numberoffullbaths);
		SELF.confidencefactor1.numberofhalfbaths := IF(keepLeft(le.confidencefactor1.numberofhalfbaths, ri.confidencefactor1.numberofhalfbaths), le.confidencefactor1.numberofhalfbaths, ri.confidencefactor1.numberofhalfbaths);
		SELF.confidencefactor1.numberofrooms := IF(keepLeft(le.confidencefactor1.numberofrooms, ri.confidencefactor1.numberofrooms), le.confidencefactor1.numberofrooms, ri.confidencefactor1.numberofrooms);
		SELF.confidencefactor1.numberofstories := IF(keepLeft(le.confidencefactor1.numberofstories, ri.confidencefactor1.numberofstories), le.confidencefactor1.numberofstories, ri.confidencefactor1.numberofstories);
		SELF.confidencefactor1.numberofunits := IF(keepLeft(le.confidencefactor1.numberofunits, ri.confidencefactor1.numberofunits), le.confidencefactor1.numberofunits, ri.confidencefactor1.numberofunits);
		SELF.confidencefactor1.parkingtype := IF(keepLeft(le.confidencefactor1.parkingtype, ri.confidencefactor1.parkingtype), le.confidencefactor1.parkingtype, ri.confidencefactor1.parkingtype);
		SELF.confidencefactor1.percentimproved := IF(keepLeft(le.confidencefactor1.percentimproved, ri.confidencefactor1.percentimproved), le.confidencefactor1.percentimproved, ri.confidencefactor1.percentimproved);
		SELF.confidencefactor1.poolindicator := IF(keepLeft(le.confidencefactor1.poolindicator, ri.confidencefactor1.poolindicator), le.confidencefactor1.poolindicator, ri.confidencefactor1.poolindicator);
		SELF.confidencefactor1.pooltype := IF(keepLeft(le.confidencefactor1.pooltype, ri.confidencefactor1.pooltype), le.confidencefactor1.pooltype, ri.confidencefactor1.pooltype);
		SELF.confidencefactor1.propertytypecode := IF(keepLeft(le.confidencefactor1.propertytypecode, ri.confidencefactor1.propertytypecode), le.confidencefactor1.propertytypecode, ri.confidencefactor1.propertytypecode);
		SELF.confidencefactor1.qualityofstructurecode := IF(keepLeft(le.confidencefactor1.qualityofstructurecode, ri.confidencefactor1.qualityofstructurecode), le.confidencefactor1.qualityofstructurecode, ri.confidencefactor1.qualityofstructurecode);
		SELF.confidencefactor1.roofcovertype := IF(keepLeft(le.confidencefactor1.roofcovertype, ri.confidencefactor1.roofcovertype), le.confidencefactor1.roofcovertype, ri.confidencefactor1.roofcovertype);
		SELF.confidencefactor1.sewertype := IF(keepLeft(le.confidencefactor1.sewertype, ri.confidencefactor1.sewertype), le.confidencefactor1.sewertype, ri.confidencefactor1.sewertype);
		SELF.confidencefactor1.storiestype := IF(keepLeft(le.confidencefactor1.storiestype, ri.confidencefactor1.storiestype), le.confidencefactor1.storiestype, ri.confidencefactor1.storiestype);
		SELF.confidencefactor1.styletype := IF(keepLeft(le.confidencefactor1.styletype, ri.confidencefactor1.styletype), le.confidencefactor1.styletype, ri.confidencefactor1.styletype);
		SELF.confidencefactor1.subdivisionname := IF(keepLeft(le.confidencefactor1.subdivisionname, ri.confidencefactor1.subdivisionname), le.confidencefactor1.subdivisionname, ri.confidencefactor1.subdivisionname);
		SELF.confidencefactor1.taxamount := IF(keepLeft(le.confidencefactor1.taxamount, ri.confidencefactor1.taxamount), le.confidencefactor1.taxamount, ri.confidencefactor1.taxamount);
		SELF.confidencefactor1.taxbillingyear := IF(keepLeft(le.confidencefactor1.taxbillingyear, ri.confidencefactor1.taxbillingyear), le.confidencefactor1.taxbillingyear, ri.confidencefactor1.taxbillingyear);
		SELF.confidencefactor1.totalassessedvalue := IF(keepLeft(le.confidencefactor1.totalassessedvalue, ri.confidencefactor1.totalassessedvalue), le.confidencefactor1.totalassessedvalue, ri.confidencefactor1.totalassessedvalue);
		SELF.confidencefactor1.totalcalculatedvalue := IF(keepLeft(le.confidencefactor1.totalcalculatedvalue, ri.confidencefactor1.totalcalculatedvalue), le.confidencefactor1.totalcalculatedvalue, ri.confidencefactor1.totalcalculatedvalue);
		SELF.confidencefactor1.totallandvalue := IF(keepLeft(le.confidencefactor1.totallandvalue, ri.confidencefactor1.totallandvalue), le.confidencefactor1.totallandvalue, ri.confidencefactor1.totallandvalue);
		SELF.confidencefactor1.totalmarketvalue := IF(keepLeft(le.confidencefactor1.totalmarketvalue, ri.confidencefactor1.totalmarketvalue), le.confidencefactor1.totalmarketvalue, ri.confidencefactor1.totalmarketvalue);
		SELF.confidencefactor1.townshipname := IF(keepLeft(le.confidencefactor1.townshipname, ri.confidencefactor1.townshipname), le.confidencefactor1.townshipname, ri.confidencefactor1.townshipname);
		SELF.confidencefactor1.watertype := IF(keepLeft(le.confidencefactor1.watertype, ri.confidencefactor1.watertype), le.confidencefactor1.watertype, ri.confidencefactor1.watertype);
		SELF.confidencefactor1.yearbuilt := IF(keepLeft(le.confidencefactor1.yearbuilt, ri.confidencefactor1.yearbuilt), le.confidencefactor1.yearbuilt, ri.confidencefactor1.yearbuilt);
		SELF.confidencefactor1.zoningdescription := IF(keepLeft(le.confidencefactor1.zoningdescription, ri.confidencefactor1.zoningdescription), le.confidencefactor1.zoningdescription, ri.confidencefactor1.zoningdescription);
		
		SELF.confidencefactor2.deeddocumentnumber := IF(keepLeft(le.confidencefactor2.deeddocumentnumber, ri.confidencefactor2.deeddocumentnumber), le.confidencefactor2.deeddocumentnumber, ri.confidencefactor2.deeddocumentnumber);
		SELF.confidencefactor2.deedrecordingdate := IF(keepLeft(le.confidencefactor2.deedrecordingdate, ri.confidencefactor2.deedrecordingdate), le.confidencefactor2.deedrecordingdate, ri.confidencefactor2.deedrecordingdate);
		SELF.confidencefactor2.interestratetypecode := IF(keepLeft(le.confidencefactor2.interestratetypecode, ri.confidencefactor2.interestratetypecode), le.confidencefactor2.interestratetypecode, ri.confidencefactor2.interestratetypecode);
		SELF.confidencefactor2.loanamount := IF(keepLeft(le.confidencefactor2.loanamount, ri.confidencefactor2.loanamount), le.confidencefactor2.loanamount, ri.confidencefactor2.loanamount);
		SELF.confidencefactor2.loantypecode := IF(keepLeft(le.confidencefactor2.loantypecode, ri.confidencefactor2.loantypecode), le.confidencefactor2.loantypecode, ri.confidencefactor2.loantypecode);
		SELF.confidencefactor2.mortgagecompanyname := IF(keepLeft(le.confidencefactor2.mortgagecompanyname, ri.confidencefactor2.mortgagecompanyname), le.confidencefactor2.mortgagecompanyname, ri.confidencefactor2.mortgagecompanyname);
		SELF.confidencefactor2.salefullorpart := IF(keepLeft(le.confidencefactor2.salefullorpart, ri.confidencefactor2.salefullorpart), le.confidencefactor2.salefullorpart, ri.confidencefactor2.salefullorpart);
		SELF.confidencefactor2.salesamount := IF(keepLeft(le.confidencefactor2.salesamount, ri.confidencefactor2.salesamount), le.confidencefactor2.salesamount, ri.confidencefactor2.salesamount);
		SELF.confidencefactor2.salesdate := IF(keepLeft(le.confidencefactor2.salesdate, ri.confidencefactor2.salesdate), le.confidencefactor2.salesdate, ri.confidencefactor2.salesdate);
		SELF.confidencefactor2.salestypecode := IF(keepLeft(le.confidencefactor2.salestypecode, ri.confidencefactor2.salestypecode), le.confidencefactor2.salestypecode, ri.confidencefactor2.salestypecode);
		SELF.confidencefactor2.secondloanamount := IF(keepLeft(le.confidencefactor2.secondloanamount, ri.confidencefactor2.secondloanamount), le.confidencefactor2.secondloanamount, ri.confidencefactor2.secondloanamount);
		
		// Anything not currently definied just fill in using the left - mostly unimportant information at this point
		SELF.propertyattributes := le.propertyattributes;
		SELF.propertysales := le.propertysales;
		SELF.propertytax := le.propertytax;
		SELF.confidencefactor1 := le.confidencefactor1;
		SELF.confidencefactor2 := le.confidencefactor2;

		SELF := [];
	END;
	
	bestPropertyData := ROLLUP(propertyData, LEFT.RiskAddress.streetnumber = RIGHT.RiskAddress.streetnumber AND 
																								 LEFT.RiskAddress.streetpredirection = RIGHT.RiskAddress.streetpredirection AND 
																								 LEFT.RiskAddress.streetname = RIGHT.RiskAddress.streetname AND 
																								 LEFT.RiskAddress.streetsuffix = RIGHT.RiskAddress.streetsuffix AND 
																								 LEFT.RiskAddress.streetpostdirection = RIGHT.RiskAddress.streetpostdirection AND 
																								 LEFT.RiskAddress.unitdesignation = RIGHT.RiskAddress.unitdesignation AND 
																								 LEFT.RiskAddress.unitnumber = RIGHT.RiskAddress.unitnumber AND 
																								 // LEFT.RiskAddress.streetaddress1 = RIGHT.RiskAddress.streetaddress1 AND /* This can differ between left and right */
																								 // LEFT.RiskAddress.streetaddress2 = RIGHT.RiskAddress.streetaddress2 AND /* This can differ between left and right */
																								 LEFT.RiskAddress.city = RIGHT.RiskAddress.city AND 
																								 LEFT.RiskAddress.state = RIGHT.RiskAddress.state AND 
																								 LEFT.RiskAddress.zip5 = RIGHT.RiskAddress.zip5 AND 
																								 LEFT.RiskAddress.zip4 = RIGHT.RiskAddress.zip4 AND 
																								 LEFT.RiskAddress.county = RIGHT.RiskAddress.county AND 
																								 LEFT.RiskAddress.postalcode = RIGHT.RiskAddress.postalcode,
															rollupPropertyData(LEFT, RIGHT));
		
/* ************************************************************
	 *         Join back ERC Data for the Address:              *
	 ************************************************************ */
	 iesp.property_info.t_PropertyInformationReport combineWithERC (iesp.property_info.t_PropertyInformationReport le, iesp.property_info.t_PropertyDataItem ri) := TRANSFORM
		
    SELF.estimatedreplacementcost := le.estimatedreplacementcost;
		 
	
    SELF.propertydata := ri;
		
		// Fill in the remaining with the stuff on the left
		SELF := le;
		
		SELF := [];
	END;
	withERC := JOIN(report, bestPropertyData, LEFT.PropertyData[1].RiskAddress.streetnumber = RIGHT.RiskAddress.streetnumber AND 
																						LEFT.PropertyData[1].RiskAddress.streetpredirection = RIGHT.RiskAddress.streetpredirection AND 
																						LEFT.PropertyData[1].RiskAddress.streetname = RIGHT.RiskAddress.streetname AND 
																						LEFT.PropertyData[1].RiskAddress.streetsuffix = RIGHT.RiskAddress.streetsuffix AND 
																						LEFT.PropertyData[1].RiskAddress.streetpostdirection = RIGHT.RiskAddress.streetpostdirection AND 
																						LEFT.PropertyData[1].RiskAddress.unitdesignation = RIGHT.RiskAddress.unitdesignation AND 
																						LEFT.PropertyData[1].RiskAddress.unitnumber = RIGHT.RiskAddress.unitnumber AND 
																						LEFT.PropertyData[1].RiskAddress.city = RIGHT.RiskAddress.city AND 
																						LEFT.PropertyData[1].RiskAddress.state = RIGHT.RiskAddress.state AND 
																						LEFT.PropertyData[1].RiskAddress.zip5 = RIGHT.RiskAddress.zip5 AND 
																						LEFT.PropertyData[1].RiskAddress.zip4 = RIGHT.RiskAddress.zip4 AND 
																						LEFT.PropertyData[1].RiskAddress.county = RIGHT.RiskAddress.county AND 
																						LEFT.PropertyData[1].RiskAddress.postalcode = RIGHT.RiskAddress.postalcode,
																					combineWithERC(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(1000));
  

														
/* ************************************************************
	 *      Flatten the Property Information for Return:        *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics flattenProperty(iesp.property_info.t_PropertyInformationReport le) := TRANSFORM
		// At this point everything is rolled up for Property Data, we just need to grab the first (and only) row
		propData := le.PropertyData[1];
		ercData := le.EstimatedReplacementCost;
		
		/*****************************************
		 *         Address Information           *
		 *****************************************/
		SELF.PropertyCharacteristics.Address.Street_Number := propData.RiskAddress.StreetNumber;
		SELF.PropertyCharacteristics.Address.Street_Pre_Direction := propData.RiskAddress.StreetPreDirection;
		SELF.PropertyCharacteristics.Address.Street_Name := propData.RiskAddress.StreetName;
		SELF.PropertyCharacteristics.Address.Street_Suffix := propData.RiskAddress.StreetSuffix;
		SELF.PropertyCharacteristics.Address.Street_Post_Direction := propData.RiskAddress.StreetPostDirection;
		SELF.PropertyCharacteristics.Address.Unit_Designation := propData.RiskAddress.UnitDesignation;
		SELF.PropertyCharacteristics.Address.Unit_Number := propData.RiskAddress.UnitNumber;
		SELF.PropertyCharacteristics.Address.Street_Address_1 := propData.RiskAddress.StreetAddress1;
		SELF.PropertyCharacteristics.Address.Street_Address_2 := propData.RiskAddress.StreetAddress2;
		SELF.PropertyCharacteristics.Address.City := propData.RiskAddress.City;
		SELF.PropertyCharacteristics.Address.State := propData.RiskAddress.State;
		SELF.PropertyCharacteristics.Address.Zip_5 := propData.RiskAddress.Zip5;
		SELF.PropertyCharacteristics.Address.Zip_4 := propData.RiskAddress.Zip4;
		SELF.PropertyCharacteristics.Address.County := propData.RiskAddress.County;
		SELF.PropertyCharacteristics.Address.Postal_Code := propData.RiskAddress.PostalCode;
		SELF.PropertyCharacteristics.Address.State_City_Zip := propData.RiskAddress.StateCityZip;
		SELF.PropertyCharacteristics.Address.Census_Tract := propData.RiskAddress.CensusTract;

		/*****************************************
		 *       Attributes Information          *
		 *****************************************/
		SELF.PropertyCharacteristics.Attributes.Living_Area_SF := propData.PropertyAttributes.LivingAreaSF;
		SELF.PropertyCharacteristics.Attributes.Living_Area_SF_ConfidenceFactor := propData.confidencefactor1.livingareasquarefootage;
		SELF.PropertyCharacteristics.Attributes.Stories := propData.PropertyAttributes.Stories;
		SELF.PropertyCharacteristics.Attributes.Stories_ConfidenceFactor := propData.confidencefactor1.numberofstories;
		SELF.PropertyCharacteristics.Attributes.Bedrooms := propData.PropertyAttributes.Bedrooms;
		SELF.PropertyCharacteristics.Attributes.Bedrooms_ConfidenceFactor := propData.confidencefactor1.numberofbedrooms;
		SELF.PropertyCharacteristics.Attributes.Baths := propData.PropertyAttributes.Baths;
		SELF.PropertyCharacteristics.Attributes.Baths_ConfidenceFactor := propData.confidencefactor1.numberofbaths;
		SELF.PropertyCharacteristics.Attributes.Fireplaces := propData.PropertyAttributes.Fireplaces;
		SELF.PropertyCharacteristics.Attributes.Fireplaces_ConfidenceFactor := propData.confidencefactor1.numberoffireplaces;
		SELF.PropertyCharacteristics.Attributes.Pool := propData.PropertyAttributes.Pool;
		SELF.PropertyCharacteristics.Attributes.Pool_ConfidenceFactor := propData.confidencefactor1.poolindicator;
		SELF.PropertyCharacteristics.Attributes.AC := propData.PropertyAttributes.AC;
		SELF.PropertyCharacteristics.Attributes.AC_ConfidenceFactor := propData.confidencefactor1.airconditioningtypecode;
		SELF.PropertyCharacteristics.Attributes.Year_Built := (STRING)propData.PropertyAttributes.YearBuilt;
		SELF.PropertyCharacteristics.Attributes.Year_Built_ConfidenceFactor := propData.confidencefactor1.yearbuilt;
		// SELF.PropertyCharacteristics.Attributes.Slope := propData.PropertyAttributes.Slope;
		// SELF.PropertyCharacteristics.Attributes.Slope_ConfidenceFactor := propData.PropertyAttributes.Slope;
		SELF.PropertyCharacteristics.Attributes.Quality_Of_Struct := propData.PropertyAttributes.QualityOfStruct;
		SELF.PropertyCharacteristics.Attributes.Quality_Of_Struct_ConfidenceFactor := propData.confidencefactor1.qualityofstructurecode;
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id_ConfidenceFactor := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value_ConfidenceFactor := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		SELF.PropertyCharacteristics.Attributes.Fireplace_Indicator := propData.PropertyAttributes.FireplaceIndicator;
		SELF.PropertyCharacteristics.Attributes.Fireplace_Indicator_ConfidenceFactor := propData.confidencefactor1.fireplaceindicator;
		SELF.PropertyCharacteristics.Attributes.Units := (STRING)propData.PropertyAttributes.Units;
		SELF.PropertyCharacteristics.Attributes.Units_ConfidenceFactor := propData.confidencefactor1.numberofunits;
		SELF.PropertyCharacteristics.Attributes.Rooms := (STRING)propData.PropertyAttributes.Rooms;
		SELF.PropertyCharacteristics.Attributes.Rooms_ConfidenceFactor := propData.confidencefactor1.numberofrooms;
		SELF.PropertyCharacteristics.Attributes.Full_Baths := (STRING)propData.PropertyAttributes.FullBaths;
		SELF.PropertyCharacteristics.Attributes.Full_Baths_ConfidenceFactor := propData.confidencefactor1.numberoffullbaths;
		SELF.PropertyCharacteristics.Attributes.Half_Baths := (STRING)propData.PropertyAttributes.HalfBaths;
		SELF.PropertyCharacteristics.Attributes.Half_Baths_ConfidenceFactor := propData.confidencefactor1.numberofhalfbaths;
		SELF.PropertyCharacteristics.Attributes.Bath_Fixtures := (STRING)propData.PropertyAttributes.BathFixtures;
		SELF.PropertyCharacteristics.Attributes.Bath_Fixtures_ConfidenceFactor := propData.confidencefactor1.numberofbathfixtures;
		SELF.PropertyCharacteristics.Attributes.Effective_Year_Built := (STRING)propData.PropertyAttributes.EffectiveYearBuilt;
		SELF.PropertyCharacteristics.Attributes.Effective_Year_Built_ConfidenceFactor := propData.confidencefactor1.effectiveyearbuilt;
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure := propData.PropertyAttributes.ConditionOfStructure;
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure_ConfidenceFactor := propData.PropertyAttributes.ConditionOfStructure;
		SELF.PropertyCharacteristics.Attributes.Building_Area_SF := (STRING)propData.PropertyAttributes.BuildingAreaSF;
		SELF.PropertyCharacteristics.Attributes.Building_Area_SF_ConfidenceFactor := propData.confidencefactor1.buildingsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Ground_Floor_Area_SF := (STRING)propData.PropertyAttributes.GroundFloorAreaSF;
		SELF.PropertyCharacteristics.Attributes.Ground_Floor_Area_SF_ConfidenceFactor := propData.confidencefactor1.groundfloorsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Basement_Area_SF := (STRING)propData.PropertyAttributes.BasementAreaSF;
		SELF.PropertyCharacteristics.Attributes.Basement_Area_SF_ConfidenceFactor := propData.confidencefactor1.basementsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Garage_Area_SF := (STRING)propData.PropertyAttributes.GarageAreaSF;
		SELF.PropertyCharacteristics.Attributes.Garage_Area_SF_ConfidenceFactor := propData.confidencefactor1.garagesquarefootage;
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence := propData.PropertyAttributes.TypeOfResidence;
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence_ConfidenceFactor := propData.PropertyAttributes.TypeOfResidence;
		SELF.PropertyCharacteristics.Attributes.Flood_Zone_Panel_Number := propData.PropertyAttributes.FloodZonePanelNumber;
		SELF.PropertyCharacteristics.Attributes.Flood_Zone_Panel_Number_ConfidenceFactor := propData.confidencefactor1.floodzonepanelnumber;
		SELF.PropertyCharacteristics.Attributes.Stories_Type := propData.PropertyAttributes.StoriesType;
		SELF.PropertyCharacteristics.Attributes.Stories_Type_ConfidenceFactor := propData.confidencefactor1.storiestype;
		
		/*****************************************
		 *     Characteristics Information       *
		 *****************************************/
		cat001 := propData.PropertyCharacteristics (category = '001')[1];
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material := cat001.Material;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_ConfidenceFactor := propData.confidencefactor1.airconditioningtypecode;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_Desc := cat001.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_Desc_ConfidenceFactor := propData.confidencefactor1.airconditioningtypecode;
		
		// Place holder - not currently populating
		cat002 := propData.PropertyCharacteristics (category = '002')[1];
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material := cat002.Material;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_Desc := cat002.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_Desc_ConfidenceFactor := 0;
		
		cat003 := propData.PropertyCharacteristics (category = '003')[1];
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material := cat003.Material;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_ConfidenceFactor := propData.confidencefactor1.floortype;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_Desc := cat003.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_Desc_ConfidenceFactor := propData.confidencefactor1.floortype;
		
		// Place holder - not currently populating
		cat004 := propData.PropertyCharacteristics (category = '004')[1];
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material := cat004.Material;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_Desc := cat004.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_Desc_ConfidenceFactor := 0;
		
		cat005 := propData.PropertyCharacteristics (category = '005')[1];
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material := cat005.Material;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_ConfidenceFactor := propData.confidencefactor1.exteriorwalltype;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_Desc := cat005.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_Desc_ConfidenceFactor := propData.confidencefactor1.exteriorwalltype;
		
		cat006 := propData.PropertyCharacteristics (category = '006')[1];
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material := cat006.Material;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_ConfidenceFactor := propData.confidencefactor1.roofcovertype;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_Desc := cat006.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_Desc_ConfidenceFactor := propData.confidencefactor1.roofcovertype;
		
		cat007 := propData.PropertyCharacteristics (category = '007')[1];
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material := cat007.Material;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_ConfidenceFactor := propData.confidencefactor1.foundationtype;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_Desc := cat007.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_Desc_ConfidenceFactor := propData.confidencefactor1.foundationtype;
		
		cat008 := propData.PropertyCharacteristics (category = '008')[1];
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material := cat008.Material;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_ConfidenceFactor := propData.confidencefactor1.fireplacetype;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_Desc := cat008.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_Desc_ConfidenceFactor := propData.confidencefactor1.fireplacetype;
		
		// Place holder - not currently populating
		cat009 := propData.PropertyCharacteristics (category = '009')[1];
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material := cat009.Material;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_Desc := cat009.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat010 := propData.PropertyCharacteristics (category = '010')[1];
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material := cat010.Material;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_Desc := cat010.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat011 := propData.PropertyCharacteristics (category = '011')[1];
		SELF.PropertyCharacteristics.Characteristics.Porch_Material := cat011.Material;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_Desc := cat011.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_Desc_ConfidenceFactor := 0;
		
		cat012 := propData.PropertyCharacteristics (category = '012')[1];
		SELF.PropertyCharacteristics.Characteristics.Parking_Material := cat012.Material;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_ConfidenceFactor := propData.confidencefactor1.parkingtype;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_Desc := cat012.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_Desc_ConfidenceFactor := propData.confidencefactor1.parkingtype;
		
		cat013 := propData.PropertyCharacteristics (category = '013')[1];
		SELF.PropertyCharacteristics.Characteristics.Basement_Material := cat013.Material;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_ConfidenceFactor := propData.confidencefactor1.basementfinishtype;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_Desc := cat013.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_Desc_ConfidenceFactor := propData.confidencefactor1.basementfinishtype;
		
		// Place holder - not currently populating
		cat014 := propData.PropertyCharacteristics (category = '014')[1];
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material := cat014.Material;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_Desc := cat014.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat015 := propData.PropertyCharacteristics (category = '015')[1];
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material := cat015.Material;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_Desc := cat015.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_Desc_ConfidenceFactor := 0;
		
		cat016 := propData.PropertyCharacteristics (category = '016')[1];
		SELF.PropertyCharacteristics.Characteristics.Water_Material := cat016.Material;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_ConfidenceFactor := propData.confidencefactor1.watertype;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_Desc := cat016.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_Desc_ConfidenceFactor := propData.confidencefactor1.watertype;
		
		// Place holder - not currently populating
		cat017 := propData.PropertyCharacteristics (category = '017')[1];
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material := cat017.Material;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_Desc := cat017.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat018 := propData.PropertyCharacteristics (category = '018')[1];
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material := cat018.Material;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_Desc := cat018.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_Desc_ConfidenceFactor := 0;
		
		cat019 := propData.PropertyCharacteristics (category = '019')[1];
		SELF.PropertyCharacteristics.Characteristics.Style_Material := cat019.Material;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_ConfidenceFactor := propData.confidencefactor1.styletype;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_Desc := cat019.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_Desc_ConfidenceFactor := propData.confidencefactor1.styletype;
		
		cat020 := propData.PropertyCharacteristics (category = '020')[1];
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material := cat020.Material;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_ConfidenceFactor := propData.confidencefactor1.fueltype;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_Desc := cat020.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_Desc_ConfidenceFactor := propData.confidencefactor1.fueltype;
		
		cat021 := propData.PropertyCharacteristics (category = '021')[1];
		SELF.PropertyCharacteristics.Characteristics.Garage_Material := cat021.Material;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_ConfidenceFactor := propData.confidencefactor1.garagecarporttype;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_Desc := cat021.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_Desc_ConfidenceFactor := propData.confidencefactor1.garagecarporttype;
		
		cat022 := propData.PropertyCharacteristics (category = '022')[1];
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material := cat022.Material;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_ConfidenceFactor := propData.confidencefactor1.constructiontype;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_Desc := cat022.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_Desc_ConfidenceFactor := propData.confidencefactor1.constructiontype;

		// There is no category 023...
		
		cat024 := propData.PropertyCharacteristics (category = '024')[1];
		SELF.PropertyCharacteristics.Characteristics.Heating_Material := cat024.Material;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_ConfidenceFactor := propData.confidencefactor1.heatingtype;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_Desc := cat024.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_Desc_ConfidenceFactor := propData.confidencefactor1.heatingtype;
		
		cat025 := propData.PropertyCharacteristics (category = '025')[1];
		SELF.PropertyCharacteristics.Characteristics.Frame_Material := cat025.Material;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_ConfidenceFactor := propData.confidencefactor1.frametype;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_Desc := cat025.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_Desc_ConfidenceFactor := propData.confidencefactor1.frametype;
		
		cat026 := propData.PropertyCharacteristics (category = '026')[1];
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material := cat026.Material;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_ConfidenceFactor := propData.confidencefactor1.sewertype;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_Desc := cat026.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_Desc_ConfidenceFactor := propData.confidencefactor1.sewertype;
		
		cat027 := propData.PropertyCharacteristics (category = '027')[1];
		SELF.PropertyCharacteristics.Characteristics.Pool_Material := cat027.Material;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_ConfidenceFactor := propData.confidencefactor1.pooltype;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_Desc := cat027.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_Desc_ConfidenceFactor := propData.confidencefactor1.pooltype;
		
		/*****************************************
		 *         Mortgages Information         *
		 *****************************************/
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Company_Name := propData.Mortgages[1].MortgageCompanyName;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Company_Name_ConfidenceFactor := propData.confidencefactor2.mortgagecompanyname;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type := (STRING)propData.Mortgages[1].MortgageType;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_ConfidenceFactor := propData.confidencefactor2.mortgagecompanyname; // The Mortgage_Company_Name, Mortgage_Type, and Mortgage_Type_Desc all use the same record, so just use the MortgageCompanyName Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_Desc := propData.Mortgages[1].MortgageTypeDesc;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_Desc_ConfidenceFactor := propData.confidencefactor2.mortgagecompanyname; // The Mortgage_Company_Name, Mortgage_Type, and Mortgage_Type_Desc all use the same record, so just use the MortgageCompanyName Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Loan_Amount := (STRING)propData.Mortgages[1].LoanAmount;
		SELF.PropertyCharacteristics.Mortgages.Loan_Amount_ConfidenceFactor := propData.confidencefactor2.loanamount;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_Code := propData.Mortgages[1].LoanTypeCode;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_Code_ConfidenceFactor := propData.confidencefactor2.loantypecode; // Loan_Type_Code and Loan_Type use the same record, so just use the LoanTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Loan_Type := propData.Mortgages[1].LoanType;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_ConfidenceFactor := propData.confidencefactor2.loantypecode; // Loan_Type_Code and Loan_Type use the same record, so just use the LoanTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Interest_Rate := (STRING)propData.Mortgages[1].InterestRate;
		SELF.PropertyCharacteristics.Mortgages.Interest_Rate_ConfidenceFactor := propData.confidencefactor2.interestratetypecode;
		
		/*****************************************
		 *          Sales Information            *
		 *****************************************/
		formatDate (STRING Year, STRING Month, STRING Day) := IF(LENGTH(TRIM(Year)) = 4, Year, '') + IF(LENGTH(TRIM(Month)) = 2, Month, IF(LENGTH(TRIM(Month)) = 1, '0' + Month, '')) + IF(LENGTH(TRIM(Day)) = 2, Day, IF(LENGTH(TRIM(Day)) = 1, '0' + Day, ''));
		deedDate := formatDate((STRING)propData.PropertySales.DeedRecordingDate.Year, (STRING)propData.PropertySales.DeedRecordingDate.Month, (STRING)propData.PropertySales.DeedRecordingDate.Day);
		SELF.PropertyCharacteristics.Sales.Deed_Recording_Date := IF((UNSIGNED)deedDate = 0, '', deedDate);
		SELF.PropertyCharacteristics.Sales.Deed_Recording_Date_ConfidenceFactor := propData.confidencefactor2.deedrecordingdate;
		salesDate := formatDate((STRING)propData.PropertySales.SalesDate.Year, (STRING)propData.PropertySales.SalesDate.Month, (STRING)propData.PropertySales.SalesDate.Day);
		SELF.PropertyCharacteristics.Sales.Sales_Date := IF((UNSIGNED)salesDate = 0, '', salesDate);
		SELF.PropertyCharacteristics.Sales.Sales_Date_ConfidenceFactor := propData.confidencefactor2.salesdate;
		SELF.PropertyCharacteristics.Sales.Deed_Document_Number := propData.PropertySales.DeedDocumentNumber;
		SELF.PropertyCharacteristics.Sales.Deed_Document_Number_ConfidenceFactor := propData.confidencefactor2.deeddocumentnumber;
		SELF.PropertyCharacteristics.Sales.Sales_Amount := (STRING)propData.PropertySales.SalesAmount;
		SELF.PropertyCharacteristics.Sales.Sales_Amount_ConfidenceFactor := propData.confidencefactor2.salesamount;
		SELF.PropertyCharacteristics.Sales.Sales_Type := propData.PropertySales.SalesType;
		SELF.PropertyCharacteristics.Sales.Sales_Type_ConfidenceFactor := propData.confidencefactor2.salestypecode;

		/*****************************************
		 *          Taxes Information            *
		 *****************************************/
		SELF.PropertyCharacteristics.Taxes.Land_Use_Code := propData.PropertyTax.LandUseCode;
		SELF.PropertyCharacteristics.Taxes.Land_Use_Code_ConfidenceFactor := propData.confidencefactor1.landusecode; // Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Land_Use := propData.PropertyTax.LandUse;
		SELF.PropertyCharacteristics.Taxes.Land_Use_ConfidenceFactor := propData.confidencefactor1.landusecode; // Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Property_Type_Code := propData.PropertyTax.PropertyTypeCode;
		SELF.PropertyCharacteristics.Taxes.Property_Type_Code_ConfidenceFactor := propData.confidencefactor1.propertytypecode; // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Property_Type := propData.PropertyTax.PropertyType;
		SELF.PropertyCharacteristics.Taxes.Property_Type_ConfidenceFactor := propData.confidencefactor1.propertytypecode; // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Lot_Size := propData.PropertyTax.LotSize;
		SELF.PropertyCharacteristics.Taxes.Lot_Size_ConfidenceFactor := propData.confidencefactor1.lotsize;
		SELF.PropertyCharacteristics.Taxes.Lot_Front_Footage := propData.PropertyTax.LotFrontFootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Front_Footage_ConfidenceFactor := propData.confidencefactor1.lotfrontfootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Depth_Footage := propData.PropertyTax.LotDepthFootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Depth_Footage_ConfidenceFactor := propData.confidencefactor1.lotdepthfootage;
		SELF.PropertyCharacteristics.Taxes.Acres := propData.PropertyTax.Acres;
		SELF.PropertyCharacteristics.Taxes.Acres_ConfidenceFactor := propData.confidencefactor1.acres;
		SELF.PropertyCharacteristics.Taxes.Total_Assessed_Value := (STRING)propData.PropertyTax.TotalAssessedValue;
		SELF.PropertyCharacteristics.Taxes.Total_Assessed_Value_ConfidenceFactor := propData.confidencefactor1.totalassessedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Calculated_Value := (STRING)propData.PropertyTax.TotalCalculatedValue;
		SELF.PropertyCharacteristics.Taxes.Total_Calculated_Value_ConfidenceFactor := propData.confidencefactor1.totalcalculatedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Market_Value := (STRING)propData.PropertyTax.TotalMarketValue;
		SELF.PropertyCharacteristics.Taxes.Total_Market_Value_ConfidenceFactor := propData.confidencefactor1.totalmarketvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Land_Value := (STRING)propData.PropertyTax.TotalLandValue;
		SELF.PropertyCharacteristics.Taxes.Total_Land_Value_ConfidenceFactor := propData.confidencefactor1.totallandvalue;
		SELF.PropertyCharacteristics.Taxes.Market_Land_Value := (STRING)propData.PropertyTax.MarketLandValue;
		SELF.PropertyCharacteristics.Taxes.Market_Land_Value_ConfidenceFactor := propData.confidencefactor1.marketlandvalue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Land_Value := (STRING)propData.PropertyTax.AssessedLandValue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Land_Value_ConfidenceFactor := propData.confidencefactor1.assessedlandvalue;
		SELF.PropertyCharacteristics.Taxes.Improvement_Value := (STRING)propData.PropertyTax.ImprovementValue;
		SELF.PropertyCharacteristics.Taxes.Improvement_Value_ConfidenceFactor := propData.confidencefactor1.improvementvalue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Year := (STRING)propData.PropertyTax.AssessedYear;
		SELF.PropertyCharacteristics.Taxes.Assessed_Year_ConfidenceFactor := propData.confidencefactor1.assessedyear;
		// Placeholder, not currently populated
		SELF.PropertyCharacteristics.Taxes.Tax_Code_Area := propData.PropertyTax.TaxCodeArea;
		SELF.PropertyCharacteristics.Taxes.Tax_Code_Area_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Taxes.Tax_Billing_Year := (STRING)propData.PropertyTax.TaxBillingYear;
		SELF.PropertyCharacteristics.Taxes.Tax_Billing_Year_ConfidenceFactor := propData.confidencefactor1.taxbillingyear;
		SELF.PropertyCharacteristics.Taxes.Home_Stead_Exemption := propData.PropertyTax.HomeSteadExemption;
		SELF.PropertyCharacteristics.Taxes.Home_Stead_Exemption_ConfidenceFactor := propData.confidencefactor1.homesteadexemptionindicator;
		SELF.PropertyCharacteristics.Taxes.Tax_Amount := (STRING)propData.PropertyTax.TaxAmount;
		SELF.PropertyCharacteristics.Taxes.Tax_Amount_ConfidenceFactor := propData.confidencefactor1.taxamount;
		SELF.PropertyCharacteristics.Taxes.Percent_Improved := (STRING)propData.PropertyTax.PercentImproved;
		SELF.PropertyCharacteristics.Taxes.Percent_Improved_ConfidenceFactor := propData.confidencefactor1.percentimproved;
		assessDate := formatDate((STRING)propData.PropertyTax.AssessmentRecordingDate.Year, (STRING)propData.PropertyTax.AssessmentRecordingDate.Month, (STRING)propData.PropertyTax.AssessmentRecordingDate.Day);
		SELF.PropertyCharacteristics.Taxes.Assessment_Recording_Date := IF((UNSIGNED)assessDate = 0, '', assessDate);
		SELF.PropertyCharacteristics.Taxes.Assessment_Recording_Date_ConfidenceFactor := propData.confidencefactor1.assessmentrecordingdate;
		
		/*****************************************
		 *    ERC Cost Summary Information       *
		 *****************************************/
		SELF.ERCCalculations.CostSummary.Insurance_To_Value := (STRING)ercData.CostSummary.InsuranceToValue;
		SELF.ERCCalculations.CostSummary.Estimated_Replacement_Cost := (STRING)ercData.CostSummary.EstimatedReplacementCost;
		SELF.ERCCalculations.CostSummary.Profit := (STRING)ercData.CostSummary.Profit;
		SELF.ERCCalculations.CostSummary.Architect_Amount := (STRING)ercData.CostSummary.ArchitectAmount;
		SELF.ERCCalculations.CostSummary.Sales_Tax_Included := ercData.CostSummary.SalesTaxIncluded;
		SELF.ERCCalculations.CostSummary.Debris_Amount := (STRING)ercData.CostSummary.DebrisAmount;
		SELF.ERCCalculations.CostSummary.Actual_Cash_Value := (STRING)ercData.CostSummary.ActualCashValue;
		SELF.ERCCalculations.CostSummary.Overhead_Amount := (STRING)ercData.CostSummary.OverheadAmount;
		SELF.ERCCalculations.CostSummary.Est_Replacement_Cost_Score := (STRING)ercData.CostSummary.EstReplacementCostScore;
		SELF.ERCCalculations.CostSummary.Actual_Cash_Value_Score := (STRING)ercData.CostSummary.ActualCashValueScore;
		
		/*****************************************
		 *     ERC Attributes Information        *
		 *****************************************/
		SELF.ERCCalculations.Attributes.Living_Area_SF := ercData.PropertyAttributes.LivingAreaSF;
		SELF.ERCCalculations.Attributes.Stories := ercData.PropertyAttributes.Stories;
		SELF.ERCCalculations.Attributes.Bedrooms := ercData.PropertyAttributes.Bedrooms;
		SELF.ERCCalculations.Attributes.Baths := ercData.PropertyAttributes.Baths;
		SELF.ERCCalculations.Attributes.Fireplaces := ercData.PropertyAttributes.Fireplaces;
		SELF.ERCCalculations.Attributes.Pool := ercData.PropertyAttributes.Pool;
		SELF.ERCCalculations.Attributes.AC := ercData.PropertyAttributes.AC;
		SELF.ERCCalculations.Attributes.Year_Built := (STRING)ercData.PropertyAttributes.YearBuilt;
		SELF.ERCCalculations.Attributes.Slope := ercData.PropertyAttributes.Slope;
		SELF.ERCCalculations.Attributes.Quality_Of_Struct := ercData.PropertyAttributes.QualityOfStruct;
		SELF.ERCCalculations.Attributes.Replacement_Cost_Report_Id := ercData.PropertyAttributes.ReplacementCostReportId;
		SELF.ERCCalculations.Attributes.Policy_Coverage_Value := (STRING)ercData.PropertyAttributes.PolicyCoverageValue;
		SELF.ERCCalculations.Attributes.Fireplace_Indicator := ercData.PropertyAttributes.FireplaceIndicator;
		SELF.ERCCalculations.Attributes.Units := (STRING)ercData.PropertyAttributes.Units;
		SELF.ERCCalculations.Attributes.Rooms := (STRING)ercData.PropertyAttributes.Rooms;
		SELF.ERCCalculations.Attributes.Full_Baths := (STRING)ercData.PropertyAttributes.FullBaths;
		SELF.ERCCalculations.Attributes.Half_Baths := (STRING)ercData.PropertyAttributes.HalfBaths;
		SELF.ERCCalculations.Attributes.Bath_Fixtures := (STRING)ercData.PropertyAttributes.BathFixtures;
		SELF.ERCCalculations.Attributes.Effective_Year_Built := (STRING)ercData.PropertyAttributes.EffectiveYearBuilt;
		SELF.ERCCalculations.Attributes.Condition_Of_Structure := ercData.PropertyAttributes.ConditionOfStructure;
		SELF.ERCCalculations.Attributes.Building_Area_SF := (STRING)ercData.PropertyAttributes.BuildingAreaSF;
		SELF.ERCCalculations.Attributes.Ground_Floor_Area_SF := (STRING)ercData.PropertyAttributes.GroundFloorAreaSF;
		SELF.ERCCalculations.Attributes.Basement_Area_SF := (STRING)ercData.PropertyAttributes.BasementAreaSF;
		SELF.ERCCalculations.Attributes.Garage_Area_SF := (STRING)ercData.PropertyAttributes.GarageAreaSF;
		SELF.ERCCalculations.Attributes.Type_Of_Residence := ercData.PropertyAttributes.TypeOfResidence;
		SELF.ERCCalculations.Attributes.Flood_Zone_Panel_Number := ercData.PropertyAttributes.FloodZonePanelNumber;
		SELF.ERCCalculations.Attributes.Stories_Type := ercData.PropertyAttributes.StoriesType;

		/*****************************************
		 *   ERC Characteristics Information     *
		 *****************************************/
		erccat001 := ercData.PropertyCharacteristics (category = '001')[1];
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Material := erccat001.Material;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Material_Desc := erccat001.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Value := (STRING)erccat001.Value;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Quality_Desc := erccat001.QualityDesc;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Condition_Desc := erccat001.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Age := (STRING)erccat001.Age;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_ERC_Value := (STRING)erccat001.ERCValue;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_Low_ERC_Value := (STRING)erccat001.LowERCValue;
		SELF.ERCCalculations.Characteristics.Air_Conditioning_High_ERC_Value := (STRING)erccat001.HighERCValue;
		
		erccat002 := ercData.PropertyCharacteristics (category = '002')[1];
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Material := erccat002.Material;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Material_Desc := erccat002.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Value := (STRING)erccat002.Value;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Quality_Desc := erccat002.QualityDesc;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Condition_Desc := erccat002.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Age := (STRING)erccat002.Age;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_ERC_Value := (STRING)erccat002.ERCValue;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_Low_ERC_Value := (STRING)erccat002.LowERCValue;
		SELF.ERCCalculations.Characteristics.Walls_and_Ceilings_High_ERC_Value := (STRING)erccat002.HighERCValue;
		
		erccat003 := ercData.PropertyCharacteristics (category = '003')[1];
		SELF.ERCCalculations.Characteristics.Flooring_Material := erccat003.Material;
		SELF.ERCCalculations.Characteristics.Flooring_Material_Desc := erccat003.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Flooring_Value := (STRING)erccat003.Value;
		SELF.ERCCalculations.Characteristics.Flooring_Quality_Desc := erccat003.QualityDesc;
		SELF.ERCCalculations.Characteristics.Flooring_Condition_Desc := erccat003.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Flooring_Age := (STRING)erccat003.Age;
		SELF.ERCCalculations.Characteristics.Flooring_ERC_Value := (STRING)erccat003.ERCValue;
		SELF.ERCCalculations.Characteristics.Flooring_Low_ERC_Value := (STRING)erccat003.LowERCValue;
		SELF.ERCCalculations.Characteristics.Flooring_High_ERC_Value := (STRING)erccat003.HighERCValue;
		
		erccat004 := ercData.PropertyCharacteristics (category = '004')[1];
		SELF.ERCCalculations.Characteristics.Appliances_Material := erccat004.Material;
		SELF.ERCCalculations.Characteristics.Appliances_Material_Desc := erccat004.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Appliances_Value := (STRING)erccat004.Value;
		SELF.ERCCalculations.Characteristics.Appliances_Quality_Desc := erccat004.QualityDesc;
		SELF.ERCCalculations.Characteristics.Appliances_Condition_Desc := erccat004.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Appliances_Age := (STRING)erccat004.Age;
		SELF.ERCCalculations.Characteristics.Appliances_ERC_Value := (STRING)erccat004.ERCValue;
		SELF.ERCCalculations.Characteristics.Appliances_Low_ERC_Value := (STRING)erccat004.LowERCValue;
		SELF.ERCCalculations.Characteristics.Appliances_High_ERC_Value := (STRING)erccat004.HighERCValue;
		
		erccat005 := ercData.PropertyCharacteristics (category = '005')[1];
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Material := erccat005.Material;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Material_Desc := erccat005.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Value := (STRING)erccat005.Value;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Quality_Desc := erccat005.QualityDesc;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Condition_Desc := erccat005.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Age := (STRING)erccat005.Age;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_ERC_Value := (STRING)erccat005.ERCValue;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_Low_ERC_Value := (STRING)erccat005.LowERCValue;
		SELF.ERCCalculations.Characteristics.Exterior_Wall_High_ERC_Value := (STRING)erccat005.HighERCValue;
		
		erccat006 := ercData.PropertyCharacteristics (category = '006')[1];
		SELF.ERCCalculations.Characteristics.Roofing_Material := erccat006.Material;
		SELF.ERCCalculations.Characteristics.Roofing_Material_Desc := erccat006.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Roofing_Value := (STRING)erccat006.Value;
		SELF.ERCCalculations.Characteristics.Roofing_Quality_Desc := erccat006.QualityDesc;
		SELF.ERCCalculations.Characteristics.Roofing_Condition_Desc := erccat006.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Roofing_Age := (STRING)erccat006.Age;
		SELF.ERCCalculations.Characteristics.Roofing_ERC_Value := (STRING)erccat006.ERCValue;
		SELF.ERCCalculations.Characteristics.Roofing_Low_ERC_Value := (STRING)erccat006.LowERCValue;
		SELF.ERCCalculations.Characteristics.Roofing_High_ERC_Value := (STRING)erccat006.HighERCValue;
		
		erccat007 := ercData.PropertyCharacteristics (category = '007')[1];
		SELF.ERCCalculations.Characteristics.Foundation_Material := erccat007.Material;
		SELF.ERCCalculations.Characteristics.Foundation_Material_Desc := erccat007.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Foundation_Value := (STRING)erccat007.Value;
		SELF.ERCCalculations.Characteristics.Foundation_Quality_Desc := erccat007.QualityDesc;
		SELF.ERCCalculations.Characteristics.Foundation_Condition_Desc := erccat007.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Foundation_Age := (STRING)erccat007.Age;
		SELF.ERCCalculations.Characteristics.Foundation_ERC_Value := (STRING)erccat007.ERCValue;
		SELF.ERCCalculations.Characteristics.Foundation_Low_ERC_Value := (STRING)erccat007.LowERCValue;
		SELF.ERCCalculations.Characteristics.Foundation_High_ERC_Value := (STRING)erccat007.HighERCValue;
		
		erccat008 := ercData.PropertyCharacteristics (category = '008')[1];
		SELF.ERCCalculations.Characteristics.Fireplace_Material := erccat008.Material;
		SELF.ERCCalculations.Characteristics.Fireplace_Material_Desc := erccat008.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Fireplace_Value := (STRING)erccat008.Value;
		SELF.ERCCalculations.Characteristics.Fireplace_Quality_Desc := erccat008.QualityDesc;
		SELF.ERCCalculations.Characteristics.Fireplace_Condition_Desc := erccat008.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Fireplace_Age := (STRING)erccat008.Age;
		SELF.ERCCalculations.Characteristics.Fireplace_ERC_Value := (STRING)erccat008.ERCValue;
		SELF.ERCCalculations.Characteristics.Fireplace_Low_ERC_Value := (STRING)erccat008.LowERCValue;
		SELF.ERCCalculations.Characteristics.Fireplace_High_ERC_Value := (STRING)erccat008.HighERCValue;
		
		erccat009 := ercData.PropertyCharacteristics (category = '009')[1];
		SELF.ERCCalculations.Characteristics.Balcony_Material := erccat009.Material;
		SELF.ERCCalculations.Characteristics.Balcony_Material_Desc := erccat009.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Balcony_Value := (STRING)erccat009.Value;
		SELF.ERCCalculations.Characteristics.Balcony_Quality_Desc := erccat009.QualityDesc;
		SELF.ERCCalculations.Characteristics.Balcony_Condition_Desc := erccat009.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Balcony_Age := (STRING)erccat009.Age;
		SELF.ERCCalculations.Characteristics.Balcony_ERC_Value := (STRING)erccat009.ERCValue;
		SELF.ERCCalculations.Characteristics.Balcony_Low_ERC_Value := (STRING)erccat009.LowERCValue;
		SELF.ERCCalculations.Characteristics.Balcony_High_ERC_Value := (STRING)erccat009.HighERCValue;
		
		erccat010 := ercData.PropertyCharacteristics (category = '010')[1];
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Material := erccat010.Material;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Material_Desc := erccat010.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Value := (STRING)erccat010.Value;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Quality_Desc := erccat010.QualityDesc;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Condition_Desc := erccat010.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Age := (STRING)erccat010.Age;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_ERC_Value := (STRING)erccat010.ERCValue;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_Low_ERC_Value := (STRING)erccat010.LowERCValue;
		SELF.ERCCalculations.Characteristics.Decks_and_Patios_High_ERC_Value := (STRING)erccat010.HighERCValue;
		
		erccat011 := ercData.PropertyCharacteristics (category = '011')[1];
		SELF.ERCCalculations.Characteristics.Porch_Material := erccat011.Material;
		SELF.ERCCalculations.Characteristics.Porch_Material_Desc := erccat011.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Porch_Value := (STRING)erccat011.Value;
		SELF.ERCCalculations.Characteristics.Porch_Quality_Desc := erccat011.QualityDesc;
		SELF.ERCCalculations.Characteristics.Porch_Condition_Desc := erccat011.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Porch_Age := (STRING)erccat011.Age;
		SELF.ERCCalculations.Characteristics.Porch_ERC_Value := (STRING)erccat011.ERCValue;
		SELF.ERCCalculations.Characteristics.Porch_Low_ERC_Value := (STRING)erccat011.LowERCValue;
		SELF.ERCCalculations.Characteristics.Porch_High_ERC_Value := (STRING)erccat011.HighERCValue;
		
		erccat012 := ercData.PropertyCharacteristics (category = '012')[1];
		SELF.ERCCalculations.Characteristics.Parking_Material := erccat012.Material;
		SELF.ERCCalculations.Characteristics.Parking_Material_Desc := erccat012.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Parking_Value := (STRING)erccat012.Value;
		SELF.ERCCalculations.Characteristics.Parking_Quality_Desc := erccat012.QualityDesc;
		SELF.ERCCalculations.Characteristics.Parking_Condition_Desc := erccat012.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Parking_Age := (STRING)erccat012.Age;
		SELF.ERCCalculations.Characteristics.Parking_ERC_Value := (STRING)erccat012.ERCValue;
		SELF.ERCCalculations.Characteristics.Parking_Low_ERC_Value := (STRING)erccat012.LowERCValue;
		SELF.ERCCalculations.Characteristics.Parking_High_ERC_Value := (STRING)erccat012.HighERCValue;
		
		erccat013 := ercData.PropertyCharacteristics (category = '013')[1];
		SELF.ERCCalculations.Characteristics.Basement_Material := erccat013.Material;
		SELF.ERCCalculations.Characteristics.Basement_Material_Desc := erccat013.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Basement_Value := (STRING)erccat013.Value;
		SELF.ERCCalculations.Characteristics.Basement_Quality_Desc := erccat013.QualityDesc;
		SELF.ERCCalculations.Characteristics.Basement_Condition_Desc := erccat013.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Basement_Age := (STRING)erccat013.Age;
		SELF.ERCCalculations.Characteristics.Basement_ERC_Value := (STRING)erccat013.ERCValue;
		SELF.ERCCalculations.Characteristics.Basement_Low_ERC_Value := (STRING)erccat013.LowERCValue;
		SELF.ERCCalculations.Characteristics.Basement_High_ERC_Value := (STRING)erccat013.HighERCValue;
		
		erccat014 := ercData.PropertyCharacteristics (category = '014')[1];
		SELF.ERCCalculations.Characteristics.Kitchen_Material := erccat014.Material;
		SELF.ERCCalculations.Characteristics.Kitchen_Material_Desc := erccat014.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Kitchen_Value := (STRING)erccat014.Value;
		SELF.ERCCalculations.Characteristics.Kitchen_Quality_Desc := erccat014.QualityDesc;
		SELF.ERCCalculations.Characteristics.Kitchen_Condition_Desc := erccat014.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Kitchen_Age := (STRING)erccat014.Age;
		SELF.ERCCalculations.Characteristics.Kitchen_ERC_Value := (STRING)erccat014.ERCValue;
		SELF.ERCCalculations.Characteristics.Kitchen_Low_ERC_Value := (STRING)erccat014.LowERCValue;
		SELF.ERCCalculations.Characteristics.Kitchen_High_ERC_Value := (STRING)erccat014.HighERCValue;
		
		erccat015 := ercData.PropertyCharacteristics (category = '015')[1];
		SELF.ERCCalculations.Characteristics.Bathroom_Material := erccat015.Material;
		SELF.ERCCalculations.Characteristics.Bathroom_Material_Desc := erccat015.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Bathroom_Value := (STRING)erccat015.Value;
		SELF.ERCCalculations.Characteristics.Bathroom_Quality_Desc := erccat015.QualityDesc;
		SELF.ERCCalculations.Characteristics.Bathroom_Condition_Desc := erccat015.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Bathroom_Age := (STRING)erccat015.Age;
		SELF.ERCCalculations.Characteristics.Bathroom_ERC_Value := (STRING)erccat015.ERCValue;
		SELF.ERCCalculations.Characteristics.Bathroom_Low_ERC_Value := (STRING)erccat015.LowERCValue;
		SELF.ERCCalculations.Characteristics.Bathroom_High_ERC_Value := (STRING)erccat015.HighERCValue;
		
		erccat016 := ercData.PropertyCharacteristics (category = '016')[1];
		SELF.ERCCalculations.Characteristics.Water_Material := erccat016.Material;
		SELF.ERCCalculations.Characteristics.Water_Material_Desc := erccat016.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Water_Value := (STRING)erccat016.Value;
		SELF.ERCCalculations.Characteristics.Water_Quality_Desc := erccat016.QualityDesc;
		SELF.ERCCalculations.Characteristics.Water_Condition_Desc := erccat016.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Water_Age := (STRING)erccat016.Age;
		SELF.ERCCalculations.Characteristics.Water_ERC_Value := (STRING)erccat016.ERCValue;
		SELF.ERCCalculations.Characteristics.Water_Low_ERC_Value := (STRING)erccat016.LowERCValue;
		SELF.ERCCalculations.Characteristics.Water_High_ERC_Value := (STRING)erccat016.HighERCValue;
		
		erccat017 := ercData.PropertyCharacteristics (category = '017')[1];
		SELF.ERCCalculations.Characteristics.Basecost_Material := erccat017.Material;
		SELF.ERCCalculations.Characteristics.Basecost_Material_Desc := erccat017.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Basecost_Value := (STRING)erccat017.Value;
		SELF.ERCCalculations.Characteristics.Basecost_Quality_Desc := erccat017.QualityDesc;
		SELF.ERCCalculations.Characteristics.Basecost_Condition_Desc := erccat017.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Basecost_Age := (STRING)erccat017.Age;
		SELF.ERCCalculations.Characteristics.Basecost_ERC_Value := (STRING)erccat017.ERCValue;
		SELF.ERCCalculations.Characteristics.Basecost_Low_ERC_Value := (STRING)erccat017.LowERCValue;
		SELF.ERCCalculations.Characteristics.Basecost_High_ERC_Value := (STRING)erccat017.HighERCValue;
		
		erccat018 := ercData.PropertyCharacteristics (category = '018')[1];
		SELF.ERCCalculations.Characteristics.Plumbing_Material := erccat018.Material;
		SELF.ERCCalculations.Characteristics.Plumbing_Material_Desc := erccat018.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Plumbing_Value := (STRING)erccat018.Value;
		SELF.ERCCalculations.Characteristics.Plumbing_Quality_Desc := erccat018.QualityDesc;
		SELF.ERCCalculations.Characteristics.Plumbing_Condition_Desc := erccat018.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Plumbing_Age := (STRING)erccat018.Age;
		SELF.ERCCalculations.Characteristics.Plumbing_ERC_Value := (STRING)erccat018.ERCValue;
		SELF.ERCCalculations.Characteristics.Plumbing_Low_ERC_Value := (STRING)erccat018.LowERCValue;
		SELF.ERCCalculations.Characteristics.Plumbing_High_ERC_Value := (STRING)erccat018.HighERCValue;
		
		erccat019 := ercData.PropertyCharacteristics (category = '019')[1];
		SELF.ERCCalculations.Characteristics.Style_Material := erccat019.Material;
		SELF.ERCCalculations.Characteristics.Style_Material_Desc := erccat019.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Style_Value := (STRING)erccat019.Value;
		SELF.ERCCalculations.Characteristics.Style_Quality_Desc := erccat019.QualityDesc;
		SELF.ERCCalculations.Characteristics.Style_Condition_Desc := erccat019.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Style_Age := (STRING)erccat019.Age;
		SELF.ERCCalculations.Characteristics.Style_ERC_Value := (STRING)erccat019.ERCValue;
		SELF.ERCCalculations.Characteristics.Style_Low_ERC_Value := (STRING)erccat019.LowERCValue;
		SELF.ERCCalculations.Characteristics.Style_High_ERC_Value := (STRING)erccat019.HighERCValue;
		
		erccat020 := ercData.PropertyCharacteristics (category = '020')[1];
		SELF.ERCCalculations.Characteristics.Fuel_Material := erccat020.Material;
		SELF.ERCCalculations.Characteristics.Fuel_Material_Desc := erccat020.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Fuel_Value := (STRING)erccat020.Value;
		SELF.ERCCalculations.Characteristics.Fuel_Quality_Desc := erccat020.QualityDesc;
		SELF.ERCCalculations.Characteristics.Fuel_Condition_Desc := erccat020.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Fuel_Age := (STRING)erccat020.Age;
		SELF.ERCCalculations.Characteristics.Fuel_ERC_Value := (STRING)erccat020.ERCValue;
		SELF.ERCCalculations.Characteristics.Fuel_Low_ERC_Value := (STRING)erccat020.LowERCValue;
		SELF.ERCCalculations.Characteristics.Fuel_High_ERC_Value := (STRING)erccat020.HighERCValue;
		
		erccat021 := ercData.PropertyCharacteristics (category = '021')[1];
		SELF.ERCCalculations.Characteristics.Garage_Material := erccat021.Material;
		SELF.ERCCalculations.Characteristics.Garage_Material_Desc := erccat021.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Garage_Value := (STRING)erccat021.Value;
		SELF.ERCCalculations.Characteristics.Garage_Quality_Desc := erccat021.QualityDesc;
		SELF.ERCCalculations.Characteristics.Garage_Condition_Desc := erccat021.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Garage_Age := (STRING)erccat021.Age;
		SELF.ERCCalculations.Characteristics.Garage_ERC_Value := (STRING)erccat021.ERCValue;
		SELF.ERCCalculations.Characteristics.Garage_Low_ERC_Value := (STRING)erccat021.LowERCValue;
		SELF.ERCCalculations.Characteristics.Garage_High_ERC_Value := (STRING)erccat021.HighERCValue;
		
		erccat022 := ercData.PropertyCharacteristics (category = '022')[1];
		SELF.ERCCalculations.Characteristics.Construction_Type_Material := erccat022.Material;
		SELF.ERCCalculations.Characteristics.Construction_Type_Material_Desc := erccat022.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Construction_Type_Value := (STRING)erccat022.Value;
		SELF.ERCCalculations.Characteristics.Construction_Type_Quality_Desc := erccat022.QualityDesc;
		SELF.ERCCalculations.Characteristics.Construction_Type_Condition_Desc := erccat022.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Construction_Type_Age := (STRING)erccat022.Age;
		SELF.ERCCalculations.Characteristics.Construction_Type_ERC_Value := (STRING)erccat022.ERCValue;
		SELF.ERCCalculations.Characteristics.Construction_Type_Low_ERC_Value := (STRING)erccat022.LowERCValue;
		SELF.ERCCalculations.Characteristics.Construction_Type_High_ERC_Value := (STRING)erccat022.HighERCValue;

		// There is no category 023...
		
		erccat024 := ercData.PropertyCharacteristics (category = '024')[1];
		SELF.ERCCalculations.Characteristics.Heating_Material := erccat024.Material;
		SELF.ERCCalculations.Characteristics.Heating_Material_Desc := erccat024.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Heating_Value := (STRING)erccat024.Value;
		SELF.ERCCalculations.Characteristics.Heating_Quality_Desc := erccat024.QualityDesc;
		SELF.ERCCalculations.Characteristics.Heating_Condition_Desc := erccat024.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Heating_Age := (STRING)erccat024.Age;
		SELF.ERCCalculations.Characteristics.Heating_ERC_Value := (STRING)erccat024.ERCValue;
		SELF.ERCCalculations.Characteristics.Heating_Low_ERC_Value := (STRING)erccat024.LowERCValue;
		SELF.ERCCalculations.Characteristics.Heating_High_ERC_Value := (STRING)erccat024.HighERCValue;
		
		erccat025 := ercData.PropertyCharacteristics (category = '025')[1];
		SELF.ERCCalculations.Characteristics.Frame_Material := erccat025.Material;
		SELF.ERCCalculations.Characteristics.Frame_Material_Desc := erccat025.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Frame_Value := (STRING)erccat025.Value;
		SELF.ERCCalculations.Characteristics.Frame_Quality_Desc := erccat025.QualityDesc;
		SELF.ERCCalculations.Characteristics.Frame_Condition_Desc := erccat025.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Frame_Age := (STRING)erccat025.Age;
		SELF.ERCCalculations.Characteristics.Frame_ERC_Value := (STRING)erccat025.ERCValue;
		SELF.ERCCalculations.Characteristics.Frame_Low_ERC_Value := (STRING)erccat025.LowERCValue;
		SELF.ERCCalculations.Characteristics.Frame_High_ERC_Value := (STRING)erccat025.HighERCValue;
		
		erccat026 := ercData.PropertyCharacteristics (category = '026')[1];
		SELF.ERCCalculations.Characteristics.Sewer_Material := erccat026.Material;
		SELF.ERCCalculations.Characteristics.Sewer_Material_Desc := erccat026.MaterialDesc;
		SELF.ERCCalculations.Characteristics.Sewer_Value := (STRING)erccat026.Value;
		SELF.ERCCalculations.Characteristics.Sewer_Quality_Desc := erccat026.QualityDesc;
		SELF.ERCCalculations.Characteristics.Sewer_Condition_Desc := erccat026.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Sewer_Age := (STRING)erccat026.Age;
		SELF.ERCCalculations.Characteristics.Sewer_ERC_Value := (STRING)erccat026.ERCValue;
		SELF.ERCCalculations.Characteristics.Sewer_Low_ERC_Value := (STRING)erccat026.LowERCValue;
		SELF.ERCCalculations.Characteristics.Sewer_High_ERC_Value := (STRING)erccat026.HighERCValue;
		
		erccat027 := ercData.PropertyCharacteristics (category = '027')[1];
		SELF.ERCCalculations.Characteristics.Pool_Material := erccat027.Material;
		SELF.ERCCalculations.Characteristics.Pool_Material_Desc := erccat027.MaterialDesc;	
		SELF.ERCCalculations.Characteristics.Pool_Value := (STRING)erccat027.Value;
		SELF.ERCCalculations.Characteristics.Pool_Quality_Desc := erccat027.QualityDesc;
		SELF.ERCCalculations.Characteristics.Pool_Condition_Desc := erccat027.ConditionDesc;
		SELF.ERCCalculations.Characteristics.Pool_Age := (STRING)erccat027.Age;
		SELF.ERCCalculations.Characteristics.Pool_ERC_Value := (STRING)erccat027.ERCValue;
		SELF.ERCCalculations.Characteristics.Pool_Low_ERC_Value := (STRING)erccat027.LowERCValue;
		SELF.ERCCalculations.Characteristics.Pool_High_ERC_Value := (STRING)erccat027.HighERCValue;	
		
		/*****************************************
		 *     ERC Descriptions Information      *
		 *****************************************/
		SELF.ERCCalculations.Descriptions.Classification := ercData.PropertyDescriptionRecordSet[1].Classification;
		SELF.ERCCalculations.Descriptions.Property_Desc := ercData.PropertyDescriptionRecordSet[1].PropertyDesc;
		SELF.ERCCalculations.Descriptions.Property_Addition_Value := (STRING)ercData.PropertyDescriptionRecordSet[1].PropertyAdditionValue;
		SELF.ERCCalculations.Descriptions.Property_Addition_Quality := ercData.PropertyDescriptionRecordSet[1].PropertyAdditionQuality;
		SELF.ERCCalculations.Descriptions.Property_Addition_Quality_Desc := ercData.PropertyDescriptionRecordSet[1].PropertyAdditionQualityDesc;
		SELF.ERCCalculations.Descriptions.Property_Addition_Condition := ercData.PropertyDescriptionRecordSet[1].PropertyAdditionCondition;
		SELF.ERCCalculations.Descriptions.Property_Addition_Condition_Desc := ercData.PropertyDescriptionRecordSet[1].PropertyAdditionConditionDesc;
		SELF.ERCCalculations.Descriptions.Living_Area_Indicator := ercData.PropertyDescriptionRecordSet[1].LivingAreaIndicator;
		SELF.ERCCalculations.Descriptions.ERC_Value := (STRING)ercData.PropertyDescriptionRecordSet[1].ERCValue;
		SELF.ERCCalculations.Descriptions.Low_ERC_Value := (STRING)ercData.PropertyDescriptionRecordSet[1].LowERCValue;
		SELF.ERCCalculations.Descriptions.High_ERC_Value := (STRING)ercData.PropertyDescriptionRecordSet[1].HighERCValue;
		
		SELF := [];
	END;
	
	flatProperty := PROJECT(withERC, flattenProperty(LEFT));
	
	Address_Shell.layoutPropertyCharacteristics intoFinal(Address_Shell.layoutInput le, Address_Shell.layoutPropertyCharacteristics ri) := TRANSFORM
		SELF.Input.StreetNumber := le.StreetNumber;
		SELF.Input.StreetPreDirection := le.StreetPreDirection;
		SELF.Input.StreetName := le.StreetName;
		SELF.Input.StreetSuffix := le.StreetSuffix;
		SELF.Input.StreetPostDirection := le.StreetPostDirection;
		SELF.Input.UnitDesignation := le.UnitDesignation;
		SELF.Input.UnitNumber := le.UnitNumber;
		SELF.Input.StreetAddress1 := le.StreetAddress1;
		SELF.Input.StreetAddress2 := le.StreetAddress2;
		SELF.Input.City := le.City;
		SELF.Input.State := le.State;
		SELF.Input.Zip5 := le.Zip5;
		SELF.Input.Zip4 := le.Zip4;
		SELF.Input.County := le.County;
		SELF.Input.PostalCode := le.PostalCode;
		SELF.Input.StateCityZip := le.StateCityZip;
		SELF.Input.GeoLat := le.GeoLat;
		SELF.Input.GeoLong := le.GeoLong;
		SELF.Input.GeoLink := le.GeoLink;
		
		SELF.Input := le;
		
		SELF := ri;
		SELF := [];
	END;
	// The Property Characteristics Service occassionally cleans the input City to a different City, since this is an XML only 
	// join and not batch both the left and right sides only have 1 record, so we can simply use TRUE instead of address based fields in 
	// case the Property Characteristics Report Service cleans to a different address than what we passed in.
	finalJoin := JOIN(input, flatProperty, TRUE, intoFinal(LEFT, RIGHT), LEFT OUTER, ALL);
	
	final := IF(propertyInformationAttributesVersion > 0 OR ercAttributesVersion > 0, finalJoin, justInput);
	
	/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	#if(Address_Shell.Constants.debugging)
		#STORED('PCJustInput', justInput);
		#STORED('PCReport', report);
		#STORED('PCPropertyData', propertyData);
		#STORED('PCBestPropertyData', bestPropertyData);
		#STORED('PCWithERC', withERC);
		#STORED('PCFlatProperty', flatProperty);
		#STORED('PCFinalJoin', finalJoin);
	#end
	
	RETURN final;
END;