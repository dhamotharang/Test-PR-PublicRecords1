ds := DATASET('~thor_data400::base::ams::20120109::idnumber',
				      AMS.Layouts.Base.IDNumber, THOR) +
		  DATASET('~thor_data400::base::ams::20120203::idnumber',
				      AMS.Layouts.Base.IDNumber, THOR) +
		  DATASET('~thor_data400::base::ams::20120302::idnumber',
				      AMS.Layouts.Base.IDNumber, THOR);

OUTPUT(ds);

Field_PopulationStats := RECORD
  CountGroup 								:= COUNT(GROUP);
	xAMS_ID 									:= AVE(GROUP, IF(ds.AMS_ID <> '', 100, 0));
	xRecord_type 							:= AVE(GROUP, IF(ds.record_type <> '', 100, 0));
	xDt_first_seen 						:= AVE(GROUP, IF(ds.dt_first_seen <> 0, 100, 0));
	xDt_last_seen							:= AVE(GROUP, IF(ds.dt_last_seen <> 0, 100, 0));
	xDt_vendor_first_reported	:= AVE(GROUP, IF(ds.dt_vendor_first_reported <> 0, 100, 0));
	xDt_vendor_last_reported	:= AVE(GROUP, IF(ds.dt_vendor_last_reported <> 0, 100, 0));
	xINDY_ID									:= AVE(GROUP, IF(ds.rawfields.INDY_ID	<> '', 100, 0));
	xSRC_CD										:= AVE(GROUP, IF(ds.rawfields.SRC_CD <> '', 100, 0));
	xINDY_ID_END_DATE					:= AVE(GROUP, IF(ds.rawfields.INDY_ID_END_DATE <> '', 100, 0));
	xEND_DATE_REASON					:= AVE(GROUP, IF(ds.rawfields.END_DATE_REASON <> '', 100, 0));
	xSRC_CD_DESC							:= AVE(GROUP, IF(ds.SRC_CD_DESC <> '', 100, 0));
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
	UNSIGNED4	xINDY_ID 									:= MAX(GROUP, LENGTH(ds.rawfields.INDY_ID));
	UNSIGNED4	xSRC_CD	         					:= MAX(GROUP, LENGTH(ds.rawfields.SRC_CD));
	UNSIGNED4	xINDY_ID_END_DATE	 				:= MAX(GROUP, LENGTH(ds.rawfields.INDY_ID_END_DATE));
	UNSIGNED4	xEND_DATE_REASON	   			:= MAX(GROUP, LENGTH(ds.rawfields.END_DATE_REASON));
	UNSIGNED4	xSRC_CD_DESC	 						:= MAX(GROUP, LENGTH(ds.SRC_CD_DESC));
END;

OUTPUT(TABLE(ds, Field_Max_Length_Stats, FEW));