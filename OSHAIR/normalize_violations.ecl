import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_violations(string filedate, string process_date):= FUNCTION

Violation 				 := oshair.files().input.Violation.using;
violations_cleaned := OSHAIR.layout_OSHAIR_violations_clean;

violations_cleaned normalize_violation(Violation L) := TRANSFORM
   self.dt_first_seen 						  :=  (unsigned4)process_date;
	 self.dt_last_seen  						  :=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	  :=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	  :=  (unsigned4)process_date;
   self.Activity_Number            	:=	(integer)l.Activity_Nr;
	 self.citation_number							:=	l.citation_id[1..2];
	 self.item_number									:=	l.citation_id[3..5];
	 self.item_group									:=	l.citation_id[6..7];
	 self.violation_type							:=	l.viol_type;
	 self.Fed_state_standard					:=	l.standard;
	 self.Abatement_Date							:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.abate_date,'-','');
	 self.Number_Instances						:=	(integer)l.nr_instances;
	 self.Related_Event_Code					:=	l.rec;
	 self.Number_Exposed							:=	(integer)l.nr_exposed;
	 self.Abatement_Complete					:=	l.abate_complete;
	 self.Earliest_Contest_Date				:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.contest_date,'-','');
	 self.Final_Order_Date						:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.final_order_date,'-','');
	 self.FTA_Inspection_Number				:=	(integer)l.fta_insp_nr;	
   self.Violation_Desc             	:= 	OSHAIR.Lookup_OSHAIR_Mini.Violation_lookup(l.viol_type);
   self.Related_Event_Desc        	:= 	OSHAIR.Lookup_OSHAIR_Mini.Related_Event_lookup(l.rec);
   self.Abatement_Comp_Desc        	:= 	OSHAIR.Lookup_OSHAIR_Mini.Abatement_Complete_lookup(l.abate_complete);
   // self.Disposition_Event_Desc     	:= 	OSHAIR.Lookup_OSHAIR_Mini.Disposition_Event_lookup(l.Disposition_Event);
   // self.FTA_Disposition_Event_Desc	:= 	OSHAIR.Lookup_OSHAIR_Mini.FTA_Disposition_Event_lookup(l.FTA_Disposition_Event);
	 self.issuance_date								:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.issuance_date,'-','');
	 self.current_penalty							:=	(integer)l.current_penalty;
	 self.initial_penalty							:=	(integer)l.initial_penalty;
	 self.fta_penalty									:=	(integer)l.fta_penalty;
	 self.fta_issuance_Date						:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.fta_issuance_date,'-','');
	 self.fta_final_order_date				:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.fta_final_order_date,'-','');
	 self.fta_contest_date						:=	(integer)lib_stringlib.stringlib.stringfindreplace(l.fta_contest_date,'-','');
   self                            	:= 	l;
	 self															:=	[];
end;

ds_Violations 	:= 	project(Violation,normalize_violation(LEFT));
dsAllViolations	:=	distribute((OSHAIR.Files().base.Violations.qa+ ds_Violations),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_violations_clean RollupViolations(OSHAIR.layout_OSHAIR_violations_clean l, OSHAIR.layout_OSHAIR_violations_clean r) := transform
	self.dt_first_seen  					:= ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 						:= MAX(l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self												  := l;
end;

ViolationsRollup	:= rollup(sort(dsAllViolations,record, except dt_first_seen,dt_last_seen, 
														dt_vendor_first_reported, dt_vendor_last_reported, local)
														, RollupViolations(left, right), record
														,except dt_first_seen, dt_last_seen, 
																		dt_vendor_first_reported, dt_vendor_last_reported
														, local);

return output(ViolationsRollup,,'~thor_data400::base::oshair::' + filedate + '::violations',compressed,overwrite);

end;