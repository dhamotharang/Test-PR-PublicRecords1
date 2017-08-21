ds := DATASET('~thor_data400::base::ams::20120109::statelicense',
				      AMS.Layouts.Base.StateLicense, THOR) +
		  DATASET('~thor_data400::base::ams::20120203::statelicense',
				      AMS.Layouts.Base.StateLicense, THOR) +
		  DATASET('~thor_data400::base::ams::20120302::statelicense',
				      AMS.Layouts.Base.StateLicense, THOR);

OUTPUT(ds);

Field_PopulationStats := RECORD
  CountGroup 								:= COUNT(GROUP);
	xAMS_ID 									:= AVE(GROUP, IF(ds.AMS_ID <> '', 100, 0));
	xRecord_type 							:= AVE(GROUP, IF(ds.record_type <> '', 100, 0));
	xDt_first_seen 						:= AVE(GROUP, IF(ds.dt_first_seen <> 0, 100, 0));
	xDt_last_seen							:= AVE(GROUP, IF(ds.dt_last_seen <> 0, 100, 0));
	xDt_vendor_first_reported	:= AVE(GROUP, IF(ds.dt_vendor_first_reported <> 0, 100, 0));
	xDt_vendor_last_reported	:= AVE(GROUP, IF(ds.dt_vendor_last_reported <> 0, 100, 0));
	xINDY_ID									:= AVE(GROUP, IF(ds.rawfields.INDY_ID <> '', 100, 0));
	xSRC_CD										:= AVE(GROUP, IF(ds.rawfields.SRC_CD <> '', 100, 0));
	xST_LIC_NUM								:= AVE(GROUP, IF(ds.rawfields.ST_LIC_NUM <> '', 100, 0));
	xST_LIC_BRD_CD						:= AVE(GROUP, IF(ds.rawfields.ST_LIC_BRD_CD <> '', 100, 0));
	xST_LIC_STATE							:= AVE(GROUP, IF(ds.rawfields.ST_LIC_STATE <> '', 100, 0));
	xST_LIC_DEGREE						:= AVE(GROUP, IF(ds.rawfields.ST_LIC_DEGREE <> '', 100, 0));
	xST_LIC_TYPE							:= AVE(GROUP, IF(ds.rawfields.ST_LIC_TYPE <> '', 100, 0));
	xST_LIC_STATUS						:= AVE(GROUP, IF(ds.rawfields.ST_LIC_STATUS <> '', 100, 0));
	xST_LIC_EXP_DATE					:= AVE(GROUP, IF(ds.rawfields.ST_LIC_EXP_DATE <> '', 100, 0));
	xST_LIC_ISSUE_DATE				:= AVE(GROUP, IF(ds.rawfields.ST_LIC_ISSUE_DATE <> '', 100, 0));
	xST_LIC_BRD_DATE					:= AVE(GROUP, IF(ds.rawfields.ST_LIC_BRD_DATE <> '', 100, 0));
	xELIGIBILITY_CD						:= AVE(GROUP, IF(ds.rawfields.ELIGIBILITY_CD <> '', 100, 0));
	xSRC_CD_DESC							:= AVE(GROUP, IF(ds.SRC_CD_DESC <> '', 100, 0));
	xST_LIC_STATE_DESC				:= AVE(GROUP, IF(ds.ST_LIC_STATE_DESC <> '', 100, 0));
	xST_LIC_DEGREE_DESC				:= AVE(GROUP, IF(ds.ST_LIC_DEGREE_DESC <> '', 100, 0));
	xST_LIC_TYPE_DESC					:= AVE(GROUP, IF(ds.ST_LIC_TYPE_DESC <> '', 100, 0));
	xST_LIC_STATUS_DESC				:= AVE(GROUP, IF(ds.ST_LIC_STATUS_DESC <> '', 100, 0));
	xELIGIBILITY_CD_DESC			:= AVE(GROUP, IF(ds.ELIGIBILITY_CD_DESC <> '', 100, 0));
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
	UNSIGNED4	xINDY_ID	         				:= MAX(GROUP, LENGTH(ds.rawfields.INDY_ID));
	UNSIGNED4	xSRC_CD 									:= MAX(GROUP, LENGTH(ds.rawfields.SRC_CD));
	UNSIGNED4	xST_LIC_NUM	 							:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_NUM));
	UNSIGNED4	xST_LIC_BRD_CD	         	:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_BRD_CD));
	UNSIGNED4	xST_LIC_STATE 						:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_STATE));
	UNSIGNED4	xST_LIC_DEGREE	 					:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_DEGREE));
	UNSIGNED4	xST_LIC_TYPE	         		:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_TYPE));
	UNSIGNED4	xST_LIC_STATUS 						:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_STATUS));
	UNSIGNED4	xST_LIC_EXP_DATE	 				:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_EXP_DATE));
	UNSIGNED4	xST_LIC_ISSUE_DATE	      := MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_ISSUE_DATE));
	UNSIGNED4	xST_LIC_BRD_DATE 					:= MAX(GROUP, LENGTH(ds.rawfields.ST_LIC_BRD_DATE));
	UNSIGNED4	xELIGIBILITY_CD	 					:= MAX(GROUP, LENGTH(ds.rawfields.ELIGIBILITY_CD));
	UNSIGNED4	xSRC_CD_DESC	 						:= MAX(GROUP, LENGTH(ds.SRC_CD_DESC));
	UNSIGNED4	xST_LIC_STATE_DESC	 			:= MAX(GROUP, LENGTH(ds.ST_LIC_STATE_DESC));
	UNSIGNED4	xST_LIC_DEGREE_DESC	 			:= MAX(GROUP, LENGTH(ds.ST_LIC_DEGREE_DESC));
	UNSIGNED4	xST_LIC_TYPE_DESC	 				:= MAX(GROUP, LENGTH(ds.ST_LIC_TYPE_DESC));
	UNSIGNED4	xST_LIC_STATUS_DESC	 			:= MAX(GROUP, LENGTH(ds.ST_LIC_STATUS_DESC));
	UNSIGNED4	xELIGIBILITY_CD_DESC	 		:= MAX(GROUP, LENGTH(ds.ELIGIBILITY_CD_DESC));
END;

OUTPUT(TABLE(ds, Field_Max_Length_Stats, FEW));