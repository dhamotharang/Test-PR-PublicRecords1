export _DeveloperNotes := output('Review Notes');
/* 
*********************************************************************************************
// FCRA Consumer Data Field Depreciation Project requires certain fields be blanked out
// Currently key_aircraft_info & key_engine_info are copied from production data 
// If thie approach changes the following fields will have to blanked out for the FCRA keys
// aircraft_info_key_fields = [aircraft_category_code,aircraft_cruising_speed,aircraft_weight,amateur_certification_code
//																												lf,number_of_engines,number_of_seats,type_engine
//             														 ]
//
// engine_info_key_fields = [fuel_consumed,lf]
*************************************************************************************************
*/

