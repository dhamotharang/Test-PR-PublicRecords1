IMPORT iesp;
EXPORT Layouts := MODULE

export batch_in := record
	STRING20 seq;
	STRING20 AcctNo;
	STRING60 StreetAddress1;
	STRING60 StreetAddress2;
	STRING25 City;
	STRING2 State;
	STRING5 Zip5;
END;

EXPORT address_shell_input := Record
	STRING20 seq := '';
	STRING2 GLBPurpose := '';
	STRING2 DPPAPurpose := '';
	STRING50 DataRestrictionMask := '';
	STRING20 AccountNumber := '';
	iesp.share.t_Address;
	STRING10 GeoLat := '';
	STRING11 GeoLong := '';
	STRING12 GeoLink := '';
	STRING4 Err_Stat := '';	
END;

LOADXML('<xml/>');
#DECLARE(fields_characteristics);
#SET(fields_characteristics, '');

#DECLARE(fields_descriptions);
#SET(fields_descriptions, '');

#DECLARE (i);

#SET (i, 1);
#LOOP
  #IF (%i% > 30)
    #BREAK
  #ELSE
    #APPEND (fields_characteristics, 
             'string3 Category_' + %'i'% + '; string3 Material_' + %'i'% + '; real8 Value_' + %'i'% + 
             '; string1 Quality_' + %'i'% + '; string1 Condition_' + %'i'% + '; unsigned Age_' + %'i'% + ';');
    #SET (i, %i% + 1);
  #END
#END

#SET (i, 1);
#LOOP
  #IF (%i% > 10)
    #BREAK
  #ELSE
    #APPEND (fields_descriptions, 
             'string50 Description_' + %'i'% + '; unsigned AdditionValue_' + %'i'% + '; string1 AdditionQuality_' + %'i'% + 
             '; string1 AdditionCondition_' + %'i'% + '; string1 LivingAreaIndicator_' + %'i'% + ';');
    #SET (i, %i% + 1);
  #END
#END

	export PC_batch_in := record
		string20 	acctno;

		//Address 
		string40 StreetAddress; // required
		string25 City; //required
		string2  State; //required
		string5  Zip5; //required
		string4  Zip4; // ignored
		string10 CensusTract; // ignored
		
		//Name 
		string20 First; // required for gateway
		string20 Middle;
		string20 Last; // required for gateway
		
		//Property Attributes		
		string10 LivingAreaSF;
		string5 Stories;
		string5 Bedrooms;
		string7 Baths;
		string5 Fireplaces;
		string1 Pool;
		string1 AC;
		unsigned YearBuilt;
		string1 SlopeCode;
		string64 Slope;
		string3 QualityOfStructCode;
		string64 QualityOfStruct;
		string25 ReplacementCostReportId;
		unsigned PolicyCoverageValue;
		%fields_characteristics%

    %fields_descriptions%

	end;
	EXPORT PC_Soap_In := Record
		Dataset(PC_batch_in) batch_in;
		String1 Product;
		String1 ReportType;
		boolean IsReseller;
		boolean IncludeConfidenceFactors;
		boolean	_Blind := FALSE;
	End;
	

// generates flat output for 85 characteristics
#DECLARE(output_characteristics);
#SET(output_characteristics, '');

#DECLARE(output_mortgages);
#SET(output_mortgages, '');

#DECLARE (k);
#SET (k, 1);
#LOOP
  #IF (%k% > 85)
    #BREAK
  #ELSE
    #APPEND (output_characteristics, 
             'string3 Category_'   + %'k'% + '; string64 CategoryDesc_' + %'k'% + 
             '; string3 Material_' + %'k'% + '; string64 MaterialDesc_' + %'k'% + 
             '; real8 Value_'      + %'k'% + '; unsigned ErcValue_'     + %'k'% + ';');
    #SET (k, %k% + 1);
  #END
#END

// ... 3 mortgages
#SET (k, 1);
#LOOP
  #IF (%k% > 3)
    #BREAK
  #ELSE
    #APPEND (output_mortgages, 
             'string50 MortgageCompanyName_' + %'k'% + '; unsigned MortgageType_' + %'k'% + '; string64 MortgageTypeDesc_' + %'k'% + 
             '; real8 LoanAmount_' + %'k'% + '; string5 LoanTypeCode_' + %'k'% + '; string64 LoanType_' + %'k'% + 
             '; real8 InterestRate_' + %'k'% + '; string4 InterestRateTypeCode_' + %'k'% + '; string64 InterestRateType_' + %'k'% + 
             '; string15 MortgageLoanNumber_' + %'k'% + '; string1 FsiMortgageLoanNumber_' + %'k'% + '; string1 FsiMortgageCompanyName_' + %'k'% + 
             '; string2 Classification_' + %'k'% + ';');
    #SET (k, %k% + 1);
  #END
#END

export flat_inhouse_rec_slim := record
	string1 DataSource;
	string10 StreetNumber;
	string2 StreetPreDirection;
	string28 StreetName;
	string4 StreetSuffix;
	string2 StreetPostDirection;
	string10 UnitDesignation;
	string8 UnitNumber;
	string60 StreetAddress1;
	string60 StreetAddress2;
	string25 City;
	string2 State;
	string5 Zip5;
	string4 Zip4;
	string18 County;
	string9 PostalCode;
	string50 StateCityZip;
	string10 CensusTract;
	string10 LivingAreaSF;
	string5 Stories;
	string5 Bedrooms;
	string7 Baths;
	string5 Fireplaces;
	string1 Pool; //values['U','Y','N','']
	string1 AC; //values['U','Y','N','']
	unsigned YearBuilt {xpath('YearBuilt')};
	string1 SlopeCode;
	string64 Slope;
	string3 QualityOfStructCode;
	string64 QualityOfStruct;
	string25 ReplacementCostReportId;
	unsigned PolicyCoverageValue {xpath('PolicyCoverageValue')};
	string1 FireplaceIndicator; //values['U','Y','N','']
	unsigned Units {xpath('Units')};
	unsigned Rooms {xpath('Rooms')};
	unsigned FullBaths {xpath('FullBaths')};
	unsigned HalfBaths {xpath('HalfBaths')};
	unsigned BathFixtures {xpath('BathFixtures')};
	unsigned EffectiveYearBuilt {xpath('EffectiveYearBuilt')};
	string3 ConditionOfStructureCode;
	string64 ConditionOfStructure;
	unsigned BuildingAreaSF {xpath('BuildingAreaSF')};
	unsigned GroundFloorAreaSF {xpath('GroundFloorAreaSF')};
	unsigned BasementAreaSF {xpath('BasementAreaSF')};
	unsigned GarageAreaSF {xpath('GarageAreaSF')};
	string100 TypeOfResidence;
	string11 FloodZonePanelNumber;
	string6 StoriesType;
	string2 Classification;
	string20 DeedDocumentNumber;
	real8 SalesAmount {xpath('SalesAmount')};
	string3 SalesTypeCode;
	string64 SalesType;
	string3 SalesFullPart;
	string8 DeedRecordingDate;
	string8 SalesDate;
	string100 LegalDesc;
	string20 ParcelNumber;
	string5 FipsCode;
	string80 ApnNumber;
	string7 BlockNumber;
	string10 LotNumber;
	string80 SubdivisionName ;
	string30 TownshipName;
	string80 MunicipalityName;
	string3 Range;
	string7 Section;
	string25 ZoningDesc;
	string3 LocationOfInfluenceCode;
	string64 LocationOfInfluence;
	string10 LandUseCode;
	string64 LandUse;
	string4 PropertyTypeCode;
	string64 PropertyType;
	string10 Latitude;
	string11 Longitude;
	string15 LotSize;
	string10 LotFrontFootage;
	string10 LotDepthFootage;
	string15 Acres;
	real8 TotalAssessedValue {xpath('TotalAssessedValue')};
	real8 TotalCalculatedValue {xpath('TotalCalculatedValue')};
	real8 TotalMarketValue {xpath('TotalMarketValue')};
	real8 TotalLandValue {xpath('TotalLandValue')};
	real8 MarketLandValue {xpath('MarketLandValue')};
	real8 AssessedLandValue {xpath('AssessedLandValue')};
	real8 ImprovementValue {xpath('ImprovementValue')};
	unsigned AssessedYear {xpath('AssessedYear')};
	string20 TaxCodeArea;
	unsigned TaxBillingYear {xpath('TaxBillingYear')};
	string1 HomeSteadExemption; //values['U','Y','N','']
	real8 TaxAmount {xpath('TaxAmount')};
	real8 PercentImproved {xpath('PercentImproved')};
	string20 AssessmentDocumentNumber;
	string8 AssessmentRecordingDate;
  string80 Tax_County;

	// iesp.property_info.t_ConfidenceFactor1;
	unsigned CF1_Acres;
	unsigned CF1_AirConditioningTypeCode;
	unsigned CF1_ApnNumber;
	unsigned CF1_AssessedLandValue;
	unsigned CF1_AssessedYear;
	unsigned CF1_AssessmentDocumentNumber;
	unsigned CF1_AssessmentRecordingDate;
	unsigned CF1_BasementFinishType;
	unsigned CF1_BasementSquareFootage;
	unsigned CF1_BlockNumber;
	unsigned CF1_BuildingSquareFootage;
	unsigned CF1_CensusTract;
	unsigned CF1_ConstructionType;
	unsigned CF1_County;
	unsigned CF1_EffectiveYearBuilt;
	unsigned CF1_ExteriorWallType;
	unsigned CF1_FipsCode;
	unsigned CF1_FireplaceIndicator;
	unsigned CF1_FireplaceType;
	unsigned CF1_FloodZonePanelNumber;
	unsigned CF1_FloorType;
	unsigned CF1_FoundationType;
	unsigned CF1_FrameType;
	unsigned CF1_FuelType;
	unsigned CF1_GarageCarportType;
	unsigned CF1_GarageSquareFootage;
	unsigned CF1_GroundFloorSquareFootage;
	unsigned CF1_HeatingType;
	unsigned CF1_HomesteadExemptionIndicator;
	unsigned CF1_ImprovementValue;
	unsigned CF1_LandUseCode;
	unsigned CF1_Latitude;
	unsigned CF1_LivingAreaSquareFootage;
	unsigned CF1_LocationOfInfluenceCode;
	unsigned CF1_Longitude;
	unsigned CF1_LotDepthFootage;
	unsigned CF1_LotFrontFootage;
	unsigned CF1_LotNumber;
	unsigned CF1_LotSize;
	unsigned CF1_MarketLandValue;
	unsigned CF1_MunicipalityName;
	unsigned CF1_NumberOfBathFixtures;
	unsigned CF1_NumberOfBaths;
	unsigned CF1_NumberOfBedrooms;
	unsigned CF1_NumberOfFireplaces;
	unsigned CF1_NumberOfFullBaths;
	unsigned CF1_NumberOfHalfBaths;
	unsigned CF1_NumberOfRooms;
	unsigned CF1_NumberOfStories;
	unsigned CF1_NumberOfUnits;
	unsigned CF1_ParkingType;
	unsigned CF1_PercentImproved;
	unsigned CF1_PoolIndicator;
	unsigned CF1_PoolType;
	unsigned CF1_PropertyTypeCode;
	unsigned CF1_QualityOfStructureCode;
	unsigned CF1_Range;
	unsigned CF1_RoofCoverType;
	unsigned CF1_SewerType;
	unsigned CF1_StoriesType;
	unsigned CF1_StyleType;
	unsigned CF1_SubdivisionName;
	unsigned CF1_TaxAmount;
	unsigned CF1_TaxBillingYear;
	unsigned CF1_TotalAssessedValue;
	unsigned CF1_TotalCalculatedValue;
	unsigned CF1_TotalLandValue;
	unsigned CF1_TotalMarketValue;
	unsigned CF1_TownshipName;
	unsigned CF1_WaterType;
	unsigned CF1_YearBuilt;
	unsigned CF1_ZoningDescription;
		
	//iesp.property_info.t_ConfidenceFactor2;
	unsigned CF2_DeedDocumentNumber;
	unsigned CF2_DeedRecordingDate;
	unsigned CF2_InterestRateTypeCode;
	unsigned CF2_LoanAmount;
	unsigned CF2_LoanTypeCode;
	unsigned CF2_MortgageCompanyName;
	unsigned CF2_SaleFullOrPart;
	unsigned CF2_SalesAmount;
	unsigned CF2_SalesDate;
	unsigned CF2_SalesTypeCode;
	unsigned CF2_SecondLoanAmount;
end;
export flat_inhouse_rec := record
  flat_inhouse_rec_slim;
  %output_characteristics%
  %output_mortgages%
End;	

export PropertyCharacteristicRecordReport := record
	string3 Category;
	string64 CategoryDesc;
	string3 Material;
	string64 MaterialDesc;
	real8 Value ;
end;	

export MortgageRecordReport := record
	string50 MortgageCompanyName;
	unsigned MortgageType;
	string64 MortgageTypeDesc;
	real8 LoanAmount;
	string5 LoanTypeCode;
	string64 LoanType;
	real8 InterestRate;
	string4 InterestRateTypeCode;
	string64 InterestRateType;
	string15 MortgageLoanNumber;
	string1 FsiMortgageLoanNumber; //values['U','Y','N','']
	string1 FsiMortgageCompanyName; //values['U','Y','N','']
	string2 Classification;
end;
export transpose_inhouse_rec := record
  flat_inhouse_rec_slim;
	dataset(PropertyCharacteristicRecordReport) PropertyCharacteristics;
	dataset(MortgageRecordReport) Mortgages;
END;

#DECLARE(erc_output_characteristics);
#SET(erc_output_characteristics, '');

#DECLARE(erc_output_descriptions);
#SET(erc_output_descriptions, '');

#SET (k, 1);
#LOOP
  #IF (%k% > 85)
    #BREAK
  #ELSE
    #APPEND (erc_output_characteristics, 
             'string64 ERC_CategoryDesc_' + %'k'% + '; string64 ERC_MaterialDesc_' + %'k'% + '; real8 ERC_Value_' + %'k'% + 
             '; unsigned ERC_ErcValue_' + %'k'% + ';');
    #SET (k, %k% + 1);
  #END
#END

#SET (k, 1);
#LOOP
  #IF (%k% > 10)
    #BREAK
  #ELSE
    #APPEND (erc_output_descriptions, 
             'string50 ERC_PropertyDesc_' + %'k'% + '; unsigned ERC_PropertyAdditionValue_' + %'k'% + '; unsigned ERCDesc_Value_' + %'k'% + ';') 
    #SET (k, %k% + 1);
  #END
#END


export flat_erc_rec := record
	//iesp.property_info.t_CostSummaryRecordReport;
	unsigned InsuranceToValue;
	unsigned EstimatedReplacementCost;
	unsigned Profit;
	unsigned ArchitectAmount;
	string1 SalesTaxIncluded; //values['U','Y','N','']
	unsigned DebrisAmount;
	unsigned ActualCashValue;
	unsigned OverheadAmount;
	unsigned EstReplacementCostScore;
	unsigned ActualCashValueScore;

	//iesp.property_info.t_PropertyAttributesReport;
	string10 ERC_LivingAreaSF;
	string5 ERC_Stories;
	string5 ERC_Bedrooms;
	string7 ERC_Baths;
	string5 ERC_Fireplaces;
	string1 ERC_Pool; //values['U','Y','N','']
	string1 ERC_AC; //values['U','Y','N','']
	unsigned ERC_YearBuilt;
	string1 ERC_SlopeCode;
	string64 ERC_Slope;
	string3 ERC_QualityOfStructCode;
	string64 ERC_QualityOfStruct;
	string25 ERC_ReplacementCostReportId;
	unsigned ERC_PolicyCoverageValue;
	string1 ERC_FireplaceIndicator; //values['U','Y','N','']
	string100 ERC_TypeOfResidence;
	// dataset(t_PropertyCharacteristicRecordReport) PropertyCharacteristics {xpath('PropertyCharacteristics/PropertyCharacteristic'), MAXCOUNT(85)};
  %erc_output_characteristics%

	// dataset(t_PropertyDescriptionRecordPartReport) PropertyDescriptionRecordSet {xpath('PropertyDescriptionRecordSet/PropertyDescriptionRecordPart'), MAXCOUNT(250)};
  %erc_output_descriptions%
end;

  // formatted output
	export PC_Soap_out := record
		string20 acctno;
		flat_inhouse_rec;
		flat_erc_rec;
		boolean is_cleaned := false;
		unsigned general_err;
		unsigned erc_err;
		string32 erc_err_message;
	end;

	export PC_Soap_out_slim := record
		string20 acctno;
		flat_inhouse_rec_slim;
		dataset(PropertyCharacteristicRecordReport) PropertyCharacteristics;
		dataset(MortgageRecordReport) Mortgages;
		boolean is_cleaned := false;
		unsigned general_err;
		unsigned erc_err;
		string32 erc_err_message;
	end;	

END;
