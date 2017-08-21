import header, watchdog, census_data, ut, ln_property, infutor;

/*
Sequence:
Get_AddrID
Choose_SSN1_or_SSN2
Join_to_Address_Indicators
Get_Census
Get_HHID
Append_Mktg_Best_To_Infutor
Get_Additional_Members -> based on lname,addrid join to HHID
Append_Mktg_Best_To_Additional_Members
Remove_Dead_People
Rank_People
Map_To_Common
Dwelling_units
Hyphenated_Names
Rent_Own_Score
Derived_HHIDs
*/

export BWR_Build := sort(first_data.Derived_HHIDs,zip,str_name,house_nbr,unit_nbr,last_name,first_name);
output(BWR_Build,,'~thor_dell400_2::out::'+first_data.version+'::fds',overwrite);