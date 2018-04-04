import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_hazardous_substances(string filedate, string process_date) := FUNCTION

Violation 									:= oshair.files().input.Violation.using;
hazardous_substance_cleaned := OSHAIR.layout_OSHAIR_hazardous_substance_clean;

hazardous_substance_cleaned normalize_hazardous_substance(Violation L) := TRANSFORM
   self.dt_first_seen 						:=  (unsigned4)process_date;
	 self.dt_last_seen  						:=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	:=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	:=  (unsigned4)process_date;   
   self.Activity_Number      			:= 	(integer)l.activity_nr;
	 self.citation_number						:=	l.citation_id[1..2];
	 self.item_number								:=	l.citation_id[3..5];
	 self.item_group								:=	l.citation_id[6..7];	
	 self.hazardous_substance_1			:=	l.hazsub1;
	 self.hazardous_substance_2			:=	l.hazsub2;
	 self.hazardous_substance_3			:=	l.hazsub3;
	 self.hazardous_substance_4			:=	l.hazsub4;
	 self.hazardous_substance_5			:=	l.hazsub5;	 
   self.Hazardous_Sub_Desc_1 			:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.hazsub1);
   self.Hazardous_Sub_Desc_2 			:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.hazsub2);
   self.Hazardous_Sub_Desc_3 			:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.hazsub3);
   self.Hazardous_Sub_Desc_4 			:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.hazsub4);
   self.Hazardous_Sub_Desc_5 			:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.hazsub5);
   self 													:= 	l;
	 self														:=	[];
end;

ds_Hazardous_Substances 	:= 	project(Violation,normalize_hazardous_substance(LEFT));
dsAllHazardous_Substances	:=	distribute((OSHAIR.Files().base.hazardous.qa + ds_Hazardous_Substances),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_hazardous_substance_clean RollupHazSub(OSHAIR.layout_OSHAIR_hazardous_substance_clean l, OSHAIR.layout_OSHAIR_hazardous_substance_clean r) := transform
  self.dt_first_seen  					:= ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 					  := MAX(l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self 													:= l;
end;

HazSubRollup := rollup(sort(dsAllHazardous_Substances, record, except dt_first_seen,dt_last_seen, 
														dt_vendor_first_reported, dt_vendor_last_reported, local)
											, RollupHazSub(left, right), record
											,except dt_first_seen, dt_last_seen, 
															dt_vendor_first_reported, dt_vendor_last_reported
											, local);

return output(HazSubRollup,,'~thor_data400::base::oshair::' + filedate + '::hazardous_substance',compressed,overwrite);

end;