import dx_FirstData, PRTE2_DLV2, FirstData; 

EXPORT Layouts := module

	export base					:= FirstData.Layout.base;
	export key_did 			:= dx_FirstData.layouts.i_did;
	// export key_license 	:= dx_FirstData.layouts.i_driverslicense;
	
	export key_license := record
		STRING8   PROCESS_DATE;
		STRING8   FILEDATE;
		STRING1   RECORD_TYPE;
		STRING1   ACTION_CODE;
		STRING9   CONS_ID;
		STRING2   DL_STATE;
		STRING50  DL_ID;
		UNSIGNED6 LEX_ID;
		STRING8  	DATE_FIRST_SEEN;
		STRING8  	DATE_LAST_SEEN;
		STRING1   DISPUTE_STATUS;
	end;	
	
	
		

end;	

