/*
 * This is a flattened layout of the results from PropertyCharacteristics_Services.BatchService.
 * All fields of interest (And several that are not of interest) should be included here...
 */

IMPORT iesp, PropertyCharacteristics_Services, PropertyCharacteristics;

EXPORT layoutPropertyCharacteristics_batch := MODULE

EXPORT attributesVersion1 := RECORD
	STRING2 State := '';
	STRING1 Address_Vacancy_Indicator := '';
	STRING6 Mobility_Index := '';
	STRING6 Poverty_Index := '';
	STRING6 Risk_Index := '';
	STRING5 Low_Income := '';
	STRING8 Foreclosure_Recording_Date := '';
	STRING3 Foreclosure_Count := '';
	STRING15 Property_Owned_Assessed_Total := '';
	STRING15 Property_Owned_Purchase_Total := '';
	STRING15 Property_Purchase_Amount := '';
	STRING15 Property_Automated_Valuation := '';
	STRING15 Property_Tax_Assessment_Valuation := '';
	STRING4 Career_Firefighter := '';
	STRING4 Volunteer_Firefighter := '';
	STRING10 Distance_To_Fire_Department := '';
END;

EXPORT propertyAddress := RECORD
	STRING10 Street_Number := '';
	STRING2 Street_Pre_Direction := '';
	STRING28 Street_Name := '';
	STRING4 Street_Suffix := '';
	STRING2 Street_Post_Direction := '';
	STRING10 Unit_Designation := '';
	STRING8 Unit_Number := '';
	STRING60 Street_Address_1 := '';
	STRING60 Street_Address_2 := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING5 Zip_5 := '';
	STRING4 Zip_4 := '';
	STRING18 County := '';
	STRING9 Postal_Code := '';
	STRING50 State_City_Zip := '';
	STRING10 Census_Tract := '';
END;

EXPORT propertyAddress_Output := RECORD
	STRING10 Property_Information__Street_Number := '';
	STRING2 Property_Information__Street_Pre_Direction := '';
	STRING28 Property_Information__Street_Name := '';
	STRING4 Property_Information__Street_Suffix := '';
	STRING2 Property_Information__Street_Post_Direction := '';
	STRING10 Property_Information__Unit_Designation := '';
	STRING8 Property_Information__Unit_Number := '';
	STRING60 Property_Information__Street_Address_1 := '';
	STRING60 Property_Information__Street_Address_2 := '';
	STRING25 Property_Information__City := '';
	STRING2 Property_Information__State := '';
	STRING5 Property_Information__Zip_5 := '';
	STRING4 Property_Information__Zip_4 := '';
	STRING18 Property_Information__County := '';
	STRING9 Property_Information__Postal_Code := '';
	STRING50 Property_Information__State_City_Zip := '';
	STRING10 Property_Information__Census_Tract := '';
END;

EXPORT propertyAttributes := RECORD
	STRING15 Living_Area_SF := '';
	UNSIGNED2 Living_Area_SF_ConfidenceFactor := 0;
	STRING5 Stories := '';
	UNSIGNED2 Stories_ConfidenceFactor := 0;
	STRING5 Bedrooms := '';
	UNSIGNED2 Bedrooms_ConfidenceFactor := 0;
	STRING7 Baths := '';
	UNSIGNED2 Baths_ConfidenceFactor := 0;
	STRING5 Fireplaces := '';
	UNSIGNED2 Fireplaces_ConfidenceFactor := 0;
	STRING1 Pool := '';
	UNSIGNED2 Pool_ConfidenceFactor := 0;
	STRING1 AC := '';
	UNSIGNED2 AC_ConfidenceFactor := 0;
	STRING8 Year_Built := '';
	UNSIGNED2 Year_Built_ConfidenceFactor := 0;
	STRING64 Slope := '';
	UNSIGNED2 Slope_ConfidenceFactor := 0;
	STRING64 Quality_Of_Struct := '';
	UNSIGNED2 Quality_Of_Struct_ConfidenceFactor := 0;
	STRING25 Replacement_Cost_Report_Id := '';
	UNSIGNED2 Replacement_Cost_Report_Id_ConfidenceFactor := 0;
	STRING25 Policy_Coverage_Value := '';
	UNSIGNED2 Policy_Coverage_Value_ConfidenceFactor := 0;
	STRING1 Fireplace_Indicator := '';
	UNSIGNED2 Fireplace_Indicator_ConfidenceFactor := 0;
	STRING15 Units := '';
	UNSIGNED2 Units_ConfidenceFactor := 0;
	STRING15 Rooms := '';
	UNSIGNED2 Rooms_ConfidenceFactor := 0;
	STRING15 Full_Baths := '';
	UNSIGNED2 Full_Baths_ConfidenceFactor := 0;
	STRING15 Half_Baths := '';
	UNSIGNED2 Half_Baths_ConfidenceFactor := 0;
	STRING15 Bath_Fixtures := '';
	UNSIGNED2 Bath_Fixtures_ConfidenceFactor := 0;
	STRING8 Effective_Year_Built := '';
	UNSIGNED2 Effective_Year_Built_ConfidenceFactor := 0;
	STRING64 Condition_Of_Structure := '';
	UNSIGNED2 Condition_Of_Structure_ConfidenceFactor := 0;
	STRING15 Building_Area_SF := '';
	UNSIGNED2 Building_Area_SF_ConfidenceFactor := 0;
	STRING15 Ground_Floor_Area_SF := '';
	UNSIGNED2 Ground_Floor_Area_SF_ConfidenceFactor := 0;
	STRING15 Basement_Area_SF := '';
	UNSIGNED2 Basement_Area_SF_ConfidenceFactor := 0;
	STRING15 Garage_Area_SF := '';
	UNSIGNED2 Garage_Area_SF_ConfidenceFactor := 0;
	STRING100 Type_Of_Residence := '';
	UNSIGNED2 Type_Of_Residence_ConfidenceFactor := 0;
	STRING11 Flood_Zone_Panel_Number := '';
	UNSIGNED2 Flood_Zone_Panel_Number_ConfidenceFactor := 0;
	STRING6 Stories_Type := '';
	UNSIGNED2 Stories_Type_ConfidenceFactor := 0;
END;

EXPORT propertyCharacteristics := RECORD
	// Category 001
	STRING3 Air_Conditioning_Category := '001';
	STRING3 Air_Conditioning_Material := '';
	UNSIGNED2 Air_Conditioning_Material_ConfidenceFactor := 0;
	STRING64 Air_Conditioning_Material_Desc := '';
	UNSIGNED2 Air_Conditioning_Material_Desc_ConfidenceFactor := 0;
	STRING15 Air_Conditioning_Value := '';
	STRING64 Air_Conditioning_Quality_Desc := '';
	STRING64 Air_Conditioning_Condition_Desc := '';
	STRING3 Air_Conditioning_Age := '';
	STRING15 Air_Conditioning_ERC_Value := '';
	STRING15 Air_Conditioning_Low_ERC_Value := '';
	STRING15 Air_Conditioning_High_ERC_Value := '';
	// Category 002
	STRING3 Walls_and_Ceilings_Category := '002';
	STRING3 Walls_and_Ceilings_Material := '';
	UNSIGNED2 Walls_and_Ceilings_Material_ConfidenceFactor := 0;
	STRING64 Walls_and_Ceilings_Material_Desc := '';
	UNSIGNED2 Walls_and_Ceilings_Material_Desc_ConfidenceFactor := 0;
	STRING15 Walls_and_Ceilings_Value := '';
	STRING64 Walls_and_Ceilings_Quality_Desc := '';
	STRING64 Walls_and_Ceilings_Condition_Desc := '';
	STRING3 Walls_and_Ceilings_Age := '';
	STRING15 Walls_and_Ceilings_ERC_Value := '';
	STRING15 Walls_and_Ceilings_Low_ERC_Value := '';
	STRING15 Walls_and_Ceilings_High_ERC_Value := '';
	// Category 003
	STRING3 Flooring_Category := '003';
	STRING3 Flooring_Material := '';
	UNSIGNED2 Flooring_Material_ConfidenceFactor := 0;
	STRING64 Flooring_Material_Desc := '';
	UNSIGNED2 Flooring_Material_Desc_ConfidenceFactor := 0;
	STRING15 Flooring_Value := '';
	STRING64 Flooring_Quality_Desc := '';
	STRING64 Flooring_Condition_Desc := '';
	STRING3 Flooring_Age := '';
	STRING15 Flooring_ERC_Value := '';
	STRING15 Flooring_Low_ERC_Value := '';
	STRING15 Flooring_High_ERC_Value := '';
	// Category 004
	STRING3 Appliances_Category := '004';
	STRING3 Appliances_Material := '';
	UNSIGNED2 Appliances_Material_ConfidenceFactor := 0;
	STRING64 Appliances_Material_Desc := '';
	UNSIGNED2 Appliances_Material_Desc_ConfidenceFactor := 0;
	STRING15 Appliances_Value := '';
	STRING64 Appliances_Quality_Desc := '';
	STRING64 Appliances_Condition_Desc := '';
	STRING3 Appliances_Age := '';
	STRING15 Appliances_ERC_Value := '';
	STRING15 Appliances_Low_ERC_Value := '';
	STRING15 Appliances_High_ERC_Value := '';
	// Category 005
	STRING3 Exterior_Wall_Category := '005';
	STRING3 Exterior_Wall_Material := '';
	UNSIGNED2 Exterior_Wall_Material_ConfidenceFactor := 0;
	STRING64 Exterior_Wall_Material_Desc := '';
	UNSIGNED2 Exterior_Wall_Material_Desc_ConfidenceFactor := 0;
	STRING15 Exterior_Wall_Value := '';
	STRING64 Exterior_Wall_Quality_Desc := '';
	STRING64 Exterior_Wall_Condition_Desc := '';
	STRING3 Exterior_Wall_Age := '';
	STRING15 Exterior_Wall_ERC_Value := '';
	STRING15 Exterior_Wall_Low_ERC_Value := '';
	STRING15 Exterior_Wall_High_ERC_Value := '';
	// Category 006
	STRING3 Roofing_Category := '006';
	STRING3 Roofing_Material := '';
	UNSIGNED2 Roofing_Material_ConfidenceFactor := 0;
	STRING64 Roofing_Material_Desc := '';
	UNSIGNED2 Roofing_Material_Desc_ConfidenceFactor := 0;
	STRING15 Roofing_Value := '';
	STRING64 Roofing_Quality_Desc := '';
	STRING64 Roofing_Condition_Desc := '';
	STRING3 Roofing_Age := '';
	STRING15 Roofing_ERC_Value := '';
	STRING15 Roofing_Low_ERC_Value := '';
	STRING15 Roofing_High_ERC_Value := '';
	// Category 007
	STRING3 Foundation_Category := '007';
	STRING3 Foundation_Material := '';
	UNSIGNED2 Foundation_Material_ConfidenceFactor := 0;
	STRING64 Foundation_Material_Desc := '';
	UNSIGNED2 Foundation_Material_Desc_ConfidenceFactor := 0;
	STRING15 Foundation_Value := '';
	STRING64 Foundation_Quality_Desc := '';
	STRING64 Foundation_Condition_Desc := '';
	STRING3 Foundation_Age := '';
	STRING15 Foundation_ERC_Value := '';
	STRING15 Foundation_Low_ERC_Value := '';
	STRING15 Foundation_High_ERC_Value := '';
	// Category 008
	STRING3 Fireplace_Category := '008';
	STRING3 Fireplace_Material := '';
	UNSIGNED2 Fireplace_Material_ConfidenceFactor := 0;
	STRING64 Fireplace_Material_Desc := '';
	UNSIGNED2 Fireplace_Material_Desc_ConfidenceFactor := 0;
	STRING15 Fireplace_Value := '';
	STRING64 Fireplace_Quality_Desc := '';
	STRING64 Fireplace_Condition_Desc := '';
	STRING3 Fireplace_Age := '';
	STRING15 Fireplace_ERC_Value := '';
	STRING15 Fireplace_Low_ERC_Value := '';
	STRING15 Fireplace_High_ERC_Value := '';
	// Category 009
	STRING3 Balcony_Category := '009';
	STRING3 Balcony_Material := '';
	UNSIGNED2 Balcony_Material_ConfidenceFactor := 0;
	STRING64 Balcony_Material_Desc := '';
	UNSIGNED2 Balcony_Material_Desc_ConfidenceFactor := 0;
	STRING15 Balcony_Value := '';
	STRING64 Balcony_Quality_Desc := '';
	STRING64 Balcony_Condition_Desc := '';
	STRING3 Balcony_Age := '';
	STRING15 Balcony_ERC_Value := '';
	STRING15 Balcony_Low_ERC_Value := '';
	STRING15 Balcony_High_ERC_Value := '';
	// Category 010
	STRING3 Decks_and_Patios_Category := '010';
	STRING3 Decks_and_Patios_Material := '';
	UNSIGNED2 Decks_and_Patios_Material_ConfidenceFactor := 0;
	STRING64 Decks_and_Patios_Material_Desc := '';
	UNSIGNED2 Decks_and_Patios_Material_Desc_ConfidenceFactor := 0;
	STRING15 Decks_and_Patios_Value := '';
	STRING64 Decks_and_Patios_Quality_Desc := '';
	STRING64 Decks_and_Patios_Condition_Desc := '';
	STRING3 Decks_and_Patios_Age := '';
	STRING15 Decks_and_Patios_ERC_Value := '';
	STRING15 Decks_and_Patios_Low_ERC_Value := '';
	STRING15 Decks_and_Patios_High_ERC_Value := '';
	// Category 011
	STRING3 Porch_Category := '011';
	STRING3 Porch_Material := '';
	UNSIGNED2 Porch_Material_ConfidenceFactor := 0;
	STRING64 Porch_Material_Desc := '';
	UNSIGNED2 Porch_Material_Desc_ConfidenceFactor := 0;
	STRING15 Porch_Value := '';
	STRING64 Porch_Quality_Desc := '';
	STRING64 Porch_Condition_Desc := '';
	STRING3 Porch_Age := '';
	STRING15 Porch_ERC_Value := '';
	STRING15 Porch_Low_ERC_Value := '';
	STRING15 Porch_High_ERC_Value := '';
	// Category 012
	STRING3 Parking_Category := '012';
	STRING3 Parking_Material := '';
	UNSIGNED2 Parking_Material_ConfidenceFactor := 0;
	STRING64 Parking_Material_Desc := '';
	UNSIGNED2 Parking_Material_Desc_ConfidenceFactor := 0;
	STRING15 Parking_Value := '';
	STRING64 Parking_Quality_Desc := '';
	STRING64 Parking_Condition_Desc := '';
	STRING3 Parking_Age := '';
	STRING15 Parking_ERC_Value := '';
	STRING15 Parking_Low_ERC_Value := '';
	STRING15 Parking_High_ERC_Value := '';
	// Category 013
	STRING3 Basement_Category := '013';
	STRING3 Basement_Material := '';
	UNSIGNED2 Basement_Material_ConfidenceFactor := 0;
	STRING64 Basement_Material_Desc := '';
	UNSIGNED2 Basement_Material_Desc_ConfidenceFactor := 0;
	STRING15 Basement_Value := '';
	STRING64 Basement_Quality_Desc := '';
	STRING64 Basement_Condition_Desc := '';
	STRING3 Basement_Age := '';
	STRING15 Basement_ERC_Value := '';
	STRING15 Basement_Low_ERC_Value := '';
	STRING15 Basement_High_ERC_Value := '';
	// Category 014
	STRING3 Kitchen_Category := '014';
	STRING3 Kitchen_Material := '';
	UNSIGNED2 Kitchen_Material_ConfidenceFactor := 0;
	STRING64 Kitchen_Material_Desc := '';
	UNSIGNED2 Kitchen_Material_Desc_ConfidenceFactor := 0;
	STRING15 Kitchen_Value := '';
	STRING64 Kitchen_Quality_Desc := '';
	STRING64 Kitchen_Condition_Desc := '';
	STRING3 Kitchen_Age := '';
	STRING15 Kitchen_ERC_Value := '';
	STRING15 Kitchen_Low_ERC_Value := '';
	STRING15 Kitchen_High_ERC_Value := '';
	// Category 015
	STRING3 Bathroom_Category := '015';
	STRING3 Bathroom_Material := '';
	UNSIGNED2 Bathroom_Material_ConfidenceFactor := 0;
	STRING64 Bathroom_Material_Desc := '';
	UNSIGNED2 Bathroom_Material_Desc_ConfidenceFactor := 0;
	STRING15 Bathroom_Value := '';
	STRING64 Bathroom_Quality_Desc := '';
	STRING64 Bathroom_Condition_Desc := '';
	STRING3 Bathroom_Age := '';
	STRING15 Bathroom_ERC_Value := '';
	STRING15 Bathroom_Low_ERC_Value := '';
	STRING15 Bathroom_High_ERC_Value := '';
	// Category 016
	STRING3 Water_Category := '016';
	STRING3 Water_Material := '';
	UNSIGNED2 Water_Material_ConfidenceFactor := 0;
	STRING64 Water_Material_Desc := '';
	UNSIGNED2 Water_Material_Desc_ConfidenceFactor := 0;
	STRING15 Water_Value := '';
	STRING64 Water_Quality_Desc := '';
	STRING64 Water_Condition_Desc := '';
	STRING3 Water_Age := '';
	STRING15 Water_ERC_Value := '';
	STRING15 Water_Low_ERC_Value := '';
	STRING15 Water_High_ERC_Value := '';
	// Category 017
	STRING3 Basecost_Category := '017';
	STRING3 Basecost_Material := '';
	UNSIGNED2 Basecost_Material_ConfidenceFactor := 0;
	STRING64 Basecost_Material_Desc := '';
	UNSIGNED2 Basecost_Material_Desc_ConfidenceFactor := 0;
	STRING15 Basecost_Value := '';
	STRING64 Basecost_Quality_Desc := '';
	STRING64 Basecost_Condition_Desc := '';
	STRING3 Basecost_Age := '';
	STRING15 Basecost_ERC_Value := '';
	STRING15 Basecost_Low_ERC_Value := '';
	STRING15 Basecost_High_ERC_Value := '';
	// Category 018
	STRING3 Plumbing_Category := '018';
	STRING3 Plumbing_Material := '';
	UNSIGNED2 Plumbing_Material_ConfidenceFactor := 0;
	STRING64 Plumbing_Material_Desc := '';
	UNSIGNED2 Plumbing_Material_Desc_ConfidenceFactor := 0;
	STRING15 Plumbing_Value := '';
	STRING64 Plumbing_Quality_Desc := '';
	STRING64 Plumbing_Condition_Desc := '';
	STRING3 Plumbing_Age := '';
	STRING15 Plumbing_ERC_Value := '';
	STRING15 Plumbing_Low_ERC_Value := '';
	STRING15 Plumbing_High_ERC_Value := '';
	// Category 019
	STRING3 Style_Category := '019';
	STRING3 Style_Material := '';
	UNSIGNED2 Style_Material_ConfidenceFactor := 0;
	STRING64 Style_Material_Desc := '';
	UNSIGNED2 Style_Material_Desc_ConfidenceFactor := 0;
	STRING15 Style_Value := '';
	STRING64 Style_Quality_Desc := '';
	STRING64 Style_Condition_Desc := '';
	STRING3 Style_Age := '';
	STRING15 Style_ERC_Value := '';
	STRING15 Style_Low_ERC_Value := '';
	STRING15 Style_High_ERC_Value := '';
	// Category 020
	STRING3 Fuel_Category := '020';
	STRING3 Fuel_Material := '';
	UNSIGNED2 Fuel_Material_ConfidenceFactor := 0;
	STRING64 Fuel_Material_Desc := '';
	UNSIGNED2 Fuel_Material_Desc_ConfidenceFactor := 0;
	STRING15 Fuel_Value := '';
	STRING64 Fuel_Quality_Desc := '';
	STRING64 Fuel_Condition_Desc := '';
	STRING3 Fuel_Age := '';
	STRING15 Fuel_ERC_Value := '';
	STRING15 Fuel_Low_ERC_Value := '';
	STRING15 Fuel_High_ERC_Value := '';
	// Category 021
	STRING3 Garage_Category := '021';
	STRING3 Garage_Material := '';
	UNSIGNED2 Garage_Material_ConfidenceFactor := 0;
	STRING64 Garage_Material_Desc := '';
	UNSIGNED2 Garage_Material_Desc_ConfidenceFactor := 0;
	STRING15 Garage_Value := '';
	STRING64 Garage_Quality_Desc := '';
	STRING64 Garage_Condition_Desc := '';
	STRING3 Garage_Age := '';
	STRING15 Garage_ERC_Value := '';
	STRING15 Garage_Low_ERC_Value := '';
	STRING15 Garage_High_ERC_Value := '';
	// Category 022
	STRING3 Construction_Type_Category := '022';
	STRING3 Construction_Type_Material := '';
	UNSIGNED2 Construction_Type_Material_ConfidenceFactor := 0;
	STRING64 Construction_Type_Material_Desc := '';
	UNSIGNED2 Construction_Type_Material_Desc_ConfidenceFactor := 0;
	STRING15 Construction_Type_Value := '';
	STRING64 Construction_Type_Quality_Desc := '';
	STRING64 Construction_Type_Condition_Desc := '';
	STRING3 Construction_Type_Age := '';
	STRING15 Construction_Type_ERC_Value := '';
	STRING15 Construction_Type_Low_ERC_Value := '';
	STRING15 Construction_Type_High_ERC_Value := '';
	// Category 024
	STRING3 Heating_Category := '024';
	STRING3 Heating_Material := '';
	UNSIGNED2 Heating_Material_ConfidenceFactor := 0;
	STRING64 Heating_Material_Desc := '';
	UNSIGNED2 Heating_Material_Desc_ConfidenceFactor := 0;
	STRING15 Heating_Value := '';
	STRING64 Heating_Quality_Desc := '';
	STRING64 Heating_Condition_Desc := '';
	STRING3 Heating_Age := '';
	STRING15 Heating_ERC_Value := '';
	STRING15 Heating_Low_ERC_Value := '';
	STRING15 Heating_High_ERC_Value := '';
	// Category 025
	STRING3 Frame_Category := '025';
	STRING3 Frame_Material := '';
	UNSIGNED2 Frame_Material_ConfidenceFactor := 0;
	STRING64 Frame_Material_Desc := '';
	UNSIGNED2 Frame_Material_Desc_ConfidenceFactor := 0;
	STRING15 Frame_Value := '';
	STRING64 Frame_Quality_Desc := '';
	STRING64 Frame_Condition_Desc := '';
	STRING3 Frame_Age := '';
	STRING15 Frame_ERC_Value := '';
	STRING15 Frame_Low_ERC_Value := '';
	STRING15 Frame_High_ERC_Value := '';
	// Category 026
	STRING3 Sewer_Category := '026';
	STRING3 Sewer_Material := '';
	UNSIGNED2 Sewer_Material_ConfidenceFactor := 0;
	STRING64 Sewer_Material_Desc := '';
	UNSIGNED2 Sewer_Material_Desc_ConfidenceFactor := 0;
	STRING15 Sewer_Value := '';
	STRING64 Sewer_Quality_Desc := '';
	STRING64 Sewer_Condition_Desc := '';
	STRING3 Sewer_Age := '';
	STRING15 Sewer_ERC_Value := '';
	STRING15 Sewer_Low_ERC_Value := '';
	STRING15 Sewer_High_ERC_Value := '';
	// Category 027
	STRING3 Pool_Category := '027';
	STRING3 Pool_Material := '';
	UNSIGNED2 Pool_Material_ConfidenceFactor := 0;
	STRING64 Pool_Material_Desc := '';
	UNSIGNED2 Pool_Material_Desc_ConfidenceFactor := 0;
	STRING15 Pool_Value := '';
	STRING64 Pool_Quality_Desc := '';
	STRING64 Pool_Condition_Desc := '';
	STRING3 Pool_Age := '';
	STRING15 Pool_ERC_Value := '';
	STRING15 Pool_Low_ERC_Value := '';
	STRING15 Pool_High_ERC_Value := '';
END;

EXPORT propertyMortgages := RECORD
	STRING50 Mortgage_Company_Name := '';
	UNSIGNED2 Mortgage_Company_Name_ConfidenceFactor := 0;
	STRING10 Mortgage_Type := '';
	UNSIGNED2 Mortgage_Type_ConfidenceFactor := 0;
	STRING64 Mortgage_Type_Desc := '';
	UNSIGNED2 Mortgage_Type_Desc_ConfidenceFactor := 0;
	STRING15 Loan_Amount := '';
	UNSIGNED2 Loan_Amount_ConfidenceFactor := 0;
	STRING5 Loan_Type_Code := '';
	UNSIGNED2 Loan_Type_Code_ConfidenceFactor := 0;
	STRING64 Loan_Type := '';
	UNSIGNED2 Loan_Type_ConfidenceFactor := 0;
	STRING10 Interest_Rate := '';
	UNSIGNED2 Interest_Rate_ConfidenceFactor := 0;
END;

EXPORT propertySales := RECORD
	STRING8 Deed_Recording_Date := '';
	UNSIGNED2 Deed_Recording_Date_ConfidenceFactor := 0;
	STRING8 Sales_Date := '';
	UNSIGNED2 Sales_Date_ConfidenceFactor := 0;
	STRING20 Deed_Document_Number := '';
	UNSIGNED2 Deed_Document_Number_ConfidenceFactor := 0;
	STRING15 Sales_Amount := '';
	UNSIGNED2 Sales_Amount_ConfidenceFactor := 0;
	STRING64 Sales_Type := '';
	UNSIGNED2 Sales_Type_ConfidenceFactor := 0;
END;

EXPORT propertyTax := RECORD
	STRING10 Land_Use_Code := '';
	UNSIGNED2 Land_Use_Code_ConfidenceFactor := 0;
	STRING64 Land_Use := '';
	UNSIGNED2 Land_Use_ConfidenceFactor := 0;
	STRING4 Property_Type_Code := '';
	UNSIGNED2 Property_Type_Code_ConfidenceFactor := 0;
	STRING64 Property_Type := '';
	UNSIGNED2 Property_Type_ConfidenceFactor := 0;
	STRING15 Lot_Size := '';
	UNSIGNED2 Lot_Size_ConfidenceFactor := 0;
	STRING10 Lot_Front_Footage := '';
	UNSIGNED2 Lot_Front_Footage_ConfidenceFactor := 0;
	STRING10 Lot_Depth_Footage := '';
	UNSIGNED2 Lot_Depth_Footage_ConfidenceFactor := 0;
	STRING15 Acres := '';
	UNSIGNED2 Acres_ConfidenceFactor := 0;
	STRING15 Total_Assessed_Value := '';
	UNSIGNED2 Total_Assessed_Value_ConfidenceFactor := 0;
	STRING15 Total_Calculated_Value := '';
	UNSIGNED2 Total_Calculated_Value_ConfidenceFactor := 0;
	STRING15 Total_Market_Value := '';
	UNSIGNED2 Total_Market_Value_ConfidenceFactor := 0;
	STRING15 Total_Land_Value := '';
	UNSIGNED2 Total_Land_Value_ConfidenceFactor := 0;
	STRING15 Market_Land_Value := '';
	UNSIGNED2 Market_Land_Value_ConfidenceFactor := 0;
	STRING15 Assessed_Land_Value := '';
	UNSIGNED2 Assessed_Land_Value_ConfidenceFactor := 0;
	STRING15 Improvement_Value := '';
	UNSIGNED2 Improvement_Value_ConfidenceFactor := 0;
	STRING8 Assessed_Year := '';
	UNSIGNED2 Assessed_Year_ConfidenceFactor := 0;
	STRING20 Tax_Code_Area := '';
	UNSIGNED2 Tax_Code_Area_ConfidenceFactor := 0;
	STRING8 Tax_Billing_Year := '';
	UNSIGNED2 Tax_Billing_Year_ConfidenceFactor := 0;
	STRING1 Home_Stead_Exemption := '';
	UNSIGNED2 Home_Stead_Exemption_ConfidenceFactor := 0;
	STRING15 Tax_Amount := '';
	UNSIGNED2 Tax_Amount_ConfidenceFactor := 0;
	STRING10 Percent_Improved := '';
	UNSIGNED2 Percent_Improved_ConfidenceFactor := 0;
	STRING8 Assessment_Recording_Date := '';
	UNSIGNED2 Assessment_Recording_Date_ConfidenceFactor := 0;
END;


SHARED propAttributes := RECORD
	attributesVersion1 Version1;
END;

SHARED propCharacteristics := RECORD
	propertyAddress Address;
	propertyAttributes Attributes;
	propertyCharacteristics Characteristics;
	propertyMortgages Mortgages;
	propertySales Sales;
	propertyTax Taxes;
END;

EXPORT PropertyCharacteristics_batch := RECORD
	Address_Shell.Layouts.address_shell_input Input;	
	propAttributes PropertyAttributes;
	propCharacteristics PropertyCharacteristics;
END;

END;