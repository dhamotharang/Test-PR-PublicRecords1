// Checks a string to see if it is in one of the seven sets that
// Set_CityNames had to be split into
export BOOLEAN IsCityName(STRING city) := 
	city IN Set_CityNames_1 OR
	city IN Set_CityNames_2 OR
	city IN Set_CityNames_3 OR
	city IN Set_CityNames_4 OR
	city IN Set_CityNames_5 OR
	city IN Set_CityNames_6 OR
	city IN Set_CityNames_7;