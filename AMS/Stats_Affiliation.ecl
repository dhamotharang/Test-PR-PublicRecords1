ds := DATASET('~thor_data400::base::ams::20120109::affiliation',
				      AMS.Layouts.Base.Affiliation, THOR) +
		  DATASET('~thor_data400::base::ams::20120203::affiliation',
				      AMS.Layouts.Base.Affiliation, THOR) +
		  DATASET('~thor_data400::base::ams::20120302::affiliation',
				      AMS.Layouts.Base.Affiliation, THOR);

OUTPUT(ds);

Field_PopulationStats := RECORD
  CountGroup 								:= COUNT(GROUP);
	xAMS_PARENT_ID 						:= AVE(GROUP, IF(ds.AMS_PARENT_ID <> '', 100, 0));
	xAMS_CHILD_ID 						:= AVE(GROUP, IF(ds.AMS_CHILD_ID <> '', 100, 0));
	xRecord_type 							:= AVE(GROUP, IF(ds.record_type <> '', 100, 0));
	xDt_first_seen 						:= AVE(GROUP, IF(ds.dt_first_seen <> 0, 100, 0));
	xDt_last_seen							:= AVE(GROUP, IF(ds.dt_last_seen	<> 0, 100, 0));
	xDt_vendor_first_reported	:= AVE(GROUP, IF(ds.dt_vendor_first_reported	<> 0, 100, 0));
	xDt_vendor_last_reported	:= AVE(GROUP, IF(ds.dt_vendor_last_reported <> 0, 100, 0));
	xSRC_CD										:= AVE(GROUP, IF(ds.rawfields.SRC_CD	<> '', 100, 0));
	xAFFIL_STATUS							:= AVE(GROUP, IF(ds.rawfields.AFFIL_STATUS	<> '', 100, 0));
	xAFFIL_TYPE								:= AVE(GROUP, IF(ds.rawfields.AFFIL_TYPE	<> '', 100, 0));
	xAFFIL_UPDATE_DATE				:= AVE(GROUP, IF(ds.rawfields.AFFIL_UPDATE_DATE <> '', 100, 0));
	xAFFIL_START_DATE					:= AVE(GROUP, IF(ds.rawfields.AFFIL_START_DATE	<> '', 100, 0));
	xAFFIL_END_DATE						:= AVE(GROUP, IF(ds.rawfields.AFFIL_END_DATE	<> '', 100, 0));
	xSRC_CD_DESC							:= AVE(GROUP, IF(ds.SRC_CD_DESC <> '', 100, 0));
END;

fieldPOP := TABLE(ds, Field_PopulationStats, ALL);

OUTPUT(fieldPOP);

Field_Max_Length_Stats := RECORD
	CountGroup    											:= COUNT(GROUP);
	UNSIGNED4	xAMS_PARENT_ID	   				:= MAX(GROUP, LENGTH(ds.AMS_PARENT_ID));
	UNSIGNED4	xAMS_CHILD_ID	 						:= MAX(GROUP, LENGTH(ds.AMS_CHILD_ID));
	UNSIGNED4	xRecord_type	     				:= MAX(GROUP, LENGTH(ds.record_type));
	UNSIGNED4	xDt_first_seen	     			:= MAX(GROUP, LENGTH((STRING)ds.dt_first_seen));
	UNSIGNED4	xDt_last_seen	       			:= MAX(GROUP, LENGTH((STRING)ds.dt_last_seen));
	UNSIGNED4	xDt_vendor_first_reported	:= MAX(GROUP, LENGTH((STRING)ds.dt_vendor_first_reported));
	UNSIGNED4	xDt_vendor_last_reported	:= MAX(GROUP, LENGTH((STRING)ds.dt_vendor_last_reported));
	UNSIGNED4	xSRC_CD	         					:= MAX(GROUP, LENGTH(ds.rawfields.SRC_CD));
	UNSIGNED4	xAFFIL_STATUS 						:= MAX(GROUP, LENGTH(ds.rawfields.AFFIL_STATUS));
	UNSIGNED4	xAFFIL_TYPE	 							:= MAX(GROUP, LENGTH(ds.rawfields.AFFIL_TYPE));
	UNSIGNED4	xAFFIL_UPDATE_DATE	   		:= MAX(GROUP, LENGTH(ds.rawfields.AFFIL_UPDATE_DATE));
	UNSIGNED4	xAFFIL_START_DATE	  			:= MAX(GROUP, LENGTH(ds.rawfields.AFFIL_START_DATE));
	UNSIGNED4	xAFFIL_END_DATE	 					:= MAX(GROUP, LENGTH(ds.rawfields.AFFIL_END_DATE));
	UNSIGNED4	xSRC_CD_DESC	 						:= MAX(GROUP, LENGTH(ds.SRC_CD_DESC));
END;

OUTPUT(TABLE(ds, Field_Max_Length_Stats, FEW));