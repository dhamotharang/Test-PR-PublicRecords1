EXPORT fn_Copy_Vehicle_Files() := FUNCTION

	Copy_Veh_Main := Copy_Vehicle_Main_Boca_to_Alpha();

	Copy_Veh_Party := Copy_Vehicle_Party_Boca_to_Alpha();

	Copy_VINA := Copy_VINA_Boca_to_Alpha();

	Copy_Veh_Files := SEQUENTIAL(Copy_Veh_Main, Copy_Veh_Party, Copy_VINA);
	 
	RETURN Copy_Veh_Files;
END;