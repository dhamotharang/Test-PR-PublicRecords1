export Lookup_OSHAIR_Mini := module

/*
Contains lookups for the following:

Violation child record:
	Violation_lookup
	Related_Event_lookup
	Abatement_Complete_lookup
	Disposition_Event_lookup
	FTA_Disposition_Event_lookup
Accident child record:
	Degree_of_Injury_lookup
	Task_Assigned_lookup
Related Activity child record:
	Related_Activity_lookup
Inspection record:
	Previous_Activity_lookup
	Compliance_Office_Title_lookup
	Owner_Type_lookup
	Inspection_Type_lookup
	Inspection_Scope_lookup
	Why_No_Inspection_lookup
	Due_Date_lookup
	Optional_Description_lookup
*/
export Violation_lookup (string violation_code) := case(violation_code
											,'S' => 'SERIOUS'
											,'O' => 'OTHER'
											,'R' => 'REPEAT'
											,'U' => 'UNCLASSIFIED'
											,'W' => 'WILLFUL'
											,'');
											
export Related_Event_lookup (string related_event_code) := case(related_event_code
											,'A' => 'ACCIDENT (FAT/CAT)'
											,'C' => 'COMPLAINT'
											,'I' => 'IMMINENT DANGER'
											,'R' => 'RELATED EVENT CODE'
											,'V' => 'VARIANCE'
                                 ,                              '');
export Abatement_Complete_lookup (string abatement_complete_code) := case(abatement_complete_code
											,'X' => 'ABATEMENT, PPE, REPORT COMPLETED'
											,'E' => 'ABATEMENT, PPE, PLAN, REPORT NOT COMPLETED, EMPLOYER OUT OF BUSINESS'
											,'W' => 'ABATEMENT, PPE, PLAN, REPORT NOT COMPLETED, WORKSITE CHANGED'
											,'S' => 'ABATEMENT, PPE, PLAN, REPORT NOT COMPLETED, SOLICITOR ADVISED'
											,'A' => 'ABATEMENT, PPE, PLAN, REPORT NOT COMPLETED, AD DISCRETION'
											,'');

export Disposition_Event_lookup (string disposition_event_code) := case(disposition_event_code
											,'W' => 'EMPLOYER WITHDREW CONTEST'
											,'D' => 'GOVERNMENT DISMISSED CONTEST'
											,'L' => 'STATE-SETTLEMENT AT ADMIN. LEVEL'
											,'Y' => 'STATE-DECISION AT ADMIN. LEVEL'
											,'F' => 'FORMAL SETTLEMENT AGREEMENT'
											,'J' => 'ADMINISTRATIVE LAW JUDGE DECISION'
											,'R' => 'REVIEW COMMISSION DECISION'
											,'1' => 'STATE-LOWER'
											,'2' => 'APPEALS COURT DECISION'
											,'3' => 'SUPREME COURT DECISION'
									 ,                             '');
export FTA_Disposition_Event_lookup (string fta_disposition_event_code) := case(fta_disposition_event_code
											,'W' => 'EMPLOYER WITHDREW CONTEST'
											,'D' => 'GOVERNMENT DISMISSED CONTEST'
											,'L' => 'STATE-SETTLEMENT AT ADMIN. LEVEL'
											,'Y' => 'STATE-DECISION AT ADMIN. LEVEL'
											,'F' => 'FORMAL SETTLEMENT AGREEMENT'
											,'J' => 'ADMINISTRATIVE LAW JUDGE DECISION'
											,'R' => 'REVIEW COMMISSION DECISION'
											,'1' => 'STATE-LOWER'
											,'2' => 'APPEALS COURT DECISION'
											,'3' => 'SUPREME COURT DECISION'
											,'');
										 
export Degree_of_Injury_lookup (string degree_of_injury_code) := case(degree_of_injury_code
											,'1' => 'FATALITY'
											,'2' => 'HOSPITALIZED INJURY'
											,'3' => 'NONHOSPITALIZED INJURY'
											,'');

export Task_Assigned_lookup (string task_assigned_code) := case(task_assigned_code
											,'1' => 'REGULARLY ASSIGNED TASK'
											,'2' => 'TASK OTHER THAN REGULARLY ASSIGNED TASK'
											,'');

export Optional_Description_lookup (string optional_description_code) := case(optional_description_code
											,'N' => 'NATIONAL'
											,'R' => 'REGIONAL'
											,'A' => 'AREA'
											,'S' => 'STATE'
											,'');
											
export Related_Activity_lookup (string related_activity_code) := case(related_activity_code
											,'A' => 'ACCIDENT (FAT/CAT)'
											,'C' => 'COMPLAINT'
											,'I' => 'INSPECTION'
											,'R' => 'REFERRAL'
											,'');
											
export Previous_Activity_lookup (string previous_activity_code) := case(previous_activity_code
											,'A' => 'ACCIDENT (FATALITY/CATASTROPHE)'
											,'C' => 'COMPLAINT'
											,'I' => 'INSPECTION'
											,'R' => 'REFERRAL'
											,'NO ACTIVITY');

export Compliance_Office_Title_lookup (string compliance_officer_code) := case(compliance_officer_code
											,'C' => 'SAFETY OFFICER'
	                                        ,'I' => 'HEALTH OFFICER'
	                                        ,'L' => 'SAFETY TRAINEE'
	                                        ,'M' => 'HEALTH TRAINEE'
	                                        ,'S' => 'SUPERVISOR'
	                                        ,'A' => 'AREA DIRECTOR'
	                                        ,'V' => 'DISCRIM. INVEST\'R'
	                                        ,'W' => 'REGIONAL MGT.'
	                                        ,'X' => 'REGIONAL FSO'
	                                        ,'Y' => 'REGIONAL TECH. SUPP.'
											,'');

export Owner_Type_lookup (string owner_type_code) := case(owner_type_code
											,'A' => 'PRIVATE'
											,'B' => 'LOCAL GOVERNMENT'
											,'C' => 'STATE GOVERNMENT'
											,'D' => 'FEDERAL GOVERNMENT'
											,'');
											
export Inspection_Type_lookup (string inspection_type_code) := case(inspection_type_code
											,'A' => 'FATALITY/CATASTROPHE'
											,'B' => 'COMPLAINT'
											,'C' => 'REFERRAL'
											,'D' => 'MONITORING'
											,'E' => 'VARIANCE'
											,'F' => 'FOLLOWUP'
											,'G' => 'RELATED'
											,'H' => 'PLANNED (PROGRAMMED)'
											,'I' => 'RELATED (PROGRAMMED)'
											,'J' => 'OTHER'
											,'K' => 'OTHER (PROGRAMMED)'
											,'L' => 'NON-INSPECTION (PROGRAMMED)'
											,'');

export Inspection_Scope_lookup (string inspection_scope_code) := case(inspection_scope_code
											,'A' => 'COMPREHENSIVE'
											,'B' => 'PARTIAL'
											,'C' => 'RECORDS ONLY'
											,'D' => 'NO INSPECTION'
											,'');

export Why_No_Inspection_lookup (string why_no_inspection_code) := case(why_no_inspection_code
											,'A' => 'ESTABLISHMENT NOT FOUND'
											,'B' => 'EMPLOYER OUT OF BUSINESS'
											,'C' => 'PROCESS TO BE INSPECTED NOT ACTIVE'
											,'D' => 'TEN OR FEWER EMPLOYEES'
											,'E' => 'DENIED ENTRY'
											,'F' => 'SIC NOT ON PLANNING GUIDE'
											,'G' => 'WORKS ITE EXEMPT THROUGH VOLUNTARY PROGRAM'
											,'H' => 'NON-EXEMPT CONSULTATION IN PROGRESS'
											,'I' => 'OTHER REASON'
											,'');

export Due_Date_lookup (string due_date_code) := case(due_date_code
											,'N' => 'DATE SET TO 9/1/85 BY NATIONAL OFFICE'
											,'D' => 'DATE SET BY THE FIELD SUBMITTED ON OSHA 167 I'
											,'R' => 'WHEN R EVENT CD, PEN DUE DATE = FINAL ORDER DATE + 60 DAYS'
											,'J' => 'WHEN J EVENT CD, PEN DUE DATE = FINAL ORDER DATE + 90 DAYS'
											,'F' => 'FINAL ORDER DATE ENTERED ON OSHA 166 I' 
											,'I' => 'CITATION ISSUANCE DATE + 20 DAYS'
											,'A' => 'INFORMAL SETTLEMENT DATE + 20 DAYS'
											,'NO DUE DATE');

/* End of the module */
end;
