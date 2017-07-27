import doxie;
unsigned2 pt := 10 : stored('PenaltThreshold');
boolean IncludeBlankDOD := false : stored('IncludeBlankDOD');

doxie.MAC_Header_Field_Declare()

//***** GET IDS
sids := deathv2_services.Search_ids(not noDeepDive, false);
ids := dedup(project(sids,
					           deathv2_services.layouts.death_id), 
						 all);

//***** GENERATE REPORT
rpen := deathv2_services.raw.get_report.from_death_ids(ids,ssn_mask_value); 

//***** MARK DEEP DIVE
rdd := join(rpen, dedup(sort(sids,state_death_id,if(isDeepDive, 1, 0)), state_death_id), 
			left.state_death_id = right.state_death_id,
			transform(deathv2_services.layouts.report_external , self.isDeepDive := right.isDeepDive, self := left),
			left outer);

//***** FILTER BY PENALT AND SORT
rsrt := sort(rdd(penalt <= pt and (includeBlankDOD or (integer)dod8 > 0)), if(isDeepDive, 1, 0), penalt, -dod8, record);
// doxie.MAC_Marshall_Results(rsrt,rmar);

// export Search_records := rmar;

EXPORT Search_records := rsrt;