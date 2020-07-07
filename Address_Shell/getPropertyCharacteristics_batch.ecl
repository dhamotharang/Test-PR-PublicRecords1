/* 
 * getPropertyCharacteristics_batch: This function takes in the input and calls out to
 * PropertyCharacteristics_Services.BatchService() to acquire Property Characteristic
 * information.  It then formats the result in a flat layout with the best possible
 * information.
 */

IMPORT iesp, InsuranceContext_iesp, ut,Address_Shell, Gateway;

EXPORT Address_Shell.layoutPropertyCharacteristics_batch.PropertyCharacteristics_batch getPropertyCharacteristics_batch
 (DATASET(Address_Shell.Layouts.address_shell_input) input, UNSIGNED1 propertyInformationAttributesVersion,
 DATASET(Gateway.Layouts.Config) gateway_cfg) := FUNCTION
/* ************************************************************
	 *        Place the input into the working layout:          *
	 ************************************************************ */											
	Address_Shell.layoutPropertyCharacteristics_batch.PropertyCharacteristics_batch intoWorking(Address_Shell.Layouts.address_shell_input le) := TRANSFORM
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
	reportServiceResult := Address_Shell.propertyCharacteristicsBatchSoapCallFunction(input, propertyInformationAttributesVersion, gateway_cfg);
	
	propertyData := SORT(reportServiceResult,streetnumber, streetpredirection,streetname,streetsuffix,streetpostdirection, 
																									unitdesignation, unitnumber, streetaddress1, streetaddress2, city, 
																									state, zip5, zip4, county, postalcode,datasource);
	// propertyData := SORT(reportServiceResult,acctno);																									
	
			#DECLARE(trans_characteristics);
			#SET(trans_characteristics, '');

			#DECLARE(trans_mortgages);
			#SET(trans_mortgages, '');

			#DECLARE (k);
			#SET (k, 1);
			#LOOP
				#IF (%k% > 85)
					#BREAK
				#ELSE
					#APPEND (trans_characteristics,'{le.Category_' + %'k'% + ',le.CategoryDesc_' + %'k'% + ',le.Material_' + %'k'% + ',le.MaterialDesc_' + %'k'% + ',le.Value_' + %'k'% + '},');
					#SET (k, %k% + 1);
				#END
			#END

			#SET (k, 1);
			#LOOP
				#IF (%k% > 3)
					#BREAK
				#ELSE
					#APPEND (trans_mortgages,'{le.MortgageCompanyName_' + %'k'% + ',le.MortgageType_' + %'k'% + ',le.MortgageTypeDesc_' + %'k'% + ',le.LoanAmount_' + %'k'% +
																	 ',le.LoanTypeCode_' + %'k'% + ',le.LoanType_' + %'k'% + ',le.InterestRate_' + %'k'% + ',le.InterestRateTypeCode_' + %'k'% +  
																	 ',le.InterestRateType_' + %'k'% + ',le.MortgageLoanNumber_' + %'k'% + ',le.FsiMortgageLoanNumber_' + %'k'% +
																	 ',le.FsiMortgageCompanyName_' + %'k'% + ',le.Classification_' + %'k'% + '},');
					#SET (k, %k% + 1);
				#END
			#END	
	
	Address_Shell.layouts.PC_Soap_out_slim ConvertIntoDS (Address_Shell.layouts.PC_Soap_out le) := transform
				
			PC := dataset([
										 %trans_characteristics%
										 {'','','','',0.0}
										 ],Address_Shell.layouts.PropertyCharacteristicRecordReport);
			MTG := dataset([
											%trans_mortgages%
											{'',0,'',0.0,'','',0.0,'','','','','',''}
										 ],Address_Shell.layouts.MortgageRecordReport);
										 
			self.PropertyCharacteristics := PC;
			self.Mortgages := MTG;
			self := le;
	END;
	
	Property_transposed := project(propertyData,ConvertIntoDS(left));
	
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
	Address_Shell.layouts.PC_Soap_out_slim rollup_property(Address_Shell.layouts.PC_Soap_out_slim le,Address_Shell.layouts.PC_Soap_out_slim ri) := TRANSFORM

		
		/*****************************************
		 *         Address Information           *
		 *****************************************/
		SELF.CensusTract := IF(TRIM(le.CensusTract) <> '', le.CensusTract, ri.CensusTract);
    SELF.acctno      := le.acctno;
		/*****************************************
		 *       Attributes Information          *
		 *****************************************/
		SELF.livingareasf := IF(keepLeft(le.CF1_LivingAreaSquareFootage, ri.CF1_LivingAreaSquareFootage), le.livingareasf, ri.livingareasf);
		SELF.CF1_LivingAreaSquareFootage := IF(keepLeft(le.CF1_LivingAreaSquareFootage, ri.CF1_LivingAreaSquareFootage), le.CF1_LivingAreaSquareFootage, ri.CF1_LivingAreaSquareFootage);
		SELF.Stories := IF(keepLeft(le.CF1_numberofstories, ri.CF1_numberofstories), le.stories, ri.stories);
		SELF.CF1_numberofstories := IF(keepLeft(le.CF1_numberofstories, ri.CF1_numberofstories), le.CF1_numberofstories, ri.CF1_numberofstories);
		SELF.Bedrooms := IF(keepLeft(le.CF1_numberofbedrooms, ri.CF1_numberofbedrooms), le.bedrooms, ri.bedrooms);
		SELF.CF1_numberofbedrooms := IF(keepLeft(le.CF1_numberofbedrooms, ri.CF1_numberofbedrooms), le.CF1_numberofbedrooms, ri.CF1_numberofbedrooms);
		SELF.Baths := IF(keepLeft(le.CF1_numberofbaths, ri.CF1_numberofbaths), le.baths, ri.baths);
		SELF.CF1_numberofbaths := IF(keepLeft(le.CF1_numberofbaths, ri.CF1_numberofbaths), le.CF1_numberofbaths, ri.CF1_numberofbaths);
		SELF.Fireplaces := IF(keepLeft(le.CF1_numberoffireplaces, ri.CF1_numberoffireplaces), le.fireplaces, ri.fireplaces);
		SELF.CF1_numberoffireplaces := IF(keepLeft(le.CF1_numberoffireplaces, ri.CF1_numberoffireplaces), le.CF1_numberoffireplaces, ri.CF1_numberoffireplaces);
		SELF.Pool := IF(keepLeft(le.CF1_poolindicator, ri.CF1_poolindicator), le.pool, ri.pool);
		SELF.CF1_poolindicator := IF(keepLeft(le.CF1_poolindicator, ri.CF1_poolindicator), le.CF1_poolindicator, ri.CF1_poolindicator);
		SELF.AC := IF(keepLeft(le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode), le.ac, ri.ac);
		SELF.CF1_airconditioningtypecode := IF(keepLeft(le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode), le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode);
		SELF.yearbuilt := IF(keepLeft(le.CF1_yearbuilt, ri.CF1_yearbuilt), le.yearbuilt, ri.yearbuilt);
		SELF.CF1_yearbuilt := IF(keepLeft(le.CF1_yearbuilt, ri.CF1_yearbuilt), le.CF1_yearbuilt, ri.CF1_yearbuilt);
		// SELF.PropertyCharacteristics.Attributes.Slope := propData.PropertyAttributes.Slope;
		// SELF.PropertyCharacteristics.Attributes.Slope_ConfidenceFactor := propData.PropertyAttributes.Slope;
		SELF.qualityofstruct := IF(keepLeft(le.CF1_qualityofstructurecode, ri.CF1_qualityofstructurecode), le.qualityofstruct, ri.qualityofstruct);
		SELF.CF1_qualityofstructurecode := IF(keepLeft(le.CF1_qualityofstructurecode, ri.CF1_qualityofstructurecode), le.CF1_qualityofstructurecode, ri.CF1_qualityofstructurecode);
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id_ConfidenceFactor := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value_ConfidenceFactor := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		SELF.fireplaceindicator := IF(keepLeft(le.CF1_fireplaceindicator, ri.CF1_fireplaceindicator), le.fireplaceindicator, ri.fireplaceindicator);
		SELF.CF1_fireplaceindicator := IF(keepLeft(le.CF1_fireplaceindicator, ri.CF1_fireplaceindicator), le.CF1_fireplaceindicator, ri.CF1_fireplaceindicator);
		SELF.Units := IF(keepLeft(le.CF1_numberofunits, ri.CF1_numberofunits), le.units, ri.units);
		SELF.CF1_numberofunits := IF(keepLeft(le.CF1_numberofunits, ri.CF1_numberofunits), le.CF1_numberofunits, ri.CF1_numberofunits);
		SELF.Rooms := IF(keepLeft(le.CF1_numberofrooms, ri.CF1_numberofrooms), le.rooms, ri.rooms);
		SELF.CF1_numberofrooms := IF(keepLeft(le.CF1_numberofrooms, ri.CF1_numberofrooms), le.CF1_numberofrooms, ri.CF1_numberofrooms);
		SELF.fullbaths := IF(keepLeft(le.CF1_numberoffullbaths, ri.CF1_numberoffullbaths), le.fullbaths, ri.fullbaths);
		SELF.CF1_numberoffullbaths := IF(keepLeft(le.CF1_numberoffullbaths, ri.CF1_numberoffullbaths), le.CF1_numberoffullbaths, ri.CF1_numberoffullbaths);
		SELF.halfbaths := IF(keepLeft(le.CF1_numberofhalfbaths, ri.CF1_numberofhalfbaths), le.halfbaths, ri.halfbaths);
		SELF.CF1_numberofhalfbaths := IF(keepLeft(le.CF1_numberofhalfbaths, ri.CF1_numberofhalfbaths), le.CF1_numberofhalfbaths, ri.CF1_numberofhalfbaths);
		SELF.bathfixtures := IF(keepLeft(le.CF1_numberofbathfixtures, ri.CF1_numberofbathfixtures), le.bathfixtures, ri.bathfixtures);
		SELF.CF1_numberofbathfixtures := IF(keepLeft(le.CF1_numberofbathfixtures, ri.CF1_numberofbathfixtures), le.CF1_numberofbathfixtures, ri.CF1_numberofbathfixtures);
		SELF.effectiveyearbuilt := IF(keepLeft(le.CF1_effectiveyearbuilt, ri.CF1_effectiveyearbuilt), le.effectiveyearbuilt, ri.effectiveyearbuilt);
		SELF.CF1_effectiveyearbuilt := IF(keepLeft(le.CF1_effectiveyearbuilt, ri.CF1_effectiveyearbuilt), le.CF1_effectiveyearbuilt, ri.CF1_effectiveyearbuilt);
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure := propData.PropertyAttributes.ConditionOfStructure;
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure_ConfidenceFactor := propData.PropertyAttributes.ConditionOfStructure;
		SELF.buildingareasf := IF(keepLeft(le.CF1_buildingsquarefootage, ri.CF1_buildingsquarefootage), le.buildingareasf, ri.buildingareasf);
		SELF.CF1_buildingsquarefootage := IF(keepLeft(le.CF1_buildingsquarefootage, ri.CF1_buildingsquarefootage), le.CF1_buildingsquarefootage, ri.CF1_buildingsquarefootage);
		SELF.groundfloorareasf := IF(keepLeft(le.CF1_groundfloorsquarefootage, ri.CF1_groundfloorsquarefootage), le.groundfloorareasf, ri.groundfloorareasf);
		SELF.CF1_groundfloorsquarefootage := IF(keepLeft(le.CF1_groundfloorsquarefootage, ri.CF1_groundfloorsquarefootage), le.CF1_groundfloorsquarefootage, ri.CF1_groundfloorsquarefootage);
		SELF.basementareasf := IF(keepLeft(le.CF1_basementsquarefootage, ri.CF1_basementsquarefootage), le.basementareasf, ri.basementareasf);
		SELF.CF1_basementsquarefootage := IF(keepLeft(le.CF1_basementsquarefootage, ri.CF1_basementsquarefootage), le.CF1_basementsquarefootage, ri.CF1_basementsquarefootage);
		SELF.garageareasf := IF(keepLeft(le.CF1_garagesquarefootage, ri.CF1_garagesquarefootage), le.garageareasf, ri.garageareasf);
		SELF.CF1_garagesquarefootage := IF(keepLeft(le.CF1_garagesquarefootage, ri.CF1_garagesquarefootage), le.CF1_garagesquarefootage, ri.CF1_garagesquarefootage);
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence := propData.PropertyAttributes.TypeOfResidence;
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence_ConfidenceFactor := propData.PropertyAttributes.TypeOfResidence;
		SELF.floodzonepanelnumber := IF(keepLeft(le.CF1_floodzonepanelnumber, ri.CF1_floodzonepanelnumber), le.floodzonepanelnumber, ri.floodzonepanelnumber);
		SELF.CF1_floodzonepanelnumber := IF(keepLeft(le.CF1_floodzonepanelnumber, ri.CF1_floodzonepanelnumber), le.CF1_floodzonepanelnumber, ri.CF1_floodzonepanelnumber);
		SELF.storiestype := IF(keepLeft(le.CF1_storiestype, ri.CF1_storiestype), le.storiestype, ri.storiestype);
		SELF.CF1_storiestype := IF(keepLeft(le.CF1_storiestype, ri.CF1_storiestype), le.CF1_storiestype, ri.CF1_storiestype);
		
		/*****************************************
		 *     Characteristics Information       *
		 *****************************************/
		unknownTypes := ['UNK', 'UD0'];
		
	  leAC := le.PropertyCharacteristics (category = '001');
		riAC := ri.PropertyCharacteristics (category = '001');
		cat001 := IF(keepLeft(le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode) AND EXISTS(leAC) AND (leAC[1].material NOT IN unknownTypes), 
																	leAC, 
																	IF(EXISTS(riAC), riAC, leAC)); // If there is data at the right, use it - if not continue with the left side data
		// SELF.CF1_airconditioningtypecode := IF(keepLeft(le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode), le.CF1_airconditioningtypecode, ri.CF1_airconditioningtypecode);
		
		leFloor := le.PropertyCharacteristics (category = '003');
		riFloor := ri.PropertyCharacteristics (category = '003');
		cat003 := IF(keepLeft(le.CF1_floortype, ri.CF1_floortype) AND EXISTS(leFloor) AND (leFloor[1].material NOT IN unknownTypes), 
																	leFloor, 
																	IF(EXISTS(riFloor), riFloor, leFloor));

		SELF.CF1_floortype := IF(keepLeft(le.CF1_floortype, ri.CF1_floortype), le.CF1_floortype, ri.CF1_floortype);
		
		leExteriorWall := le.PropertyCharacteristics (category = '005');
		riExteriorWall := ri.PropertyCharacteristics (category = '005');
		cat005 := IF(keepLeft(le.CF1_exteriorwalltype, ri.CF1_exteriorwalltype) AND EXISTS(leExteriorWall) AND (leExteriorWall[1].material NOT IN unknownTypes), 
																	leExteriorWall, 
																	IF(EXISTS(riExteriorWall), riExteriorWall, leExteriorWall));
		SELF.CF1_exteriorwalltype := IF(keepLeft(le.CF1_exteriorwalltype, ri.CF1_exteriorwalltype), le.CF1_exteriorwalltype, ri.CF1_exteriorwalltype);
		
		leRoof := le.PropertyCharacteristics (category = '006');
		riRoof := ri.PropertyCharacteristics (category = '006');
		cat006 := IF(keepLeft(le.CF1_roofcovertype, ri.CF1_roofcovertype) AND EXISTS(leRoof) AND (leRoof[1].material NOT IN unknownTypes), 
																	leRoof, 
																	IF(EXISTS(riRoof), riRoof, leRoof));
		SELF.CF1_roofcovertype := IF(keepLeft(le.CF1_roofcovertype, ri.CF1_roofcovertype), le.CF1_roofcovertype, ri.CF1_roofcovertype);
		
		leFoundation := le.PropertyCharacteristics (category = '007');
		riFoundation := ri.PropertyCharacteristics (category = '007');
		cat007 := IF(keepLeft(le.CF1_foundationtype, ri.CF1_foundationtype) AND EXISTS(leFoundation) AND (leFoundation[1].material NOT IN unknownTypes), 
																	leFoundation, 
																	IF(EXISTS(riFoundation), riFoundation, leFoundation));
		SELF.CF1_foundationtype := IF(keepLeft(le.CF1_foundationtype, ri.CF1_foundationtype), le.CF1_foundationtype, ri.CF1_foundationtype);
		
		leFireplace := le.PropertyCharacteristics (category = '008');
		riFireplace := ri.PropertyCharacteristics (category = '008');
		cat008 := IF(keepLeft(le.CF1_fireplacetype, ri.CF1_fireplacetype) AND EXISTS(leFireplace) AND (leFireplace[1].material NOT IN unknownTypes), 
																	leFireplace, 
																	IF(EXISTS(riFireplace), riFireplace, leFireplace));
		SELF.CF1_fireplacetype := IF(keepLeft(le.CF1_fireplacetype, ri.CF1_fireplacetype), le.CF1_fireplacetype, ri.CF1_fireplacetype);
		
		leParking := le.PropertyCharacteristics (category = '012');
		riParking := ri.PropertyCharacteristics (category = '012');
		cat012 := IF(keepLeft(le.CF1_parkingtype, ri.CF1_parkingtype) AND EXISTS(leParking) AND (leParking[1].material NOT IN unknownTypes), 
																	leParking, 
																	IF(EXISTS(riParking), riParking, leParking));

		SELF.CF1_parkingtype := IF(keepLeft(le.CF1_parkingtype, ri.CF1_parkingtype), le.CF1_parkingtype, ri.CF1_parkingtype);
		
		leBasement := le.PropertyCharacteristics (category = '013');
		riBasement := ri.PropertyCharacteristics (category = '013');
		cat013 := IF(keepLeft(le.CF1_basementfinishtype, ri.CF1_basementfinishtype) AND EXISTS(leBasement) AND (leBasement[1].material NOT IN unknownTypes), 
																	leBasement, 
																	IF(EXISTS(riBasement), riBasement, leBasement));
		SELF.CF1_basementfinishtype := IF(keepLeft(le.CF1_basementfinishtype, ri.CF1_basementfinishtype), le.CF1_basementfinishtype, ri.CF1_basementfinishtype);
		
		leWater := le.PropertyCharacteristics (category = '016');
		riWater := ri.PropertyCharacteristics (category = '016');
		cat016 := IF(keepLeft(le.CF1_watertype, ri.CF1_watertype) AND EXISTS(leWater) AND (leWater[1].material NOT IN unknownTypes), 
																	leWater, 
																	IF(EXISTS(riWater), riWater, leWater));
		SELF.CF1_watertype := IF(keepLeft(le.CF1_watertype, ri.CF1_watertype), le.CF1_watertype, ri.CF1_watertype);
		
		leStyle := le.PropertyCharacteristics (category = '019');
		riStyle := ri.PropertyCharacteristics (category = '019');
		cat019 := IF(keepLeft(le.CF1_styletype, ri.CF1_styletype) AND EXISTS(leStyle) AND (leStyle[1].material NOT IN unknownTypes), 
																	leStyle, 
																	IF(EXISTS(riStyle), riStyle, leStyle));

		SELF.CF1_styletype := IF(keepLeft(le.CF1_styletype, ri.CF1_styletype), le.CF1_styletype, ri.CF1_styletype);
		
		leFuel := le.PropertyCharacteristics (category = '020');
		riFuel := ri.PropertyCharacteristics (category = '020');
		cat020 := IF(keepLeft(le.CF1_fueltype, ri.CF1_fueltype) AND EXISTS(leFuel) AND (leFuel[1].material NOT IN unknownTypes), 
																	leFuel, 
																	IF(EXISTS(riFuel), riFuel, leFuel));
		SELF.CF1_fueltype := IF(keepLeft(le.CF1_fueltype, ri.CF1_fueltype), le.CF1_fueltype, ri.CF1_fueltype);
		
		leGarage := le.PropertyCharacteristics (category = '021');
		riGarage := ri.PropertyCharacteristics (category = '021');
		cat021 := IF(keepLeft(le.CF1_garagecarporttype, ri.CF1_garagecarporttype) AND EXISTS(leGarage) AND (leGarage[1].material NOT IN unknownTypes), 
																	leGarage, 
																	IF(EXISTS(riGarage), riGarage, leGarage));

		SELF.CF1_garagecarporttype := IF(keepLeft(le.CF1_garagecarporttype, ri.CF1_garagecarporttype), le.CF1_garagecarporttype, ri.CF1_garagecarporttype);
		
		leConstruction := le.PropertyCharacteristics (category = '022');
		riConstruction := ri.PropertyCharacteristics (category = '022');
		cat022 := IF(keepLeft(le.CF1_constructiontype, ri.CF1_constructiontype) AND EXISTS(leConstruction) AND (leConstruction[1].material NOT IN unknownTypes), 
																	leConstruction, 
																	IF(EXISTS(riConstruction), riConstruction, leConstruction));
		SELF.CF1_constructiontype := IF(keepLeft(le.CF1_constructiontype, ri.CF1_constructiontype), le.CF1_constructiontype, ri.CF1_constructiontype);

		// There is no category 023...
		
		leHeating := le.PropertyCharacteristics (category = '024');
		riHeating := ri.PropertyCharacteristics (category = '024');
		cat024 := IF(keepLeft(le.CF1_heatingtype, ri.CF1_heatingtype) AND EXISTS(leHeating) AND (leHeating[1].material NOT IN unknownTypes), 
																	leHeating, 
																	IF(EXISTS(riHeating), riHeating, leHeating));
		SELF.CF1_heatingtype := IF(keepLeft(le.CF1_heatingtype, ri.CF1_heatingtype), le.CF1_heatingtype, ri.CF1_heatingtype);
		
		leFrame := le.PropertyCharacteristics (category = '025');
		riFrame := ri.PropertyCharacteristics (category = '025');
		cat025 := IF(keepLeft(le.CF1_frametype, ri.CF1_frametype) AND EXISTS(leFrame) AND (leFrame[1].material NOT IN unknownTypes), 
																	leFrame, 
																	IF(EXISTS(riFrame), riFrame, leFrame));

		SELF.CF1_frametype := IF(keepLeft(le.CF1_frametype, ri.CF1_frametype), le.CF1_frametype, ri.CF1_frametype);
		
		leSewer := le.PropertyCharacteristics (category = '026');
		riSewer := ri.PropertyCharacteristics (category = '026');
		cat026 := IF(keepLeft(le.CF1_sewertype, ri.CF1_sewertype) AND EXISTS(leSewer) AND (leSewer[1].material NOT IN unknownTypes), 
																	leSewer, 
																	IF(EXISTS(riSewer), riSewer, leSewer));

		SELF.CF1_sewertype := IF(keepLeft(le.CF1_sewertype, ri.CF1_sewertype), le.CF1_sewertype, ri.CF1_sewertype);
		
		lePool := le.PropertyCharacteristics (category = '027');
		riPool := ri.PropertyCharacteristics (category = '027');
		cat027 := IF(keepLeft(le.CF1_pooltype, ri.CF1_pooltype) AND EXISTS(lePool) AND (lePool[1].material NOT IN unknownTypes), 
																	lePool, 
																	IF(EXISTS(riPool), riPool, lePool));

		SELF.CF1_pooltype := IF(keepLeft(le.CF1_pooltype, ri.CF1_pooltype), le.CF1_pooltype, ri.CF1_pooltype);
		
		propertyChars := cat001 + cat003 + cat005 + cat006 + cat007 + cat008 + cat012 + cat013 + cat016 + cat019 + cat020 + cat021 + cat022 + cat024 + cat025 + cat026 + cat027;
		SELF.PropertyCharacteristics := propertyChars;		
		/*****************************************
		 *         Mortgages Information         *
		 *****************************************/
		leMortgage := le.Mortgages[1];
		riMortgage := ri.Mortgages[1];
		
		mortgagecompanyname := IF(keepLeft(le.CF2_mortgagecompanyname, ri.CF2_mortgagecompanyname), leMortgage.mortgagecompanyname, riMortgage.mortgagecompanyname);
		mortgagetype := IF(keepLeft(le.CF2_mortgagecompanyname, ri.CF2_mortgagecompanyname), leMortgage.mortgagetype, riMortgage.mortgagetype);
		mortgagetypedesc := IF(keepLeft(le.CF2_mortgagecompanyname, ri.CF2_mortgagecompanyname), leMortgage.mortgagetypedesc, riMortgage.mortgagetypedesc);
		loanamount := IF(keepLeft(le.CF2_loanamount, ri.CF2_loanamount), leMortgage.loanamount, riMortgage.loanamount);
		loantypecode := IF(keepLeft(le.CF2_loantypecode, ri.CF2_loantypecode), leMortgage.loantypecode, riMortgage.loantypecode);
		loantype := IF(keepLeft(le.CF2_loantypecode, ri.CF2_loantypecode), leMortgage.loantype, riMortgage.loantype);
		interestrate := IF(keepLeft(le.CF2_interestratetypecode, ri.CF2_interestratetypecode), leMortgage.interestrate, riMortgage.interestrate);
		interestratetypecode := IF(keepLeft(le.CF2_interestratetypecode, ri.CF2_interestratetypecode), leMortgage.interestratetypecode, riMortgage.interestratetypecode);
		
		SELF.mortgages := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(Address_Shell.Layouts.MortgageRecordReport,
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
																													
		mortgage_confidencefactor :=IF(keepLeft(le.CF2_mortgagecompanyname, ri.CF2_mortgagecompanyname), le.CF2_mortgagecompanyname, ri.CF2_mortgagecompanyname);
		loanamount_confidencefactor := IF(keepLeft(le.CF2_loanamount, ri.CF2_loanamount), le.CF2_loanamount, ri.CF2_loanamount);
		loantype_confidencefactor := IF(keepLeft(le.CF2_loantypecode, ri.CF2_loantypecode), le.CF2_loantypecode, ri.CF2_loantypecode);
		interestrate_confidencefactor := IF(keepLeft(le.CF2_interestratetypecode, ri.CF2_interestratetypecode), le.CF2_interestratetypecode, ri.CF2_interestratetypecode);		

		SELF.CF2_mortgagecompanyname := mortgage_confidencefactor;
		SELF.CF2_loanamount :=loanamount_confidencefactor;
		SELF.CF2_loantypecode := loantype_confidencefactor; // Loan_Type_Code and Loan_Type use the same record, so just use the LoanTypeCode Confidence Factor
		SELF.CF2_interestratetypecode := interestrate_confidencefactor;
		
		/*****************************************
		 *          Sales Information            *
		 *****************************************/
		// formatDate (STRING Year, STRING Month, STRING Day) := IF(LENGTH(TRIM(Year)) = 4, Year, '') + IF(LENGTH(TRIM(Month)) = 2, Month, IF(LENGTH(TRIM(Month)) = 1, '0' + Month, '')) + IF(LENGTH(TRIM(Day)) = 2, Day, IF(LENGTH(TRIM(Day)) = 1, '0' + Day, ''));
		// deedDate := formatDate((STRING)propData.PropertySales.DeedRecordingDate.Year, (STRING)propData.PropertySales.DeedRecordingDate.Month, (STRING)propData.PropertySales.DeedRecordingDate.Day);
		SELF.deedrecordingdate := IF(keepLeft(le.CF2_deedrecordingdate, ri.CF2_deedrecordingdate), le.deedrecordingdate, ri.deedrecordingdate);
		SELF.CF2_deedrecordingdate := IF(keepLeft(le.CF2_deedrecordingdate, ri.CF2_deedrecordingdate), le.CF2_deedrecordingdate, ri.CF2_deedrecordingdate);
		// salesDate := formatDate((STRING)propData.PropertySales.SalesDate.Year, (STRING)propData.PropertySales.SalesDate.Month, (STRING)propData.PropertySales.SalesDate.Day);
		SELF.salesdate := IF(keepLeft(le.CF2_salesdate, ri.CF2_salesdate), le.salesdate, ri.salesdate);
		SELF.CF2_salesdate := IF(keepLeft(le.CF2_salesdate, ri.CF2_salesdate), le.CF2_salesdate, ri.CF2_salesdate);
		SELF.deeddocumentnumber := IF(keepLeft(le.CF2_deeddocumentnumber, ri.CF2_deeddocumentnumber), le.deeddocumentnumber, ri.deeddocumentnumber);
		SELF.CF2_deeddocumentnumber := IF(keepLeft(le.CF2_deeddocumentnumber, ri.CF2_deeddocumentnumber), le.CF2_deeddocumentnumber, ri.CF2_deeddocumentnumber);
		SELF.salesamount := IF(keepLeft(le.CF2_salesamount, ri.CF2_salesamount), le.salesamount, ri.salesamount);
		SELF.CF2_salesamount := IF(keepLeft(le.CF2_salesamount, ri.CF2_salesamount), le.CF2_salesamount, ri.CF2_salesamount);
		SELF.salestype := IF(keepLeft(le.CF2_salestypecode, ri.CF2_salestypecode), le.salestype, ri.salestype);
		SELF.CF2_salestypecode := IF(keepLeft(le.CF2_salestypecode, ri.CF2_salestypecode), le.CF2_salestypecode, ri.CF2_salestypecode);

		/*****************************************
		 *          Taxes Information            *
		 *****************************************/
		SELF.landusecode := IF(keepLeft(le.CF1_landusecode, ri.CF1_landusecode), le.landusecode, ri.landusecode);
		SELF.CF1_landusecode := IF(keepLeft(le.CF1_landusecode, ri.CF1_landusecode), le.CF1_landusecode, ri.CF1_landusecode); // Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.landuse := IF(keepLeft(le.CF1_landusecode, ri.CF1_landusecode), le.landuse, ri.landuse);
		// SELF.CF1_landusecode := IF(keepLeft(le.CF1_landusecode, ri.CF1_landusecode), le.CF1_landusecode, ri.CF1_landusecode);// Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.propertytypecode := IF(keepLeft(le.CF1_propertytypecode, ri.CF1_propertytypecode), le.propertytypecode, ri.propertytypecode);
		SELF.CF1_propertytypecode := IF(keepLeft(le.CF1_propertytypecode, ri.CF1_propertytypecode), le.CF1_propertytypecode, ri.CF1_propertytypecode); // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.propertytype := IF(keepLeft(le.CF1_propertytypecode, ri.CF1_propertytypecode), le.propertytype, ri.propertytype);
		// SELF.CF1_propertytypecode := IF(keepLeft(le.CF1_propertytypecode, ri.CF1_propertytypecode), le.CF1_propertytypecode, ri.CF1_propertytypecode); // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.lotsize := IF(keepLeft(le.CF1_lotsize, ri.CF1_lotsize), le.lotsize, ri.lotsize);
		SELF.CF1_lotsize := IF(keepLeft(le.CF1_lotsize, ri.CF1_lotsize), le.CF1_lotsize, ri.CF1_lotsize);
		SELF.lotfrontfootage := IF(keepLeft(le.CF1_lotfrontfootage, ri.CF1_lotfrontfootage), le.lotfrontfootage, ri.lotfrontfootage);
		SELF.CF1_lotfrontfootage := IF(keepLeft(le.CF1_lotfrontfootage, ri.CF1_lotfrontfootage), le.CF1_lotfrontfootage, ri.CF1_lotfrontfootage);
		SELF.lotdepthfootage := IF(keepLeft(le.CF1_lotdepthfootage, ri.CF1_lotdepthfootage), le.lotdepthfootage, ri.lotdepthfootage);
		SELF.CF1_lotdepthfootage := IF(keepLeft(le.CF1_lotdepthfootage, ri.CF1_lotdepthfootage), le.CF1_lotdepthfootage, ri.CF1_lotdepthfootage);
		SELF.acres := IF(keepLeft(le.CF1_acres, ri.CF1_acres), le.acres, ri.acres);
		SELF.CF1_acres := IF(keepLeft(le.CF1_acres, ri.CF1_acres), le.CF1_acres, ri.CF1_acres);
		SELF.totalassessedvalue := IF(keepLeft(le.CF1_totalassessedvalue, ri.CF1_totalassessedvalue), le.totalassessedvalue, ri.totalassessedvalue);
		SELF.CF1_totalassessedvalue := IF(keepLeft(le.CF1_totalassessedvalue, ri.CF1_totalassessedvalue), le.CF1_totalassessedvalue, ri.CF1_totalassessedvalue);
		SELF.totalcalculatedvalue := IF(keepLeft(le.CF1_totalcalculatedvalue, ri.CF1_totalcalculatedvalue), le.totalcalculatedvalue, ri.totalcalculatedvalue);
		SELF.CF1_totalcalculatedvalue := IF(keepLeft(le.CF1_totalcalculatedvalue, ri.CF1_totalcalculatedvalue), le.CF1_totalcalculatedvalue, ri.CF1_totalcalculatedvalue);
		SELF.totalmarketvalue := IF(keepLeft(le.CF1_totalmarketvalue, ri.CF1_totalmarketvalue), le.totalmarketvalue, ri.totalmarketvalue);
		SELF.CF1_totalmarketvalue := IF(keepLeft(le.CF1_totalmarketvalue, ri.CF1_totalmarketvalue), le.CF1_totalmarketvalue, ri.CF1_totalmarketvalue);
		SELF.totallandvalue := IF(keepLeft(le.CF1_totallandvalue, ri.CF1_totallandvalue), le.totallandvalue, ri.totallandvalue);
		SELF.CF1_totallandvalue := IF(keepLeft(le.CF1_totallandvalue, ri.CF1_totallandvalue), le.CF1_totallandvalue, ri.CF1_totallandvalue);
		SELF.marketlandvalue := IF(keepLeft(le.CF1_marketlandvalue, ri.CF1_marketlandvalue), le.marketlandvalue, ri.marketlandvalue);
		SELF.CF1_marketlandvalue := IF(keepLeft(le.CF1_marketlandvalue, ri.CF1_marketlandvalue), le.CF1_marketlandvalue, ri.CF1_marketlandvalue);
		SELF.assessedlandvalue := IF(keepLeft(le.CF1_assessedlandvalue, ri.CF1_assessedlandvalue), le.assessedlandvalue, ri.assessedlandvalue);
		SELF.CF1_assessedlandvalue := IF(keepLeft(le.CF1_assessedlandvalue, ri.CF1_assessedlandvalue), le.CF1_assessedlandvalue, ri.CF1_assessedlandvalue);
		SELF.improvementvalue := IF(keepLeft(le.CF1_improvementvalue, ri.CF1_improvementvalue), le.improvementvalue, ri.improvementvalue);
		SELF.CF1_improvementvalue := IF(keepLeft(le.CF1_improvementvalue, ri.CF1_improvementvalue), le.CF1_improvementvalue, ri.CF1_improvementvalue);
		SELF.assessedyear := IF(keepLeft(le.CF1_assessedyear, ri.CF1_assessedyear), le.assessedyear, ri.assessedyear);
		SELF.CF1_assessedyear := IF(keepLeft(le.CF1_assessedyear, ri.CF1_assessedyear), le.CF1_assessedyear, ri.CF1_assessedyear);
		
		
		SELF.taxbillingyear := IF(keepLeft(le.CF1_TaxBillingYear, ri.CF1_TaxBillingYear), le.taxbillingyear, ri.taxbillingyear);
		SELF.CF1_TaxBillingYear := IF(keepLeft(le.CF1_TaxBillingYear, ri.CF1_TaxBillingYear), le.CF1_TaxBillingYear, ri.CF1_TaxBillingYear);
		SELF.homesteadexemption := IF(keepLeft(le.CF1_homesteadexemptionindicator, ri.CF1_homesteadexemptionindicator), le.homesteadexemption, ri.homesteadexemption);
		SELF.CF1_homesteadexemptionindicator := IF(keepLeft(le.CF1_homesteadexemptionindicator, ri.CF1_homesteadexemptionindicator), le.CF1_homesteadexemptionindicator, ri.CF1_homesteadexemptionindicator);
		SELF.taxamount := IF(keepLeft(le.CF1_taxamount, ri.CF1_taxamount), le.taxamount, ri.taxamount);
		SELF.CF1_taxamount := IF(keepLeft(le.CF1_taxamount, ri.CF1_taxamount), le.CF1_taxamount, ri.CF1_taxamount);
		SELF.percentimproved := IF(keepLeft(le.CF1_percentimproved, ri.CF1_percentimproved), le.percentimproved, ri.percentimproved);
		SELF.CF1_percentimproved := IF(keepLeft(le.CF1_percentimproved, ri.CF1_percentimproved), le.CF1_percentimproved, ri.CF1_percentimproved);
		SELF.assessmentdocumentnumber := IF(keepLeft(le.CF1_assessmentdocumentnumber, ri.CF1_assessmentdocumentnumber), le.assessmentdocumentnumber, ri.assessmentdocumentnumber);
		SELF.CF1_assessmentdocumentnumber := IF(keepLeft(le.CF1_assessmentdocumentnumber, ri.CF1_assessmentdocumentnumber), le.CF1_assessmentdocumentnumber, ri.CF1_assessmentdocumentnumber);
		SELF.assessmentrecordingdate := IF(keepLeft(le.CF1_assessmentrecordingdate, ri.CF1_assessmentrecordingdate), le.assessmentrecordingdate, ri.assessmentrecordingdate);
		SELF.CF1_assessmentrecordingdate := IF(keepLeft(le.CF1_assessmentrecordingdate, ri.CF1_assessmentrecordingdate), le.CF1_assessmentrecordingdate, ri.CF1_assessmentrecordingdate);
		
		
		SELF := le;
		SELF := [];
	END;
	
	bestPropertyData := ROLLUP(Property_transposed, LEFT.acctno = RIGHT.acctno, rollup_property(LEFT, RIGHT));														
/* ************************************************************
	 *      Flatten the Property Information for Return:        *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics_batch.PropertyCharacteristics_batch flattenProperty(Address_Shell.layouts.PC_Soap_out_slim le) := TRANSFORM

		SELF.Input.seq     := le.acctno;
		/*****************************************
		 *         Address Information           *
		 *****************************************/
		SELF.PropertyCharacteristics.Address.Street_Number := le.StreetNumber;
		SELF.PropertyCharacteristics.Address.Street_Pre_Direction := le.StreetPreDirection;
		SELF.PropertyCharacteristics.Address.Street_Name := le.StreetName;
		SELF.PropertyCharacteristics.Address.Street_Suffix := le.StreetSuffix;
		SELF.PropertyCharacteristics.Address.Street_Post_Direction := le.StreetPostDirection;
		SELF.PropertyCharacteristics.Address.Unit_Designation := le.UnitDesignation;
		SELF.PropertyCharacteristics.Address.Unit_Number := le.UnitNumber;
		SELF.PropertyCharacteristics.Address.Street_Address_1 := le.StreetAddress1;
		SELF.PropertyCharacteristics.Address.Street_Address_2 := le.StreetAddress2;
		SELF.PropertyCharacteristics.Address.City := le.City;
		SELF.PropertyCharacteristics.Address.State := le.State;
		SELF.PropertyCharacteristics.Address.Zip_5 := le.Zip5;
		SELF.PropertyCharacteristics.Address.Zip_4 := le.Zip4;
		SELF.PropertyCharacteristics.Address.County := le.County;
		SELF.PropertyCharacteristics.Address.Postal_Code := le.PostalCode;
		SELF.PropertyCharacteristics.Address.State_City_Zip := le.StateCityZip;
		SELF.PropertyCharacteristics.Address.Census_Tract := le.CensusTract;

		/*****************************************
		 *       Attributes Information          *
		 *****************************************/
		SELF.PropertyCharacteristics.Attributes.Living_Area_SF := le.livingareasf;
		SELF.PropertyCharacteristics.Attributes.Living_Area_SF_ConfidenceFactor := le.CF1_LivingAreaSquareFootage;
		SELF.PropertyCharacteristics.Attributes.Stories := le.stories;
		SELF.PropertyCharacteristics.Attributes.Stories_ConfidenceFactor := le.CF1_numberofstories;
		SELF.PropertyCharacteristics.Attributes.Bedrooms := le.bedrooms;
		SELF.PropertyCharacteristics.Attributes.Bedrooms_ConfidenceFactor := le.CF1_numberofbedrooms;
		SELF.PropertyCharacteristics.Attributes.Baths := le.baths;
		SELF.PropertyCharacteristics.Attributes.Baths_ConfidenceFactor := le.CF1_numberofbaths;
		SELF.PropertyCharacteristics.Attributes.Fireplaces := le.fireplaces;
		SELF.PropertyCharacteristics.Attributes.Fireplaces_ConfidenceFactor := le.CF1_numberoffireplaces;
		SELF.PropertyCharacteristics.Attributes.Pool := le.pool;
		SELF.PropertyCharacteristics.Attributes.Pool_ConfidenceFactor := le.CF1_poolindicator;
		SELF.PropertyCharacteristics.Attributes.AC := le.ac;
		SELF.PropertyCharacteristics.Attributes.AC_ConfidenceFactor := le.CF1_airconditioningtypecode;
		SELF.PropertyCharacteristics.Attributes.Year_Built := (string8)le.yearbuilt;
		SELF.PropertyCharacteristics.Attributes.Year_Built_ConfidenceFactor := le.CF1_yearbuilt;
		// SELF.PropertyCharacteristics.Attributes.Slope := propData.PropertyAttributes.Slope;
		// SELF.PropertyCharacteristics.Attributes.Slope_ConfidenceFactor := propData.PropertyAttributes.Slope;
		SELF.PropertyCharacteristics.Attributes.Quality_Of_Struct := le.qualityofstruct;
		SELF.PropertyCharacteristics.Attributes.Quality_Of_Struct_ConfidenceFactor := le.CF1_qualityofstructurecode;
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Replacement_Cost_Report_Id_ConfidenceFactor := propData.PropertyAttributes.ReplacementCostReportId;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		// SELF.PropertyCharacteristics.Attributes.Policy_Coverage_Value_ConfidenceFactor := (STRING)propData.PropertyAttributes.PolicyCoverageValue;
		SELF.PropertyCharacteristics.Attributes.Fireplace_Indicator := le.fireplaceindicator;
		SELF.PropertyCharacteristics.Attributes.Fireplace_Indicator_ConfidenceFactor := le.CF1_fireplaceindicator;
		SELF.PropertyCharacteristics.Attributes.Units := (STRING) le.units;
		SELF.PropertyCharacteristics.Attributes.Units_ConfidenceFactor := le.CF1_numberofunits;
		SELF.PropertyCharacteristics.Attributes.Rooms := (STRING)le.rooms;
		SELF.PropertyCharacteristics.Attributes.Rooms_ConfidenceFactor := le.CF1_numberofrooms;
		SELF.PropertyCharacteristics.Attributes.Full_Baths := (STRING)le.fullbaths;
		SELF.PropertyCharacteristics.Attributes.Full_Baths_ConfidenceFactor := le.CF1_numberoffullbaths;
		SELF.PropertyCharacteristics.Attributes.Half_Baths := (STRING)le.halfbaths;
		SELF.PropertyCharacteristics.Attributes.Half_Baths_ConfidenceFactor := le.CF1_numberofhalfbaths;
		SELF.PropertyCharacteristics.Attributes.Bath_Fixtures := (STRING) le.bathfixtures;
		SELF.PropertyCharacteristics.Attributes.Bath_Fixtures_ConfidenceFactor :=  le.CF1_numberofbathfixtures;
		SELF.PropertyCharacteristics.Attributes.Effective_Year_Built := (STRING)le.effectiveyearbuilt;
		SELF.PropertyCharacteristics.Attributes.Effective_Year_Built_ConfidenceFactor := le.CF1_effectiveyearbuilt;
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure := propData.PropertyAttributes.ConditionOfStructure;
		// SELF.PropertyCharacteristics.Attributes.Condition_Of_Structure_ConfidenceFactor := propData.PropertyAttributes.ConditionOfStructure;
		SELF.PropertyCharacteristics.Attributes.Building_Area_SF := (STRING)le.buildingareasf;
		SELF.PropertyCharacteristics.Attributes.Building_Area_SF_ConfidenceFactor :=  le.CF1_buildingsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Ground_Floor_Area_SF := (STRING)le.groundfloorareasf;
		SELF.PropertyCharacteristics.Attributes.Ground_Floor_Area_SF_ConfidenceFactor := le.CF1_groundfloorsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Basement_Area_SF := (STRING)le.basementareasf;
		SELF.PropertyCharacteristics.Attributes.Basement_Area_SF_ConfidenceFactor := le.CF1_basementsquarefootage;
		SELF.PropertyCharacteristics.Attributes.Garage_Area_SF := (STRING)le.garageareasf;
		SELF.PropertyCharacteristics.Attributes.Garage_Area_SF_ConfidenceFactor := le.CF1_garagesquarefootage;
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence := propData.PropertyAttributes.TypeOfResidence;
		// SELF.PropertyCharacteristics.Attributes.Type_Of_Residence_ConfidenceFactor := propData.PropertyAttributes.TypeOfResidence;
		SELF.PropertyCharacteristics.Attributes.Flood_Zone_Panel_Number := le.floodzonepanelnumber;
		SELF.PropertyCharacteristics.Attributes.Flood_Zone_Panel_Number_ConfidenceFactor := le.CF1_floodzonepanelnumber;
		SELF.PropertyCharacteristics.Attributes.Stories_Type := le.storiestype;
		SELF.PropertyCharacteristics.Attributes.Stories_Type_ConfidenceFactor := le.CF1_storiestype;
		
		/*****************************************
		 *     Characteristics Information       *
		 *****************************************/
    cat001 := le.PropertyCharacteristics (category = '001')[1];
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material := cat001.Material;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_ConfidenceFactor := le.CF1_airconditioningtypecode;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_Desc := cat001.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Air_Conditioning_Material_Desc_ConfidenceFactor := le.CF1_airconditioningtypecode;
		
		// Place holder - not currently populating
		cat002 := le.PropertyCharacteristics (category = '002')[1];
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material := cat002.Material;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_Desc := cat002.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Walls_and_Ceilings_Material_Desc_ConfidenceFactor := 0;
		
    cat003 := le.PropertyCharacteristics (category = '003')[1];
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material := cat003.Material;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_ConfidenceFactor := le.CF1_floortype;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_Desc := cat003.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Flooring_Material_Desc_ConfidenceFactor := le.CF1_floortype;
		
		// Place holder - not currently populating
		cat004 :=le.PropertyCharacteristics (category = '004')[1];
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material := cat004.Material;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_Desc := cat004.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Appliances_Material_Desc_ConfidenceFactor := 0;
		
    cat005 :=le.PropertyCharacteristics (category = '005')[1];
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material := cat005.Material;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_ConfidenceFactor := le.CF1_exteriorwalltype;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_Desc := cat005.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Exterior_Wall_Material_Desc_ConfidenceFactor := le.CF1_exteriorwalltype;
		
    cat006 :=le.PropertyCharacteristics (category = '006')[1]; 
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material := cat006.Material;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_ConfidenceFactor := le.CF1_roofcovertype;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_Desc := cat006.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Roofing_Material_Desc_ConfidenceFactor := le.CF1_roofcovertype;
		
    cat007 :=le.PropertyCharacteristics (category = '007')[1]; 
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material := cat007.Material;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_ConfidenceFactor := le.CF1_foundationtype;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_Desc := cat007.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Foundation_Material_Desc_ConfidenceFactor := le.CF1_foundationtype;
		
    cat008 :=le.PropertyCharacteristics (category = '008')[1]; 
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material := cat008.Material;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_ConfidenceFactor := le.CF1_fireplacetype;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_Desc := cat008.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Fireplace_Material_Desc_ConfidenceFactor := le.CF1_fireplacetype;
		
		// Place holder - not currently populating
		cat009 := le.PropertyCharacteristics (category = '009')[1];
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material := cat009.Material;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_Desc := cat009.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Balcony_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat010 := le.PropertyCharacteristics (category = '010')[1];
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material := cat010.Material;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_Desc := cat010.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Decks_and_Patios_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat011 := le.PropertyCharacteristics (category = '011')[1];
		SELF.PropertyCharacteristics.Characteristics.Porch_Material := cat011.Material;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_Desc := cat011.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Porch_Material_Desc_ConfidenceFactor := 0;
		
		cat012 := le.PropertyCharacteristics (category = '012')[1];
		SELF.PropertyCharacteristics.Characteristics.Parking_Material := cat012.Material;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_ConfidenceFactor := le.CF1_parkingtype;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_Desc := cat012.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Parking_Material_Desc_ConfidenceFactor := le.CF1_parkingtype;
		
		cat013 := le.PropertyCharacteristics (category = '013')[1];
		SELF.PropertyCharacteristics.Characteristics.Basement_Material := cat013.Material;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_ConfidenceFactor := le.CF1_basementfinishtype;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_Desc := cat013.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Basement_Material_Desc_ConfidenceFactor := le.CF1_basementfinishtype;
		
		// Place holder - not currently populating
		cat014 := le.PropertyCharacteristics (category = '014')[1];
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material := cat014.Material;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_Desc := cat014.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Kitchen_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat015 := le.PropertyCharacteristics (category = '015')[1];
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material := cat015.Material;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_Desc := cat015.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Bathroom_Material_Desc_ConfidenceFactor := 0;
		
		cat016 := le.PropertyCharacteristics (category = '016')[1];
		SELF.PropertyCharacteristics.Characteristics.Water_Material := cat016.Material;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_ConfidenceFactor := le.CF1_watertype;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_Desc := cat016.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Water_Material_Desc_ConfidenceFactor := le.CF1_watertype;
		
		// Place holder - not currently populating
		cat017 := le.PropertyCharacteristics (category = '017')[1];
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material := cat017.Material;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_Desc := cat017.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Basecost_Material_Desc_ConfidenceFactor := 0;
		
		// Place holder - not currently populating
		cat018 := le.PropertyCharacteristics (category = '018')[1];
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material := cat018.Material;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_Desc := cat018.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Plumbing_Material_Desc_ConfidenceFactor := 0;
		
		cat019 := le.PropertyCharacteristics (category = '019')[1];
		SELF.PropertyCharacteristics.Characteristics.Style_Material := cat019.Material;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_ConfidenceFactor := le.CF1_styletype;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_Desc := cat019.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Style_Material_Desc_ConfidenceFactor := le.CF1_styletype;
		
		cat020 := le.PropertyCharacteristics (category = '020')[1];
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material := cat020.Material;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_ConfidenceFactor := le.CF1_fueltype;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_Desc := cat020.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Fuel_Material_Desc_ConfidenceFactor := le.CF1_fueltype;
		
		cat021 := le.PropertyCharacteristics (category = '021')[1];
		SELF.PropertyCharacteristics.Characteristics.Garage_Material := cat021.Material;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_ConfidenceFactor := le.CF1_garagecarporttype;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_Desc := cat021.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Garage_Material_Desc_ConfidenceFactor := le.CF1_garagecarporttype;
		
		cat022 := le.PropertyCharacteristics (category = '022')[1];
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material := cat022.Material;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_ConfidenceFactor := le.CF1_constructiontype;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_Desc := cat022.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Construction_Type_Material_Desc_ConfidenceFactor := le.CF1_constructiontype;

		// There is no category 023...
		
		cat024 := le.PropertyCharacteristics (category = '024')[1];
		SELF.PropertyCharacteristics.Characteristics.Heating_Material := cat024.Material;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_ConfidenceFactor := le.CF1_heatingtype;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_Desc := cat024.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Heating_Material_Desc_ConfidenceFactor := le.CF1_heatingtype;
		
		cat025 := le.PropertyCharacteristics (category = '025')[1];
		SELF.PropertyCharacteristics.Characteristics.Frame_Material := cat025.Material;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_ConfidenceFactor := le.CF1_frametype;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_Desc := cat025.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Frame_Material_Desc_ConfidenceFactor := le.CF1_frametype;
		
		cat026 := le.PropertyCharacteristics (category = '026')[1];
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material := cat026.Material;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_ConfidenceFactor := le.CF1_sewertype;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_Desc := cat026.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Sewer_Material_Desc_ConfidenceFactor := le.CF1_sewertype;
		
		cat027 := le.PropertyCharacteristics (category = '027')[1];
		SELF.PropertyCharacteristics.Characteristics.Pool_Material := cat027.Material;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_ConfidenceFactor :=le.CF1_pooltype;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_Desc := cat027.MaterialDesc;
		SELF.PropertyCharacteristics.Characteristics.Pool_Material_Desc_ConfidenceFactor := le.CF1_pooltype;
		
		/*****************************************
		 *         Mortgages Information         *
		 *****************************************/
		leMortgage := le.Mortgages[1];
		
		mortgagecompanyname := leMortgage.mortgagecompanyname;
		mortgagetype := IF(le.DataSource <> '', leMortgage.mortgagetype, 0); // mortgagetype always returns 1 in PC batch service. 
																																				 // check that we are actually hitting data to match XML Address Shell.
		mortgagetypedesc := leMortgage.mortgagetypedesc;
		loanamount := leMortgage.loanamount;
		loantypecode :=  leMortgage.loantypecode;
		loantype := leMortgage.loantype;
		interestrate := leMortgage.interestrate;
		interestratetypecode := leMortgage.interestratetypecode;
		
		mortgage_confidencefactor :=le.CF2_mortgagecompanyname;
		loanamount_confidencefactor := le.CF2_loanamount;
		loantype_confidencefactor := le.CF2_loantypecode;
		interestrate_confidencefactor := le.CF2_interestratetypecode;	
		
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Company_Name := mortgagecompanyname;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Company_Name_ConfidenceFactor := mortgage_confidencefactor;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type := (STRING)mortgagetype;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_ConfidenceFactor := mortgage_confidencefactor; // The Mortgage_Company_Name, Mortgage_Type, and Mortgage_Type_Desc all use the same record, so just use the MortgageCompanyName Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_Desc := mortgagetypedesc;
		SELF.PropertyCharacteristics.Mortgages.Mortgage_Type_Desc_ConfidenceFactor := mortgage_confidencefactor; // The Mortgage_Company_Name, Mortgage_Type, and Mortgage_Type_Desc all use the same record, so just use the MortgageCompanyName Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Loan_Amount := (STRING)loanamount;
		SELF.PropertyCharacteristics.Mortgages.Loan_Amount_ConfidenceFactor :=loanamount_confidencefactor;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_Code := loantypecode;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_Code_ConfidenceFactor := loantype_confidencefactor; // Loan_Type_Code and Loan_Type use the same record, so just use the LoanTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Loan_Type := LoanType;
		SELF.PropertyCharacteristics.Mortgages.Loan_Type_ConfidenceFactor := loantype_confidencefactor; // Loan_Type_Code and Loan_Type use the same record, so just use the LoanTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Mortgages.Interest_Rate := (STRING)interestrate;
		SELF.PropertyCharacteristics.Mortgages.Interest_Rate_ConfidenceFactor := interestrate_confidencefactor;
		
		/*****************************************
		 *          Sales Information            *
		 *****************************************/
		// formatDate (STRING Year, STRING Month, STRING Day) := IF(LENGTH(TRIM(Year)) = 4, Year, '') + IF(LENGTH(TRIM(Month)) = 2, Month, IF(LENGTH(TRIM(Month)) = 1, '0' + Month, '')) + IF(LENGTH(TRIM(Day)) = 2, Day, IF(LENGTH(TRIM(Day)) = 1, '0' + Day, ''));
		// deedDate := formatDate((STRING)propData.PropertySales.DeedRecordingDate.Year, (STRING)propData.PropertySales.DeedRecordingDate.Month, (STRING)propData.PropertySales.DeedRecordingDate.Day);
		SELF.PropertyCharacteristics.Sales.Deed_Recording_Date := le.deedrecordingdate;
		SELF.PropertyCharacteristics.Sales.Deed_Recording_Date_ConfidenceFactor := le.CF2_deedrecordingdate;
		// salesDate := formatDate((STRING)propData.PropertySales.SalesDate.Year, (STRING)propData.PropertySales.SalesDate.Month, (STRING)propData.PropertySales.SalesDate.Day);
		SELF.PropertyCharacteristics.Sales.Sales_Date := le.salesdate;
		SELF.PropertyCharacteristics.Sales.Sales_Date_ConfidenceFactor := le.CF2_salesdate;
		SELF.PropertyCharacteristics.Sales.Deed_Document_Number := le.deeddocumentnumber;
		SELF.PropertyCharacteristics.Sales.Deed_Document_Number_ConfidenceFactor := le.CF2_deeddocumentnumber;
		SELF.PropertyCharacteristics.Sales.Sales_Amount := (STRING)le.salesamount;
		SELF.PropertyCharacteristics.Sales.Sales_Amount_ConfidenceFactor := le.CF2_salesamount;
		SELF.PropertyCharacteristics.Sales.Sales_Type := le.salestype;
		SELF.PropertyCharacteristics.Sales.Sales_Type_ConfidenceFactor := le.CF2_salestypecode;

		/*****************************************
		 *          Taxes Information            *
		 *****************************************/
		SELF.PropertyCharacteristics.Taxes.Land_Use_Code := le.landusecode;
		SELF.PropertyCharacteristics.Taxes.Land_Use_Code_ConfidenceFactor := le.CF1_landusecode; // Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Land_Use := le.landuse;
		SELF.PropertyCharacteristics.Taxes.Land_Use_ConfidenceFactor := le.CF1_landusecode;// Land_Use_Code and Land_Use use the same record, so just use the LandUseCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Property_Type_Code := le.propertytypecode;
		SELF.PropertyCharacteristics.Taxes.Property_Type_Code_ConfidenceFactor := le.CF1_propertytypecode; // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Property_Type := le.propertytype;
		SELF.PropertyCharacteristics.Taxes.Property_Type_ConfidenceFactor := le.CF1_propertytypecode; // Property_Type_Code and Property_Type use the same record, so just use the PropertyTypeCode Confidence Factor
		SELF.PropertyCharacteristics.Taxes.Lot_Size := le.lotsize;
		SELF.PropertyCharacteristics.Taxes.Lot_Size_ConfidenceFactor := le.CF1_lotsize;
		SELF.PropertyCharacteristics.Taxes.Lot_Front_Footage := le.lotfrontfootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Front_Footage_ConfidenceFactor := le.CF1_lotfrontfootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Depth_Footage := le.lotdepthfootage;
		SELF.PropertyCharacteristics.Taxes.Lot_Depth_Footage_ConfidenceFactor := le.CF1_lotdepthfootage;
		SELF.PropertyCharacteristics.Taxes.Acres := le.acres;
		SELF.PropertyCharacteristics.Taxes.Acres_ConfidenceFactor := le.CF1_acres;
		SELF.PropertyCharacteristics.Taxes.Total_Assessed_Value := (STRING)le.totalassessedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Assessed_Value_ConfidenceFactor := le.CF1_totalassessedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Calculated_Value := (STRING)le.totalcalculatedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Calculated_Value_ConfidenceFactor := le.CF1_totalcalculatedvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Market_Value := (STRING)le.totalmarketvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Market_Value_ConfidenceFactor := le.CF1_totalmarketvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Land_Value := (STRING)le.totallandvalue;
		SELF.PropertyCharacteristics.Taxes.Total_Land_Value_ConfidenceFactor := le.CF1_totallandvalue;
		SELF.PropertyCharacteristics.Taxes.Market_Land_Value := (STRING)le.marketlandvalue;
		SELF.PropertyCharacteristics.Taxes.Market_Land_Value_ConfidenceFactor := le.CF1_marketlandvalue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Land_Value := (STRING)le.assessedlandvalue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Land_Value_ConfidenceFactor := le.CF1_assessedlandvalue;
		SELF.PropertyCharacteristics.Taxes.Improvement_Value := (STRING)le.improvementvalue;
		SELF.PropertyCharacteristics.Taxes.Improvement_Value_ConfidenceFactor := le.CF1_improvementvalue;
		SELF.PropertyCharacteristics.Taxes.Assessed_Year := (STRING)le.assessedyear;
		SELF.PropertyCharacteristics.Taxes.Assessed_Year_ConfidenceFactor := le.CF1_assessedyear;
		SELF.PropertyCharacteristics.Taxes.Tax_Code_Area := le.TaxCodeArea;
		SELF.PropertyCharacteristics.Taxes.Tax_Code_Area_ConfidenceFactor := 0;
		SELF.PropertyCharacteristics.Taxes.Tax_Billing_Year := (STRING)le.TaxBillingYear;
		SELF.PropertyCharacteristics.Taxes.Tax_Billing_Year_ConfidenceFactor := le.CF1_taxbillingyear;
		SELF.PropertyCharacteristics.Taxes.Home_Stead_Exemption := le.HomeSteadExemption;
		SELF.PropertyCharacteristics.Taxes.Home_Stead_Exemption_ConfidenceFactor := le.CF1_homesteadexemptionindicator;
		SELF.PropertyCharacteristics.Taxes.Tax_Amount := (STRING)le.TaxAmount;
		SELF.PropertyCharacteristics.Taxes.Tax_Amount_ConfidenceFactor := le.CF1_taxamount;
		SELF.PropertyCharacteristics.Taxes.Percent_Improved := (STRING)le.PercentImproved;
		SELF.PropertyCharacteristics.Taxes.Percent_Improved_ConfidenceFactor := le.CF1_percentimproved;
		SELF.PropertyCharacteristics.Taxes.Assessment_Recording_Date := le.AssessmentRecordingDate;
		SELF.PropertyCharacteristics.Taxes.Assessment_Recording_Date_ConfidenceFactor := le.CF1_assessmentrecordingdate;
		// SELF.PropertyCharacteristics.Taxes.Assessment_document_number := le.assessmentdocumentnumber;
		// SELF.PropertyCharacteristics.Taxes.Assessment_document_number_ConfidenceFactor := le.CF1_assessmentdocumentnumber;
		
		
		SELF := [];
	END;

	flatProperty := PROJECT(bestPropertyData, flattenProperty(LEFT));
	
	Address_Shell.layoutPropertyCharacteristics_batch.PropertyCharacteristics_batch intoFinal(Address_Shell.Layouts.address_shell_input le, Address_Shell.layoutPropertyCharacteristics_batch.PropertyCharacteristics_batch ri) := TRANSFORM
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
		
	finalJoin := JOIN(input, flatProperty, LEFT.Seq = RIGHT.Input.Seq,
														intoFinal(LEFT, RIGHT), LEFT OUTER, KEEP(1), LIMIT(1000));
	
	final := IF(propertyInformationAttributesVersion > 0 , finalJoin, justInput);
	
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