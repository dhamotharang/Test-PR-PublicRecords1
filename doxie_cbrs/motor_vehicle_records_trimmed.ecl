IMPORT doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT motor_vehicle_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

mv_recs := doxie_cbrs.motor_vehicle_records_dayton(bdids)(Include_Bus_DPPA AND Include_MotorVehicles_val);
SHARED mv_slim := PROJECT(mv_recs, TRANSFORM(doxie_cbrs.layouts.mvr_record, SELF := LEFT));

EXPORT records := CHOOSEN(mv_slim, Max_MotorVehicles_val);
EXPORT records_count := COUNT(mv_slim);

END;
