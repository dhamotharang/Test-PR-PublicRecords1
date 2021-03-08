/* KEL expects that any necessary data cleaning happens prior to the KEL implementation.  
   The purpose of this MODULE is to gather all of that cleaning functionality into one location for ease of maintanence.
   KEL can then USE these cleaned results for Attribute computation. 
   For organizational purposes, we are maintaining this list in alphabettical order. */
IMPORT
 dx_BestRecords,
 MDR,
 ProfileBooster,
 ProfileBooster.ProfileBoosterV2_KEL,
 ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions,
 Risk_Indicators,
 VehicleV2,
 Watchdog,
 STD,
 _control;
 
EXPORT FileCleaning := MODULE
/* ******************************************************************************
                            SHARED CLEANING LOGIC
 ****************************************************************************** */

	EXPORT Risk_Indicators__Key_ADL_Risk_Table_v4_Filtered_Expanded := RECORD
		// RECORDOF(Risk_Indicators.Key_ADL_Risk_Table_v4_Filtered) - combo - eq - en - tn;
		RECORDOF(Risk_Indicators.Key_ADL_Risk_Table_v4) - combo - eq - en - tn;
		RECORDOF(Risk_Indicators.Key_ADL_Risk_Table_v4.combo);
		STRING8 Src;
	END;

	EXPORT Risk_Indicators__Key_SSN_Table_v4_Filtered_Expanded := RECORD
		RECORDOF(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA) - combo - eq - en - tn;
		RECORDOF(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA.combo);
		STRING8 Src;
	END;
	
	EXPORT Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => MDR.sourceTools.src_Accurint_DOC,
				'2' => MDR.sourceTools.src_Accurint_Crim_Court,
				'5' => MDR.sourceTools.src_Accurint_Arrest_Log,
					'');
	
	EXPORT LN_PropertyV2_Src(STRING ln_fare_id) := MDR.sourceTools.fProperty(ln_fare_id);
	
	EXPORT LN_PropertyV2_REGEXFIND(STRING Land_Attribute) := REGEXFIND('^[0-9]*.?[0-9]*', Land_Attribute, 0);

	EXPORT Watercraft__date_first_seen(STRING sequence_key) := MAP(
		LENGTH(TRIM(sequence_key)) = 8 => sequence_key,
		LENGTH(TRIM(sequence_key)) = 6 => sequence_key + '31',
																'');
	
/* ******************************************************************************
                            NON FCRA FILE CLEANING
 ****************************************************************************** */
	EXPORT NonFCRA := MODULE
		SHARED isFCRA := FALSE;
		
		SHARED DunnFile := DATASET('~foreign::' + _control.IPAddress.prod_thor_dali + '::thor_data400::base::dunndata_consumer', ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.DunnDataLayout, thor);
    
		EXPORT DunnData_Consumer__Key_Did := PROJECT(DunnFile, TRANSFORM(RECORDOF(LEFT),
      SELF.dt_first_seen := MAP(
                              LEFT.dt_first_seen=0 AND LEFT.dt_vendor_first_reported<>0 => std.Date.AdjustCalendar(LEFT.dt_vendor_first_reported,0,-1*LEFT.lmos),
                              LEFT.dt_first_seen<>0                                     => LEFT.dt_first_seen,                              
                              0);
      SELF.dt_last_seen := MAP(
                              LEFT.dt_last_seen=0 AND LEFT.dt_vendor_last_reported<>0 => LEFT.dt_vendor_last_reported,
                              LEFT.dt_last_seen<>0                                    => LEFT.dt_last_seen,                              
                              0);
			SELF := LEFT))(did<>0);
      
		EXPORT VehicleV2__Key_Vehicle_Main_Key := PROJECT(VehicleV2.Key_Vehicle_Main_Key, TRANSFORM({RECORDOF(LEFT), STRING10 cleaned_brand_date_1, STRING10 cleaned_brand_date_2, STRING10 cleaned_brand_date_3, STRING10 cleaned_brand_date_4, STRING10 cleaned_brand_date_5},
			SELF.cleaned_brand_date_1 := (STRING)ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(LEFT.brand_date_1)[1].result;
			SELF.cleaned_brand_date_2 := (STRING)ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(LEFT.brand_date_2)[1].result;
			SELF.cleaned_brand_date_3 := (STRING)ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(LEFT.brand_date_3)[1].result;
			SELF.cleaned_brand_date_4 := (STRING)ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(LEFT.brand_date_4)[1].result;
			SELF.cleaned_brand_date_5 := (STRING)ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Clean_Date(LEFT.brand_date_5)[1].result;
			SELF := LEFT));
			
		EXPORT Watchdog__Key_Watchdog := PROJECT(dx_BestRecords.Key_Watchdog(), TRANSFORM({recordof(left), STRING2 src},
			SELF.src := MDR.SourceTools.src_Best_Person,
			SELF := LEFT));

	END;
END;