ds := DATASET('~thor_data400::base::ams::20120109::degree',
				      AMS.Layouts.Base.Degree, THOR) +
		  DATASET('~thor_data400::base::ams::20120203::degree',
				      AMS.Layouts.Base.Degree, THOR) +
		  DATASET('~thor_data400::base::ams::20120302::degree',
				      AMS.Layouts.Base.Degree, THOR);

OUTPUT(ds);

Field_PopulationStats := RECORD
  CountGroup 								:= COUNT(GROUP);
	xAMS_ID 									:= AVE(GROUP, IF(ds.AMS_ID <> '', 100, 0));
	xRecord_type 							:= AVE(GROUP, IF(ds.record_type <> '', 100, 0));
	xDt_first_seen 						:= AVE(GROUP, IF(ds.dt_first_seen <> 0, 100, 0));
	xDt_last_seen							:= AVE(GROUP, IF(ds.dt_last_seen <> 0, 100, 0));
	xDt_vendor_first_reported	:= AVE(GROUP, IF(ds.dt_vendor_first_reported <> 0, 100, 0));
	xDt_vendor_last_reported	:= AVE(GROUP, IF(ds.dt_vendor_last_reported <> 0, 100, 0));
	xDEGREE										:= AVE(GROUP, IF(ds.rawfields.DEGREE <> '', 100, 0));
	xBEST_DEGREE							:= AVE(GROUP, IF(ds.rawfields.BEST_DEGREE	<> '', 100, 0));
	xDEGREE_DESC							:= AVE(GROUP, IF(ds.DEGREE_DESC <> '', 100, 0));
END;

fieldPOP := TABLE(ds, Field_PopulationStats, ALL);

OUTPUT(fieldPOP);

Field_Max_Length_Stats := RECORD
	CountGroup    											:= COUNT(GROUP);
	UNSIGNED4	xAMS_ID	   								:= MAX(GROUP, LENGTH(ds.AMS_ID));
	UNSIGNED4	xRecord_type	     				:= MAX(GROUP, LENGTH(ds.record_type));
	UNSIGNED4	xDt_first_seen	     			:= MAX(GROUP, LENGTH((STRING)ds.dt_first_seen));
	UNSIGNED4	xDt_last_seen	       			:= MAX(GROUP, LENGTH((STRING)ds.dt_last_seen));
	UNSIGNED4	xDt_vendor_first_reported	:= MAX(GROUP, LENGTH((STRING)ds.dt_vendor_first_reported));
	UNSIGNED4	xDt_vendor_last_reported	:= MAX(GROUP, LENGTH((STRING)ds.dt_vendor_last_reported));
	UNSIGNED4	xDEGREE	         					:= MAX(GROUP, LENGTH(ds.rawfields.DEGREE));
	UNSIGNED4	xBEST_DEGREE 							:= MAX(GROUP, LENGTH(ds.rawfields.BEST_DEGREE));
	UNSIGNED4	xDEGREE_DESC	 						:= MAX(GROUP, LENGTH(ds.DEGREE_DESC));
END;

OUTPUT(TABLE(ds, Field_Max_Length_Stats, FEW));