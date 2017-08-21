EXPORT Layout_raw_okc_assessment := RECORD

string2	state_Postal_Code;  //Two-letter standard postal abbreviation. See p. 53-54 of the USPS Postal Addressâ€¦
string25	county_Name;  //This field contains the jurisdiction name which is usually the name of the countâ€¦
string45	aPN_A_or_PIN_Number;  //Assessor's Parcel Number or Parcel Identification Number. This is an arbitrary pâ€¦
string2	duplicate_APN_Multiple_Address_ID;  //Multiple Address IDThis field contains sequence numbers assigned to parcels haviâ€¦
string1	property_Address_Source_Flag;  //This field contains a letter code which tells how the contents of various properâ€¦
string7	property_House_Number;  //This field contains the number location of the property as commonly used in an aâ€¦
string6	property_House_Alpha;  //This field contains the upper limit of the house number range, fractions, or theâ€¦
string2	property_Street_Direction_Left;  //This field contains directional indicators in the property address which occur pâ€¦
string30	property_Street_Name;  //This field contains the name of the street. Do not abbreviate this data.Example;â€¦
string4	property_Street_Suffix;  //This field contains the recommended USPS standardized suffix abbreviations as coâ€¦
string2	property_Street_Direction_Right;  //Some street addresses will contain a directional indicator after the street suffâ€¦
string6	property_Unit_Number;  //This field contains the suite, unit, or apartment number which is part of the vaâ€¦
string60	property_Full_Street_Address;  //The full situs address of the property is always moved to this field. When the sâ€¦
string30	property_City_Name;  //This field contains the name of the city or municipality where the property is lâ€¦
string2	property_State;  //Two-letter standard postal abbreviation (see field _1), included here to completâ€¦
string5	property_Zip_Code;  //This data may be obtained from the assessed owner's mailing address for owner-ocâ€¦
string4	property_Zip4;  //This is the four-digit extension to the postal ZIP code for the property addressâ€¦
string80	assessee_Owner_Name;  //This field contains the name of the assessed property owner as of the tax lien dâ€¦
string60	second_Assessee_Owner_Name;  //This field is used for additional assessed owners' names, when provided by the câ€¦
string2	assessee_Vesting_ID_Code;  //This field either identifies how the assessed owner took title (vesting) or descâ€¦
string30	tax_Account_Number;  //This field accepts the tax account number assigned by the County.Sample Instructâ€¦
string60	mail_Care_Of_Name;  //When the sources file gives the owner's mailing address as care of another parâ€¦
string7	mailing_House_Number;  //â€¦
string6	mailing_House_Alpha;  //â€¦
string2	mailing_Street_Direction_Left;  //â€¦
string30	mailing_Street_Name;  //â€¦
string4	mailing_Street_Suffix;  //â€¦
string2	mailing_Street_Direction_Right;  //â€¦
string6	mailing_Unit_Number;  //â€¦
string80	mailing_Full_Street_Address;  //â€¦
string30	mailing_City_Name;  //â€¦
string2	mailing_State;  //â€¦
string5	mailing_Zip_Code;  //â€¦
string4	mailing_Zip4;  //â€¦
string10	state_Land_Use_Code;  //This field contains the land use code used by the state for land use classificatâ€¦
string1	owner_Occupied_SFR_Condo;  //Owner-occupancy of residential property is indicated by a Y in this field if Eâ€¦
string10	assessed_Land_Value;  //This is the assessed value of the land only, as reported on the County tax or asâ€¦
string10	assessed_Improvement_Value;  //This is the assessed value of the improvements only, as reported on the County tâ€¦
string11	total_Assessed_Value;  //This field contains the total current assessed value of the land and improvementâ€¦
string4	assessment_Year;  //This is the year in which the tax lien derived from the assessments given in fieâ€¦
string1	calif_Homeowners_Exemption;  //If the property has received a California State Homeowner's Exemption, this fielâ€¦
string4	tax_Exemption_Code;  //This field reports the tax exemptions to which the owners of the property are enâ€¦
string18	tax_Rate_Code_Area;  //This field contains information about the taxing entities levying against the prâ€¦
string10	tax_Amount;  //This field contains the amount of tax on the property expressed in dollars and câ€¦
string4	tax_Year;  //This is the year in which the amount shown in Tax Amount [44] was levied. Sampleâ€¦
string4	tax_Delinquent_Year;  //This is the year in which the property tax became delinquent (unpaid).Sample Insâ€¦
string20	recorders_Document_Number;  //This is a sequential number assigned to documents at the time of recording for tâ€¦
string10	recorders_Book_Number;  //This is the first half of a sequential numbering system by which recorded documeâ€¦
string10	recorders_Page_Number;  //This is the second half of a sequential numbering system by which recorded documâ€¦
string8	recording_Date;  //This is the date on which a document was recorded (it is not usually the actual â€¦
string25	document_Type; //This field contains a code for the type of document used to establish ownership â€¦
string10	sales_Price;  //Sale price greater than $500.00 is entered in whole dollars only. Availability wâ€¦
string1	sales_Price_Code;  //Because the sale price reported in the source file is not always the actual dollâ€¦
string8	prior_Recording_Date; //This is the date of sale for that sale immediately prior to the most recent one.â€¦
string10	prior_Sales_Price;  //This is the price paid by the previous owner of the property.Use only when a corâ€¦
string1	prior_Sales_Code;  //The code in this field indicates whether the reported prior sale amount isFFullâ€¦
string2	legal_Lot_Code;  //This code identifies records for which the lot(s) in question are either multiplâ€¦
string7	legal_Lot_Number;  //The actual lot number(s) covered by the record, such as any lot in a tract or suâ€¦
string10	legal_Land_Lot;  //A Land Lot is a mapping term used in a survey system unique to Georgia, usually â€¦
string7	legal_Block;  //Block is the term used to describe the next largest classification of subdividâ€¦
string7	legal_Section;  //Section is the term used to describe the next largest classification of urban â€¦
string12	legal_District;  //This field is used to provide the (usually numeric) code designation of the distâ€¦
string6	legal_Unit;  //Subdivision unit numberSample Instruction;Â â€¦
string30	legal_City_Municipality_Township;  //This field contains the name of the municipal jurisdiction within which the propâ€¦
string40	legal_Subdivision_Name;  //This field contains the name of the subdivision or plat or tract within which thâ€¦
string7	legal_Phase_No;  //This field generally refers to the phase number of a subdivision or tract develoâ€¦
string10	legal_Tract_No;  //This field contains the number of the tract within which the property is locatedâ€¦
string30	legal_Sec_Twn_Rng_Mer;  //The government performed a survey of most of the nation in the last century. As â€¦
string125	legal_Brief_Description;  //In this field is strung whatever narrative legal description is given in the souâ€¦
string15	legal_Assessors_Map_Ref;  //This field contains the Assessor's Map reference, which may or may not be the saâ€¦
string45	county_Land_Use_Description;  //This field contains the literal land use description unique to each county assesâ€¦
string8	county_Land_Use_Code;  //This field contains the land use code used by the county for land use classificaâ€¦
string4	standardized_Land_Use_Code;  //This field contains the Lexis-Nexis Standardized Land Use Code as found on the Lâ€¦
string1	timeshare_Code;  //If the property is a timeshare property, enter Y in this field; otherwise, leaâ€¦
string25	zoning;  //This field contains the actual city zoning, unique to each incorporated area. Thâ€¦
string14	lot_Size_or_Area;  //This field contains the total area measurement of the land. Depending on how thiâ€¦
string9	building_Area; //This field contains the total square footage of improvements on the property andâ€¦
string4	year_Built;  //This field applies to all types of improvements. If the source file only containâ€¦
string3	no_of_Buildings;  //This field contains the total number of buildings or structures on a single parcâ€¦
string5	no_of_Stories;  //This field contains the number of stories for the main structure on the propertyâ€¦
string4	no_of_Units;  //This field is primarily used for reporting the number of units in apartment builâ€¦
string2	total_Rooms;  //This field contains the result of a physical room count. Counties will occasionaâ€¦
string2	no_of_Bedrooms;  //This field contains the result of a physical bedroom (with closet) count for resâ€¦
string4	no_of_Baths; //This field contains the result of a physical bathroom count for residential propâ€¦
string2	no_of_PARTIAL_Baths;  //When given in the source file, residential partial bath counts are moved to thisâ€¦
string1	garage_Type_Parking;  //The type of parking available on the property is converted per the table below aâ€¦
string4	parking_of_Cars;  //This field contains the number of cars which the existing parking facilities canâ€¦
string1	pool;  //This field indicates the presence or absence of swimming pools and spas, as thisâ€¦
string50	mail_csz;  //If the source file only contains an unparsed version of the assessed owner's maiâ€¦
string5	fIPS_Code_State_County;  //The FIPS code is a five-digit numeric designation which is unique for each countâ€¦
string6	tape_Cut_Date;  //This is the date on which our tape was generated from the source (county) databaâ€¦
string6	census_Tract;  //Format 9999v99 (implied decimal) Sample Instructions;Â  â€¦
string2	record_Type;  //This field contains a code which identifies the type of ownership for each parceâ€¦
string10	market_Value_Land;  //This field contains the market value of the land only. The data may be availableâ€¦
string10	market_Value_Improvement;  //This field contains the market value of the improvements only. The data may be aâ€¦
string11	total_Market_Value;  //This field contains the total market value of the parcel, including land, improvâ€¦
string4	market_Value_Year;  //This field contains the year that the market value of the property was establishâ€¦
string1	building_Class;  //This field contains the Fire Insurance Building Classification Code used for comâ€¦
string1	style;  //AA-FrameXCustomâ€¦
string1	type_Construction;  //This field contains a single-letter code telling the type of construction used iâ€¦
string1	exterior_Walls;  //This field contains a single-letter code telling the type of exterior walls usedâ€¦
string1	foundation;  //This field contains a single-letter code telling the type of foundation found inâ€¦
string1	roof_Cover;  //This field contains a single-letter code telling the type of roof cover found inâ€¦
string1	heating;  //This field contains a single-letter code telling the type of heating system founâ€¦
string1	air_Conditioning;  //This field contains a single-letter code telling the type of air conditioning syâ€¦
string1	elevator;  //This field contains the actual number of elevators (if available) or one of the â€¦
string1	fireplace;  //This field contains the actual number of fireplaces (if available) or Y for Yeâ€¦
string1	basement;  //This field contains a single-letter code telling the type of basement found in tâ€¦
string2	edition_Number;  //This field contains the numerical edition, beginning with 01.Sample Instructioâ€¦
string3	property_Country_Code;  //The country code of the parcel. Defaults to 'blank' for the United States and Viâ€¦
string1	building_Area_Indicator_for_field_77;  //Identifies the value moved to BUILDING AREA [77]. Some examples are living area,â€¦
string1	property_Address_Match_Code_Y_N;  //â€¦
string4	property_Address_Unit_Designator_see_table;  //â€¦
string8	property_Address_Unit_Number;  //â€¦
string4	property_Address_Carrier_Route;  //â€¦
string1	property_Address_GeoCode_Match_Code;  //â€¦
string10	property_Address_Latitude;  //â€¦
string11	property_Address_Longitude;  //â€¦
string16	property_Address_Census_Tract_Block;  //â€¦
string1	mailing_Address_Match_Code_Y_N;  //â€¦
string4	mailing_Address_Unit_Designator_see_table;  //â€¦
string8	mailing_Address_Unit_Number;  //â€¦
string4	mailing_Address_Carrier_Route_;  //â€¦
string1	assessee_Owner_Name_Indicator;  //1252nd Assessee(Owner) Name Ind.11474126Mail Care-Of Name Indicator11475â€¦
string1	second_Assessee_Owner_Name_Indicator;  //126Mail Care-Of Name Indicator11475Lan2.2 fields 124-126 are used to indicate thâ€¦
string1	mail_Care_Of_Name_Indicator;  //Lan2.2 fields 124-126 are used to indicate the predominate pattern of names for â€¦
string1	assessee_Owner_Name_Type;  //1282nd Owner Name Type11477Indicate whether the names associated with a parcel aâ€¦
string1	second_Assessee_Owner_Name_Type;  //Indicate whether the names associated with a parcel are individuals, businesses,â€¦
string1	mail_Care_Of_Name_Type;  //Indicates whether the value in Old/Alt APN [187] is an old APN (meaning an APN câ€¦
string8	certification_Date;  //The date that the file was certified by the County. This date will be provided bâ€¦
string9	lot_Size_Square_Feet;  //This field contains the total area measurement of the land in square feet. If thâ€¦
string2	building_Quality;  //This field contains a code reflecting the quality of a building. Usually comes aâ€¦
string2	fLOOR_COVER;  //This field contains a code reflecting the type of flooring used in improvements â€¦
string3	_of_Plumbing_Fixtures;  //This is a numerical field identifying the number of plumbing features reported bâ€¦
string8	building_Area_1;  //136Building Area 1 Indicator21511137Building Area 281513â€¦
string2	building_Area_1_Indicator;  //137Building Area 281513138Building Area 2 Indicator21521â€¦
string8	building_Area_2;  //138Building Area 2 Indicator21521139Building Area 381523â€¦
string2	building_Area_2_Indicator;  //139Building Area 381523140Building Area 3 Indicator21531â€¦
string8	building_Area_3;  //140Building Area 3 Indicator21531141Building Area 481533â€¦
string2	building_Area_3_Indicator;  //141Building Area 481533142Building Area 4 Indicator21541â€¦
string8	building_Area_4;  //142Building Area 4 Indicator21541143Building Area 581543â€¦
string2	building_Area_4_Indicator;  //143Building Area 581543144Building Area 5 Indicator21551â€¦
string8	building_Area_5;  //144Building Area 5 Indicator21551145Building Area 681553â€¦
string2	building_Area_5_Indicator;  //145Building Area 681553146Building Area 6 Indicator21561â€¦
string8	building_Area_6;  //146Building Area 6 Indicator21561147Building Area 781563â€¦
string2	building_Area_6_Indicator;  //147Building Area 781563148Building Area 7 Indicator21571â€¦
string8	building_Area_7;  //148Building Area 7 Indicator21571Allow for identifying building area for up to sâ€¦
string2	building_Area_7_Indicator;  //Allow for identifying building area for up to seven building features, such as gâ€¦
string4	effective_Year_Built;  //The date that reflects the condition of an improvement. It is the same or later â€¦
string1	heating_Fuel_Type;  //The type of heating fuel (oil, gas, solar). Some counties may also provide a heaâ€¦
string1	air_Conditioning_Type;  //The type of air conditioning. Some counties may also provide an air conditioningâ€¦
string10	lot_Size_Acres;  //This field contains the total area measurement of the land in acres. If the lot â€¦
string40	mortgage_Lender_Name;  //The name of the company or individual that holds the mortgage, as provided by thâ€¦
string1	interior_Walls;  //This field contains a code reflecting the composition of the interior walls.â€¦
string15	school_Tax_District_1;  //156School/Tax District Ind. 111645157School/Tax District 2151646â€¦
string1	school_Tax_District_1_Indicator;  //157School/Tax District 2151646158School/Tax District Ind. 211661â€¦
string15	school_Tax_District_2;  //158School/Tax District Ind. 211661159School/Tax District 3151662â€¦
string1	school_Tax_District_2_Indicator;  //159School/Tax District 3151662160School/Tax District Ind. 311677â€¦
string15	school_Tax_District_3;  //160School/Tax District Ind. 311677Identifies school and/or tax districts. These â€¦
string1	school_Tax_District_3_Indicator;  //Identifies school and/or tax districts. These fields will be used in different wâ€¦
string2	site_Influence;  //Identifies features or characteristics of a location which might influence the vâ€¦
string5	amenities_See_Amenities_2_Field_170;  //Identifies the extra selling features that add to the value of property, such asâ€¦
string2	other_Impr_Building_Indicator_1;  //164OTHER IMPR BLDG IND 221687165OTHER IMPR BLDG IND 321689â€¦
string2	other_Impr_Building_Indicator_2;  //165OTHER IMPR BLDG IND 321689166OTHER IMPR BLDG IND 421691â€¦
string2	other_Impr_Building_Indicator_3;  //166OTHER IMPR BLDG IND 421691169OTHER IMPR BLDG IND 521722â€¦
string2	other_Impr_Building_Indicator_4;  //169OTHER IMPR BLDG IND 521722These fields are defined as buildings not attached â€¦
string9	neighborhood_Code;  //Indicates the neighborhood or geographic area of a parcel. This is a county-provâ€¦
string0	intentionally_left_blank;  //Indicates the neighborhood or geographic area of a parcel. This is a county-provâ€¦
string20	condo_Project_Bldg_Name;  //The name of a condominium building or complex and/or building name or complex. â€¦
string2	other_Impr_Building_Indicator_5;  //These fields are defined as buildings not attached to the main building/house anâ€¦
string5	amenities_2_see_Field_162;  //If more than five codes can be moved to Amenities [162] use this field for up toâ€¦
string9	other_Impr_Building_Area_1;  //172OTHER IMPR BLDG AREA 291738173OTHER IMPR BLDG AREA 391747â€¦
string9	other_Impr_Building_Area_2;  //173OTHER IMPR BLDG AREA 391747174OTHER IMPR BLDG AREA 491756â€¦
string9	other_Impr_Building_Area_3;  //174OTHER IMPR BLDG AREA 491756175OTHER IMPR BLDG AREA 591765â€¦
string9	other_Impr_Building_Area_4;  //175OTHER IMPR BLDG AREA 591765Contains the measurements of their respective Builâ€¦
string9	other_Impr_Building_Area_5;  //Contains the measurements of their respective Buildings and Improvements describâ€¦
string5	other_Rooms;  //This field describes the rooms within the main building/house, if provided by thâ€¦
string9	extra_Features_1_Area;  //178Extra Feature Area 1 Ind21788181Extra Features Area 291792â€¦
string2	extra_Features_1_Indicator;  //181Extra Features Area 291792182Extra Feature Area 2 Ind21801â€¦
string1	topography;  //Contains code representing the physical (including man-made) or natural featuresâ€¦
string1	roof_Type;  //The architectural style of the roof (gable, mansard, etc).FFlatâ€¦
string9	extra_Features_2_Area;  //182Extra Feature Area 2 Ind21801183Extra Features Area 391803â€¦
string2	extra_Features_2_Indicator;  //183Extra Features Area 391803184Extra Feature Area 3 Ind21812â€¦
string9	extra_Features_3_Area;  //184Extra Feature Area 3 Ind21812185Extra Features Area 491814â€¦
string2	extra_Features_3_Indicator;  //185Extra Features Area 491814186Extra Feature Area 4 Ind21823â€¦
string9	extra_Features_4_Area;  //186Extra Feature Area 4 Ind21823Allow for identifying areas for up to 4 extra feâ€¦
string2	extra_Features_4_Indicator;  //Allow for identifying areas for up to 4 extra features, such as driveways, fenceâ€¦
string31	old_APN;  //This field will list the APN previously used by the county to identify the propeâ€¦
string1	building_Condition;  //This field contains a code reflecting the condition of a building as determined â€¦
string10	lot_Size_Frontage_Feet;  //This field provides the frontage measurement of the property when provided by thâ€¦
string10	lot_Size_Depth_Feet;  //This field provides the depth measurement of the property when provided by the câ€¦
string120	comments_Summary_of_DR_Records;  //Additional information regarding a parcel. This information may come from a commâ€¦
string1	water;  //Contains codes representing the water system for the property. Valid Codes;â€¦
string1	sewer;  //Contains codes representing the waste disposal/sewage system for the property. Vâ€¦
string2	new_Record_Type_Legal_Description;  //Additional breakdown of Record Type [93]. Indicates whether a record is a DR râ€¦

END;