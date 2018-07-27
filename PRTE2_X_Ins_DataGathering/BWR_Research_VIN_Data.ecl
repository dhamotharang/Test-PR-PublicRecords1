IMPORT VehicleV2,STD;

ReportOnThis := FALSE;		// Else Next year
SuperOnly := FALSE;			// Else include BWR, Porsche and Mercedes which have lower end models
Trimit(STRING S) := TRIM(S,left,right);

All_This := VehicleV2.file_VehicleV2_main(vina_model_year='2018');
All_Next := VehicleV2.file_VehicleV2_main(vina_model_year='2019');
// CHOOSEN(All_Next,100);

HighValue := ['BMW','PORSCHE','MERCEDES','MASERATI','BENTLEY','FERRARI','MCLAREN','LAMBORGHINI','ROLLS-ROYCE','ASTON MARTIN'];
SuperHighValue := ['MASERATI','BENTLEY','FERRARI','MCLAREN','LAMBORGHINI','ROLLS-ROYCE','ASTON MARTIN'];
HighValueMakes := IF(SuperOnly, SuperHighValue, HighValue);

//NOTE: discovered that VIN make descriptions are NOT uppercased!!!!
VThis := All_This (StringLib.StringToUpperCase(vina_make_desc) IN HighValueMakes);
VNext := All_Next (StringLib.StringToUpperCase(vina_make_desc) IN HighValueMakes);

reportOn := IF(ReportOnThis, VThis, VNext);
COUNT(reportOn);
CHOOSEN(reportOn,100);

report0 := RECORD
	recTypeSrc	 := Trimit(reportOn.vina_make_desc)+'|'+Trimit(reportOn.vina_model_desc)+'|'+Trimit(reportOn.vina_series_desc);
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(reportOn,report0,vina_make_desc,vina_model_desc,vina_series_desc);
OUTPUT(SORT(RepTable0,-GroupCount));