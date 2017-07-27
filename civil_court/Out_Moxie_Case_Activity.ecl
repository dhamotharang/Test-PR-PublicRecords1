/*civil_court.Layout_Moxie_Case_Activity tActivityInToOut(civil_court.Layout_In_Case_Activity pInput)
 :=
  transform
	self			:= pInput;
  end
 ;

dInAsOut		:= project(civil_court.File_In_Case_Activity,tActivityInToOut(left));

dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,case_key,court_code,court,case_number));

dInAsOutSorted	:= sort(dInAsOutDist,vendor,state_origin,source_file,case_key,court_code,
                       court,case_number,event_date,event_type_code,event_type_description_1,
					   event_type_description_2,process_date,local);
					   
dInAsOutDeduped := dedup(dInAsOutDist,vendor,state_origin,source_file,case_key,court_code,
                       court,case_number,event_date,event_type_code,event_type_description_1,
					   event_type_description_2,local);
					   
export Out_Moxie_Case_Activity := output(dInAsOutDeduped,,civil_court.Name_Moxie_Case_Activity_Dev,overwrite);*/

import civil_court,lib_stringlib;

//layouts have changed with Date first reported and Date last reported instead of process date

civil_court.Layout_Moxie_Case_Activity tActivityInToOut(civil_court.Layout_In_Case_Activity pInput)
 := transform
 self.dt_first_reported := pInput.process_date;
 self.dt_last_reported := pInput.process_date;
 self:= pInput;
 end;
 
dInAsOut := project(civil_court.File_In_Case_Activity, tActivityInToOut(left));

//Rollup to set Date first reported and Date last reported

//Populate the all unique value found in the fields

civil_court.Layout_Moxie_Case_Activity tRollup(civil_court.Layout_Moxie_Case_Activity L, civil_court.Layout_Moxie_Case_Activity R)

 := transform
  self.dt_first_reported := if(L.dt_first_reported  < R.dt_first_reported , L.dt_first_reported , R.dt_first_reported );
  self.dt_last_reported  := if(L.dt_first_reported  < R.dt_first_reported , R.dt_first_reported , L.dt_first_reported );
  self := L;
  
end;

dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,case_key,court_code,court,case_number));


dInAsOutSorted	:= sort(dInAsOutDist,vendor,state_origin,source_file,case_key,court_code,court,case_number,event_date,event_type_code,
                       event_type_description_1,event_type_description_2,dt_first_reported,local);
					   
/*dInAsOutRollup  := rollup(dInAsOutSorted,left.vendor = right.vendor and left.state_origin = right.state_origin and
                         left.source_file = right.source_file and left.case_key = right.case_key and left.court_code = 
						 right.court_code and left.court = right.court and left.case_number = right.case_number and
						 left.event_date = right.event_date and left.event_type_code = right.event_type_code and left.event_type_description_1 
						 = right.event_type_description_1 and left.event_type_description_2 = right.event_type_description_2,
						 tRollup(left, right),local);*/
						 
dInAsOutRollup  := rollup(dInAsOutSorted,tRollup(left, right),RECORD,EXCEPT process_date,dt_first_reported,dt_last_reported,LOCAL);
					   
export Out_Moxie_Case_Activity := output(dInAsOutRollup,,civil_court.Name_Moxie_Case_Activity_Dev,overwrite);