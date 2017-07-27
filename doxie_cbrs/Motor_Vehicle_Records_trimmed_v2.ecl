import doxie,doxie_crs;
export motor_vehicle_records_trimmed_v2(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

shared mv_recs := doxie_cbrs.motor_vehicle_records_v2(bdids).report_view(Max_MotorVehicles_val)(Include_Bus_DPPA AND Include_MotorVehiclesV2_val);

export records := mv_recs;
export records_count := count(mv_recs);
export records_count_nolimit := doxie_cbrs.Motor_Vehicle_records_v2(bdids).report_count(true);

END;
