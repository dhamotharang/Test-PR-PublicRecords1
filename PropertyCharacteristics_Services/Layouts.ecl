import	iesp,PropertyCharacteristics, doxie, address;  

export	Layouts	:=
module

	// Input intermediate log layout
	export	Input	:=
	record
		string1		ReportType;
		string20	FirstName;
		string20	MiddleName;
		string20	LastName;
		string100	StreetAddress;
		string25	City;
		string2		State;
		string5		Zip;
		string10	CensusTract;
		string20	PolicyNumber;
		string60	Quoteback;
		string8		LivingAreaSF;
		string5		Stories;
		string5		Bedrooms;
		string8		Baths;
		string3		Fireplaces;
		string1		Pool;
		string1		AC;
		string4		YearBuilt;
		string1		Slope;
		string3		QualityOfStruct;
		string25	ReplacementCostReportId;
		string12	PolicyCoverageValue;
		dataset(iesp.property_info.t_PropertyCharacteristic)	Property_Characteristics	{maxcount(85)};
		dataset(iesp.property_info.t_PropertyDescription)			Property_Description			{maxcount(250)};
	end;
	
	// Transaction log layout
	export	TransactionLog	:=
	record
		string20		transaction_id;							//No PK of the entry. Generate by Roxie
		integer			product_id;									//Insurance	product id of the entry.
		string10		date_added;									//Date the record was added
		string60		login_id;										//Log-in id of the user executing the search. Not applicable to current insurance products
		string60		billing_code;								//Billing code of the transaciton. Not applicable to current insurance products. For migrated products it would be special billing id
		string30		function_name;							//Type of transaction/search that is being executed. Equivalent for the current insurance products as "report_service_type"
		string4			report_code;								//Denotes the reporting code to be used for billing
		string8			account_base;								//account number of the one that is running the search
		string3			account_suffix;							//account suffix of the one running the search
		integer			account_id;									//account id of the transaction that executes this search
		integer			customer_number;						//customer number associated to the account
		string60		customer_reference_code;		//Pass through value by the customer to ID the transaction. In the current insurance world referred as "full quote back" and in accurint "reference number"
		string10		i_date_ordered;							//Represents the date the record was ordered
		string9			i_person_ssn;								//SSN for the person being inquiried
		string5			i_person_name_prefix;				//Prefix name provided
		string20		i_person_last_name;					//Last name, input in search
		string20		i_person_first_name;				//First name input in search
		string20		i_person_middle_name;				//Middle name input at the time of search
		string5			i_person_name_suffix;				//Suffix name provided
		string8			i_person_dob;								//D.O.B of the subject
		integer2		count_person_in := 0;				//How many subjects are in the search
		string15		i_dl1_number;								//First DL value being passed
		string2			i_dl1_state;								//DL state of the first DL passed in "first_i_dl_number"
		integer			i_dl1_type;									//Type of DL . 1= "Current", 2= "Prior"
		integer2		count_dl_in := 0;						//How many DL are in the search
		string90		i_addr_line;								//Line address being passed
		integer1		i_addr_street_type;					//Street type
		string2			i_addr_state;								//State of the address being passed
		string10		i_addr_zip;									//ZIP of the address passed
		string50		i_addr_city;								//Yes City of the address passed
		string50		i_addr_county;							//Yes County of the address passed
		string3			i_addr_country	:=	'USA';	//USA 3 letter ISO code of the country of the address parsed
		integer2		i_addr_type;								//Address type of the entry passed here
		integer2		count_addr_in;							//Number of addresses in the inquiry
		string20		i_vehicle_vin;							//Optional parameter for VIN standard 
		integer			i_vehicle_year;							//Required for Vin Standard, Vin Services
		string30		i_vehicle_make;							//Required for Vin Standard, Vin Services
		string30		i_vehicle_model;						//Required for Vin Standard, Vin Services + searches
		string10		i_vehicle_plate_data;				//Required for Vin Standard, Vin Services + searches
		string2			i_vehicle_state;						//Required for some VIN searches
		integer1		count_vehicle_in := 0;			//How many vehicles were passed in the request
		string32		i_unique_id;								//Unique ID provided for the specific transaction if applies and it's not within the existing set of defined ones (vin, dl, ssn). For example, report #
		integer1		i_unique_id_type;						//What type of unique id is it? . (Other than VIN, DL, SSN)
		decimal4_1	record_version;							//Version of the record, i.e EDITS version 1,2 etc or XML version if needs to be supported
		string20		reference_number;						//Value assigned right now by the product people, based on timestamp
		string3			processing_status	:=	'R';	//Processing status of the order
		integer1		billing_type_id := 0;				//Indicates the type of billing id. For now it won't be populated but once there is a Pricer it will be set up by this application. 0 = Undefined, 2 = Detail, 6= Bulk
		decimal18_9	price	:=	-1.000000000;			//Price of the transaction. Having the price in the accounting_log easily helps reporting tieing a type of transaction with the price
		integer1		currency := 0;							//Indicates the type of currency. 0=unknown, 1= U.S Dollar,etc
		integer			pricing_error_code := 0;		//To be set by the pricing application. Indicates default pricing status after pricer process the record
		integer1		free := 0;									//Tells whether the record is for free and the reason, i.e free = 1 Free Trial, free 2= Exempt Company, free = 3 Next Page search, free = 4/6 , marked as Freebee
		integer			record_count_1;							//Results returned from the search for one type
		integer1		record_count_1_type;				//What type of record count 1 refers to?. i.e 1 = "VINS developed", "VINS matched",etc
		integer			record_count_2;							//Results returned from the search for one type
		integer1		record_count_2_type;				//What type of record count 2 is?. i.e 1 = "VINS developed", "VINS matched",etc
		integer1		result_format;							//Denotes the type of format . 0 = undefined, 1 = EDITS, 2= XML.
		string10		report_options;							//Register the options for each possible search if applies. Can be similar to what we use in Accurint accounting_log but even expand the use if necessary, and as opposed to use boolean 1/0 for each position, can have different values
		integer			transaction_code;						//This would be used for billing and potentially for rollup
		string9			return_node_id;							//Where the search is run from
		string9			request_node_id;						//Where the search comes from
		integer			order_status_code;					//Order status code
		string3			product_line;								//Might be deprecated if found out that report_service_type can be unique by itself
		unsigned		login_history_id;						//Optional. Possibly NULL in this case for non WEB transactions
		string20		ip_address;									//IP where the request was made for the search
		decimal8_4	response_time;							//Response time taken to fullfil the request, from request to result
		string40		esp_method;									//ESP method tied to this transaction id
		string60		user_added	:=	'esp';			//esp User that added the record
		string60		user_changed;								//User that made a change on the record
		string10		date_changed;								//Date the record was changed
		string3 		glba_code;  								//CR1381 - log glba = 1
  end;
	
	// Transaction layout for mbsi
	export	TransactionLogRec	:=
	record
		dataset(TransactionLog)	Rec	{xpath('Records/Rec'),maxcount(3)};
	end;
	
	// Transaction log extesnion layout
	export	TransactionLogExtension	:=
	record
		string20		transaction_id;							//No PK of the entry. Generate by Roxie
		string10		date_added;									//Date the record was added
		integer2 		sequence;
		integer5 		extension_type;
		string100 	value;
	end;
	
	// Transaction log extension layout for mbsi
	export	TransactionLogExtensionRec	:=
	record
		dataset(TransactionLogExtension)	Rec	{xpath('Records/Rec'),maxcount(3)};
	end;
	

	// PropertyCharacteristics payload base layout
	export	Payload	:= PropertyCharacteristics.Layouts.Base;

  // generally, just acctno and cleaned address
	export CleanAddressRec := record 
		doxie.layout_inBatchMaster.acctno; // for batch-style usage 
    Address.Layout_Clean182 and not [v_city_name,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,
                                     rec_type,county,geo_lat,geo_long,msa];
		boolean is_cleaned := false;
  end;

  // in-house data plus cleaned address, in case it is needed for gateway call
	export main	:= record
		doxie.layout_inBatchMaster.acctno; // for batch-style usage 
    // CleanAddressRec clean_address;
		Payload;
	end;

	// unique id
	export	SearchID	:=
	record
		doxie.layout_inBatchMaster.acctno;
		Payload.property_rid;
	end;
	
	// BOB layout
	export	BOB	:=
	record
		Payload;
		unsigned1	wghtLivingSqFt;
		unsigned1	wghtBldgSqFt;
		unsigned2	cntKeyFields;
		unsigned2	cntNonKeyFields;
	end;
	
	// slimmed mortgage
	export	SlimmedMortgage	:=
	record
		Payload.mortgage_company_name;
		Payload.loan_amount;
		Payload.second_loan_amount;
		Payload.loan_type_code;
		Payload.interest_rate_type_code;
	end;
	
	// slimmed property characteristics
	export	SlimmedPropChar	:=
	record
		Payload.air_conditioning_type;
		Payload.basement_finish;
		Payload.construction_type;
		Payload.exterior_wall;
		Payload.fireplace_type;
		Payload.garage;
		Payload.heating;
		Payload.parking_type;
		Payload.pool_type;
		Payload.roof_cover;
		Payload.roof_type;
		Payload.foundation;
		Payload.stories_type;
		Payload.floor_type;
		Payload.fuel_type;
		Payload.style_type;
		Payload.water;
		Payload.sewer;
		Payload.frame_type;
	end;

  export errors_rec := record
    unsigned8 internal_code := 0;
    iesp.property_info.t_PropertyNarrativeARecordReport;
  end;


// template to generate a flat input layout containing:
//  30 iesp.property_info.t_PropertyDescription and
//  10 iesp.property_info.t_PropertyDescription structures

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

	export batch_in := record
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
		// string3 Category_1;
		// string3  Material_1;
		// real8    Value_1;
		// string1  Quality_1;
		// string1  Condition_1;
		// unsigned Age_1;
		// etc.
    %fields_descriptions%
		// string50 Description_1 {xpath('Description')};
		// unsigned AdditionValue_1;
		// string1 AdditionQuality_1;
		// string1 AdditionCondition_1;
		// string1 LivingAreaIndicator_1; //values['U','Y','N','']
		// etc.
	end;

  // batch input, with request formatted as ESDL
	export batch_in_esdl := record
		string20 acctno;
		iesp.property_info.t_PropertyInformationRequest request; // customer request
  end;

	export batch_internal := record (batch_in_esdl)
    CleanAddressRec clean_address;
		Payload inhouse;
  end;

	// request to ERC gateway
	export batch_erc_ready := record
		string20 acctno;
    CleanAddressRec clean_address;
		BOB inhouse_best; // "best" of the in-house data
		iesp.property_info.t_PropertyInformationRequest request; // customer request
		unsigned general_err;
	end;

  // record to keep ERC results
	export batch_erc := record
		string20 acctno;
		unsigned general_err;
		unsigned erc_err;
    string32 erc_err_message;
		dataset (iesp.property_value_report.t_PropertyOut) ERC {maxcount(1)};
	end;

	// combined results; this is actually a ready-to-use batch output, not-formatted
	export batch_combined := record
		string20 acctno;
    CleanAddressRec clean_address;
		iesp.property_info.t_PropertyDataItem property; // esdl-style (so far)
		// dataset (iesp.property_value_report.t_PropertyOut) ERC {maxcount(1)};
		dataset (iesp.property_info.t_EstimatedReplacementCost) ERC {maxcount(1)};
		unsigned general_err;
		unsigned erc_err;
    string32 erc_err_message;
	end;

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
//not used:
	// string3 Category {xpath('Category')};
	// string3 Material {xpath('Material')};
	// real8 Value {xpath('Value')};
	// unsigned ErcValue {xpath('ErcValue')};

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

export flat_inhouse_rec := record
	string25 DataSource {xpath('DataSource')};
	iesp.property_info.t_PropertyAddressInfo;
	iesp.property_info.t_PropertyAttributesReport;
	//[dataset(t_PropertyCharacteristicRecordReport) PropertyCharacteristics {xpath('PropertyCharacteristics/PropertyCharacteristic'), MAXCOUNT(85)};]
  %output_characteristics%
	//[dataset(t_MortgageRecordReport) Mortgages {xpath('Mortgages/Mortgage'), MAXCOUNT(3)};]
  %output_mortgages%

	iesp.property_info.t_PropertyInfoSalesInfoRecordReport and not [DeedRecordingDate, SalesDate];
	string8 DeedRecordingDate;
	string8 SalesDate;
	iesp.property_info.t_PropertyTaxInfoRecordReport and not [County, AssessmentRecordingDate];
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
	unsigned CF1_RoofType;
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
//not used:
	// string3 Category {xpath('Category')};
	// string3 Material {xpath('Material')};
	// real8 Value {xpath('Value')};
	// unsigned ErcValue {xpath('ErcValue')};

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
//not used:
	// string2 Classification {xpath('Classification')};
	// string1 PropertyAdditionQuality {xpath('PropertyAdditionQuality')};
	// string64 PropertyAdditionQualityDesc {xpath('PropertyAdditionQualityDesc')};
	// string1 PropertyAdditionCondition {xpath('PropertyAdditionCondition')};
	// string64 PropertyAdditionConditionDesc {xpath('PropertyAdditionConditionDesc')};
	// string1 LivingAreaIndicator {xpath('LivingAreaIndicator')}; //values['U','Y','N','']
	// unsigned LowErcValue {xpath('LowErcValue')};
	// unsigned HighErcValue {xpath('HighErcValue')};

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
	export batch_out := record
		string20 acctno;
		flat_inhouse_rec;
		flat_erc_rec;
		boolean is_cleaned := false;
		unsigned general_err;
		unsigned erc_err;
		string32 erc_err_message;
	end;
	
	export inhouse_layout := RECORD
		string20 acctno;
	  Payload;
	END;


end;