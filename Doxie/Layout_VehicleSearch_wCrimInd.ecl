IMPORT doxie;

EXPORT Layout_VehicleSearch_wCrimInd := 
RECORD
	doxie.Layout_VehicleSearch;
	BOOLEAN own_1_hasCriminalConviction := FALSE;
	BOOLEAN own_1_isSexualOffender := FALSE;
	BOOLEAN own_2_hasCriminalConviction := FALSE;
	BOOLEAN own_2_isSexualOffender := FALSE;
	BOOLEAN reg_1_hasCriminalConviction := FALSE;
	BOOLEAN reg_1_isSexualOffender := FALSE;
	BOOLEAN reg_2_hasCriminalConviction := FALSE;
	BOOLEAN reg_2_isSexualOffender := FALSE;
END;