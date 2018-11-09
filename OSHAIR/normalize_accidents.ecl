#option('skipFileFormatCrcCheck', 1);
import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_accidents(string filedate, string process_date) := FUNCTION

inputAccidentInjury		:= oshair.files().input.AccidentInjury.using;
accident_cleaned 			:= oshair.layout_oshair_accident_clean;

accident_cleaned trfAccidentMapped(Layouts_input.AccidentInjury l) := TRANSFORM
   self.dt_first_seen 						:=  (unsigned4)process_date;
	 self.dt_last_seen  						:=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	:=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	:=  (unsigned4)process_date;
   self.Activity_Number    				:=	(integer)l.rel_insp_nr;
	 self.Related_Inspection_Number	:=	(integer)l.rel_insp_nr;
   self.Age                				:= 	(Unsigned1)l.Age;
	 self.degree_of_injury					:=	l.Degree_of_Inj;
	 self.nature_of_injury					:=	intformat((integer)l.nature_of_inj,2,1);
	 self.source_of_injury					:=	intformat((integer)l.src_of_injury,2,1);
	 self.environmental_factor			:=	intformat((integer)l.evn_factor,2,1);
	 self.human_factor							:=	intformat((integer)l.hum_factor,2,1);
	 self.part_of_body							:=	intformat((integer)l.part_of_body,2,1);
	 self.event_type								:=	intformat((integer)l.Event_Type,2,1);	 
	 self.hazardous_substance				:=	l.hazsub;
	 self.occupation_code						:=	l.occ_code;
   self.Deg_of_Injury_Desc 				:= 	OSHAIR.Lookup_OSHAIR_Mini.Degree_of_Injury_lookup(self.degree_of_injury);
   self.Nat_of_Inj_Desc   				:= 	OSHAIR.Lookup_OSHAIR.nature_injury_lookup(self.nature_of_injury);
   self.Part_of_Body_Desc  				:= 	OSHAIR.Lookup_OSHAIR.body_part_lookup(self.part_of_body);
   self.Src_of_Inj_Desc    				:= 	OSHAIR.Lookup_OSHAIR.src_injury_lookup(self.source_of_injury);
   self.Event_Desc         				:= 	OSHAIR.Lookup_OSHAIR.event_type_lookup(self.event_type);
   self.Env_Factor_Desc    				:= 	OSHAIR.Lookup_OSHAIR.env_factor_lookup(self.environmental_factor);
   self.Human_Factor_Desc  				:= 	OSHAIR.Lookup_OSHAIR.human_factor_lookup(self.human_factor);
   self.Task_Assigned_Desc 				:= 	OSHAIR.Lookup_OSHAIR_Mini.Task_Assigned_lookup(l.Task_Assigned);
   self.Hazardous_Sub_Desc				:= 	OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(l.HazSub);
   self.Occupation_Desc    				:= 	OSHAIR.Lookup_OSHAIR.occupation_lookup(l.Occ_Code);
   self 													:= 	l;
	 self														:=	[];
end;

ds_Accidents 	:= 	project(inputAccidentInjury,trfAccidentMapped(LEFT));

dsAll					:=	distribute((OSHAIR.Files().base.accident.qa + ds_Accidents),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_accident_clean RollupAccident(OSHAIR.layout_OSHAIR_accident_clean l, OSHAIR.layout_OSHAIR_accident_clean r) := transform
  self.dt_first_seen 						:= ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 						:= MAX(l.dt_last_seen	 ,r.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self 													:= l;
end;

AccidentRollup := rollup(sort(dsAll,activity_number,record,except dt_first_seen,dt_last_seen, 
														  dt_vendor_first_reported, dt_vendor_last_reported,local)
												 , RollupAccident(left, right), record
												 ,except victim.name_score, dt_first_seen, dt_last_seen, 
																 dt_vendor_first_reported, dt_vendor_last_reported
												 , local);

return output(AccidentRollup,,'~thor_data400::base::oshair::' + filedate + '::accident',compressed,overwrite);

end;