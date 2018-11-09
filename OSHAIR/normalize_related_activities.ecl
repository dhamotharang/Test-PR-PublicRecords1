import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_related_activities(string filedate, string process_date):= FUNCTION

RelatedActivity 				 := oshair.files().input.RelatedActivity.using;
related_activity_cleaned := OSHAIR.layout_OSHAIR_related_activity_clean;

related_activity_cleaned normalize_related_activity(RelatedActivity L) := TRANSFORM
   self.dt_first_seen 						:=  (unsigned4)process_date;
	 self.dt_last_seen  						:=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	:=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	:=  (unsigned4)process_date;
   self.Activity_Number    				:=	(integer)l.activity_nr;
   self.rel_Activity_Number 			:=	(integer)l.activity_nr;	
	 self.rel_activity_type					:=	l.rel_type;
	 self.rel_activity_safety_flag	:=	l.rel_safety;
	 self.rel_activity_health_flag	:=	l.rel_health;
   self.Rel_Activity_Desc  				:= 	OSHAIR.Lookup_OSHAIR_Mini.Related_Activity_lookup(l.Rel_Type);
   self 													:= 	l;
	 self														:=	[];
end;

ds_Related_Activities := 	project(RelatedActivity,normalize_related_activity(LEFT));
dsAllRelAct						:=	distribute((OSHAIR.Files().base.Related_Activity.qa + ds_Related_Activities),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_related_activity_clean RollupRelAct(OSHAIR.layout_OSHAIR_related_activity_clean l, OSHAIR.layout_OSHAIR_related_activity_clean r) := transform
	self.dt_first_seen  					:= ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 						:= MAX(l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self 												  := l;
end;

RelActRollup	:= rollup(sort(dsAllRelAct,record, except dt_first_seen,dt_last_seen, 
														 dt_vendor_first_reported, dt_vendor_last_reported, local)
												, RollupRelAct(left, right), record
												,except dt_first_seen, dt_last_seen, 
																dt_vendor_first_reported, dt_vendor_last_reported
												, local);

return output(RelActRollup,,'~thor_data400::base::oshair::' + filedate + '::related_activity',compressed,overwrite);

end;