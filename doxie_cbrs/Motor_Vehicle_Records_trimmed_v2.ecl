IMPORT doxie_cbrs;
EXPORT motor_vehicle_records_trimmed_v2(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

SHARED mv_recs := doxie_cbrs.motor_vehicle_records_v2(bdids).report_view(Max_MotorVehicles_val)(Include_Bus_DPPA AND Include_MotorVehiclesV2_val);

EXPORT records := PROJECT(mv_recs, TRANSFORM(doxie_cbrs.layouts.mvr_record_v2, SELF := LEFT)); 
EXPORT records_count := COUNT(mv_recs);
EXPORT records_count_nolimit := doxie_cbrs.Motor_Vehicle_records_v2(bdids).report_count(TRUE);

END;
