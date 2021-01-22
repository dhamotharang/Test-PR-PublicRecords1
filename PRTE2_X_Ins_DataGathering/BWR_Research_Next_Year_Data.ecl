   /* ***********************************************************************************************************
   PRTE2_X_Ins_DataGathering\BWR_Research_Next_Year_Data
   ***********************************************************************************************************
   ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR *****
   ***********************************************************************************************************

   Oct 2020 - odd, had to comment out the filter only orig_vehicle_type_code='P' because 99% of 2021 orig_types had "U"
            checking on the 5 year search if it was only 2021 that was affected or not
            yes - trying 2021 VIN years with this worked fine:
                  vina_model_year IN yearsToPull AND vina_vin <>''
                  AND (vina_veh_type IN ['P','M'] 
                        OR (vina_veh_type = 'T' AND orig_vehicle_type_code IN ['P','U'] ) )
                  AND (vina_make_desc <> '' OR vina_series_desc <> '') );
             ALSO! - previous years we checked orig_year - that's broke for 2021, using vina_model_year                     
*********************************************************************************************************** */
IMPORT VehicleV2,STD;

Trimit(STRING S) := TRIM(S,left,right);

reportOn := VehicleV2.file_VehicleV2_main(vina_model_year='2021');

COUNT(reportOn);
CHOOSEN(reportOn,100);

report0 := RECORD
	// recTypeSrc	 := Trimit(reportOn.vina_veh_type+'|'+reportOn.vina_make_desc)+'|'+Trimit(reportOn.vina_model_desc)+'|'+Trimit(reportOn.vina_series_desc);
	// recTypeSrc	 := Trimit(reportOn.vina_veh_type)+'|'+Trimit(reportOn.vina_make_desc) /*+'|'+Trimit(reportOn.vina_model_desc)+'|'+Trimit(reportOn.vina_series_desc)*/;
	recTypeSrc	 := Trimit(reportOn.vina_veh_type)+'|'+Trimit(reportOn.orig_vehicle_type_code)+'|'+Trimit(reportOn.vina_model_desc)+'|'+Trimit(reportOn.vina_series_desc);
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(reportOn,report0,vina_veh_type,vina_make_desc,vina_model_desc,vina_series_desc);
OUTPUT(SORT(RepTable0,-GroupCount),ALL);
OUTPUT(SORT(RepTable0,recTypeSrc),ALL);