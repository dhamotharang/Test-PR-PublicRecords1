EXPORT Constants_NtlAccidentsInquiry := MODULE
	//Headers added
	EXPORT HdrClient := ['ACCT_NBR'];
	EXPORT HdrVehicleIncident := ['VEHICLE_INCIDENT_ID'];
	EXPORT HdrVehicles := ['VEHICLE_ID'];
	EXPORT HdrIntOrder := ['ORDER_ID'];
	EXPORT HdrVehicleParty := ['PARTY_ID'];
	EXPORT HdrOrderVersion := ['ORDER_ID'];
	EXPORT HdrResult := ['RESULT_ID'];
	EXPORT HdrVehicleInscr := ['INS_CARRIER_ID'];
	EXPORT NtlAccidentWeightScoreHdrLnk := 30;
	EXPORT NtlAccidentDistanceHdrLnk := 3;
	//Promonitor parameters 
	EXPORT Promonitor_StateAbbr_List :=  ['AK','AL','AR','CO','CT','DC','DE','FL','GA','HI','ID','IL','IN','KS','MA','MD','ME',
																																							'MI','MO','NC','ND','NE','NJ','NM','NY','OH','OK','OR','PA','SC','SD','TN','UT','VA',
																																							'VT','WI','WV','WY'];
	EXPORT Promonitor_DaysBetween := 31;	
	
	EXPORT Promonitor_DidScore := 75;
	
	EXPORT VINA_Vehicle_Status := 'V';
END;