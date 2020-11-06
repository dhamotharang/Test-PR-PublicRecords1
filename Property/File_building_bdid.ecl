IMPORT $, dx_Property;

File_Building := property.File_Foreclosure_Base_v2;

l_key	:= RECORD
	STRING70	FID; //used for key index
	dx_Property.Layout_Fares_Foreclosure;
END;

tBuilding	:= DEDUP(SORT(DISTRIBUTE(PROJECT(File_Building,
									TRANSFORM(l_key,
														SELF.FID							:= LEFT.foreclosure_id;
														SELF.name1_bdid       := LEFT.name1_bdid,
														SELF.name1_bdid_score := LEFT.name1_bdid_score,
														SELF.name2_bdid       := LEFT.name2_bdid,
														SELF.name2_bdid_score := LEFT.name2_bdid_score,
														SELF.name3_bdid       := LEFT.name3_bdid,
														SELF.name3_bdid_score := LEFT.name3_bdid_score,
														SELF.name4_bdid       := LEFT.name4_bdid,
														SELF.name4_bdid_score := LEFT.name4_bdid_score,
														//Fields added for delta update project - DF-28049
														SELF.record_sid				:= LEFT.record_sid;
														SELF.global_sid				:= LEFT.global_sid;
														SELF.dt_effective_first	:= 0;
														SELF.dt_effective_last	:= 0;
														SELF.delta_ind					:= 0;
														SELF := LEFT)),HASH(foreclosure_id)),RECORD,LOCAL),RECORD,LOCAL);

EXPORT File_building_bdid := tBuilding(TRIM(foreclosure_id, LEFT, RIGHT) NOT IN Suppress_FID);//: persist('~thor_data400::persist::file_foreclosure_building');