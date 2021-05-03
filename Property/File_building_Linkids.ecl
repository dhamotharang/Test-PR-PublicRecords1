IMPORT $, BIPV2, dx_Property;

File_Building := property.File_Foreclosure_Base_v2;

l_key	:= RECORD
	STRING70	FID; //used for key index
	dx_Property.Layout_Fares_Foreclosure;
	BIPV2.IDlayouts.l_xlink_ids name1;
	BIPV2.IDlayouts.l_xlink_ids name2;
	BIPV2.IDlayouts.l_xlink_ids name3;
	BIPV2.IDlayouts.l_xlink_ids name4;
END;

df := project(File_Building,
							TRANSFORM(l_key,
							SELF.FID							:= LEFT.foreclosure_id;
							//Fields added for delta update project - DF-28049
							SELF.record_sid				:= LEFT.record_sid;
							SELF.global_sid				:= LEFT.global_sid;
							SELF.dt_effective_first	:= 0;
							SELF.dt_effective_last	:= 0;
							SELF.delta_ind					:= 0;
							SELF := LEFT));	

EXPORT File_building_Linkids := df(TRIM(foreclosure_id, LEFT, RIGHT) NOT IN Suppress_FID);