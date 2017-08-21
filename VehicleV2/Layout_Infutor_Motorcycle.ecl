
IMPORT	AID,Address;

EXPORT Layout_Infutor_Motorcycle	:= MODULE

	//---------------------------------------------------------
	//-----------INFUTOR INPUT FORMAT LAYOUT
	//---------------------------------------------------------
	
	EXPORT	Raw_Main	:= RECORD	
		VehicleV2.Layout_Infutor_VIN.Raw_Main;
	END;
	
	//------------------------------------------------------------
	//ADD NAME TYPE INDICATORS
	//------------------------------------------------------------
	EXPORT	Prepped	:= RECORD
		VehicleV2.Layout_Infutor_VIN.Prepped;
	END;
	
	//------------------------------------------------------------
	//OUTPUT CLEAN FILE LAYOUTS
	//------------------------------------------------------------
	EXPORT Clean_Main	:= RECORD
		VehicleV2.Layout_Infutor_VIN.Clean_Main;
	END;

	EXPORT	Infutor_Motorcycle_as_VehicleV2	:= RECORD
		VehicleV2.Layout_Infutor_VIN.Infutor_Vin_as_VehicleV2;
	END;
	
END;