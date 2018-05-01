
// The following layout contains fieldnames as transmitted by Cortera in their processed 
// Retrotest csv file, save for minor changes to make it ECL-compatible. Actual field
// names from the Retrotest csv file are in comments.
EXPORT layout_Retrotest_raw := RECORD
  STRING seq;	// ID1  (this is the Seq field)
  STRING acctno;	// ID2  (this is the acctno field)
  STRING _LINK_ID;	// LINKID
  STRING Retro_Date;	// Retro_Date
  STRING Status;	// Status
  STRING Confidence_Match_Score;	// Confidence Match Score
  STRING LINK_ID;	// LINK ID (synonym of LINKID)
  STRING Company_Name;	// Company Name
  STRING Alternate_Business_Name;	// Alternate Business Name
  STRING Address;	// Address
  STRING City;	// City
  STRING State;	// State
  STRING Zip;	// Zip
  STRING Country;	// Country
  STRING Position_Type;	// Position Type
  STRING Latitude;	// Latitude
  STRING Longitude;	// Longitude
  STRING URL;	// URL
  STRING LinkID;	// LinkID (duplicate field!)
  STRING Ultimate_LinkID;	// Ultimate LinkID
  STRING Cortera_Score;	// Cortera Score
  STRING CPR;	// CPR
  STRING CPR_Segment;	// CPR Segment
  STRING DBT;	// DBT
  STRING Average_Balance;	// Average Balance
  STRING Primary_SIC;	// Primary SIC
  STRING Primary_SIC_Description;	// Primary SIC Description
  STRING Primary_NAICS;	// Primary NAICS
  STRING Primary_NAICS_Description;	// Primary NAICS Description
  STRING Cortera_Industry;	// Cortera Industry
  STRING Cortera_Industry_Description;	// Cortera Industry Description
  STRING Calculation_Date;	// Calculation Date
  STRING Air_Spend;	// Air Spend
  STRING Fuel_Spend;	// Fuel Spend
  STRING Leasing_Spend;	// Leasing Spend
  STRING Less_Than_Truckload_Shipping_Spend;	// Less Than Truckload Shipping Spend
  STRING Rail_Spend;	// Rail Spend
  STRING Truckload_Shipping_Spend;	// Truckload Shipping Spend
  STRING Transportation_Services_Spend;	// Transportation Services Spend
  STRING Transportation_Supplies_Spend;	// Transportation Supplies Spend
  STRING Building__Brick_Stone_and_Tile_Spend;	// "Building - Brick, Stone & Tile Spend"
  STRING Building__Doors_and_Glass_Spend;	// Building - Doors & Glass Spend
  STRING Building__Electrical_Spend;	// Building - Electrical Spend
  STRING Building__HVAC_Spend;	// Building - HVAC Spend
  STRING Building__Other_Spend;	// Building - Other Spend
  STRING Building__Plumbing_Spend;	// Building - Plumbing Spend
  STRING Building__Roofing_and_Siding_Spend;	// Building - Roofing & Siding Spend
  STRING Building__Wood_Products_Spend;	// Building - Wood Products Spend
  STRING Chemicals_Spend;	// Chemicals Spend
  STRING Electronics_Spend;	// Electronics Spend
  STRING Metals_Spend;	// Metals Spend
  STRING Other_Materials_Spend;	// Other Materials Spend
  STRING Packaging_Spend;	// Packaging Spend
  STRING Pipes_Valves_and_Fittings_Spend;	// "Pipes, Valves & Fittings Spend"
  STRING Plastics_Spend;	// Plastics Spend
  STRING Textiles_Spend;	// Textiles Spend
  STRING Business_Services_Spend;	// Business Services Spend
  STRING Construction_Equipment_Spend;	// Construction Equipment Spend
  STRING Hardware_Spend;	// Hardware Spend
  STRING Industrial_Equipment_Spend;	// Industrial Equipment Spend
  STRING Industrial_Supplies_Spend;	// Industrial Supplies Spend
  STRING Information_Technology_Spend;	// Information Technology Spend
  STRING Medical_and_Lab_Supplies_Spend;	// Medical & Lab Supplies Spend
  STRING Office_Supplies_Spend;	// Office Supplies Spend
  STRING Publishing_and_Printing_Spend;	// Publishing & Printing Spend
  STRING Service_Industry_Supplies_Spend;	// Service Industry Supplies Spend
  STRING Apparel_and_Outdoors_Spend;	// Apparel & Outdoors Spend
  STRING Beverages_Spend;	// Beverages Spend
  STRING Construction_Spend;	// Construction Spend
  STRING Consulting_Spend;	// Consulting Spend
  STRING Financial_Services_Spend;	// Financial Services Spend
  STRING Food_Products_Spend;	// Food Products Spend
  STRING Insurance_Spend;	// Insurance Spend
  STRING Legal_Services_Spend;	// Legal Services Spend
  STRING Oil_and_Gas_Spend;	// Oil & Gas Spend
  STRING Utilities_Spend;	// Utilities Spend
  STRING Other_Spend;	// Other Spend
  STRING Advertising_Spend;	// Advertising Spend
  STRING Top5Spend;	// Top5Spend
  STRING Air_Growth;	// Air Growth
  STRING Fuel_Growth;	// Fuel Growth
  STRING Leasing_Growth;	// Leasing Growth
  STRING Less_Than_Truckload_Shipping_Growth;	// Less Than Truckload Shipping Growth
  STRING Rail_Growth;	// Rail Growth
  STRING Truckload_Shipping_Growth;	// Truckload Shipping Growth
  STRING Transportation_Services_Growth;	// Transportation Services Growth
  STRING Transportation_Supplies_Growth;	// Transportation Supplies Growth
  STRING Building__Brick_Stone_and_Tile_Growth;	// "Building - Brick, Stone & Tile Growth"
  STRING Building__Doors_and_Glass_Growth;	// Building - Doors & Glass Growth
  STRING Building__Electrical_Growth;	// Building - Electrical Growth
  STRING Building__HVAC_Growth;	// Building - HVAC Growth
  STRING Building__Other_Growth;	// Building - Other Growth
  STRING Building__Plumbing_Growth;	// Building - Plumbing Growth
  STRING Building__Roofing_and_Siding_Growth;	// Building - Roofing & Siding Growth
  STRING Building__Wood_Products_Growth;	// Building - Wood Products Growth
  STRING Chemicals_Growth;	// Chemicals Growth
  STRING Electronics_Growth;	// Electronics Growth
  STRING Metals_Growth;	// Metals Growth
  STRING Other_Materials_Growth;	// Other Materials Growth
  STRING Packaging_Growth;	// Packaging Growth
  STRING Pipes_Valves_and_Fittings_Growth;	// "Pipes, Valves & Fittings Growth"
  STRING Plastics_Growth;	// Plastics Growth
  STRING Textiles_Growth;	// Textiles Growth
  STRING Business_Services_Growth;	// Business Services Growth
  STRING Construction_Equipment_Growth;	// Construction Equipment Growth
  STRING Hardware_Growth;	// Hardware Growth
  STRING Industrial_Equipment_Growth;	// Industrial Equipment Growth
  STRING Industrial_Supplies_Growth;	// Industrial Supplies Growth
  STRING Information_Technology_Growth;	// Information Technology Growth
  STRING Medical_and_Lab_Supplies_Growth;	// Medical & Lab Supplies Growth
  STRING Office_Supplies_Growth;	// Office Supplies Growth
  STRING Publishing_and_Printing_Growth;	// Publishing & Printing Growth
  STRING Service_Industry_Supplies_Growth;	// Service Industry Supplies Growth
  STRING Apparel_and_Outdoors_Growth;	// Apparel & Outdoors Growth
  STRING Beverages_Growth;	// Beverages Growth
  STRING Construction_Growth;	// Construction Growth
  STRING Consulting_Growth;	// Consulting Growth
  STRING Financial_Services_Growth;	// Financial Services Growth
  STRING Food_Products_Growth;	// Food Products Growth
  STRING Insurance_Growth;	// Insurance Growth
  STRING Legal_Services_Growth;	// Legal Services Growth
  STRING Oil_and_Gas_Growth;	// Oil & Gas Growth
  STRING Utilities_Growth;	// Utilities Growth
  STRING Other_Growth;	// Other Growth
  STRING Advertising_Growth;	// Advertising Growth
  STRING Top5_Growth;	// Top5 Growth
  STRING shipping_y1;	// shipping_y1
  STRING shipping_growth;	// shipping_growth
  STRING materials_y1;	// materials_y1
  STRING materials_growth;	// materials_growth
  STRING operations_y1;	// operations_y1
  STRING operations_growth;	// operations_growth
  STRING total_paid_average_0t12;	// total_paid_average_0t12
  STRING total_paid_monthspastworst_24;	// total_paid_monthspastworst_24
  STRING total_paid_slope_0t12;	// total_paid_slope_0t12
  STRING total_paid_slope_0t6;	// total_paid_slope_0t6
  STRING total_paid_slope_6t12;	// total_paid_slope_6t12
  STRING total_paid_slope_6t18;	// total_paid_slope_6t18
  STRING total_paid_volatility_0t12;	// total_paid_volatility_0t12
  STRING total_paid_volatility_0t6;	// total_paid_volatility_0t6
  STRING total_paid_volatility_12t18;	// total_paid_volatility_12t18
  STRING total_paid_volatility_6t12;	// total_paid_volatility_6t12
  STRING total_spend_monthspastleast_24;	// total_spend_monthspastleast_24
  STRING total_spend_monthspastmost_24;	// total_spend_monthspastmost_24
  STRING total_spend_slope_0t12;	// total_spend_slope_0t12
  STRING total_spend_slope_0t24;	// total_spend_slope_0t24
  STRING total_spend_slope_0t6;	// total_spend_slope_0t6
  STRING total_spend_slope_6t12;	// total_spend_slope_6t12
  STRING total_spend_sum_12;	// total_spend_sum_12
  STRING total_spend_volatility_0t12;	// total_spend_volatility_0t12
  STRING total_spend_volatility_0t6;	// total_spend_volatility_0t6
  STRING total_spend_volatility_12t18;	// total_spend_volatility_12t18
  STRING total_spend_volatility_6t12;	// total_spend_volatility_6t12
  STRING mfgmat_paid_average_12;	// mfgmat_paid_average_12
  STRING mfgmat_paid_monthspastworst_24;	// mfgmat_paid_monthspastworst_24
  STRING mfgmat_paid_slope_0t12;	// mfgmat_paid_slope_0t12
  STRING mfgmat_paid_slope_0t24;	// mfgmat_paid_slope_0t24
  STRING mfgmat_paid_slope_0t6;	// mfgmat_paid_slope_0t6
  STRING mfgmat_paid_volatility_0t12;	// mfgmat_paid_volatility_0t12
  STRING mfgmat_paid_volatility_0t6;	// mfgmat_paid_volatility_0t6
  STRING mfgmat_spend_monthspastleast_24;	// mfgmat_spend_monthspastleast_24
  STRING mfgmat_spend_monthspastmost_24;	// mfgmat_spend_monthspastmost_24
  STRING mfgmat_spend_slope_0t12;	// mfgmat_spend_slope_0t12
  STRING mfgmat_spend_slope_0t24;	// mfgmat_spend_slope_0t24
  STRING mfgmat_spend_slope_0t6;	// mfgmat_spend_slope_0t6
  STRING mfgmat_spend_sum_12;	// mfgmat_spend_sum_12
  STRING mfgmat_spend_volatility_0t6;	// mfgmat_spend_volatility_0t6
  STRING mfgmat_spend_volatility_6t12;	// mfgmat_spend_volatility_6t12
  STRING ops_paid_average_12;	// ops_paid_average_12
  STRING ops_paid_monthspastworst_24;	// ops_paid_monthspastworst_24
  STRING ops_paid_slope_0t12;	// ops_paid_slope_0t12
  STRING ops_paid_slope_0t24;	// ops_paid_slope_0t24
  STRING ops_paid_slope_0t6;	// ops_paid_slope_0t6
  STRING ops_paid_volatility_0t12;	// ops_paid_volatility_0t12
  STRING ops_paid_volatility_0t6;	// ops_paid_volatility_0t6
  STRING ops_spend_monthspastleast_24;	// ops_spend_monthspastleast_24
  STRING ops_spend_monthspastmost_24;	// ops_spend_monthspastmost_24
  STRING ops_spend_slope_0t12;	// ops_spend_slope_0t12
  STRING ops_spend_slope_0t24;	// ops_spend_slope_0t24
  STRING ops_spend_slope_0t6;	// ops_spend_slope_0t6
  STRING ops_spend_sum_12;	// ops_spend_sum_12
  STRING ops_spend_volatility_0t6;	// ops_spend_volatility_0t6
  STRING ops_spend_volatility_6t12;	// ops_spend_volatility_6t12
  STRING fleet_paid_average_12;	// fleet_paid_average_12
  STRING fleet_paid_monthspastworst_24;	// fleet_paid_monthspastworst_24
  STRING fleet_paid_slope_0t12;	// fleet_paid_slope_0t12
  STRING fleet_paid_slope_0t24;	// fleet_paid_slope_0t24
  STRING fleet_paid_slope_0t6;	// fleet_paid_slope_0t6
  STRING fleet_paid_volatility_0t12;	// fleet_paid_volatility_0t12
  STRING fleet_paid_volatility_0t6;	// fleet_paid_volatility_0t6
  STRING fleet_spend_monthspastleast_24;	// fleet_spend_monthspastleast_24
  STRING fleet_spend_monthspastmost_24;	// fleet_spend_monthspastmost_24
  STRING fleet_spend_slope_0t12;	// fleet_spend_slope_0t12
  STRING fleet_spend_slope_0t24;	// fleet_spend_slope_0t24
  STRING fleet_spend_slope_0t6;	// fleet_spend_slope_0t6
  STRING fleet_spend_sum_12;	// fleet_spend_sum_12
  STRING fleet_spend_volatility_0t6;	// fleet_spend_volatility_0t6
  STRING fleet_spend_volatility_6t12;	// fleet_spend_volatility_6t12
  STRING carrier_paid_average_12;	// carrier_paid_average_12
  STRING carrier_paid_monthspastworst_24;	// carrier_paid_monthspastworst_24
  STRING carrier_paid_slope_0t12;	// carrier_paid_slope_0t12
  STRING carrier_paid_slope_0t24;	// carrier_paid_slope_0t24
  STRING carrier_paid_slope_0t6;	// carrier_paid_slope_0t6
  STRING carrier_paid_volatility_0t12;	// carrier_paid_volatility_0t12
  STRING carrier_paid_volatility_0t6;	// carrier_paid_volatility_0t6
  STRING carrier_spend_monthspastleast_24;	// carrier_spend_monthspastleast_24
  STRING carrier_spend_monthspastmost_24;	// carrier_spend_monthspastmost_24
  STRING carrier_spend_slope_0t12;	// carrier_spend_slope_0t12
  STRING carrier_spend_slope_0t24;	// carrier_spend_slope_0t24
  STRING carrier_spend_slope_0t6;	// carrier_spend_slope_0t6
  STRING carrier_spend_sum_12;	// carrier_spend_sum_12
  STRING carrier_spend_volatility_0t6;	// carrier_spend_volatility_0t6
  STRING carrier_spend_volatility_6t12;	// carrier_spend_volatility_6t12
  STRING bldgmats_paid_average_12;	// bldgmats_paid_average_12
  STRING bldgmats_paid_monthspastworst_24;	// bldgmats_paid_monthspastworst_24
  STRING bldgmats_paid_slope_0t12;	// bldgmats_paid_slope_0t12
  STRING bldgmats_paid_slope_0t24;	// bldgmats_paid_slope_0t24
  STRING bldgmats_paid_slope_0t6;	// bldgmats_paid_slope_0t6
  STRING bldgmats_paid_volatility_0t12;	// bldgmats_paid_volatility_0t12
  STRING bldgmats_paid_volatility_0t6;	// bldgmats_paid_volatility_0t6
  STRING bldgmats_spend_monthspastleast_24;	// bldgmats_spend_monthspastleast_24
  STRING bldgmats_spend_monthspastmost_24;	// bldgmats_spend_monthspastmost_24
  STRING bldgmats_spend_slope_0t12;	// bldgmats_spend_slope_0t12
  STRING bldgmats_spend_slope_0t24;	// bldgmats_spend_slope_0t24
  STRING bldgmats_spend_slope_0t6;	// bldgmats_spend_slope_0t6
  STRING bldgmats_spend_sum_12;	// bldgmats_spend_sum_12
  STRING bldgmats_spend_volatility_0t6;	// bldgmats_spend_volatility_0t6
  STRING bldgmats_spend_volatility_6t12;	// bldgmats_spend_volatility_6t12
  STRING top5_paid_average_12;	// top5_paid_average_12
  STRING top5_paid_monthspastworst_24;	// top5_paid_monthspastworst_24
  STRING top5_paid_slope_0t12;	// top5_paid_slope_0t12
  STRING top5_paid_slope_0t24;	// top5_paid_slope_0t24
  STRING top5_paid_slope_0t6;	// top5_paid_slope_0t6
  STRING top5_paid_volatility_0t12;	// top5_paid_volatility_0t12
  STRING top5_paid_volatility_0t6;	// top5_paid_volatility_0t6
  STRING top5_spend_monthspastleast_24;	// top5_spend_monthspastleast_24
  STRING top5_spend_monthspastmost_24;	// top5_spend_monthspastmost_24
  STRING top5_spend_slope_0t12;	// top5_spend_slope_0t12
  STRING top5_spend_slope_0t24;	// top5_spend_slope_0t24
  STRING top5_spend_slope_0t6;	// top5_spend_slope_0t6
  STRING top5_spend_sum_12;	// top5_spend_sum_12
  STRING top5_spend_volatility_0t6;	// top5_spend_volatility_0t6
  STRING top5_spend_volatility_6t12;	// top5_spend_volatility_6t12
  STRING risk_default_calc_date;	// Risk Default Calc Date
  STRING Risk_Default_1_Score;	// Risk Default 1 Score
  STRING Risk_Default_2_Score;	// Risk Default 2 Score
  STRING total_numrel_avg12;	// total_numrel_avg12
  STRING total_numrel_monthpspastmost_24;	// total_numrel_monthpspastmost_24
  STRING total_numrel_monthspastleast_24;	// total_numrel_monthspastleast_24
  STRING total_numrel_slope_0t12;	// total_numrel_slope_0t12
  STRING total_numrel_slope_0t24;	// total_numrel_slope_0t24
  STRING total_numrel_slope_0t6;	// total_numrel_slope_0t6
  STRING total_numrel_slope_6t12;	// total_numrel_slope_6t12
  STRING total_numrel_var_0t12;	// total_numrel_var_0t12
  STRING total_numrel_var_0t24;	// total_numrel_var_0t24
  STRING total_numrel_var_12t24;	// total_numrel_var_12t24
  STRING total_numrel_var_6t18;	// total_numrel_var_6t18
  STRING mfgmat_numrel_avg12;	// mfgmat_numrel_avg12
  STRING mfgmat_numrel_slope_0t6;	// mfgmat_numrel_slope_0t6
  STRING mfgmat_numrel_slope_0t12;	// mfgmat_numrel_slope_0t12
  STRING mfgmat_numrel_slope_6t12;	// mfgmat_numrel_slope_6t12
  STRING mfgmat_numrel_slope_0t24;	// mfgmat_numrel_slope_0t24
  STRING mfgmat_numrel_var_0t12;	// mfgmat_numrel_var_0t12
  STRING mfgmat_numrel_var_12t24;	// mfgmat_numrel_var_12t24
  STRING ops_numrel_avg12;	// ops_numrel_avg12
  STRING ops_numrel_slope_0t6;	// ops_numrel_slope_0t6
  STRING ops_numrel_slope_0t12;	// ops_numrel_slope_0t12
  STRING ops_numrel_slope_6t12;	// ops_numrel_slope_6t12
  STRING ops_numrel_slope_0t24;	// ops_numrel_slope_0t24
  STRING ops_numrel_var_0t12;	// ops_numrel_var_0t12
  STRING ops_numrel_var_12t24;	// ops_numrel_var_12t24
  STRING fleet_numrel_avg12;	// fleet_numrel_avg12
  STRING fleet_numrel_slope_0t6;	// fleet_numrel_slope_0t6
  STRING fleet_numrel_slope_0t12;	// fleet_numrel_slope_0t12
  STRING fleet_numrel_slope_6t12;	// fleet_numrel_slope_6t12
  STRING fleet_numrel_slope_0t24;	// fleet_numrel_slope_0t24
  STRING fleet_numrel_var_0t12;	// fleet_numrel_var_0t12
  STRING fleet_numrel_var_12t24;	// fleet_numrel_var_12t24
  STRING carrier_numrel_avg12;	// carrier_numrel_avg12
  STRING carrier_numrel_slope_0t6;	// carrier_numrel_slope_0t6
  STRING carrier_numrel_slope_0t12;	// carrier_numrel_slope_0t12
  STRING carrier_numrel_slope_6t12;	// carrier_numrel_slope_6t12
  STRING carrier_numrel_slope_0t24;	// carrier_numrel_slope_0t24
  STRING carrier_numrel_var_0t12;	// carrier_numrel_var_0t12
  STRING carrier_numrel_var_12t24;	// carrier_numrel_var_12t24
  STRING bldgmats_numrel_avg12;	// bldgmats_numrel_avg12
  STRING bldgmats_numrel_slope_0t6;	// bldgmats_numrel_slope_0t6
  STRING bldgmats_numrel_slope_0t12;	// bldgmats_numrel_slope_0t12
  STRING bldgmats_numrel_slope_6t12;	// bldgmats_numrel_slope_6t12
  STRING bldgmats_numrel_slope_0t24;	// bldgmats_numrel_slope_0t24
  STRING bldgmats_numrel_var_0t12;	// bldgmats_numrel_var_0t12
  STRING bldgmats_numrel_var_12t24;	// bldgmats_numrel_var_12t24
  STRING total_monthsoutstanding_slope24;	// total_monthsoutstanding_slope24
  STRING total_percprov30_avg_0t12;	// total_percprov30_avg_0t12
  STRING total_percprov30_slope_0t12;	// total_percprov30_slope_0t12
  STRING total_percprov30_slope_0t24;	// total_percprov30_slope_0t24
  STRING total_percprov30_slope_0t6;	// total_percprov30_slope_0t6
  STRING total_percprov30_slope_6t12;	// total_percprov30_slope_6t12
  STRING total_percprov60_avg_0t12;	// total_percprov60_avg_0t12
  STRING total_percprov60_slope_0t12;	// total_percprov60_slope_0t12
  STRING total_percprov60_slope_0t24;	// total_percprov60_slope_0t24
  STRING total_percprov60_slope_0t6;	// total_percprov60_slope_0t6
  STRING total_percprov60_slope_6t12;	// total_percprov60_slope_6t12
  STRING total_percprov90_avg_0t12;	// total_percprov90_avg_0t12
  STRING total_percprov90_lowerlim_0t12;	// total_percprov90_lowerlim_0t12
  STRING total_percprov90_slope_0t24;	// total_percprov90_slope_0t24
  STRING total_percprov90_slope_0t6;	// total_percprov90_slope_0t6
  STRING total_percprov90_slope_6t12;	// total_percprov90_slope_6t12
  STRING total_percprovoutstanding_adjustedslope_0t12;	// total_percprovoutstanding_adjustedslope_0t12
  STRING mfgmat_monthsoutstanding_slope24;	// mfgmat_monthsoutstanding_slope24
  STRING mfgmat_percprov30_slope_0t12;	// mfgmat_percprov30_slope_0t12
  STRING mfgmat_percprov30_slope_6t12;	// mfgmat_percprov30_slope_6t12
  STRING mfgmat_percprov60_slope_0t12;	// mfgmat_percprov60_slope_0t12
  STRING mfgmat_percprov60_slope_6t12;	// mfgmat_percprov60_slope_6t12
  STRING mfgmat_percprov90_slope_0t24;	// mfgmat_percprov90_slope_0t24
  STRING mfgmat_percprov90_slope_0t6;	// mfgmat_percprov90_slope_0t6
  STRING mfgmat_percprov90_slope_6t12;	// mfgmat_percprov90_slope_6t12
  STRING mfgmat_percprovoutstanding_adjustedslope_0t12;	// mfgmat_percprovoutstanding_adjustedslope_0t12
  STRING ops_monthsoutstanding_slope24;	// ops_monthsoutstanding_slope24
  STRING ops_percprov30_slope_0t12;	// ops_percprov30_slope_0t12
  STRING ops_percprov30_slope_6t12;	// ops_percprov30_slope_6t12
  STRING ops_percprov60_slope_0t12;	// ops_percprov60_slope_0t12
  STRING ops_percprov60_slope_6t12;	// ops_percprov60_slope_6t12
  STRING ops_percprov90_slope_0t24;	// ops_percprov90_slope_0t24
  STRING ops_percprov90_slope_0t6;	// ops_percprov90_slope_0t6
  STRING ops_percprov90_slope_6t12;	// ops_percprov90_slope_6t12
  STRING ops_percprovoutstanding_adjustedslope_0t12;	// ops_percprovoutstanding_adjustedslope_0t12
  STRING fleet_monthsoutstanding_slope24;	// fleet_monthsoutstanding_slope24
  STRING fleet_percprov30_slope_0t12;	// fleet_percprov30_slope_0t12
  STRING fleet_percprov30_slope_6t12;	// fleet_percprov30_slope_6t12
  STRING fleet_percprov60_slope_0t12;	// fleet_percprov60_slope_0t12
  STRING fleet_percprov60_slope_6t12;	// fleet_percprov60_slope_6t12
  STRING fleet_percprov90_slope_0t24;	// fleet_percprov90_slope_0t24
  STRING fleet_percprov90_slope_0t6;	// fleet_percprov90_slope_0t6
  STRING fleet_percprov90_slope_6t12;	// fleet_percprov90_slope_6t12
  STRING fleet_percprovoutstanding_adjustedslope_0t12;	// fleet_percprovoutstanding_adjustedslope_0t12
  STRING carrier_monthsoutstanding_slope24;	// carrier_monthsoutstanding_slope24
  STRING carrier_percprov30_slope_0t12;	// carrier_percprov30_slope_0t12
  STRING carrier_percprov30_slope_6t12;	// carrier_percprov30_slope_6t12
  STRING carrier_percprov60_slope_0t12;	// carrier_percprov60_slope_0t12
  STRING carrier_percprov60_slope_6t12;	// carrier_percprov60_slope_6t12
  STRING carrier_percprov90_slope_0t24;	// carrier_percprov90_slope_0t24
  STRING carrier_percprov90_slope_0t6;	// carrier_percprov90_slope_0t6
  STRING carrier_percprov90_slope_6t12;	// carrier_percprov90_slope_6t12
  STRING carrier_percprovoutstanding_adjustedslope_0t12;	// carrier_percprovoutstanding_adjustedslope_0t12
  STRING bldgmats_monthsoutstanding_slope24;	// bldgmats_monthsoutstanding_slope24
  STRING bldgmats_percprov30_slope_0t12;	// bldgmats_percprov30_slope_0t12
  STRING bldgmats_percprov30_slope_6t12;	// bldgmats_percprov30_slope_6t12
  STRING bldgmats_percprov60_slope_0t12;	// bldgmats_percprov60_slope_0t12
  STRING bldgmats_percprov60_slope_6t12;	// bldgmats_percprov60_slope_6t12
  STRING bldgmats_percprov90_slope_0t24;	// bldgmats_percprov90_slope_0t24
  STRING bldgmats_percprov90_slope_0t6;	// bldgmats_percprov90_slope_0t6
  STRING bldgmats_percprov90_slope_6t12;	// bldgmats_percprov90_slope_6t12
  STRING bldgmats_percprovoutstanding_adjustedslope_0t12;	// bldgmats_percprovoutstanding_adjustedslope_0t12
  STRING top5_monthsoutstanding_slope24;	// top5_monthsoutstanding_slope24
  STRING top5_percprov30_slope_0t12;	// top5_percprov30_slope_0t12
  STRING top5_percprov30_slope_6t12;	// top5_percprov30_slope_6t12
  STRING top5_percprov60_slope_0t12;	// top5_percprov60_slope_0t12
  STRING top5_percprov60_slope_6t12;	// top5_percprov60_slope_6t12
  STRING top5_percprov90_slope_0t24;	// top5_percprov90_slope_0t24
  STRING top5_percprov90_slope_0t6;	// top5_percprov90_slope_0t6
  STRING top5_percprov90_slope_6t12;	// top5_percprov90_slope_6t12
  STRING top5_percprovoutstanding_adjustedslope_0t12;	// top5_percprovoutstanding_adjustedslope_0t12

END;
