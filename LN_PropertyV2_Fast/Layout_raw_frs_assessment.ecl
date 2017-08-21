EXPORT Layout_raw_frs_assessment := RECORD

string5         fips_code;//Federal Information Processing Standards codes used nationally to numerically identify a specific county or political jurisdiction.
string3         fips_subcode;//A secondary classification of a jurisdiction within a FIPS.
string45        unformatted_apn;//Assessors Parcel Number in an unformatted form. This is most often used by the county and others as a unique key (e.g.,10132021A)
string3         apn_seq_nmb;//This internal sequence number is used to ensure unique-ness of the Assessors Parcel Number (e.g., 10132021A seq 001)
string45        formatted_apn;//Assessors Parcel Number in a formatted form. Dashes and decimals are commonly used to break an APN down into logical components (e.g., 101-32-021.A).
string45        original_apn;//Assessors Parcel Number exactly as received by source (e.g., 10132-021A00000).
string15        account_num;//The county or source number used primary for billing. Note: this number is typically not unique to a parcel, but rather to a tax bill (multiple parcels can be combined on 1 bill).
string60        map_ref_1;//A FARES unique key to link record to the FARES CD Map product. This is typically built from components of the APN that are relevant to the Assessor Maps (e.g., 101-32, represent Map Book and Map Page numbers).
string60        map_ref_2;//A secondary FARES unique key to link property records to the FARES CD Map product. See MAP REFERENCE 1 above.
string10        census_tract;//Comprised of Census Tract, Census Block and Census Block Suffix. These numbers are established by the US Department of Commerce (Bureau Of The Census).
string10        zoning;//The data contained in this field is based upon County and//or Local established Zoning Codes and are not converted by FARES.
string5         block_number;//Subdivision or County Map Block Number
string5         lot_number;//Subdivision or County Map Lot Number
string3         _range;//The range portion of geographical coordinates based on local surveys. Ranges typically run east or west of pre-determined meridian in six mile intervals.
string3         township;//The township portion of geographical coordinates based on local surveys. Townships typically run north or south of pre-determined meridian in six mile intervals.
string3         section;//The section portion of geographical coordinates based on local surveys. Sections are 1 square mile and there are 36 sections within the intersection of a Range // Township.
string3         quater_section;//A section that has been divided into four sub sections (e.g., NE, NW, SE, SW).
string11        thomas_bros_map_num;//The current map page and grid number used by Thomas Bros. Maps company.
string11        flood_zone_comm_panel_id;//This represents the FEMA Community Panel Number.
string8         situs_latitude;//The property location based upon the latitude component of latitude//longitude coordinates. The latitude is stored in decimal degrees to 6 decimal places (e.g., 12.123456) and will always be positive north of the equator.
string9         situs_longitude;//The property location based upon the longitude component of latitude//longitude coordinates. The longitude is stored in decimal degrees to 6 decimal places (e.g., 123.123456) and will always be negative on the North American continent.
string4         centroid_code;//This code represent to the level to which the property address was able to have a Lat//Long assigned (e.g., house, block).
string1         homestead_exempt;//This field will be set with an Y if the owner has qualified for a Homeowner//Homestead exemption.
string1         absentee_owner;//This field will be set with an A if the owner lives at a different location.
string10        tax_code_area;//This is a county specific code that represent the tax entity(s) for which a parcel is taxed (e.g., Park Hosp Dist, Hall Sch Dist,).
string10        land_use;//A FARES established Land Use code converted from various county Land Use codes to aid in search and extract functions.
string10        county_use1;//Primary (i.e., highest) Land Use as established by the county or local taxing administration.
string10        county_use2;//Secondary Land Use as established by the county or local taxing administration.
string3         property_ind;//A FARES general code used to easily recognize specific property types (e.g, Residential, Condominium, Commercial).
string30        municipality_name;//Name of the Municipality where parcel is located.
string3         view;//View from building (e.g., Gulf, Mountains, Pool). Please see VIEW table for code descriptions.
string3         location_influence;//Positive or negative aspects associated with the location of the parcel (e.g., waterfront, flood plane, airport). Please see LOCIN table for code descriptions.
string3         number_of_buildings;//Total number of buildings on the parcel.
string15        subdivision_tract_num;//The unique number assigned to a specific subdivision by the county. Often this is used in lieu of an actual subdivision name.
string6         subdivision_plat_book;//The first component of a recording system used by some counties to catalog subdivision // condo plans (e.g., Book 123 Page 55A).
string6         subdivision_plat_page;//The second component of a recording system used by some counties to catalog subdivision // condo plans (e.g., Book 123 Page 55A).
string30        subdivision_name;//The name of the Subdivision or Condominium where the parcel is located (e.g., Highland Mills Estates, Crystal Towers Condo).
string1         prop_address_indicator;//This field is used to indicate whether the Situs data (I.e., property location) was obtained directly from a county or local source (S) or was derived by the owners mailing address (M).
string5         prop_house_number_prefix;//The digits found to the left of a traditional house number (e.g., A123 MAIN ST) portion of a property address.
string10        prop_house_number;//The digits found to the immediate right of the Situs House Number Prefix and to the left of a traditional street name (e.g., A123 MAIN ST).
string10        prop_house_number_suffix;//The digits found to the right of a traditional house number often representing a multiple or range of entries to a building (e.g., 202B JONES RD, 202-220 JONES RD).
string2         prop_direction;//This field represents the direction found to the left of the street name (e.g., 9340 N DUNHILL DR // 340 NW 70TH AVE). AKA Directional Abbreviations, Pre-Directional.
string30        prop_street_name;//The name or number of the street where a parcel is located (e.g., 9340 N DUNHILL DR // 340 NW 70TH AVE // RR BOX 202, 12 BOX CREEK RD).
string5         prop_mode;//The Mode or Type of street found to the right of the street name (e.g.., 9340 N DUNHILL DR). AKA Street Designators // Street Suffixes.
string2         prop_quadrant;//The quadrant field is found to the right of Situs Mode (e.g., 100 TEMPLE ST NW, 2040 NW 100 ST SW). AKA Post-Directional.
string6         prop_apt_unit_num;//The unit or suite number of the property address (e.g., 649 LAKE SHORE DR #1400).
string40        prop_city;//The city associated with the property address (e.g., CHICAGO, ATLANTA, DENVER).
string2         prop_state;//The two-letter USPS postal abbreviation associated with the state // protectorants // commonwealth (e.g., CA, VI, PR).
string9         prop_zipcode;//The nine digit (i.e., ZIP & plus 4) assigned by the USPS. This is populated by various source files and other proprietary and non-proprietary processes (e.g., 954630042).
string4         prop_carrier_route;//This is the four digit code used by the local mail carrier to identify the delivery path.
string4         prop_match_code;//See MATCH TABLE KEY worksheet for an explanation of these codes.
string1         owner_corp_ind;//The Name of the property owner has been recognized as a corporation or business.
string30        owner_name;//The name of the property owner.
string30        owner_name_2;//Additional owner names if more than one person owns the property.
string60        owner_name1;//Non parsed owner name.
string60        owner_name2;//Additional owner names if more than one person owns the property - non parsed.
string10        owner_phone;//Phone number of property owner (e.g., 9095551212).
string1         owner_phone_opt_out_code;//A Y represents a record where the property owner has contacted the DMA (i.e., Direct Marketing Association) and has asked not to be contacted by phone for solicitation.
string1         owner_etal_ind;//A code appearing in this field indicates additional ownership, whose name(s) were not provided by our sources. Please see ETAL table for code descriptions.
string3         owner_ownership_rights_code;//Form or Method of Property Ownership (e.g., Joint Tenancy, Living Trust). Please see OWNSH table for code descriptions.
string2         owner_relationship_code;//Relationship between multiple owners or the marital status of a single owner (e.g., Husband//Wife, Unmarried Man). Please see RELAT table for code descriptions.
string5         own_house_number_prefix;//The digits found to the left of a traditional house number (e.g., A123 MAIN ST) portion of a property address.
string10        own_house_number;//The digits found to the immediate right of the Mail House Number Prefix and to the left of a traditional street name (e.g., A123 MAIN ST).
string10        own_house_number_suffix;//The digits found to the right of a traditional house number often representing a multiple or range of entries to a building (e.g., 202B JONES RD, 202-220 JONES RD).
string2         own_direction;//This field represents the direction found to the left of the street name (e.g., 9340 N DUNHILL DR // 340 NW 70TH AVE). AKA Directional Abbreviations, Pre-Directional.
string30        own_street_name;//The name or number of the street where a parcel is located (e.g., 9340 N DUNHILL DR // 340 NW 70TH AVE // RR BOX 202, 12 BOX CREEK RD).
string5         own_mode;//The Mode or Type of street found to the right of the street name (e.g.., 9340 N DUNHILL DR). AKA Street Designators // Street Suffixes.
string2         own_quadrant;//The quadrant field is found to the right of Mail Mode (e.g., 100 TEMPLE ST NW, 2040 NW 100 ST SW). AKA Post-Directional.
string6         own_apt_unit_num;//The unit or suite number of the property address (e.g., 649 LAKE SHORE DR #1400).
string40        own_city;//The city associated with the property address (e.g., CHICAGO, ATLANTA, DENVER).
string2         own_state;//The two-letter USPS postal abbreviation associated with the state // protectorants // commonwealth (e.g., CA, VI, PR).
string9         own_zipcode;//The nine digit (i.e., ZIP & plus 4) assigned by the USPS. This is populated by various source files and other proprietary and non-proprietary processes (e.g., 954630042).
string4         own_carrier_code;//This is the four digit code used by the local mail carrier to identify the delivery path.
string4         own_match_code;//See MATCH TABLE KEY worksheet for an explanation of these codes.
string1         mailing_opt_out_code;//A Y represents a record where the property owner has contacted the DMA (i.e., Direct Marketing Association) and has asked not to be contacted by mail for solicitation.
string11        total_val_calc;//The TOTAL (i.e., Land + Improvement) Value closest to current market value used for assessment by county or local taxing authorities.
string11        land_val_calc;//The LAND Value closest to current market value used for assessment by county or local taxing authorities.
string11        improvement_value_calc;//The IMPROVEMENT Value closest to current market value used for assessment by county or local taxing authorities.
string1         total_value_calc_ind;//The code appearing in this indicator field reflects the type of values (e.g., Market, Appraised) used to seed the TOTAL VALUE CALCULATED field. Please see VALTY table for code descriptions.
string1         land_value_calc_ind;//The code appearing in this indicator field reflects the type of values (e.g., Market, Appraised) used to seed the LAND VALUE CALCULATED field. Please see VALTY table for code descriptions.
string1         improvement_value_calc_ind;//The code appearing in this indicator field reflects the type of values (e.g., Market, Appraised) used to seed the IMPROVEMENT VALUE CALCULATED field. Please see VALTY table for code descriptions.
string11        assd_total_val;//The Total Assessed Value of the Parcels Land & Improvement values as provided by the county or local taxing//assessment authority.
string11        assd_land_val;//The Assessed Land Values as provided by the county or local taxing//assessment authority.
string11        assd_improvement_value;//The Assessed Improvement Values as provided by the county or local taxing//assessment authority.
string11        mkt_total_val;//The Total Market Value of the Parcels Land & Improvement values as provided by the county or local taxing//assessment authority.
string11        mkt_land_val;//The Market Land Values as provided by the county or local taxing//assessment authority.
string11        mkt_improvement_val;//The Market Improvement Values as provided by the county or local taxing//assessment authority.
string11        appr_total_val;//The Total Appraised Value of the Parcels Land & Improvement values as provided by the county or local taxing//assessment authority.
string11        appr_land_val;//The Appraised Land Values as provided by the county or local taxing//assessment authority.
string11        appr_improvement_val;//The Appraised Improvement Values as provided by the county or local taxing//assessment authority.
string11        tax_amount;//The Total Tax amount provided by the county or local taxing//assessment authority.
string4         tax_year;//The tax or assessment year for which the taxes were billed.
string17        transaction_id;//This is a FARES internal number used to identify a specific transaction. This number may aid customers in the creation of unique keys.
string4         document_year;//The year a sales transaction document was recorded (e.g., 1984).
string12        document_number;//The document number used by some counties to record sales transactions (e.g., 000012345678).
string12        book_page;//The Book and Page number used by some counties to catalog their sales recordings (e.g., 001234005678).
string3         sales_deed_cat_type;//The type of deed used to record the sales transaction (e.g., Grant, Quit, Foreclosure). Please see DEEDC table for code descriptions.
string8         recording_date;//The date the sales transaction was recorded at the county (e.g., 19621028)
string8         sale_date;//The date the sales transaction was legally completed (i.e., contact signed) (e.g., 19621025).
string11        sale_price;//Price of the sale as depicted on the recorded sales transaction.
string1         sale_code;//This field indicates whether the financial consideration is F = Full or P = Partial.
string60        seller_name;//The sellers name as it appears on the recorded sales transaction.
string3         sale_trans_code;//This identifies situations associated with the sale (e.g., Resale, Construction Loan, Seller Carryback). Please see TRNTP table for code descriptions.
string1         multi_apn_flag_1;//The data contained in this field depicts multiple or split parcel sales. Please see SLMLT table for code descriptions.
string4         multi_apn_count;//This reflects the number of parcels associated with the sale (e.g., 14 parcels recorded on the same document number).
string5         title_company_code;//This is a FARES internal code used to identify the Title Company that was associated with the sales transaction.
string60        title_company_name;//This is the Title Company associated with the sales transaction
string1         residential_model_ind;//A code to indicate whether the property is residential based on individual zipcodes and values. Y = yes, N or blank = no
string11        first_motgage_amount;//The amount of the first mortgage as depicted on the recorded document.
string8         mortgage_date;//The date the Mortgage was initiated.
string5         mortgage_loan_type_code;//Type of load secured (e.g., Conventional, FHA, VA). Please see MTGTP table for code descriptions
string6         mortgage_deed_type;//Type of deed used for recording (e.g., Agreement of Sale, Assumption, Correction Deed). Please see DOCTY table for code descriptions
string4         mortgage_term_code;//This code is used to identify whether the number stored in the MORTGAGE TERM field is in Days, Months or Years. Please see MTGTC table for code descriptions.
string5         mortgage_term;//The length of time before the mortgage matures (e.g., 15yrs, 30 yrs, 45dys).
string8         mortgage_due_date;//The date the mortgage amount becomes due.
string9         mortgage_assumption_amount;//The assumption amount related to an existing mortgage.
string10        lender_code;//This is a FARES internal code used to identify the Lending Company that was associated with the sales transaction.
string60        lender_name;//This is the name of the lender on the original recorded document.
string11        second_mortgage_amount;//This is the amount associated with the 2nd mortgage.
string5         second_mortgage_loan_type_code;//Type of load secured as part of the 2nd mortgage (e.g., Conventional, FHA, VA). Please see MTGTP table for code descriptions
string6         second_deed_type;//Type of deed used for recording the 2nd mortgage (e.g., Agreement of Sale, Assumption, Correction Deed). Please see DOCTY table for code descriptions
string13        prior_trans_id;//This is a FARES internal number used to identify a specific transaction. This number may aid customers in the creation of unique keys.
string4         prior_document_year;//The year a sales transaction document was recorded (e.g., 1984).
string12        prior_document_number;//The document number used by some counties to record sales transactions (e.g., 000012345678).
string12        prior_book_page;//The Book and Page number used by some counties to catalog their sales recordings (e.g., 001234005678).
string1         prior_sls_deed_cat_type;//The type of deed used to record the prior sales transaction (e.g., Grant, Quit, Foreclosure). Please see DEEDC table for code descriptions.
string8         prior_recording_date;//The date the sales transaction was recorded at the county (e.g., 19621028)
string8         prior_sales_date;//The date the sales transaction was legally completed (i.e., contact signed) (e.g., 19621025).
string11        prior_sales_price;//Price of the sale as depicted on the recorded sales transaction.
string1         prior_sales_code;//This field indicates whether the financial consideration is F = Full or P = Partial.
string3         prior_sales_trans_code;//This identifies situations associated with the sale (e.g., Resale, Construction Loan, Seller Carryback). Please see TRNTP table for code descriptions.
string1         prior_multi_apn_flag;//The data contained in this field depicts multiple or split parcel sales. Please see SLMLT table for code descriptions.
string4         multi_apn_count_2;//This reflects the number of parcels associated with the sale (e.g., 14 parcels recorded on the same document number).
string11        prior_mortgage_amount;//This is the amount associated with the mortgage of the prior sale.
string1         prior_deed_type;//Type of deed used for recording (e.g., Agreement of Sale, Assumption, Correction Deed). Please see DOCTY table for code descriptions
string7         front_footage;//The linear feet across the front of the lot - facing the street.
string7         depth_footage;//The linear feet between the front and back of the lot.
string13        acres;//Total land mass in Acres.
string9         land_square_footage;//Total land mass is Square Feet.
string20        lot_area;//A textual description of the lot area, which may include size and unique attributes of the lot (e.g., irregular lot size).
string9         universal_building_sq_feet;//The Building Square Footage that can most accurately be used for assessments or comparables (e.g., Living, Adjusted, Gross).
string1         building_sq_feet_ind;//The codes appearing in this field indicates the source used to populate the UNIVERSAL BUILDING SQUARE FEET field (e.g., Living, Adjusted, Gross). Please see BLDSF table for code descriptions.
string9         building_square_feet;//The size of the building in Square Feet. This field is most commonly populated as a cumulative total when a county does not differentiate between Living and Non-living areas.
string7         living_square_feet;//This is the area of a building that is used for general living. This is typically the area of a building that is heated or air conditioned and does not include Garage, Porch or Basement square footage.
string7         ground_floor_square_feet;//Square footage of the part of the building which is level with the ground (typically the front of the building). This is generally above the basement(s) and below the second floor.
string7         gross_square_feet;//This is the square footage for the entire building. Typically this represents all square feet under the roof.
string7         adjusted_gross_square_feet;//This is the square footage used by the county or local taxing // assessment authority to determine Improvement Value. This figure is typically 100% of the living area, plus lower percentage of non-living area.
string7         basement_square_feet;//This is total square footage associated with Basement portion of a building. This would include both finished and unfinished areas.
string7         garage_parking_square_feet;//This is the total square footage of the primary garage or parking area (i.e., commercial). This includes both finished and unfinished areas.
string4         year_built;//This is the construction year of the original building.
string4         effective_year_built;//This is the first year the building was assessed with its current components (e.g., a building is originally constructed in 1960 and a bedroom and bath was added to the building in 1974. The Year Built would be 1960 and the Effective Year Built would be 1974.
string5         bedrooms;//Total number of bedroom contained in the primary building.
string5         total_rooms;//Total number of rooms contained in the primary building.
string7         total_baths_calculated;//Total number of Bath Rooms in whole numbers (e.g., a home containing 2 1//2 baths would have the number 3 stored in this field as, three actual rooms have been designated for this purpose).
string7         total_baths;//Total number of Bathrooms as provided by our data sources (e.g., 4.00, 2.50, 1.75).
string5         full_baths;//Total number of Full Baths (typically comprised of a sink, toilet, and bathtub // shower stall). A home containing 2 1//2 baths would have the number 2 stored in this field.
string5         half_baths;//Total number of Half Baths (typically comprised of a sink & toilet). A home containing 2 1//2 baths would have the number 1 stored in this field.
string5         one_qtr_baths;//Total number of Quarter Baths (typically comprised only of a sink, as found in many laundry rooms).
string5         three_qtr_baths;//Total number of 3 Quarter Baths (typically comprised of a sink, toilet & shower stall).
string5         bath_fixtures;//The total number of bathroom fixtures (typically a Full Bath would have 4 fixtures - 1 = sink, 1 = toilet, 1 = bathtub, 1 = shower head).
string3         air_conditioning;//The type of air conditioning method used to cool the building (e.g., Central, Wall Unit, Evaporative). Please see AC table for code descriptions.
string3         basement_finish;//The type of basement found in the building (e.g., Finished, Half, Crawl). Please see BSMTF table for code descriptions.
string3         bldg_code;//The primary building type (e.g., Bowling Alley, Supermarket). Please see BLDG table for code descriptions.
string3         bldg_impv_code;//The primary improvement type (e.g., Grain Silo, Hanger, Marina). Please see IMPRV table for code descriptions.
string3         condition;//This represent the physical condition of the mail improvement (e.g., Good, Fair, Under Construction). Please see COND table for code descriptions.
string3         construction_type;//The primary method of construction (e.g., Steel // Glass, Concrete Block, Log). Please see CNSTR table for code descriptions.
string3         exterior_walls;//The type and//or finish of the exterior walls (e.g., Vinyl Siding, Brick Veneer, Frame // Stone). Please see EXTNW table for code descriptions.
string1         fireplace_ind;//This field is populated with a Y if a fireplace is located within the building.
string3         fireplace_number;//This represent the number of fireplace openings located within the building
string3         fireplace_type;//The type of fireplace (e.g., 2 Story // 3 Openings, 2 Story Brick). Please see FIREP table for code descriptions.
string3         foundation;//The type of foundation (e.g., Continuous Footing, Pier, Mud Sill). Please see FOUND table for code descriptions.
string3         floor;//The type of floor construction (e.g., Concrete, Plywood). Please see FLTYP table for code descriptions.
string3         frame;//The type of roof framing used (e.g., Bar Joist, Reinforced Concrete, Flexicore). Please see RFFRM table for code descriptions.
string3         garage;//Type of garage or carport present (e.g., Attached Finished, Enclosed Carport, Basement Garage). Please see GRGCD table for code descriptions.
string3         heating;//Type or method of heating (e.g., Hot Water, Heat Pump, Baseboard, Radiant). Please see HEAT table for code descriptions.
string1         mobile_home_ind;//This field is populated with a Y if a Mobile Home is present on the parcel.
string5         parking_spaces;//This represent the total number of Parking Spaces or Car Capacity associated with the Garage or Parking type.
string3         parking_type;//Type of parking found on the parcel. This is typically commercial or communal (e.g., Condos) in nature. Please see PARKG table for code descriptions.
string1         pool;//This field is populated with a Y if a Pool is present on the parcel
string3         pool_code;//Type of pool, construction or pool amenities (e.g., Kidney, Gunite, Vinyl, Jacuzzi, Heated). Please see POOL table for code descriptions.
string3         quality;//Type of construction quality of building (e.g., excellent, economical). Please see QUAL table for code descriptions.
string3         roof_cover;//Type of roof covering (e.g., Clay Tile, Aluminum, Shake). Please see RFCOV table for code descriptions.
string3         roof_type;//Type of roof shape (e.g., Gambrel, Gable, Flat, Mansard). Please see RFSHP table for code descriptions.
string3         stories_code;//Type // number of stories (e.g., Split Foyer, Tri Level, 2 Story). Please see STORY table for code descriptions.
string3         stories_number;//Number of stories associated with the building (e.g., 2, 1.5).
string5         style;//Type of building style (e.g., Colonial, Cape Code, Bungalow). Please see STYLE table for code descriptions.
string5         units_number;//Number of Residential, Apartment or Business Units.
string3         electric_energy;//Type of electricity or energy use within the building (e.g., Average Wiring, Underground Wired, Private Source). Please see ELEC table for code descriptions.
string3         fuel;//Type of fuel used for heating of water and building (e.g., Solar, Gas, Oil). Please see FUEL table for code descriptions.
string3         sewer;//Type of sewer system on the parcel (e.g., Public, Septic, Commercial). Please see SEWER table for code descriptions.
string3         water;//Type of water service on the parcel (e.g., Public, Well, Cistern). Please see WATER table for code descriptions.
string250       legal1;//First 250 bytes of the total 750 byte legal description.
string250       legal2;//Second 250 bytes of the total 750 byte legal description.
string250       legal3;//Third 250 bytes of the total 750 byte legal description.
string60				irissecondarykey;   //Additional APN
string2 				crlf;



END;